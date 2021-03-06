// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

static void consputc(int);

static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

//add_new_variable----------------------------------
static int bufferFlag=1;
static int showAtonce=1;

//if bufferFlag==1, enable console cache
void setBufferFlag(int flag){
  bufferFlag=flag;
}

//if showAtonce==1, inputs displayed on the screen
void setShowAtOnce(int flag){
  showAtonce=flag;
}

//---------------------------------------------------

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

//add function------------------------------------------------
//void showc(int pos, int c ){
//  crt[pos] = c & 0xffff;
//}
int getCursorPos(){
  int pos;
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  return pos;
}

void setCursorPos(int x, int y) {
  
  int pos = x*80 + y;
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] |= 0x0700;
}

static void
cgaputc(int c)
{
  int pos;
  pos = getCursorPos();

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } 
  else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  //expand the screen from 24 to 25 lines
  //modified----------
  if((pos/80) >= 25){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*24*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
  }

  setCursorPos(pos/80, pos%80);
  crt[pos] = ' ' | 0x0700;
}

//--------------------------------------------------------

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
struct {
  struct spinlock lock;
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;

#define C(x)  ((x)-'@')  // Control-x

//modified function-----------------------------------------------
void
consoleintr(int (*getc)(void))
{
  int c;
  //add_new_variable
  int doprocdump = 0;

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      //procdump();
      doprocdump=1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        if(showAtonce)  //add_judge
          consputc(c);
        //add_judge
        if(!bufferFlag || c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&input.lock);
  //add_judge
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

//-----------------------------------------------------------------------

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  ioapicenable(IRQ_KBD, 0);
}

//add_new_function------------------------------------------------------------

uint colors[17] = {0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xa,0xb,0xc,0xd,0xe,0xf};
  
// 清空屏幕，设置光标为(0, 0)。
void clearScreen(){
  int pos = 0;
  memset(crt, 0, sizeof(crt[0])*(25*80));

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;  //显示光标
}

// 在屏幕(x, y)处写入c，光标向后移动。
void writeAt(int x,int y,char c){
    setCursorPos(x, y);
    cgaputc(c);
}

void saveScreen(ushort *screen, int pos){ 
  int size = pos*sizeof(crt[0]);
  memmove(screen,crt,size);
}

void recorverScreen(ushort *screen, int pos){
  int size = pos*sizeof(crt[0]);
  clearScreen();
  memmove(crt, screen, size);
  setCursorPos(pos/80,pos%80);
}

// 将字符串text的len个字节（或是小于len的整个字符串）复制到显示器的相对位置pos后面，一直到屏幕末尾，不翻行。
// 要求： 0 <= pos < 25*80
void copyFromTextToScreen(char* text,int pos,int len,int color){
   char *p = text;
   setCursorPos(pos/80,pos%80);
   int i;
   for(i=0;i<len&&*p!='\0';i++){
    uchar cc = getColor(colors[color], 0x0);
    showC(*p,cc);
    p++;
    pos = getCursorPos();
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
      break;
   }
}

void ToScreen(char* text,int pos,int len,int* color){
   char *p = text;
   setCursorPos(pos/80,pos%80);
   int i;
   for(i=0;i<len&&*p!='\0';i++){
    uchar cc = getColor(colors[color[i]], 0x0);
    showC(*p,cc);
    p++;
    pos = getCursorPos();
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
      break;
   }
}

uchar getColor(uchar tcolor, uchar bcolor){
  return (bcolor<<4) | tcolor;
}

void showC(int c, uchar color){
  int pos;
  pos = getCursorPos();
  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } 
  else
    crt[pos++] = (c | (color<<8));  // black on white
  if((pos/80) >= 25){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*24*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
  }

  setCursorPos(pos/80, pos%80);
  crt[pos] = ' ' | 0x0700;
}
