
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 d7 10 80       	mov    $0x8010d7d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 e0 39 10 80       	mov    $0x801039e0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 d8 93 10 80       	push   $0x801093d8
80100042:	68 e0 d7 10 80       	push   $0x8010d7e0
80100047:	e8 a8 50 00 00       	call   801050f4 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 10 ed 10 80 04 	movl   $0x8010ed04,0x8010ed10
80100056:	ed 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 14 ed 10 80 04 	movl   $0x8010ed04,0x8010ed14
80100060:	ed 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 14 d8 10 80 	movl   $0x8010d814,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 14 ed 10 80    	mov    0x8010ed14,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 04 ed 10 80 	movl   $0x8010ed04,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 14 ed 10 80       	mov    0x8010ed14,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 14 ed 10 80       	mov    %eax,0x8010ed14

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 04 ed 10 80       	mov    $0x8010ed04,%eax
801000ab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ae:	72 bc                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b0:	90                   	nop
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    

801000b3 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b3:	55                   	push   %ebp
801000b4:	89 e5                	mov    %esp,%ebp
801000b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b9:	83 ec 0c             	sub    $0xc,%esp
801000bc:	68 e0 d7 10 80       	push   $0x8010d7e0
801000c1:	e8 50 50 00 00       	call   80105116 <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c9:	a1 14 ed 10 80       	mov    0x8010ed14,%eax
801000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d1:	eb 67                	jmp    8010013a <bget+0x87>
    if(b->dev == dev && b->sector == sector){
801000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d6:	8b 40 04             	mov    0x4(%eax),%eax
801000d9:	3b 45 08             	cmp    0x8(%ebp),%eax
801000dc:	75 53                	jne    80100131 <bget+0x7e>
801000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e1:	8b 40 08             	mov    0x8(%eax),%eax
801000e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e7:	75 48                	jne    80100131 <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 00                	mov    (%eax),%eax
801000ee:	83 e0 01             	and    $0x1,%eax
801000f1:	85 c0                	test   %eax,%eax
801000f3:	75 27                	jne    8010011c <bget+0x69>
        b->flags |= B_BUSY;
801000f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f8:	8b 00                	mov    (%eax),%eax
801000fa:	83 c8 01             	or     $0x1,%eax
801000fd:	89 c2                	mov    %eax,%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100104:	83 ec 0c             	sub    $0xc,%esp
80100107:	68 e0 d7 10 80       	push   $0x8010d7e0
8010010c:	e8 6c 50 00 00       	call   8010517d <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 e0 d7 10 80       	push   $0x8010d7e0
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 f1 4c 00 00       	call   80104e1d <sleep>
8010012c:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012f:	eb 98                	jmp    801000c9 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100134:	8b 40 10             	mov    0x10(%eax),%eax
80100137:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010013a:	81 7d f4 04 ed 10 80 	cmpl   $0x8010ed04,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100143:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
80100148:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014b:	eb 51                	jmp    8010019e <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100150:	8b 00                	mov    (%eax),%eax
80100152:	83 e0 01             	and    $0x1,%eax
80100155:	85 c0                	test   %eax,%eax
80100157:	75 3c                	jne    80100195 <bget+0xe2>
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	8b 00                	mov    (%eax),%eax
8010015e:	83 e0 04             	and    $0x4,%eax
80100161:	85 c0                	test   %eax,%eax
80100163:	75 30                	jne    80100195 <bget+0xe2>
      b->dev = dev;
80100165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100168:	8b 55 08             	mov    0x8(%ebp),%edx
8010016b:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	68 e0 d7 10 80       	push   $0x8010d7e0
80100188:	e8 f0 4f 00 00       	call   8010517d <release>
8010018d:	83 c4 10             	add    $0x10,%esp
      return b;
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1f                	jmp    801001b4 <bget+0x101>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 0c             	mov    0xc(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 04 ed 10 80 	cmpl   $0x8010ed04,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 df 93 10 80       	push   $0x801093df
801001af:	e8 ce 03 00 00       	call   80100582 <panic>
}
801001b4:	c9                   	leave  
801001b5:	c3                   	ret    

801001b6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001b6:	55                   	push   %ebp
801001b7:	89 e5                	mov    %esp,%ebp
801001b9:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001bc:	83 ec 08             	sub    $0x8,%esp
801001bf:	ff 75 0c             	pushl  0xc(%ebp)
801001c2:	ff 75 08             	pushl  0x8(%ebp)
801001c5:	e8 e9 fe ff ff       	call   801000b3 <bget>
801001ca:	83 c4 10             	add    $0x10,%esp
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0e                	jne    801001ea <bread+0x34>
    iderw(b);
801001dc:	83 ec 0c             	sub    $0xc,%esp
801001df:	ff 75 f4             	pushl  -0xc(%ebp)
801001e2:	e8 d4 2b 00 00       	call   80102dbb <iderw>
801001e7:	83 c4 10             	add    $0x10,%esp
  return b;
801001ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001ed:	c9                   	leave  
801001ee:	c3                   	ret    

801001ef <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ef:	55                   	push   %ebp
801001f0:	89 e5                	mov    %esp,%ebp
801001f2:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f5:	8b 45 08             	mov    0x8(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 01             	and    $0x1,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0d                	jne    8010020e <bwrite+0x1f>
    panic("bwrite");
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	68 f0 93 10 80       	push   $0x801093f0
80100209:	e8 74 03 00 00       	call   80100582 <panic>
  b->flags |= B_DIRTY;
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	8b 00                	mov    (%eax),%eax
80100213:	83 c8 04             	or     $0x4,%eax
80100216:	89 c2                	mov    %eax,%edx
80100218:	8b 45 08             	mov    0x8(%ebp),%eax
8010021b:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021d:	83 ec 0c             	sub    $0xc,%esp
80100220:	ff 75 08             	pushl  0x8(%ebp)
80100223:	e8 93 2b 00 00       	call   80102dbb <iderw>
80100228:	83 c4 10             	add    $0x10,%esp
}
8010022b:	90                   	nop
8010022c:	c9                   	leave  
8010022d:	c3                   	ret    

8010022e <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022e:	55                   	push   %ebp
8010022f:	89 e5                	mov    %esp,%ebp
80100231:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100234:	8b 45 08             	mov    0x8(%ebp),%eax
80100237:	8b 00                	mov    (%eax),%eax
80100239:	83 e0 01             	and    $0x1,%eax
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 0d                	jne    8010024d <brelse+0x1f>
    panic("brelse");
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 f7 93 10 80       	push   $0x801093f7
80100248:	e8 35 03 00 00       	call   80100582 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 e0 d7 10 80       	push   $0x8010d7e0
80100255:	e8 bc 4e 00 00       	call   80105116 <acquire>
8010025a:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025d:	8b 45 08             	mov    0x8(%ebp),%eax
80100260:	8b 40 10             	mov    0x10(%eax),%eax
80100263:	8b 55 08             	mov    0x8(%ebp),%edx
80100266:	8b 52 0c             	mov    0xc(%edx),%edx
80100269:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	8b 40 0c             	mov    0xc(%eax),%eax
80100272:	8b 55 08             	mov    0x8(%ebp),%edx
80100275:	8b 52 10             	mov    0x10(%edx),%edx
80100278:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010027b:	8b 15 14 ed 10 80    	mov    0x8010ed14,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c 04 ed 10 80 	movl   $0x8010ed04,0xc(%eax)
  bcache.head.next->prev = b;
80100291:	a1 14 ed 10 80       	mov    0x8010ed14,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 14 ed 10 80       	mov    %eax,0x8010ed14

  b->flags &= ~B_BUSY;
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	8b 00                	mov    (%eax),%eax
801002a9:	83 e0 fe             	and    $0xfffffffe,%eax
801002ac:	89 c2                	mov    %eax,%edx
801002ae:	8b 45 08             	mov    0x8(%ebp),%eax
801002b1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b3:	83 ec 0c             	sub    $0xc,%esp
801002b6:	ff 75 08             	pushl  0x8(%ebp)
801002b9:	e8 4a 4c 00 00       	call   80104f08 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 e0 d7 10 80       	push   $0x8010d7e0
801002c9:	e8 af 4e 00 00       	call   8010517d <release>
801002ce:	83 c4 10             	add    $0x10,%esp
}
801002d1:	90                   	nop
801002d2:	c9                   	leave  
801002d3:	c3                   	ret    

801002d4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d4:	55                   	push   %ebp
801002d5:	89 e5                	mov    %esp,%ebp
801002d7:	83 ec 14             	sub    $0x14,%esp
801002da:	8b 45 08             	mov    0x8(%ebp),%eax
801002dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	ec                   	in     (%dx),%al
801002e8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002ef:	c9                   	leave  
801002f0:	c3                   	ret    

801002f1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	83 ec 08             	sub    $0x8,%esp
801002f7:	8b 55 08             	mov    0x8(%ebp),%edx
801002fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100301:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100304:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100308:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010030c:	ee                   	out    %al,(%dx)
}
8010030d:	90                   	nop
8010030e:	c9                   	leave  
8010030f:	c3                   	ret    

80100310 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100310:	55                   	push   %ebp
80100311:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100313:	fa                   	cli    
}
80100314:	90                   	nop
80100315:	5d                   	pop    %ebp
80100316:	c3                   	ret    

80100317 <setBufferFlag>:
//add_new_variable----------------------------------
static int bufferFlag=1;
static int showAtonce=1;

//if bufferFlag==1, enable console cache
void setBufferFlag(int flag){
80100317:	55                   	push   %ebp
80100318:	89 e5                	mov    %esp,%ebp
  bufferFlag=flag;
8010031a:	8b 45 08             	mov    0x8(%ebp),%eax
8010031d:	a3 00 a0 10 80       	mov    %eax,0x8010a000
}
80100322:	90                   	nop
80100323:	5d                   	pop    %ebp
80100324:	c3                   	ret    

80100325 <setShowAtOnce>:

//if showAtonce==1, inputs displayed on the screen
void setShowAtOnce(int flag){
80100325:	55                   	push   %ebp
80100326:	89 e5                	mov    %esp,%ebp
  showAtonce=flag;
80100328:	8b 45 08             	mov    0x8(%ebp),%eax
8010032b:	a3 04 a0 10 80       	mov    %eax,0x8010a004
}
80100330:	90                   	nop
80100331:	5d                   	pop    %ebp
80100332:	c3                   	ret    

80100333 <printint>:

//---------------------------------------------------

static void
printint(int xx, int base, int sign)
{
80100333:	55                   	push   %ebp
80100334:	89 e5                	mov    %esp,%ebp
80100336:	53                   	push   %ebx
80100337:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010033a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010033e:	74 1c                	je     8010035c <printint+0x29>
80100340:	8b 45 08             	mov    0x8(%ebp),%eax
80100343:	c1 e8 1f             	shr    $0x1f,%eax
80100346:	0f b6 c0             	movzbl %al,%eax
80100349:	89 45 10             	mov    %eax,0x10(%ebp)
8010034c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100350:	74 0a                	je     8010035c <printint+0x29>
    x = -xx;
80100352:	8b 45 08             	mov    0x8(%ebp),%eax
80100355:	f7 d8                	neg    %eax
80100357:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010035a:	eb 06                	jmp    80100362 <printint+0x2f>
  else
    x = xx;
8010035c:	8b 45 08             	mov    0x8(%ebp),%eax
8010035f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100362:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100369:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010036c:	8d 41 01             	lea    0x1(%ecx),%eax
8010036f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100372:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100375:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100378:	ba 00 00 00 00       	mov    $0x0,%edx
8010037d:	f7 f3                	div    %ebx
8010037f:	89 d0                	mov    %edx,%eax
80100381:	0f b6 80 64 a0 10 80 	movzbl -0x7fef5f9c(%eax),%eax
80100388:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010038c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010038f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100392:	ba 00 00 00 00       	mov    $0x0,%edx
80100397:	f7 f3                	div    %ebx
80100399:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010039c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003a0:	75 c7                	jne    80100369 <printint+0x36>

  if(sign)
801003a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003a6:	74 2a                	je     801003d2 <printint+0x9f>
    buf[i++] = '-';
801003a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003ab:	8d 50 01             	lea    0x1(%eax),%edx
801003ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003b1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003b6:	eb 1a                	jmp    801003d2 <printint+0x9f>
    consputc(buf[i]);
801003b8:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003be:	01 d0                	add    %edx,%eax
801003c0:	0f b6 00             	movzbl (%eax),%eax
801003c3:	0f be c0             	movsbl %al,%eax
801003c6:	83 ec 0c             	sub    $0xc,%esp
801003c9:	50                   	push   %eax
801003ca:	e8 5b 04 00 00       	call   8010082a <consputc>
801003cf:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003d2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003da:	79 dc                	jns    801003b8 <printint+0x85>
    consputc(buf[i]);
}
801003dc:	90                   	nop
801003dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003e0:	c9                   	leave  
801003e1:	c3                   	ret    

801003e2 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003e2:	55                   	push   %ebp
801003e3:	89 e5                	mov    %esp,%ebp
801003e5:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003e8:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801003ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003f0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003f4:	74 10                	je     80100406 <cprintf+0x24>
    acquire(&cons.lock);
801003f6:	83 ec 0c             	sub    $0xc,%esp
801003f9:	68 00 c6 10 80       	push   $0x8010c600
801003fe:	e8 13 4d 00 00       	call   80105116 <acquire>
80100403:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100406:	8b 45 08             	mov    0x8(%ebp),%eax
80100409:	85 c0                	test   %eax,%eax
8010040b:	75 0d                	jne    8010041a <cprintf+0x38>
    panic("null fmt");
8010040d:	83 ec 0c             	sub    $0xc,%esp
80100410:	68 fe 93 10 80       	push   $0x801093fe
80100415:	e8 68 01 00 00       	call   80100582 <panic>

  argp = (uint*)(void*)(&fmt + 1);
8010041a:	8d 45 0c             	lea    0xc(%ebp),%eax
8010041d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100420:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100427:	e9 1a 01 00 00       	jmp    80100546 <cprintf+0x164>
    if(c != '%'){
8010042c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100430:	74 13                	je     80100445 <cprintf+0x63>
      consputc(c);
80100432:	83 ec 0c             	sub    $0xc,%esp
80100435:	ff 75 e4             	pushl  -0x1c(%ebp)
80100438:	e8 ed 03 00 00       	call   8010082a <consputc>
8010043d:	83 c4 10             	add    $0x10,%esp
      continue;
80100440:	e9 fd 00 00 00       	jmp    80100542 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100445:	8b 55 08             	mov    0x8(%ebp),%edx
80100448:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010044c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010044f:	01 d0                	add    %edx,%eax
80100451:	0f b6 00             	movzbl (%eax),%eax
80100454:	0f be c0             	movsbl %al,%eax
80100457:	25 ff 00 00 00       	and    $0xff,%eax
8010045c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010045f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100463:	0f 84 ff 00 00 00    	je     80100568 <cprintf+0x186>
      break;
    switch(c){
80100469:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010046c:	83 f8 70             	cmp    $0x70,%eax
8010046f:	74 47                	je     801004b8 <cprintf+0xd6>
80100471:	83 f8 70             	cmp    $0x70,%eax
80100474:	7f 13                	jg     80100489 <cprintf+0xa7>
80100476:	83 f8 25             	cmp    $0x25,%eax
80100479:	0f 84 98 00 00 00    	je     80100517 <cprintf+0x135>
8010047f:	83 f8 64             	cmp    $0x64,%eax
80100482:	74 14                	je     80100498 <cprintf+0xb6>
80100484:	e9 9d 00 00 00       	jmp    80100526 <cprintf+0x144>
80100489:	83 f8 73             	cmp    $0x73,%eax
8010048c:	74 47                	je     801004d5 <cprintf+0xf3>
8010048e:	83 f8 78             	cmp    $0x78,%eax
80100491:	74 25                	je     801004b8 <cprintf+0xd6>
80100493:	e9 8e 00 00 00       	jmp    80100526 <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
80100498:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049b:	8d 50 04             	lea    0x4(%eax),%edx
8010049e:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a1:	8b 00                	mov    (%eax),%eax
801004a3:	83 ec 04             	sub    $0x4,%esp
801004a6:	6a 01                	push   $0x1
801004a8:	6a 0a                	push   $0xa
801004aa:	50                   	push   %eax
801004ab:	e8 83 fe ff ff       	call   80100333 <printint>
801004b0:	83 c4 10             	add    $0x10,%esp
      break;
801004b3:	e9 8a 00 00 00       	jmp    80100542 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bb:	8d 50 04             	lea    0x4(%eax),%edx
801004be:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c1:	8b 00                	mov    (%eax),%eax
801004c3:	83 ec 04             	sub    $0x4,%esp
801004c6:	6a 00                	push   $0x0
801004c8:	6a 10                	push   $0x10
801004ca:	50                   	push   %eax
801004cb:	e8 63 fe ff ff       	call   80100333 <printint>
801004d0:	83 c4 10             	add    $0x10,%esp
      break;
801004d3:	eb 6d                	jmp    80100542 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004d8:	8d 50 04             	lea    0x4(%eax),%edx
801004db:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004de:	8b 00                	mov    (%eax),%eax
801004e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004e7:	75 22                	jne    8010050b <cprintf+0x129>
        s = "(null)";
801004e9:	c7 45 ec 07 94 10 80 	movl   $0x80109407,-0x14(%ebp)
      for(; *s; s++)
801004f0:	eb 19                	jmp    8010050b <cprintf+0x129>
        consputc(*s);
801004f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f5:	0f b6 00             	movzbl (%eax),%eax
801004f8:	0f be c0             	movsbl %al,%eax
801004fb:	83 ec 0c             	sub    $0xc,%esp
801004fe:	50                   	push   %eax
801004ff:	e8 26 03 00 00       	call   8010082a <consputc>
80100504:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100507:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010050b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010050e:	0f b6 00             	movzbl (%eax),%eax
80100511:	84 c0                	test   %al,%al
80100513:	75 dd                	jne    801004f2 <cprintf+0x110>
        consputc(*s);
      break;
80100515:	eb 2b                	jmp    80100542 <cprintf+0x160>
    case '%':
      consputc('%');
80100517:	83 ec 0c             	sub    $0xc,%esp
8010051a:	6a 25                	push   $0x25
8010051c:	e8 09 03 00 00       	call   8010082a <consputc>
80100521:	83 c4 10             	add    $0x10,%esp
      break;
80100524:	eb 1c                	jmp    80100542 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100526:	83 ec 0c             	sub    $0xc,%esp
80100529:	6a 25                	push   $0x25
8010052b:	e8 fa 02 00 00       	call   8010082a <consputc>
80100530:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100533:	83 ec 0c             	sub    $0xc,%esp
80100536:	ff 75 e4             	pushl  -0x1c(%ebp)
80100539:	e8 ec 02 00 00       	call   8010082a <consputc>
8010053e:	83 c4 10             	add    $0x10,%esp
      break;
80100541:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100542:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100546:	8b 55 08             	mov    0x8(%ebp),%edx
80100549:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010054c:	01 d0                	add    %edx,%eax
8010054e:	0f b6 00             	movzbl (%eax),%eax
80100551:	0f be c0             	movsbl %al,%eax
80100554:	25 ff 00 00 00       	and    $0xff,%eax
80100559:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010055c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100560:	0f 85 c6 fe ff ff    	jne    8010042c <cprintf+0x4a>
80100566:	eb 01                	jmp    80100569 <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100568:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100569:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010056d:	74 10                	je     8010057f <cprintf+0x19d>
    release(&cons.lock);
8010056f:	83 ec 0c             	sub    $0xc,%esp
80100572:	68 00 c6 10 80       	push   $0x8010c600
80100577:	e8 01 4c 00 00       	call   8010517d <release>
8010057c:	83 c4 10             	add    $0x10,%esp
}
8010057f:	90                   	nop
80100580:	c9                   	leave  
80100581:	c3                   	ret    

80100582 <panic>:

void
panic(char *s)
{
80100582:	55                   	push   %ebp
80100583:	89 e5                	mov    %esp,%ebp
80100585:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100588:	e8 83 fd ff ff       	call   80100310 <cli>
  cons.locking = 0;
8010058d:	c7 05 34 c6 10 80 00 	movl   $0x0,0x8010c634
80100594:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100597:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010059d:	0f b6 00             	movzbl (%eax),%eax
801005a0:	0f b6 c0             	movzbl %al,%eax
801005a3:	83 ec 08             	sub    $0x8,%esp
801005a6:	50                   	push   %eax
801005a7:	68 0e 94 10 80       	push   $0x8010940e
801005ac:	e8 31 fe ff ff       	call   801003e2 <cprintf>
801005b1:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005b4:	8b 45 08             	mov    0x8(%ebp),%eax
801005b7:	83 ec 0c             	sub    $0xc,%esp
801005ba:	50                   	push   %eax
801005bb:	e8 22 fe ff ff       	call   801003e2 <cprintf>
801005c0:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005c3:	83 ec 0c             	sub    $0xc,%esp
801005c6:	68 1d 94 10 80       	push   $0x8010941d
801005cb:	e8 12 fe ff ff       	call   801003e2 <cprintf>
801005d0:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005d3:	83 ec 08             	sub    $0x8,%esp
801005d6:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005d9:	50                   	push   %eax
801005da:	8d 45 08             	lea    0x8(%ebp),%eax
801005dd:	50                   	push   %eax
801005de:	e8 ec 4b 00 00       	call   801051cf <getcallerpcs>
801005e3:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005ed:	eb 1c                	jmp    8010060b <panic+0x89>
    cprintf(" %p", pcs[i]);
801005ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005f2:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005f6:	83 ec 08             	sub    $0x8,%esp
801005f9:	50                   	push   %eax
801005fa:	68 1f 94 10 80       	push   $0x8010941f
801005ff:	e8 de fd ff ff       	call   801003e2 <cprintf>
80100604:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
80100607:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010060b:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010060f:	7e de                	jle    801005ef <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
80100611:	c7 05 e0 c5 10 80 01 	movl   $0x1,0x8010c5e0
80100618:	00 00 00 
  for(;;)
    ;
8010061b:	eb fe                	jmp    8010061b <panic+0x99>

8010061d <getCursorPos>:

//add function------------------------------------------------
//void showc(int pos, int c ){
//  crt[pos] = c & 0xffff;
//}
int getCursorPos(){
8010061d:	55                   	push   %ebp
8010061e:	89 e5                	mov    %esp,%ebp
80100620:	83 ec 10             	sub    $0x10,%esp
  int pos;
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100623:	6a 0e                	push   $0xe
80100625:	68 d4 03 00 00       	push   $0x3d4
8010062a:	e8 c2 fc ff ff       	call   801002f1 <outb>
8010062f:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100632:	68 d5 03 00 00       	push   $0x3d5
80100637:	e8 98 fc ff ff       	call   801002d4 <inb>
8010063c:	83 c4 04             	add    $0x4,%esp
8010063f:	0f b6 c0             	movzbl %al,%eax
80100642:	c1 e0 08             	shl    $0x8,%eax
80100645:	89 45 fc             	mov    %eax,-0x4(%ebp)
  outb(CRTPORT, 15);
80100648:	6a 0f                	push   $0xf
8010064a:	68 d4 03 00 00       	push   $0x3d4
8010064f:	e8 9d fc ff ff       	call   801002f1 <outb>
80100654:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100657:	68 d5 03 00 00       	push   $0x3d5
8010065c:	e8 73 fc ff ff       	call   801002d4 <inb>
80100661:	83 c4 04             	add    $0x4,%esp
80100664:	0f b6 c0             	movzbl %al,%eax
80100667:	09 45 fc             	or     %eax,-0x4(%ebp)
  return pos;
8010066a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010066d:	c9                   	leave  
8010066e:	c3                   	ret    

8010066f <setCursorPos>:

void setCursorPos(int x, int y) {
8010066f:	55                   	push   %ebp
80100670:	89 e5                	mov    %esp,%ebp
80100672:	83 ec 10             	sub    $0x10,%esp
  
  int pos = x*80 + y;
80100675:	8b 55 08             	mov    0x8(%ebp),%edx
80100678:	89 d0                	mov    %edx,%eax
8010067a:	c1 e0 02             	shl    $0x2,%eax
8010067d:	01 d0                	add    %edx,%eax
8010067f:	c1 e0 04             	shl    $0x4,%eax
80100682:	89 c2                	mov    %eax,%edx
80100684:	8b 45 0c             	mov    0xc(%ebp),%eax
80100687:	01 d0                	add    %edx,%eax
80100689:	89 45 fc             	mov    %eax,-0x4(%ebp)
  outb(CRTPORT, 14);
8010068c:	6a 0e                	push   $0xe
8010068e:	68 d4 03 00 00       	push   $0x3d4
80100693:	e8 59 fc ff ff       	call   801002f1 <outb>
80100698:	83 c4 08             	add    $0x8,%esp
  outb(CRTPORT+1, pos>>8);
8010069b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010069e:	c1 f8 08             	sar    $0x8,%eax
801006a1:	0f b6 c0             	movzbl %al,%eax
801006a4:	50                   	push   %eax
801006a5:	68 d5 03 00 00       	push   $0x3d5
801006aa:	e8 42 fc ff ff       	call   801002f1 <outb>
801006af:	83 c4 08             	add    $0x8,%esp
  outb(CRTPORT, 15);
801006b2:	6a 0f                	push   $0xf
801006b4:	68 d4 03 00 00       	push   $0x3d4
801006b9:	e8 33 fc ff ff       	call   801002f1 <outb>
801006be:	83 c4 08             	add    $0x8,%esp
  outb(CRTPORT+1, pos);
801006c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801006c4:	0f b6 c0             	movzbl %al,%eax
801006c7:	50                   	push   %eax
801006c8:	68 d5 03 00 00       	push   $0x3d5
801006cd:	e8 1f fc ff ff       	call   801002f1 <outb>
801006d2:	83 c4 08             	add    $0x8,%esp
  crt[pos] |= 0x0700;
801006d5:	a1 08 a0 10 80       	mov    0x8010a008,%eax
801006da:	8b 55 fc             	mov    -0x4(%ebp),%edx
801006dd:	01 d2                	add    %edx,%edx
801006df:	01 d0                	add    %edx,%eax
801006e1:	8b 15 08 a0 10 80    	mov    0x8010a008,%edx
801006e7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
801006ea:	01 c9                	add    %ecx,%ecx
801006ec:	01 ca                	add    %ecx,%edx
801006ee:	0f b7 12             	movzwl (%edx),%edx
801006f1:	80 ce 07             	or     $0x7,%dh
801006f4:	66 89 10             	mov    %dx,(%eax)
}
801006f7:	90                   	nop
801006f8:	c9                   	leave  
801006f9:	c3                   	ret    

801006fa <cgaputc>:

static void
cgaputc(int c)
{
801006fa:	55                   	push   %ebp
801006fb:	89 e5                	mov    %esp,%ebp
801006fd:	53                   	push   %ebx
801006fe:	83 ec 14             	sub    $0x14,%esp
  int pos;
  pos = getCursorPos();
80100701:	e8 17 ff ff ff       	call   8010061d <getCursorPos>
80100706:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(c == '\n')
80100709:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010070d:	75 30                	jne    8010073f <cgaputc+0x45>
    pos += 80 - pos%80;
8010070f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100712:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100717:	89 c8                	mov    %ecx,%eax
80100719:	f7 ea                	imul   %edx
8010071b:	c1 fa 05             	sar    $0x5,%edx
8010071e:	89 c8                	mov    %ecx,%eax
80100720:	c1 f8 1f             	sar    $0x1f,%eax
80100723:	29 c2                	sub    %eax,%edx
80100725:	89 d0                	mov    %edx,%eax
80100727:	c1 e0 02             	shl    $0x2,%eax
8010072a:	01 d0                	add    %edx,%eax
8010072c:	c1 e0 04             	shl    $0x4,%eax
8010072f:	29 c1                	sub    %eax,%ecx
80100731:	89 ca                	mov    %ecx,%edx
80100733:	b8 50 00 00 00       	mov    $0x50,%eax
80100738:	29 d0                	sub    %edx,%eax
8010073a:	01 45 f4             	add    %eax,-0xc(%ebp)
8010073d:	eb 34                	jmp    80100773 <cgaputc+0x79>
  else if(c == BACKSPACE){
8010073f:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100746:	75 0c                	jne    80100754 <cgaputc+0x5a>
    if(pos > 0) --pos;
80100748:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010074c:	7e 25                	jle    80100773 <cgaputc+0x79>
8010074e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100752:	eb 1f                	jmp    80100773 <cgaputc+0x79>
  } 
  else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100754:	8b 0d 08 a0 10 80    	mov    0x8010a008,%ecx
8010075a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010075d:	8d 50 01             	lea    0x1(%eax),%edx
80100760:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100763:	01 c0                	add    %eax,%eax
80100765:	01 c8                	add    %ecx,%eax
80100767:	8b 55 08             	mov    0x8(%ebp),%edx
8010076a:	0f b6 d2             	movzbl %dl,%edx
8010076d:	80 ce 07             	or     $0x7,%dh
80100770:	66 89 10             	mov    %dx,(%eax)
  
  //expand the screen from 24 to 25 lines
  //modified----------
  if((pos/80) >= 25){  // Scroll up.
80100773:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
8010077a:	7e 4c                	jle    801007c8 <cgaputc+0xce>
    memmove(crt, crt+80, sizeof(crt[0])*24*80);
8010077c:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100781:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100787:	a1 08 a0 10 80       	mov    0x8010a008,%eax
8010078c:	83 ec 04             	sub    $0x4,%esp
8010078f:	68 00 0f 00 00       	push   $0xf00
80100794:	52                   	push   %edx
80100795:	50                   	push   %eax
80100796:	e8 9d 4c 00 00       	call   80105438 <memmove>
8010079b:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
8010079e:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
801007a2:	b8 d0 07 00 00       	mov    $0x7d0,%eax
801007a7:	2b 45 f4             	sub    -0xc(%ebp),%eax
801007aa:	8d 14 00             	lea    (%eax,%eax,1),%edx
801007ad:	a1 08 a0 10 80       	mov    0x8010a008,%eax
801007b2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801007b5:	01 c9                	add    %ecx,%ecx
801007b7:	01 c8                	add    %ecx,%eax
801007b9:	83 ec 04             	sub    $0x4,%esp
801007bc:	52                   	push   %edx
801007bd:	6a 00                	push   $0x0
801007bf:	50                   	push   %eax
801007c0:	e8 b4 4b 00 00       	call   80105379 <memset>
801007c5:	83 c4 10             	add    $0x10,%esp
  }

  setCursorPos(pos/80, pos%80);
801007c8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801007cb:	ba 67 66 66 66       	mov    $0x66666667,%edx
801007d0:	89 d8                	mov    %ebx,%eax
801007d2:	f7 ea                	imul   %edx
801007d4:	c1 fa 05             	sar    $0x5,%edx
801007d7:	89 d8                	mov    %ebx,%eax
801007d9:	c1 f8 1f             	sar    $0x1f,%eax
801007dc:	89 d1                	mov    %edx,%ecx
801007de:	29 c1                	sub    %eax,%ecx
801007e0:	89 c8                	mov    %ecx,%eax
801007e2:	c1 e0 02             	shl    $0x2,%eax
801007e5:	01 c8                	add    %ecx,%eax
801007e7:	c1 e0 04             	shl    $0x4,%eax
801007ea:	29 c3                	sub    %eax,%ebx
801007ec:	89 d9                	mov    %ebx,%ecx
801007ee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801007f1:	ba 67 66 66 66       	mov    $0x66666667,%edx
801007f6:	89 d8                	mov    %ebx,%eax
801007f8:	f7 ea                	imul   %edx
801007fa:	c1 fa 05             	sar    $0x5,%edx
801007fd:	89 d8                	mov    %ebx,%eax
801007ff:	c1 f8 1f             	sar    $0x1f,%eax
80100802:	29 c2                	sub    %eax,%edx
80100804:	89 d0                	mov    %edx,%eax
80100806:	83 ec 08             	sub    $0x8,%esp
80100809:	51                   	push   %ecx
8010080a:	50                   	push   %eax
8010080b:	e8 5f fe ff ff       	call   8010066f <setCursorPos>
80100810:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100813:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100818:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010081b:	01 d2                	add    %edx,%edx
8010081d:	01 d0                	add    %edx,%eax
8010081f:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100824:	90                   	nop
80100825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100828:	c9                   	leave  
80100829:	c3                   	ret    

8010082a <consputc>:

//--------------------------------------------------------

void
consputc(int c)
{
8010082a:	55                   	push   %ebp
8010082b:	89 e5                	mov    %esp,%ebp
8010082d:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100830:	a1 e0 c5 10 80       	mov    0x8010c5e0,%eax
80100835:	85 c0                	test   %eax,%eax
80100837:	74 07                	je     80100840 <consputc+0x16>
    cli();
80100839:	e8 d2 fa ff ff       	call   80100310 <cli>
    for(;;)
      ;
8010083e:	eb fe                	jmp    8010083e <consputc+0x14>
  }

  if(c == BACKSPACE){
80100840:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100847:	75 29                	jne    80100872 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100849:	83 ec 0c             	sub    $0xc,%esp
8010084c:	6a 08                	push   $0x8
8010084e:	e8 eb 67 00 00       	call   8010703e <uartputc>
80100853:	83 c4 10             	add    $0x10,%esp
80100856:	83 ec 0c             	sub    $0xc,%esp
80100859:	6a 20                	push   $0x20
8010085b:	e8 de 67 00 00       	call   8010703e <uartputc>
80100860:	83 c4 10             	add    $0x10,%esp
80100863:	83 ec 0c             	sub    $0xc,%esp
80100866:	6a 08                	push   $0x8
80100868:	e8 d1 67 00 00       	call   8010703e <uartputc>
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	eb 0e                	jmp    80100880 <consputc+0x56>
  } else
    uartputc(c);
80100872:	83 ec 0c             	sub    $0xc,%esp
80100875:	ff 75 08             	pushl  0x8(%ebp)
80100878:	e8 c1 67 00 00       	call   8010703e <uartputc>
8010087d:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	ff 75 08             	pushl  0x8(%ebp)
80100886:	e8 6f fe ff ff       	call   801006fa <cgaputc>
8010088b:	83 c4 10             	add    $0x10,%esp
}
8010088e:	90                   	nop
8010088f:	c9                   	leave  
80100890:	c3                   	ret    

80100891 <consoleintr>:
#define C(x)  ((x)-'@')  // Control-x

//modified function-----------------------------------------------
void
consoleintr(int (*getc)(void))
{
80100891:	55                   	push   %ebp
80100892:	89 e5                	mov    %esp,%ebp
80100894:	83 ec 18             	sub    $0x18,%esp
  int c;
  //add_new_variable
  int doprocdump = 0;
80100897:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&input.lock);
8010089e:	83 ec 0c             	sub    $0xc,%esp
801008a1:	68 20 ef 10 80       	push   $0x8010ef20
801008a6:	e8 6b 48 00 00       	call   80105116 <acquire>
801008ab:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801008ae:	e9 5a 01 00 00       	jmp    80100a0d <consoleintr+0x17c>
    switch(c){
801008b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008b6:	83 f8 10             	cmp    $0x10,%eax
801008b9:	74 1e                	je     801008d9 <consoleintr+0x48>
801008bb:	83 f8 10             	cmp    $0x10,%eax
801008be:	7f 0a                	jg     801008ca <consoleintr+0x39>
801008c0:	83 f8 08             	cmp    $0x8,%eax
801008c3:	74 6b                	je     80100930 <consoleintr+0x9f>
801008c5:	e9 9b 00 00 00       	jmp    80100965 <consoleintr+0xd4>
801008ca:	83 f8 15             	cmp    $0x15,%eax
801008cd:	74 33                	je     80100902 <consoleintr+0x71>
801008cf:	83 f8 7f             	cmp    $0x7f,%eax
801008d2:	74 5c                	je     80100930 <consoleintr+0x9f>
801008d4:	e9 8c 00 00 00       	jmp    80100965 <consoleintr+0xd4>
    case C('P'):  // Process listing.
      //procdump();
      doprocdump=1;
801008d9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801008e0:	e9 28 01 00 00       	jmp    80100a0d <consoleintr+0x17c>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008e5:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
801008ea:	83 e8 01             	sub    $0x1,%eax
801008ed:	a3 dc ef 10 80       	mov    %eax,0x8010efdc
        consputc(BACKSPACE);
801008f2:	83 ec 0c             	sub    $0xc,%esp
801008f5:	68 00 01 00 00       	push   $0x100
801008fa:	e8 2b ff ff ff       	call   8010082a <consputc>
801008ff:	83 c4 10             	add    $0x10,%esp
    case C('P'):  // Process listing.
      //procdump();
      doprocdump=1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100902:	8b 15 dc ef 10 80    	mov    0x8010efdc,%edx
80100908:	a1 d8 ef 10 80       	mov    0x8010efd8,%eax
8010090d:	39 c2                	cmp    %eax,%edx
8010090f:	0f 84 f8 00 00 00    	je     80100a0d <consoleintr+0x17c>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100915:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
8010091a:	83 e8 01             	sub    $0x1,%eax
8010091d:	83 e0 7f             	and    $0x7f,%eax
80100920:	0f b6 80 54 ef 10 80 	movzbl -0x7fef10ac(%eax),%eax
    case C('P'):  // Process listing.
      //procdump();
      doprocdump=1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100927:	3c 0a                	cmp    $0xa,%al
80100929:	75 ba                	jne    801008e5 <consoleintr+0x54>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010092b:	e9 dd 00 00 00       	jmp    80100a0d <consoleintr+0x17c>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100930:	8b 15 dc ef 10 80    	mov    0x8010efdc,%edx
80100936:	a1 d8 ef 10 80       	mov    0x8010efd8,%eax
8010093b:	39 c2                	cmp    %eax,%edx
8010093d:	0f 84 ca 00 00 00    	je     80100a0d <consoleintr+0x17c>
        input.e--;
80100943:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
80100948:	83 e8 01             	sub    $0x1,%eax
8010094b:	a3 dc ef 10 80       	mov    %eax,0x8010efdc
        consputc(BACKSPACE);
80100950:	83 ec 0c             	sub    $0xc,%esp
80100953:	68 00 01 00 00       	push   $0x100
80100958:	e8 cd fe ff ff       	call   8010082a <consputc>
8010095d:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100960:	e9 a8 00 00 00       	jmp    80100a0d <consoleintr+0x17c>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100965:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100969:	0f 84 9d 00 00 00    	je     80100a0c <consoleintr+0x17b>
8010096f:	8b 15 dc ef 10 80    	mov    0x8010efdc,%edx
80100975:	a1 d4 ef 10 80       	mov    0x8010efd4,%eax
8010097a:	29 c2                	sub    %eax,%edx
8010097c:	89 d0                	mov    %edx,%eax
8010097e:	83 f8 7f             	cmp    $0x7f,%eax
80100981:	0f 87 85 00 00 00    	ja     80100a0c <consoleintr+0x17b>
        c = (c == '\r') ? '\n' : c;
80100987:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010098b:	74 05                	je     80100992 <consoleintr+0x101>
8010098d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100990:	eb 05                	jmp    80100997 <consoleintr+0x106>
80100992:	b8 0a 00 00 00       	mov    $0xa,%eax
80100997:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
8010099a:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
8010099f:	8d 50 01             	lea    0x1(%eax),%edx
801009a2:	89 15 dc ef 10 80    	mov    %edx,0x8010efdc
801009a8:	83 e0 7f             	and    $0x7f,%eax
801009ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
801009ae:	88 90 54 ef 10 80    	mov    %dl,-0x7fef10ac(%eax)
        if(showAtonce)  //add_judge
801009b4:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801009b9:	85 c0                	test   %eax,%eax
801009bb:	74 0e                	je     801009cb <consoleintr+0x13a>
          consputc(c);
801009bd:	83 ec 0c             	sub    $0xc,%esp
801009c0:	ff 75 f0             	pushl  -0x10(%ebp)
801009c3:	e8 62 fe ff ff       	call   8010082a <consputc>
801009c8:	83 c4 10             	add    $0x10,%esp
        //add_judge
        if(!bufferFlag || c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009cb:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801009d0:	85 c0                	test   %eax,%eax
801009d2:	74 1e                	je     801009f2 <consoleintr+0x161>
801009d4:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801009d8:	74 18                	je     801009f2 <consoleintr+0x161>
801009da:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009de:	74 12                	je     801009f2 <consoleintr+0x161>
801009e0:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
801009e5:	8b 15 d4 ef 10 80    	mov    0x8010efd4,%edx
801009eb:	83 ea 80             	sub    $0xffffff80,%edx
801009ee:	39 d0                	cmp    %edx,%eax
801009f0:	75 1a                	jne    80100a0c <consoleintr+0x17b>
          input.w = input.e;
801009f2:	a1 dc ef 10 80       	mov    0x8010efdc,%eax
801009f7:	a3 d8 ef 10 80       	mov    %eax,0x8010efd8
          wakeup(&input.r);
801009fc:	83 ec 0c             	sub    $0xc,%esp
801009ff:	68 d4 ef 10 80       	push   $0x8010efd4
80100a04:	e8 ff 44 00 00       	call   80104f08 <wakeup>
80100a09:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100a0c:	90                   	nop
  int c;
  //add_new_variable
  int doprocdump = 0;

  acquire(&input.lock);
  while((c = getc()) >= 0){
80100a0d:	8b 45 08             	mov    0x8(%ebp),%eax
80100a10:	ff d0                	call   *%eax
80100a12:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100a15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100a19:	0f 89 94 fe ff ff    	jns    801008b3 <consoleintr+0x22>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100a1f:	83 ec 0c             	sub    $0xc,%esp
80100a22:	68 20 ef 10 80       	push   $0x8010ef20
80100a27:	e8 51 47 00 00       	call   8010517d <release>
80100a2c:	83 c4 10             	add    $0x10,%esp
  //add_judge
  if(doprocdump) {
80100a2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100a33:	74 05                	je     80100a3a <consoleintr+0x1a9>
    procdump();  // now call procdump() wo. cons.lock held
80100a35:	e8 89 45 00 00       	call   80104fc3 <procdump>
  }
}
80100a3a:	90                   	nop
80100a3b:	c9                   	leave  
80100a3c:	c3                   	ret    

80100a3d <consoleread>:

//-----------------------------------------------------------------------

int
consoleread(struct inode *ip, char *dst, int n)
{
80100a3d:	55                   	push   %ebp
80100a3e:	89 e5                	mov    %esp,%ebp
80100a40:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100a43:	83 ec 0c             	sub    $0xc,%esp
80100a46:	ff 75 08             	pushl  0x8(%ebp)
80100a49:	e8 64 15 00 00       	call   80101fb2 <iunlock>
80100a4e:	83 c4 10             	add    $0x10,%esp
  target = n;
80100a51:	8b 45 10             	mov    0x10(%ebp),%eax
80100a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100a57:	83 ec 0c             	sub    $0xc,%esp
80100a5a:	68 20 ef 10 80       	push   $0x8010ef20
80100a5f:	e8 b2 46 00 00       	call   80105116 <acquire>
80100a64:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100a67:	e9 ac 00 00 00       	jmp    80100b18 <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
80100a6c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100a72:	8b 40 24             	mov    0x24(%eax),%eax
80100a75:	85 c0                	test   %eax,%eax
80100a77:	74 28                	je     80100aa1 <consoleread+0x64>
        release(&input.lock);
80100a79:	83 ec 0c             	sub    $0xc,%esp
80100a7c:	68 20 ef 10 80       	push   $0x8010ef20
80100a81:	e8 f7 46 00 00       	call   8010517d <release>
80100a86:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a89:	83 ec 0c             	sub    $0xc,%esp
80100a8c:	ff 75 08             	pushl  0x8(%ebp)
80100a8f:	e8 c6 13 00 00       	call   80101e5a <ilock>
80100a94:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a9c:	e9 ab 00 00 00       	jmp    80100b4c <consoleread+0x10f>
      }
      sleep(&input.r, &input.lock);
80100aa1:	83 ec 08             	sub    $0x8,%esp
80100aa4:	68 20 ef 10 80       	push   $0x8010ef20
80100aa9:	68 d4 ef 10 80       	push   $0x8010efd4
80100aae:	e8 6a 43 00 00       	call   80104e1d <sleep>
80100ab3:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80100ab6:	8b 15 d4 ef 10 80    	mov    0x8010efd4,%edx
80100abc:	a1 d8 ef 10 80       	mov    0x8010efd8,%eax
80100ac1:	39 c2                	cmp    %eax,%edx
80100ac3:	74 a7                	je     80100a6c <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100ac5:	a1 d4 ef 10 80       	mov    0x8010efd4,%eax
80100aca:	8d 50 01             	lea    0x1(%eax),%edx
80100acd:	89 15 d4 ef 10 80    	mov    %edx,0x8010efd4
80100ad3:	83 e0 7f             	and    $0x7f,%eax
80100ad6:	0f b6 80 54 ef 10 80 	movzbl -0x7fef10ac(%eax),%eax
80100add:	0f be c0             	movsbl %al,%eax
80100ae0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100ae3:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100ae7:	75 17                	jne    80100b00 <consoleread+0xc3>
      if(n < target){
80100ae9:	8b 45 10             	mov    0x10(%ebp),%eax
80100aec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100aef:	73 2f                	jae    80100b20 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100af1:	a1 d4 ef 10 80       	mov    0x8010efd4,%eax
80100af6:	83 e8 01             	sub    $0x1,%eax
80100af9:	a3 d4 ef 10 80       	mov    %eax,0x8010efd4
      }
      break;
80100afe:	eb 20                	jmp    80100b20 <consoleread+0xe3>
    }
    *dst++ = c;
80100b00:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b03:	8d 50 01             	lea    0x1(%eax),%edx
80100b06:	89 55 0c             	mov    %edx,0xc(%ebp)
80100b09:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100b0c:	88 10                	mov    %dl,(%eax)
    --n;
80100b0e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100b12:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100b16:	74 0b                	je     80100b23 <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100b18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100b1c:	7f 98                	jg     80100ab6 <consoleread+0x79>
80100b1e:	eb 04                	jmp    80100b24 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100b20:	90                   	nop
80100b21:	eb 01                	jmp    80100b24 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100b23:	90                   	nop
  }
  release(&input.lock);
80100b24:	83 ec 0c             	sub    $0xc,%esp
80100b27:	68 20 ef 10 80       	push   $0x8010ef20
80100b2c:	e8 4c 46 00 00       	call   8010517d <release>
80100b31:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b34:	83 ec 0c             	sub    $0xc,%esp
80100b37:	ff 75 08             	pushl  0x8(%ebp)
80100b3a:	e8 1b 13 00 00       	call   80101e5a <ilock>
80100b3f:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100b42:	8b 45 10             	mov    0x10(%ebp),%eax
80100b45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b48:	29 c2                	sub    %eax,%edx
80100b4a:	89 d0                	mov    %edx,%eax
}
80100b4c:	c9                   	leave  
80100b4d:	c3                   	ret    

80100b4e <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100b4e:	55                   	push   %ebp
80100b4f:	89 e5                	mov    %esp,%ebp
80100b51:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100b54:	83 ec 0c             	sub    $0xc,%esp
80100b57:	ff 75 08             	pushl  0x8(%ebp)
80100b5a:	e8 53 14 00 00       	call   80101fb2 <iunlock>
80100b5f:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100b62:	83 ec 0c             	sub    $0xc,%esp
80100b65:	68 00 c6 10 80       	push   $0x8010c600
80100b6a:	e8 a7 45 00 00       	call   80105116 <acquire>
80100b6f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100b79:	eb 21                	jmp    80100b9c <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100b7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b81:	01 d0                	add    %edx,%eax
80100b83:	0f b6 00             	movzbl (%eax),%eax
80100b86:	0f be c0             	movsbl %al,%eax
80100b89:	0f b6 c0             	movzbl %al,%eax
80100b8c:	83 ec 0c             	sub    $0xc,%esp
80100b8f:	50                   	push   %eax
80100b90:	e8 95 fc ff ff       	call   8010082a <consputc>
80100b95:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100b98:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b9f:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ba2:	7c d7                	jl     80100b7b <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ba4:	83 ec 0c             	sub    $0xc,%esp
80100ba7:	68 00 c6 10 80       	push   $0x8010c600
80100bac:	e8 cc 45 00 00       	call   8010517d <release>
80100bb1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100bb4:	83 ec 0c             	sub    $0xc,%esp
80100bb7:	ff 75 08             	pushl  0x8(%ebp)
80100bba:	e8 9b 12 00 00       	call   80101e5a <ilock>
80100bbf:	83 c4 10             	add    $0x10,%esp

  return n;
80100bc2:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100bc5:	c9                   	leave  
80100bc6:	c3                   	ret    

80100bc7 <consoleinit>:

void
consoleinit(void)
{
80100bc7:	55                   	push   %ebp
80100bc8:	89 e5                	mov    %esp,%ebp
80100bca:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100bcd:	83 ec 08             	sub    $0x8,%esp
80100bd0:	68 23 94 10 80       	push   $0x80109423
80100bd5:	68 00 c6 10 80       	push   $0x8010c600
80100bda:	e8 15 45 00 00       	call   801050f4 <initlock>
80100bdf:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100be2:	83 ec 08             	sub    $0x8,%esp
80100be5:	68 2b 94 10 80       	push   $0x8010942b
80100bea:	68 20 ef 10 80       	push   $0x8010ef20
80100bef:	e8 00 45 00 00       	call   801050f4 <initlock>
80100bf4:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100bf7:	c7 05 8c f9 10 80 4e 	movl   $0x80100b4e,0x8010f98c
80100bfe:	0b 10 80 
  devsw[CONSOLE].read = consoleread;
80100c01:	c7 05 88 f9 10 80 3d 	movl   $0x80100a3d,0x8010f988
80100c08:	0a 10 80 
  cons.locking = 1;
80100c0b:	c7 05 34 c6 10 80 01 	movl   $0x1,0x8010c634
80100c12:	00 00 00 

  picenable(IRQ_KBD);
80100c15:	83 ec 0c             	sub    $0xc,%esp
80100c18:	6a 01                	push   $0x1
80100c1a:	e8 62 34 00 00       	call   80104081 <picenable>
80100c1f:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100c22:	83 ec 08             	sub    $0x8,%esp
80100c25:	6a 00                	push   $0x0
80100c27:	6a 01                	push   $0x1
80100c29:	e8 5a 23 00 00       	call   80102f88 <ioapicenable>
80100c2e:	83 c4 10             	add    $0x10,%esp
}
80100c31:	90                   	nop
80100c32:	c9                   	leave  
80100c33:	c3                   	ret    

80100c34 <clearScreen>:
//add_new_function------------------------------------------------------------

uint colors[17] = {0x0,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0xa,0xb,0xc,0xd,0xe,0xf};
  
// 清空屏幕，设置光标为(0, 0)。
void clearScreen(){
80100c34:	55                   	push   %ebp
80100c35:	89 e5                	mov    %esp,%ebp
80100c37:	83 ec 18             	sub    $0x18,%esp
  int pos = 0;
80100c3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  memset(crt, 0, sizeof(crt[0])*(25*80));
80100c41:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100c46:	83 ec 04             	sub    $0x4,%esp
80100c49:	68 a0 0f 00 00       	push   $0xfa0
80100c4e:	6a 00                	push   $0x0
80100c50:	50                   	push   %eax
80100c51:	e8 23 47 00 00       	call   80105379 <memset>
80100c56:	83 c4 10             	add    $0x10,%esp

  outb(CRTPORT, 14);
80100c59:	83 ec 08             	sub    $0x8,%esp
80100c5c:	6a 0e                	push   $0xe
80100c5e:	68 d4 03 00 00       	push   $0x3d4
80100c63:	e8 89 f6 ff ff       	call   801002f1 <outb>
80100c68:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100c6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100c6e:	c1 f8 08             	sar    $0x8,%eax
80100c71:	0f b6 c0             	movzbl %al,%eax
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	50                   	push   %eax
80100c78:	68 d5 03 00 00       	push   $0x3d5
80100c7d:	e8 6f f6 ff ff       	call   801002f1 <outb>
80100c82:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100c85:	83 ec 08             	sub    $0x8,%esp
80100c88:	6a 0f                	push   $0xf
80100c8a:	68 d4 03 00 00       	push   $0x3d4
80100c8f:	e8 5d f6 ff ff       	call   801002f1 <outb>
80100c94:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100c9a:	0f b6 c0             	movzbl %al,%eax
80100c9d:	83 ec 08             	sub    $0x8,%esp
80100ca0:	50                   	push   %eax
80100ca1:	68 d5 03 00 00       	push   $0x3d5
80100ca6:	e8 46 f6 ff ff       	call   801002f1 <outb>
80100cab:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;  //显示光标
80100cae:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100cb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100cb6:	01 d2                	add    %edx,%edx
80100cb8:	01 d0                	add    %edx,%eax
80100cba:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100cbf:	90                   	nop
80100cc0:	c9                   	leave  
80100cc1:	c3                   	ret    

80100cc2 <writeAt>:

// 在屏幕(x, y)处写入c，光标向后移动。
void writeAt(int x,int y,char c){
80100cc2:	55                   	push   %ebp
80100cc3:	89 e5                	mov    %esp,%ebp
80100cc5:	83 ec 18             	sub    $0x18,%esp
80100cc8:	8b 45 10             	mov    0x10(%ebp),%eax
80100ccb:	88 45 f4             	mov    %al,-0xc(%ebp)
    setCursorPos(x, y);
80100cce:	ff 75 0c             	pushl  0xc(%ebp)
80100cd1:	ff 75 08             	pushl  0x8(%ebp)
80100cd4:	e8 96 f9 ff ff       	call   8010066f <setCursorPos>
80100cd9:	83 c4 08             	add    $0x8,%esp
    cgaputc(c);
80100cdc:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
80100ce0:	83 ec 0c             	sub    $0xc,%esp
80100ce3:	50                   	push   %eax
80100ce4:	e8 11 fa ff ff       	call   801006fa <cgaputc>
80100ce9:	83 c4 10             	add    $0x10,%esp
}
80100cec:	90                   	nop
80100ced:	c9                   	leave  
80100cee:	c3                   	ret    

80100cef <saveScreen>:

void saveScreen(ushort *screen, int pos){ 
80100cef:	55                   	push   %ebp
80100cf0:	89 e5                	mov    %esp,%ebp
80100cf2:	83 ec 18             	sub    $0x18,%esp
  int size = pos*sizeof(crt[0]);
80100cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf8:	01 c0                	add    %eax,%eax
80100cfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(screen,crt,size);
80100cfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100d00:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100d05:	83 ec 04             	sub    $0x4,%esp
80100d08:	52                   	push   %edx
80100d09:	50                   	push   %eax
80100d0a:	ff 75 08             	pushl  0x8(%ebp)
80100d0d:	e8 26 47 00 00       	call   80105438 <memmove>
80100d12:	83 c4 10             	add    $0x10,%esp
}
80100d15:	90                   	nop
80100d16:	c9                   	leave  
80100d17:	c3                   	ret    

80100d18 <recorverScreen>:

void recorverScreen(ushort *screen, int pos){
80100d18:	55                   	push   %ebp
80100d19:	89 e5                	mov    %esp,%ebp
80100d1b:	53                   	push   %ebx
80100d1c:	83 ec 14             	sub    $0x14,%esp
  int size = pos*sizeof(crt[0]);
80100d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d22:	01 c0                	add    %eax,%eax
80100d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  clearScreen();
80100d27:	e8 08 ff ff ff       	call   80100c34 <clearScreen>
  memmove(crt, screen, size);
80100d2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100d2f:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80100d34:	83 ec 04             	sub    $0x4,%esp
80100d37:	52                   	push   %edx
80100d38:	ff 75 08             	pushl  0x8(%ebp)
80100d3b:	50                   	push   %eax
80100d3c:	e8 f7 46 00 00       	call   80105438 <memmove>
80100d41:	83 c4 10             	add    $0x10,%esp
  setCursorPos(pos/80,pos%80);
80100d44:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100d47:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100d4c:	89 d8                	mov    %ebx,%eax
80100d4e:	f7 ea                	imul   %edx
80100d50:	c1 fa 05             	sar    $0x5,%edx
80100d53:	89 d8                	mov    %ebx,%eax
80100d55:	c1 f8 1f             	sar    $0x1f,%eax
80100d58:	89 d1                	mov    %edx,%ecx
80100d5a:	29 c1                	sub    %eax,%ecx
80100d5c:	89 c8                	mov    %ecx,%eax
80100d5e:	c1 e0 02             	shl    $0x2,%eax
80100d61:	01 c8                	add    %ecx,%eax
80100d63:	c1 e0 04             	shl    $0x4,%eax
80100d66:	29 c3                	sub    %eax,%ebx
80100d68:	89 d9                	mov    %ebx,%ecx
80100d6a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100d6d:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100d72:	89 d8                	mov    %ebx,%eax
80100d74:	f7 ea                	imul   %edx
80100d76:	c1 fa 05             	sar    $0x5,%edx
80100d79:	89 d8                	mov    %ebx,%eax
80100d7b:	c1 f8 1f             	sar    $0x1f,%eax
80100d7e:	29 c2                	sub    %eax,%edx
80100d80:	89 d0                	mov    %edx,%eax
80100d82:	83 ec 08             	sub    $0x8,%esp
80100d85:	51                   	push   %ecx
80100d86:	50                   	push   %eax
80100d87:	e8 e3 f8 ff ff       	call   8010066f <setCursorPos>
80100d8c:	83 c4 10             	add    $0x10,%esp
}
80100d8f:	90                   	nop
80100d90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d93:	c9                   	leave  
80100d94:	c3                   	ret    

80100d95 <copyFromTextToScreen>:

// 将字符串text的len个字节（或是小于len的整个字符串）复制到显示器的相对位置pos后面，一直到屏幕末尾，不翻行。
// 要求： 0 <= pos < 25*80
void copyFromTextToScreen(char* text,int pos,int len,int color){
80100d95:	55                   	push   %ebp
80100d96:	89 e5                	mov    %esp,%ebp
80100d98:	53                   	push   %ebx
80100d99:	83 ec 14             	sub    $0x14,%esp
   char *p = text;
80100d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
   setCursorPos(pos/80,pos%80);
80100da2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100da5:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100daa:	89 d8                	mov    %ebx,%eax
80100dac:	f7 ea                	imul   %edx
80100dae:	c1 fa 05             	sar    $0x5,%edx
80100db1:	89 d8                	mov    %ebx,%eax
80100db3:	c1 f8 1f             	sar    $0x1f,%eax
80100db6:	89 d1                	mov    %edx,%ecx
80100db8:	29 c1                	sub    %eax,%ecx
80100dba:	89 c8                	mov    %ecx,%eax
80100dbc:	c1 e0 02             	shl    $0x2,%eax
80100dbf:	01 c8                	add    %ecx,%eax
80100dc1:	c1 e0 04             	shl    $0x4,%eax
80100dc4:	29 c3                	sub    %eax,%ebx
80100dc6:	89 d9                	mov    %ebx,%ecx
80100dc8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100dcb:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100dd0:	89 d8                	mov    %ebx,%eax
80100dd2:	f7 ea                	imul   %edx
80100dd4:	c1 fa 05             	sar    $0x5,%edx
80100dd7:	89 d8                	mov    %ebx,%eax
80100dd9:	c1 f8 1f             	sar    $0x1f,%eax
80100ddc:	29 c2                	sub    %eax,%edx
80100dde:	89 d0                	mov    %edx,%eax
80100de0:	51                   	push   %ecx
80100de1:	50                   	push   %eax
80100de2:	e8 88 f8 ff ff       	call   8010066f <setCursorPos>
80100de7:	83 c4 08             	add    $0x8,%esp
   int i;
   for(i=0;i<len&&*p!='\0';i++){
80100dea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80100df1:	eb 64                	jmp    80100e57 <copyFromTextToScreen+0xc2>
    uchar cc = getColor(colors[color], 0x0);
80100df3:	8b 45 14             	mov    0x14(%ebp),%eax
80100df6:	8b 04 85 20 a0 10 80 	mov    -0x7fef5fe0(,%eax,4),%eax
80100dfd:	0f b6 c0             	movzbl %al,%eax
80100e00:	83 ec 08             	sub    $0x8,%esp
80100e03:	6a 00                	push   $0x0
80100e05:	50                   	push   %eax
80100e06:	e8 50 01 00 00       	call   80100f5b <getColor>
80100e0b:	83 c4 10             	add    $0x10,%esp
80100e0e:	88 45 ef             	mov    %al,-0x11(%ebp)
    showC(*p,cc);
80100e11:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
80100e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e18:	0f b6 00             	movzbl (%eax),%eax
80100e1b:	0f be c0             	movsbl %al,%eax
80100e1e:	83 ec 08             	sub    $0x8,%esp
80100e21:	52                   	push   %edx
80100e22:	50                   	push   %eax
80100e23:	e8 56 01 00 00       	call   80100f7e <showC>
80100e28:	83 c4 10             	add    $0x10,%esp
    p++;
80100e2b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    pos = getCursorPos();
80100e2f:	e8 e9 f7 ff ff       	call   8010061d <getCursorPos>
80100e34:	89 45 0c             	mov    %eax,0xc(%ebp)
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
80100e37:	81 7d 0c cf 07 00 00 	cmpl   $0x7cf,0xc(%ebp)
80100e3e:	74 29                	je     80100e69 <copyFromTextToScreen+0xd4>
80100e40:	81 7d 0c 7f 07 00 00 	cmpl   $0x77f,0xc(%ebp)
80100e47:	7e 0a                	jle    80100e53 <copyFromTextToScreen+0xbe>
80100e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e4c:	0f b6 00             	movzbl (%eax),%eax
80100e4f:	3c 0a                	cmp    $0xa,%al
80100e51:	74 16                	je     80100e69 <copyFromTextToScreen+0xd4>
// 要求： 0 <= pos < 25*80
void copyFromTextToScreen(char* text,int pos,int len,int color){
   char *p = text;
   setCursorPos(pos/80,pos%80);
   int i;
   for(i=0;i<len&&*p!='\0';i++){
80100e53:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80100e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e5a:	3b 45 10             	cmp    0x10(%ebp),%eax
80100e5d:	7d 0a                	jge    80100e69 <copyFromTextToScreen+0xd4>
80100e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e62:	0f b6 00             	movzbl (%eax),%eax
80100e65:	84 c0                	test   %al,%al
80100e67:	75 8a                	jne    80100df3 <copyFromTextToScreen+0x5e>
    p++;
    pos = getCursorPos();
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
      break;
   }
}
80100e69:	90                   	nop
80100e6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e6d:	c9                   	leave  
80100e6e:	c3                   	ret    

80100e6f <ToScreen>:

void ToScreen(char* text,int pos,int len,int* color){
80100e6f:	55                   	push   %ebp
80100e70:	89 e5                	mov    %esp,%ebp
80100e72:	53                   	push   %ebx
80100e73:	83 ec 14             	sub    $0x14,%esp
   char *p = text;
80100e76:	8b 45 08             	mov    0x8(%ebp),%eax
80100e79:	89 45 f4             	mov    %eax,-0xc(%ebp)
   setCursorPos(pos/80,pos%80);
80100e7c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100e7f:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100e84:	89 d8                	mov    %ebx,%eax
80100e86:	f7 ea                	imul   %edx
80100e88:	c1 fa 05             	sar    $0x5,%edx
80100e8b:	89 d8                	mov    %ebx,%eax
80100e8d:	c1 f8 1f             	sar    $0x1f,%eax
80100e90:	89 d1                	mov    %edx,%ecx
80100e92:	29 c1                	sub    %eax,%ecx
80100e94:	89 c8                	mov    %ecx,%eax
80100e96:	c1 e0 02             	shl    $0x2,%eax
80100e99:	01 c8                	add    %ecx,%eax
80100e9b:	c1 e0 04             	shl    $0x4,%eax
80100e9e:	29 c3                	sub    %eax,%ebx
80100ea0:	89 d9                	mov    %ebx,%ecx
80100ea2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100ea5:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100eaa:	89 d8                	mov    %ebx,%eax
80100eac:	f7 ea                	imul   %edx
80100eae:	c1 fa 05             	sar    $0x5,%edx
80100eb1:	89 d8                	mov    %ebx,%eax
80100eb3:	c1 f8 1f             	sar    $0x1f,%eax
80100eb6:	29 c2                	sub    %eax,%edx
80100eb8:	89 d0                	mov    %edx,%eax
80100eba:	51                   	push   %ecx
80100ebb:	50                   	push   %eax
80100ebc:	e8 ae f7 ff ff       	call   8010066f <setCursorPos>
80100ec1:	83 c4 08             	add    $0x8,%esp
   int i;
   for(i=0;i<len&&*p!='\0';i++){
80100ec4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80100ecb:	eb 72                	jmp    80100f3f <ToScreen+0xd0>
    uchar cc = getColor(colors[color[i]], 0x0);
80100ecd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ed0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100ed7:	8b 45 14             	mov    0x14(%ebp),%eax
80100eda:	01 d0                	add    %edx,%eax
80100edc:	8b 00                	mov    (%eax),%eax
80100ede:	8b 04 85 20 a0 10 80 	mov    -0x7fef5fe0(,%eax,4),%eax
80100ee5:	0f b6 c0             	movzbl %al,%eax
80100ee8:	83 ec 08             	sub    $0x8,%esp
80100eeb:	6a 00                	push   $0x0
80100eed:	50                   	push   %eax
80100eee:	e8 68 00 00 00       	call   80100f5b <getColor>
80100ef3:	83 c4 10             	add    $0x10,%esp
80100ef6:	88 45 ef             	mov    %al,-0x11(%ebp)
    showC(*p,cc);
80100ef9:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
80100efd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f00:	0f b6 00             	movzbl (%eax),%eax
80100f03:	0f be c0             	movsbl %al,%eax
80100f06:	83 ec 08             	sub    $0x8,%esp
80100f09:	52                   	push   %edx
80100f0a:	50                   	push   %eax
80100f0b:	e8 6e 00 00 00       	call   80100f7e <showC>
80100f10:	83 c4 10             	add    $0x10,%esp
    p++;
80100f13:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    pos = getCursorPos();
80100f17:	e8 01 f7 ff ff       	call   8010061d <getCursorPos>
80100f1c:	89 45 0c             	mov    %eax,0xc(%ebp)
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
80100f1f:	81 7d 0c cf 07 00 00 	cmpl   $0x7cf,0xc(%ebp)
80100f26:	74 2d                	je     80100f55 <ToScreen+0xe6>
80100f28:	81 7d 0c 7f 07 00 00 	cmpl   $0x77f,0xc(%ebp)
80100f2f:	7e 0a                	jle    80100f3b <ToScreen+0xcc>
80100f31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f34:	0f b6 00             	movzbl (%eax),%eax
80100f37:	3c 0a                	cmp    $0xa,%al
80100f39:	74 1a                	je     80100f55 <ToScreen+0xe6>

void ToScreen(char* text,int pos,int len,int* color){
   char *p = text;
   setCursorPos(pos/80,pos%80);
   int i;
   for(i=0;i<len&&*p!='\0';i++){
80100f3b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80100f3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100f42:	3b 45 10             	cmp    0x10(%ebp),%eax
80100f45:	7d 0e                	jge    80100f55 <ToScreen+0xe6>
80100f47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f4a:	0f b6 00             	movzbl (%eax),%eax
80100f4d:	84 c0                	test   %al,%al
80100f4f:	0f 85 78 ff ff ff    	jne    80100ecd <ToScreen+0x5e>
    p++;
    pos = getCursorPos();
    if( (pos==25*80-1) || (pos>=24*80 && *p=='\n'))
      break;
   }
}
80100f55:	90                   	nop
80100f56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f59:	c9                   	leave  
80100f5a:	c3                   	ret    

80100f5b <getColor>:

uchar getColor(uchar tcolor, uchar bcolor){
80100f5b:	55                   	push   %ebp
80100f5c:	89 e5                	mov    %esp,%ebp
80100f5e:	83 ec 08             	sub    $0x8,%esp
80100f61:	8b 55 08             	mov    0x8(%ebp),%edx
80100f64:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f67:	88 55 fc             	mov    %dl,-0x4(%ebp)
80100f6a:	88 45 f8             	mov    %al,-0x8(%ebp)
  return (bcolor<<4) | tcolor;
80100f6d:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100f71:	c1 e0 04             	shl    $0x4,%eax
80100f74:	89 c2                	mov    %eax,%edx
80100f76:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
80100f7a:	09 d0                	or     %edx,%eax
}
80100f7c:	c9                   	leave  
80100f7d:	c3                   	ret    

80100f7e <showC>:

void showC(int c, uchar color){
80100f7e:	55                   	push   %ebp
80100f7f:	89 e5                	mov    %esp,%ebp
80100f81:	53                   	push   %ebx
80100f82:	83 ec 24             	sub    $0x24,%esp
80100f85:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f88:	88 45 e4             	mov    %al,-0x1c(%ebp)
  int pos;
  pos = getCursorPos();
80100f8b:	e8 8d f6 ff ff       	call   8010061d <getCursorPos>
80100f90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(c == '\n')
80100f93:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100f97:	75 30                	jne    80100fc9 <showC+0x4b>
    pos += 80 - pos%80;
80100f99:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100f9c:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100fa1:	89 c8                	mov    %ecx,%eax
80100fa3:	f7 ea                	imul   %edx
80100fa5:	c1 fa 05             	sar    $0x5,%edx
80100fa8:	89 c8                	mov    %ecx,%eax
80100faa:	c1 f8 1f             	sar    $0x1f,%eax
80100fad:	29 c2                	sub    %eax,%edx
80100faf:	89 d0                	mov    %edx,%eax
80100fb1:	c1 e0 02             	shl    $0x2,%eax
80100fb4:	01 d0                	add    %edx,%eax
80100fb6:	c1 e0 04             	shl    $0x4,%eax
80100fb9:	29 c1                	sub    %eax,%ecx
80100fbb:	89 ca                	mov    %ecx,%edx
80100fbd:	b8 50 00 00 00       	mov    $0x50,%eax
80100fc2:	29 d0                	sub    %edx,%eax
80100fc4:	01 45 f4             	add    %eax,-0xc(%ebp)
80100fc7:	eb 39                	jmp    80101002 <showC+0x84>
  else if(c == BACKSPACE){
80100fc9:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100fd0:	75 0c                	jne    80100fde <showC+0x60>
    if(pos > 0) --pos;
80100fd2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100fd6:	7e 2a                	jle    80101002 <showC+0x84>
80100fd8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100fdc:	eb 24                	jmp    80101002 <showC+0x84>
  } 
  else
    crt[pos++] = (c | (color<<8));  // black on white
80100fde:	8b 0d 08 a0 10 80    	mov    0x8010a008,%ecx
80100fe4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fe7:	8d 50 01             	lea    0x1(%eax),%edx
80100fea:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100fed:	01 c0                	add    %eax,%eax
80100fef:	01 c8                	add    %ecx,%eax
80100ff1:	0f b6 55 e4          	movzbl -0x1c(%ebp),%edx
80100ff5:	c1 e2 08             	shl    $0x8,%edx
80100ff8:	89 d1                	mov    %edx,%ecx
80100ffa:	8b 55 08             	mov    0x8(%ebp),%edx
80100ffd:	09 ca                	or     %ecx,%edx
80100fff:	66 89 10             	mov    %dx,(%eax)
  if((pos/80) >= 25){  // Scroll up.
80101002:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
80101009:	7e 4c                	jle    80101057 <showC+0xd9>
    memmove(crt, crt+80, sizeof(crt[0])*24*80);
8010100b:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80101010:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80101016:	a1 08 a0 10 80       	mov    0x8010a008,%eax
8010101b:	83 ec 04             	sub    $0x4,%esp
8010101e:	68 00 0f 00 00       	push   $0xf00
80101023:	52                   	push   %edx
80101024:	50                   	push   %eax
80101025:	e8 0e 44 00 00       	call   80105438 <memmove>
8010102a:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
8010102d:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(25*80 - pos));
80101031:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80101036:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101039:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010103c:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80101041:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80101044:	01 c9                	add    %ecx,%ecx
80101046:	01 c8                	add    %ecx,%eax
80101048:	83 ec 04             	sub    $0x4,%esp
8010104b:	52                   	push   %edx
8010104c:	6a 00                	push   $0x0
8010104e:	50                   	push   %eax
8010104f:	e8 25 43 00 00       	call   80105379 <memset>
80101054:	83 c4 10             	add    $0x10,%esp
  }

  setCursorPos(pos/80, pos%80);
80101057:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010105a:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010105f:	89 d8                	mov    %ebx,%eax
80101061:	f7 ea                	imul   %edx
80101063:	c1 fa 05             	sar    $0x5,%edx
80101066:	89 d8                	mov    %ebx,%eax
80101068:	c1 f8 1f             	sar    $0x1f,%eax
8010106b:	89 d1                	mov    %edx,%ecx
8010106d:	29 c1                	sub    %eax,%ecx
8010106f:	89 c8                	mov    %ecx,%eax
80101071:	c1 e0 02             	shl    $0x2,%eax
80101074:	01 c8                	add    %ecx,%eax
80101076:	c1 e0 04             	shl    $0x4,%eax
80101079:	29 c3                	sub    %eax,%ebx
8010107b:	89 d9                	mov    %ebx,%ecx
8010107d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101080:	ba 67 66 66 66       	mov    $0x66666667,%edx
80101085:	89 d8                	mov    %ebx,%eax
80101087:	f7 ea                	imul   %edx
80101089:	c1 fa 05             	sar    $0x5,%edx
8010108c:	89 d8                	mov    %ebx,%eax
8010108e:	c1 f8 1f             	sar    $0x1f,%eax
80101091:	29 c2                	sub    %eax,%edx
80101093:	89 d0                	mov    %edx,%eax
80101095:	83 ec 08             	sub    $0x8,%esp
80101098:	51                   	push   %ecx
80101099:	50                   	push   %eax
8010109a:	e8 d0 f5 ff ff       	call   8010066f <setCursorPos>
8010109f:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801010a2:	a1 08 a0 10 80       	mov    0x8010a008,%eax
801010a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801010aa:	01 d2                	add    %edx,%edx
801010ac:	01 d0                	add    %edx,%eax
801010ae:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801010b3:	90                   	nop
801010b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010b7:	c9                   	leave  
801010b8:	c3                   	ret    

801010b9 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801010b9:	55                   	push   %ebp
801010ba:	89 e5                	mov    %esp,%ebp
801010bc:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
801010c2:	83 ec 0c             	sub    $0xc,%esp
801010c5:	ff 75 08             	pushl  0x8(%ebp)
801010c8:	e8 45 19 00 00       	call   80102a12 <namei>
801010cd:	83 c4 10             	add    $0x10,%esp
801010d0:	89 45 d8             	mov    %eax,-0x28(%ebp)
801010d3:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801010d7:	75 0a                	jne    801010e3 <exec+0x2a>
    return -1;
801010d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010de:	e9 c4 03 00 00       	jmp    801014a7 <exec+0x3ee>
  ilock(ip);
801010e3:	83 ec 0c             	sub    $0xc,%esp
801010e6:	ff 75 d8             	pushl  -0x28(%ebp)
801010e9:	e8 6c 0d 00 00       	call   80101e5a <ilock>
801010ee:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
801010f1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
801010f8:	6a 34                	push   $0x34
801010fa:	6a 00                	push   $0x0
801010fc:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80101102:	50                   	push   %eax
80101103:	ff 75 d8             	pushl  -0x28(%ebp)
80101106:	e8 b7 12 00 00       	call   801023c2 <readi>
8010110b:	83 c4 10             	add    $0x10,%esp
8010110e:	83 f8 33             	cmp    $0x33,%eax
80101111:	0f 86 44 03 00 00    	jbe    8010145b <exec+0x3a2>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80101117:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010111d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80101122:	0f 85 36 03 00 00    	jne    8010145e <exec+0x3a5>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80101128:	e8 66 70 00 00       	call   80108193 <setupkvm>
8010112d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101130:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80101134:	0f 84 27 03 00 00    	je     80101461 <exec+0x3a8>
    goto bad;

  // Load program into memory.
  sz = 0;
8010113a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101141:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101148:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
8010114e:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101151:	e9 ab 00 00 00       	jmp    80101201 <exec+0x148>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101156:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101159:	6a 20                	push   $0x20
8010115b:	50                   	push   %eax
8010115c:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80101162:	50                   	push   %eax
80101163:	ff 75 d8             	pushl  -0x28(%ebp)
80101166:	e8 57 12 00 00       	call   801023c2 <readi>
8010116b:	83 c4 10             	add    $0x10,%esp
8010116e:	83 f8 20             	cmp    $0x20,%eax
80101171:	0f 85 ed 02 00 00    	jne    80101464 <exec+0x3ab>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101177:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
8010117d:	83 f8 01             	cmp    $0x1,%eax
80101180:	75 71                	jne    801011f3 <exec+0x13a>
      continue;
    if(ph.memsz < ph.filesz)
80101182:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80101188:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
8010118e:	39 c2                	cmp    %eax,%edx
80101190:	0f 82 d1 02 00 00    	jb     80101467 <exec+0x3ae>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101196:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
8010119c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
801011a2:	01 d0                	add    %edx,%eax
801011a4:	83 ec 04             	sub    $0x4,%esp
801011a7:	50                   	push   %eax
801011a8:	ff 75 e0             	pushl  -0x20(%ebp)
801011ab:	ff 75 d4             	pushl  -0x2c(%ebp)
801011ae:	e8 87 73 00 00       	call   8010853a <allocuvm>
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011b9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801011bd:	0f 84 a7 02 00 00    	je     8010146a <exec+0x3b1>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801011c3:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
801011c9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
801011cf:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
801011d5:	83 ec 0c             	sub    $0xc,%esp
801011d8:	52                   	push   %edx
801011d9:	50                   	push   %eax
801011da:	ff 75 d8             	pushl  -0x28(%ebp)
801011dd:	51                   	push   %ecx
801011de:	ff 75 d4             	pushl  -0x2c(%ebp)
801011e1:	e8 7d 72 00 00       	call   80108463 <loaduvm>
801011e6:	83 c4 20             	add    $0x20,%esp
801011e9:	85 c0                	test   %eax,%eax
801011eb:	0f 88 7c 02 00 00    	js     8010146d <exec+0x3b4>
801011f1:	eb 01                	jmp    801011f4 <exec+0x13b>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
801011f3:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801011f4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801011f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801011fb:	83 c0 20             	add    $0x20,%eax
801011fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101201:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80101208:	0f b7 c0             	movzwl %ax,%eax
8010120b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010120e:	0f 8f 42 ff ff ff    	jg     80101156 <exec+0x9d>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80101214:	83 ec 0c             	sub    $0xc,%esp
80101217:	ff 75 d8             	pushl  -0x28(%ebp)
8010121a:	e8 f5 0e 00 00       	call   80102114 <iunlockput>
8010121f:	83 c4 10             	add    $0x10,%esp
  ip = 0;
80101222:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101229:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010122c:	05 ff 0f 00 00       	add    $0xfff,%eax
80101231:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101236:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101239:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010123c:	05 00 20 00 00       	add    $0x2000,%eax
80101241:	83 ec 04             	sub    $0x4,%esp
80101244:	50                   	push   %eax
80101245:	ff 75 e0             	pushl  -0x20(%ebp)
80101248:	ff 75 d4             	pushl  -0x2c(%ebp)
8010124b:	e8 ea 72 00 00       	call   8010853a <allocuvm>
80101250:	83 c4 10             	add    $0x10,%esp
80101253:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101256:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010125a:	0f 84 10 02 00 00    	je     80101470 <exec+0x3b7>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101260:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101263:	2d 00 20 00 00       	sub    $0x2000,%eax
80101268:	83 ec 08             	sub    $0x8,%esp
8010126b:	50                   	push   %eax
8010126c:	ff 75 d4             	pushl  -0x2c(%ebp)
8010126f:	e8 ec 74 00 00       	call   80108760 <clearpteu>
80101274:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80101277:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010127a:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
8010127d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101284:	e9 96 00 00 00       	jmp    8010131f <exec+0x266>
    if(argc >= MAXARG)
80101289:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
8010128d:	0f 87 e0 01 00 00    	ja     80101473 <exec+0x3ba>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101293:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101296:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010129d:	8b 45 0c             	mov    0xc(%ebp),%eax
801012a0:	01 d0                	add    %edx,%eax
801012a2:	8b 00                	mov    (%eax),%eax
801012a4:	83 ec 0c             	sub    $0xc,%esp
801012a7:	50                   	push   %eax
801012a8:	e8 19 43 00 00       	call   801055c6 <strlen>
801012ad:	83 c4 10             	add    $0x10,%esp
801012b0:	89 c2                	mov    %eax,%edx
801012b2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012b5:	29 d0                	sub    %edx,%eax
801012b7:	83 e8 01             	sub    $0x1,%eax
801012ba:	83 e0 fc             	and    $0xfffffffc,%eax
801012bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801012c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801012ca:	8b 45 0c             	mov    0xc(%ebp),%eax
801012cd:	01 d0                	add    %edx,%eax
801012cf:	8b 00                	mov    (%eax),%eax
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	50                   	push   %eax
801012d5:	e8 ec 42 00 00       	call   801055c6 <strlen>
801012da:	83 c4 10             	add    $0x10,%esp
801012dd:	83 c0 01             	add    $0x1,%eax
801012e0:	89 c1                	mov    %eax,%ecx
801012e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801012ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801012ef:	01 d0                	add    %edx,%eax
801012f1:	8b 00                	mov    (%eax),%eax
801012f3:	51                   	push   %ecx
801012f4:	50                   	push   %eax
801012f5:	ff 75 dc             	pushl  -0x24(%ebp)
801012f8:	ff 75 d4             	pushl  -0x2c(%ebp)
801012fb:	e8 04 76 00 00       	call   80108904 <copyout>
80101300:	83 c4 10             	add    $0x10,%esp
80101303:	85 c0                	test   %eax,%eax
80101305:	0f 88 6b 01 00 00    	js     80101476 <exec+0x3bd>
      goto bad;
    ustack[3+argc] = sp;
8010130b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010130e:	8d 50 03             	lea    0x3(%eax),%edx
80101311:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101314:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
8010131b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010131f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101322:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101329:	8b 45 0c             	mov    0xc(%ebp),%eax
8010132c:	01 d0                	add    %edx,%eax
8010132e:	8b 00                	mov    (%eax),%eax
80101330:	85 c0                	test   %eax,%eax
80101332:	0f 85 51 ff ff ff    	jne    80101289 <exec+0x1d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80101338:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010133b:	83 c0 03             	add    $0x3,%eax
8010133e:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80101345:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101349:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80101350:	ff ff ff 
  ustack[1] = argc;
80101353:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101356:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010135c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010135f:	83 c0 01             	add    $0x1,%eax
80101362:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101369:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010136c:	29 d0                	sub    %edx,%eax
8010136e:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80101374:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101377:	83 c0 04             	add    $0x4,%eax
8010137a:	c1 e0 02             	shl    $0x2,%eax
8010137d:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101380:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101383:	83 c0 04             	add    $0x4,%eax
80101386:	c1 e0 02             	shl    $0x2,%eax
80101389:	50                   	push   %eax
8010138a:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80101390:	50                   	push   %eax
80101391:	ff 75 dc             	pushl  -0x24(%ebp)
80101394:	ff 75 d4             	pushl  -0x2c(%ebp)
80101397:	e8 68 75 00 00       	call   80108904 <copyout>
8010139c:	83 c4 10             	add    $0x10,%esp
8010139f:	85 c0                	test   %eax,%eax
801013a1:	0f 88 d2 00 00 00    	js     80101479 <exec+0x3c0>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801013a7:	8b 45 08             	mov    0x8(%ebp),%eax
801013aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
801013ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801013b3:	eb 17                	jmp    801013cc <exec+0x313>
    if(*s == '/')
801013b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b8:	0f b6 00             	movzbl (%eax),%eax
801013bb:	3c 2f                	cmp    $0x2f,%al
801013bd:	75 09                	jne    801013c8 <exec+0x30f>
      last = s+1;
801013bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c2:	83 c0 01             	add    $0x1,%eax
801013c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801013c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801013cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013cf:	0f b6 00             	movzbl (%eax),%eax
801013d2:	84 c0                	test   %al,%al
801013d4:	75 df                	jne    801013b5 <exec+0x2fc>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
801013d6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801013dc:	83 c0 6c             	add    $0x6c,%eax
801013df:	83 ec 04             	sub    $0x4,%esp
801013e2:	6a 10                	push   $0x10
801013e4:	ff 75 f0             	pushl  -0x10(%ebp)
801013e7:	50                   	push   %eax
801013e8:	e8 8f 41 00 00       	call   8010557c <safestrcpy>
801013ed:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
801013f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801013f6:	8b 40 04             	mov    0x4(%eax),%eax
801013f9:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
801013fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101402:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80101405:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80101408:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010140e:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101411:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80101413:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101419:	8b 40 18             	mov    0x18(%eax),%eax
8010141c:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80101422:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80101425:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010142b:	8b 40 18             	mov    0x18(%eax),%eax
8010142e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101431:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80101434:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010143a:	83 ec 0c             	sub    $0xc,%esp
8010143d:	50                   	push   %eax
8010143e:	e8 37 6e 00 00       	call   8010827a <switchuvm>
80101443:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80101446:	83 ec 0c             	sub    $0xc,%esp
80101449:	ff 75 d0             	pushl  -0x30(%ebp)
8010144c:	e8 6f 72 00 00       	call   801086c0 <freevm>
80101451:	83 c4 10             	add    $0x10,%esp
  return 0;
80101454:	b8 00 00 00 00       	mov    $0x0,%eax
80101459:	eb 4c                	jmp    801014a7 <exec+0x3ee>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
8010145b:	90                   	nop
8010145c:	eb 1c                	jmp    8010147a <exec+0x3c1>
  if(elf.magic != ELF_MAGIC)
    goto bad;
8010145e:	90                   	nop
8010145f:	eb 19                	jmp    8010147a <exec+0x3c1>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80101461:	90                   	nop
80101462:	eb 16                	jmp    8010147a <exec+0x3c1>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80101464:	90                   	nop
80101465:	eb 13                	jmp    8010147a <exec+0x3c1>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80101467:	90                   	nop
80101468:	eb 10                	jmp    8010147a <exec+0x3c1>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
8010146a:	90                   	nop
8010146b:	eb 0d                	jmp    8010147a <exec+0x3c1>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
8010146d:	90                   	nop
8010146e:	eb 0a                	jmp    8010147a <exec+0x3c1>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80101470:	90                   	nop
80101471:	eb 07                	jmp    8010147a <exec+0x3c1>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80101473:	90                   	nop
80101474:	eb 04                	jmp    8010147a <exec+0x3c1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80101476:	90                   	nop
80101477:	eb 01                	jmp    8010147a <exec+0x3c1>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80101479:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
8010147a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
8010147e:	74 0e                	je     8010148e <exec+0x3d5>
    freevm(pgdir);
80101480:	83 ec 0c             	sub    $0xc,%esp
80101483:	ff 75 d4             	pushl  -0x2c(%ebp)
80101486:	e8 35 72 00 00       	call   801086c0 <freevm>
8010148b:	83 c4 10             	add    $0x10,%esp
  if(ip)
8010148e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80101492:	74 0e                	je     801014a2 <exec+0x3e9>
    iunlockput(ip);
80101494:	83 ec 0c             	sub    $0xc,%esp
80101497:	ff 75 d8             	pushl  -0x28(%ebp)
8010149a:	e8 75 0c 00 00       	call   80102114 <iunlockput>
8010149f:	83 c4 10             	add    $0x10,%esp
  return -1;
801014a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801014a7:	c9                   	leave  
801014a8:	c3                   	ret    

801014a9 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801014a9:	55                   	push   %ebp
801014aa:	89 e5                	mov    %esp,%ebp
801014ac:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 31 94 10 80       	push   $0x80109431
801014b7:	68 e0 ef 10 80       	push   $0x8010efe0
801014bc:	e8 33 3c 00 00       	call   801050f4 <initlock>
801014c1:	83 c4 10             	add    $0x10,%esp
}
801014c4:	90                   	nop
801014c5:	c9                   	leave  
801014c6:	c3                   	ret    

801014c7 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801014c7:	55                   	push   %ebp
801014c8:	89 e5                	mov    %esp,%ebp
801014ca:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
801014cd:	83 ec 0c             	sub    $0xc,%esp
801014d0:	68 e0 ef 10 80       	push   $0x8010efe0
801014d5:	e8 3c 3c 00 00       	call   80105116 <acquire>
801014da:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801014dd:	c7 45 f4 14 f0 10 80 	movl   $0x8010f014,-0xc(%ebp)
801014e4:	eb 2d                	jmp    80101513 <filealloc+0x4c>
    if(f->ref == 0){
801014e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014e9:	8b 40 04             	mov    0x4(%eax),%eax
801014ec:	85 c0                	test   %eax,%eax
801014ee:	75 1f                	jne    8010150f <filealloc+0x48>
      f->ref = 1;
801014f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014f3:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
801014fa:	83 ec 0c             	sub    $0xc,%esp
801014fd:	68 e0 ef 10 80       	push   $0x8010efe0
80101502:	e8 76 3c 00 00       	call   8010517d <release>
80101507:	83 c4 10             	add    $0x10,%esp
      return f;
8010150a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010150d:	eb 23                	jmp    80101532 <filealloc+0x6b>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010150f:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101513:	b8 74 f9 10 80       	mov    $0x8010f974,%eax
80101518:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010151b:	72 c9                	jb     801014e6 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
8010151d:	83 ec 0c             	sub    $0xc,%esp
80101520:	68 e0 ef 10 80       	push   $0x8010efe0
80101525:	e8 53 3c 00 00       	call   8010517d <release>
8010152a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010152d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101532:	c9                   	leave  
80101533:	c3                   	ret    

80101534 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101534:	55                   	push   %ebp
80101535:	89 e5                	mov    %esp,%ebp
80101537:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
8010153a:	83 ec 0c             	sub    $0xc,%esp
8010153d:	68 e0 ef 10 80       	push   $0x8010efe0
80101542:	e8 cf 3b 00 00       	call   80105116 <acquire>
80101547:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010154a:	8b 45 08             	mov    0x8(%ebp),%eax
8010154d:	8b 40 04             	mov    0x4(%eax),%eax
80101550:	85 c0                	test   %eax,%eax
80101552:	7f 0d                	jg     80101561 <filedup+0x2d>
    panic("filedup");
80101554:	83 ec 0c             	sub    $0xc,%esp
80101557:	68 38 94 10 80       	push   $0x80109438
8010155c:	e8 21 f0 ff ff       	call   80100582 <panic>
  f->ref++;
80101561:	8b 45 08             	mov    0x8(%ebp),%eax
80101564:	8b 40 04             	mov    0x4(%eax),%eax
80101567:	8d 50 01             	lea    0x1(%eax),%edx
8010156a:	8b 45 08             	mov    0x8(%ebp),%eax
8010156d:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101570:	83 ec 0c             	sub    $0xc,%esp
80101573:	68 e0 ef 10 80       	push   $0x8010efe0
80101578:	e8 00 3c 00 00       	call   8010517d <release>
8010157d:	83 c4 10             	add    $0x10,%esp
  return f;
80101580:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101583:	c9                   	leave  
80101584:	c3                   	ret    

80101585 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101585:	55                   	push   %ebp
80101586:	89 e5                	mov    %esp,%ebp
80101588:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
8010158b:	83 ec 0c             	sub    $0xc,%esp
8010158e:	68 e0 ef 10 80       	push   $0x8010efe0
80101593:	e8 7e 3b 00 00       	call   80105116 <acquire>
80101598:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010159b:	8b 45 08             	mov    0x8(%ebp),%eax
8010159e:	8b 40 04             	mov    0x4(%eax),%eax
801015a1:	85 c0                	test   %eax,%eax
801015a3:	7f 0d                	jg     801015b2 <fileclose+0x2d>
    panic("fileclose");
801015a5:	83 ec 0c             	sub    $0xc,%esp
801015a8:	68 40 94 10 80       	push   $0x80109440
801015ad:	e8 d0 ef ff ff       	call   80100582 <panic>
  if(--f->ref > 0){
801015b2:	8b 45 08             	mov    0x8(%ebp),%eax
801015b5:	8b 40 04             	mov    0x4(%eax),%eax
801015b8:	8d 50 ff             	lea    -0x1(%eax),%edx
801015bb:	8b 45 08             	mov    0x8(%ebp),%eax
801015be:	89 50 04             	mov    %edx,0x4(%eax)
801015c1:	8b 45 08             	mov    0x8(%ebp),%eax
801015c4:	8b 40 04             	mov    0x4(%eax),%eax
801015c7:	85 c0                	test   %eax,%eax
801015c9:	7e 15                	jle    801015e0 <fileclose+0x5b>
    release(&ftable.lock);
801015cb:	83 ec 0c             	sub    $0xc,%esp
801015ce:	68 e0 ef 10 80       	push   $0x8010efe0
801015d3:	e8 a5 3b 00 00       	call   8010517d <release>
801015d8:	83 c4 10             	add    $0x10,%esp
801015db:	e9 8b 00 00 00       	jmp    8010166b <fileclose+0xe6>
    return;
  }
  ff = *f;
801015e0:	8b 45 08             	mov    0x8(%ebp),%eax
801015e3:	8b 10                	mov    (%eax),%edx
801015e5:	89 55 e0             	mov    %edx,-0x20(%ebp)
801015e8:	8b 50 04             	mov    0x4(%eax),%edx
801015eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801015ee:	8b 50 08             	mov    0x8(%eax),%edx
801015f1:	89 55 e8             	mov    %edx,-0x18(%ebp)
801015f4:	8b 50 0c             	mov    0xc(%eax),%edx
801015f7:	89 55 ec             	mov    %edx,-0x14(%ebp)
801015fa:	8b 50 10             	mov    0x10(%eax),%edx
801015fd:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101600:	8b 40 14             	mov    0x14(%eax),%eax
80101603:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101606:	8b 45 08             	mov    0x8(%ebp),%eax
80101609:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101610:	8b 45 08             	mov    0x8(%ebp),%eax
80101613:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101619:	83 ec 0c             	sub    $0xc,%esp
8010161c:	68 e0 ef 10 80       	push   $0x8010efe0
80101621:	e8 57 3b 00 00       	call   8010517d <release>
80101626:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
80101629:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010162c:	83 f8 01             	cmp    $0x1,%eax
8010162f:	75 19                	jne    8010164a <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
80101631:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101635:	0f be d0             	movsbl %al,%edx
80101638:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010163b:	83 ec 08             	sub    $0x8,%esp
8010163e:	52                   	push   %edx
8010163f:	50                   	push   %eax
80101640:	e8 a5 2c 00 00       	call   801042ea <pipeclose>
80101645:	83 c4 10             	add    $0x10,%esp
80101648:	eb 21                	jmp    8010166b <fileclose+0xe6>
  else if(ff.type == FD_INODE){
8010164a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010164d:	83 f8 02             	cmp    $0x2,%eax
80101650:	75 19                	jne    8010166b <fileclose+0xe6>
    begin_trans();
80101652:	e8 87 21 00 00       	call   801037de <begin_trans>
    iput(ff.ip);
80101657:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010165a:	83 ec 0c             	sub    $0xc,%esp
8010165d:	50                   	push   %eax
8010165e:	e8 c1 09 00 00       	call   80102024 <iput>
80101663:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101666:	e8 c6 21 00 00       	call   80103831 <commit_trans>
  }
}
8010166b:	c9                   	leave  
8010166c:	c3                   	ret    

8010166d <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010166d:	55                   	push   %ebp
8010166e:	89 e5                	mov    %esp,%ebp
80101670:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101673:	8b 45 08             	mov    0x8(%ebp),%eax
80101676:	8b 00                	mov    (%eax),%eax
80101678:	83 f8 02             	cmp    $0x2,%eax
8010167b:	75 40                	jne    801016bd <filestat+0x50>
    ilock(f->ip);
8010167d:	8b 45 08             	mov    0x8(%ebp),%eax
80101680:	8b 40 10             	mov    0x10(%eax),%eax
80101683:	83 ec 0c             	sub    $0xc,%esp
80101686:	50                   	push   %eax
80101687:	e8 ce 07 00 00       	call   80101e5a <ilock>
8010168c:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010168f:	8b 45 08             	mov    0x8(%ebp),%eax
80101692:	8b 40 10             	mov    0x10(%eax),%eax
80101695:	83 ec 08             	sub    $0x8,%esp
80101698:	ff 75 0c             	pushl  0xc(%ebp)
8010169b:	50                   	push   %eax
8010169c:	e8 db 0c 00 00       	call   8010237c <stati>
801016a1:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801016a4:	8b 45 08             	mov    0x8(%ebp),%eax
801016a7:	8b 40 10             	mov    0x10(%eax),%eax
801016aa:	83 ec 0c             	sub    $0xc,%esp
801016ad:	50                   	push   %eax
801016ae:	e8 ff 08 00 00       	call   80101fb2 <iunlock>
801016b3:	83 c4 10             	add    $0x10,%esp
    return 0;
801016b6:	b8 00 00 00 00       	mov    $0x0,%eax
801016bb:	eb 05                	jmp    801016c2 <filestat+0x55>
  }
  return -1;
801016bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801016c2:	c9                   	leave  
801016c3:	c3                   	ret    

801016c4 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801016c4:	55                   	push   %ebp
801016c5:	89 e5                	mov    %esp,%ebp
801016c7:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
801016ca:	8b 45 08             	mov    0x8(%ebp),%eax
801016cd:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801016d1:	84 c0                	test   %al,%al
801016d3:	75 0a                	jne    801016df <fileread+0x1b>
    return -1;
801016d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801016da:	e9 9b 00 00 00       	jmp    8010177a <fileread+0xb6>
  if(f->type == FD_PIPE)
801016df:	8b 45 08             	mov    0x8(%ebp),%eax
801016e2:	8b 00                	mov    (%eax),%eax
801016e4:	83 f8 01             	cmp    $0x1,%eax
801016e7:	75 1a                	jne    80101703 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
801016e9:	8b 45 08             	mov    0x8(%ebp),%eax
801016ec:	8b 40 0c             	mov    0xc(%eax),%eax
801016ef:	83 ec 04             	sub    $0x4,%esp
801016f2:	ff 75 10             	pushl  0x10(%ebp)
801016f5:	ff 75 0c             	pushl  0xc(%ebp)
801016f8:	50                   	push   %eax
801016f9:	e8 94 2d 00 00       	call   80104492 <piperead>
801016fe:	83 c4 10             	add    $0x10,%esp
80101701:	eb 77                	jmp    8010177a <fileread+0xb6>
  if(f->type == FD_INODE){
80101703:	8b 45 08             	mov    0x8(%ebp),%eax
80101706:	8b 00                	mov    (%eax),%eax
80101708:	83 f8 02             	cmp    $0x2,%eax
8010170b:	75 60                	jne    8010176d <fileread+0xa9>
    ilock(f->ip);
8010170d:	8b 45 08             	mov    0x8(%ebp),%eax
80101710:	8b 40 10             	mov    0x10(%eax),%eax
80101713:	83 ec 0c             	sub    $0xc,%esp
80101716:	50                   	push   %eax
80101717:	e8 3e 07 00 00       	call   80101e5a <ilock>
8010171c:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010171f:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101722:	8b 45 08             	mov    0x8(%ebp),%eax
80101725:	8b 50 14             	mov    0x14(%eax),%edx
80101728:	8b 45 08             	mov    0x8(%ebp),%eax
8010172b:	8b 40 10             	mov    0x10(%eax),%eax
8010172e:	51                   	push   %ecx
8010172f:	52                   	push   %edx
80101730:	ff 75 0c             	pushl  0xc(%ebp)
80101733:	50                   	push   %eax
80101734:	e8 89 0c 00 00       	call   801023c2 <readi>
80101739:	83 c4 10             	add    $0x10,%esp
8010173c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010173f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101743:	7e 11                	jle    80101756 <fileread+0x92>
      f->off += r;
80101745:	8b 45 08             	mov    0x8(%ebp),%eax
80101748:	8b 50 14             	mov    0x14(%eax),%edx
8010174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010174e:	01 c2                	add    %eax,%edx
80101750:	8b 45 08             	mov    0x8(%ebp),%eax
80101753:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101756:	8b 45 08             	mov    0x8(%ebp),%eax
80101759:	8b 40 10             	mov    0x10(%eax),%eax
8010175c:	83 ec 0c             	sub    $0xc,%esp
8010175f:	50                   	push   %eax
80101760:	e8 4d 08 00 00       	call   80101fb2 <iunlock>
80101765:	83 c4 10             	add    $0x10,%esp
    return r;
80101768:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010176b:	eb 0d                	jmp    8010177a <fileread+0xb6>
  }
  panic("fileread");
8010176d:	83 ec 0c             	sub    $0xc,%esp
80101770:	68 4a 94 10 80       	push   $0x8010944a
80101775:	e8 08 ee ff ff       	call   80100582 <panic>
}
8010177a:	c9                   	leave  
8010177b:	c3                   	ret    

8010177c <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
8010177c:	55                   	push   %ebp
8010177d:	89 e5                	mov    %esp,%ebp
8010177f:	53                   	push   %ebx
80101780:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101783:	8b 45 08             	mov    0x8(%ebp),%eax
80101786:	0f b6 40 09          	movzbl 0x9(%eax),%eax
8010178a:	84 c0                	test   %al,%al
8010178c:	75 0a                	jne    80101798 <filewrite+0x1c>
    return -1;
8010178e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101793:	e9 1b 01 00 00       	jmp    801018b3 <filewrite+0x137>
  if(f->type == FD_PIPE)
80101798:	8b 45 08             	mov    0x8(%ebp),%eax
8010179b:	8b 00                	mov    (%eax),%eax
8010179d:	83 f8 01             	cmp    $0x1,%eax
801017a0:	75 1d                	jne    801017bf <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
801017a2:	8b 45 08             	mov    0x8(%ebp),%eax
801017a5:	8b 40 0c             	mov    0xc(%eax),%eax
801017a8:	83 ec 04             	sub    $0x4,%esp
801017ab:	ff 75 10             	pushl  0x10(%ebp)
801017ae:	ff 75 0c             	pushl  0xc(%ebp)
801017b1:	50                   	push   %eax
801017b2:	e8 dd 2b 00 00       	call   80104394 <pipewrite>
801017b7:	83 c4 10             	add    $0x10,%esp
801017ba:	e9 f4 00 00 00       	jmp    801018b3 <filewrite+0x137>
  if(f->type == FD_INODE){
801017bf:	8b 45 08             	mov    0x8(%ebp),%eax
801017c2:	8b 00                	mov    (%eax),%eax
801017c4:	83 f8 02             	cmp    $0x2,%eax
801017c7:	0f 85 d9 00 00 00    	jne    801018a6 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801017cd:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
801017d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
801017db:	e9 a3 00 00 00       	jmp    80101883 <filewrite+0x107>
      int n1 = n - i;
801017e0:	8b 45 10             	mov    0x10(%ebp),%eax
801017e3:	2b 45 f4             	sub    -0xc(%ebp),%eax
801017e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
801017e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801017ef:	7e 06                	jle    801017f7 <filewrite+0x7b>
        n1 = max;
801017f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017f4:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
801017f7:	e8 e2 1f 00 00       	call   801037de <begin_trans>
      ilock(f->ip);
801017fc:	8b 45 08             	mov    0x8(%ebp),%eax
801017ff:	8b 40 10             	mov    0x10(%eax),%eax
80101802:	83 ec 0c             	sub    $0xc,%esp
80101805:	50                   	push   %eax
80101806:	e8 4f 06 00 00       	call   80101e5a <ilock>
8010180b:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010180e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101811:	8b 45 08             	mov    0x8(%ebp),%eax
80101814:	8b 50 14             	mov    0x14(%eax),%edx
80101817:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010181a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010181d:	01 c3                	add    %eax,%ebx
8010181f:	8b 45 08             	mov    0x8(%ebp),%eax
80101822:	8b 40 10             	mov    0x10(%eax),%eax
80101825:	51                   	push   %ecx
80101826:	52                   	push   %edx
80101827:	53                   	push   %ebx
80101828:	50                   	push   %eax
80101829:	e8 eb 0c 00 00       	call   80102519 <writei>
8010182e:	83 c4 10             	add    $0x10,%esp
80101831:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101834:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101838:	7e 11                	jle    8010184b <filewrite+0xcf>
        f->off += r;
8010183a:	8b 45 08             	mov    0x8(%ebp),%eax
8010183d:	8b 50 14             	mov    0x14(%eax),%edx
80101840:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101843:	01 c2                	add    %eax,%edx
80101845:	8b 45 08             	mov    0x8(%ebp),%eax
80101848:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010184b:	8b 45 08             	mov    0x8(%ebp),%eax
8010184e:	8b 40 10             	mov    0x10(%eax),%eax
80101851:	83 ec 0c             	sub    $0xc,%esp
80101854:	50                   	push   %eax
80101855:	e8 58 07 00 00       	call   80101fb2 <iunlock>
8010185a:	83 c4 10             	add    $0x10,%esp
      commit_trans();
8010185d:	e8 cf 1f 00 00       	call   80103831 <commit_trans>

      if(r < 0)
80101862:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101866:	78 29                	js     80101891 <filewrite+0x115>
        break;
      if(r != n1)
80101868:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010186b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010186e:	74 0d                	je     8010187d <filewrite+0x101>
        panic("short filewrite");
80101870:	83 ec 0c             	sub    $0xc,%esp
80101873:	68 53 94 10 80       	push   $0x80109453
80101878:	e8 05 ed ff ff       	call   80100582 <panic>
      i += r;
8010187d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101880:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101886:	3b 45 10             	cmp    0x10(%ebp),%eax
80101889:	0f 8c 51 ff ff ff    	jl     801017e0 <filewrite+0x64>
8010188f:	eb 01                	jmp    80101892 <filewrite+0x116>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
80101891:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101892:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101895:	3b 45 10             	cmp    0x10(%ebp),%eax
80101898:	75 05                	jne    8010189f <filewrite+0x123>
8010189a:	8b 45 10             	mov    0x10(%ebp),%eax
8010189d:	eb 14                	jmp    801018b3 <filewrite+0x137>
8010189f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801018a4:	eb 0d                	jmp    801018b3 <filewrite+0x137>
  }
  panic("filewrite");
801018a6:	83 ec 0c             	sub    $0xc,%esp
801018a9:	68 63 94 10 80       	push   $0x80109463
801018ae:	e8 cf ec ff ff       	call   80100582 <panic>
}
801018b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018b6:	c9                   	leave  
801018b7:	c3                   	ret    

801018b8 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801018b8:	55                   	push   %ebp
801018b9:	89 e5                	mov    %esp,%ebp
801018bb:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801018be:	8b 45 08             	mov    0x8(%ebp),%eax
801018c1:	83 ec 08             	sub    $0x8,%esp
801018c4:	6a 01                	push   $0x1
801018c6:	50                   	push   %eax
801018c7:	e8 ea e8 ff ff       	call   801001b6 <bread>
801018cc:	83 c4 10             	add    $0x10,%esp
801018cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
801018d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d5:	83 c0 18             	add    $0x18,%eax
801018d8:	83 ec 04             	sub    $0x4,%esp
801018db:	6a 10                	push   $0x10
801018dd:	50                   	push   %eax
801018de:	ff 75 0c             	pushl  0xc(%ebp)
801018e1:	e8 52 3b 00 00       	call   80105438 <memmove>
801018e6:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801018e9:	83 ec 0c             	sub    $0xc,%esp
801018ec:	ff 75 f4             	pushl  -0xc(%ebp)
801018ef:	e8 3a e9 ff ff       	call   8010022e <brelse>
801018f4:	83 c4 10             	add    $0x10,%esp
}
801018f7:	90                   	nop
801018f8:	c9                   	leave  
801018f9:	c3                   	ret    

801018fa <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801018fa:	55                   	push   %ebp
801018fb:	89 e5                	mov    %esp,%ebp
801018fd:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101900:	8b 55 0c             	mov    0xc(%ebp),%edx
80101903:	8b 45 08             	mov    0x8(%ebp),%eax
80101906:	83 ec 08             	sub    $0x8,%esp
80101909:	52                   	push   %edx
8010190a:	50                   	push   %eax
8010190b:	e8 a6 e8 ff ff       	call   801001b6 <bread>
80101910:	83 c4 10             	add    $0x10,%esp
80101913:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101919:	83 c0 18             	add    $0x18,%eax
8010191c:	83 ec 04             	sub    $0x4,%esp
8010191f:	68 00 02 00 00       	push   $0x200
80101924:	6a 00                	push   $0x0
80101926:	50                   	push   %eax
80101927:	e8 4d 3a 00 00       	call   80105379 <memset>
8010192c:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010192f:	83 ec 0c             	sub    $0xc,%esp
80101932:	ff 75 f4             	pushl  -0xc(%ebp)
80101935:	e8 5c 1f 00 00       	call   80103896 <log_write>
8010193a:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010193d:	83 ec 0c             	sub    $0xc,%esp
80101940:	ff 75 f4             	pushl  -0xc(%ebp)
80101943:	e8 e6 e8 ff ff       	call   8010022e <brelse>
80101948:	83 c4 10             	add    $0x10,%esp
}
8010194b:	90                   	nop
8010194c:	c9                   	leave  
8010194d:	c3                   	ret    

8010194e <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010194e:	55                   	push   %ebp
8010194f:	89 e5                	mov    %esp,%ebp
80101951:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101954:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
8010195b:	8b 45 08             	mov    0x8(%ebp),%eax
8010195e:	83 ec 08             	sub    $0x8,%esp
80101961:	8d 55 d8             	lea    -0x28(%ebp),%edx
80101964:	52                   	push   %edx
80101965:	50                   	push   %eax
80101966:	e8 4d ff ff ff       	call   801018b8 <readsb>
8010196b:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
8010196e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101975:	e9 15 01 00 00       	jmp    80101a8f <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
8010197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010197d:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101983:	85 c0                	test   %eax,%eax
80101985:	0f 48 c2             	cmovs  %edx,%eax
80101988:	c1 f8 0c             	sar    $0xc,%eax
8010198b:	89 c2                	mov    %eax,%edx
8010198d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101990:	c1 e8 03             	shr    $0x3,%eax
80101993:	01 d0                	add    %edx,%eax
80101995:	83 c0 03             	add    $0x3,%eax
80101998:	83 ec 08             	sub    $0x8,%esp
8010199b:	50                   	push   %eax
8010199c:	ff 75 08             	pushl  0x8(%ebp)
8010199f:	e8 12 e8 ff ff       	call   801001b6 <bread>
801019a4:	83 c4 10             	add    $0x10,%esp
801019a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801019aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801019b1:	e9 a6 00 00 00       	jmp    80101a5c <balloc+0x10e>
      m = 1 << (bi % 8);
801019b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b9:	99                   	cltd   
801019ba:	c1 ea 1d             	shr    $0x1d,%edx
801019bd:	01 d0                	add    %edx,%eax
801019bf:	83 e0 07             	and    $0x7,%eax
801019c2:	29 d0                	sub    %edx,%eax
801019c4:	ba 01 00 00 00       	mov    $0x1,%edx
801019c9:	89 c1                	mov    %eax,%ecx
801019cb:	d3 e2                	shl    %cl,%edx
801019cd:	89 d0                	mov    %edx,%eax
801019cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801019d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d5:	8d 50 07             	lea    0x7(%eax),%edx
801019d8:	85 c0                	test   %eax,%eax
801019da:	0f 48 c2             	cmovs  %edx,%eax
801019dd:	c1 f8 03             	sar    $0x3,%eax
801019e0:	89 c2                	mov    %eax,%edx
801019e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801019e5:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801019ea:	0f b6 c0             	movzbl %al,%eax
801019ed:	23 45 e8             	and    -0x18(%ebp),%eax
801019f0:	85 c0                	test   %eax,%eax
801019f2:	75 64                	jne    80101a58 <balloc+0x10a>
        bp->data[bi/8] |= m;  // Mark block in use.
801019f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f7:	8d 50 07             	lea    0x7(%eax),%edx
801019fa:	85 c0                	test   %eax,%eax
801019fc:	0f 48 c2             	cmovs  %edx,%eax
801019ff:	c1 f8 03             	sar    $0x3,%eax
80101a02:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101a05:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101a0a:	89 d1                	mov    %edx,%ecx
80101a0c:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101a0f:	09 ca                	or     %ecx,%edx
80101a11:	89 d1                	mov    %edx,%ecx
80101a13:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101a16:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101a1a:	83 ec 0c             	sub    $0xc,%esp
80101a1d:	ff 75 ec             	pushl  -0x14(%ebp)
80101a20:	e8 71 1e 00 00       	call   80103896 <log_write>
80101a25:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101a28:	83 ec 0c             	sub    $0xc,%esp
80101a2b:	ff 75 ec             	pushl  -0x14(%ebp)
80101a2e:	e8 fb e7 ff ff       	call   8010022e <brelse>
80101a33:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
80101a36:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a3c:	01 c2                	add    %eax,%edx
80101a3e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a41:	83 ec 08             	sub    $0x8,%esp
80101a44:	52                   	push   %edx
80101a45:	50                   	push   %eax
80101a46:	e8 af fe ff ff       	call   801018fa <bzero>
80101a4b:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101a4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a54:	01 d0                	add    %edx,%eax
80101a56:	eb 52                	jmp    80101aaa <balloc+0x15c>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101a58:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101a5c:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101a63:	7f 15                	jg     80101a7a <balloc+0x12c>
80101a65:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a6b:	01 d0                	add    %edx,%eax
80101a6d:	89 c2                	mov    %eax,%edx
80101a6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a72:	39 c2                	cmp    %eax,%edx
80101a74:	0f 82 3c ff ff ff    	jb     801019b6 <balloc+0x68>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101a7a:	83 ec 0c             	sub    $0xc,%esp
80101a7d:	ff 75 ec             	pushl  -0x14(%ebp)
80101a80:	e8 a9 e7 ff ff       	call   8010022e <brelse>
80101a85:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101a88:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101a8f:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a95:	39 c2                	cmp    %eax,%edx
80101a97:	0f 87 dd fe ff ff    	ja     8010197a <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101a9d:	83 ec 0c             	sub    $0xc,%esp
80101aa0:	68 6d 94 10 80       	push   $0x8010946d
80101aa5:	e8 d8 ea ff ff       	call   80100582 <panic>
}
80101aaa:	c9                   	leave  
80101aab:	c3                   	ret    

80101aac <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101aac:	55                   	push   %ebp
80101aad:	89 e5                	mov    %esp,%ebp
80101aaf:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
80101ab2:	83 ec 08             	sub    $0x8,%esp
80101ab5:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101ab8:	50                   	push   %eax
80101ab9:	ff 75 08             	pushl  0x8(%ebp)
80101abc:	e8 f7 fd ff ff       	call   801018b8 <readsb>
80101ac1:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101ac4:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ac7:	c1 e8 0c             	shr    $0xc,%eax
80101aca:	89 c2                	mov    %eax,%edx
80101acc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101acf:	c1 e8 03             	shr    $0x3,%eax
80101ad2:	01 d0                	add    %edx,%eax
80101ad4:	8d 50 03             	lea    0x3(%eax),%edx
80101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ada:	83 ec 08             	sub    $0x8,%esp
80101add:	52                   	push   %edx
80101ade:	50                   	push   %eax
80101adf:	e8 d2 e6 ff ff       	call   801001b6 <bread>
80101ae4:	83 c4 10             	add    $0x10,%esp
80101ae7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101aea:	8b 45 0c             	mov    0xc(%ebp),%eax
80101aed:	25 ff 0f 00 00       	and    $0xfff,%eax
80101af2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101af8:	99                   	cltd   
80101af9:	c1 ea 1d             	shr    $0x1d,%edx
80101afc:	01 d0                	add    %edx,%eax
80101afe:	83 e0 07             	and    $0x7,%eax
80101b01:	29 d0                	sub    %edx,%eax
80101b03:	ba 01 00 00 00       	mov    $0x1,%edx
80101b08:	89 c1                	mov    %eax,%ecx
80101b0a:	d3 e2                	shl    %cl,%edx
80101b0c:	89 d0                	mov    %edx,%eax
80101b0e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b14:	8d 50 07             	lea    0x7(%eax),%edx
80101b17:	85 c0                	test   %eax,%eax
80101b19:	0f 48 c2             	cmovs  %edx,%eax
80101b1c:	c1 f8 03             	sar    $0x3,%eax
80101b1f:	89 c2                	mov    %eax,%edx
80101b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b24:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101b29:	0f b6 c0             	movzbl %al,%eax
80101b2c:	23 45 ec             	and    -0x14(%ebp),%eax
80101b2f:	85 c0                	test   %eax,%eax
80101b31:	75 0d                	jne    80101b40 <bfree+0x94>
    panic("freeing free block");
80101b33:	83 ec 0c             	sub    $0xc,%esp
80101b36:	68 83 94 10 80       	push   $0x80109483
80101b3b:	e8 42 ea ff ff       	call   80100582 <panic>
  bp->data[bi/8] &= ~m;
80101b40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b43:	8d 50 07             	lea    0x7(%eax),%edx
80101b46:	85 c0                	test   %eax,%eax
80101b48:	0f 48 c2             	cmovs  %edx,%eax
80101b4b:	c1 f8 03             	sar    $0x3,%eax
80101b4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b51:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101b56:	89 d1                	mov    %edx,%ecx
80101b58:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b5b:	f7 d2                	not    %edx
80101b5d:	21 ca                	and    %ecx,%edx
80101b5f:	89 d1                	mov    %edx,%ecx
80101b61:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b64:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101b68:	83 ec 0c             	sub    $0xc,%esp
80101b6b:	ff 75 f4             	pushl  -0xc(%ebp)
80101b6e:	e8 23 1d 00 00       	call   80103896 <log_write>
80101b73:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101b76:	83 ec 0c             	sub    $0xc,%esp
80101b79:	ff 75 f4             	pushl  -0xc(%ebp)
80101b7c:	e8 ad e6 ff ff       	call   8010022e <brelse>
80101b81:	83 c4 10             	add    $0x10,%esp
}
80101b84:	90                   	nop
80101b85:	c9                   	leave  
80101b86:	c3                   	ret    

80101b87 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101b87:	55                   	push   %ebp
80101b88:	89 e5                	mov    %esp,%ebp
80101b8a:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
80101b8d:	83 ec 08             	sub    $0x8,%esp
80101b90:	68 96 94 10 80       	push   $0x80109496
80101b95:	68 e0 f9 10 80       	push   $0x8010f9e0
80101b9a:	e8 55 35 00 00       	call   801050f4 <initlock>
80101b9f:	83 c4 10             	add    $0x10,%esp
}
80101ba2:	90                   	nop
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    

80101ba5 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101ba5:	55                   	push   %ebp
80101ba6:	89 e5                	mov    %esp,%ebp
80101ba8:	83 ec 38             	sub    $0x38,%esp
80101bab:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bae:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
80101bb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb5:	83 ec 08             	sub    $0x8,%esp
80101bb8:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101bbb:	52                   	push   %edx
80101bbc:	50                   	push   %eax
80101bbd:	e8 f6 fc ff ff       	call   801018b8 <readsb>
80101bc2:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
80101bc5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101bcc:	e9 98 00 00 00       	jmp    80101c69 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
80101bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bd4:	c1 e8 03             	shr    $0x3,%eax
80101bd7:	83 c0 02             	add    $0x2,%eax
80101bda:	83 ec 08             	sub    $0x8,%esp
80101bdd:	50                   	push   %eax
80101bde:	ff 75 08             	pushl  0x8(%ebp)
80101be1:	e8 d0 e5 ff ff       	call   801001b6 <bread>
80101be6:	83 c4 10             	add    $0x10,%esp
80101be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bef:	8d 50 18             	lea    0x18(%eax),%edx
80101bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bf5:	83 e0 07             	and    $0x7,%eax
80101bf8:	c1 e0 06             	shl    $0x6,%eax
80101bfb:	01 d0                	add    %edx,%eax
80101bfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101c00:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c03:	0f b7 00             	movzwl (%eax),%eax
80101c06:	66 85 c0             	test   %ax,%ax
80101c09:	75 4c                	jne    80101c57 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
80101c0b:	83 ec 04             	sub    $0x4,%esp
80101c0e:	6a 40                	push   $0x40
80101c10:	6a 00                	push   $0x0
80101c12:	ff 75 ec             	pushl  -0x14(%ebp)
80101c15:	e8 5f 37 00 00       	call   80105379 <memset>
80101c1a:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101c1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c20:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101c24:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101c27:	83 ec 0c             	sub    $0xc,%esp
80101c2a:	ff 75 f0             	pushl  -0x10(%ebp)
80101c2d:	e8 64 1c 00 00       	call   80103896 <log_write>
80101c32:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101c35:	83 ec 0c             	sub    $0xc,%esp
80101c38:	ff 75 f0             	pushl  -0x10(%ebp)
80101c3b:	e8 ee e5 ff ff       	call   8010022e <brelse>
80101c40:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c46:	83 ec 08             	sub    $0x8,%esp
80101c49:	50                   	push   %eax
80101c4a:	ff 75 08             	pushl  0x8(%ebp)
80101c4d:	e8 ef 00 00 00       	call   80101d41 <iget>
80101c52:	83 c4 10             	add    $0x10,%esp
80101c55:	eb 2d                	jmp    80101c84 <ialloc+0xdf>
    }
    brelse(bp);
80101c57:	83 ec 0c             	sub    $0xc,%esp
80101c5a:	ff 75 f0             	pushl  -0x10(%ebp)
80101c5d:	e8 cc e5 ff ff       	call   8010022e <brelse>
80101c62:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101c65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101c69:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c6f:	39 c2                	cmp    %eax,%edx
80101c71:	0f 87 5a ff ff ff    	ja     80101bd1 <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101c77:	83 ec 0c             	sub    $0xc,%esp
80101c7a:	68 9d 94 10 80       	push   $0x8010949d
80101c7f:	e8 fe e8 ff ff       	call   80100582 <panic>
}
80101c84:	c9                   	leave  
80101c85:	c3                   	ret    

80101c86 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101c86:	55                   	push   %ebp
80101c87:	89 e5                	mov    %esp,%ebp
80101c89:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101c8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8f:	8b 40 04             	mov    0x4(%eax),%eax
80101c92:	c1 e8 03             	shr    $0x3,%eax
80101c95:	8d 50 02             	lea    0x2(%eax),%edx
80101c98:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9b:	8b 00                	mov    (%eax),%eax
80101c9d:	83 ec 08             	sub    $0x8,%esp
80101ca0:	52                   	push   %edx
80101ca1:	50                   	push   %eax
80101ca2:	e8 0f e5 ff ff       	call   801001b6 <bread>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cb0:	8d 50 18             	lea    0x18(%eax),%edx
80101cb3:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb6:	8b 40 04             	mov    0x4(%eax),%eax
80101cb9:	83 e0 07             	and    $0x7,%eax
80101cbc:	c1 e0 06             	shl    $0x6,%eax
80101cbf:	01 d0                	add    %edx,%eax
80101cc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101cc4:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc7:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101ccb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cce:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101cd1:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd4:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cdb:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101cdf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce2:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101ce6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ce9:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101ced:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf0:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cf7:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101cfb:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfe:	8b 50 18             	mov    0x18(%eax),%edx
80101d01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d04:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101d07:	8b 45 08             	mov    0x8(%ebp),%eax
80101d0a:	8d 50 1c             	lea    0x1c(%eax),%edx
80101d0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d10:	83 c0 0c             	add    $0xc,%eax
80101d13:	83 ec 04             	sub    $0x4,%esp
80101d16:	6a 34                	push   $0x34
80101d18:	52                   	push   %edx
80101d19:	50                   	push   %eax
80101d1a:	e8 19 37 00 00       	call   80105438 <memmove>
80101d1f:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101d22:	83 ec 0c             	sub    $0xc,%esp
80101d25:	ff 75 f4             	pushl  -0xc(%ebp)
80101d28:	e8 69 1b 00 00       	call   80103896 <log_write>
80101d2d:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101d30:	83 ec 0c             	sub    $0xc,%esp
80101d33:	ff 75 f4             	pushl  -0xc(%ebp)
80101d36:	e8 f3 e4 ff ff       	call   8010022e <brelse>
80101d3b:	83 c4 10             	add    $0x10,%esp
}
80101d3e:	90                   	nop
80101d3f:	c9                   	leave  
80101d40:	c3                   	ret    

80101d41 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101d41:	55                   	push   %ebp
80101d42:	89 e5                	mov    %esp,%ebp
80101d44:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101d47:	83 ec 0c             	sub    $0xc,%esp
80101d4a:	68 e0 f9 10 80       	push   $0x8010f9e0
80101d4f:	e8 c2 33 00 00       	call   80105116 <acquire>
80101d54:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101d57:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101d5e:	c7 45 f4 14 fa 10 80 	movl   $0x8010fa14,-0xc(%ebp)
80101d65:	eb 5d                	jmp    80101dc4 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101d67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d6a:	8b 40 08             	mov    0x8(%eax),%eax
80101d6d:	85 c0                	test   %eax,%eax
80101d6f:	7e 39                	jle    80101daa <iget+0x69>
80101d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d74:	8b 00                	mov    (%eax),%eax
80101d76:	3b 45 08             	cmp    0x8(%ebp),%eax
80101d79:	75 2f                	jne    80101daa <iget+0x69>
80101d7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d7e:	8b 40 04             	mov    0x4(%eax),%eax
80101d81:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101d84:	75 24                	jne    80101daa <iget+0x69>
      ip->ref++;
80101d86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d89:	8b 40 08             	mov    0x8(%eax),%eax
80101d8c:	8d 50 01             	lea    0x1(%eax),%edx
80101d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d92:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101d95:	83 ec 0c             	sub    $0xc,%esp
80101d98:	68 e0 f9 10 80       	push   $0x8010f9e0
80101d9d:	e8 db 33 00 00       	call   8010517d <release>
80101da2:	83 c4 10             	add    $0x10,%esp
      return ip;
80101da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101da8:	eb 74                	jmp    80101e1e <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101daa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101dae:	75 10                	jne    80101dc0 <iget+0x7f>
80101db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101db3:	8b 40 08             	mov    0x8(%eax),%eax
80101db6:	85 c0                	test   %eax,%eax
80101db8:	75 06                	jne    80101dc0 <iget+0x7f>
      empty = ip;
80101dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101dc0:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101dc4:	81 7d f4 b4 09 11 80 	cmpl   $0x801109b4,-0xc(%ebp)
80101dcb:	72 9a                	jb     80101d67 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101dcd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101dd1:	75 0d                	jne    80101de0 <iget+0x9f>
    panic("iget: no inodes");
80101dd3:	83 ec 0c             	sub    $0xc,%esp
80101dd6:	68 af 94 10 80       	push   $0x801094af
80101ddb:	e8 a2 e7 ff ff       	call   80100582 <panic>

  ip = empty;
80101de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101de3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101de9:	8b 55 08             	mov    0x8(%ebp),%edx
80101dec:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101dee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101df1:	8b 55 0c             	mov    0xc(%ebp),%edx
80101df4:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101dfa:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e04:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101e0b:	83 ec 0c             	sub    $0xc,%esp
80101e0e:	68 e0 f9 10 80       	push   $0x8010f9e0
80101e13:	e8 65 33 00 00       	call   8010517d <release>
80101e18:	83 c4 10             	add    $0x10,%esp

  return ip;
80101e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101e1e:	c9                   	leave  
80101e1f:	c3                   	ret    

80101e20 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101e26:	83 ec 0c             	sub    $0xc,%esp
80101e29:	68 e0 f9 10 80       	push   $0x8010f9e0
80101e2e:	e8 e3 32 00 00       	call   80105116 <acquire>
80101e33:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101e36:	8b 45 08             	mov    0x8(%ebp),%eax
80101e39:	8b 40 08             	mov    0x8(%eax),%eax
80101e3c:	8d 50 01             	lea    0x1(%eax),%edx
80101e3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e42:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101e45:	83 ec 0c             	sub    $0xc,%esp
80101e48:	68 e0 f9 10 80       	push   $0x8010f9e0
80101e4d:	e8 2b 33 00 00       	call   8010517d <release>
80101e52:	83 c4 10             	add    $0x10,%esp
  return ip;
80101e55:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101e58:	c9                   	leave  
80101e59:	c3                   	ret    

80101e5a <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101e5a:	55                   	push   %ebp
80101e5b:	89 e5                	mov    %esp,%ebp
80101e5d:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101e60:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101e64:	74 0a                	je     80101e70 <ilock+0x16>
80101e66:	8b 45 08             	mov    0x8(%ebp),%eax
80101e69:	8b 40 08             	mov    0x8(%eax),%eax
80101e6c:	85 c0                	test   %eax,%eax
80101e6e:	7f 0d                	jg     80101e7d <ilock+0x23>
    panic("ilock");
80101e70:	83 ec 0c             	sub    $0xc,%esp
80101e73:	68 bf 94 10 80       	push   $0x801094bf
80101e78:	e8 05 e7 ff ff       	call   80100582 <panic>

  acquire(&icache.lock);
80101e7d:	83 ec 0c             	sub    $0xc,%esp
80101e80:	68 e0 f9 10 80       	push   $0x8010f9e0
80101e85:	e8 8c 32 00 00       	call   80105116 <acquire>
80101e8a:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80101e8d:	eb 13                	jmp    80101ea2 <ilock+0x48>
    sleep(ip, &icache.lock);
80101e8f:	83 ec 08             	sub    $0x8,%esp
80101e92:	68 e0 f9 10 80       	push   $0x8010f9e0
80101e97:	ff 75 08             	pushl  0x8(%ebp)
80101e9a:	e8 7e 2f 00 00       	call   80104e1d <sleep>
80101e9f:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101ea2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea5:	8b 40 0c             	mov    0xc(%eax),%eax
80101ea8:	83 e0 01             	and    $0x1,%eax
80101eab:	85 c0                	test   %eax,%eax
80101ead:	75 e0                	jne    80101e8f <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101eaf:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb2:	8b 40 0c             	mov    0xc(%eax),%eax
80101eb5:	83 c8 01             	or     $0x1,%eax
80101eb8:	89 c2                	mov    %eax,%edx
80101eba:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebd:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	68 e0 f9 10 80       	push   $0x8010f9e0
80101ec8:	e8 b0 32 00 00       	call   8010517d <release>
80101ecd:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed3:	8b 40 0c             	mov    0xc(%eax),%eax
80101ed6:	83 e0 02             	and    $0x2,%eax
80101ed9:	85 c0                	test   %eax,%eax
80101edb:	0f 85 ce 00 00 00    	jne    80101faf <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee4:	8b 40 04             	mov    0x4(%eax),%eax
80101ee7:	c1 e8 03             	shr    $0x3,%eax
80101eea:	8d 50 02             	lea    0x2(%eax),%edx
80101eed:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef0:	8b 00                	mov    (%eax),%eax
80101ef2:	83 ec 08             	sub    $0x8,%esp
80101ef5:	52                   	push   %edx
80101ef6:	50                   	push   %eax
80101ef7:	e8 ba e2 ff ff       	call   801001b6 <bread>
80101efc:	83 c4 10             	add    $0x10,%esp
80101eff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101f02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f05:	8d 50 18             	lea    0x18(%eax),%edx
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8b 40 04             	mov    0x4(%eax),%eax
80101f0e:	83 e0 07             	and    $0x7,%eax
80101f11:	c1 e0 06             	shl    $0x6,%eax
80101f14:	01 d0                	add    %edx,%eax
80101f16:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f1c:	0f b7 10             	movzwl (%eax),%edx
80101f1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f22:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101f26:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f29:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101f2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f30:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101f34:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f37:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101f3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3e:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101f42:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f45:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101f49:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4c:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101f50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f53:	8b 50 08             	mov    0x8(%eax),%edx
80101f56:	8b 45 08             	mov    0x8(%ebp),%eax
80101f59:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101f5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f5f:	8d 50 0c             	lea    0xc(%eax),%edx
80101f62:	8b 45 08             	mov    0x8(%ebp),%eax
80101f65:	83 c0 1c             	add    $0x1c,%eax
80101f68:	83 ec 04             	sub    $0x4,%esp
80101f6b:	6a 34                	push   $0x34
80101f6d:	52                   	push   %edx
80101f6e:	50                   	push   %eax
80101f6f:	e8 c4 34 00 00       	call   80105438 <memmove>
80101f74:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f77:	83 ec 0c             	sub    $0xc,%esp
80101f7a:	ff 75 f4             	pushl  -0xc(%ebp)
80101f7d:	e8 ac e2 ff ff       	call   8010022e <brelse>
80101f82:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101f85:	8b 45 08             	mov    0x8(%ebp),%eax
80101f88:	8b 40 0c             	mov    0xc(%eax),%eax
80101f8b:	83 c8 02             	or     $0x2,%eax
80101f8e:	89 c2                	mov    %eax,%edx
80101f90:	8b 45 08             	mov    0x8(%ebp),%eax
80101f93:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101f96:	8b 45 08             	mov    0x8(%ebp),%eax
80101f99:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101f9d:	66 85 c0             	test   %ax,%ax
80101fa0:	75 0d                	jne    80101faf <ilock+0x155>
      panic("ilock: no type");
80101fa2:	83 ec 0c             	sub    $0xc,%esp
80101fa5:	68 c5 94 10 80       	push   $0x801094c5
80101faa:	e8 d3 e5 ff ff       	call   80100582 <panic>
  }
}
80101faf:	90                   	nop
80101fb0:	c9                   	leave  
80101fb1:	c3                   	ret    

80101fb2 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101fb2:	55                   	push   %ebp
80101fb3:	89 e5                	mov    %esp,%ebp
80101fb5:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101fb8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101fbc:	74 17                	je     80101fd5 <iunlock+0x23>
80101fbe:	8b 45 08             	mov    0x8(%ebp),%eax
80101fc1:	8b 40 0c             	mov    0xc(%eax),%eax
80101fc4:	83 e0 01             	and    $0x1,%eax
80101fc7:	85 c0                	test   %eax,%eax
80101fc9:	74 0a                	je     80101fd5 <iunlock+0x23>
80101fcb:	8b 45 08             	mov    0x8(%ebp),%eax
80101fce:	8b 40 08             	mov    0x8(%eax),%eax
80101fd1:	85 c0                	test   %eax,%eax
80101fd3:	7f 0d                	jg     80101fe2 <iunlock+0x30>
    panic("iunlock");
80101fd5:	83 ec 0c             	sub    $0xc,%esp
80101fd8:	68 d4 94 10 80       	push   $0x801094d4
80101fdd:	e8 a0 e5 ff ff       	call   80100582 <panic>

  acquire(&icache.lock);
80101fe2:	83 ec 0c             	sub    $0xc,%esp
80101fe5:	68 e0 f9 10 80       	push   $0x8010f9e0
80101fea:	e8 27 31 00 00       	call   80105116 <acquire>
80101fef:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101ff2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff5:	8b 40 0c             	mov    0xc(%eax),%eax
80101ff8:	83 e0 fe             	and    $0xfffffffe,%eax
80101ffb:	89 c2                	mov    %eax,%edx
80101ffd:	8b 45 08             	mov    0x8(%ebp),%eax
80102000:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80102003:	83 ec 0c             	sub    $0xc,%esp
80102006:	ff 75 08             	pushl  0x8(%ebp)
80102009:	e8 fa 2e 00 00       	call   80104f08 <wakeup>
8010200e:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80102011:	83 ec 0c             	sub    $0xc,%esp
80102014:	68 e0 f9 10 80       	push   $0x8010f9e0
80102019:	e8 5f 31 00 00       	call   8010517d <release>
8010201e:	83 c4 10             	add    $0x10,%esp
}
80102021:	90                   	nop
80102022:	c9                   	leave  
80102023:	c3                   	ret    

80102024 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80102024:	55                   	push   %ebp
80102025:	89 e5                	mov    %esp,%ebp
80102027:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
8010202a:	83 ec 0c             	sub    $0xc,%esp
8010202d:	68 e0 f9 10 80       	push   $0x8010f9e0
80102032:	e8 df 30 00 00       	call   80105116 <acquire>
80102037:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
8010203a:	8b 45 08             	mov    0x8(%ebp),%eax
8010203d:	8b 40 08             	mov    0x8(%eax),%eax
80102040:	83 f8 01             	cmp    $0x1,%eax
80102043:	0f 85 a9 00 00 00    	jne    801020f2 <iput+0xce>
80102049:	8b 45 08             	mov    0x8(%ebp),%eax
8010204c:	8b 40 0c             	mov    0xc(%eax),%eax
8010204f:	83 e0 02             	and    $0x2,%eax
80102052:	85 c0                	test   %eax,%eax
80102054:	0f 84 98 00 00 00    	je     801020f2 <iput+0xce>
8010205a:	8b 45 08             	mov    0x8(%ebp),%eax
8010205d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80102061:	66 85 c0             	test   %ax,%ax
80102064:	0f 85 88 00 00 00    	jne    801020f2 <iput+0xce>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
8010206a:	8b 45 08             	mov    0x8(%ebp),%eax
8010206d:	8b 40 0c             	mov    0xc(%eax),%eax
80102070:	83 e0 01             	and    $0x1,%eax
80102073:	85 c0                	test   %eax,%eax
80102075:	74 0d                	je     80102084 <iput+0x60>
      panic("iput busy");
80102077:	83 ec 0c             	sub    $0xc,%esp
8010207a:	68 dc 94 10 80       	push   $0x801094dc
8010207f:	e8 fe e4 ff ff       	call   80100582 <panic>
    ip->flags |= I_BUSY;
80102084:	8b 45 08             	mov    0x8(%ebp),%eax
80102087:	8b 40 0c             	mov    0xc(%eax),%eax
8010208a:	83 c8 01             	or     $0x1,%eax
8010208d:	89 c2                	mov    %eax,%edx
8010208f:	8b 45 08             	mov    0x8(%ebp),%eax
80102092:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80102095:	83 ec 0c             	sub    $0xc,%esp
80102098:	68 e0 f9 10 80       	push   $0x8010f9e0
8010209d:	e8 db 30 00 00       	call   8010517d <release>
801020a2:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
801020a5:	83 ec 0c             	sub    $0xc,%esp
801020a8:	ff 75 08             	pushl  0x8(%ebp)
801020ab:	e8 a8 01 00 00       	call   80102258 <itrunc>
801020b0:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
801020b3:	8b 45 08             	mov    0x8(%ebp),%eax
801020b6:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
801020bc:	83 ec 0c             	sub    $0xc,%esp
801020bf:	ff 75 08             	pushl  0x8(%ebp)
801020c2:	e8 bf fb ff ff       	call   80101c86 <iupdate>
801020c7:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
801020ca:	83 ec 0c             	sub    $0xc,%esp
801020cd:	68 e0 f9 10 80       	push   $0x8010f9e0
801020d2:	e8 3f 30 00 00       	call   80105116 <acquire>
801020d7:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
801020da:	8b 45 08             	mov    0x8(%ebp),%eax
801020dd:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
801020e4:	83 ec 0c             	sub    $0xc,%esp
801020e7:	ff 75 08             	pushl  0x8(%ebp)
801020ea:	e8 19 2e 00 00       	call   80104f08 <wakeup>
801020ef:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
801020f2:	8b 45 08             	mov    0x8(%ebp),%eax
801020f5:	8b 40 08             	mov    0x8(%eax),%eax
801020f8:	8d 50 ff             	lea    -0x1(%eax),%edx
801020fb:	8b 45 08             	mov    0x8(%ebp),%eax
801020fe:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80102101:	83 ec 0c             	sub    $0xc,%esp
80102104:	68 e0 f9 10 80       	push   $0x8010f9e0
80102109:	e8 6f 30 00 00       	call   8010517d <release>
8010210e:	83 c4 10             	add    $0x10,%esp
}
80102111:	90                   	nop
80102112:	c9                   	leave  
80102113:	c3                   	ret    

80102114 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80102114:	55                   	push   %ebp
80102115:	89 e5                	mov    %esp,%ebp
80102117:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
8010211a:	83 ec 0c             	sub    $0xc,%esp
8010211d:	ff 75 08             	pushl  0x8(%ebp)
80102120:	e8 8d fe ff ff       	call   80101fb2 <iunlock>
80102125:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80102128:	83 ec 0c             	sub    $0xc,%esp
8010212b:	ff 75 08             	pushl  0x8(%ebp)
8010212e:	e8 f1 fe ff ff       	call   80102024 <iput>
80102133:	83 c4 10             	add    $0x10,%esp
}
80102136:	90                   	nop
80102137:	c9                   	leave  
80102138:	c3                   	ret    

80102139 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102139:	55                   	push   %ebp
8010213a:	89 e5                	mov    %esp,%ebp
8010213c:	53                   	push   %ebx
8010213d:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80102140:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80102144:	77 42                	ja     80102188 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80102146:	8b 45 08             	mov    0x8(%ebp),%eax
80102149:	8b 55 0c             	mov    0xc(%ebp),%edx
8010214c:	83 c2 04             	add    $0x4,%edx
8010214f:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102153:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102156:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010215a:	75 24                	jne    80102180 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010215c:	8b 45 08             	mov    0x8(%ebp),%eax
8010215f:	8b 00                	mov    (%eax),%eax
80102161:	83 ec 0c             	sub    $0xc,%esp
80102164:	50                   	push   %eax
80102165:	e8 e4 f7 ff ff       	call   8010194e <balloc>
8010216a:	83 c4 10             	add    $0x10,%esp
8010216d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102170:	8b 45 08             	mov    0x8(%ebp),%eax
80102173:	8b 55 0c             	mov    0xc(%ebp),%edx
80102176:	8d 4a 04             	lea    0x4(%edx),%ecx
80102179:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010217c:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80102180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102183:	e9 cb 00 00 00       	jmp    80102253 <bmap+0x11a>
  }
  bn -= NDIRECT;
80102188:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
8010218c:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80102190:	0f 87 b0 00 00 00    	ja     80102246 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102196:	8b 45 08             	mov    0x8(%ebp),%eax
80102199:	8b 40 4c             	mov    0x4c(%eax),%eax
8010219c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010219f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801021a3:	75 1d                	jne    801021c2 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801021a5:	8b 45 08             	mov    0x8(%ebp),%eax
801021a8:	8b 00                	mov    (%eax),%eax
801021aa:	83 ec 0c             	sub    $0xc,%esp
801021ad:	50                   	push   %eax
801021ae:	e8 9b f7 ff ff       	call   8010194e <balloc>
801021b3:	83 c4 10             	add    $0x10,%esp
801021b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801021b9:	8b 45 08             	mov    0x8(%ebp),%eax
801021bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021bf:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
801021c2:	8b 45 08             	mov    0x8(%ebp),%eax
801021c5:	8b 00                	mov    (%eax),%eax
801021c7:	83 ec 08             	sub    $0x8,%esp
801021ca:	ff 75 f4             	pushl  -0xc(%ebp)
801021cd:	50                   	push   %eax
801021ce:	e8 e3 df ff ff       	call   801001b6 <bread>
801021d3:	83 c4 10             	add    $0x10,%esp
801021d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
801021d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021dc:	83 c0 18             	add    $0x18,%eax
801021df:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
801021e2:	8b 45 0c             	mov    0xc(%ebp),%eax
801021e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801021ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021ef:	01 d0                	add    %edx,%eax
801021f1:	8b 00                	mov    (%eax),%eax
801021f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801021f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801021fa:	75 37                	jne    80102233 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
801021fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801021ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80102206:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102209:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010220c:	8b 45 08             	mov    0x8(%ebp),%eax
8010220f:	8b 00                	mov    (%eax),%eax
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	50                   	push   %eax
80102215:	e8 34 f7 ff ff       	call   8010194e <balloc>
8010221a:	83 c4 10             	add    $0x10,%esp
8010221d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102220:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102223:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	ff 75 f0             	pushl  -0x10(%ebp)
8010222b:	e8 66 16 00 00       	call   80103896 <log_write>
80102230:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80102233:	83 ec 0c             	sub    $0xc,%esp
80102236:	ff 75 f0             	pushl  -0x10(%ebp)
80102239:	e8 f0 df ff ff       	call   8010022e <brelse>
8010223e:	83 c4 10             	add    $0x10,%esp
    return addr;
80102241:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102244:	eb 0d                	jmp    80102253 <bmap+0x11a>
  }

  panic("bmap: out of range");
80102246:	83 ec 0c             	sub    $0xc,%esp
80102249:	68 e6 94 10 80       	push   $0x801094e6
8010224e:	e8 2f e3 ff ff       	call   80100582 <panic>
}
80102253:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102256:	c9                   	leave  
80102257:	c3                   	ret    

80102258 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80102258:	55                   	push   %ebp
80102259:	89 e5                	mov    %esp,%ebp
8010225b:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010225e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102265:	eb 45                	jmp    801022ac <itrunc+0x54>
    if(ip->addrs[i]){
80102267:	8b 45 08             	mov    0x8(%ebp),%eax
8010226a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010226d:	83 c2 04             	add    $0x4,%edx
80102270:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102274:	85 c0                	test   %eax,%eax
80102276:	74 30                	je     801022a8 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80102278:	8b 45 08             	mov    0x8(%ebp),%eax
8010227b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010227e:	83 c2 04             	add    $0x4,%edx
80102281:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102285:	8b 55 08             	mov    0x8(%ebp),%edx
80102288:	8b 12                	mov    (%edx),%edx
8010228a:	83 ec 08             	sub    $0x8,%esp
8010228d:	50                   	push   %eax
8010228e:	52                   	push   %edx
8010228f:	e8 18 f8 ff ff       	call   80101aac <bfree>
80102294:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80102297:	8b 45 08             	mov    0x8(%ebp),%eax
8010229a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010229d:	83 c2 04             	add    $0x4,%edx
801022a0:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801022a7:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801022a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801022ac:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
801022b0:	7e b5                	jle    80102267 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
801022b2:	8b 45 08             	mov    0x8(%ebp),%eax
801022b5:	8b 40 4c             	mov    0x4c(%eax),%eax
801022b8:	85 c0                	test   %eax,%eax
801022ba:	0f 84 a1 00 00 00    	je     80102361 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801022c0:	8b 45 08             	mov    0x8(%ebp),%eax
801022c3:	8b 50 4c             	mov    0x4c(%eax),%edx
801022c6:	8b 45 08             	mov    0x8(%ebp),%eax
801022c9:	8b 00                	mov    (%eax),%eax
801022cb:	83 ec 08             	sub    $0x8,%esp
801022ce:	52                   	push   %edx
801022cf:	50                   	push   %eax
801022d0:	e8 e1 de ff ff       	call   801001b6 <bread>
801022d5:	83 c4 10             	add    $0x10,%esp
801022d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
801022db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022de:	83 c0 18             	add    $0x18,%eax
801022e1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801022e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801022eb:	eb 3c                	jmp    80102329 <itrunc+0xd1>
      if(a[j])
801022ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801022f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801022fa:	01 d0                	add    %edx,%eax
801022fc:	8b 00                	mov    (%eax),%eax
801022fe:	85 c0                	test   %eax,%eax
80102300:	74 23                	je     80102325 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80102302:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102305:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010230c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010230f:	01 d0                	add    %edx,%eax
80102311:	8b 00                	mov    (%eax),%eax
80102313:	8b 55 08             	mov    0x8(%ebp),%edx
80102316:	8b 12                	mov    (%edx),%edx
80102318:	83 ec 08             	sub    $0x8,%esp
8010231b:	50                   	push   %eax
8010231c:	52                   	push   %edx
8010231d:	e8 8a f7 ff ff       	call   80101aac <bfree>
80102322:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80102325:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80102329:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010232c:	83 f8 7f             	cmp    $0x7f,%eax
8010232f:	76 bc                	jbe    801022ed <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80102331:	83 ec 0c             	sub    $0xc,%esp
80102334:	ff 75 ec             	pushl  -0x14(%ebp)
80102337:	e8 f2 de ff ff       	call   8010022e <brelse>
8010233c:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010233f:	8b 45 08             	mov    0x8(%ebp),%eax
80102342:	8b 40 4c             	mov    0x4c(%eax),%eax
80102345:	8b 55 08             	mov    0x8(%ebp),%edx
80102348:	8b 12                	mov    (%edx),%edx
8010234a:	83 ec 08             	sub    $0x8,%esp
8010234d:	50                   	push   %eax
8010234e:	52                   	push   %edx
8010234f:	e8 58 f7 ff ff       	call   80101aac <bfree>
80102354:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80102357:	8b 45 08             	mov    0x8(%ebp),%eax
8010235a:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80102361:	8b 45 08             	mov    0x8(%ebp),%eax
80102364:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
8010236b:	83 ec 0c             	sub    $0xc,%esp
8010236e:	ff 75 08             	pushl  0x8(%ebp)
80102371:	e8 10 f9 ff ff       	call   80101c86 <iupdate>
80102376:	83 c4 10             	add    $0x10,%esp
}
80102379:	90                   	nop
8010237a:	c9                   	leave  
8010237b:	c3                   	ret    

8010237c <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
8010237c:	55                   	push   %ebp
8010237d:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
8010237f:	8b 45 08             	mov    0x8(%ebp),%eax
80102382:	8b 00                	mov    (%eax),%eax
80102384:	89 c2                	mov    %eax,%edx
80102386:	8b 45 0c             	mov    0xc(%ebp),%eax
80102389:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
8010238c:	8b 45 08             	mov    0x8(%ebp),%eax
8010238f:	8b 50 04             	mov    0x4(%eax),%edx
80102392:	8b 45 0c             	mov    0xc(%ebp),%eax
80102395:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80102398:	8b 45 08             	mov    0x8(%ebp),%eax
8010239b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
8010239f:	8b 45 0c             	mov    0xc(%ebp),%eax
801023a2:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
801023a5:	8b 45 08             	mov    0x8(%ebp),%eax
801023a8:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801023ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801023af:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
801023b3:	8b 45 08             	mov    0x8(%ebp),%eax
801023b6:	8b 50 18             	mov    0x18(%eax),%edx
801023b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801023bc:	89 50 10             	mov    %edx,0x10(%eax)
}
801023bf:	90                   	nop
801023c0:	5d                   	pop    %ebp
801023c1:	c3                   	ret    

801023c2 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801023c2:	55                   	push   %ebp
801023c3:	89 e5                	mov    %esp,%ebp
801023c5:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801023c8:	8b 45 08             	mov    0x8(%ebp),%eax
801023cb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023cf:	66 83 f8 03          	cmp    $0x3,%ax
801023d3:	75 5c                	jne    80102431 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
801023d8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023dc:	66 85 c0             	test   %ax,%ax
801023df:	78 20                	js     80102401 <readi+0x3f>
801023e1:	8b 45 08             	mov    0x8(%ebp),%eax
801023e4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023e8:	66 83 f8 09          	cmp    $0x9,%ax
801023ec:	7f 13                	jg     80102401 <readi+0x3f>
801023ee:	8b 45 08             	mov    0x8(%ebp),%eax
801023f1:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023f5:	98                   	cwtl   
801023f6:	8b 04 c5 80 f9 10 80 	mov    -0x7fef0680(,%eax,8),%eax
801023fd:	85 c0                	test   %eax,%eax
801023ff:	75 0a                	jne    8010240b <readi+0x49>
      return -1;
80102401:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102406:	e9 0c 01 00 00       	jmp    80102517 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
8010240b:	8b 45 08             	mov    0x8(%ebp),%eax
8010240e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102412:	98                   	cwtl   
80102413:	8b 04 c5 80 f9 10 80 	mov    -0x7fef0680(,%eax,8),%eax
8010241a:	8b 55 14             	mov    0x14(%ebp),%edx
8010241d:	83 ec 04             	sub    $0x4,%esp
80102420:	52                   	push   %edx
80102421:	ff 75 0c             	pushl  0xc(%ebp)
80102424:	ff 75 08             	pushl  0x8(%ebp)
80102427:	ff d0                	call   *%eax
80102429:	83 c4 10             	add    $0x10,%esp
8010242c:	e9 e6 00 00 00       	jmp    80102517 <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80102431:	8b 45 08             	mov    0x8(%ebp),%eax
80102434:	8b 40 18             	mov    0x18(%eax),%eax
80102437:	3b 45 10             	cmp    0x10(%ebp),%eax
8010243a:	72 0d                	jb     80102449 <readi+0x87>
8010243c:	8b 55 10             	mov    0x10(%ebp),%edx
8010243f:	8b 45 14             	mov    0x14(%ebp),%eax
80102442:	01 d0                	add    %edx,%eax
80102444:	3b 45 10             	cmp    0x10(%ebp),%eax
80102447:	73 0a                	jae    80102453 <readi+0x91>
    return -1;
80102449:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010244e:	e9 c4 00 00 00       	jmp    80102517 <readi+0x155>
  if(off + n > ip->size)
80102453:	8b 55 10             	mov    0x10(%ebp),%edx
80102456:	8b 45 14             	mov    0x14(%ebp),%eax
80102459:	01 c2                	add    %eax,%edx
8010245b:	8b 45 08             	mov    0x8(%ebp),%eax
8010245e:	8b 40 18             	mov    0x18(%eax),%eax
80102461:	39 c2                	cmp    %eax,%edx
80102463:	76 0c                	jbe    80102471 <readi+0xaf>
    n = ip->size - off;
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
80102468:	8b 40 18             	mov    0x18(%eax),%eax
8010246b:	2b 45 10             	sub    0x10(%ebp),%eax
8010246e:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102478:	e9 8b 00 00 00       	jmp    80102508 <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010247d:	8b 45 10             	mov    0x10(%ebp),%eax
80102480:	c1 e8 09             	shr    $0x9,%eax
80102483:	83 ec 08             	sub    $0x8,%esp
80102486:	50                   	push   %eax
80102487:	ff 75 08             	pushl  0x8(%ebp)
8010248a:	e8 aa fc ff ff       	call   80102139 <bmap>
8010248f:	83 c4 10             	add    $0x10,%esp
80102492:	89 c2                	mov    %eax,%edx
80102494:	8b 45 08             	mov    0x8(%ebp),%eax
80102497:	8b 00                	mov    (%eax),%eax
80102499:	83 ec 08             	sub    $0x8,%esp
8010249c:	52                   	push   %edx
8010249d:	50                   	push   %eax
8010249e:	e8 13 dd ff ff       	call   801001b6 <bread>
801024a3:	83 c4 10             	add    $0x10,%esp
801024a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801024a9:	8b 45 10             	mov    0x10(%ebp),%eax
801024ac:	25 ff 01 00 00       	and    $0x1ff,%eax
801024b1:	ba 00 02 00 00       	mov    $0x200,%edx
801024b6:	29 c2                	sub    %eax,%edx
801024b8:	8b 45 14             	mov    0x14(%ebp),%eax
801024bb:	2b 45 f4             	sub    -0xc(%ebp),%eax
801024be:	39 c2                	cmp    %eax,%edx
801024c0:	0f 46 c2             	cmovbe %edx,%eax
801024c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
801024c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024c9:	8d 50 18             	lea    0x18(%eax),%edx
801024cc:	8b 45 10             	mov    0x10(%ebp),%eax
801024cf:	25 ff 01 00 00       	and    $0x1ff,%eax
801024d4:	01 d0                	add    %edx,%eax
801024d6:	83 ec 04             	sub    $0x4,%esp
801024d9:	ff 75 ec             	pushl  -0x14(%ebp)
801024dc:	50                   	push   %eax
801024dd:	ff 75 0c             	pushl  0xc(%ebp)
801024e0:	e8 53 2f 00 00       	call   80105438 <memmove>
801024e5:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801024e8:	83 ec 0c             	sub    $0xc,%esp
801024eb:	ff 75 f0             	pushl  -0x10(%ebp)
801024ee:	e8 3b dd ff ff       	call   8010022e <brelse>
801024f3:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801024f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024f9:	01 45 f4             	add    %eax,-0xc(%ebp)
801024fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024ff:	01 45 10             	add    %eax,0x10(%ebp)
80102502:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102505:	01 45 0c             	add    %eax,0xc(%ebp)
80102508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010250b:	3b 45 14             	cmp    0x14(%ebp),%eax
8010250e:	0f 82 69 ff ff ff    	jb     8010247d <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80102514:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102517:	c9                   	leave  
80102518:	c3                   	ret    

80102519 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102519:	55                   	push   %ebp
8010251a:	89 e5                	mov    %esp,%ebp
8010251c:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010251f:	8b 45 08             	mov    0x8(%ebp),%eax
80102522:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102526:	66 83 f8 03          	cmp    $0x3,%ax
8010252a:	75 5c                	jne    80102588 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
8010252c:	8b 45 08             	mov    0x8(%ebp),%eax
8010252f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102533:	66 85 c0             	test   %ax,%ax
80102536:	78 20                	js     80102558 <writei+0x3f>
80102538:	8b 45 08             	mov    0x8(%ebp),%eax
8010253b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010253f:	66 83 f8 09          	cmp    $0x9,%ax
80102543:	7f 13                	jg     80102558 <writei+0x3f>
80102545:	8b 45 08             	mov    0x8(%ebp),%eax
80102548:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010254c:	98                   	cwtl   
8010254d:	8b 04 c5 84 f9 10 80 	mov    -0x7fef067c(,%eax,8),%eax
80102554:	85 c0                	test   %eax,%eax
80102556:	75 0a                	jne    80102562 <writei+0x49>
      return -1;
80102558:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010255d:	e9 3d 01 00 00       	jmp    8010269f <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
80102562:	8b 45 08             	mov    0x8(%ebp),%eax
80102565:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102569:	98                   	cwtl   
8010256a:	8b 04 c5 84 f9 10 80 	mov    -0x7fef067c(,%eax,8),%eax
80102571:	8b 55 14             	mov    0x14(%ebp),%edx
80102574:	83 ec 04             	sub    $0x4,%esp
80102577:	52                   	push   %edx
80102578:	ff 75 0c             	pushl  0xc(%ebp)
8010257b:	ff 75 08             	pushl  0x8(%ebp)
8010257e:	ff d0                	call   *%eax
80102580:	83 c4 10             	add    $0x10,%esp
80102583:	e9 17 01 00 00       	jmp    8010269f <writei+0x186>
  }

  if(off > ip->size || off + n < off)
80102588:	8b 45 08             	mov    0x8(%ebp),%eax
8010258b:	8b 40 18             	mov    0x18(%eax),%eax
8010258e:	3b 45 10             	cmp    0x10(%ebp),%eax
80102591:	72 0d                	jb     801025a0 <writei+0x87>
80102593:	8b 55 10             	mov    0x10(%ebp),%edx
80102596:	8b 45 14             	mov    0x14(%ebp),%eax
80102599:	01 d0                	add    %edx,%eax
8010259b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010259e:	73 0a                	jae    801025aa <writei+0x91>
    return -1;
801025a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025a5:	e9 f5 00 00 00       	jmp    8010269f <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
801025aa:	8b 55 10             	mov    0x10(%ebp),%edx
801025ad:	8b 45 14             	mov    0x14(%ebp),%eax
801025b0:	01 d0                	add    %edx,%eax
801025b2:	3d 00 18 01 00       	cmp    $0x11800,%eax
801025b7:	76 0a                	jbe    801025c3 <writei+0xaa>
    return -1;
801025b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025be:	e9 dc 00 00 00       	jmp    8010269f <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801025c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801025ca:	e9 99 00 00 00       	jmp    80102668 <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801025cf:	8b 45 10             	mov    0x10(%ebp),%eax
801025d2:	c1 e8 09             	shr    $0x9,%eax
801025d5:	83 ec 08             	sub    $0x8,%esp
801025d8:	50                   	push   %eax
801025d9:	ff 75 08             	pushl  0x8(%ebp)
801025dc:	e8 58 fb ff ff       	call   80102139 <bmap>
801025e1:	83 c4 10             	add    $0x10,%esp
801025e4:	89 c2                	mov    %eax,%edx
801025e6:	8b 45 08             	mov    0x8(%ebp),%eax
801025e9:	8b 00                	mov    (%eax),%eax
801025eb:	83 ec 08             	sub    $0x8,%esp
801025ee:	52                   	push   %edx
801025ef:	50                   	push   %eax
801025f0:	e8 c1 db ff ff       	call   801001b6 <bread>
801025f5:	83 c4 10             	add    $0x10,%esp
801025f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801025fb:	8b 45 10             	mov    0x10(%ebp),%eax
801025fe:	25 ff 01 00 00       	and    $0x1ff,%eax
80102603:	ba 00 02 00 00       	mov    $0x200,%edx
80102608:	29 c2                	sub    %eax,%edx
8010260a:	8b 45 14             	mov    0x14(%ebp),%eax
8010260d:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102610:	39 c2                	cmp    %eax,%edx
80102612:	0f 46 c2             	cmovbe %edx,%eax
80102615:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102618:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010261b:	8d 50 18             	lea    0x18(%eax),%edx
8010261e:	8b 45 10             	mov    0x10(%ebp),%eax
80102621:	25 ff 01 00 00       	and    $0x1ff,%eax
80102626:	01 d0                	add    %edx,%eax
80102628:	83 ec 04             	sub    $0x4,%esp
8010262b:	ff 75 ec             	pushl  -0x14(%ebp)
8010262e:	ff 75 0c             	pushl  0xc(%ebp)
80102631:	50                   	push   %eax
80102632:	e8 01 2e 00 00       	call   80105438 <memmove>
80102637:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
8010263a:	83 ec 0c             	sub    $0xc,%esp
8010263d:	ff 75 f0             	pushl  -0x10(%ebp)
80102640:	e8 51 12 00 00       	call   80103896 <log_write>
80102645:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102648:	83 ec 0c             	sub    $0xc,%esp
8010264b:	ff 75 f0             	pushl  -0x10(%ebp)
8010264e:	e8 db db ff ff       	call   8010022e <brelse>
80102653:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102656:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102659:	01 45 f4             	add    %eax,-0xc(%ebp)
8010265c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010265f:	01 45 10             	add    %eax,0x10(%ebp)
80102662:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102665:	01 45 0c             	add    %eax,0xc(%ebp)
80102668:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010266b:	3b 45 14             	cmp    0x14(%ebp),%eax
8010266e:	0f 82 5b ff ff ff    	jb     801025cf <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102674:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102678:	74 22                	je     8010269c <writei+0x183>
8010267a:	8b 45 08             	mov    0x8(%ebp),%eax
8010267d:	8b 40 18             	mov    0x18(%eax),%eax
80102680:	3b 45 10             	cmp    0x10(%ebp),%eax
80102683:	73 17                	jae    8010269c <writei+0x183>
    ip->size = off;
80102685:	8b 45 08             	mov    0x8(%ebp),%eax
80102688:	8b 55 10             	mov    0x10(%ebp),%edx
8010268b:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010268e:	83 ec 0c             	sub    $0xc,%esp
80102691:	ff 75 08             	pushl  0x8(%ebp)
80102694:	e8 ed f5 ff ff       	call   80101c86 <iupdate>
80102699:	83 c4 10             	add    $0x10,%esp
  }
  return n;
8010269c:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010269f:	c9                   	leave  
801026a0:	c3                   	ret    

801026a1 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801026a1:	55                   	push   %ebp
801026a2:	89 e5                	mov    %esp,%ebp
801026a4:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801026a7:	83 ec 04             	sub    $0x4,%esp
801026aa:	6a 0e                	push   $0xe
801026ac:	ff 75 0c             	pushl  0xc(%ebp)
801026af:	ff 75 08             	pushl  0x8(%ebp)
801026b2:	e8 17 2e 00 00       	call   801054ce <strncmp>
801026b7:	83 c4 10             	add    $0x10,%esp
}
801026ba:	c9                   	leave  
801026bb:	c3                   	ret    

801026bc <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801026bc:	55                   	push   %ebp
801026bd:	89 e5                	mov    %esp,%ebp
801026bf:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801026c2:	8b 45 08             	mov    0x8(%ebp),%eax
801026c5:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801026c9:	66 83 f8 01          	cmp    $0x1,%ax
801026cd:	74 0d                	je     801026dc <dirlookup+0x20>
    panic("dirlookup not DIR");
801026cf:	83 ec 0c             	sub    $0xc,%esp
801026d2:	68 f9 94 10 80       	push   $0x801094f9
801026d7:	e8 a6 de ff ff       	call   80100582 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801026dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026e3:	eb 7b                	jmp    80102760 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026e5:	6a 10                	push   $0x10
801026e7:	ff 75 f4             	pushl  -0xc(%ebp)
801026ea:	8d 45 e0             	lea    -0x20(%ebp),%eax
801026ed:	50                   	push   %eax
801026ee:	ff 75 08             	pushl  0x8(%ebp)
801026f1:	e8 cc fc ff ff       	call   801023c2 <readi>
801026f6:	83 c4 10             	add    $0x10,%esp
801026f9:	83 f8 10             	cmp    $0x10,%eax
801026fc:	74 0d                	je     8010270b <dirlookup+0x4f>
      panic("dirlink read");
801026fe:	83 ec 0c             	sub    $0xc,%esp
80102701:	68 0b 95 10 80       	push   $0x8010950b
80102706:	e8 77 de ff ff       	call   80100582 <panic>
    if(de.inum == 0)
8010270b:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010270f:	66 85 c0             	test   %ax,%ax
80102712:	74 47                	je     8010275b <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102714:	83 ec 08             	sub    $0x8,%esp
80102717:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010271a:	83 c0 02             	add    $0x2,%eax
8010271d:	50                   	push   %eax
8010271e:	ff 75 0c             	pushl  0xc(%ebp)
80102721:	e8 7b ff ff ff       	call   801026a1 <namecmp>
80102726:	83 c4 10             	add    $0x10,%esp
80102729:	85 c0                	test   %eax,%eax
8010272b:	75 2f                	jne    8010275c <dirlookup+0xa0>
      // entry matches path element
      if(poff)
8010272d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102731:	74 08                	je     8010273b <dirlookup+0x7f>
        *poff = off;
80102733:	8b 45 10             	mov    0x10(%ebp),%eax
80102736:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102739:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010273b:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010273f:	0f b7 c0             	movzwl %ax,%eax
80102742:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102745:	8b 45 08             	mov    0x8(%ebp),%eax
80102748:	8b 00                	mov    (%eax),%eax
8010274a:	83 ec 08             	sub    $0x8,%esp
8010274d:	ff 75 f0             	pushl  -0x10(%ebp)
80102750:	50                   	push   %eax
80102751:	e8 eb f5 ff ff       	call   80101d41 <iget>
80102756:	83 c4 10             	add    $0x10,%esp
80102759:	eb 19                	jmp    80102774 <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
8010275b:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010275c:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102760:	8b 45 08             	mov    0x8(%ebp),%eax
80102763:	8b 40 18             	mov    0x18(%eax),%eax
80102766:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102769:	0f 87 76 ff ff ff    	ja     801026e5 <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010276f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102774:	c9                   	leave  
80102775:	c3                   	ret    

80102776 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102776:	55                   	push   %ebp
80102777:	89 e5                	mov    %esp,%ebp
80102779:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010277c:	83 ec 04             	sub    $0x4,%esp
8010277f:	6a 00                	push   $0x0
80102781:	ff 75 0c             	pushl  0xc(%ebp)
80102784:	ff 75 08             	pushl  0x8(%ebp)
80102787:	e8 30 ff ff ff       	call   801026bc <dirlookup>
8010278c:	83 c4 10             	add    $0x10,%esp
8010278f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102792:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102796:	74 18                	je     801027b0 <dirlink+0x3a>
    iput(ip);
80102798:	83 ec 0c             	sub    $0xc,%esp
8010279b:	ff 75 f0             	pushl  -0x10(%ebp)
8010279e:	e8 81 f8 ff ff       	call   80102024 <iput>
801027a3:	83 c4 10             	add    $0x10,%esp
    return -1;
801027a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027ab:	e9 9c 00 00 00       	jmp    8010284c <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801027b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801027b7:	eb 39                	jmp    801027f2 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801027b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027bc:	6a 10                	push   $0x10
801027be:	50                   	push   %eax
801027bf:	8d 45 e0             	lea    -0x20(%ebp),%eax
801027c2:	50                   	push   %eax
801027c3:	ff 75 08             	pushl  0x8(%ebp)
801027c6:	e8 f7 fb ff ff       	call   801023c2 <readi>
801027cb:	83 c4 10             	add    $0x10,%esp
801027ce:	83 f8 10             	cmp    $0x10,%eax
801027d1:	74 0d                	je     801027e0 <dirlink+0x6a>
      panic("dirlink read");
801027d3:	83 ec 0c             	sub    $0xc,%esp
801027d6:	68 0b 95 10 80       	push   $0x8010950b
801027db:	e8 a2 dd ff ff       	call   80100582 <panic>
    if(de.inum == 0)
801027e0:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801027e4:	66 85 c0             	test   %ax,%ax
801027e7:	74 18                	je     80102801 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801027e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027ec:	83 c0 10             	add    $0x10,%eax
801027ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027f2:	8b 45 08             	mov    0x8(%ebp),%eax
801027f5:	8b 50 18             	mov    0x18(%eax),%edx
801027f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027fb:	39 c2                	cmp    %eax,%edx
801027fd:	77 ba                	ja     801027b9 <dirlink+0x43>
801027ff:	eb 01                	jmp    80102802 <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
80102801:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102802:	83 ec 04             	sub    $0x4,%esp
80102805:	6a 0e                	push   $0xe
80102807:	ff 75 0c             	pushl  0xc(%ebp)
8010280a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010280d:	83 c0 02             	add    $0x2,%eax
80102810:	50                   	push   %eax
80102811:	e8 0e 2d 00 00       	call   80105524 <strncpy>
80102816:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102819:	8b 45 10             	mov    0x10(%ebp),%eax
8010281c:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102820:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102823:	6a 10                	push   $0x10
80102825:	50                   	push   %eax
80102826:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102829:	50                   	push   %eax
8010282a:	ff 75 08             	pushl  0x8(%ebp)
8010282d:	e8 e7 fc ff ff       	call   80102519 <writei>
80102832:	83 c4 10             	add    $0x10,%esp
80102835:	83 f8 10             	cmp    $0x10,%eax
80102838:	74 0d                	je     80102847 <dirlink+0xd1>
    panic("dirlink");
8010283a:	83 ec 0c             	sub    $0xc,%esp
8010283d:	68 18 95 10 80       	push   $0x80109518
80102842:	e8 3b dd ff ff       	call   80100582 <panic>
  
  return 0;
80102847:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010284c:	c9                   	leave  
8010284d:	c3                   	ret    

8010284e <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010284e:	55                   	push   %ebp
8010284f:	89 e5                	mov    %esp,%ebp
80102851:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102854:	eb 04                	jmp    8010285a <skipelem+0xc>
    path++;
80102856:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010285a:	8b 45 08             	mov    0x8(%ebp),%eax
8010285d:	0f b6 00             	movzbl (%eax),%eax
80102860:	3c 2f                	cmp    $0x2f,%al
80102862:	74 f2                	je     80102856 <skipelem+0x8>
    path++;
  if(*path == 0)
80102864:	8b 45 08             	mov    0x8(%ebp),%eax
80102867:	0f b6 00             	movzbl (%eax),%eax
8010286a:	84 c0                	test   %al,%al
8010286c:	75 07                	jne    80102875 <skipelem+0x27>
    return 0;
8010286e:	b8 00 00 00 00       	mov    $0x0,%eax
80102873:	eb 7b                	jmp    801028f0 <skipelem+0xa2>
  s = path;
80102875:	8b 45 08             	mov    0x8(%ebp),%eax
80102878:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010287b:	eb 04                	jmp    80102881 <skipelem+0x33>
    path++;
8010287d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102881:	8b 45 08             	mov    0x8(%ebp),%eax
80102884:	0f b6 00             	movzbl (%eax),%eax
80102887:	3c 2f                	cmp    $0x2f,%al
80102889:	74 0a                	je     80102895 <skipelem+0x47>
8010288b:	8b 45 08             	mov    0x8(%ebp),%eax
8010288e:	0f b6 00             	movzbl (%eax),%eax
80102891:	84 c0                	test   %al,%al
80102893:	75 e8                	jne    8010287d <skipelem+0x2f>
    path++;
  len = path - s;
80102895:	8b 55 08             	mov    0x8(%ebp),%edx
80102898:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010289b:	29 c2                	sub    %eax,%edx
8010289d:	89 d0                	mov    %edx,%eax
8010289f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801028a2:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801028a6:	7e 15                	jle    801028bd <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
801028a8:	83 ec 04             	sub    $0x4,%esp
801028ab:	6a 0e                	push   $0xe
801028ad:	ff 75 f4             	pushl  -0xc(%ebp)
801028b0:	ff 75 0c             	pushl  0xc(%ebp)
801028b3:	e8 80 2b 00 00       	call   80105438 <memmove>
801028b8:	83 c4 10             	add    $0x10,%esp
801028bb:	eb 26                	jmp    801028e3 <skipelem+0x95>
  else {
    memmove(name, s, len);
801028bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028c0:	83 ec 04             	sub    $0x4,%esp
801028c3:	50                   	push   %eax
801028c4:	ff 75 f4             	pushl  -0xc(%ebp)
801028c7:	ff 75 0c             	pushl  0xc(%ebp)
801028ca:	e8 69 2b 00 00       	call   80105438 <memmove>
801028cf:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801028d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
801028d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801028d8:	01 d0                	add    %edx,%eax
801028da:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801028dd:	eb 04                	jmp    801028e3 <skipelem+0x95>
    path++;
801028df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801028e3:	8b 45 08             	mov    0x8(%ebp),%eax
801028e6:	0f b6 00             	movzbl (%eax),%eax
801028e9:	3c 2f                	cmp    $0x2f,%al
801028eb:	74 f2                	je     801028df <skipelem+0x91>
    path++;
  return path;
801028ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
801028f0:	c9                   	leave  
801028f1:	c3                   	ret    

801028f2 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801028f2:	55                   	push   %ebp
801028f3:	89 e5                	mov    %esp,%ebp
801028f5:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801028f8:	8b 45 08             	mov    0x8(%ebp),%eax
801028fb:	0f b6 00             	movzbl (%eax),%eax
801028fe:	3c 2f                	cmp    $0x2f,%al
80102900:	75 17                	jne    80102919 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
80102902:	83 ec 08             	sub    $0x8,%esp
80102905:	6a 01                	push   $0x1
80102907:	6a 01                	push   $0x1
80102909:	e8 33 f4 ff ff       	call   80101d41 <iget>
8010290e:	83 c4 10             	add    $0x10,%esp
80102911:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102914:	e9 bb 00 00 00       	jmp    801029d4 <namex+0xe2>
  else
    ip = idup(proc->cwd);
80102919:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010291f:	8b 40 68             	mov    0x68(%eax),%eax
80102922:	83 ec 0c             	sub    $0xc,%esp
80102925:	50                   	push   %eax
80102926:	e8 f5 f4 ff ff       	call   80101e20 <idup>
8010292b:	83 c4 10             	add    $0x10,%esp
8010292e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102931:	e9 9e 00 00 00       	jmp    801029d4 <namex+0xe2>
    ilock(ip);
80102936:	83 ec 0c             	sub    $0xc,%esp
80102939:	ff 75 f4             	pushl  -0xc(%ebp)
8010293c:	e8 19 f5 ff ff       	call   80101e5a <ilock>
80102941:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102944:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102947:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010294b:	66 83 f8 01          	cmp    $0x1,%ax
8010294f:	74 18                	je     80102969 <namex+0x77>
      iunlockput(ip);
80102951:	83 ec 0c             	sub    $0xc,%esp
80102954:	ff 75 f4             	pushl  -0xc(%ebp)
80102957:	e8 b8 f7 ff ff       	call   80102114 <iunlockput>
8010295c:	83 c4 10             	add    $0x10,%esp
      return 0;
8010295f:	b8 00 00 00 00       	mov    $0x0,%eax
80102964:	e9 a7 00 00 00       	jmp    80102a10 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
80102969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010296d:	74 20                	je     8010298f <namex+0x9d>
8010296f:	8b 45 08             	mov    0x8(%ebp),%eax
80102972:	0f b6 00             	movzbl (%eax),%eax
80102975:	84 c0                	test   %al,%al
80102977:	75 16                	jne    8010298f <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
80102979:	83 ec 0c             	sub    $0xc,%esp
8010297c:	ff 75 f4             	pushl  -0xc(%ebp)
8010297f:	e8 2e f6 ff ff       	call   80101fb2 <iunlock>
80102984:	83 c4 10             	add    $0x10,%esp
      return ip;
80102987:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010298a:	e9 81 00 00 00       	jmp    80102a10 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010298f:	83 ec 04             	sub    $0x4,%esp
80102992:	6a 00                	push   $0x0
80102994:	ff 75 10             	pushl  0x10(%ebp)
80102997:	ff 75 f4             	pushl  -0xc(%ebp)
8010299a:	e8 1d fd ff ff       	call   801026bc <dirlookup>
8010299f:	83 c4 10             	add    $0x10,%esp
801029a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801029a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801029a9:	75 15                	jne    801029c0 <namex+0xce>
      iunlockput(ip);
801029ab:	83 ec 0c             	sub    $0xc,%esp
801029ae:	ff 75 f4             	pushl  -0xc(%ebp)
801029b1:	e8 5e f7 ff ff       	call   80102114 <iunlockput>
801029b6:	83 c4 10             	add    $0x10,%esp
      return 0;
801029b9:	b8 00 00 00 00       	mov    $0x0,%eax
801029be:	eb 50                	jmp    80102a10 <namex+0x11e>
    }
    iunlockput(ip);
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	ff 75 f4             	pushl  -0xc(%ebp)
801029c6:	e8 49 f7 ff ff       	call   80102114 <iunlockput>
801029cb:	83 c4 10             	add    $0x10,%esp
    ip = next;
801029ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801029d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801029d4:	83 ec 08             	sub    $0x8,%esp
801029d7:	ff 75 10             	pushl  0x10(%ebp)
801029da:	ff 75 08             	pushl  0x8(%ebp)
801029dd:	e8 6c fe ff ff       	call   8010284e <skipelem>
801029e2:	83 c4 10             	add    $0x10,%esp
801029e5:	89 45 08             	mov    %eax,0x8(%ebp)
801029e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801029ec:	0f 85 44 ff ff ff    	jne    80102936 <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801029f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801029f6:	74 15                	je     80102a0d <namex+0x11b>
    iput(ip);
801029f8:	83 ec 0c             	sub    $0xc,%esp
801029fb:	ff 75 f4             	pushl  -0xc(%ebp)
801029fe:	e8 21 f6 ff ff       	call   80102024 <iput>
80102a03:	83 c4 10             	add    $0x10,%esp
    return 0;
80102a06:	b8 00 00 00 00       	mov    $0x0,%eax
80102a0b:	eb 03                	jmp    80102a10 <namex+0x11e>
  }
  return ip;
80102a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102a10:	c9                   	leave  
80102a11:	c3                   	ret    

80102a12 <namei>:

struct inode*
namei(char *path)
{
80102a12:	55                   	push   %ebp
80102a13:	89 e5                	mov    %esp,%ebp
80102a15:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102a18:	83 ec 04             	sub    $0x4,%esp
80102a1b:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102a1e:	50                   	push   %eax
80102a1f:	6a 00                	push   $0x0
80102a21:	ff 75 08             	pushl  0x8(%ebp)
80102a24:	e8 c9 fe ff ff       	call   801028f2 <namex>
80102a29:	83 c4 10             	add    $0x10,%esp
}
80102a2c:	c9                   	leave  
80102a2d:	c3                   	ret    

80102a2e <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80102a34:	83 ec 04             	sub    $0x4,%esp
80102a37:	ff 75 0c             	pushl  0xc(%ebp)
80102a3a:	6a 01                	push   $0x1
80102a3c:	ff 75 08             	pushl  0x8(%ebp)
80102a3f:	e8 ae fe ff ff       	call   801028f2 <namex>
80102a44:	83 c4 10             	add    $0x10,%esp
}
80102a47:	c9                   	leave  
80102a48:	c3                   	ret    

80102a49 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102a49:	55                   	push   %ebp
80102a4a:	89 e5                	mov    %esp,%ebp
80102a4c:	83 ec 14             	sub    $0x14,%esp
80102a4f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a52:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a56:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102a5a:	89 c2                	mov    %eax,%edx
80102a5c:	ec                   	in     (%dx),%al
80102a5d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102a60:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102a64:	c9                   	leave  
80102a65:	c3                   	ret    

80102a66 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102a66:	55                   	push   %ebp
80102a67:	89 e5                	mov    %esp,%ebp
80102a69:	57                   	push   %edi
80102a6a:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102a6b:	8b 55 08             	mov    0x8(%ebp),%edx
80102a6e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102a71:	8b 45 10             	mov    0x10(%ebp),%eax
80102a74:	89 cb                	mov    %ecx,%ebx
80102a76:	89 df                	mov    %ebx,%edi
80102a78:	89 c1                	mov    %eax,%ecx
80102a7a:	fc                   	cld    
80102a7b:	f3 6d                	rep insl (%dx),%es:(%edi)
80102a7d:	89 c8                	mov    %ecx,%eax
80102a7f:	89 fb                	mov    %edi,%ebx
80102a81:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102a84:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102a87:	90                   	nop
80102a88:	5b                   	pop    %ebx
80102a89:	5f                   	pop    %edi
80102a8a:	5d                   	pop    %ebp
80102a8b:	c3                   	ret    

80102a8c <outb>:

static inline void
outb(ushort port, uchar data)
{
80102a8c:	55                   	push   %ebp
80102a8d:	89 e5                	mov    %esp,%ebp
80102a8f:	83 ec 08             	sub    $0x8,%esp
80102a92:	8b 55 08             	mov    0x8(%ebp),%edx
80102a95:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a98:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102a9c:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a9f:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102aa3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102aa7:	ee                   	out    %al,(%dx)
}
80102aa8:	90                   	nop
80102aa9:	c9                   	leave  
80102aaa:	c3                   	ret    

80102aab <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102aab:	55                   	push   %ebp
80102aac:	89 e5                	mov    %esp,%ebp
80102aae:	56                   	push   %esi
80102aaf:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102ab0:	8b 55 08             	mov    0x8(%ebp),%edx
80102ab3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ab6:	8b 45 10             	mov    0x10(%ebp),%eax
80102ab9:	89 cb                	mov    %ecx,%ebx
80102abb:	89 de                	mov    %ebx,%esi
80102abd:	89 c1                	mov    %eax,%ecx
80102abf:	fc                   	cld    
80102ac0:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102ac2:	89 c8                	mov    %ecx,%eax
80102ac4:	89 f3                	mov    %esi,%ebx
80102ac6:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102ac9:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102acc:	90                   	nop
80102acd:	5b                   	pop    %ebx
80102ace:	5e                   	pop    %esi
80102acf:	5d                   	pop    %ebp
80102ad0:	c3                   	ret    

80102ad1 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102ad1:	55                   	push   %ebp
80102ad2:	89 e5                	mov    %esp,%ebp
80102ad4:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102ad7:	90                   	nop
80102ad8:	68 f7 01 00 00       	push   $0x1f7
80102add:	e8 67 ff ff ff       	call   80102a49 <inb>
80102ae2:	83 c4 04             	add    $0x4,%esp
80102ae5:	0f b6 c0             	movzbl %al,%eax
80102ae8:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102aeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102aee:	25 c0 00 00 00       	and    $0xc0,%eax
80102af3:	83 f8 40             	cmp    $0x40,%eax
80102af6:	75 e0                	jne    80102ad8 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102af8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102afc:	74 11                	je     80102b0f <idewait+0x3e>
80102afe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102b01:	83 e0 21             	and    $0x21,%eax
80102b04:	85 c0                	test   %eax,%eax
80102b06:	74 07                	je     80102b0f <idewait+0x3e>
    return -1;
80102b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b0d:	eb 05                	jmp    80102b14 <idewait+0x43>
  return 0;
80102b0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102b14:	c9                   	leave  
80102b15:	c3                   	ret    

80102b16 <ideinit>:

void
ideinit(void)
{
80102b16:	55                   	push   %ebp
80102b17:	89 e5                	mov    %esp,%ebp
80102b19:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102b1c:	83 ec 08             	sub    $0x8,%esp
80102b1f:	68 20 95 10 80       	push   $0x80109520
80102b24:	68 40 c6 10 80       	push   $0x8010c640
80102b29:	e8 c6 25 00 00       	call   801050f4 <initlock>
80102b2e:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102b31:	83 ec 0c             	sub    $0xc,%esp
80102b34:	6a 0e                	push   $0xe
80102b36:	e8 46 15 00 00       	call   80104081 <picenable>
80102b3b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102b3e:	a1 80 10 11 80       	mov    0x80111080,%eax
80102b43:	83 e8 01             	sub    $0x1,%eax
80102b46:	83 ec 08             	sub    $0x8,%esp
80102b49:	50                   	push   %eax
80102b4a:	6a 0e                	push   $0xe
80102b4c:	e8 37 04 00 00       	call   80102f88 <ioapicenable>
80102b51:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102b54:	83 ec 0c             	sub    $0xc,%esp
80102b57:	6a 00                	push   $0x0
80102b59:	e8 73 ff ff ff       	call   80102ad1 <idewait>
80102b5e:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102b61:	83 ec 08             	sub    $0x8,%esp
80102b64:	68 f0 00 00 00       	push   $0xf0
80102b69:	68 f6 01 00 00       	push   $0x1f6
80102b6e:	e8 19 ff ff ff       	call   80102a8c <outb>
80102b73:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102b76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102b7d:	eb 24                	jmp    80102ba3 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
80102b7f:	83 ec 0c             	sub    $0xc,%esp
80102b82:	68 f7 01 00 00       	push   $0x1f7
80102b87:	e8 bd fe ff ff       	call   80102a49 <inb>
80102b8c:	83 c4 10             	add    $0x10,%esp
80102b8f:	84 c0                	test   %al,%al
80102b91:	74 0c                	je     80102b9f <ideinit+0x89>
      havedisk1 = 1;
80102b93:	c7 05 78 c6 10 80 01 	movl   $0x1,0x8010c678
80102b9a:	00 00 00 
      break;
80102b9d:	eb 0d                	jmp    80102bac <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102b9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102ba3:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102baa:	7e d3                	jle    80102b7f <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102bac:	83 ec 08             	sub    $0x8,%esp
80102baf:	68 e0 00 00 00       	push   $0xe0
80102bb4:	68 f6 01 00 00       	push   $0x1f6
80102bb9:	e8 ce fe ff ff       	call   80102a8c <outb>
80102bbe:	83 c4 10             	add    $0x10,%esp
}
80102bc1:	90                   	nop
80102bc2:	c9                   	leave  
80102bc3:	c3                   	ret    

80102bc4 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102bc4:	55                   	push   %ebp
80102bc5:	89 e5                	mov    %esp,%ebp
80102bc7:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
80102bca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102bce:	75 0d                	jne    80102bdd <idestart+0x19>
    panic("idestart");
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	68 24 95 10 80       	push   $0x80109524
80102bd8:	e8 a5 d9 ff ff       	call   80100582 <panic>

  idewait(0);
80102bdd:	83 ec 0c             	sub    $0xc,%esp
80102be0:	6a 00                	push   $0x0
80102be2:	e8 ea fe ff ff       	call   80102ad1 <idewait>
80102be7:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102bea:	83 ec 08             	sub    $0x8,%esp
80102bed:	6a 00                	push   $0x0
80102bef:	68 f6 03 00 00       	push   $0x3f6
80102bf4:	e8 93 fe ff ff       	call   80102a8c <outb>
80102bf9:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
80102bfc:	83 ec 08             	sub    $0x8,%esp
80102bff:	6a 01                	push   $0x1
80102c01:	68 f2 01 00 00       	push   $0x1f2
80102c06:	e8 81 fe ff ff       	call   80102a8c <outb>
80102c0b:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
80102c0e:	8b 45 08             	mov    0x8(%ebp),%eax
80102c11:	8b 40 08             	mov    0x8(%eax),%eax
80102c14:	0f b6 c0             	movzbl %al,%eax
80102c17:	83 ec 08             	sub    $0x8,%esp
80102c1a:	50                   	push   %eax
80102c1b:	68 f3 01 00 00       	push   $0x1f3
80102c20:	e8 67 fe ff ff       	call   80102a8c <outb>
80102c25:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
80102c28:	8b 45 08             	mov    0x8(%ebp),%eax
80102c2b:	8b 40 08             	mov    0x8(%eax),%eax
80102c2e:	c1 e8 08             	shr    $0x8,%eax
80102c31:	0f b6 c0             	movzbl %al,%eax
80102c34:	83 ec 08             	sub    $0x8,%esp
80102c37:	50                   	push   %eax
80102c38:	68 f4 01 00 00       	push   $0x1f4
80102c3d:	e8 4a fe ff ff       	call   80102a8c <outb>
80102c42:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102c45:	8b 45 08             	mov    0x8(%ebp),%eax
80102c48:	8b 40 08             	mov    0x8(%eax),%eax
80102c4b:	c1 e8 10             	shr    $0x10,%eax
80102c4e:	0f b6 c0             	movzbl %al,%eax
80102c51:	83 ec 08             	sub    $0x8,%esp
80102c54:	50                   	push   %eax
80102c55:	68 f5 01 00 00       	push   $0x1f5
80102c5a:	e8 2d fe ff ff       	call   80102a8c <outb>
80102c5f:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102c62:	8b 45 08             	mov    0x8(%ebp),%eax
80102c65:	8b 40 04             	mov    0x4(%eax),%eax
80102c68:	83 e0 01             	and    $0x1,%eax
80102c6b:	c1 e0 04             	shl    $0x4,%eax
80102c6e:	89 c2                	mov    %eax,%edx
80102c70:	8b 45 08             	mov    0x8(%ebp),%eax
80102c73:	8b 40 08             	mov    0x8(%eax),%eax
80102c76:	c1 e8 18             	shr    $0x18,%eax
80102c79:	83 e0 0f             	and    $0xf,%eax
80102c7c:	09 d0                	or     %edx,%eax
80102c7e:	83 c8 e0             	or     $0xffffffe0,%eax
80102c81:	0f b6 c0             	movzbl %al,%eax
80102c84:	83 ec 08             	sub    $0x8,%esp
80102c87:	50                   	push   %eax
80102c88:	68 f6 01 00 00       	push   $0x1f6
80102c8d:	e8 fa fd ff ff       	call   80102a8c <outb>
80102c92:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102c95:	8b 45 08             	mov    0x8(%ebp),%eax
80102c98:	8b 00                	mov    (%eax),%eax
80102c9a:	83 e0 04             	and    $0x4,%eax
80102c9d:	85 c0                	test   %eax,%eax
80102c9f:	74 30                	je     80102cd1 <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
80102ca1:	83 ec 08             	sub    $0x8,%esp
80102ca4:	6a 30                	push   $0x30
80102ca6:	68 f7 01 00 00       	push   $0x1f7
80102cab:	e8 dc fd ff ff       	call   80102a8c <outb>
80102cb0:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102cb3:	8b 45 08             	mov    0x8(%ebp),%eax
80102cb6:	83 c0 18             	add    $0x18,%eax
80102cb9:	83 ec 04             	sub    $0x4,%esp
80102cbc:	68 80 00 00 00       	push   $0x80
80102cc1:	50                   	push   %eax
80102cc2:	68 f0 01 00 00       	push   $0x1f0
80102cc7:	e8 df fd ff ff       	call   80102aab <outsl>
80102ccc:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
80102ccf:	eb 12                	jmp    80102ce3 <idestart+0x11f>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102cd1:	83 ec 08             	sub    $0x8,%esp
80102cd4:	6a 20                	push   $0x20
80102cd6:	68 f7 01 00 00       	push   $0x1f7
80102cdb:	e8 ac fd ff ff       	call   80102a8c <outb>
80102ce0:	83 c4 10             	add    $0x10,%esp
  }
}
80102ce3:	90                   	nop
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    

80102ce6 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102ce6:	55                   	push   %ebp
80102ce7:	89 e5                	mov    %esp,%ebp
80102ce9:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102cec:	83 ec 0c             	sub    $0xc,%esp
80102cef:	68 40 c6 10 80       	push   $0x8010c640
80102cf4:	e8 1d 24 00 00       	call   80105116 <acquire>
80102cf9:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102cfc:	a1 74 c6 10 80       	mov    0x8010c674,%eax
80102d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102d04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102d08:	75 15                	jne    80102d1f <ideintr+0x39>
    release(&idelock);
80102d0a:	83 ec 0c             	sub    $0xc,%esp
80102d0d:	68 40 c6 10 80       	push   $0x8010c640
80102d12:	e8 66 24 00 00       	call   8010517d <release>
80102d17:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102d1a:	e9 9a 00 00 00       	jmp    80102db9 <ideintr+0xd3>
  }
  idequeue = b->qnext;
80102d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d22:	8b 40 14             	mov    0x14(%eax),%eax
80102d25:	a3 74 c6 10 80       	mov    %eax,0x8010c674

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d2d:	8b 00                	mov    (%eax),%eax
80102d2f:	83 e0 04             	and    $0x4,%eax
80102d32:	85 c0                	test   %eax,%eax
80102d34:	75 2d                	jne    80102d63 <ideintr+0x7d>
80102d36:	83 ec 0c             	sub    $0xc,%esp
80102d39:	6a 01                	push   $0x1
80102d3b:	e8 91 fd ff ff       	call   80102ad1 <idewait>
80102d40:	83 c4 10             	add    $0x10,%esp
80102d43:	85 c0                	test   %eax,%eax
80102d45:	78 1c                	js     80102d63 <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
80102d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d4a:	83 c0 18             	add    $0x18,%eax
80102d4d:	83 ec 04             	sub    $0x4,%esp
80102d50:	68 80 00 00 00       	push   $0x80
80102d55:	50                   	push   %eax
80102d56:	68 f0 01 00 00       	push   $0x1f0
80102d5b:	e8 06 fd ff ff       	call   80102a66 <insl>
80102d60:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d66:	8b 00                	mov    (%eax),%eax
80102d68:	83 c8 02             	or     $0x2,%eax
80102d6b:	89 c2                	mov    %eax,%edx
80102d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d70:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d75:	8b 00                	mov    (%eax),%eax
80102d77:	83 e0 fb             	and    $0xfffffffb,%eax
80102d7a:	89 c2                	mov    %eax,%edx
80102d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d7f:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102d81:	83 ec 0c             	sub    $0xc,%esp
80102d84:	ff 75 f4             	pushl  -0xc(%ebp)
80102d87:	e8 7c 21 00 00       	call   80104f08 <wakeup>
80102d8c:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102d8f:	a1 74 c6 10 80       	mov    0x8010c674,%eax
80102d94:	85 c0                	test   %eax,%eax
80102d96:	74 11                	je     80102da9 <ideintr+0xc3>
    idestart(idequeue);
80102d98:	a1 74 c6 10 80       	mov    0x8010c674,%eax
80102d9d:	83 ec 0c             	sub    $0xc,%esp
80102da0:	50                   	push   %eax
80102da1:	e8 1e fe ff ff       	call   80102bc4 <idestart>
80102da6:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102da9:	83 ec 0c             	sub    $0xc,%esp
80102dac:	68 40 c6 10 80       	push   $0x8010c640
80102db1:	e8 c7 23 00 00       	call   8010517d <release>
80102db6:	83 c4 10             	add    $0x10,%esp
}
80102db9:	c9                   	leave  
80102dba:	c3                   	ret    

80102dbb <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102dbb:	55                   	push   %ebp
80102dbc:	89 e5                	mov    %esp,%ebp
80102dbe:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102dc1:	8b 45 08             	mov    0x8(%ebp),%eax
80102dc4:	8b 00                	mov    (%eax),%eax
80102dc6:	83 e0 01             	and    $0x1,%eax
80102dc9:	85 c0                	test   %eax,%eax
80102dcb:	75 0d                	jne    80102dda <iderw+0x1f>
    panic("iderw: buf not busy");
80102dcd:	83 ec 0c             	sub    $0xc,%esp
80102dd0:	68 2d 95 10 80       	push   $0x8010952d
80102dd5:	e8 a8 d7 ff ff       	call   80100582 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102dda:	8b 45 08             	mov    0x8(%ebp),%eax
80102ddd:	8b 00                	mov    (%eax),%eax
80102ddf:	83 e0 06             	and    $0x6,%eax
80102de2:	83 f8 02             	cmp    $0x2,%eax
80102de5:	75 0d                	jne    80102df4 <iderw+0x39>
    panic("iderw: nothing to do");
80102de7:	83 ec 0c             	sub    $0xc,%esp
80102dea:	68 41 95 10 80       	push   $0x80109541
80102def:	e8 8e d7 ff ff       	call   80100582 <panic>
  if(b->dev != 0 && !havedisk1)
80102df4:	8b 45 08             	mov    0x8(%ebp),%eax
80102df7:	8b 40 04             	mov    0x4(%eax),%eax
80102dfa:	85 c0                	test   %eax,%eax
80102dfc:	74 16                	je     80102e14 <iderw+0x59>
80102dfe:	a1 78 c6 10 80       	mov    0x8010c678,%eax
80102e03:	85 c0                	test   %eax,%eax
80102e05:	75 0d                	jne    80102e14 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
80102e07:	83 ec 0c             	sub    $0xc,%esp
80102e0a:	68 56 95 10 80       	push   $0x80109556
80102e0f:	e8 6e d7 ff ff       	call   80100582 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 40 c6 10 80       	push   $0x8010c640
80102e1c:	e8 f5 22 00 00       	call   80105116 <acquire>
80102e21:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102e24:	8b 45 08             	mov    0x8(%ebp),%eax
80102e27:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102e2e:	c7 45 f4 74 c6 10 80 	movl   $0x8010c674,-0xc(%ebp)
80102e35:	eb 0b                	jmp    80102e42 <iderw+0x87>
80102e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e3a:	8b 00                	mov    (%eax),%eax
80102e3c:	83 c0 14             	add    $0x14,%eax
80102e3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e45:	8b 00                	mov    (%eax),%eax
80102e47:	85 c0                	test   %eax,%eax
80102e49:	75 ec                	jne    80102e37 <iderw+0x7c>
    ;
  *pp = b;
80102e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e4e:	8b 55 08             	mov    0x8(%ebp),%edx
80102e51:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102e53:	a1 74 c6 10 80       	mov    0x8010c674,%eax
80102e58:	3b 45 08             	cmp    0x8(%ebp),%eax
80102e5b:	75 23                	jne    80102e80 <iderw+0xc5>
    idestart(b);
80102e5d:	83 ec 0c             	sub    $0xc,%esp
80102e60:	ff 75 08             	pushl  0x8(%ebp)
80102e63:	e8 5c fd ff ff       	call   80102bc4 <idestart>
80102e68:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102e6b:	eb 13                	jmp    80102e80 <iderw+0xc5>
    sleep(b, &idelock);
80102e6d:	83 ec 08             	sub    $0x8,%esp
80102e70:	68 40 c6 10 80       	push   $0x8010c640
80102e75:	ff 75 08             	pushl  0x8(%ebp)
80102e78:	e8 a0 1f 00 00       	call   80104e1d <sleep>
80102e7d:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102e80:	8b 45 08             	mov    0x8(%ebp),%eax
80102e83:	8b 00                	mov    (%eax),%eax
80102e85:	83 e0 06             	and    $0x6,%eax
80102e88:	83 f8 02             	cmp    $0x2,%eax
80102e8b:	75 e0                	jne    80102e6d <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
80102e8d:	83 ec 0c             	sub    $0xc,%esp
80102e90:	68 40 c6 10 80       	push   $0x8010c640
80102e95:	e8 e3 22 00 00       	call   8010517d <release>
80102e9a:	83 c4 10             	add    $0x10,%esp
}
80102e9d:	90                   	nop
80102e9e:	c9                   	leave  
80102e9f:	c3                   	ret    

80102ea0 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102ea3:	a1 b4 09 11 80       	mov    0x801109b4,%eax
80102ea8:	8b 55 08             	mov    0x8(%ebp),%edx
80102eab:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102ead:	a1 b4 09 11 80       	mov    0x801109b4,%eax
80102eb2:	8b 40 10             	mov    0x10(%eax),%eax
}
80102eb5:	5d                   	pop    %ebp
80102eb6:	c3                   	ret    

80102eb7 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102eb7:	55                   	push   %ebp
80102eb8:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102eba:	a1 b4 09 11 80       	mov    0x801109b4,%eax
80102ebf:	8b 55 08             	mov    0x8(%ebp),%edx
80102ec2:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102ec4:	a1 b4 09 11 80       	mov    0x801109b4,%eax
80102ec9:	8b 55 0c             	mov    0xc(%ebp),%edx
80102ecc:	89 50 10             	mov    %edx,0x10(%eax)
}
80102ecf:	90                   	nop
80102ed0:	5d                   	pop    %ebp
80102ed1:	c3                   	ret    

80102ed2 <ioapicinit>:

void
ioapicinit(void)
{
80102ed2:	55                   	push   %ebp
80102ed3:	89 e5                	mov    %esp,%ebp
80102ed5:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102ed8:	a1 84 0a 11 80       	mov    0x80110a84,%eax
80102edd:	85 c0                	test   %eax,%eax
80102edf:	0f 84 a0 00 00 00    	je     80102f85 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102ee5:	c7 05 b4 09 11 80 00 	movl   $0xfec00000,0x801109b4
80102eec:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102eef:	6a 01                	push   $0x1
80102ef1:	e8 aa ff ff ff       	call   80102ea0 <ioapicread>
80102ef6:	83 c4 04             	add    $0x4,%esp
80102ef9:	c1 e8 10             	shr    $0x10,%eax
80102efc:	25 ff 00 00 00       	and    $0xff,%eax
80102f01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102f04:	6a 00                	push   $0x0
80102f06:	e8 95 ff ff ff       	call   80102ea0 <ioapicread>
80102f0b:	83 c4 04             	add    $0x4,%esp
80102f0e:	c1 e8 18             	shr    $0x18,%eax
80102f11:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102f14:	0f b6 05 80 0a 11 80 	movzbl 0x80110a80,%eax
80102f1b:	0f b6 c0             	movzbl %al,%eax
80102f1e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102f21:	74 10                	je     80102f33 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102f23:	83 ec 0c             	sub    $0xc,%esp
80102f26:	68 74 95 10 80       	push   $0x80109574
80102f2b:	e8 b2 d4 ff ff       	call   801003e2 <cprintf>
80102f30:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102f33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102f3a:	eb 3f                	jmp    80102f7b <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f3f:	83 c0 20             	add    $0x20,%eax
80102f42:	0d 00 00 01 00       	or     $0x10000,%eax
80102f47:	89 c2                	mov    %eax,%edx
80102f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f4c:	83 c0 08             	add    $0x8,%eax
80102f4f:	01 c0                	add    %eax,%eax
80102f51:	83 ec 08             	sub    $0x8,%esp
80102f54:	52                   	push   %edx
80102f55:	50                   	push   %eax
80102f56:	e8 5c ff ff ff       	call   80102eb7 <ioapicwrite>
80102f5b:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102f5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f61:	83 c0 08             	add    $0x8,%eax
80102f64:	01 c0                	add    %eax,%eax
80102f66:	83 c0 01             	add    $0x1,%eax
80102f69:	83 ec 08             	sub    $0x8,%esp
80102f6c:	6a 00                	push   $0x0
80102f6e:	50                   	push   %eax
80102f6f:	e8 43 ff ff ff       	call   80102eb7 <ioapicwrite>
80102f74:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102f77:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102f7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f7e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102f81:	7e b9                	jle    80102f3c <ioapicinit+0x6a>
80102f83:	eb 01                	jmp    80102f86 <ioapicinit+0xb4>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102f85:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102f86:	c9                   	leave  
80102f87:	c3                   	ret    

80102f88 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102f88:	55                   	push   %ebp
80102f89:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102f8b:	a1 84 0a 11 80       	mov    0x80110a84,%eax
80102f90:	85 c0                	test   %eax,%eax
80102f92:	74 39                	je     80102fcd <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102f94:	8b 45 08             	mov    0x8(%ebp),%eax
80102f97:	83 c0 20             	add    $0x20,%eax
80102f9a:	89 c2                	mov    %eax,%edx
80102f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80102f9f:	83 c0 08             	add    $0x8,%eax
80102fa2:	01 c0                	add    %eax,%eax
80102fa4:	52                   	push   %edx
80102fa5:	50                   	push   %eax
80102fa6:	e8 0c ff ff ff       	call   80102eb7 <ioapicwrite>
80102fab:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102fae:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fb1:	c1 e0 18             	shl    $0x18,%eax
80102fb4:	89 c2                	mov    %eax,%edx
80102fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80102fb9:	83 c0 08             	add    $0x8,%eax
80102fbc:	01 c0                	add    %eax,%eax
80102fbe:	83 c0 01             	add    $0x1,%eax
80102fc1:	52                   	push   %edx
80102fc2:	50                   	push   %eax
80102fc3:	e8 ef fe ff ff       	call   80102eb7 <ioapicwrite>
80102fc8:	83 c4 08             	add    $0x8,%esp
80102fcb:	eb 01                	jmp    80102fce <ioapicenable+0x46>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102fcd:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102fce:	c9                   	leave  
80102fcf:	c3                   	ret    

80102fd0 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	8b 45 08             	mov    0x8(%ebp),%eax
80102fd6:	05 00 00 00 80       	add    $0x80000000,%eax
80102fdb:	5d                   	pop    %ebp
80102fdc:	c3                   	ret    

80102fdd <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102fdd:	55                   	push   %ebp
80102fde:	89 e5                	mov    %esp,%ebp
80102fe0:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102fe3:	83 ec 08             	sub    $0x8,%esp
80102fe6:	68 a6 95 10 80       	push   $0x801095a6
80102feb:	68 c0 09 11 80       	push   $0x801109c0
80102ff0:	e8 ff 20 00 00       	call   801050f4 <initlock>
80102ff5:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102ff8:	c7 05 f4 09 11 80 00 	movl   $0x0,0x801109f4
80102fff:	00 00 00 
  freerange(vstart, vend);
80103002:	83 ec 08             	sub    $0x8,%esp
80103005:	ff 75 0c             	pushl  0xc(%ebp)
80103008:	ff 75 08             	pushl  0x8(%ebp)
8010300b:	e8 2a 00 00 00       	call   8010303a <freerange>
80103010:	83 c4 10             	add    $0x10,%esp
}
80103013:	90                   	nop
80103014:	c9                   	leave  
80103015:	c3                   	ret    

80103016 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80103016:	55                   	push   %ebp
80103017:	89 e5                	mov    %esp,%ebp
80103019:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
8010301c:	83 ec 08             	sub    $0x8,%esp
8010301f:	ff 75 0c             	pushl  0xc(%ebp)
80103022:	ff 75 08             	pushl  0x8(%ebp)
80103025:	e8 10 00 00 00       	call   8010303a <freerange>
8010302a:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
8010302d:	c7 05 f4 09 11 80 01 	movl   $0x1,0x801109f4
80103034:	00 00 00 
}
80103037:	90                   	nop
80103038:	c9                   	leave  
80103039:	c3                   	ret    

8010303a <freerange>:

void
freerange(void *vstart, void *vend)
{
8010303a:	55                   	push   %ebp
8010303b:	89 e5                	mov    %esp,%ebp
8010303d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80103040:	8b 45 08             	mov    0x8(%ebp),%eax
80103043:	05 ff 0f 00 00       	add    $0xfff,%eax
80103048:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010304d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103050:	eb 15                	jmp    80103067 <freerange+0x2d>
    kfree(p);
80103052:	83 ec 0c             	sub    $0xc,%esp
80103055:	ff 75 f4             	pushl  -0xc(%ebp)
80103058:	e8 1a 00 00 00       	call   80103077 <kfree>
8010305d:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103060:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80103067:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010306a:	05 00 10 00 00       	add    $0x1000,%eax
8010306f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103072:	76 de                	jbe    80103052 <freerange+0x18>
    kfree(p);
}
80103074:	90                   	nop
80103075:	c9                   	leave  
80103076:	c3                   	ret    

80103077 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103077:	55                   	push   %ebp
80103078:	89 e5                	mov    %esp,%ebp
8010307a:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
8010307d:	8b 45 08             	mov    0x8(%ebp),%eax
80103080:	25 ff 0f 00 00       	and    $0xfff,%eax
80103085:	85 c0                	test   %eax,%eax
80103087:	75 1b                	jne    801030a4 <kfree+0x2d>
80103089:	81 7d 08 7c 38 11 80 	cmpl   $0x8011387c,0x8(%ebp)
80103090:	72 12                	jb     801030a4 <kfree+0x2d>
80103092:	ff 75 08             	pushl  0x8(%ebp)
80103095:	e8 36 ff ff ff       	call   80102fd0 <v2p>
8010309a:	83 c4 04             	add    $0x4,%esp
8010309d:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801030a2:	76 0d                	jbe    801030b1 <kfree+0x3a>
    panic("kfree");
801030a4:	83 ec 0c             	sub    $0xc,%esp
801030a7:	68 ab 95 10 80       	push   $0x801095ab
801030ac:	e8 d1 d4 ff ff       	call   80100582 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801030b1:	83 ec 04             	sub    $0x4,%esp
801030b4:	68 00 10 00 00       	push   $0x1000
801030b9:	6a 01                	push   $0x1
801030bb:	ff 75 08             	pushl  0x8(%ebp)
801030be:	e8 b6 22 00 00       	call   80105379 <memset>
801030c3:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
801030c6:	a1 f4 09 11 80       	mov    0x801109f4,%eax
801030cb:	85 c0                	test   %eax,%eax
801030cd:	74 10                	je     801030df <kfree+0x68>
    acquire(&kmem.lock);
801030cf:	83 ec 0c             	sub    $0xc,%esp
801030d2:	68 c0 09 11 80       	push   $0x801109c0
801030d7:	e8 3a 20 00 00       	call   80105116 <acquire>
801030dc:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
801030df:	8b 45 08             	mov    0x8(%ebp),%eax
801030e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
801030e5:	8b 15 f8 09 11 80    	mov    0x801109f8,%edx
801030eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030ee:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
801030f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030f3:	a3 f8 09 11 80       	mov    %eax,0x801109f8
  if(kmem.use_lock)
801030f8:	a1 f4 09 11 80       	mov    0x801109f4,%eax
801030fd:	85 c0                	test   %eax,%eax
801030ff:	74 10                	je     80103111 <kfree+0x9a>
    release(&kmem.lock);
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	68 c0 09 11 80       	push   $0x801109c0
80103109:	e8 6f 20 00 00       	call   8010517d <release>
8010310e:	83 c4 10             	add    $0x10,%esp
}
80103111:	90                   	nop
80103112:	c9                   	leave  
80103113:	c3                   	ret    

80103114 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103114:	55                   	push   %ebp
80103115:	89 e5                	mov    %esp,%ebp
80103117:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
8010311a:	a1 f4 09 11 80       	mov    0x801109f4,%eax
8010311f:	85 c0                	test   %eax,%eax
80103121:	74 10                	je     80103133 <kalloc+0x1f>
    acquire(&kmem.lock);
80103123:	83 ec 0c             	sub    $0xc,%esp
80103126:	68 c0 09 11 80       	push   $0x801109c0
8010312b:	e8 e6 1f 00 00       	call   80105116 <acquire>
80103130:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80103133:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80103138:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
8010313b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010313f:	74 0a                	je     8010314b <kalloc+0x37>
    kmem.freelist = r->next;
80103141:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103144:	8b 00                	mov    (%eax),%eax
80103146:	a3 f8 09 11 80       	mov    %eax,0x801109f8
  if(kmem.use_lock)
8010314b:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80103150:	85 c0                	test   %eax,%eax
80103152:	74 10                	je     80103164 <kalloc+0x50>
    release(&kmem.lock);
80103154:	83 ec 0c             	sub    $0xc,%esp
80103157:	68 c0 09 11 80       	push   $0x801109c0
8010315c:	e8 1c 20 00 00       	call   8010517d <release>
80103161:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80103164:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103167:	c9                   	leave  
80103168:	c3                   	ret    

80103169 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103169:	55                   	push   %ebp
8010316a:	89 e5                	mov    %esp,%ebp
8010316c:	83 ec 14             	sub    $0x14,%esp
8010316f:	8b 45 08             	mov    0x8(%ebp),%eax
80103172:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103176:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010317a:	89 c2                	mov    %eax,%edx
8010317c:	ec                   	in     (%dx),%al
8010317d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103180:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103184:	c9                   	leave  
80103185:	c3                   	ret    

80103186 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80103186:	55                   	push   %ebp
80103187:	89 e5                	mov    %esp,%ebp
80103189:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
8010318c:	6a 64                	push   $0x64
8010318e:	e8 d6 ff ff ff       	call   80103169 <inb>
80103193:	83 c4 04             	add    $0x4,%esp
80103196:	0f b6 c0             	movzbl %al,%eax
80103199:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
8010319c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010319f:	83 e0 01             	and    $0x1,%eax
801031a2:	85 c0                	test   %eax,%eax
801031a4:	75 0a                	jne    801031b0 <kbdgetc+0x2a>
    return -1;
801031a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031ab:	e9 23 01 00 00       	jmp    801032d3 <kbdgetc+0x14d>
  data = inb(KBDATAP);
801031b0:	6a 60                	push   $0x60
801031b2:	e8 b2 ff ff ff       	call   80103169 <inb>
801031b7:	83 c4 04             	add    $0x4,%esp
801031ba:	0f b6 c0             	movzbl %al,%eax
801031bd:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
801031c0:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
801031c7:	75 17                	jne    801031e0 <kbdgetc+0x5a>
    shift |= E0ESC;
801031c9:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
801031ce:	83 c8 40             	or     $0x40,%eax
801031d1:	a3 7c c6 10 80       	mov    %eax,0x8010c67c
    return 0;
801031d6:	b8 00 00 00 00       	mov    $0x0,%eax
801031db:	e9 f3 00 00 00       	jmp    801032d3 <kbdgetc+0x14d>
  } else if(data & 0x80){
801031e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801031e3:	25 80 00 00 00       	and    $0x80,%eax
801031e8:	85 c0                	test   %eax,%eax
801031ea:	74 45                	je     80103231 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801031ec:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
801031f1:	83 e0 40             	and    $0x40,%eax
801031f4:	85 c0                	test   %eax,%eax
801031f6:	75 08                	jne    80103200 <kbdgetc+0x7a>
801031f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801031fb:	83 e0 7f             	and    $0x7f,%eax
801031fe:	eb 03                	jmp    80103203 <kbdgetc+0x7d>
80103200:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103203:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80103206:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103209:	05 80 a0 10 80       	add    $0x8010a080,%eax
8010320e:	0f b6 00             	movzbl (%eax),%eax
80103211:	83 c8 40             	or     $0x40,%eax
80103214:	0f b6 c0             	movzbl %al,%eax
80103217:	f7 d0                	not    %eax
80103219:	89 c2                	mov    %eax,%edx
8010321b:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
80103220:	21 d0                	and    %edx,%eax
80103222:	a3 7c c6 10 80       	mov    %eax,0x8010c67c
    return 0;
80103227:	b8 00 00 00 00       	mov    $0x0,%eax
8010322c:	e9 a2 00 00 00       	jmp    801032d3 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80103231:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
80103236:	83 e0 40             	and    $0x40,%eax
80103239:	85 c0                	test   %eax,%eax
8010323b:	74 14                	je     80103251 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010323d:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80103244:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
80103249:	83 e0 bf             	and    $0xffffffbf,%eax
8010324c:	a3 7c c6 10 80       	mov    %eax,0x8010c67c
  }

  shift |= shiftcode[data];
80103251:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103254:	05 80 a0 10 80       	add    $0x8010a080,%eax
80103259:	0f b6 00             	movzbl (%eax),%eax
8010325c:	0f b6 d0             	movzbl %al,%edx
8010325f:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
80103264:	09 d0                	or     %edx,%eax
80103266:	a3 7c c6 10 80       	mov    %eax,0x8010c67c
  shift ^= togglecode[data];
8010326b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010326e:	05 80 a1 10 80       	add    $0x8010a180,%eax
80103273:	0f b6 00             	movzbl (%eax),%eax
80103276:	0f b6 d0             	movzbl %al,%edx
80103279:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
8010327e:	31 d0                	xor    %edx,%eax
80103280:	a3 7c c6 10 80       	mov    %eax,0x8010c67c
  c = charcode[shift & (CTL | SHIFT)][data];
80103285:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
8010328a:	83 e0 03             	and    $0x3,%eax
8010328d:	8b 14 85 80 a5 10 80 	mov    -0x7fef5a80(,%eax,4),%edx
80103294:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103297:	01 d0                	add    %edx,%eax
80103299:	0f b6 00             	movzbl (%eax),%eax
8010329c:	0f b6 c0             	movzbl %al,%eax
8010329f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
801032a2:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
801032a7:	83 e0 08             	and    $0x8,%eax
801032aa:	85 c0                	test   %eax,%eax
801032ac:	74 22                	je     801032d0 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
801032ae:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
801032b2:	76 0c                	jbe    801032c0 <kbdgetc+0x13a>
801032b4:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
801032b8:	77 06                	ja     801032c0 <kbdgetc+0x13a>
      c += 'A' - 'a';
801032ba:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
801032be:	eb 10                	jmp    801032d0 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
801032c0:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
801032c4:	76 0a                	jbe    801032d0 <kbdgetc+0x14a>
801032c6:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
801032ca:	77 04                	ja     801032d0 <kbdgetc+0x14a>
      c += 'a' - 'A';
801032cc:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
801032d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801032d3:	c9                   	leave  
801032d4:	c3                   	ret    

801032d5 <kbdintr>:

void
kbdintr(void)
{
801032d5:	55                   	push   %ebp
801032d6:	89 e5                	mov    %esp,%ebp
801032d8:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
801032db:	83 ec 0c             	sub    $0xc,%esp
801032de:	68 86 31 10 80       	push   $0x80103186
801032e3:	e8 a9 d5 ff ff       	call   80100891 <consoleintr>
801032e8:	83 c4 10             	add    $0x10,%esp
}
801032eb:	90                   	nop
801032ec:	c9                   	leave  
801032ed:	c3                   	ret    

801032ee <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801032ee:	55                   	push   %ebp
801032ef:	89 e5                	mov    %esp,%ebp
801032f1:	83 ec 08             	sub    $0x8,%esp
801032f4:	8b 55 08             	mov    0x8(%ebp),%edx
801032f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801032fa:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801032fe:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103301:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103305:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103309:	ee                   	out    %al,(%dx)
}
8010330a:	90                   	nop
8010330b:	c9                   	leave  
8010330c:	c3                   	ret    

8010330d <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
8010330d:	55                   	push   %ebp
8010330e:	89 e5                	mov    %esp,%ebp
80103310:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103313:	9c                   	pushf  
80103314:	58                   	pop    %eax
80103315:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103318:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010331b:	c9                   	leave  
8010331c:	c3                   	ret    

8010331d <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
8010331d:	55                   	push   %ebp
8010331e:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103320:	a1 fc 09 11 80       	mov    0x801109fc,%eax
80103325:	8b 55 08             	mov    0x8(%ebp),%edx
80103328:	c1 e2 02             	shl    $0x2,%edx
8010332b:	01 c2                	add    %eax,%edx
8010332d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103330:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80103332:	a1 fc 09 11 80       	mov    0x801109fc,%eax
80103337:	83 c0 20             	add    $0x20,%eax
8010333a:	8b 00                	mov    (%eax),%eax
}
8010333c:	90                   	nop
8010333d:	5d                   	pop    %ebp
8010333e:	c3                   	ret    

8010333f <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
8010333f:	55                   	push   %ebp
80103340:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80103342:	a1 fc 09 11 80       	mov    0x801109fc,%eax
80103347:	85 c0                	test   %eax,%eax
80103349:	0f 84 0b 01 00 00    	je     8010345a <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
8010334f:	68 3f 01 00 00       	push   $0x13f
80103354:	6a 3c                	push   $0x3c
80103356:	e8 c2 ff ff ff       	call   8010331d <lapicw>
8010335b:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
8010335e:	6a 0b                	push   $0xb
80103360:	68 f8 00 00 00       	push   $0xf8
80103365:	e8 b3 ff ff ff       	call   8010331d <lapicw>
8010336a:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
8010336d:	68 20 00 02 00       	push   $0x20020
80103372:	68 c8 00 00 00       	push   $0xc8
80103377:	e8 a1 ff ff ff       	call   8010331d <lapicw>
8010337c:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
8010337f:	68 80 96 98 00       	push   $0x989680
80103384:	68 e0 00 00 00       	push   $0xe0
80103389:	e8 8f ff ff ff       	call   8010331d <lapicw>
8010338e:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103391:	68 00 00 01 00       	push   $0x10000
80103396:	68 d4 00 00 00       	push   $0xd4
8010339b:	e8 7d ff ff ff       	call   8010331d <lapicw>
801033a0:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801033a3:	68 00 00 01 00       	push   $0x10000
801033a8:	68 d8 00 00 00       	push   $0xd8
801033ad:	e8 6b ff ff ff       	call   8010331d <lapicw>
801033b2:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801033b5:	a1 fc 09 11 80       	mov    0x801109fc,%eax
801033ba:	83 c0 30             	add    $0x30,%eax
801033bd:	8b 00                	mov    (%eax),%eax
801033bf:	c1 e8 10             	shr    $0x10,%eax
801033c2:	0f b6 c0             	movzbl %al,%eax
801033c5:	83 f8 03             	cmp    $0x3,%eax
801033c8:	76 12                	jbe    801033dc <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
801033ca:	68 00 00 01 00       	push   $0x10000
801033cf:	68 d0 00 00 00       	push   $0xd0
801033d4:	e8 44 ff ff ff       	call   8010331d <lapicw>
801033d9:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801033dc:	6a 33                	push   $0x33
801033de:	68 dc 00 00 00       	push   $0xdc
801033e3:	e8 35 ff ff ff       	call   8010331d <lapicw>
801033e8:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
801033eb:	6a 00                	push   $0x0
801033ed:	68 a0 00 00 00       	push   $0xa0
801033f2:	e8 26 ff ff ff       	call   8010331d <lapicw>
801033f7:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
801033fa:	6a 00                	push   $0x0
801033fc:	68 a0 00 00 00       	push   $0xa0
80103401:	e8 17 ff ff ff       	call   8010331d <lapicw>
80103406:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103409:	6a 00                	push   $0x0
8010340b:	6a 2c                	push   $0x2c
8010340d:	e8 0b ff ff ff       	call   8010331d <lapicw>
80103412:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80103415:	6a 00                	push   $0x0
80103417:	68 c4 00 00 00       	push   $0xc4
8010341c:	e8 fc fe ff ff       	call   8010331d <lapicw>
80103421:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103424:	68 00 85 08 00       	push   $0x88500
80103429:	68 c0 00 00 00       	push   $0xc0
8010342e:	e8 ea fe ff ff       	call   8010331d <lapicw>
80103433:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103436:	90                   	nop
80103437:	a1 fc 09 11 80       	mov    0x801109fc,%eax
8010343c:	05 00 03 00 00       	add    $0x300,%eax
80103441:	8b 00                	mov    (%eax),%eax
80103443:	25 00 10 00 00       	and    $0x1000,%eax
80103448:	85 c0                	test   %eax,%eax
8010344a:	75 eb                	jne    80103437 <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010344c:	6a 00                	push   $0x0
8010344e:	6a 20                	push   $0x20
80103450:	e8 c8 fe ff ff       	call   8010331d <lapicw>
80103455:	83 c4 08             	add    $0x8,%esp
80103458:	eb 01                	jmp    8010345b <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
8010345a:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
8010345b:	c9                   	leave  
8010345c:	c3                   	ret    

8010345d <cpunum>:

int
cpunum(void)
{
8010345d:	55                   	push   %ebp
8010345e:	89 e5                	mov    %esp,%ebp
80103460:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103463:	e8 a5 fe ff ff       	call   8010330d <readeflags>
80103468:	25 00 02 00 00       	and    $0x200,%eax
8010346d:	85 c0                	test   %eax,%eax
8010346f:	74 26                	je     80103497 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103471:	a1 80 c6 10 80       	mov    0x8010c680,%eax
80103476:	8d 50 01             	lea    0x1(%eax),%edx
80103479:	89 15 80 c6 10 80    	mov    %edx,0x8010c680
8010347f:	85 c0                	test   %eax,%eax
80103481:	75 14                	jne    80103497 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103483:	8b 45 04             	mov    0x4(%ebp),%eax
80103486:	83 ec 08             	sub    $0x8,%esp
80103489:	50                   	push   %eax
8010348a:	68 b4 95 10 80       	push   $0x801095b4
8010348f:	e8 4e cf ff ff       	call   801003e2 <cprintf>
80103494:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80103497:	a1 fc 09 11 80       	mov    0x801109fc,%eax
8010349c:	85 c0                	test   %eax,%eax
8010349e:	74 0f                	je     801034af <cpunum+0x52>
    return lapic[ID]>>24;
801034a0:	a1 fc 09 11 80       	mov    0x801109fc,%eax
801034a5:	83 c0 20             	add    $0x20,%eax
801034a8:	8b 00                	mov    (%eax),%eax
801034aa:	c1 e8 18             	shr    $0x18,%eax
801034ad:	eb 05                	jmp    801034b4 <cpunum+0x57>
  return 0;
801034af:	b8 00 00 00 00       	mov    $0x0,%eax
}
801034b4:	c9                   	leave  
801034b5:	c3                   	ret    

801034b6 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801034b6:	55                   	push   %ebp
801034b7:	89 e5                	mov    %esp,%ebp
  if(lapic)
801034b9:	a1 fc 09 11 80       	mov    0x801109fc,%eax
801034be:	85 c0                	test   %eax,%eax
801034c0:	74 0c                	je     801034ce <lapiceoi+0x18>
    lapicw(EOI, 0);
801034c2:	6a 00                	push   $0x0
801034c4:	6a 2c                	push   $0x2c
801034c6:	e8 52 fe ff ff       	call   8010331d <lapicw>
801034cb:	83 c4 08             	add    $0x8,%esp
}
801034ce:	90                   	nop
801034cf:	c9                   	leave  
801034d0:	c3                   	ret    

801034d1 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801034d1:	55                   	push   %ebp
801034d2:	89 e5                	mov    %esp,%ebp
}
801034d4:	90                   	nop
801034d5:	5d                   	pop    %ebp
801034d6:	c3                   	ret    

801034d7 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801034d7:	55                   	push   %ebp
801034d8:	89 e5                	mov    %esp,%ebp
801034da:	83 ec 14             	sub    $0x14,%esp
801034dd:	8b 45 08             	mov    0x8(%ebp),%eax
801034e0:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
801034e3:	6a 0f                	push   $0xf
801034e5:	6a 70                	push   $0x70
801034e7:	e8 02 fe ff ff       	call   801032ee <outb>
801034ec:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
801034ef:	6a 0a                	push   $0xa
801034f1:	6a 71                	push   $0x71
801034f3:	e8 f6 fd ff ff       	call   801032ee <outb>
801034f8:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801034fb:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103502:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103505:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010350a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010350d:	83 c0 02             	add    $0x2,%eax
80103510:	8b 55 0c             	mov    0xc(%ebp),%edx
80103513:	c1 ea 04             	shr    $0x4,%edx
80103516:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103519:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010351d:	c1 e0 18             	shl    $0x18,%eax
80103520:	50                   	push   %eax
80103521:	68 c4 00 00 00       	push   $0xc4
80103526:	e8 f2 fd ff ff       	call   8010331d <lapicw>
8010352b:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
8010352e:	68 00 c5 00 00       	push   $0xc500
80103533:	68 c0 00 00 00       	push   $0xc0
80103538:	e8 e0 fd ff ff       	call   8010331d <lapicw>
8010353d:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103540:	68 c8 00 00 00       	push   $0xc8
80103545:	e8 87 ff ff ff       	call   801034d1 <microdelay>
8010354a:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
8010354d:	68 00 85 00 00       	push   $0x8500
80103552:	68 c0 00 00 00       	push   $0xc0
80103557:	e8 c1 fd ff ff       	call   8010331d <lapicw>
8010355c:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
8010355f:	6a 64                	push   $0x64
80103561:	e8 6b ff ff ff       	call   801034d1 <microdelay>
80103566:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103569:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103570:	eb 3d                	jmp    801035af <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103572:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103576:	c1 e0 18             	shl    $0x18,%eax
80103579:	50                   	push   %eax
8010357a:	68 c4 00 00 00       	push   $0xc4
8010357f:	e8 99 fd ff ff       	call   8010331d <lapicw>
80103584:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103587:	8b 45 0c             	mov    0xc(%ebp),%eax
8010358a:	c1 e8 0c             	shr    $0xc,%eax
8010358d:	80 cc 06             	or     $0x6,%ah
80103590:	50                   	push   %eax
80103591:	68 c0 00 00 00       	push   $0xc0
80103596:	e8 82 fd ff ff       	call   8010331d <lapicw>
8010359b:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
8010359e:	68 c8 00 00 00       	push   $0xc8
801035a3:	e8 29 ff ff ff       	call   801034d1 <microdelay>
801035a8:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801035ab:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801035af:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801035b3:	7e bd                	jle    80103572 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801035b5:	90                   	nop
801035b6:	c9                   	leave  
801035b7:	c3                   	ret    

801035b8 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
801035b8:	55                   	push   %ebp
801035b9:	89 e5                	mov    %esp,%ebp
801035bb:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801035be:	83 ec 08             	sub    $0x8,%esp
801035c1:	68 e0 95 10 80       	push   $0x801095e0
801035c6:	68 00 0a 11 80       	push   $0x80110a00
801035cb:	e8 24 1b 00 00       	call   801050f4 <initlock>
801035d0:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
801035d3:	83 ec 08             	sub    $0x8,%esp
801035d6:	8d 45 e8             	lea    -0x18(%ebp),%eax
801035d9:	50                   	push   %eax
801035da:	6a 01                	push   $0x1
801035dc:	e8 d7 e2 ff ff       	call   801018b8 <readsb>
801035e1:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
801035e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801035e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035ea:	29 c2                	sub    %eax,%edx
801035ec:	89 d0                	mov    %edx,%eax
801035ee:	a3 34 0a 11 80       	mov    %eax,0x80110a34
  log.size = sb.nlog;
801035f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035f6:	a3 38 0a 11 80       	mov    %eax,0x80110a38
  log.dev = ROOTDEV;
801035fb:	c7 05 40 0a 11 80 01 	movl   $0x1,0x80110a40
80103602:	00 00 00 
  recover_from_log();
80103605:	e8 b2 01 00 00       	call   801037bc <recover_from_log>
}
8010360a:	90                   	nop
8010360b:	c9                   	leave  
8010360c:	c3                   	ret    

8010360d <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010360d:	55                   	push   %ebp
8010360e:	89 e5                	mov    %esp,%ebp
80103610:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103613:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010361a:	e9 95 00 00 00       	jmp    801036b4 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010361f:	8b 15 34 0a 11 80    	mov    0x80110a34,%edx
80103625:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103628:	01 d0                	add    %edx,%eax
8010362a:	83 c0 01             	add    $0x1,%eax
8010362d:	89 c2                	mov    %eax,%edx
8010362f:	a1 40 0a 11 80       	mov    0x80110a40,%eax
80103634:	83 ec 08             	sub    $0x8,%esp
80103637:	52                   	push   %edx
80103638:	50                   	push   %eax
80103639:	e8 78 cb ff ff       	call   801001b6 <bread>
8010363e:	83 c4 10             	add    $0x10,%esp
80103641:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103644:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103647:	83 c0 10             	add    $0x10,%eax
8010364a:	8b 04 85 08 0a 11 80 	mov    -0x7feef5f8(,%eax,4),%eax
80103651:	89 c2                	mov    %eax,%edx
80103653:	a1 40 0a 11 80       	mov    0x80110a40,%eax
80103658:	83 ec 08             	sub    $0x8,%esp
8010365b:	52                   	push   %edx
8010365c:	50                   	push   %eax
8010365d:	e8 54 cb ff ff       	call   801001b6 <bread>
80103662:	83 c4 10             	add    $0x10,%esp
80103665:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103668:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010366b:	8d 50 18             	lea    0x18(%eax),%edx
8010366e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103671:	83 c0 18             	add    $0x18,%eax
80103674:	83 ec 04             	sub    $0x4,%esp
80103677:	68 00 02 00 00       	push   $0x200
8010367c:	52                   	push   %edx
8010367d:	50                   	push   %eax
8010367e:	e8 b5 1d 00 00       	call   80105438 <memmove>
80103683:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103686:	83 ec 0c             	sub    $0xc,%esp
80103689:	ff 75 ec             	pushl  -0x14(%ebp)
8010368c:	e8 5e cb ff ff       	call   801001ef <bwrite>
80103691:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103694:	83 ec 0c             	sub    $0xc,%esp
80103697:	ff 75 f0             	pushl  -0x10(%ebp)
8010369a:	e8 8f cb ff ff       	call   8010022e <brelse>
8010369f:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801036a2:	83 ec 0c             	sub    $0xc,%esp
801036a5:	ff 75 ec             	pushl  -0x14(%ebp)
801036a8:	e8 81 cb ff ff       	call   8010022e <brelse>
801036ad:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801036b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801036b4:	a1 44 0a 11 80       	mov    0x80110a44,%eax
801036b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036bc:	0f 8f 5d ff ff ff    	jg     8010361f <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801036c2:	90                   	nop
801036c3:	c9                   	leave  
801036c4:	c3                   	ret    

801036c5 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801036c5:	55                   	push   %ebp
801036c6:	89 e5                	mov    %esp,%ebp
801036c8:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801036cb:	a1 34 0a 11 80       	mov    0x80110a34,%eax
801036d0:	89 c2                	mov    %eax,%edx
801036d2:	a1 40 0a 11 80       	mov    0x80110a40,%eax
801036d7:	83 ec 08             	sub    $0x8,%esp
801036da:	52                   	push   %edx
801036db:	50                   	push   %eax
801036dc:	e8 d5 ca ff ff       	call   801001b6 <bread>
801036e1:	83 c4 10             	add    $0x10,%esp
801036e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801036e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ea:	83 c0 18             	add    $0x18,%eax
801036ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801036f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036f3:	8b 00                	mov    (%eax),%eax
801036f5:	a3 44 0a 11 80       	mov    %eax,0x80110a44
  for (i = 0; i < log.lh.n; i++) {
801036fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103701:	eb 1b                	jmp    8010371e <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
80103703:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103706:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103709:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010370d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103710:	83 c2 10             	add    $0x10,%edx
80103713:	89 04 95 08 0a 11 80 	mov    %eax,-0x7feef5f8(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010371a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010371e:	a1 44 0a 11 80       	mov    0x80110a44,%eax
80103723:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103726:	7f db                	jg     80103703 <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103728:	83 ec 0c             	sub    $0xc,%esp
8010372b:	ff 75 f0             	pushl  -0x10(%ebp)
8010372e:	e8 fb ca ff ff       	call   8010022e <brelse>
80103733:	83 c4 10             	add    $0x10,%esp
}
80103736:	90                   	nop
80103737:	c9                   	leave  
80103738:	c3                   	ret    

80103739 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103739:	55                   	push   %ebp
8010373a:	89 e5                	mov    %esp,%ebp
8010373c:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010373f:	a1 34 0a 11 80       	mov    0x80110a34,%eax
80103744:	89 c2                	mov    %eax,%edx
80103746:	a1 40 0a 11 80       	mov    0x80110a40,%eax
8010374b:	83 ec 08             	sub    $0x8,%esp
8010374e:	52                   	push   %edx
8010374f:	50                   	push   %eax
80103750:	e8 61 ca ff ff       	call   801001b6 <bread>
80103755:	83 c4 10             	add    $0x10,%esp
80103758:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010375b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010375e:	83 c0 18             	add    $0x18,%eax
80103761:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103764:	8b 15 44 0a 11 80    	mov    0x80110a44,%edx
8010376a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010376d:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010376f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103776:	eb 1b                	jmp    80103793 <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
80103778:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010377b:	83 c0 10             	add    $0x10,%eax
8010377e:	8b 0c 85 08 0a 11 80 	mov    -0x7feef5f8(,%eax,4),%ecx
80103785:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103788:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010378b:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010378f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103793:	a1 44 0a 11 80       	mov    0x80110a44,%eax
80103798:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010379b:	7f db                	jg     80103778 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
8010379d:	83 ec 0c             	sub    $0xc,%esp
801037a0:	ff 75 f0             	pushl  -0x10(%ebp)
801037a3:	e8 47 ca ff ff       	call   801001ef <bwrite>
801037a8:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801037ab:	83 ec 0c             	sub    $0xc,%esp
801037ae:	ff 75 f0             	pushl  -0x10(%ebp)
801037b1:	e8 78 ca ff ff       	call   8010022e <brelse>
801037b6:	83 c4 10             	add    $0x10,%esp
}
801037b9:	90                   	nop
801037ba:	c9                   	leave  
801037bb:	c3                   	ret    

801037bc <recover_from_log>:

static void
recover_from_log(void)
{
801037bc:	55                   	push   %ebp
801037bd:	89 e5                	mov    %esp,%ebp
801037bf:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801037c2:	e8 fe fe ff ff       	call   801036c5 <read_head>
  install_trans(); // if committed, copy from log to disk
801037c7:	e8 41 fe ff ff       	call   8010360d <install_trans>
  log.lh.n = 0;
801037cc:	c7 05 44 0a 11 80 00 	movl   $0x0,0x80110a44
801037d3:	00 00 00 
  write_head(); // clear the log
801037d6:	e8 5e ff ff ff       	call   80103739 <write_head>
}
801037db:	90                   	nop
801037dc:	c9                   	leave  
801037dd:	c3                   	ret    

801037de <begin_trans>:

void
begin_trans(void)
{
801037de:	55                   	push   %ebp
801037df:	89 e5                	mov    %esp,%ebp
801037e1:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801037e4:	83 ec 0c             	sub    $0xc,%esp
801037e7:	68 00 0a 11 80       	push   $0x80110a00
801037ec:	e8 25 19 00 00       	call   80105116 <acquire>
801037f1:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
801037f4:	eb 15                	jmp    8010380b <begin_trans+0x2d>
    sleep(&log, &log.lock);
801037f6:	83 ec 08             	sub    $0x8,%esp
801037f9:	68 00 0a 11 80       	push   $0x80110a00
801037fe:	68 00 0a 11 80       	push   $0x80110a00
80103803:	e8 15 16 00 00       	call   80104e1d <sleep>
80103808:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
8010380b:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
80103810:	85 c0                	test   %eax,%eax
80103812:	75 e2                	jne    801037f6 <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103814:	c7 05 3c 0a 11 80 01 	movl   $0x1,0x80110a3c
8010381b:	00 00 00 
  release(&log.lock);
8010381e:	83 ec 0c             	sub    $0xc,%esp
80103821:	68 00 0a 11 80       	push   $0x80110a00
80103826:	e8 52 19 00 00       	call   8010517d <release>
8010382b:	83 c4 10             	add    $0x10,%esp
}
8010382e:	90                   	nop
8010382f:	c9                   	leave  
80103830:	c3                   	ret    

80103831 <commit_trans>:

void
commit_trans(void)
{
80103831:	55                   	push   %ebp
80103832:	89 e5                	mov    %esp,%ebp
80103834:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103837:	a1 44 0a 11 80       	mov    0x80110a44,%eax
8010383c:	85 c0                	test   %eax,%eax
8010383e:	7e 19                	jle    80103859 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
80103840:	e8 f4 fe ff ff       	call   80103739 <write_head>
    install_trans(); // Now install writes to home locations
80103845:	e8 c3 fd ff ff       	call   8010360d <install_trans>
    log.lh.n = 0; 
8010384a:	c7 05 44 0a 11 80 00 	movl   $0x0,0x80110a44
80103851:	00 00 00 
    write_head();    // Erase the transaction from the log
80103854:	e8 e0 fe ff ff       	call   80103739 <write_head>
  }
  
  acquire(&log.lock);
80103859:	83 ec 0c             	sub    $0xc,%esp
8010385c:	68 00 0a 11 80       	push   $0x80110a00
80103861:	e8 b0 18 00 00       	call   80105116 <acquire>
80103866:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
80103869:	c7 05 3c 0a 11 80 00 	movl   $0x0,0x80110a3c
80103870:	00 00 00 
  wakeup(&log);
80103873:	83 ec 0c             	sub    $0xc,%esp
80103876:	68 00 0a 11 80       	push   $0x80110a00
8010387b:	e8 88 16 00 00       	call   80104f08 <wakeup>
80103880:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
80103883:	83 ec 0c             	sub    $0xc,%esp
80103886:	68 00 0a 11 80       	push   $0x80110a00
8010388b:	e8 ed 18 00 00       	call   8010517d <release>
80103890:	83 c4 10             	add    $0x10,%esp
}
80103893:	90                   	nop
80103894:	c9                   	leave  
80103895:	c3                   	ret    

80103896 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103896:	55                   	push   %ebp
80103897:	89 e5                	mov    %esp,%ebp
80103899:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010389c:	a1 44 0a 11 80       	mov    0x80110a44,%eax
801038a1:	83 f8 09             	cmp    $0x9,%eax
801038a4:	7f 12                	jg     801038b8 <log_write+0x22>
801038a6:	a1 44 0a 11 80       	mov    0x80110a44,%eax
801038ab:	8b 15 38 0a 11 80    	mov    0x80110a38,%edx
801038b1:	83 ea 01             	sub    $0x1,%edx
801038b4:	39 d0                	cmp    %edx,%eax
801038b6:	7c 0d                	jl     801038c5 <log_write+0x2f>
    panic("too big a transaction");
801038b8:	83 ec 0c             	sub    $0xc,%esp
801038bb:	68 e4 95 10 80       	push   $0x801095e4
801038c0:	e8 bd cc ff ff       	call   80100582 <panic>
  if (!log.busy)
801038c5:	a1 3c 0a 11 80       	mov    0x80110a3c,%eax
801038ca:	85 c0                	test   %eax,%eax
801038cc:	75 0d                	jne    801038db <log_write+0x45>
    panic("write outside of trans");
801038ce:	83 ec 0c             	sub    $0xc,%esp
801038d1:	68 fa 95 10 80       	push   $0x801095fa
801038d6:	e8 a7 cc ff ff       	call   80100582 <panic>

  for (i = 0; i < log.lh.n; i++) {
801038db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801038e2:	eb 1d                	jmp    80103901 <log_write+0x6b>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
801038e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038e7:	83 c0 10             	add    $0x10,%eax
801038ea:	8b 04 85 08 0a 11 80 	mov    -0x7feef5f8(,%eax,4),%eax
801038f1:	89 c2                	mov    %eax,%edx
801038f3:	8b 45 08             	mov    0x8(%ebp),%eax
801038f6:	8b 40 08             	mov    0x8(%eax),%eax
801038f9:	39 c2                	cmp    %eax,%edx
801038fb:	74 10                	je     8010390d <log_write+0x77>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
801038fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103901:	a1 44 0a 11 80       	mov    0x80110a44,%eax
80103906:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103909:	7f d9                	jg     801038e4 <log_write+0x4e>
8010390b:	eb 01                	jmp    8010390e <log_write+0x78>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
8010390d:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
8010390e:	8b 45 08             	mov    0x8(%ebp),%eax
80103911:	8b 40 08             	mov    0x8(%eax),%eax
80103914:	89 c2                	mov    %eax,%edx
80103916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103919:	83 c0 10             	add    $0x10,%eax
8010391c:	89 14 85 08 0a 11 80 	mov    %edx,-0x7feef5f8(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103923:	8b 15 34 0a 11 80    	mov    0x80110a34,%edx
80103929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010392c:	01 d0                	add    %edx,%eax
8010392e:	83 c0 01             	add    $0x1,%eax
80103931:	89 c2                	mov    %eax,%edx
80103933:	8b 45 08             	mov    0x8(%ebp),%eax
80103936:	8b 40 04             	mov    0x4(%eax),%eax
80103939:	83 ec 08             	sub    $0x8,%esp
8010393c:	52                   	push   %edx
8010393d:	50                   	push   %eax
8010393e:	e8 73 c8 ff ff       	call   801001b6 <bread>
80103943:	83 c4 10             	add    $0x10,%esp
80103946:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
80103949:	8b 45 08             	mov    0x8(%ebp),%eax
8010394c:	8d 50 18             	lea    0x18(%eax),%edx
8010394f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103952:	83 c0 18             	add    $0x18,%eax
80103955:	83 ec 04             	sub    $0x4,%esp
80103958:	68 00 02 00 00       	push   $0x200
8010395d:	52                   	push   %edx
8010395e:	50                   	push   %eax
8010395f:	e8 d4 1a 00 00       	call   80105438 <memmove>
80103964:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
80103967:	83 ec 0c             	sub    $0xc,%esp
8010396a:	ff 75 f0             	pushl  -0x10(%ebp)
8010396d:	e8 7d c8 ff ff       	call   801001ef <bwrite>
80103972:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
80103975:	83 ec 0c             	sub    $0xc,%esp
80103978:	ff 75 f0             	pushl  -0x10(%ebp)
8010397b:	e8 ae c8 ff ff       	call   8010022e <brelse>
80103980:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
80103983:	a1 44 0a 11 80       	mov    0x80110a44,%eax
80103988:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010398b:	75 0d                	jne    8010399a <log_write+0x104>
    log.lh.n++;
8010398d:	a1 44 0a 11 80       	mov    0x80110a44,%eax
80103992:	83 c0 01             	add    $0x1,%eax
80103995:	a3 44 0a 11 80       	mov    %eax,0x80110a44
  b->flags |= B_DIRTY; // XXX prevent eviction
8010399a:	8b 45 08             	mov    0x8(%ebp),%eax
8010399d:	8b 00                	mov    (%eax),%eax
8010399f:	83 c8 04             	or     $0x4,%eax
801039a2:	89 c2                	mov    %eax,%edx
801039a4:	8b 45 08             	mov    0x8(%ebp),%eax
801039a7:	89 10                	mov    %edx,(%eax)
}
801039a9:	90                   	nop
801039aa:	c9                   	leave  
801039ab:	c3                   	ret    

801039ac <v2p>:
801039ac:	55                   	push   %ebp
801039ad:	89 e5                	mov    %esp,%ebp
801039af:	8b 45 08             	mov    0x8(%ebp),%eax
801039b2:	05 00 00 00 80       	add    $0x80000000,%eax
801039b7:	5d                   	pop    %ebp
801039b8:	c3                   	ret    

801039b9 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801039b9:	55                   	push   %ebp
801039ba:	89 e5                	mov    %esp,%ebp
801039bc:	8b 45 08             	mov    0x8(%ebp),%eax
801039bf:	05 00 00 00 80       	add    $0x80000000,%eax
801039c4:	5d                   	pop    %ebp
801039c5:	c3                   	ret    

801039c6 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801039c6:	55                   	push   %ebp
801039c7:	89 e5                	mov    %esp,%ebp
801039c9:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801039cc:	8b 55 08             	mov    0x8(%ebp),%edx
801039cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801039d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
801039d5:	f0 87 02             	lock xchg %eax,(%edx)
801039d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801039db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801039de:	c9                   	leave  
801039df:	c3                   	ret    

801039e0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801039e0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801039e4:	83 e4 f0             	and    $0xfffffff0,%esp
801039e7:	ff 71 fc             	pushl  -0x4(%ecx)
801039ea:	55                   	push   %ebp
801039eb:	89 e5                	mov    %esp,%ebp
801039ed:	51                   	push   %ecx
801039ee:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801039f1:	83 ec 08             	sub    $0x8,%esp
801039f4:	68 00 00 40 80       	push   $0x80400000
801039f9:	68 7c 38 11 80       	push   $0x8011387c
801039fe:	e8 da f5 ff ff       	call   80102fdd <kinit1>
80103a03:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103a06:	e8 3a 48 00 00       	call   80108245 <kvmalloc>
  mpinit();        // collect info about this machine
80103a0b:	e8 48 04 00 00       	call   80103e58 <mpinit>
  lapicinit();
80103a10:	e8 2a f9 ff ff       	call   8010333f <lapicinit>
  seginit();       // set up segments
80103a15:	e8 d4 41 00 00       	call   80107bee <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103a1a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103a20:	0f b6 00             	movzbl (%eax),%eax
80103a23:	0f b6 c0             	movzbl %al,%eax
80103a26:	83 ec 08             	sub    $0x8,%esp
80103a29:	50                   	push   %eax
80103a2a:	68 11 96 10 80       	push   $0x80109611
80103a2f:	e8 ae c9 ff ff       	call   801003e2 <cprintf>
80103a34:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103a37:	e8 72 06 00 00       	call   801040ae <picinit>
  ioapicinit();    // another interrupt controller
80103a3c:	e8 91 f4 ff ff       	call   80102ed2 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103a41:	e8 81 d1 ff ff       	call   80100bc7 <consoleinit>
  uartinit();      // serial port
80103a46:	e8 ff 34 00 00       	call   80106f4a <uartinit>
  pinit();         // process table
80103a4b:	e8 5b 0b 00 00       	call   801045ab <pinit>
  tvinit();        // trap vectors
80103a50:	e8 bf 30 00 00       	call   80106b14 <tvinit>
  binit();         // buffer cache
80103a55:	e8 da c5 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103a5a:	e8 4a da ff ff       	call   801014a9 <fileinit>
  iinit();         // inode cache
80103a5f:	e8 23 e1 ff ff       	call   80101b87 <iinit>
  ideinit();       // disk
80103a64:	e8 ad f0 ff ff       	call   80102b16 <ideinit>
  if(!ismp)
80103a69:	a1 84 0a 11 80       	mov    0x80110a84,%eax
80103a6e:	85 c0                	test   %eax,%eax
80103a70:	75 05                	jne    80103a77 <main+0x97>
    timerinit();   // uniprocessor timer
80103a72:	e8 fa 2f 00 00       	call   80106a71 <timerinit>
  startothers();   // start other processors
80103a77:	e8 7f 00 00 00       	call   80103afb <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103a7c:	83 ec 08             	sub    $0x8,%esp
80103a7f:	68 00 00 00 8e       	push   $0x8e000000
80103a84:	68 00 00 40 80       	push   $0x80400000
80103a89:	e8 88 f5 ff ff       	call   80103016 <kinit2>
80103a8e:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103a91:	e8 39 0c 00 00       	call   801046cf <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103a96:	e8 1a 00 00 00       	call   80103ab5 <mpmain>

80103a9b <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103a9b:	55                   	push   %ebp
80103a9c:	89 e5                	mov    %esp,%ebp
80103a9e:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103aa1:	e8 b7 47 00 00       	call   8010825d <switchkvm>
  seginit();
80103aa6:	e8 43 41 00 00       	call   80107bee <seginit>
  lapicinit();
80103aab:	e8 8f f8 ff ff       	call   8010333f <lapicinit>
  mpmain();
80103ab0:	e8 00 00 00 00       	call   80103ab5 <mpmain>

80103ab5 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103ab5:	55                   	push   %ebp
80103ab6:	89 e5                	mov    %esp,%ebp
80103ab8:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103abb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103ac1:	0f b6 00             	movzbl (%eax),%eax
80103ac4:	0f b6 c0             	movzbl %al,%eax
80103ac7:	83 ec 08             	sub    $0x8,%esp
80103aca:	50                   	push   %eax
80103acb:	68 28 96 10 80       	push   $0x80109628
80103ad0:	e8 0d c9 ff ff       	call   801003e2 <cprintf>
80103ad5:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103ad8:	e8 ad 31 00 00       	call   80106c8a <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103add:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103ae3:	05 a8 00 00 00       	add    $0xa8,%eax
80103ae8:	83 ec 08             	sub    $0x8,%esp
80103aeb:	6a 01                	push   $0x1
80103aed:	50                   	push   %eax
80103aee:	e8 d3 fe ff ff       	call   801039c6 <xchg>
80103af3:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103af6:	e8 55 11 00 00       	call   80104c50 <scheduler>

80103afb <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103afb:	55                   	push   %ebp
80103afc:	89 e5                	mov    %esp,%ebp
80103afe:	53                   	push   %ebx
80103aff:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103b02:	68 00 70 00 00       	push   $0x7000
80103b07:	e8 ad fe ff ff       	call   801039b9 <p2v>
80103b0c:	83 c4 04             	add    $0x4,%esp
80103b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103b12:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103b17:	83 ec 04             	sub    $0x4,%esp
80103b1a:	50                   	push   %eax
80103b1b:	68 4c c5 10 80       	push   $0x8010c54c
80103b20:	ff 75 f0             	pushl  -0x10(%ebp)
80103b23:	e8 10 19 00 00       	call   80105438 <memmove>
80103b28:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103b2b:	c7 45 f4 a0 0a 11 80 	movl   $0x80110aa0,-0xc(%ebp)
80103b32:	e9 90 00 00 00       	jmp    80103bc7 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
80103b37:	e8 21 f9 ff ff       	call   8010345d <cpunum>
80103b3c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103b42:	05 a0 0a 11 80       	add    $0x80110aa0,%eax
80103b47:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103b4a:	74 73                	je     80103bbf <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103b4c:	e8 c3 f5 ff ff       	call   80103114 <kalloc>
80103b51:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b57:	83 e8 04             	sub    $0x4,%eax
80103b5a:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103b5d:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103b63:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103b65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b68:	83 e8 08             	sub    $0x8,%eax
80103b6b:	c7 00 9b 3a 10 80    	movl   $0x80103a9b,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b74:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103b77:	83 ec 0c             	sub    $0xc,%esp
80103b7a:	68 00 b0 10 80       	push   $0x8010b000
80103b7f:	e8 28 fe ff ff       	call   801039ac <v2p>
80103b84:	83 c4 10             	add    $0x10,%esp
80103b87:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103b89:	83 ec 0c             	sub    $0xc,%esp
80103b8c:	ff 75 f0             	pushl  -0x10(%ebp)
80103b8f:	e8 18 fe ff ff       	call   801039ac <v2p>
80103b94:	83 c4 10             	add    $0x10,%esp
80103b97:	89 c2                	mov    %eax,%edx
80103b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b9c:	0f b6 00             	movzbl (%eax),%eax
80103b9f:	0f b6 c0             	movzbl %al,%eax
80103ba2:	83 ec 08             	sub    $0x8,%esp
80103ba5:	52                   	push   %edx
80103ba6:	50                   	push   %eax
80103ba7:	e8 2b f9 ff ff       	call   801034d7 <lapicstartap>
80103bac:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103baf:	90                   	nop
80103bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bb3:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103bb9:	85 c0                	test   %eax,%eax
80103bbb:	74 f3                	je     80103bb0 <startothers+0xb5>
80103bbd:	eb 01                	jmp    80103bc0 <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103bbf:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103bc0:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103bc7:	a1 80 10 11 80       	mov    0x80111080,%eax
80103bcc:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103bd2:	05 a0 0a 11 80       	add    $0x80110aa0,%eax
80103bd7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103bda:	0f 87 57 ff ff ff    	ja     80103b37 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103be0:	90                   	nop
80103be1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103be4:	c9                   	leave  
80103be5:	c3                   	ret    

80103be6 <p2v>:
80103be6:	55                   	push   %ebp
80103be7:	89 e5                	mov    %esp,%ebp
80103be9:	8b 45 08             	mov    0x8(%ebp),%eax
80103bec:	05 00 00 00 80       	add    $0x80000000,%eax
80103bf1:	5d                   	pop    %ebp
80103bf2:	c3                   	ret    

80103bf3 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103bf3:	55                   	push   %ebp
80103bf4:	89 e5                	mov    %esp,%ebp
80103bf6:	83 ec 14             	sub    $0x14,%esp
80103bf9:	8b 45 08             	mov    0x8(%ebp),%eax
80103bfc:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103c00:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103c04:	89 c2                	mov    %eax,%edx
80103c06:	ec                   	in     (%dx),%al
80103c07:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103c0a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103c0e:	c9                   	leave  
80103c0f:	c3                   	ret    

80103c10 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	83 ec 08             	sub    $0x8,%esp
80103c16:	8b 55 08             	mov    0x8(%ebp),%edx
80103c19:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c1c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103c20:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103c23:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103c27:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103c2b:	ee                   	out    %al,(%dx)
}
80103c2c:	90                   	nop
80103c2d:	c9                   	leave  
80103c2e:	c3                   	ret    

80103c2f <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103c2f:	55                   	push   %ebp
80103c30:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103c32:	a1 84 c6 10 80       	mov    0x8010c684,%eax
80103c37:	89 c2                	mov    %eax,%edx
80103c39:	b8 a0 0a 11 80       	mov    $0x80110aa0,%eax
80103c3e:	29 c2                	sub    %eax,%edx
80103c40:	89 d0                	mov    %edx,%eax
80103c42:	c1 f8 02             	sar    $0x2,%eax
80103c45:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103c4b:	5d                   	pop    %ebp
80103c4c:	c3                   	ret    

80103c4d <sum>:

static uchar
sum(uchar *addr, int len)
{
80103c4d:	55                   	push   %ebp
80103c4e:	89 e5                	mov    %esp,%ebp
80103c50:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103c53:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103c5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103c61:	eb 15                	jmp    80103c78 <sum+0x2b>
    sum += addr[i];
80103c63:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103c66:	8b 45 08             	mov    0x8(%ebp),%eax
80103c69:	01 d0                	add    %edx,%eax
80103c6b:	0f b6 00             	movzbl (%eax),%eax
80103c6e:	0f b6 c0             	movzbl %al,%eax
80103c71:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103c74:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103c78:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103c7b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103c7e:	7c e3                	jl     80103c63 <sum+0x16>
    sum += addr[i];
  return sum;
80103c80:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103c83:	c9                   	leave  
80103c84:	c3                   	ret    

80103c85 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103c85:	55                   	push   %ebp
80103c86:	89 e5                	mov    %esp,%ebp
80103c88:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103c8b:	ff 75 08             	pushl  0x8(%ebp)
80103c8e:	e8 53 ff ff ff       	call   80103be6 <p2v>
80103c93:	83 c4 04             	add    $0x4,%esp
80103c96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103c99:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c9f:	01 d0                	add    %edx,%eax
80103ca1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103caa:	eb 36                	jmp    80103ce2 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103cac:	83 ec 04             	sub    $0x4,%esp
80103caf:	6a 04                	push   $0x4
80103cb1:	68 3c 96 10 80       	push   $0x8010963c
80103cb6:	ff 75 f4             	pushl  -0xc(%ebp)
80103cb9:	e8 22 17 00 00       	call   801053e0 <memcmp>
80103cbe:	83 c4 10             	add    $0x10,%esp
80103cc1:	85 c0                	test   %eax,%eax
80103cc3:	75 19                	jne    80103cde <mpsearch1+0x59>
80103cc5:	83 ec 08             	sub    $0x8,%esp
80103cc8:	6a 10                	push   $0x10
80103cca:	ff 75 f4             	pushl  -0xc(%ebp)
80103ccd:	e8 7b ff ff ff       	call   80103c4d <sum>
80103cd2:	83 c4 10             	add    $0x10,%esp
80103cd5:	84 c0                	test   %al,%al
80103cd7:	75 05                	jne    80103cde <mpsearch1+0x59>
      return (struct mp*)p;
80103cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cdc:	eb 11                	jmp    80103cef <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103cde:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ce5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103ce8:	72 c2                	jb     80103cac <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103cea:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103cef:	c9                   	leave  
80103cf0:	c3                   	ret    

80103cf1 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103cf1:	55                   	push   %ebp
80103cf2:	89 e5                	mov    %esp,%ebp
80103cf4:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103cf7:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d01:	83 c0 0f             	add    $0xf,%eax
80103d04:	0f b6 00             	movzbl (%eax),%eax
80103d07:	0f b6 c0             	movzbl %al,%eax
80103d0a:	c1 e0 08             	shl    $0x8,%eax
80103d0d:	89 c2                	mov    %eax,%edx
80103d0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d12:	83 c0 0e             	add    $0xe,%eax
80103d15:	0f b6 00             	movzbl (%eax),%eax
80103d18:	0f b6 c0             	movzbl %al,%eax
80103d1b:	09 d0                	or     %edx,%eax
80103d1d:	c1 e0 04             	shl    $0x4,%eax
80103d20:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d23:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d27:	74 21                	je     80103d4a <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103d29:	83 ec 08             	sub    $0x8,%esp
80103d2c:	68 00 04 00 00       	push   $0x400
80103d31:	ff 75 f0             	pushl  -0x10(%ebp)
80103d34:	e8 4c ff ff ff       	call   80103c85 <mpsearch1>
80103d39:	83 c4 10             	add    $0x10,%esp
80103d3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103d43:	74 51                	je     80103d96 <mpsearch+0xa5>
      return mp;
80103d45:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103d48:	eb 61                	jmp    80103dab <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d4d:	83 c0 14             	add    $0x14,%eax
80103d50:	0f b6 00             	movzbl (%eax),%eax
80103d53:	0f b6 c0             	movzbl %al,%eax
80103d56:	c1 e0 08             	shl    $0x8,%eax
80103d59:	89 c2                	mov    %eax,%edx
80103d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d5e:	83 c0 13             	add    $0x13,%eax
80103d61:	0f b6 00             	movzbl (%eax),%eax
80103d64:	0f b6 c0             	movzbl %al,%eax
80103d67:	09 d0                	or     %edx,%eax
80103d69:	c1 e0 0a             	shl    $0xa,%eax
80103d6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d72:	2d 00 04 00 00       	sub    $0x400,%eax
80103d77:	83 ec 08             	sub    $0x8,%esp
80103d7a:	68 00 04 00 00       	push   $0x400
80103d7f:	50                   	push   %eax
80103d80:	e8 00 ff ff ff       	call   80103c85 <mpsearch1>
80103d85:	83 c4 10             	add    $0x10,%esp
80103d88:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d8b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103d8f:	74 05                	je     80103d96 <mpsearch+0xa5>
      return mp;
80103d91:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103d94:	eb 15                	jmp    80103dab <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103d96:	83 ec 08             	sub    $0x8,%esp
80103d99:	68 00 00 01 00       	push   $0x10000
80103d9e:	68 00 00 0f 00       	push   $0xf0000
80103da3:	e8 dd fe ff ff       	call   80103c85 <mpsearch1>
80103da8:	83 c4 10             	add    $0x10,%esp
}
80103dab:	c9                   	leave  
80103dac:	c3                   	ret    

80103dad <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103dad:	55                   	push   %ebp
80103dae:	89 e5                	mov    %esp,%ebp
80103db0:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103db3:	e8 39 ff ff ff       	call   80103cf1 <mpsearch>
80103db8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103dbb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103dbf:	74 0a                	je     80103dcb <mpconfig+0x1e>
80103dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dc4:	8b 40 04             	mov    0x4(%eax),%eax
80103dc7:	85 c0                	test   %eax,%eax
80103dc9:	75 0a                	jne    80103dd5 <mpconfig+0x28>
    return 0;
80103dcb:	b8 00 00 00 00       	mov    $0x0,%eax
80103dd0:	e9 81 00 00 00       	jmp    80103e56 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dd8:	8b 40 04             	mov    0x4(%eax),%eax
80103ddb:	83 ec 0c             	sub    $0xc,%esp
80103dde:	50                   	push   %eax
80103ddf:	e8 02 fe ff ff       	call   80103be6 <p2v>
80103de4:	83 c4 10             	add    $0x10,%esp
80103de7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103dea:	83 ec 04             	sub    $0x4,%esp
80103ded:	6a 04                	push   $0x4
80103def:	68 41 96 10 80       	push   $0x80109641
80103df4:	ff 75 f0             	pushl  -0x10(%ebp)
80103df7:	e8 e4 15 00 00       	call   801053e0 <memcmp>
80103dfc:	83 c4 10             	add    $0x10,%esp
80103dff:	85 c0                	test   %eax,%eax
80103e01:	74 07                	je     80103e0a <mpconfig+0x5d>
    return 0;
80103e03:	b8 00 00 00 00       	mov    $0x0,%eax
80103e08:	eb 4c                	jmp    80103e56 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103e0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e0d:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103e11:	3c 01                	cmp    $0x1,%al
80103e13:	74 12                	je     80103e27 <mpconfig+0x7a>
80103e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e18:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103e1c:	3c 04                	cmp    $0x4,%al
80103e1e:	74 07                	je     80103e27 <mpconfig+0x7a>
    return 0;
80103e20:	b8 00 00 00 00       	mov    $0x0,%eax
80103e25:	eb 2f                	jmp    80103e56 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e2a:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103e2e:	0f b7 c0             	movzwl %ax,%eax
80103e31:	83 ec 08             	sub    $0x8,%esp
80103e34:	50                   	push   %eax
80103e35:	ff 75 f0             	pushl  -0x10(%ebp)
80103e38:	e8 10 fe ff ff       	call   80103c4d <sum>
80103e3d:	83 c4 10             	add    $0x10,%esp
80103e40:	84 c0                	test   %al,%al
80103e42:	74 07                	je     80103e4b <mpconfig+0x9e>
    return 0;
80103e44:	b8 00 00 00 00       	mov    $0x0,%eax
80103e49:	eb 0b                	jmp    80103e56 <mpconfig+0xa9>
  *pmp = mp;
80103e4b:	8b 45 08             	mov    0x8(%ebp),%eax
80103e4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e51:	89 10                	mov    %edx,(%eax)
  return conf;
80103e53:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103e56:	c9                   	leave  
80103e57:	c3                   	ret    

80103e58 <mpinit>:

void
mpinit(void)
{
80103e58:	55                   	push   %ebp
80103e59:	89 e5                	mov    %esp,%ebp
80103e5b:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103e5e:	c7 05 84 c6 10 80 a0 	movl   $0x80110aa0,0x8010c684
80103e65:	0a 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103e68:	83 ec 0c             	sub    $0xc,%esp
80103e6b:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103e6e:	50                   	push   %eax
80103e6f:	e8 39 ff ff ff       	call   80103dad <mpconfig>
80103e74:	83 c4 10             	add    $0x10,%esp
80103e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103e7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103e7e:	0f 84 96 01 00 00    	je     8010401a <mpinit+0x1c2>
    return;
  ismp = 1;
80103e84:	c7 05 84 0a 11 80 01 	movl   $0x1,0x80110a84
80103e8b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103e8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e91:	8b 40 24             	mov    0x24(%eax),%eax
80103e94:	a3 fc 09 11 80       	mov    %eax,0x801109fc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e9c:	83 c0 2c             	add    $0x2c,%eax
80103e9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ea2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ea5:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103ea9:	0f b7 d0             	movzwl %ax,%edx
80103eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103eaf:	01 d0                	add    %edx,%eax
80103eb1:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103eb4:	e9 f2 00 00 00       	jmp    80103fab <mpinit+0x153>
    switch(*p){
80103eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ebc:	0f b6 00             	movzbl (%eax),%eax
80103ebf:	0f b6 c0             	movzbl %al,%eax
80103ec2:	83 f8 04             	cmp    $0x4,%eax
80103ec5:	0f 87 bc 00 00 00    	ja     80103f87 <mpinit+0x12f>
80103ecb:	8b 04 85 84 96 10 80 	mov    -0x7fef697c(,%eax,4),%eax
80103ed2:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103ed4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ed7:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103eda:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103edd:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103ee1:	0f b6 d0             	movzbl %al,%edx
80103ee4:	a1 80 10 11 80       	mov    0x80111080,%eax
80103ee9:	39 c2                	cmp    %eax,%edx
80103eeb:	74 2b                	je     80103f18 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103eed:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103ef0:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103ef4:	0f b6 d0             	movzbl %al,%edx
80103ef7:	a1 80 10 11 80       	mov    0x80111080,%eax
80103efc:	83 ec 04             	sub    $0x4,%esp
80103eff:	52                   	push   %edx
80103f00:	50                   	push   %eax
80103f01:	68 46 96 10 80       	push   $0x80109646
80103f06:	e8 d7 c4 ff ff       	call   801003e2 <cprintf>
80103f0b:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103f0e:	c7 05 84 0a 11 80 00 	movl   $0x0,0x80110a84
80103f15:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103f18:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103f1b:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103f1f:	0f b6 c0             	movzbl %al,%eax
80103f22:	83 e0 02             	and    $0x2,%eax
80103f25:	85 c0                	test   %eax,%eax
80103f27:	74 15                	je     80103f3e <mpinit+0xe6>
        bcpu = &cpus[ncpu];
80103f29:	a1 80 10 11 80       	mov    0x80111080,%eax
80103f2e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103f34:	05 a0 0a 11 80       	add    $0x80110aa0,%eax
80103f39:	a3 84 c6 10 80       	mov    %eax,0x8010c684
      cpus[ncpu].id = ncpu;
80103f3e:	a1 80 10 11 80       	mov    0x80111080,%eax
80103f43:	8b 15 80 10 11 80    	mov    0x80111080,%edx
80103f49:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103f4f:	05 a0 0a 11 80       	add    $0x80110aa0,%eax
80103f54:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103f56:	a1 80 10 11 80       	mov    0x80111080,%eax
80103f5b:	83 c0 01             	add    $0x1,%eax
80103f5e:	a3 80 10 11 80       	mov    %eax,0x80111080
      p += sizeof(struct mpproc);
80103f63:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103f67:	eb 42                	jmp    80103fab <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103f6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103f72:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103f76:	a2 80 0a 11 80       	mov    %al,0x80110a80
      p += sizeof(struct mpioapic);
80103f7b:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103f7f:	eb 2a                	jmp    80103fab <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103f81:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103f85:	eb 24                	jmp    80103fab <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f8a:	0f b6 00             	movzbl (%eax),%eax
80103f8d:	0f b6 c0             	movzbl %al,%eax
80103f90:	83 ec 08             	sub    $0x8,%esp
80103f93:	50                   	push   %eax
80103f94:	68 64 96 10 80       	push   $0x80109664
80103f99:	e8 44 c4 ff ff       	call   801003e2 <cprintf>
80103f9e:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103fa1:	c7 05 84 0a 11 80 00 	movl   $0x0,0x80110a84
80103fa8:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103fb1:	0f 82 02 ff ff ff    	jb     80103eb9 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103fb7:	a1 84 0a 11 80       	mov    0x80110a84,%eax
80103fbc:	85 c0                	test   %eax,%eax
80103fbe:	75 1d                	jne    80103fdd <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103fc0:	c7 05 80 10 11 80 01 	movl   $0x1,0x80111080
80103fc7:	00 00 00 
    lapic = 0;
80103fca:	c7 05 fc 09 11 80 00 	movl   $0x0,0x801109fc
80103fd1:	00 00 00 
    ioapicid = 0;
80103fd4:	c6 05 80 0a 11 80 00 	movb   $0x0,0x80110a80
    return;
80103fdb:	eb 3e                	jmp    8010401b <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103fdd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103fe0:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103fe4:	84 c0                	test   %al,%al
80103fe6:	74 33                	je     8010401b <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103fe8:	83 ec 08             	sub    $0x8,%esp
80103feb:	6a 70                	push   $0x70
80103fed:	6a 22                	push   $0x22
80103fef:	e8 1c fc ff ff       	call   80103c10 <outb>
80103ff4:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ff7:	83 ec 0c             	sub    $0xc,%esp
80103ffa:	6a 23                	push   $0x23
80103ffc:	e8 f2 fb ff ff       	call   80103bf3 <inb>
80104001:	83 c4 10             	add    $0x10,%esp
80104004:	83 c8 01             	or     $0x1,%eax
80104007:	0f b6 c0             	movzbl %al,%eax
8010400a:	83 ec 08             	sub    $0x8,%esp
8010400d:	50                   	push   %eax
8010400e:	6a 23                	push   $0x23
80104010:	e8 fb fb ff ff       	call   80103c10 <outb>
80104015:	83 c4 10             	add    $0x10,%esp
80104018:	eb 01                	jmp    8010401b <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
8010401a:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010401b:	c9                   	leave  
8010401c:	c3                   	ret    

8010401d <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010401d:	55                   	push   %ebp
8010401e:	89 e5                	mov    %esp,%ebp
80104020:	83 ec 08             	sub    $0x8,%esp
80104023:	8b 55 08             	mov    0x8(%ebp),%edx
80104026:	8b 45 0c             	mov    0xc(%ebp),%eax
80104029:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010402d:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104030:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80104034:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80104038:	ee                   	out    %al,(%dx)
}
80104039:	90                   	nop
8010403a:	c9                   	leave  
8010403b:	c3                   	ret    

8010403c <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
8010403c:	55                   	push   %ebp
8010403d:	89 e5                	mov    %esp,%ebp
8010403f:	83 ec 04             	sub    $0x4,%esp
80104042:	8b 45 08             	mov    0x8(%ebp),%eax
80104045:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80104049:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010404d:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
  outb(IO_PIC1+1, mask);
80104053:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80104057:	0f b6 c0             	movzbl %al,%eax
8010405a:	50                   	push   %eax
8010405b:	6a 21                	push   $0x21
8010405d:	e8 bb ff ff ff       	call   8010401d <outb>
80104062:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80104065:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80104069:	66 c1 e8 08          	shr    $0x8,%ax
8010406d:	0f b6 c0             	movzbl %al,%eax
80104070:	50                   	push   %eax
80104071:	68 a1 00 00 00       	push   $0xa1
80104076:	e8 a2 ff ff ff       	call   8010401d <outb>
8010407b:	83 c4 08             	add    $0x8,%esp
}
8010407e:	90                   	nop
8010407f:	c9                   	leave  
80104080:	c3                   	ret    

80104081 <picenable>:

void
picenable(int irq)
{
80104081:	55                   	push   %ebp
80104082:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80104084:	8b 45 08             	mov    0x8(%ebp),%eax
80104087:	ba 01 00 00 00       	mov    $0x1,%edx
8010408c:	89 c1                	mov    %eax,%ecx
8010408e:	d3 e2                	shl    %cl,%edx
80104090:	89 d0                	mov    %edx,%eax
80104092:	f7 d0                	not    %eax
80104094:	89 c2                	mov    %eax,%edx
80104096:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
8010409d:	21 d0                	and    %edx,%eax
8010409f:	0f b7 c0             	movzwl %ax,%eax
801040a2:	50                   	push   %eax
801040a3:	e8 94 ff ff ff       	call   8010403c <picsetmask>
801040a8:	83 c4 04             	add    $0x4,%esp
}
801040ab:	90                   	nop
801040ac:	c9                   	leave  
801040ad:	c3                   	ret    

801040ae <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801040ae:	55                   	push   %ebp
801040af:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
801040b1:	68 ff 00 00 00       	push   $0xff
801040b6:	6a 21                	push   $0x21
801040b8:	e8 60 ff ff ff       	call   8010401d <outb>
801040bd:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
801040c0:	68 ff 00 00 00       	push   $0xff
801040c5:	68 a1 00 00 00       	push   $0xa1
801040ca:	e8 4e ff ff ff       	call   8010401d <outb>
801040cf:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
801040d2:	6a 11                	push   $0x11
801040d4:	6a 20                	push   $0x20
801040d6:	e8 42 ff ff ff       	call   8010401d <outb>
801040db:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
801040de:	6a 20                	push   $0x20
801040e0:	6a 21                	push   $0x21
801040e2:	e8 36 ff ff ff       	call   8010401d <outb>
801040e7:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
801040ea:	6a 04                	push   $0x4
801040ec:	6a 21                	push   $0x21
801040ee:	e8 2a ff ff ff       	call   8010401d <outb>
801040f3:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
801040f6:	6a 03                	push   $0x3
801040f8:	6a 21                	push   $0x21
801040fa:	e8 1e ff ff ff       	call   8010401d <outb>
801040ff:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80104102:	6a 11                	push   $0x11
80104104:	68 a0 00 00 00       	push   $0xa0
80104109:	e8 0f ff ff ff       	call   8010401d <outb>
8010410e:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80104111:	6a 28                	push   $0x28
80104113:	68 a1 00 00 00       	push   $0xa1
80104118:	e8 00 ff ff ff       	call   8010401d <outb>
8010411d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80104120:	6a 02                	push   $0x2
80104122:	68 a1 00 00 00       	push   $0xa1
80104127:	e8 f1 fe ff ff       	call   8010401d <outb>
8010412c:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
8010412f:	6a 03                	push   $0x3
80104131:	68 a1 00 00 00       	push   $0xa1
80104136:	e8 e2 fe ff ff       	call   8010401d <outb>
8010413b:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
8010413e:	6a 68                	push   $0x68
80104140:	6a 20                	push   $0x20
80104142:	e8 d6 fe ff ff       	call   8010401d <outb>
80104147:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
8010414a:	6a 0a                	push   $0xa
8010414c:	6a 20                	push   $0x20
8010414e:	e8 ca fe ff ff       	call   8010401d <outb>
80104153:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80104156:	6a 68                	push   $0x68
80104158:	68 a0 00 00 00       	push   $0xa0
8010415d:	e8 bb fe ff ff       	call   8010401d <outb>
80104162:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80104165:	6a 0a                	push   $0xa
80104167:	68 a0 00 00 00       	push   $0xa0
8010416c:	e8 ac fe ff ff       	call   8010401d <outb>
80104171:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80104174:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
8010417b:	66 83 f8 ff          	cmp    $0xffff,%ax
8010417f:	74 13                	je     80104194 <picinit+0xe6>
    picsetmask(irqmask);
80104181:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104188:	0f b7 c0             	movzwl %ax,%eax
8010418b:	50                   	push   %eax
8010418c:	e8 ab fe ff ff       	call   8010403c <picsetmask>
80104191:	83 c4 04             	add    $0x4,%esp
}
80104194:	90                   	nop
80104195:	c9                   	leave  
80104196:	c3                   	ret    

80104197 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104197:	55                   	push   %ebp
80104198:	89 e5                	mov    %esp,%ebp
8010419a:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
8010419d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
801041a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801041a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801041ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801041b0:	8b 10                	mov    (%eax),%edx
801041b2:	8b 45 08             	mov    0x8(%ebp),%eax
801041b5:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801041b7:	e8 0b d3 ff ff       	call   801014c7 <filealloc>
801041bc:	89 c2                	mov    %eax,%edx
801041be:	8b 45 08             	mov    0x8(%ebp),%eax
801041c1:	89 10                	mov    %edx,(%eax)
801041c3:	8b 45 08             	mov    0x8(%ebp),%eax
801041c6:	8b 00                	mov    (%eax),%eax
801041c8:	85 c0                	test   %eax,%eax
801041ca:	0f 84 cb 00 00 00    	je     8010429b <pipealloc+0x104>
801041d0:	e8 f2 d2 ff ff       	call   801014c7 <filealloc>
801041d5:	89 c2                	mov    %eax,%edx
801041d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801041da:	89 10                	mov    %edx,(%eax)
801041dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801041df:	8b 00                	mov    (%eax),%eax
801041e1:	85 c0                	test   %eax,%eax
801041e3:	0f 84 b2 00 00 00    	je     8010429b <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801041e9:	e8 26 ef ff ff       	call   80103114 <kalloc>
801041ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
801041f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801041f5:	0f 84 9f 00 00 00    	je     8010429a <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
801041fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041fe:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104205:	00 00 00 
  p->writeopen = 1;
80104208:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010420b:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104212:	00 00 00 
  p->nwrite = 0;
80104215:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104218:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010421f:	00 00 00 
  p->nread = 0;
80104222:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104225:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010422c:	00 00 00 
  initlock(&p->lock, "pipe");
8010422f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104232:	83 ec 08             	sub    $0x8,%esp
80104235:	68 98 96 10 80       	push   $0x80109698
8010423a:	50                   	push   %eax
8010423b:	e8 b4 0e 00 00       	call   801050f4 <initlock>
80104240:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104243:	8b 45 08             	mov    0x8(%ebp),%eax
80104246:	8b 00                	mov    (%eax),%eax
80104248:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010424e:	8b 45 08             	mov    0x8(%ebp),%eax
80104251:	8b 00                	mov    (%eax),%eax
80104253:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104257:	8b 45 08             	mov    0x8(%ebp),%eax
8010425a:	8b 00                	mov    (%eax),%eax
8010425c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104260:	8b 45 08             	mov    0x8(%ebp),%eax
80104263:	8b 00                	mov    (%eax),%eax
80104265:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104268:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010426b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010426e:	8b 00                	mov    (%eax),%eax
80104270:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104276:	8b 45 0c             	mov    0xc(%ebp),%eax
80104279:	8b 00                	mov    (%eax),%eax
8010427b:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010427f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104282:	8b 00                	mov    (%eax),%eax
80104284:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104288:	8b 45 0c             	mov    0xc(%ebp),%eax
8010428b:	8b 00                	mov    (%eax),%eax
8010428d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104290:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104293:	b8 00 00 00 00       	mov    $0x0,%eax
80104298:	eb 4e                	jmp    801042e8 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
8010429a:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
8010429b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010429f:	74 0e                	je     801042af <pipealloc+0x118>
    kfree((char*)p);
801042a1:	83 ec 0c             	sub    $0xc,%esp
801042a4:	ff 75 f4             	pushl  -0xc(%ebp)
801042a7:	e8 cb ed ff ff       	call   80103077 <kfree>
801042ac:	83 c4 10             	add    $0x10,%esp
  if(*f0)
801042af:	8b 45 08             	mov    0x8(%ebp),%eax
801042b2:	8b 00                	mov    (%eax),%eax
801042b4:	85 c0                	test   %eax,%eax
801042b6:	74 11                	je     801042c9 <pipealloc+0x132>
    fileclose(*f0);
801042b8:	8b 45 08             	mov    0x8(%ebp),%eax
801042bb:	8b 00                	mov    (%eax),%eax
801042bd:	83 ec 0c             	sub    $0xc,%esp
801042c0:	50                   	push   %eax
801042c1:	e8 bf d2 ff ff       	call   80101585 <fileclose>
801042c6:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801042c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801042cc:	8b 00                	mov    (%eax),%eax
801042ce:	85 c0                	test   %eax,%eax
801042d0:	74 11                	je     801042e3 <pipealloc+0x14c>
    fileclose(*f1);
801042d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801042d5:	8b 00                	mov    (%eax),%eax
801042d7:	83 ec 0c             	sub    $0xc,%esp
801042da:	50                   	push   %eax
801042db:	e8 a5 d2 ff ff       	call   80101585 <fileclose>
801042e0:	83 c4 10             	add    $0x10,%esp
  return -1;
801042e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042e8:	c9                   	leave  
801042e9:	c3                   	ret    

801042ea <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801042ea:	55                   	push   %ebp
801042eb:	89 e5                	mov    %esp,%ebp
801042ed:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801042f0:	8b 45 08             	mov    0x8(%ebp),%eax
801042f3:	83 ec 0c             	sub    $0xc,%esp
801042f6:	50                   	push   %eax
801042f7:	e8 1a 0e 00 00       	call   80105116 <acquire>
801042fc:	83 c4 10             	add    $0x10,%esp
  if(writable){
801042ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104303:	74 23                	je     80104328 <pipeclose+0x3e>
    p->writeopen = 0;
80104305:	8b 45 08             	mov    0x8(%ebp),%eax
80104308:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
8010430f:	00 00 00 
    wakeup(&p->nread);
80104312:	8b 45 08             	mov    0x8(%ebp),%eax
80104315:	05 34 02 00 00       	add    $0x234,%eax
8010431a:	83 ec 0c             	sub    $0xc,%esp
8010431d:	50                   	push   %eax
8010431e:	e8 e5 0b 00 00       	call   80104f08 <wakeup>
80104323:	83 c4 10             	add    $0x10,%esp
80104326:	eb 21                	jmp    80104349 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104328:	8b 45 08             	mov    0x8(%ebp),%eax
8010432b:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104332:	00 00 00 
    wakeup(&p->nwrite);
80104335:	8b 45 08             	mov    0x8(%ebp),%eax
80104338:	05 38 02 00 00       	add    $0x238,%eax
8010433d:	83 ec 0c             	sub    $0xc,%esp
80104340:	50                   	push   %eax
80104341:	e8 c2 0b 00 00       	call   80104f08 <wakeup>
80104346:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104349:	8b 45 08             	mov    0x8(%ebp),%eax
8010434c:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104352:	85 c0                	test   %eax,%eax
80104354:	75 2c                	jne    80104382 <pipeclose+0x98>
80104356:	8b 45 08             	mov    0x8(%ebp),%eax
80104359:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010435f:	85 c0                	test   %eax,%eax
80104361:	75 1f                	jne    80104382 <pipeclose+0x98>
    release(&p->lock);
80104363:	8b 45 08             	mov    0x8(%ebp),%eax
80104366:	83 ec 0c             	sub    $0xc,%esp
80104369:	50                   	push   %eax
8010436a:	e8 0e 0e 00 00       	call   8010517d <release>
8010436f:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104372:	83 ec 0c             	sub    $0xc,%esp
80104375:	ff 75 08             	pushl  0x8(%ebp)
80104378:	e8 fa ec ff ff       	call   80103077 <kfree>
8010437d:	83 c4 10             	add    $0x10,%esp
80104380:	eb 0f                	jmp    80104391 <pipeclose+0xa7>
  } else
    release(&p->lock);
80104382:	8b 45 08             	mov    0x8(%ebp),%eax
80104385:	83 ec 0c             	sub    $0xc,%esp
80104388:	50                   	push   %eax
80104389:	e8 ef 0d 00 00       	call   8010517d <release>
8010438e:	83 c4 10             	add    $0x10,%esp
}
80104391:	90                   	nop
80104392:	c9                   	leave  
80104393:	c3                   	ret    

80104394 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104394:	55                   	push   %ebp
80104395:	89 e5                	mov    %esp,%ebp
80104397:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
8010439a:	8b 45 08             	mov    0x8(%ebp),%eax
8010439d:	83 ec 0c             	sub    $0xc,%esp
801043a0:	50                   	push   %eax
801043a1:	e8 70 0d 00 00       	call   80105116 <acquire>
801043a6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801043a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801043b0:	e9 ad 00 00 00       	jmp    80104462 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801043b5:	8b 45 08             	mov    0x8(%ebp),%eax
801043b8:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801043be:	85 c0                	test   %eax,%eax
801043c0:	74 0d                	je     801043cf <pipewrite+0x3b>
801043c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043c8:	8b 40 24             	mov    0x24(%eax),%eax
801043cb:	85 c0                	test   %eax,%eax
801043cd:	74 19                	je     801043e8 <pipewrite+0x54>
        release(&p->lock);
801043cf:	8b 45 08             	mov    0x8(%ebp),%eax
801043d2:	83 ec 0c             	sub    $0xc,%esp
801043d5:	50                   	push   %eax
801043d6:	e8 a2 0d 00 00       	call   8010517d <release>
801043db:	83 c4 10             	add    $0x10,%esp
        return -1;
801043de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043e3:	e9 a8 00 00 00       	jmp    80104490 <pipewrite+0xfc>
      }
      wakeup(&p->nread);
801043e8:	8b 45 08             	mov    0x8(%ebp),%eax
801043eb:	05 34 02 00 00       	add    $0x234,%eax
801043f0:	83 ec 0c             	sub    $0xc,%esp
801043f3:	50                   	push   %eax
801043f4:	e8 0f 0b 00 00       	call   80104f08 <wakeup>
801043f9:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801043fc:	8b 45 08             	mov    0x8(%ebp),%eax
801043ff:	8b 55 08             	mov    0x8(%ebp),%edx
80104402:	81 c2 38 02 00 00    	add    $0x238,%edx
80104408:	83 ec 08             	sub    $0x8,%esp
8010440b:	50                   	push   %eax
8010440c:	52                   	push   %edx
8010440d:	e8 0b 0a 00 00       	call   80104e1d <sleep>
80104412:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104415:	8b 45 08             	mov    0x8(%ebp),%eax
80104418:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
8010441e:	8b 45 08             	mov    0x8(%ebp),%eax
80104421:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104427:	05 00 02 00 00       	add    $0x200,%eax
8010442c:	39 c2                	cmp    %eax,%edx
8010442e:	74 85                	je     801043b5 <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104430:	8b 45 08             	mov    0x8(%ebp),%eax
80104433:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104439:	8d 48 01             	lea    0x1(%eax),%ecx
8010443c:	8b 55 08             	mov    0x8(%ebp),%edx
8010443f:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104445:	25 ff 01 00 00       	and    $0x1ff,%eax
8010444a:	89 c1                	mov    %eax,%ecx
8010444c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010444f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104452:	01 d0                	add    %edx,%eax
80104454:	0f b6 10             	movzbl (%eax),%edx
80104457:	8b 45 08             	mov    0x8(%ebp),%eax
8010445a:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010445e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104462:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104465:	3b 45 10             	cmp    0x10(%ebp),%eax
80104468:	7c ab                	jl     80104415 <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010446a:	8b 45 08             	mov    0x8(%ebp),%eax
8010446d:	05 34 02 00 00       	add    $0x234,%eax
80104472:	83 ec 0c             	sub    $0xc,%esp
80104475:	50                   	push   %eax
80104476:	e8 8d 0a 00 00       	call   80104f08 <wakeup>
8010447b:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010447e:	8b 45 08             	mov    0x8(%ebp),%eax
80104481:	83 ec 0c             	sub    $0xc,%esp
80104484:	50                   	push   %eax
80104485:	e8 f3 0c 00 00       	call   8010517d <release>
8010448a:	83 c4 10             	add    $0x10,%esp
  return n;
8010448d:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104490:	c9                   	leave  
80104491:	c3                   	ret    

80104492 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104492:	55                   	push   %ebp
80104493:	89 e5                	mov    %esp,%ebp
80104495:	53                   	push   %ebx
80104496:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104499:	8b 45 08             	mov    0x8(%ebp),%eax
8010449c:	83 ec 0c             	sub    $0xc,%esp
8010449f:	50                   	push   %eax
801044a0:	e8 71 0c 00 00       	call   80105116 <acquire>
801044a5:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801044a8:	eb 3f                	jmp    801044e9 <piperead+0x57>
    if(proc->killed){
801044aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044b0:	8b 40 24             	mov    0x24(%eax),%eax
801044b3:	85 c0                	test   %eax,%eax
801044b5:	74 19                	je     801044d0 <piperead+0x3e>
      release(&p->lock);
801044b7:	8b 45 08             	mov    0x8(%ebp),%eax
801044ba:	83 ec 0c             	sub    $0xc,%esp
801044bd:	50                   	push   %eax
801044be:	e8 ba 0c 00 00       	call   8010517d <release>
801044c3:	83 c4 10             	add    $0x10,%esp
      return -1;
801044c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044cb:	e9 bf 00 00 00       	jmp    8010458f <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801044d0:	8b 45 08             	mov    0x8(%ebp),%eax
801044d3:	8b 55 08             	mov    0x8(%ebp),%edx
801044d6:	81 c2 34 02 00 00    	add    $0x234,%edx
801044dc:	83 ec 08             	sub    $0x8,%esp
801044df:	50                   	push   %eax
801044e0:	52                   	push   %edx
801044e1:	e8 37 09 00 00       	call   80104e1d <sleep>
801044e6:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801044e9:	8b 45 08             	mov    0x8(%ebp),%eax
801044ec:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801044f2:	8b 45 08             	mov    0x8(%ebp),%eax
801044f5:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801044fb:	39 c2                	cmp    %eax,%edx
801044fd:	75 0d                	jne    8010450c <piperead+0x7a>
801044ff:	8b 45 08             	mov    0x8(%ebp),%eax
80104502:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104508:	85 c0                	test   %eax,%eax
8010450a:	75 9e                	jne    801044aa <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010450c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104513:	eb 49                	jmp    8010455e <piperead+0xcc>
    if(p->nread == p->nwrite)
80104515:	8b 45 08             	mov    0x8(%ebp),%eax
80104518:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010451e:	8b 45 08             	mov    0x8(%ebp),%eax
80104521:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104527:	39 c2                	cmp    %eax,%edx
80104529:	74 3d                	je     80104568 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010452b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010452e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104531:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104534:	8b 45 08             	mov    0x8(%ebp),%eax
80104537:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010453d:	8d 48 01             	lea    0x1(%eax),%ecx
80104540:	8b 55 08             	mov    0x8(%ebp),%edx
80104543:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104549:	25 ff 01 00 00       	and    $0x1ff,%eax
8010454e:	89 c2                	mov    %eax,%edx
80104550:	8b 45 08             	mov    0x8(%ebp),%eax
80104553:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80104558:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010455a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010455e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104561:	3b 45 10             	cmp    0x10(%ebp),%eax
80104564:	7c af                	jl     80104515 <piperead+0x83>
80104566:	eb 01                	jmp    80104569 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
80104568:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104569:	8b 45 08             	mov    0x8(%ebp),%eax
8010456c:	05 38 02 00 00       	add    $0x238,%eax
80104571:	83 ec 0c             	sub    $0xc,%esp
80104574:	50                   	push   %eax
80104575:	e8 8e 09 00 00       	call   80104f08 <wakeup>
8010457a:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010457d:	8b 45 08             	mov    0x8(%ebp),%eax
80104580:	83 ec 0c             	sub    $0xc,%esp
80104583:	50                   	push   %eax
80104584:	e8 f4 0b 00 00       	call   8010517d <release>
80104589:	83 c4 10             	add    $0x10,%esp
  return i;
8010458c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010458f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104592:	c9                   	leave  
80104593:	c3                   	ret    

80104594 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104594:	55                   	push   %ebp
80104595:	89 e5                	mov    %esp,%ebp
80104597:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010459a:	9c                   	pushf  
8010459b:	58                   	pop    %eax
8010459c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010459f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801045a2:	c9                   	leave  
801045a3:	c3                   	ret    

801045a4 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801045a4:	55                   	push   %ebp
801045a5:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801045a7:	fb                   	sti    
}
801045a8:	90                   	nop
801045a9:	5d                   	pop    %ebp
801045aa:	c3                   	ret    

801045ab <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801045ab:	55                   	push   %ebp
801045ac:	89 e5                	mov    %esp,%ebp
801045ae:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801045b1:	83 ec 08             	sub    $0x8,%esp
801045b4:	68 9d 96 10 80       	push   $0x8010969d
801045b9:	68 a0 10 11 80       	push   $0x801110a0
801045be:	e8 31 0b 00 00       	call   801050f4 <initlock>
801045c3:	83 c4 10             	add    $0x10,%esp
}
801045c6:	90                   	nop
801045c7:	c9                   	leave  
801045c8:	c3                   	ret    

801045c9 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801045c9:	55                   	push   %ebp
801045ca:	89 e5                	mov    %esp,%ebp
801045cc:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801045cf:	83 ec 0c             	sub    $0xc,%esp
801045d2:	68 a0 10 11 80       	push   $0x801110a0
801045d7:	e8 3a 0b 00 00       	call   80105116 <acquire>
801045dc:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045df:	c7 45 f4 d4 10 11 80 	movl   $0x801110d4,-0xc(%ebp)
801045e6:	eb 0e                	jmp    801045f6 <allocproc+0x2d>
    if(p->state == UNUSED)
801045e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045eb:	8b 40 0c             	mov    0xc(%eax),%eax
801045ee:	85 c0                	test   %eax,%eax
801045f0:	74 27                	je     80104619 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045f2:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801045f6:	81 7d f4 d4 2f 11 80 	cmpl   $0x80112fd4,-0xc(%ebp)
801045fd:	72 e9                	jb     801045e8 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
801045ff:	83 ec 0c             	sub    $0xc,%esp
80104602:	68 a0 10 11 80       	push   $0x801110a0
80104607:	e8 71 0b 00 00       	call   8010517d <release>
8010460c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010460f:	b8 00 00 00 00       	mov    $0x0,%eax
80104614:	e9 b4 00 00 00       	jmp    801046cd <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104619:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010461a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461d:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104624:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104629:	8d 50 01             	lea    0x1(%eax),%edx
8010462c:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
80104632:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104635:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104638:	83 ec 0c             	sub    $0xc,%esp
8010463b:	68 a0 10 11 80       	push   $0x801110a0
80104640:	e8 38 0b 00 00       	call   8010517d <release>
80104645:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104648:	e8 c7 ea ff ff       	call   80103114 <kalloc>
8010464d:	89 c2                	mov    %eax,%edx
8010464f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104652:	89 50 08             	mov    %edx,0x8(%eax)
80104655:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104658:	8b 40 08             	mov    0x8(%eax),%eax
8010465b:	85 c0                	test   %eax,%eax
8010465d:	75 11                	jne    80104670 <allocproc+0xa7>
    p->state = UNUSED;
8010465f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104662:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104669:	b8 00 00 00 00       	mov    $0x0,%eax
8010466e:	eb 5d                	jmp    801046cd <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
80104670:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104673:	8b 40 08             	mov    0x8(%eax),%eax
80104676:	05 00 10 00 00       	add    $0x1000,%eax
8010467b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010467e:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104682:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104685:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104688:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
8010468b:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010468f:	ba ce 6a 10 80       	mov    $0x80106ace,%edx
80104694:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104697:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104699:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
8010469d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046a3:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801046a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046a9:	8b 40 1c             	mov    0x1c(%eax),%eax
801046ac:	83 ec 04             	sub    $0x4,%esp
801046af:	6a 14                	push   $0x14
801046b1:	6a 00                	push   $0x0
801046b3:	50                   	push   %eax
801046b4:	e8 c0 0c 00 00       	call   80105379 <memset>
801046b9:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801046bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046bf:	8b 40 1c             	mov    0x1c(%eax),%eax
801046c2:	ba ec 4d 10 80       	mov    $0x80104dec,%edx
801046c7:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801046ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801046cd:	c9                   	leave  
801046ce:	c3                   	ret    

801046cf <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801046cf:	55                   	push   %ebp
801046d0:	89 e5                	mov    %esp,%ebp
801046d2:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801046d5:	e8 ef fe ff ff       	call   801045c9 <allocproc>
801046da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801046dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046e0:	a3 88 c6 10 80       	mov    %eax,0x8010c688
  if((p->pgdir = setupkvm()) == 0)
801046e5:	e8 a9 3a 00 00       	call   80108193 <setupkvm>
801046ea:	89 c2                	mov    %eax,%edx
801046ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046ef:	89 50 04             	mov    %edx,0x4(%eax)
801046f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046f5:	8b 40 04             	mov    0x4(%eax),%eax
801046f8:	85 c0                	test   %eax,%eax
801046fa:	75 0d                	jne    80104709 <userinit+0x3a>
    panic("userinit: out of memory?");
801046fc:	83 ec 0c             	sub    $0xc,%esp
801046ff:	68 a4 96 10 80       	push   $0x801096a4
80104704:	e8 79 be ff ff       	call   80100582 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104709:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010470e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104711:	8b 40 04             	mov    0x4(%eax),%eax
80104714:	83 ec 04             	sub    $0x4,%esp
80104717:	52                   	push   %edx
80104718:	68 20 c5 10 80       	push   $0x8010c520
8010471d:	50                   	push   %eax
8010471e:	e8 ca 3c 00 00       	call   801083ed <inituvm>
80104723:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104726:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104729:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010472f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104732:	8b 40 18             	mov    0x18(%eax),%eax
80104735:	83 ec 04             	sub    $0x4,%esp
80104738:	6a 4c                	push   $0x4c
8010473a:	6a 00                	push   $0x0
8010473c:	50                   	push   %eax
8010473d:	e8 37 0c 00 00       	call   80105379 <memset>
80104742:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104745:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104748:	8b 40 18             	mov    0x18(%eax),%eax
8010474b:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104751:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104754:	8b 40 18             	mov    0x18(%eax),%eax
80104757:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010475d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104760:	8b 40 18             	mov    0x18(%eax),%eax
80104763:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104766:	8b 52 18             	mov    0x18(%edx),%edx
80104769:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010476d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104771:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104774:	8b 40 18             	mov    0x18(%eax),%eax
80104777:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010477a:	8b 52 18             	mov    0x18(%edx),%edx
8010477d:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104781:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104785:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104788:	8b 40 18             	mov    0x18(%eax),%eax
8010478b:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104792:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104795:	8b 40 18             	mov    0x18(%eax),%eax
80104798:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010479f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047a2:	8b 40 18             	mov    0x18(%eax),%eax
801047a5:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801047ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047af:	83 c0 6c             	add    $0x6c,%eax
801047b2:	83 ec 04             	sub    $0x4,%esp
801047b5:	6a 10                	push   $0x10
801047b7:	68 bd 96 10 80       	push   $0x801096bd
801047bc:	50                   	push   %eax
801047bd:	e8 ba 0d 00 00       	call   8010557c <safestrcpy>
801047c2:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801047c5:	83 ec 0c             	sub    $0xc,%esp
801047c8:	68 c6 96 10 80       	push   $0x801096c6
801047cd:	e8 40 e2 ff ff       	call   80102a12 <namei>
801047d2:	83 c4 10             	add    $0x10,%esp
801047d5:	89 c2                	mov    %eax,%edx
801047d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047da:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
801047dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047e0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
801047e7:	90                   	nop
801047e8:	c9                   	leave  
801047e9:	c3                   	ret    

801047ea <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801047ea:	55                   	push   %ebp
801047eb:	89 e5                	mov    %esp,%ebp
801047ed:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
801047f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047f6:	8b 00                	mov    (%eax),%eax
801047f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801047fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801047ff:	7e 31                	jle    80104832 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104801:	8b 55 08             	mov    0x8(%ebp),%edx
80104804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104807:	01 c2                	add    %eax,%edx
80104809:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480f:	8b 40 04             	mov    0x4(%eax),%eax
80104812:	83 ec 04             	sub    $0x4,%esp
80104815:	52                   	push   %edx
80104816:	ff 75 f4             	pushl  -0xc(%ebp)
80104819:	50                   	push   %eax
8010481a:	e8 1b 3d 00 00       	call   8010853a <allocuvm>
8010481f:	83 c4 10             	add    $0x10,%esp
80104822:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104825:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104829:	75 3e                	jne    80104869 <growproc+0x7f>
      return -1;
8010482b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104830:	eb 59                	jmp    8010488b <growproc+0xa1>
  } else if(n < 0){
80104832:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104836:	79 31                	jns    80104869 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104838:	8b 55 08             	mov    0x8(%ebp),%edx
8010483b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483e:	01 c2                	add    %eax,%edx
80104840:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104846:	8b 40 04             	mov    0x4(%eax),%eax
80104849:	83 ec 04             	sub    $0x4,%esp
8010484c:	52                   	push   %edx
8010484d:	ff 75 f4             	pushl  -0xc(%ebp)
80104850:	50                   	push   %eax
80104851:	e8 ad 3d 00 00       	call   80108603 <deallocuvm>
80104856:	83 c4 10             	add    $0x10,%esp
80104859:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010485c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104860:	75 07                	jne    80104869 <growproc+0x7f>
      return -1;
80104862:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104867:	eb 22                	jmp    8010488b <growproc+0xa1>
  }
  proc->sz = sz;
80104869:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010486f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104872:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104874:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010487a:	83 ec 0c             	sub    $0xc,%esp
8010487d:	50                   	push   %eax
8010487e:	e8 f7 39 00 00       	call   8010827a <switchuvm>
80104883:	83 c4 10             	add    $0x10,%esp
  return 0;
80104886:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010488b:	c9                   	leave  
8010488c:	c3                   	ret    

8010488d <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010488d:	55                   	push   %ebp
8010488e:	89 e5                	mov    %esp,%ebp
80104890:	57                   	push   %edi
80104891:	56                   	push   %esi
80104892:	53                   	push   %ebx
80104893:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104896:	e8 2e fd ff ff       	call   801045c9 <allocproc>
8010489b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010489e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801048a2:	75 0a                	jne    801048ae <fork+0x21>
    return -1;
801048a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048a9:	e9 48 01 00 00       	jmp    801049f6 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801048ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048b4:	8b 10                	mov    (%eax),%edx
801048b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048bc:	8b 40 04             	mov    0x4(%eax),%eax
801048bf:	83 ec 08             	sub    $0x8,%esp
801048c2:	52                   	push   %edx
801048c3:	50                   	push   %eax
801048c4:	e8 d8 3e 00 00       	call   801087a1 <copyuvm>
801048c9:	83 c4 10             	add    $0x10,%esp
801048cc:	89 c2                	mov    %eax,%edx
801048ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048d1:	89 50 04             	mov    %edx,0x4(%eax)
801048d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048d7:	8b 40 04             	mov    0x4(%eax),%eax
801048da:	85 c0                	test   %eax,%eax
801048dc:	75 30                	jne    8010490e <fork+0x81>
    kfree(np->kstack);
801048de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048e1:	8b 40 08             	mov    0x8(%eax),%eax
801048e4:	83 ec 0c             	sub    $0xc,%esp
801048e7:	50                   	push   %eax
801048e8:	e8 8a e7 ff ff       	call   80103077 <kfree>
801048ed:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801048f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048f3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801048fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048fd:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104904:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104909:	e9 e8 00 00 00       	jmp    801049f6 <fork+0x169>
  }
  np->sz = proc->sz;
8010490e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104914:	8b 10                	mov    (%eax),%edx
80104916:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104919:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
8010491b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104922:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104925:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104928:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010492b:	8b 50 18             	mov    0x18(%eax),%edx
8010492e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104934:	8b 40 18             	mov    0x18(%eax),%eax
80104937:	89 c3                	mov    %eax,%ebx
80104939:	b8 13 00 00 00       	mov    $0x13,%eax
8010493e:	89 d7                	mov    %edx,%edi
80104940:	89 de                	mov    %ebx,%esi
80104942:	89 c1                	mov    %eax,%ecx
80104944:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104946:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104949:	8b 40 18             	mov    0x18(%eax),%eax
8010494c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104953:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010495a:	eb 43                	jmp    8010499f <fork+0x112>
    if(proc->ofile[i])
8010495c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104962:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104965:	83 c2 08             	add    $0x8,%edx
80104968:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010496c:	85 c0                	test   %eax,%eax
8010496e:	74 2b                	je     8010499b <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
80104970:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104976:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104979:	83 c2 08             	add    $0x8,%edx
8010497c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104980:	83 ec 0c             	sub    $0xc,%esp
80104983:	50                   	push   %eax
80104984:	e8 ab cb ff ff       	call   80101534 <filedup>
80104989:	83 c4 10             	add    $0x10,%esp
8010498c:	89 c1                	mov    %eax,%ecx
8010498e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104991:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104994:	83 c2 08             	add    $0x8,%edx
80104997:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010499b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010499f:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801049a3:	7e b7                	jle    8010495c <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801049a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049ab:	8b 40 68             	mov    0x68(%eax),%eax
801049ae:	83 ec 0c             	sub    $0xc,%esp
801049b1:	50                   	push   %eax
801049b2:	e8 69 d4 ff ff       	call   80101e20 <idup>
801049b7:	83 c4 10             	add    $0x10,%esp
801049ba:	89 c2                	mov    %eax,%edx
801049bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049bf:	89 50 68             	mov    %edx,0x68(%eax)
 
  pid = np->pid;
801049c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049c5:	8b 40 10             	mov    0x10(%eax),%eax
801049c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
801049cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049ce:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
801049d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049db:	8d 50 6c             	lea    0x6c(%eax),%edx
801049de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049e1:	83 c0 6c             	add    $0x6c,%eax
801049e4:	83 ec 04             	sub    $0x4,%esp
801049e7:	6a 10                	push   $0x10
801049e9:	52                   	push   %edx
801049ea:	50                   	push   %eax
801049eb:	e8 8c 0b 00 00       	call   8010557c <safestrcpy>
801049f0:	83 c4 10             	add    $0x10,%esp
  return pid;
801049f3:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801049f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049f9:	5b                   	pop    %ebx
801049fa:	5e                   	pop    %esi
801049fb:	5f                   	pop    %edi
801049fc:	5d                   	pop    %ebp
801049fd:	c3                   	ret    

801049fe <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
801049fe:	55                   	push   %ebp
801049ff:	89 e5                	mov    %esp,%ebp
80104a01:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104a04:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a0b:	a1 88 c6 10 80       	mov    0x8010c688,%eax
80104a10:	39 c2                	cmp    %eax,%edx
80104a12:	75 0d                	jne    80104a21 <exit+0x23>
    panic("init exiting");
80104a14:	83 ec 0c             	sub    $0xc,%esp
80104a17:	68 c8 96 10 80       	push   $0x801096c8
80104a1c:	e8 61 bb ff ff       	call   80100582 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104a21:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104a28:	eb 48                	jmp    80104a72 <exit+0x74>
    if(proc->ofile[fd]){
80104a2a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a30:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a33:	83 c2 08             	add    $0x8,%edx
80104a36:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a3a:	85 c0                	test   %eax,%eax
80104a3c:	74 30                	je     80104a6e <exit+0x70>
      fileclose(proc->ofile[fd]);
80104a3e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a44:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a47:	83 c2 08             	add    $0x8,%edx
80104a4a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a4e:	83 ec 0c             	sub    $0xc,%esp
80104a51:	50                   	push   %eax
80104a52:	e8 2e cb ff ff       	call   80101585 <fileclose>
80104a57:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104a5a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a60:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a63:	83 c2 08             	add    $0x8,%edx
80104a66:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104a6d:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104a6e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104a72:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104a76:	7e b2                	jle    80104a2a <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104a78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a7e:	8b 40 68             	mov    0x68(%eax),%eax
80104a81:	83 ec 0c             	sub    $0xc,%esp
80104a84:	50                   	push   %eax
80104a85:	e8 9a d5 ff ff       	call   80102024 <iput>
80104a8a:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
80104a8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a93:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104a9a:	83 ec 0c             	sub    $0xc,%esp
80104a9d:	68 a0 10 11 80       	push   $0x801110a0
80104aa2:	e8 6f 06 00 00       	call   80105116 <acquire>
80104aa7:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104aaa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ab0:	8b 40 14             	mov    0x14(%eax),%eax
80104ab3:	83 ec 0c             	sub    $0xc,%esp
80104ab6:	50                   	push   %eax
80104ab7:	e8 0d 04 00 00       	call   80104ec9 <wakeup1>
80104abc:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104abf:	c7 45 f4 d4 10 11 80 	movl   $0x801110d4,-0xc(%ebp)
80104ac6:	eb 3c                	jmp    80104b04 <exit+0x106>
    if(p->parent == proc){
80104ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104acb:	8b 50 14             	mov    0x14(%eax),%edx
80104ace:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad4:	39 c2                	cmp    %eax,%edx
80104ad6:	75 28                	jne    80104b00 <exit+0x102>
      p->parent = initproc;
80104ad8:	8b 15 88 c6 10 80    	mov    0x8010c688,%edx
80104ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae1:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae7:	8b 40 0c             	mov    0xc(%eax),%eax
80104aea:	83 f8 05             	cmp    $0x5,%eax
80104aed:	75 11                	jne    80104b00 <exit+0x102>
        wakeup1(initproc);
80104aef:	a1 88 c6 10 80       	mov    0x8010c688,%eax
80104af4:	83 ec 0c             	sub    $0xc,%esp
80104af7:	50                   	push   %eax
80104af8:	e8 cc 03 00 00       	call   80104ec9 <wakeup1>
80104afd:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b00:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104b04:	81 7d f4 d4 2f 11 80 	cmpl   $0x80112fd4,-0xc(%ebp)
80104b0b:	72 bb                	jb     80104ac8 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104b0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b13:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104b1a:	e8 d6 01 00 00       	call   80104cf5 <sched>
  panic("zombie exit");
80104b1f:	83 ec 0c             	sub    $0xc,%esp
80104b22:	68 d5 96 10 80       	push   $0x801096d5
80104b27:	e8 56 ba ff ff       	call   80100582 <panic>

80104b2c <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104b2c:	55                   	push   %ebp
80104b2d:	89 e5                	mov    %esp,%ebp
80104b2f:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104b32:	83 ec 0c             	sub    $0xc,%esp
80104b35:	68 a0 10 11 80       	push   $0x801110a0
80104b3a:	e8 d7 05 00 00       	call   80105116 <acquire>
80104b3f:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104b42:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b49:	c7 45 f4 d4 10 11 80 	movl   $0x801110d4,-0xc(%ebp)
80104b50:	e9 a6 00 00 00       	jmp    80104bfb <wait+0xcf>
      if(p->parent != proc)
80104b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b58:	8b 50 14             	mov    0x14(%eax),%edx
80104b5b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b61:	39 c2                	cmp    %eax,%edx
80104b63:	0f 85 8d 00 00 00    	jne    80104bf6 <wait+0xca>
        continue;
      havekids = 1;
80104b69:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104b70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b73:	8b 40 0c             	mov    0xc(%eax),%eax
80104b76:	83 f8 05             	cmp    $0x5,%eax
80104b79:	75 7c                	jne    80104bf7 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b7e:	8b 40 10             	mov    0x10(%eax),%eax
80104b81:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b87:	8b 40 08             	mov    0x8(%eax),%eax
80104b8a:	83 ec 0c             	sub    $0xc,%esp
80104b8d:	50                   	push   %eax
80104b8e:	e8 e4 e4 ff ff       	call   80103077 <kfree>
80104b93:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b99:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba3:	8b 40 04             	mov    0x4(%eax),%eax
80104ba6:	83 ec 0c             	sub    $0xc,%esp
80104ba9:	50                   	push   %eax
80104baa:	e8 11 3b 00 00       	call   801086c0 <freevm>
80104baf:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
80104bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bb5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bbf:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd3:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104bd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bda:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104be1:	83 ec 0c             	sub    $0xc,%esp
80104be4:	68 a0 10 11 80       	push   $0x801110a0
80104be9:	e8 8f 05 00 00       	call   8010517d <release>
80104bee:	83 c4 10             	add    $0x10,%esp
        return pid;
80104bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104bf4:	eb 58                	jmp    80104c4e <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104bf6:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bf7:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104bfb:	81 7d f4 d4 2f 11 80 	cmpl   $0x80112fd4,-0xc(%ebp)
80104c02:	0f 82 4d ff ff ff    	jb     80104b55 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104c08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104c0c:	74 0d                	je     80104c1b <wait+0xef>
80104c0e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c14:	8b 40 24             	mov    0x24(%eax),%eax
80104c17:	85 c0                	test   %eax,%eax
80104c19:	74 17                	je     80104c32 <wait+0x106>
      release(&ptable.lock);
80104c1b:	83 ec 0c             	sub    $0xc,%esp
80104c1e:	68 a0 10 11 80       	push   $0x801110a0
80104c23:	e8 55 05 00 00       	call   8010517d <release>
80104c28:	83 c4 10             	add    $0x10,%esp
      return -1;
80104c2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c30:	eb 1c                	jmp    80104c4e <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104c32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c38:	83 ec 08             	sub    $0x8,%esp
80104c3b:	68 a0 10 11 80       	push   $0x801110a0
80104c40:	50                   	push   %eax
80104c41:	e8 d7 01 00 00       	call   80104e1d <sleep>
80104c46:	83 c4 10             	add    $0x10,%esp
  }
80104c49:	e9 f4 fe ff ff       	jmp    80104b42 <wait+0x16>
}
80104c4e:	c9                   	leave  
80104c4f:	c3                   	ret    

80104c50 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104c56:	e8 49 f9 ff ff       	call   801045a4 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104c5b:	83 ec 0c             	sub    $0xc,%esp
80104c5e:	68 a0 10 11 80       	push   $0x801110a0
80104c63:	e8 ae 04 00 00       	call   80105116 <acquire>
80104c68:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c6b:	c7 45 f4 d4 10 11 80 	movl   $0x801110d4,-0xc(%ebp)
80104c72:	eb 63                	jmp    80104cd7 <scheduler+0x87>
      if(p->state != RUNNABLE)
80104c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c77:	8b 40 0c             	mov    0xc(%eax),%eax
80104c7a:	83 f8 03             	cmp    $0x3,%eax
80104c7d:	75 53                	jne    80104cd2 <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80104c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c82:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104c88:	83 ec 0c             	sub    $0xc,%esp
80104c8b:	ff 75 f4             	pushl  -0xc(%ebp)
80104c8e:	e8 e7 35 00 00       	call   8010827a <switchuvm>
80104c93:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c99:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104ca0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ca6:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ca9:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104cb0:	83 c2 04             	add    $0x4,%edx
80104cb3:	83 ec 08             	sub    $0x8,%esp
80104cb6:	50                   	push   %eax
80104cb7:	52                   	push   %edx
80104cb8:	e8 30 09 00 00       	call   801055ed <swtch>
80104cbd:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104cc0:	e8 98 35 00 00       	call   8010825d <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104cc5:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104ccc:	00 00 00 00 
80104cd0:	eb 01                	jmp    80104cd3 <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104cd2:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cd3:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104cd7:	81 7d f4 d4 2f 11 80 	cmpl   $0x80112fd4,-0xc(%ebp)
80104cde:	72 94                	jb     80104c74 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104ce0:	83 ec 0c             	sub    $0xc,%esp
80104ce3:	68 a0 10 11 80       	push   $0x801110a0
80104ce8:	e8 90 04 00 00       	call   8010517d <release>
80104ced:	83 c4 10             	add    $0x10,%esp

  }
80104cf0:	e9 61 ff ff ff       	jmp    80104c56 <scheduler+0x6>

80104cf5 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104cf5:	55                   	push   %ebp
80104cf6:	89 e5                	mov    %esp,%ebp
80104cf8:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104cfb:	83 ec 0c             	sub    $0xc,%esp
80104cfe:	68 a0 10 11 80       	push   $0x801110a0
80104d03:	e8 41 05 00 00       	call   80105249 <holding>
80104d08:	83 c4 10             	add    $0x10,%esp
80104d0b:	85 c0                	test   %eax,%eax
80104d0d:	75 0d                	jne    80104d1c <sched+0x27>
    panic("sched ptable.lock");
80104d0f:	83 ec 0c             	sub    $0xc,%esp
80104d12:	68 e1 96 10 80       	push   $0x801096e1
80104d17:	e8 66 b8 ff ff       	call   80100582 <panic>
  if(cpu->ncli != 1)
80104d1c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d22:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d28:	83 f8 01             	cmp    $0x1,%eax
80104d2b:	74 0d                	je     80104d3a <sched+0x45>
    panic("sched locks");
80104d2d:	83 ec 0c             	sub    $0xc,%esp
80104d30:	68 f3 96 10 80       	push   $0x801096f3
80104d35:	e8 48 b8 ff ff       	call   80100582 <panic>
  if(proc->state == RUNNING)
80104d3a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d40:	8b 40 0c             	mov    0xc(%eax),%eax
80104d43:	83 f8 04             	cmp    $0x4,%eax
80104d46:	75 0d                	jne    80104d55 <sched+0x60>
    panic("sched running");
80104d48:	83 ec 0c             	sub    $0xc,%esp
80104d4b:	68 ff 96 10 80       	push   $0x801096ff
80104d50:	e8 2d b8 ff ff       	call   80100582 <panic>
  if(readeflags()&FL_IF)
80104d55:	e8 3a f8 ff ff       	call   80104594 <readeflags>
80104d5a:	25 00 02 00 00       	and    $0x200,%eax
80104d5f:	85 c0                	test   %eax,%eax
80104d61:	74 0d                	je     80104d70 <sched+0x7b>
    panic("sched interruptible");
80104d63:	83 ec 0c             	sub    $0xc,%esp
80104d66:	68 0d 97 10 80       	push   $0x8010970d
80104d6b:	e8 12 b8 ff ff       	call   80100582 <panic>
  intena = cpu->intena;
80104d70:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d76:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104d7f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d85:	8b 40 04             	mov    0x4(%eax),%eax
80104d88:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d8f:	83 c2 1c             	add    $0x1c,%edx
80104d92:	83 ec 08             	sub    $0x8,%esp
80104d95:	50                   	push   %eax
80104d96:	52                   	push   %edx
80104d97:	e8 51 08 00 00       	call   801055ed <swtch>
80104d9c:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104d9f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104da5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104da8:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104dae:	90                   	nop
80104daf:	c9                   	leave  
80104db0:	c3                   	ret    

80104db1 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104db1:	55                   	push   %ebp
80104db2:	89 e5                	mov    %esp,%ebp
80104db4:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104db7:	83 ec 0c             	sub    $0xc,%esp
80104dba:	68 a0 10 11 80       	push   $0x801110a0
80104dbf:	e8 52 03 00 00       	call   80105116 <acquire>
80104dc4:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104dc7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104dcd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104dd4:	e8 1c ff ff ff       	call   80104cf5 <sched>
  release(&ptable.lock);
80104dd9:	83 ec 0c             	sub    $0xc,%esp
80104ddc:	68 a0 10 11 80       	push   $0x801110a0
80104de1:	e8 97 03 00 00       	call   8010517d <release>
80104de6:	83 c4 10             	add    $0x10,%esp
}
80104de9:	90                   	nop
80104dea:	c9                   	leave  
80104deb:	c3                   	ret    

80104dec <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104dec:	55                   	push   %ebp
80104ded:	89 e5                	mov    %esp,%ebp
80104def:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104df2:	83 ec 0c             	sub    $0xc,%esp
80104df5:	68 a0 10 11 80       	push   $0x801110a0
80104dfa:	e8 7e 03 00 00       	call   8010517d <release>
80104dff:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104e02:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104e07:	85 c0                	test   %eax,%eax
80104e09:	74 0f                	je     80104e1a <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104e0b:	c7 05 08 c0 10 80 00 	movl   $0x0,0x8010c008
80104e12:	00 00 00 
    initlog();
80104e15:	e8 9e e7 ff ff       	call   801035b8 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104e1a:	90                   	nop
80104e1b:	c9                   	leave  
80104e1c:	c3                   	ret    

80104e1d <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104e1d:	55                   	push   %ebp
80104e1e:	89 e5                	mov    %esp,%ebp
80104e20:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104e23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e29:	85 c0                	test   %eax,%eax
80104e2b:	75 0d                	jne    80104e3a <sleep+0x1d>
    panic("sleep");
80104e2d:	83 ec 0c             	sub    $0xc,%esp
80104e30:	68 21 97 10 80       	push   $0x80109721
80104e35:	e8 48 b7 ff ff       	call   80100582 <panic>

  if(lk == 0)
80104e3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104e3e:	75 0d                	jne    80104e4d <sleep+0x30>
    panic("sleep without lk");
80104e40:	83 ec 0c             	sub    $0xc,%esp
80104e43:	68 27 97 10 80       	push   $0x80109727
80104e48:	e8 35 b7 ff ff       	call   80100582 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e4d:	81 7d 0c a0 10 11 80 	cmpl   $0x801110a0,0xc(%ebp)
80104e54:	74 1e                	je     80104e74 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e56:	83 ec 0c             	sub    $0xc,%esp
80104e59:	68 a0 10 11 80       	push   $0x801110a0
80104e5e:	e8 b3 02 00 00       	call   80105116 <acquire>
80104e63:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104e66:	83 ec 0c             	sub    $0xc,%esp
80104e69:	ff 75 0c             	pushl  0xc(%ebp)
80104e6c:	e8 0c 03 00 00       	call   8010517d <release>
80104e71:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104e74:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104e7d:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104e80:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e86:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104e8d:	e8 63 fe ff ff       	call   80104cf5 <sched>

  // Tidy up.
  proc->chan = 0;
80104e92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e98:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104e9f:	81 7d 0c a0 10 11 80 	cmpl   $0x801110a0,0xc(%ebp)
80104ea6:	74 1e                	je     80104ec6 <sleep+0xa9>
    release(&ptable.lock);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
80104eab:	68 a0 10 11 80       	push   $0x801110a0
80104eb0:	e8 c8 02 00 00       	call   8010517d <release>
80104eb5:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104eb8:	83 ec 0c             	sub    $0xc,%esp
80104ebb:	ff 75 0c             	pushl  0xc(%ebp)
80104ebe:	e8 53 02 00 00       	call   80105116 <acquire>
80104ec3:	83 c4 10             	add    $0x10,%esp
  }
}
80104ec6:	90                   	nop
80104ec7:	c9                   	leave  
80104ec8:	c3                   	ret    

80104ec9 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104ec9:	55                   	push   %ebp
80104eca:	89 e5                	mov    %esp,%ebp
80104ecc:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ecf:	c7 45 fc d4 10 11 80 	movl   $0x801110d4,-0x4(%ebp)
80104ed6:	eb 24                	jmp    80104efc <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104ed8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104edb:	8b 40 0c             	mov    0xc(%eax),%eax
80104ede:	83 f8 02             	cmp    $0x2,%eax
80104ee1:	75 15                	jne    80104ef8 <wakeup1+0x2f>
80104ee3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ee6:	8b 40 20             	mov    0x20(%eax),%eax
80104ee9:	3b 45 08             	cmp    0x8(%ebp),%eax
80104eec:	75 0a                	jne    80104ef8 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104eee:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ef1:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ef8:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104efc:	81 7d fc d4 2f 11 80 	cmpl   $0x80112fd4,-0x4(%ebp)
80104f03:	72 d3                	jb     80104ed8 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104f05:	90                   	nop
80104f06:	c9                   	leave  
80104f07:	c3                   	ret    

80104f08 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f08:	55                   	push   %ebp
80104f09:	89 e5                	mov    %esp,%ebp
80104f0b:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104f0e:	83 ec 0c             	sub    $0xc,%esp
80104f11:	68 a0 10 11 80       	push   $0x801110a0
80104f16:	e8 fb 01 00 00       	call   80105116 <acquire>
80104f1b:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104f1e:	83 ec 0c             	sub    $0xc,%esp
80104f21:	ff 75 08             	pushl  0x8(%ebp)
80104f24:	e8 a0 ff ff ff       	call   80104ec9 <wakeup1>
80104f29:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104f2c:	83 ec 0c             	sub    $0xc,%esp
80104f2f:	68 a0 10 11 80       	push   $0x801110a0
80104f34:	e8 44 02 00 00       	call   8010517d <release>
80104f39:	83 c4 10             	add    $0x10,%esp
}
80104f3c:	90                   	nop
80104f3d:	c9                   	leave  
80104f3e:	c3                   	ret    

80104f3f <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f3f:	55                   	push   %ebp
80104f40:	89 e5                	mov    %esp,%ebp
80104f42:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104f45:	83 ec 0c             	sub    $0xc,%esp
80104f48:	68 a0 10 11 80       	push   $0x801110a0
80104f4d:	e8 c4 01 00 00       	call   80105116 <acquire>
80104f52:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f55:	c7 45 f4 d4 10 11 80 	movl   $0x801110d4,-0xc(%ebp)
80104f5c:	eb 45                	jmp    80104fa3 <kill+0x64>
    if(p->pid == pid){
80104f5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f61:	8b 40 10             	mov    0x10(%eax),%eax
80104f64:	3b 45 08             	cmp    0x8(%ebp),%eax
80104f67:	75 36                	jne    80104f9f <kill+0x60>
      p->killed = 1;
80104f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f6c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f76:	8b 40 0c             	mov    0xc(%eax),%eax
80104f79:	83 f8 02             	cmp    $0x2,%eax
80104f7c:	75 0a                	jne    80104f88 <kill+0x49>
        p->state = RUNNABLE;
80104f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f81:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	68 a0 10 11 80       	push   $0x801110a0
80104f90:	e8 e8 01 00 00       	call   8010517d <release>
80104f95:	83 c4 10             	add    $0x10,%esp
      return 0;
80104f98:	b8 00 00 00 00       	mov    $0x0,%eax
80104f9d:	eb 22                	jmp    80104fc1 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f9f:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104fa3:	81 7d f4 d4 2f 11 80 	cmpl   $0x80112fd4,-0xc(%ebp)
80104faa:	72 b2                	jb     80104f5e <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104fac:	83 ec 0c             	sub    $0xc,%esp
80104faf:	68 a0 10 11 80       	push   $0x801110a0
80104fb4:	e8 c4 01 00 00       	call   8010517d <release>
80104fb9:	83 c4 10             	add    $0x10,%esp
  return -1;
80104fbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc1:	c9                   	leave  
80104fc2:	c3                   	ret    

80104fc3 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104fc3:	55                   	push   %ebp
80104fc4:	89 e5                	mov    %esp,%ebp
80104fc6:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fc9:	c7 45 f0 d4 10 11 80 	movl   $0x801110d4,-0x10(%ebp)
80104fd0:	e9 d7 00 00 00       	jmp    801050ac <procdump+0xe9>
    if(p->state == UNUSED)
80104fd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fd8:	8b 40 0c             	mov    0xc(%eax),%eax
80104fdb:	85 c0                	test   %eax,%eax
80104fdd:	0f 84 c4 00 00 00    	je     801050a7 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104fe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fe6:	8b 40 0c             	mov    0xc(%eax),%eax
80104fe9:	83 f8 05             	cmp    $0x5,%eax
80104fec:	77 23                	ja     80105011 <procdump+0x4e>
80104fee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ff1:	8b 40 0c             	mov    0xc(%eax),%eax
80104ff4:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	74 12                	je     80105011 <procdump+0x4e>
      state = states[p->state];
80104fff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105002:	8b 40 0c             	mov    0xc(%eax),%eax
80105005:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
8010500c:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010500f:	eb 07                	jmp    80105018 <procdump+0x55>
    else
      state = "???";
80105011:	c7 45 ec 38 97 10 80 	movl   $0x80109738,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80105018:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010501b:	8d 50 6c             	lea    0x6c(%eax),%edx
8010501e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105021:	8b 40 10             	mov    0x10(%eax),%eax
80105024:	52                   	push   %edx
80105025:	ff 75 ec             	pushl  -0x14(%ebp)
80105028:	50                   	push   %eax
80105029:	68 3c 97 10 80       	push   $0x8010973c
8010502e:	e8 af b3 ff ff       	call   801003e2 <cprintf>
80105033:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80105036:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105039:	8b 40 0c             	mov    0xc(%eax),%eax
8010503c:	83 f8 02             	cmp    $0x2,%eax
8010503f:	75 54                	jne    80105095 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105041:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105044:	8b 40 1c             	mov    0x1c(%eax),%eax
80105047:	8b 40 0c             	mov    0xc(%eax),%eax
8010504a:	83 c0 08             	add    $0x8,%eax
8010504d:	89 c2                	mov    %eax,%edx
8010504f:	83 ec 08             	sub    $0x8,%esp
80105052:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105055:	50                   	push   %eax
80105056:	52                   	push   %edx
80105057:	e8 73 01 00 00       	call   801051cf <getcallerpcs>
8010505c:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
8010505f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105066:	eb 1c                	jmp    80105084 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80105068:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010506b:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
8010506f:	83 ec 08             	sub    $0x8,%esp
80105072:	50                   	push   %eax
80105073:	68 45 97 10 80       	push   $0x80109745
80105078:	e8 65 b3 ff ff       	call   801003e2 <cprintf>
8010507d:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80105080:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105084:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80105088:	7f 0b                	jg     80105095 <procdump+0xd2>
8010508a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010508d:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105091:	85 c0                	test   %eax,%eax
80105093:	75 d3                	jne    80105068 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105095:	83 ec 0c             	sub    $0xc,%esp
80105098:	68 49 97 10 80       	push   $0x80109749
8010509d:	e8 40 b3 ff ff       	call   801003e2 <cprintf>
801050a2:	83 c4 10             	add    $0x10,%esp
801050a5:	eb 01                	jmp    801050a8 <procdump+0xe5>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
801050a7:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801050a8:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
801050ac:	81 7d f0 d4 2f 11 80 	cmpl   $0x80112fd4,-0x10(%ebp)
801050b3:	0f 82 1c ff ff ff    	jb     80104fd5 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801050b9:	90                   	nop
801050ba:	c9                   	leave  
801050bb:	c3                   	ret    

801050bc <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801050bc:	55                   	push   %ebp
801050bd:	89 e5                	mov    %esp,%ebp
801050bf:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801050c2:	9c                   	pushf  
801050c3:	58                   	pop    %eax
801050c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801050c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050ca:	c9                   	leave  
801050cb:	c3                   	ret    

801050cc <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801050cc:	55                   	push   %ebp
801050cd:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801050cf:	fa                   	cli    
}
801050d0:	90                   	nop
801050d1:	5d                   	pop    %ebp
801050d2:	c3                   	ret    

801050d3 <sti>:

static inline void
sti(void)
{
801050d3:	55                   	push   %ebp
801050d4:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801050d6:	fb                   	sti    
}
801050d7:	90                   	nop
801050d8:	5d                   	pop    %ebp
801050d9:	c3                   	ret    

801050da <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
801050da:	55                   	push   %ebp
801050db:	89 e5                	mov    %esp,%ebp
801050dd:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801050e0:	8b 55 08             	mov    0x8(%ebp),%edx
801050e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801050e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050e9:	f0 87 02             	lock xchg %eax,(%edx)
801050ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801050ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050f2:	c9                   	leave  
801050f3:	c3                   	ret    

801050f4 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050f4:	55                   	push   %ebp
801050f5:	89 e5                	mov    %esp,%ebp
  lk->name = name;
801050f7:	8b 45 08             	mov    0x8(%ebp),%eax
801050fa:	8b 55 0c             	mov    0xc(%ebp),%edx
801050fd:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105100:	8b 45 08             	mov    0x8(%ebp),%eax
80105103:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105109:	8b 45 08             	mov    0x8(%ebp),%eax
8010510c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105113:	90                   	nop
80105114:	5d                   	pop    %ebp
80105115:	c3                   	ret    

80105116 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105116:	55                   	push   %ebp
80105117:	89 e5                	mov    %esp,%ebp
80105119:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
8010511c:	e8 52 01 00 00       	call   80105273 <pushcli>
  if(holding(lk))
80105121:	8b 45 08             	mov    0x8(%ebp),%eax
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	50                   	push   %eax
80105128:	e8 1c 01 00 00       	call   80105249 <holding>
8010512d:	83 c4 10             	add    $0x10,%esp
80105130:	85 c0                	test   %eax,%eax
80105132:	74 0d                	je     80105141 <acquire+0x2b>
    panic("acquire");
80105134:	83 ec 0c             	sub    $0xc,%esp
80105137:	68 75 97 10 80       	push   $0x80109775
8010513c:	e8 41 b4 ff ff       	call   80100582 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105141:	90                   	nop
80105142:	8b 45 08             	mov    0x8(%ebp),%eax
80105145:	83 ec 08             	sub    $0x8,%esp
80105148:	6a 01                	push   $0x1
8010514a:	50                   	push   %eax
8010514b:	e8 8a ff ff ff       	call   801050da <xchg>
80105150:	83 c4 10             	add    $0x10,%esp
80105153:	85 c0                	test   %eax,%eax
80105155:	75 eb                	jne    80105142 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105157:	8b 45 08             	mov    0x8(%ebp),%eax
8010515a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105161:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80105164:	8b 45 08             	mov    0x8(%ebp),%eax
80105167:	83 c0 0c             	add    $0xc,%eax
8010516a:	83 ec 08             	sub    $0x8,%esp
8010516d:	50                   	push   %eax
8010516e:	8d 45 08             	lea    0x8(%ebp),%eax
80105171:	50                   	push   %eax
80105172:	e8 58 00 00 00       	call   801051cf <getcallerpcs>
80105177:	83 c4 10             	add    $0x10,%esp
}
8010517a:	90                   	nop
8010517b:	c9                   	leave  
8010517c:	c3                   	ret    

8010517d <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
8010517d:	55                   	push   %ebp
8010517e:	89 e5                	mov    %esp,%ebp
80105180:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80105183:	83 ec 0c             	sub    $0xc,%esp
80105186:	ff 75 08             	pushl  0x8(%ebp)
80105189:	e8 bb 00 00 00       	call   80105249 <holding>
8010518e:	83 c4 10             	add    $0x10,%esp
80105191:	85 c0                	test   %eax,%eax
80105193:	75 0d                	jne    801051a2 <release+0x25>
    panic("release");
80105195:	83 ec 0c             	sub    $0xc,%esp
80105198:	68 7d 97 10 80       	push   $0x8010977d
8010519d:	e8 e0 b3 ff ff       	call   80100582 <panic>

  lk->pcs[0] = 0;
801051a2:	8b 45 08             	mov    0x8(%ebp),%eax
801051a5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801051ac:	8b 45 08             	mov    0x8(%ebp),%eax
801051af:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
801051b6:	8b 45 08             	mov    0x8(%ebp),%eax
801051b9:	83 ec 08             	sub    $0x8,%esp
801051bc:	6a 00                	push   $0x0
801051be:	50                   	push   %eax
801051bf:	e8 16 ff ff ff       	call   801050da <xchg>
801051c4:	83 c4 10             	add    $0x10,%esp

  popcli();
801051c7:	e8 ec 00 00 00       	call   801052b8 <popcli>
}
801051cc:	90                   	nop
801051cd:	c9                   	leave  
801051ce:	c3                   	ret    

801051cf <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801051cf:	55                   	push   %ebp
801051d0:	89 e5                	mov    %esp,%ebp
801051d2:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
801051d5:	8b 45 08             	mov    0x8(%ebp),%eax
801051d8:	83 e8 08             	sub    $0x8,%eax
801051db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801051de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801051e5:	eb 38                	jmp    8010521f <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801051eb:	74 53                	je     80105240 <getcallerpcs+0x71>
801051ed:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801051f4:	76 4a                	jbe    80105240 <getcallerpcs+0x71>
801051f6:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801051fa:	74 44                	je     80105240 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
801051fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105206:	8b 45 0c             	mov    0xc(%ebp),%eax
80105209:	01 c2                	add    %eax,%edx
8010520b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010520e:	8b 40 04             	mov    0x4(%eax),%eax
80105211:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105213:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105216:	8b 00                	mov    (%eax),%eax
80105218:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010521b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010521f:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105223:	7e c2                	jle    801051e7 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105225:	eb 19                	jmp    80105240 <getcallerpcs+0x71>
    pcs[i] = 0;
80105227:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010522a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105231:	8b 45 0c             	mov    0xc(%ebp),%eax
80105234:	01 d0                	add    %edx,%eax
80105236:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010523c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105240:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105244:	7e e1                	jle    80105227 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80105246:	90                   	nop
80105247:	c9                   	leave  
80105248:	c3                   	ret    

80105249 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105249:	55                   	push   %ebp
8010524a:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
8010524c:	8b 45 08             	mov    0x8(%ebp),%eax
8010524f:	8b 00                	mov    (%eax),%eax
80105251:	85 c0                	test   %eax,%eax
80105253:	74 17                	je     8010526c <holding+0x23>
80105255:	8b 45 08             	mov    0x8(%ebp),%eax
80105258:	8b 50 08             	mov    0x8(%eax),%edx
8010525b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105261:	39 c2                	cmp    %eax,%edx
80105263:	75 07                	jne    8010526c <holding+0x23>
80105265:	b8 01 00 00 00       	mov    $0x1,%eax
8010526a:	eb 05                	jmp    80105271 <holding+0x28>
8010526c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105271:	5d                   	pop    %ebp
80105272:	c3                   	ret    

80105273 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105273:	55                   	push   %ebp
80105274:	89 e5                	mov    %esp,%ebp
80105276:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105279:	e8 3e fe ff ff       	call   801050bc <readeflags>
8010527e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105281:	e8 46 fe ff ff       	call   801050cc <cli>
  if(cpu->ncli++ == 0)
80105286:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010528d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105293:	8d 48 01             	lea    0x1(%eax),%ecx
80105296:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
8010529c:	85 c0                	test   %eax,%eax
8010529e:	75 15                	jne    801052b5 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801052a0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052a9:	81 e2 00 02 00 00    	and    $0x200,%edx
801052af:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801052b5:	90                   	nop
801052b6:	c9                   	leave  
801052b7:	c3                   	ret    

801052b8 <popcli>:

void
popcli(void)
{
801052b8:	55                   	push   %ebp
801052b9:	89 e5                	mov    %esp,%ebp
801052bb:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801052be:	e8 f9 fd ff ff       	call   801050bc <readeflags>
801052c3:	25 00 02 00 00       	and    $0x200,%eax
801052c8:	85 c0                	test   %eax,%eax
801052ca:	74 0d                	je     801052d9 <popcli+0x21>
    panic("popcli - interruptible");
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	68 85 97 10 80       	push   $0x80109785
801052d4:	e8 a9 b2 ff ff       	call   80100582 <panic>
  if(--cpu->ncli < 0)
801052d9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052df:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801052e5:	83 ea 01             	sub    $0x1,%edx
801052e8:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801052ee:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052f4:	85 c0                	test   %eax,%eax
801052f6:	79 0d                	jns    80105305 <popcli+0x4d>
    panic("popcli");
801052f8:	83 ec 0c             	sub    $0xc,%esp
801052fb:	68 9c 97 10 80       	push   $0x8010979c
80105300:	e8 7d b2 ff ff       	call   80100582 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105305:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010530b:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105311:	85 c0                	test   %eax,%eax
80105313:	75 15                	jne    8010532a <popcli+0x72>
80105315:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010531b:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105321:	85 c0                	test   %eax,%eax
80105323:	74 05                	je     8010532a <popcli+0x72>
    sti();
80105325:	e8 a9 fd ff ff       	call   801050d3 <sti>
}
8010532a:	90                   	nop
8010532b:	c9                   	leave  
8010532c:	c3                   	ret    

8010532d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010532d:	55                   	push   %ebp
8010532e:	89 e5                	mov    %esp,%ebp
80105330:	57                   	push   %edi
80105331:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105332:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105335:	8b 55 10             	mov    0x10(%ebp),%edx
80105338:	8b 45 0c             	mov    0xc(%ebp),%eax
8010533b:	89 cb                	mov    %ecx,%ebx
8010533d:	89 df                	mov    %ebx,%edi
8010533f:	89 d1                	mov    %edx,%ecx
80105341:	fc                   	cld    
80105342:	f3 aa                	rep stos %al,%es:(%edi)
80105344:	89 ca                	mov    %ecx,%edx
80105346:	89 fb                	mov    %edi,%ebx
80105348:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010534b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010534e:	90                   	nop
8010534f:	5b                   	pop    %ebx
80105350:	5f                   	pop    %edi
80105351:	5d                   	pop    %ebp
80105352:	c3                   	ret    

80105353 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105353:	55                   	push   %ebp
80105354:	89 e5                	mov    %esp,%ebp
80105356:	57                   	push   %edi
80105357:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105358:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010535b:	8b 55 10             	mov    0x10(%ebp),%edx
8010535e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105361:	89 cb                	mov    %ecx,%ebx
80105363:	89 df                	mov    %ebx,%edi
80105365:	89 d1                	mov    %edx,%ecx
80105367:	fc                   	cld    
80105368:	f3 ab                	rep stos %eax,%es:(%edi)
8010536a:	89 ca                	mov    %ecx,%edx
8010536c:	89 fb                	mov    %edi,%ebx
8010536e:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105371:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105374:	90                   	nop
80105375:	5b                   	pop    %ebx
80105376:	5f                   	pop    %edi
80105377:	5d                   	pop    %ebp
80105378:	c3                   	ret    

80105379 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105379:	55                   	push   %ebp
8010537a:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
8010537c:	8b 45 08             	mov    0x8(%ebp),%eax
8010537f:	83 e0 03             	and    $0x3,%eax
80105382:	85 c0                	test   %eax,%eax
80105384:	75 43                	jne    801053c9 <memset+0x50>
80105386:	8b 45 10             	mov    0x10(%ebp),%eax
80105389:	83 e0 03             	and    $0x3,%eax
8010538c:	85 c0                	test   %eax,%eax
8010538e:	75 39                	jne    801053c9 <memset+0x50>
    c &= 0xFF;
80105390:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105397:	8b 45 10             	mov    0x10(%ebp),%eax
8010539a:	c1 e8 02             	shr    $0x2,%eax
8010539d:	89 c1                	mov    %eax,%ecx
8010539f:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a2:	c1 e0 18             	shl    $0x18,%eax
801053a5:	89 c2                	mov    %eax,%edx
801053a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801053aa:	c1 e0 10             	shl    $0x10,%eax
801053ad:	09 c2                	or     %eax,%edx
801053af:	8b 45 0c             	mov    0xc(%ebp),%eax
801053b2:	c1 e0 08             	shl    $0x8,%eax
801053b5:	09 d0                	or     %edx,%eax
801053b7:	0b 45 0c             	or     0xc(%ebp),%eax
801053ba:	51                   	push   %ecx
801053bb:	50                   	push   %eax
801053bc:	ff 75 08             	pushl  0x8(%ebp)
801053bf:	e8 8f ff ff ff       	call   80105353 <stosl>
801053c4:	83 c4 0c             	add    $0xc,%esp
801053c7:	eb 12                	jmp    801053db <memset+0x62>
  } else
    stosb(dst, c, n);
801053c9:	8b 45 10             	mov    0x10(%ebp),%eax
801053cc:	50                   	push   %eax
801053cd:	ff 75 0c             	pushl  0xc(%ebp)
801053d0:	ff 75 08             	pushl  0x8(%ebp)
801053d3:	e8 55 ff ff ff       	call   8010532d <stosb>
801053d8:	83 c4 0c             	add    $0xc,%esp
  return dst;
801053db:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053de:	c9                   	leave  
801053df:	c3                   	ret    

801053e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
801053e6:	8b 45 08             	mov    0x8(%ebp),%eax
801053e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801053ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801053f2:	eb 30                	jmp    80105424 <memcmp+0x44>
    if(*s1 != *s2)
801053f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053f7:	0f b6 10             	movzbl (%eax),%edx
801053fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053fd:	0f b6 00             	movzbl (%eax),%eax
80105400:	38 c2                	cmp    %al,%dl
80105402:	74 18                	je     8010541c <memcmp+0x3c>
      return *s1 - *s2;
80105404:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105407:	0f b6 00             	movzbl (%eax),%eax
8010540a:	0f b6 d0             	movzbl %al,%edx
8010540d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105410:	0f b6 00             	movzbl (%eax),%eax
80105413:	0f b6 c0             	movzbl %al,%eax
80105416:	29 c2                	sub    %eax,%edx
80105418:	89 d0                	mov    %edx,%eax
8010541a:	eb 1a                	jmp    80105436 <memcmp+0x56>
    s1++, s2++;
8010541c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105420:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105424:	8b 45 10             	mov    0x10(%ebp),%eax
80105427:	8d 50 ff             	lea    -0x1(%eax),%edx
8010542a:	89 55 10             	mov    %edx,0x10(%ebp)
8010542d:	85 c0                	test   %eax,%eax
8010542f:	75 c3                	jne    801053f4 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105431:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105436:	c9                   	leave  
80105437:	c3                   	ret    

80105438 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105438:	55                   	push   %ebp
80105439:	89 e5                	mov    %esp,%ebp
8010543b:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010543e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105441:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105444:	8b 45 08             	mov    0x8(%ebp),%eax
80105447:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010544a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010544d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105450:	73 54                	jae    801054a6 <memmove+0x6e>
80105452:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105455:	8b 45 10             	mov    0x10(%ebp),%eax
80105458:	01 d0                	add    %edx,%eax
8010545a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010545d:	76 47                	jbe    801054a6 <memmove+0x6e>
    s += n;
8010545f:	8b 45 10             	mov    0x10(%ebp),%eax
80105462:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105465:	8b 45 10             	mov    0x10(%ebp),%eax
80105468:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010546b:	eb 13                	jmp    80105480 <memmove+0x48>
      *--d = *--s;
8010546d:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105471:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105475:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105478:	0f b6 10             	movzbl (%eax),%edx
8010547b:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010547e:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105480:	8b 45 10             	mov    0x10(%ebp),%eax
80105483:	8d 50 ff             	lea    -0x1(%eax),%edx
80105486:	89 55 10             	mov    %edx,0x10(%ebp)
80105489:	85 c0                	test   %eax,%eax
8010548b:	75 e0                	jne    8010546d <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010548d:	eb 24                	jmp    801054b3 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
8010548f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105492:	8d 50 01             	lea    0x1(%eax),%edx
80105495:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105498:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010549b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010549e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801054a1:	0f b6 12             	movzbl (%edx),%edx
801054a4:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801054a6:	8b 45 10             	mov    0x10(%ebp),%eax
801054a9:	8d 50 ff             	lea    -0x1(%eax),%edx
801054ac:	89 55 10             	mov    %edx,0x10(%ebp)
801054af:	85 c0                	test   %eax,%eax
801054b1:	75 dc                	jne    8010548f <memmove+0x57>
      *d++ = *s++;

  return dst;
801054b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801054b6:	c9                   	leave  
801054b7:	c3                   	ret    

801054b8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801054b8:	55                   	push   %ebp
801054b9:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801054bb:	ff 75 10             	pushl  0x10(%ebp)
801054be:	ff 75 0c             	pushl  0xc(%ebp)
801054c1:	ff 75 08             	pushl  0x8(%ebp)
801054c4:	e8 6f ff ff ff       	call   80105438 <memmove>
801054c9:	83 c4 0c             	add    $0xc,%esp
}
801054cc:	c9                   	leave  
801054cd:	c3                   	ret    

801054ce <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801054ce:	55                   	push   %ebp
801054cf:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801054d1:	eb 0c                	jmp    801054df <strncmp+0x11>
    n--, p++, q++;
801054d3:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801054d7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801054db:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801054df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054e3:	74 1a                	je     801054ff <strncmp+0x31>
801054e5:	8b 45 08             	mov    0x8(%ebp),%eax
801054e8:	0f b6 00             	movzbl (%eax),%eax
801054eb:	84 c0                	test   %al,%al
801054ed:	74 10                	je     801054ff <strncmp+0x31>
801054ef:	8b 45 08             	mov    0x8(%ebp),%eax
801054f2:	0f b6 10             	movzbl (%eax),%edx
801054f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801054f8:	0f b6 00             	movzbl (%eax),%eax
801054fb:	38 c2                	cmp    %al,%dl
801054fd:	74 d4                	je     801054d3 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
801054ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105503:	75 07                	jne    8010550c <strncmp+0x3e>
    return 0;
80105505:	b8 00 00 00 00       	mov    $0x0,%eax
8010550a:	eb 16                	jmp    80105522 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
8010550c:	8b 45 08             	mov    0x8(%ebp),%eax
8010550f:	0f b6 00             	movzbl (%eax),%eax
80105512:	0f b6 d0             	movzbl %al,%edx
80105515:	8b 45 0c             	mov    0xc(%ebp),%eax
80105518:	0f b6 00             	movzbl (%eax),%eax
8010551b:	0f b6 c0             	movzbl %al,%eax
8010551e:	29 c2                	sub    %eax,%edx
80105520:	89 d0                	mov    %edx,%eax
}
80105522:	5d                   	pop    %ebp
80105523:	c3                   	ret    

80105524 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105524:	55                   	push   %ebp
80105525:	89 e5                	mov    %esp,%ebp
80105527:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010552a:	8b 45 08             	mov    0x8(%ebp),%eax
8010552d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105530:	90                   	nop
80105531:	8b 45 10             	mov    0x10(%ebp),%eax
80105534:	8d 50 ff             	lea    -0x1(%eax),%edx
80105537:	89 55 10             	mov    %edx,0x10(%ebp)
8010553a:	85 c0                	test   %eax,%eax
8010553c:	7e 2c                	jle    8010556a <strncpy+0x46>
8010553e:	8b 45 08             	mov    0x8(%ebp),%eax
80105541:	8d 50 01             	lea    0x1(%eax),%edx
80105544:	89 55 08             	mov    %edx,0x8(%ebp)
80105547:	8b 55 0c             	mov    0xc(%ebp),%edx
8010554a:	8d 4a 01             	lea    0x1(%edx),%ecx
8010554d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105550:	0f b6 12             	movzbl (%edx),%edx
80105553:	88 10                	mov    %dl,(%eax)
80105555:	0f b6 00             	movzbl (%eax),%eax
80105558:	84 c0                	test   %al,%al
8010555a:	75 d5                	jne    80105531 <strncpy+0xd>
    ;
  while(n-- > 0)
8010555c:	eb 0c                	jmp    8010556a <strncpy+0x46>
    *s++ = 0;
8010555e:	8b 45 08             	mov    0x8(%ebp),%eax
80105561:	8d 50 01             	lea    0x1(%eax),%edx
80105564:	89 55 08             	mov    %edx,0x8(%ebp)
80105567:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010556a:	8b 45 10             	mov    0x10(%ebp),%eax
8010556d:	8d 50 ff             	lea    -0x1(%eax),%edx
80105570:	89 55 10             	mov    %edx,0x10(%ebp)
80105573:	85 c0                	test   %eax,%eax
80105575:	7f e7                	jg     8010555e <strncpy+0x3a>
    *s++ = 0;
  return os;
80105577:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010557a:	c9                   	leave  
8010557b:	c3                   	ret    

8010557c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010557c:	55                   	push   %ebp
8010557d:	89 e5                	mov    %esp,%ebp
8010557f:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105582:	8b 45 08             	mov    0x8(%ebp),%eax
80105585:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105588:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010558c:	7f 05                	jg     80105593 <safestrcpy+0x17>
    return os;
8010558e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105591:	eb 31                	jmp    801055c4 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105593:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105597:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010559b:	7e 1e                	jle    801055bb <safestrcpy+0x3f>
8010559d:	8b 45 08             	mov    0x8(%ebp),%eax
801055a0:	8d 50 01             	lea    0x1(%eax),%edx
801055a3:	89 55 08             	mov    %edx,0x8(%ebp)
801055a6:	8b 55 0c             	mov    0xc(%ebp),%edx
801055a9:	8d 4a 01             	lea    0x1(%edx),%ecx
801055ac:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801055af:	0f b6 12             	movzbl (%edx),%edx
801055b2:	88 10                	mov    %dl,(%eax)
801055b4:	0f b6 00             	movzbl (%eax),%eax
801055b7:	84 c0                	test   %al,%al
801055b9:	75 d8                	jne    80105593 <safestrcpy+0x17>
    ;
  *s = 0;
801055bb:	8b 45 08             	mov    0x8(%ebp),%eax
801055be:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801055c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055c4:	c9                   	leave  
801055c5:	c3                   	ret    

801055c6 <strlen>:

int
strlen(const char *s)
{
801055c6:	55                   	push   %ebp
801055c7:	89 e5                	mov    %esp,%ebp
801055c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801055cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055d3:	eb 04                	jmp    801055d9 <strlen+0x13>
801055d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055dc:	8b 45 08             	mov    0x8(%ebp),%eax
801055df:	01 d0                	add    %edx,%eax
801055e1:	0f b6 00             	movzbl (%eax),%eax
801055e4:	84 c0                	test   %al,%al
801055e6:	75 ed                	jne    801055d5 <strlen+0xf>
    ;
  return n;
801055e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055eb:	c9                   	leave  
801055ec:	c3                   	ret    

801055ed <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801055ed:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801055f1:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801055f5:	55                   	push   %ebp
  pushl %ebx
801055f6:	53                   	push   %ebx
  pushl %esi
801055f7:	56                   	push   %esi
  pushl %edi
801055f8:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801055f9:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801055fb:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801055fd:	5f                   	pop    %edi
  popl %esi
801055fe:	5e                   	pop    %esi
  popl %ebx
801055ff:	5b                   	pop    %ebx
  popl %ebp
80105600:	5d                   	pop    %ebp
  ret
80105601:	c3                   	ret    

80105602 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105602:	55                   	push   %ebp
80105603:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105605:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010560b:	8b 00                	mov    (%eax),%eax
8010560d:	3b 45 08             	cmp    0x8(%ebp),%eax
80105610:	76 12                	jbe    80105624 <fetchint+0x22>
80105612:	8b 45 08             	mov    0x8(%ebp),%eax
80105615:	8d 50 04             	lea    0x4(%eax),%edx
80105618:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010561e:	8b 00                	mov    (%eax),%eax
80105620:	39 c2                	cmp    %eax,%edx
80105622:	76 07                	jbe    8010562b <fetchint+0x29>
    return -1;
80105624:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105629:	eb 0f                	jmp    8010563a <fetchint+0x38>
  *ip = *(int*)(addr);
8010562b:	8b 45 08             	mov    0x8(%ebp),%eax
8010562e:	8b 10                	mov    (%eax),%edx
80105630:	8b 45 0c             	mov    0xc(%ebp),%eax
80105633:	89 10                	mov    %edx,(%eax)
  return 0;
80105635:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010563a:	5d                   	pop    %ebp
8010563b:	c3                   	ret    

8010563c <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010563c:	55                   	push   %ebp
8010563d:	89 e5                	mov    %esp,%ebp
8010563f:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105642:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105648:	8b 00                	mov    (%eax),%eax
8010564a:	3b 45 08             	cmp    0x8(%ebp),%eax
8010564d:	77 07                	ja     80105656 <fetchstr+0x1a>
    return -1;
8010564f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105654:	eb 46                	jmp    8010569c <fetchstr+0x60>
  *pp = (char*)addr;
80105656:	8b 55 08             	mov    0x8(%ebp),%edx
80105659:	8b 45 0c             	mov    0xc(%ebp),%eax
8010565c:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010565e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105664:	8b 00                	mov    (%eax),%eax
80105666:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105669:	8b 45 0c             	mov    0xc(%ebp),%eax
8010566c:	8b 00                	mov    (%eax),%eax
8010566e:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105671:	eb 1c                	jmp    8010568f <fetchstr+0x53>
    if(*s == 0)
80105673:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105676:	0f b6 00             	movzbl (%eax),%eax
80105679:	84 c0                	test   %al,%al
8010567b:	75 0e                	jne    8010568b <fetchstr+0x4f>
      return s - *pp;
8010567d:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105680:	8b 45 0c             	mov    0xc(%ebp),%eax
80105683:	8b 00                	mov    (%eax),%eax
80105685:	29 c2                	sub    %eax,%edx
80105687:	89 d0                	mov    %edx,%eax
80105689:	eb 11                	jmp    8010569c <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010568b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010568f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105695:	72 dc                	jb     80105673 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010569c:	c9                   	leave  
8010569d:	c3                   	ret    

8010569e <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010569e:	55                   	push   %ebp
8010569f:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801056a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056a7:	8b 40 18             	mov    0x18(%eax),%eax
801056aa:	8b 40 44             	mov    0x44(%eax),%eax
801056ad:	8b 55 08             	mov    0x8(%ebp),%edx
801056b0:	c1 e2 02             	shl    $0x2,%edx
801056b3:	01 d0                	add    %edx,%eax
801056b5:	83 c0 04             	add    $0x4,%eax
801056b8:	ff 75 0c             	pushl  0xc(%ebp)
801056bb:	50                   	push   %eax
801056bc:	e8 41 ff ff ff       	call   80105602 <fetchint>
801056c1:	83 c4 08             	add    $0x8,%esp
}
801056c4:	c9                   	leave  
801056c5:	c3                   	ret    

801056c6 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801056c6:	55                   	push   %ebp
801056c7:	89 e5                	mov    %esp,%ebp
801056c9:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801056cc:	8d 45 fc             	lea    -0x4(%ebp),%eax
801056cf:	50                   	push   %eax
801056d0:	ff 75 08             	pushl  0x8(%ebp)
801056d3:	e8 c6 ff ff ff       	call   8010569e <argint>
801056d8:	83 c4 08             	add    $0x8,%esp
801056db:	85 c0                	test   %eax,%eax
801056dd:	79 07                	jns    801056e6 <argptr+0x20>
    return -1;
801056df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e4:	eb 3b                	jmp    80105721 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801056e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056ec:	8b 00                	mov    (%eax),%eax
801056ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056f1:	39 d0                	cmp    %edx,%eax
801056f3:	76 16                	jbe    8010570b <argptr+0x45>
801056f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056f8:	89 c2                	mov    %eax,%edx
801056fa:	8b 45 10             	mov    0x10(%ebp),%eax
801056fd:	01 c2                	add    %eax,%edx
801056ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105705:	8b 00                	mov    (%eax),%eax
80105707:	39 c2                	cmp    %eax,%edx
80105709:	76 07                	jbe    80105712 <argptr+0x4c>
    return -1;
8010570b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105710:	eb 0f                	jmp    80105721 <argptr+0x5b>
  *pp = (char*)i;
80105712:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105715:	89 c2                	mov    %eax,%edx
80105717:	8b 45 0c             	mov    0xc(%ebp),%eax
8010571a:	89 10                	mov    %edx,(%eax)
  return 0;
8010571c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105721:	c9                   	leave  
80105722:	c3                   	ret    

80105723 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105723:	55                   	push   %ebp
80105724:	89 e5                	mov    %esp,%ebp
80105726:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105729:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010572c:	50                   	push   %eax
8010572d:	ff 75 08             	pushl  0x8(%ebp)
80105730:	e8 69 ff ff ff       	call   8010569e <argint>
80105735:	83 c4 08             	add    $0x8,%esp
80105738:	85 c0                	test   %eax,%eax
8010573a:	79 07                	jns    80105743 <argstr+0x20>
    return -1;
8010573c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105741:	eb 0f                	jmp    80105752 <argstr+0x2f>
  return fetchstr(addr, pp);
80105743:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105746:	ff 75 0c             	pushl  0xc(%ebp)
80105749:	50                   	push   %eax
8010574a:	e8 ed fe ff ff       	call   8010563c <fetchstr>
8010574f:	83 c4 08             	add    $0x8,%esp
}
80105752:	c9                   	leave  
80105753:	c3                   	ret    

80105754 <syscall>:

};

void
syscall(void)
{
80105754:	55                   	push   %ebp
80105755:	89 e5                	mov    %esp,%ebp
80105757:	53                   	push   %ebx
80105758:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
8010575b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105761:	8b 40 18             	mov    0x18(%eax),%eax
80105764:	8b 40 1c             	mov    0x1c(%eax),%eax
80105767:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010576a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010576e:	7e 30                	jle    801057a0 <syscall+0x4c>
80105770:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105773:	83 f8 21             	cmp    $0x21,%eax
80105776:	77 28                	ja     801057a0 <syscall+0x4c>
80105778:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010577b:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105782:	85 c0                	test   %eax,%eax
80105784:	74 1a                	je     801057a0 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105786:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010578c:	8b 58 18             	mov    0x18(%eax),%ebx
8010578f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105792:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105799:	ff d0                	call   *%eax
8010579b:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010579e:	eb 34                	jmp    801057d4 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801057a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057a6:	8d 50 6c             	lea    0x6c(%eax),%edx
801057a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801057af:	8b 40 10             	mov    0x10(%eax),%eax
801057b2:	ff 75 f4             	pushl  -0xc(%ebp)
801057b5:	52                   	push   %edx
801057b6:	50                   	push   %eax
801057b7:	68 a3 97 10 80       	push   $0x801097a3
801057bc:	e8 21 ac ff ff       	call   801003e2 <cprintf>
801057c1:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801057c4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057ca:	8b 40 18             	mov    0x18(%eax),%eax
801057cd:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801057d4:	90                   	nop
801057d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d8:	c9                   	leave  
801057d9:	c3                   	ret    

801057da <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801057da:	55                   	push   %ebp
801057db:	89 e5                	mov    %esp,%ebp
801057dd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801057e0:	83 ec 08             	sub    $0x8,%esp
801057e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057e6:	50                   	push   %eax
801057e7:	ff 75 08             	pushl  0x8(%ebp)
801057ea:	e8 af fe ff ff       	call   8010569e <argint>
801057ef:	83 c4 10             	add    $0x10,%esp
801057f2:	85 c0                	test   %eax,%eax
801057f4:	79 07                	jns    801057fd <argfd+0x23>
    return -1;
801057f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fb:	eb 50                	jmp    8010584d <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801057fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105800:	85 c0                	test   %eax,%eax
80105802:	78 21                	js     80105825 <argfd+0x4b>
80105804:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105807:	83 f8 0f             	cmp    $0xf,%eax
8010580a:	7f 19                	jg     80105825 <argfd+0x4b>
8010580c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105812:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105815:	83 c2 08             	add    $0x8,%edx
80105818:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010581c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010581f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105823:	75 07                	jne    8010582c <argfd+0x52>
    return -1;
80105825:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582a:	eb 21                	jmp    8010584d <argfd+0x73>
  if(pfd)
8010582c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105830:	74 08                	je     8010583a <argfd+0x60>
    *pfd = fd;
80105832:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105835:	8b 45 0c             	mov    0xc(%ebp),%eax
80105838:	89 10                	mov    %edx,(%eax)
  if(pf)
8010583a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010583e:	74 08                	je     80105848 <argfd+0x6e>
    *pf = f;
80105840:	8b 45 10             	mov    0x10(%ebp),%eax
80105843:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105846:	89 10                	mov    %edx,(%eax)
  return 0;
80105848:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010584d:	c9                   	leave  
8010584e:	c3                   	ret    

8010584f <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010584f:	55                   	push   %ebp
80105850:	89 e5                	mov    %esp,%ebp
80105852:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105855:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010585c:	eb 30                	jmp    8010588e <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010585e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105864:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105867:	83 c2 08             	add    $0x8,%edx
8010586a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010586e:	85 c0                	test   %eax,%eax
80105870:	75 18                	jne    8010588a <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105872:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105878:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010587b:	8d 4a 08             	lea    0x8(%edx),%ecx
8010587e:	8b 55 08             	mov    0x8(%ebp),%edx
80105881:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105885:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105888:	eb 0f                	jmp    80105899 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010588a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010588e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105892:	7e ca                	jle    8010585e <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105894:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105899:	c9                   	leave  
8010589a:	c3                   	ret    

8010589b <sys_dup>:

int
sys_dup(void)
{
8010589b:	55                   	push   %ebp
8010589c:	89 e5                	mov    %esp,%ebp
8010589e:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801058a1:	83 ec 04             	sub    $0x4,%esp
801058a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058a7:	50                   	push   %eax
801058a8:	6a 00                	push   $0x0
801058aa:	6a 00                	push   $0x0
801058ac:	e8 29 ff ff ff       	call   801057da <argfd>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	85 c0                	test   %eax,%eax
801058b6:	79 07                	jns    801058bf <sys_dup+0x24>
    return -1;
801058b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058bd:	eb 31                	jmp    801058f0 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801058bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058c2:	83 ec 0c             	sub    $0xc,%esp
801058c5:	50                   	push   %eax
801058c6:	e8 84 ff ff ff       	call   8010584f <fdalloc>
801058cb:	83 c4 10             	add    $0x10,%esp
801058ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058d5:	79 07                	jns    801058de <sys_dup+0x43>
    return -1;
801058d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058dc:	eb 12                	jmp    801058f0 <sys_dup+0x55>
  filedup(f);
801058de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058e1:	83 ec 0c             	sub    $0xc,%esp
801058e4:	50                   	push   %eax
801058e5:	e8 4a bc ff ff       	call   80101534 <filedup>
801058ea:	83 c4 10             	add    $0x10,%esp
  return fd;
801058ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801058f0:	c9                   	leave  
801058f1:	c3                   	ret    

801058f2 <sys_read>:

int
sys_read(void)
{
801058f2:	55                   	push   %ebp
801058f3:	89 e5                	mov    %esp,%ebp
801058f5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058f8:	83 ec 04             	sub    $0x4,%esp
801058fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058fe:	50                   	push   %eax
801058ff:	6a 00                	push   $0x0
80105901:	6a 00                	push   $0x0
80105903:	e8 d2 fe ff ff       	call   801057da <argfd>
80105908:	83 c4 10             	add    $0x10,%esp
8010590b:	85 c0                	test   %eax,%eax
8010590d:	78 2e                	js     8010593d <sys_read+0x4b>
8010590f:	83 ec 08             	sub    $0x8,%esp
80105912:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105915:	50                   	push   %eax
80105916:	6a 02                	push   $0x2
80105918:	e8 81 fd ff ff       	call   8010569e <argint>
8010591d:	83 c4 10             	add    $0x10,%esp
80105920:	85 c0                	test   %eax,%eax
80105922:	78 19                	js     8010593d <sys_read+0x4b>
80105924:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105927:	83 ec 04             	sub    $0x4,%esp
8010592a:	50                   	push   %eax
8010592b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010592e:	50                   	push   %eax
8010592f:	6a 01                	push   $0x1
80105931:	e8 90 fd ff ff       	call   801056c6 <argptr>
80105936:	83 c4 10             	add    $0x10,%esp
80105939:	85 c0                	test   %eax,%eax
8010593b:	79 07                	jns    80105944 <sys_read+0x52>
    return -1;
8010593d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105942:	eb 17                	jmp    8010595b <sys_read+0x69>
  return fileread(f, p, n);
80105944:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105947:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010594a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010594d:	83 ec 04             	sub    $0x4,%esp
80105950:	51                   	push   %ecx
80105951:	52                   	push   %edx
80105952:	50                   	push   %eax
80105953:	e8 6c bd ff ff       	call   801016c4 <fileread>
80105958:	83 c4 10             	add    $0x10,%esp
}
8010595b:	c9                   	leave  
8010595c:	c3                   	ret    

8010595d <sys_write>:

int
sys_write(void)
{
8010595d:	55                   	push   %ebp
8010595e:	89 e5                	mov    %esp,%ebp
80105960:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105963:	83 ec 04             	sub    $0x4,%esp
80105966:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105969:	50                   	push   %eax
8010596a:	6a 00                	push   $0x0
8010596c:	6a 00                	push   $0x0
8010596e:	e8 67 fe ff ff       	call   801057da <argfd>
80105973:	83 c4 10             	add    $0x10,%esp
80105976:	85 c0                	test   %eax,%eax
80105978:	78 2e                	js     801059a8 <sys_write+0x4b>
8010597a:	83 ec 08             	sub    $0x8,%esp
8010597d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105980:	50                   	push   %eax
80105981:	6a 02                	push   $0x2
80105983:	e8 16 fd ff ff       	call   8010569e <argint>
80105988:	83 c4 10             	add    $0x10,%esp
8010598b:	85 c0                	test   %eax,%eax
8010598d:	78 19                	js     801059a8 <sys_write+0x4b>
8010598f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105992:	83 ec 04             	sub    $0x4,%esp
80105995:	50                   	push   %eax
80105996:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105999:	50                   	push   %eax
8010599a:	6a 01                	push   $0x1
8010599c:	e8 25 fd ff ff       	call   801056c6 <argptr>
801059a1:	83 c4 10             	add    $0x10,%esp
801059a4:	85 c0                	test   %eax,%eax
801059a6:	79 07                	jns    801059af <sys_write+0x52>
    return -1;
801059a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ad:	eb 17                	jmp    801059c6 <sys_write+0x69>
  return filewrite(f, p, n);
801059af:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801059b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801059b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059b8:	83 ec 04             	sub    $0x4,%esp
801059bb:	51                   	push   %ecx
801059bc:	52                   	push   %edx
801059bd:	50                   	push   %eax
801059be:	e8 b9 bd ff ff       	call   8010177c <filewrite>
801059c3:	83 c4 10             	add    $0x10,%esp
}
801059c6:	c9                   	leave  
801059c7:	c3                   	ret    

801059c8 <sys_close>:

int
sys_close(void)
{
801059c8:	55                   	push   %ebp
801059c9:	89 e5                	mov    %esp,%ebp
801059cb:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801059ce:	83 ec 04             	sub    $0x4,%esp
801059d1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059d4:	50                   	push   %eax
801059d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059d8:	50                   	push   %eax
801059d9:	6a 00                	push   $0x0
801059db:	e8 fa fd ff ff       	call   801057da <argfd>
801059e0:	83 c4 10             	add    $0x10,%esp
801059e3:	85 c0                	test   %eax,%eax
801059e5:	79 07                	jns    801059ee <sys_close+0x26>
    return -1;
801059e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ec:	eb 28                	jmp    80105a16 <sys_close+0x4e>
  proc->ofile[fd] = 0;
801059ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059f7:	83 c2 08             	add    $0x8,%edx
801059fa:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105a01:	00 
  fileclose(f);
80105a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a05:	83 ec 0c             	sub    $0xc,%esp
80105a08:	50                   	push   %eax
80105a09:	e8 77 bb ff ff       	call   80101585 <fileclose>
80105a0e:	83 c4 10             	add    $0x10,%esp
  return 0;
80105a11:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a16:	c9                   	leave  
80105a17:	c3                   	ret    

80105a18 <sys_fstat>:

int
sys_fstat(void)
{
80105a18:	55                   	push   %ebp
80105a19:	89 e5                	mov    %esp,%ebp
80105a1b:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a1e:	83 ec 04             	sub    $0x4,%esp
80105a21:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a24:	50                   	push   %eax
80105a25:	6a 00                	push   $0x0
80105a27:	6a 00                	push   $0x0
80105a29:	e8 ac fd ff ff       	call   801057da <argfd>
80105a2e:	83 c4 10             	add    $0x10,%esp
80105a31:	85 c0                	test   %eax,%eax
80105a33:	78 17                	js     80105a4c <sys_fstat+0x34>
80105a35:	83 ec 04             	sub    $0x4,%esp
80105a38:	6a 14                	push   $0x14
80105a3a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a3d:	50                   	push   %eax
80105a3e:	6a 01                	push   $0x1
80105a40:	e8 81 fc ff ff       	call   801056c6 <argptr>
80105a45:	83 c4 10             	add    $0x10,%esp
80105a48:	85 c0                	test   %eax,%eax
80105a4a:	79 07                	jns    80105a53 <sys_fstat+0x3b>
    return -1;
80105a4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a51:	eb 13                	jmp    80105a66 <sys_fstat+0x4e>
  return filestat(f, st);
80105a53:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a59:	83 ec 08             	sub    $0x8,%esp
80105a5c:	52                   	push   %edx
80105a5d:	50                   	push   %eax
80105a5e:	e8 0a bc ff ff       	call   8010166d <filestat>
80105a63:	83 c4 10             	add    $0x10,%esp
}
80105a66:	c9                   	leave  
80105a67:	c3                   	ret    

80105a68 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105a68:	55                   	push   %ebp
80105a69:	89 e5                	mov    %esp,%ebp
80105a6b:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a6e:	83 ec 08             	sub    $0x8,%esp
80105a71:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a74:	50                   	push   %eax
80105a75:	6a 00                	push   $0x0
80105a77:	e8 a7 fc ff ff       	call   80105723 <argstr>
80105a7c:	83 c4 10             	add    $0x10,%esp
80105a7f:	85 c0                	test   %eax,%eax
80105a81:	78 15                	js     80105a98 <sys_link+0x30>
80105a83:	83 ec 08             	sub    $0x8,%esp
80105a86:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a89:	50                   	push   %eax
80105a8a:	6a 01                	push   $0x1
80105a8c:	e8 92 fc ff ff       	call   80105723 <argstr>
80105a91:	83 c4 10             	add    $0x10,%esp
80105a94:	85 c0                	test   %eax,%eax
80105a96:	79 0a                	jns    80105aa2 <sys_link+0x3a>
    return -1;
80105a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a9d:	e9 63 01 00 00       	jmp    80105c05 <sys_link+0x19d>
  if((ip = namei(old)) == 0)
80105aa2:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105aa5:	83 ec 0c             	sub    $0xc,%esp
80105aa8:	50                   	push   %eax
80105aa9:	e8 64 cf ff ff       	call   80102a12 <namei>
80105aae:	83 c4 10             	add    $0x10,%esp
80105ab1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ab4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ab8:	75 0a                	jne    80105ac4 <sys_link+0x5c>
    return -1;
80105aba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105abf:	e9 41 01 00 00       	jmp    80105c05 <sys_link+0x19d>

  begin_trans();
80105ac4:	e8 15 dd ff ff       	call   801037de <begin_trans>

  ilock(ip);
80105ac9:	83 ec 0c             	sub    $0xc,%esp
80105acc:	ff 75 f4             	pushl  -0xc(%ebp)
80105acf:	e8 86 c3 ff ff       	call   80101e5a <ilock>
80105ad4:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ada:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ade:	66 83 f8 01          	cmp    $0x1,%ax
80105ae2:	75 1d                	jne    80105b01 <sys_link+0x99>
    iunlockput(ip);
80105ae4:	83 ec 0c             	sub    $0xc,%esp
80105ae7:	ff 75 f4             	pushl  -0xc(%ebp)
80105aea:	e8 25 c6 ff ff       	call   80102114 <iunlockput>
80105aef:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80105af2:	e8 3a dd ff ff       	call   80103831 <commit_trans>
    return -1;
80105af7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afc:	e9 04 01 00 00       	jmp    80105c05 <sys_link+0x19d>
  }

  ip->nlink++;
80105b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b04:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b08:	83 c0 01             	add    $0x1,%eax
80105b0b:	89 c2                	mov    %eax,%edx
80105b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b10:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b14:	83 ec 0c             	sub    $0xc,%esp
80105b17:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1a:	e8 67 c1 ff ff       	call   80101c86 <iupdate>
80105b1f:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105b22:	83 ec 0c             	sub    $0xc,%esp
80105b25:	ff 75 f4             	pushl  -0xc(%ebp)
80105b28:	e8 85 c4 ff ff       	call   80101fb2 <iunlock>
80105b2d:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105b30:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b33:	83 ec 08             	sub    $0x8,%esp
80105b36:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105b39:	52                   	push   %edx
80105b3a:	50                   	push   %eax
80105b3b:	e8 ee ce ff ff       	call   80102a2e <nameiparent>
80105b40:	83 c4 10             	add    $0x10,%esp
80105b43:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b4a:	74 71                	je     80105bbd <sys_link+0x155>
    goto bad;
  ilock(dp);
80105b4c:	83 ec 0c             	sub    $0xc,%esp
80105b4f:	ff 75 f0             	pushl  -0x10(%ebp)
80105b52:	e8 03 c3 ff ff       	call   80101e5a <ilock>
80105b57:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b5d:	8b 10                	mov    (%eax),%edx
80105b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b62:	8b 00                	mov    (%eax),%eax
80105b64:	39 c2                	cmp    %eax,%edx
80105b66:	75 1d                	jne    80105b85 <sys_link+0x11d>
80105b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b6b:	8b 40 04             	mov    0x4(%eax),%eax
80105b6e:	83 ec 04             	sub    $0x4,%esp
80105b71:	50                   	push   %eax
80105b72:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105b75:	50                   	push   %eax
80105b76:	ff 75 f0             	pushl  -0x10(%ebp)
80105b79:	e8 f8 cb ff ff       	call   80102776 <dirlink>
80105b7e:	83 c4 10             	add    $0x10,%esp
80105b81:	85 c0                	test   %eax,%eax
80105b83:	79 10                	jns    80105b95 <sys_link+0x12d>
    iunlockput(dp);
80105b85:	83 ec 0c             	sub    $0xc,%esp
80105b88:	ff 75 f0             	pushl  -0x10(%ebp)
80105b8b:	e8 84 c5 ff ff       	call   80102114 <iunlockput>
80105b90:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105b93:	eb 29                	jmp    80105bbe <sys_link+0x156>
  }
  iunlockput(dp);
80105b95:	83 ec 0c             	sub    $0xc,%esp
80105b98:	ff 75 f0             	pushl  -0x10(%ebp)
80105b9b:	e8 74 c5 ff ff       	call   80102114 <iunlockput>
80105ba0:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105ba3:	83 ec 0c             	sub    $0xc,%esp
80105ba6:	ff 75 f4             	pushl  -0xc(%ebp)
80105ba9:	e8 76 c4 ff ff       	call   80102024 <iput>
80105bae:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105bb1:	e8 7b dc ff ff       	call   80103831 <commit_trans>

  return 0;
80105bb6:	b8 00 00 00 00       	mov    $0x0,%eax
80105bbb:	eb 48                	jmp    80105c05 <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105bbd:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80105bbe:	83 ec 0c             	sub    $0xc,%esp
80105bc1:	ff 75 f4             	pushl  -0xc(%ebp)
80105bc4:	e8 91 c2 ff ff       	call   80101e5a <ilock>
80105bc9:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bcf:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105bd3:	83 e8 01             	sub    $0x1,%eax
80105bd6:	89 c2                	mov    %eax,%edx
80105bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bdb:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105bdf:	83 ec 0c             	sub    $0xc,%esp
80105be2:	ff 75 f4             	pushl  -0xc(%ebp)
80105be5:	e8 9c c0 ff ff       	call   80101c86 <iupdate>
80105bea:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105bed:	83 ec 0c             	sub    $0xc,%esp
80105bf0:	ff 75 f4             	pushl  -0xc(%ebp)
80105bf3:	e8 1c c5 ff ff       	call   80102114 <iunlockput>
80105bf8:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105bfb:	e8 31 dc ff ff       	call   80103831 <commit_trans>
  return -1;
80105c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c05:	c9                   	leave  
80105c06:	c3                   	ret    

80105c07 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105c07:	55                   	push   %ebp
80105c08:	89 e5                	mov    %esp,%ebp
80105c0a:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c0d:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105c14:	eb 40                	jmp    80105c56 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c19:	6a 10                	push   $0x10
80105c1b:	50                   	push   %eax
80105c1c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c1f:	50                   	push   %eax
80105c20:	ff 75 08             	pushl  0x8(%ebp)
80105c23:	e8 9a c7 ff ff       	call   801023c2 <readi>
80105c28:	83 c4 10             	add    $0x10,%esp
80105c2b:	83 f8 10             	cmp    $0x10,%eax
80105c2e:	74 0d                	je     80105c3d <isdirempty+0x36>
      panic("isdirempty: readi");
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	68 bf 97 10 80       	push   $0x801097bf
80105c38:	e8 45 a9 ff ff       	call   80100582 <panic>
    if(de.inum != 0)
80105c3d:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105c41:	66 85 c0             	test   %ax,%ax
80105c44:	74 07                	je     80105c4d <isdirempty+0x46>
      return 0;
80105c46:	b8 00 00 00 00       	mov    $0x0,%eax
80105c4b:	eb 1b                	jmp    80105c68 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c50:	83 c0 10             	add    $0x10,%eax
80105c53:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c56:	8b 45 08             	mov    0x8(%ebp),%eax
80105c59:	8b 50 18             	mov    0x18(%eax),%edx
80105c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c5f:	39 c2                	cmp    %eax,%edx
80105c61:	77 b3                	ja     80105c16 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105c63:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105c68:	c9                   	leave  
80105c69:	c3                   	ret    

80105c6a <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105c6a:	55                   	push   %ebp
80105c6b:	89 e5                	mov    %esp,%ebp
80105c6d:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c70:	83 ec 08             	sub    $0x8,%esp
80105c73:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105c76:	50                   	push   %eax
80105c77:	6a 00                	push   $0x0
80105c79:	e8 a5 fa ff ff       	call   80105723 <argstr>
80105c7e:	83 c4 10             	add    $0x10,%esp
80105c81:	85 c0                	test   %eax,%eax
80105c83:	79 0a                	jns    80105c8f <sys_unlink+0x25>
    return -1;
80105c85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c8a:	e9 b7 01 00 00       	jmp    80105e46 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
80105c8f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105c92:	83 ec 08             	sub    $0x8,%esp
80105c95:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105c98:	52                   	push   %edx
80105c99:	50                   	push   %eax
80105c9a:	e8 8f cd ff ff       	call   80102a2e <nameiparent>
80105c9f:	83 c4 10             	add    $0x10,%esp
80105ca2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ca5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ca9:	75 0a                	jne    80105cb5 <sys_unlink+0x4b>
    return -1;
80105cab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cb0:	e9 91 01 00 00       	jmp    80105e46 <sys_unlink+0x1dc>

  begin_trans();
80105cb5:	e8 24 db ff ff       	call   801037de <begin_trans>

  ilock(dp);
80105cba:	83 ec 0c             	sub    $0xc,%esp
80105cbd:	ff 75 f4             	pushl  -0xc(%ebp)
80105cc0:	e8 95 c1 ff ff       	call   80101e5a <ilock>
80105cc5:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105cc8:	83 ec 08             	sub    $0x8,%esp
80105ccb:	68 d1 97 10 80       	push   $0x801097d1
80105cd0:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cd3:	50                   	push   %eax
80105cd4:	e8 c8 c9 ff ff       	call   801026a1 <namecmp>
80105cd9:	83 c4 10             	add    $0x10,%esp
80105cdc:	85 c0                	test   %eax,%eax
80105cde:	0f 84 4a 01 00 00    	je     80105e2e <sys_unlink+0x1c4>
80105ce4:	83 ec 08             	sub    $0x8,%esp
80105ce7:	68 d3 97 10 80       	push   $0x801097d3
80105cec:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cef:	50                   	push   %eax
80105cf0:	e8 ac c9 ff ff       	call   801026a1 <namecmp>
80105cf5:	83 c4 10             	add    $0x10,%esp
80105cf8:	85 c0                	test   %eax,%eax
80105cfa:	0f 84 2e 01 00 00    	je     80105e2e <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105d00:	83 ec 04             	sub    $0x4,%esp
80105d03:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105d06:	50                   	push   %eax
80105d07:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105d0a:	50                   	push   %eax
80105d0b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d0e:	e8 a9 c9 ff ff       	call   801026bc <dirlookup>
80105d13:	83 c4 10             	add    $0x10,%esp
80105d16:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d1d:	0f 84 0a 01 00 00    	je     80105e2d <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
80105d23:	83 ec 0c             	sub    $0xc,%esp
80105d26:	ff 75 f0             	pushl  -0x10(%ebp)
80105d29:	e8 2c c1 ff ff       	call   80101e5a <ilock>
80105d2e:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d34:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d38:	66 85 c0             	test   %ax,%ax
80105d3b:	7f 0d                	jg     80105d4a <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105d3d:	83 ec 0c             	sub    $0xc,%esp
80105d40:	68 d6 97 10 80       	push   $0x801097d6
80105d45:	e8 38 a8 ff ff       	call   80100582 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105d4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d4d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d51:	66 83 f8 01          	cmp    $0x1,%ax
80105d55:	75 25                	jne    80105d7c <sys_unlink+0x112>
80105d57:	83 ec 0c             	sub    $0xc,%esp
80105d5a:	ff 75 f0             	pushl  -0x10(%ebp)
80105d5d:	e8 a5 fe ff ff       	call   80105c07 <isdirempty>
80105d62:	83 c4 10             	add    $0x10,%esp
80105d65:	85 c0                	test   %eax,%eax
80105d67:	75 13                	jne    80105d7c <sys_unlink+0x112>
    iunlockput(ip);
80105d69:	83 ec 0c             	sub    $0xc,%esp
80105d6c:	ff 75 f0             	pushl  -0x10(%ebp)
80105d6f:	e8 a0 c3 ff ff       	call   80102114 <iunlockput>
80105d74:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105d77:	e9 b2 00 00 00       	jmp    80105e2e <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
80105d7c:	83 ec 04             	sub    $0x4,%esp
80105d7f:	6a 10                	push   $0x10
80105d81:	6a 00                	push   $0x0
80105d83:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d86:	50                   	push   %eax
80105d87:	e8 ed f5 ff ff       	call   80105379 <memset>
80105d8c:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d8f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105d92:	6a 10                	push   $0x10
80105d94:	50                   	push   %eax
80105d95:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d98:	50                   	push   %eax
80105d99:	ff 75 f4             	pushl  -0xc(%ebp)
80105d9c:	e8 78 c7 ff ff       	call   80102519 <writei>
80105da1:	83 c4 10             	add    $0x10,%esp
80105da4:	83 f8 10             	cmp    $0x10,%eax
80105da7:	74 0d                	je     80105db6 <sys_unlink+0x14c>
    panic("unlink: writei");
80105da9:	83 ec 0c             	sub    $0xc,%esp
80105dac:	68 e8 97 10 80       	push   $0x801097e8
80105db1:	e8 cc a7 ff ff       	call   80100582 <panic>
  if(ip->type == T_DIR){
80105db6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105dbd:	66 83 f8 01          	cmp    $0x1,%ax
80105dc1:	75 21                	jne    80105de4 <sys_unlink+0x17a>
    dp->nlink--;
80105dc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dc6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105dca:	83 e8 01             	sub    $0x1,%eax
80105dcd:	89 c2                	mov    %eax,%edx
80105dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd2:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105dd6:	83 ec 0c             	sub    $0xc,%esp
80105dd9:	ff 75 f4             	pushl  -0xc(%ebp)
80105ddc:	e8 a5 be ff ff       	call   80101c86 <iupdate>
80105de1:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105de4:	83 ec 0c             	sub    $0xc,%esp
80105de7:	ff 75 f4             	pushl  -0xc(%ebp)
80105dea:	e8 25 c3 ff ff       	call   80102114 <iunlockput>
80105def:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105df5:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105df9:	83 e8 01             	sub    $0x1,%eax
80105dfc:	89 c2                	mov    %eax,%edx
80105dfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e01:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105e05:	83 ec 0c             	sub    $0xc,%esp
80105e08:	ff 75 f0             	pushl  -0x10(%ebp)
80105e0b:	e8 76 be ff ff       	call   80101c86 <iupdate>
80105e10:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105e13:	83 ec 0c             	sub    $0xc,%esp
80105e16:	ff 75 f0             	pushl  -0x10(%ebp)
80105e19:	e8 f6 c2 ff ff       	call   80102114 <iunlockput>
80105e1e:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105e21:	e8 0b da ff ff       	call   80103831 <commit_trans>

  return 0;
80105e26:	b8 00 00 00 00       	mov    $0x0,%eax
80105e2b:	eb 19                	jmp    80105e46 <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105e2d:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105e2e:	83 ec 0c             	sub    $0xc,%esp
80105e31:	ff 75 f4             	pushl  -0xc(%ebp)
80105e34:	e8 db c2 ff ff       	call   80102114 <iunlockput>
80105e39:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105e3c:	e8 f0 d9 ff ff       	call   80103831 <commit_trans>
  return -1;
80105e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e46:	c9                   	leave  
80105e47:	c3                   	ret    

80105e48 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105e48:	55                   	push   %ebp
80105e49:	89 e5                	mov    %esp,%ebp
80105e4b:	83 ec 38             	sub    $0x38,%esp
80105e4e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e51:	8b 55 10             	mov    0x10(%ebp),%edx
80105e54:	8b 45 14             	mov    0x14(%ebp),%eax
80105e57:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105e5b:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105e5f:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105e63:	83 ec 08             	sub    $0x8,%esp
80105e66:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e69:	50                   	push   %eax
80105e6a:	ff 75 08             	pushl  0x8(%ebp)
80105e6d:	e8 bc cb ff ff       	call   80102a2e <nameiparent>
80105e72:	83 c4 10             	add    $0x10,%esp
80105e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e7c:	75 0a                	jne    80105e88 <create+0x40>
    return 0;
80105e7e:	b8 00 00 00 00       	mov    $0x0,%eax
80105e83:	e9 90 01 00 00       	jmp    80106018 <create+0x1d0>
  ilock(dp);
80105e88:	83 ec 0c             	sub    $0xc,%esp
80105e8b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e8e:	e8 c7 bf ff ff       	call   80101e5a <ilock>
80105e93:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105e96:	83 ec 04             	sub    $0x4,%esp
80105e99:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e9c:	50                   	push   %eax
80105e9d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105ea0:	50                   	push   %eax
80105ea1:	ff 75 f4             	pushl  -0xc(%ebp)
80105ea4:	e8 13 c8 ff ff       	call   801026bc <dirlookup>
80105ea9:	83 c4 10             	add    $0x10,%esp
80105eac:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105eaf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105eb3:	74 50                	je     80105f05 <create+0xbd>
    iunlockput(dp);
80105eb5:	83 ec 0c             	sub    $0xc,%esp
80105eb8:	ff 75 f4             	pushl  -0xc(%ebp)
80105ebb:	e8 54 c2 ff ff       	call   80102114 <iunlockput>
80105ec0:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105ec3:	83 ec 0c             	sub    $0xc,%esp
80105ec6:	ff 75 f0             	pushl  -0x10(%ebp)
80105ec9:	e8 8c bf ff ff       	call   80101e5a <ilock>
80105ece:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105ed1:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105ed6:	75 15                	jne    80105eed <create+0xa5>
80105ed8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105edb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105edf:	66 83 f8 02          	cmp    $0x2,%ax
80105ee3:	75 08                	jne    80105eed <create+0xa5>
      return ip;
80105ee5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee8:	e9 2b 01 00 00       	jmp    80106018 <create+0x1d0>
    iunlockput(ip);
80105eed:	83 ec 0c             	sub    $0xc,%esp
80105ef0:	ff 75 f0             	pushl  -0x10(%ebp)
80105ef3:	e8 1c c2 ff ff       	call   80102114 <iunlockput>
80105ef8:	83 c4 10             	add    $0x10,%esp
    return 0;
80105efb:	b8 00 00 00 00       	mov    $0x0,%eax
80105f00:	e9 13 01 00 00       	jmp    80106018 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105f05:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105f09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f0c:	8b 00                	mov    (%eax),%eax
80105f0e:	83 ec 08             	sub    $0x8,%esp
80105f11:	52                   	push   %edx
80105f12:	50                   	push   %eax
80105f13:	e8 8d bc ff ff       	call   80101ba5 <ialloc>
80105f18:	83 c4 10             	add    $0x10,%esp
80105f1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f22:	75 0d                	jne    80105f31 <create+0xe9>
    panic("create: ialloc");
80105f24:	83 ec 0c             	sub    $0xc,%esp
80105f27:	68 f7 97 10 80       	push   $0x801097f7
80105f2c:	e8 51 a6 ff ff       	call   80100582 <panic>

  ilock(ip);
80105f31:	83 ec 0c             	sub    $0xc,%esp
80105f34:	ff 75 f0             	pushl  -0x10(%ebp)
80105f37:	e8 1e bf ff ff       	call   80101e5a <ilock>
80105f3c:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105f3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f42:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105f46:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105f4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f4d:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105f51:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105f55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f58:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105f5e:	83 ec 0c             	sub    $0xc,%esp
80105f61:	ff 75 f0             	pushl  -0x10(%ebp)
80105f64:	e8 1d bd ff ff       	call   80101c86 <iupdate>
80105f69:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105f6c:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105f71:	75 6a                	jne    80105fdd <create+0x195>
    dp->nlink++;  // for ".."
80105f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f76:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105f7a:	83 c0 01             	add    $0x1,%eax
80105f7d:	89 c2                	mov    %eax,%edx
80105f7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f82:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105f86:	83 ec 0c             	sub    $0xc,%esp
80105f89:	ff 75 f4             	pushl  -0xc(%ebp)
80105f8c:	e8 f5 bc ff ff       	call   80101c86 <iupdate>
80105f91:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f97:	8b 40 04             	mov    0x4(%eax),%eax
80105f9a:	83 ec 04             	sub    $0x4,%esp
80105f9d:	50                   	push   %eax
80105f9e:	68 d1 97 10 80       	push   $0x801097d1
80105fa3:	ff 75 f0             	pushl  -0x10(%ebp)
80105fa6:	e8 cb c7 ff ff       	call   80102776 <dirlink>
80105fab:	83 c4 10             	add    $0x10,%esp
80105fae:	85 c0                	test   %eax,%eax
80105fb0:	78 1e                	js     80105fd0 <create+0x188>
80105fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fb5:	8b 40 04             	mov    0x4(%eax),%eax
80105fb8:	83 ec 04             	sub    $0x4,%esp
80105fbb:	50                   	push   %eax
80105fbc:	68 d3 97 10 80       	push   $0x801097d3
80105fc1:	ff 75 f0             	pushl  -0x10(%ebp)
80105fc4:	e8 ad c7 ff ff       	call   80102776 <dirlink>
80105fc9:	83 c4 10             	add    $0x10,%esp
80105fcc:	85 c0                	test   %eax,%eax
80105fce:	79 0d                	jns    80105fdd <create+0x195>
      panic("create dots");
80105fd0:	83 ec 0c             	sub    $0xc,%esp
80105fd3:	68 06 98 10 80       	push   $0x80109806
80105fd8:	e8 a5 a5 ff ff       	call   80100582 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105fdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe0:	8b 40 04             	mov    0x4(%eax),%eax
80105fe3:	83 ec 04             	sub    $0x4,%esp
80105fe6:	50                   	push   %eax
80105fe7:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fea:	50                   	push   %eax
80105feb:	ff 75 f4             	pushl  -0xc(%ebp)
80105fee:	e8 83 c7 ff ff       	call   80102776 <dirlink>
80105ff3:	83 c4 10             	add    $0x10,%esp
80105ff6:	85 c0                	test   %eax,%eax
80105ff8:	79 0d                	jns    80106007 <create+0x1bf>
    panic("create: dirlink");
80105ffa:	83 ec 0c             	sub    $0xc,%esp
80105ffd:	68 12 98 10 80       	push   $0x80109812
80106002:	e8 7b a5 ff ff       	call   80100582 <panic>

  iunlockput(dp);
80106007:	83 ec 0c             	sub    $0xc,%esp
8010600a:	ff 75 f4             	pushl  -0xc(%ebp)
8010600d:	e8 02 c1 ff ff       	call   80102114 <iunlockput>
80106012:	83 c4 10             	add    $0x10,%esp

  return ip;
80106015:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106018:	c9                   	leave  
80106019:	c3                   	ret    

8010601a <sys_open>:

int
sys_open(void)
{
8010601a:	55                   	push   %ebp
8010601b:	89 e5                	mov    %esp,%ebp
8010601d:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106020:	83 ec 08             	sub    $0x8,%esp
80106023:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106026:	50                   	push   %eax
80106027:	6a 00                	push   $0x0
80106029:	e8 f5 f6 ff ff       	call   80105723 <argstr>
8010602e:	83 c4 10             	add    $0x10,%esp
80106031:	85 c0                	test   %eax,%eax
80106033:	78 15                	js     8010604a <sys_open+0x30>
80106035:	83 ec 08             	sub    $0x8,%esp
80106038:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010603b:	50                   	push   %eax
8010603c:	6a 01                	push   $0x1
8010603e:	e8 5b f6 ff ff       	call   8010569e <argint>
80106043:	83 c4 10             	add    $0x10,%esp
80106046:	85 c0                	test   %eax,%eax
80106048:	79 0a                	jns    80106054 <sys_open+0x3a>
    return -1;
8010604a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010604f:	e9 4d 01 00 00       	jmp    801061a1 <sys_open+0x187>
  if(omode & O_CREATE){
80106054:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106057:	25 00 02 00 00       	and    $0x200,%eax
8010605c:	85 c0                	test   %eax,%eax
8010605e:	74 2f                	je     8010608f <sys_open+0x75>
    begin_trans();
80106060:	e8 79 d7 ff ff       	call   801037de <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80106065:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106068:	6a 00                	push   $0x0
8010606a:	6a 00                	push   $0x0
8010606c:	6a 02                	push   $0x2
8010606e:	50                   	push   %eax
8010606f:	e8 d4 fd ff ff       	call   80105e48 <create>
80106074:	83 c4 10             	add    $0x10,%esp
80106077:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
8010607a:	e8 b2 d7 ff ff       	call   80103831 <commit_trans>
    if(ip == 0)
8010607f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106083:	75 66                	jne    801060eb <sys_open+0xd1>
      return -1;
80106085:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010608a:	e9 12 01 00 00       	jmp    801061a1 <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
8010608f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106092:	83 ec 0c             	sub    $0xc,%esp
80106095:	50                   	push   %eax
80106096:	e8 77 c9 ff ff       	call   80102a12 <namei>
8010609b:	83 c4 10             	add    $0x10,%esp
8010609e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060a5:	75 0a                	jne    801060b1 <sys_open+0x97>
      return -1;
801060a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060ac:	e9 f0 00 00 00       	jmp    801061a1 <sys_open+0x187>
    ilock(ip);
801060b1:	83 ec 0c             	sub    $0xc,%esp
801060b4:	ff 75 f4             	pushl  -0xc(%ebp)
801060b7:	e8 9e bd ff ff       	call   80101e5a <ilock>
801060bc:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
801060bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060c2:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801060c6:	66 83 f8 01          	cmp    $0x1,%ax
801060ca:	75 1f                	jne    801060eb <sys_open+0xd1>
801060cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060cf:	85 c0                	test   %eax,%eax
801060d1:	74 18                	je     801060eb <sys_open+0xd1>
      iunlockput(ip);
801060d3:	83 ec 0c             	sub    $0xc,%esp
801060d6:	ff 75 f4             	pushl  -0xc(%ebp)
801060d9:	e8 36 c0 ff ff       	call   80102114 <iunlockput>
801060de:	83 c4 10             	add    $0x10,%esp
      return -1;
801060e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060e6:	e9 b6 00 00 00       	jmp    801061a1 <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801060eb:	e8 d7 b3 ff ff       	call   801014c7 <filealloc>
801060f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801060f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801060f7:	74 17                	je     80106110 <sys_open+0xf6>
801060f9:	83 ec 0c             	sub    $0xc,%esp
801060fc:	ff 75 f0             	pushl  -0x10(%ebp)
801060ff:	e8 4b f7 ff ff       	call   8010584f <fdalloc>
80106104:	83 c4 10             	add    $0x10,%esp
80106107:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010610a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010610e:	79 29                	jns    80106139 <sys_open+0x11f>
    if(f)
80106110:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106114:	74 0e                	je     80106124 <sys_open+0x10a>
      fileclose(f);
80106116:	83 ec 0c             	sub    $0xc,%esp
80106119:	ff 75 f0             	pushl  -0x10(%ebp)
8010611c:	e8 64 b4 ff ff       	call   80101585 <fileclose>
80106121:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106124:	83 ec 0c             	sub    $0xc,%esp
80106127:	ff 75 f4             	pushl  -0xc(%ebp)
8010612a:	e8 e5 bf ff ff       	call   80102114 <iunlockput>
8010612f:	83 c4 10             	add    $0x10,%esp
    return -1;
80106132:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106137:	eb 68                	jmp    801061a1 <sys_open+0x187>
  }
  iunlock(ip);
80106139:	83 ec 0c             	sub    $0xc,%esp
8010613c:	ff 75 f4             	pushl  -0xc(%ebp)
8010613f:	e8 6e be ff ff       	call   80101fb2 <iunlock>
80106144:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80106147:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010614a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106150:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106153:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106156:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106159:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010615c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106166:	83 e0 01             	and    $0x1,%eax
80106169:	85 c0                	test   %eax,%eax
8010616b:	0f 94 c0             	sete   %al
8010616e:	89 c2                	mov    %eax,%edx
80106170:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106173:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106176:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106179:	83 e0 01             	and    $0x1,%eax
8010617c:	85 c0                	test   %eax,%eax
8010617e:	75 0a                	jne    8010618a <sys_open+0x170>
80106180:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106183:	83 e0 02             	and    $0x2,%eax
80106186:	85 c0                	test   %eax,%eax
80106188:	74 07                	je     80106191 <sys_open+0x177>
8010618a:	b8 01 00 00 00       	mov    $0x1,%eax
8010618f:	eb 05                	jmp    80106196 <sys_open+0x17c>
80106191:	b8 00 00 00 00       	mov    $0x0,%eax
80106196:	89 c2                	mov    %eax,%edx
80106198:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010619b:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
8010619e:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801061a1:	c9                   	leave  
801061a2:	c3                   	ret    

801061a3 <sys_mkdir>:

int
sys_mkdir(void)
{
801061a3:	55                   	push   %ebp
801061a4:	89 e5                	mov    %esp,%ebp
801061a6:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
801061a9:	e8 30 d6 ff ff       	call   801037de <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801061ae:	83 ec 08             	sub    $0x8,%esp
801061b1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061b4:	50                   	push   %eax
801061b5:	6a 00                	push   $0x0
801061b7:	e8 67 f5 ff ff       	call   80105723 <argstr>
801061bc:	83 c4 10             	add    $0x10,%esp
801061bf:	85 c0                	test   %eax,%eax
801061c1:	78 1b                	js     801061de <sys_mkdir+0x3b>
801061c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061c6:	6a 00                	push   $0x0
801061c8:	6a 00                	push   $0x0
801061ca:	6a 01                	push   $0x1
801061cc:	50                   	push   %eax
801061cd:	e8 76 fc ff ff       	call   80105e48 <create>
801061d2:	83 c4 10             	add    $0x10,%esp
801061d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061dc:	75 0c                	jne    801061ea <sys_mkdir+0x47>
    commit_trans();
801061de:	e8 4e d6 ff ff       	call   80103831 <commit_trans>
    return -1;
801061e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e8:	eb 18                	jmp    80106202 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
801061ea:	83 ec 0c             	sub    $0xc,%esp
801061ed:	ff 75 f4             	pushl  -0xc(%ebp)
801061f0:	e8 1f bf ff ff       	call   80102114 <iunlockput>
801061f5:	83 c4 10             	add    $0x10,%esp
  commit_trans();
801061f8:	e8 34 d6 ff ff       	call   80103831 <commit_trans>
  return 0;
801061fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106202:	c9                   	leave  
80106203:	c3                   	ret    

80106204 <sys_mknod>:

int
sys_mknod(void)
{
80106204:	55                   	push   %ebp
80106205:	89 e5                	mov    %esp,%ebp
80106207:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
8010620a:	e8 cf d5 ff ff       	call   801037de <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
8010620f:	83 ec 08             	sub    $0x8,%esp
80106212:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106215:	50                   	push   %eax
80106216:	6a 00                	push   $0x0
80106218:	e8 06 f5 ff ff       	call   80105723 <argstr>
8010621d:	83 c4 10             	add    $0x10,%esp
80106220:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106223:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106227:	78 4f                	js     80106278 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80106229:	83 ec 08             	sub    $0x8,%esp
8010622c:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010622f:	50                   	push   %eax
80106230:	6a 01                	push   $0x1
80106232:	e8 67 f4 ff ff       	call   8010569e <argint>
80106237:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
8010623a:	85 c0                	test   %eax,%eax
8010623c:	78 3a                	js     80106278 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010623e:	83 ec 08             	sub    $0x8,%esp
80106241:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106244:	50                   	push   %eax
80106245:	6a 02                	push   $0x2
80106247:	e8 52 f4 ff ff       	call   8010569e <argint>
8010624c:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
8010624f:	85 c0                	test   %eax,%eax
80106251:	78 25                	js     80106278 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106253:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106256:	0f bf c8             	movswl %ax,%ecx
80106259:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010625c:	0f bf d0             	movswl %ax,%edx
8010625f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106262:	51                   	push   %ecx
80106263:	52                   	push   %edx
80106264:	6a 03                	push   $0x3
80106266:	50                   	push   %eax
80106267:	e8 dc fb ff ff       	call   80105e48 <create>
8010626c:	83 c4 10             	add    $0x10,%esp
8010626f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106272:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106276:	75 0c                	jne    80106284 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80106278:	e8 b4 d5 ff ff       	call   80103831 <commit_trans>
    return -1;
8010627d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106282:	eb 18                	jmp    8010629c <sys_mknod+0x98>
  }
  iunlockput(ip);
80106284:	83 ec 0c             	sub    $0xc,%esp
80106287:	ff 75 f0             	pushl  -0x10(%ebp)
8010628a:	e8 85 be ff ff       	call   80102114 <iunlockput>
8010628f:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80106292:	e8 9a d5 ff ff       	call   80103831 <commit_trans>
  return 0;
80106297:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010629c:	c9                   	leave  
8010629d:	c3                   	ret    

8010629e <sys_chdir>:

int
sys_chdir(void)
{
8010629e:	55                   	push   %ebp
8010629f:	89 e5                	mov    %esp,%ebp
801062a1:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
801062a4:	83 ec 08             	sub    $0x8,%esp
801062a7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062aa:	50                   	push   %eax
801062ab:	6a 00                	push   $0x0
801062ad:	e8 71 f4 ff ff       	call   80105723 <argstr>
801062b2:	83 c4 10             	add    $0x10,%esp
801062b5:	85 c0                	test   %eax,%eax
801062b7:	78 18                	js     801062d1 <sys_chdir+0x33>
801062b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062bc:	83 ec 0c             	sub    $0xc,%esp
801062bf:	50                   	push   %eax
801062c0:	e8 4d c7 ff ff       	call   80102a12 <namei>
801062c5:	83 c4 10             	add    $0x10,%esp
801062c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062cf:	75 07                	jne    801062d8 <sys_chdir+0x3a>
    return -1;
801062d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062d6:	eb 64                	jmp    8010633c <sys_chdir+0x9e>
  ilock(ip);
801062d8:	83 ec 0c             	sub    $0xc,%esp
801062db:	ff 75 f4             	pushl  -0xc(%ebp)
801062de:	e8 77 bb ff ff       	call   80101e5a <ilock>
801062e3:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
801062e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801062ed:	66 83 f8 01          	cmp    $0x1,%ax
801062f1:	74 15                	je     80106308 <sys_chdir+0x6a>
    iunlockput(ip);
801062f3:	83 ec 0c             	sub    $0xc,%esp
801062f6:	ff 75 f4             	pushl  -0xc(%ebp)
801062f9:	e8 16 be ff ff       	call   80102114 <iunlockput>
801062fe:	83 c4 10             	add    $0x10,%esp
    return -1;
80106301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106306:	eb 34                	jmp    8010633c <sys_chdir+0x9e>
  }
  iunlock(ip);
80106308:	83 ec 0c             	sub    $0xc,%esp
8010630b:	ff 75 f4             	pushl  -0xc(%ebp)
8010630e:	e8 9f bc ff ff       	call   80101fb2 <iunlock>
80106313:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106316:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010631c:	8b 40 68             	mov    0x68(%eax),%eax
8010631f:	83 ec 0c             	sub    $0xc,%esp
80106322:	50                   	push   %eax
80106323:	e8 fc bc ff ff       	call   80102024 <iput>
80106328:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
8010632b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106331:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106334:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106337:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010633c:	c9                   	leave  
8010633d:	c3                   	ret    

8010633e <sys_exec>:

int
sys_exec(void)
{
8010633e:	55                   	push   %ebp
8010633f:	89 e5                	mov    %esp,%ebp
80106341:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106347:	83 ec 08             	sub    $0x8,%esp
8010634a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010634d:	50                   	push   %eax
8010634e:	6a 00                	push   $0x0
80106350:	e8 ce f3 ff ff       	call   80105723 <argstr>
80106355:	83 c4 10             	add    $0x10,%esp
80106358:	85 c0                	test   %eax,%eax
8010635a:	78 18                	js     80106374 <sys_exec+0x36>
8010635c:	83 ec 08             	sub    $0x8,%esp
8010635f:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106365:	50                   	push   %eax
80106366:	6a 01                	push   $0x1
80106368:	e8 31 f3 ff ff       	call   8010569e <argint>
8010636d:	83 c4 10             	add    $0x10,%esp
80106370:	85 c0                	test   %eax,%eax
80106372:	79 0a                	jns    8010637e <sys_exec+0x40>
    return -1;
80106374:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106379:	e9 c6 00 00 00       	jmp    80106444 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
8010637e:	83 ec 04             	sub    $0x4,%esp
80106381:	68 80 00 00 00       	push   $0x80
80106386:	6a 00                	push   $0x0
80106388:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010638e:	50                   	push   %eax
8010638f:	e8 e5 ef ff ff       	call   80105379 <memset>
80106394:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80106397:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010639e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063a1:	83 f8 1f             	cmp    $0x1f,%eax
801063a4:	76 0a                	jbe    801063b0 <sys_exec+0x72>
      return -1;
801063a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063ab:	e9 94 00 00 00       	jmp    80106444 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801063b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063b3:	c1 e0 02             	shl    $0x2,%eax
801063b6:	89 c2                	mov    %eax,%edx
801063b8:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801063be:	01 c2                	add    %eax,%edx
801063c0:	83 ec 08             	sub    $0x8,%esp
801063c3:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801063c9:	50                   	push   %eax
801063ca:	52                   	push   %edx
801063cb:	e8 32 f2 ff ff       	call   80105602 <fetchint>
801063d0:	83 c4 10             	add    $0x10,%esp
801063d3:	85 c0                	test   %eax,%eax
801063d5:	79 07                	jns    801063de <sys_exec+0xa0>
      return -1;
801063d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063dc:	eb 66                	jmp    80106444 <sys_exec+0x106>
    if(uarg == 0){
801063de:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801063e4:	85 c0                	test   %eax,%eax
801063e6:	75 27                	jne    8010640f <sys_exec+0xd1>
      argv[i] = 0;
801063e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063eb:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801063f2:	00 00 00 00 
      break;
801063f6:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801063f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063fa:	83 ec 08             	sub    $0x8,%esp
801063fd:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106403:	52                   	push   %edx
80106404:	50                   	push   %eax
80106405:	e8 af ac ff ff       	call   801010b9 <exec>
8010640a:	83 c4 10             	add    $0x10,%esp
8010640d:	eb 35                	jmp    80106444 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010640f:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106415:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106418:	c1 e2 02             	shl    $0x2,%edx
8010641b:	01 c2                	add    %eax,%edx
8010641d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106423:	83 ec 08             	sub    $0x8,%esp
80106426:	52                   	push   %edx
80106427:	50                   	push   %eax
80106428:	e8 0f f2 ff ff       	call   8010563c <fetchstr>
8010642d:	83 c4 10             	add    $0x10,%esp
80106430:	85 c0                	test   %eax,%eax
80106432:	79 07                	jns    8010643b <sys_exec+0xfd>
      return -1;
80106434:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106439:	eb 09                	jmp    80106444 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010643b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010643f:	e9 5a ff ff ff       	jmp    8010639e <sys_exec+0x60>
  return exec(path, argv);
}
80106444:	c9                   	leave  
80106445:	c3                   	ret    

80106446 <sys_pipe>:

int
sys_pipe(void)
{
80106446:	55                   	push   %ebp
80106447:	89 e5                	mov    %esp,%ebp
80106449:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010644c:	83 ec 04             	sub    $0x4,%esp
8010644f:	6a 08                	push   $0x8
80106451:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106454:	50                   	push   %eax
80106455:	6a 00                	push   $0x0
80106457:	e8 6a f2 ff ff       	call   801056c6 <argptr>
8010645c:	83 c4 10             	add    $0x10,%esp
8010645f:	85 c0                	test   %eax,%eax
80106461:	79 0a                	jns    8010646d <sys_pipe+0x27>
    return -1;
80106463:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106468:	e9 af 00 00 00       	jmp    8010651c <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
8010646d:	83 ec 08             	sub    $0x8,%esp
80106470:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106473:	50                   	push   %eax
80106474:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106477:	50                   	push   %eax
80106478:	e8 1a dd ff ff       	call   80104197 <pipealloc>
8010647d:	83 c4 10             	add    $0x10,%esp
80106480:	85 c0                	test   %eax,%eax
80106482:	79 0a                	jns    8010648e <sys_pipe+0x48>
    return -1;
80106484:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106489:	e9 8e 00 00 00       	jmp    8010651c <sys_pipe+0xd6>
  fd0 = -1;
8010648e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106495:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106498:	83 ec 0c             	sub    $0xc,%esp
8010649b:	50                   	push   %eax
8010649c:	e8 ae f3 ff ff       	call   8010584f <fdalloc>
801064a1:	83 c4 10             	add    $0x10,%esp
801064a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064ab:	78 18                	js     801064c5 <sys_pipe+0x7f>
801064ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064b0:	83 ec 0c             	sub    $0xc,%esp
801064b3:	50                   	push   %eax
801064b4:	e8 96 f3 ff ff       	call   8010584f <fdalloc>
801064b9:	83 c4 10             	add    $0x10,%esp
801064bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
801064bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801064c3:	79 3f                	jns    80106504 <sys_pipe+0xbe>
    if(fd0 >= 0)
801064c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064c9:	78 14                	js     801064df <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
801064cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064d4:	83 c2 08             	add    $0x8,%edx
801064d7:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801064de:	00 
    fileclose(rf);
801064df:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064e2:	83 ec 0c             	sub    $0xc,%esp
801064e5:	50                   	push   %eax
801064e6:	e8 9a b0 ff ff       	call   80101585 <fileclose>
801064eb:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
801064ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064f1:	83 ec 0c             	sub    $0xc,%esp
801064f4:	50                   	push   %eax
801064f5:	e8 8b b0 ff ff       	call   80101585 <fileclose>
801064fa:	83 c4 10             	add    $0x10,%esp
    return -1;
801064fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106502:	eb 18                	jmp    8010651c <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80106504:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106507:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010650a:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
8010650c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010650f:	8d 50 04             	lea    0x4(%eax),%edx
80106512:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106515:	89 02                	mov    %eax,(%edx)
  return 0;
80106517:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010651c:	c9                   	leave  
8010651d:	c3                   	ret    

8010651e <sys_setCursorPos>:

//add_function----------------------------------------

int sys_setCursorPos(void){
8010651e:	55                   	push   %ebp
8010651f:	89 e5                	mov    %esp,%ebp
80106521:	83 ec 18             	sub    $0x18,%esp
	int x,y;
	if(argint(0,&x)<0 || argint(1,&y)<0)
80106524:	83 ec 08             	sub    $0x8,%esp
80106527:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010652a:	50                   	push   %eax
8010652b:	6a 00                	push   $0x0
8010652d:	e8 6c f1 ff ff       	call   8010569e <argint>
80106532:	83 c4 10             	add    $0x10,%esp
80106535:	85 c0                	test   %eax,%eax
80106537:	78 15                	js     8010654e <sys_setCursorPos+0x30>
80106539:	83 ec 08             	sub    $0x8,%esp
8010653c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010653f:	50                   	push   %eax
80106540:	6a 01                	push   $0x1
80106542:	e8 57 f1 ff ff       	call   8010569e <argint>
80106547:	83 c4 10             	add    $0x10,%esp
8010654a:	85 c0                	test   %eax,%eax
8010654c:	79 07                	jns    80106555 <sys_setCursorPos+0x37>
		return -1;
8010654e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106553:	eb 18                	jmp    8010656d <sys_setCursorPos+0x4f>
	setCursorPos(x,y);
80106555:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106558:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010655b:	83 ec 08             	sub    $0x8,%esp
8010655e:	52                   	push   %edx
8010655f:	50                   	push   %eax
80106560:	e8 0a a1 ff ff       	call   8010066f <setCursorPos>
80106565:	83 c4 10             	add    $0x10,%esp
	return 0;
80106568:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010656d:	c9                   	leave  
8010656e:	c3                   	ret    

8010656f <sys_copyFromTextToScreen>:
int sys_copyFromTextToScreen(void){
8010656f:	55                   	push   %ebp
80106570:	89 e5                	mov    %esp,%ebp
80106572:	53                   	push   %ebx
80106573:	83 ec 14             	sub    $0x14,%esp
	char *text;
	int pos,len;
  int color;
	if(argstr(0,&text)<0 || argint(1,&pos)<0 || argint(2,&len)<0 || argint(3,&color)<0)
80106576:	83 ec 08             	sub    $0x8,%esp
80106579:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010657c:	50                   	push   %eax
8010657d:	6a 00                	push   $0x0
8010657f:	e8 9f f1 ff ff       	call   80105723 <argstr>
80106584:	83 c4 10             	add    $0x10,%esp
80106587:	85 c0                	test   %eax,%eax
80106589:	78 3f                	js     801065ca <sys_copyFromTextToScreen+0x5b>
8010658b:	83 ec 08             	sub    $0x8,%esp
8010658e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106591:	50                   	push   %eax
80106592:	6a 01                	push   $0x1
80106594:	e8 05 f1 ff ff       	call   8010569e <argint>
80106599:	83 c4 10             	add    $0x10,%esp
8010659c:	85 c0                	test   %eax,%eax
8010659e:	78 2a                	js     801065ca <sys_copyFromTextToScreen+0x5b>
801065a0:	83 ec 08             	sub    $0x8,%esp
801065a3:	8d 45 ec             	lea    -0x14(%ebp),%eax
801065a6:	50                   	push   %eax
801065a7:	6a 02                	push   $0x2
801065a9:	e8 f0 f0 ff ff       	call   8010569e <argint>
801065ae:	83 c4 10             	add    $0x10,%esp
801065b1:	85 c0                	test   %eax,%eax
801065b3:	78 15                	js     801065ca <sys_copyFromTextToScreen+0x5b>
801065b5:	83 ec 08             	sub    $0x8,%esp
801065b8:	8d 45 e8             	lea    -0x18(%ebp),%eax
801065bb:	50                   	push   %eax
801065bc:	6a 03                	push   $0x3
801065be:	e8 db f0 ff ff       	call   8010569e <argint>
801065c3:	83 c4 10             	add    $0x10,%esp
801065c6:	85 c0                	test   %eax,%eax
801065c8:	79 07                	jns    801065d1 <sys_copyFromTextToScreen+0x62>
		return -1;
801065ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065cf:	eb 1d                	jmp    801065ee <sys_copyFromTextToScreen+0x7f>
	copyFromTextToScreen(text,pos,len,color);
801065d1:	8b 5d e8             	mov    -0x18(%ebp),%ebx
801065d4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801065d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801065da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065dd:	53                   	push   %ebx
801065de:	51                   	push   %ecx
801065df:	52                   	push   %edx
801065e0:	50                   	push   %eax
801065e1:	e8 af a7 ff ff       	call   80100d95 <copyFromTextToScreen>
801065e6:	83 c4 10             	add    $0x10,%esp
	return 0;
801065e9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065f1:	c9                   	leave  
801065f2:	c3                   	ret    

801065f3 <sys_clearScreen>:
int sys_clearScreen(void){
801065f3:	55                   	push   %ebp
801065f4:	89 e5                	mov    %esp,%ebp
801065f6:	83 ec 08             	sub    $0x8,%esp
	clearScreen();
801065f9:	e8 36 a6 ff ff       	call   80100c34 <clearScreen>
	return 0;
801065fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106603:	c9                   	leave  
80106604:	c3                   	ret    

80106605 <sys_writeAt>:
int sys_writeAt(void){
80106605:	55                   	push   %ebp
80106606:	89 e5                	mov    %esp,%ebp
80106608:	83 ec 18             	sub    $0x18,%esp
	int x,y,c;
	if(argint(0,&x)<0 || argint(1,&y)<0 || argint(2,&c)<0)
8010660b:	83 ec 08             	sub    $0x8,%esp
8010660e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106611:	50                   	push   %eax
80106612:	6a 00                	push   $0x0
80106614:	e8 85 f0 ff ff       	call   8010569e <argint>
80106619:	83 c4 10             	add    $0x10,%esp
8010661c:	85 c0                	test   %eax,%eax
8010661e:	78 2a                	js     8010664a <sys_writeAt+0x45>
80106620:	83 ec 08             	sub    $0x8,%esp
80106623:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106626:	50                   	push   %eax
80106627:	6a 01                	push   $0x1
80106629:	e8 70 f0 ff ff       	call   8010569e <argint>
8010662e:	83 c4 10             	add    $0x10,%esp
80106631:	85 c0                	test   %eax,%eax
80106633:	78 15                	js     8010664a <sys_writeAt+0x45>
80106635:	83 ec 08             	sub    $0x8,%esp
80106638:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010663b:	50                   	push   %eax
8010663c:	6a 02                	push   $0x2
8010663e:	e8 5b f0 ff ff       	call   8010569e <argint>
80106643:	83 c4 10             	add    $0x10,%esp
80106646:	85 c0                	test   %eax,%eax
80106648:	79 07                	jns    80106651 <sys_writeAt+0x4c>
		return -1;
8010664a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010664f:	eb 1f                	jmp    80106670 <sys_writeAt+0x6b>
	writeAt(x,y,(char)c);
80106651:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106654:	0f be c8             	movsbl %al,%ecx
80106657:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010665a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010665d:	83 ec 04             	sub    $0x4,%esp
80106660:	51                   	push   %ecx
80106661:	52                   	push   %edx
80106662:	50                   	push   %eax
80106663:	e8 5a a6 ff ff       	call   80100cc2 <writeAt>
80106668:	83 c4 10             	add    $0x10,%esp
	return 0; 
8010666b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106670:	c9                   	leave  
80106671:	c3                   	ret    

80106672 <sys_setBufferFlag>:
int sys_setBufferFlag(void){
80106672:	55                   	push   %ebp
80106673:	89 e5                	mov    %esp,%ebp
80106675:	83 ec 18             	sub    $0x18,%esp
	int flag;
	if(argint(0,&flag)<0)
80106678:	83 ec 08             	sub    $0x8,%esp
8010667b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010667e:	50                   	push   %eax
8010667f:	6a 00                	push   $0x0
80106681:	e8 18 f0 ff ff       	call   8010569e <argint>
80106686:	83 c4 10             	add    $0x10,%esp
80106689:	85 c0                	test   %eax,%eax
8010668b:	79 07                	jns    80106694 <sys_setBufferFlag+0x22>
		return -1;
8010668d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106692:	eb 14                	jmp    801066a8 <sys_setBufferFlag+0x36>
	setBufferFlag(flag);
80106694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106697:	83 ec 0c             	sub    $0xc,%esp
8010669a:	50                   	push   %eax
8010669b:	e8 77 9c ff ff       	call   80100317 <setBufferFlag>
801066a0:	83 c4 10             	add    $0x10,%esp
	return 0;
801066a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    

801066aa <sys_setShowAtOnce>:
int sys_setShowAtOnce(void){
801066aa:	55                   	push   %ebp
801066ab:	89 e5                	mov    %esp,%ebp
801066ad:	83 ec 18             	sub    $0x18,%esp
	int flag;
	if(argint(0,&flag)<0)
801066b0:	83 ec 08             	sub    $0x8,%esp
801066b3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066b6:	50                   	push   %eax
801066b7:	6a 00                	push   $0x0
801066b9:	e8 e0 ef ff ff       	call   8010569e <argint>
801066be:	83 c4 10             	add    $0x10,%esp
801066c1:	85 c0                	test   %eax,%eax
801066c3:	79 07                	jns    801066cc <sys_setShowAtOnce+0x22>
		return -1;
801066c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066ca:	eb 14                	jmp    801066e0 <sys_setShowAtOnce+0x36>
	setShowAtOnce(flag);
801066cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066cf:	83 ec 0c             	sub    $0xc,%esp
801066d2:	50                   	push   %eax
801066d3:	e8 4d 9c ff ff       	call   80100325 <setShowAtOnce>
801066d8:	83 c4 10             	add    $0x10,%esp
	return 0;
801066db:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066e0:	c9                   	leave  
801066e1:	c3                   	ret    

801066e2 <sys_getCursorPos>:
int sys_getCursorPos(void){
801066e2:	55                   	push   %ebp
801066e3:	89 e5                	mov    %esp,%ebp
801066e5:	83 ec 08             	sub    $0x8,%esp
	return getCursorPos();
801066e8:	e8 30 9f ff ff       	call   8010061d <getCursorPos>
}
801066ed:	c9                   	leave  
801066ee:	c3                   	ret    

801066ef <sys_saveScreen>:

int sys_saveScreen(void){
801066ef:	55                   	push   %ebp
801066f0:	89 e5                	mov    %esp,%ebp
801066f2:	83 ec 18             	sub    $0x18,%esp
  ushort *screen;
  int pos;
  if(argint(1,&pos)<0 || argptr(0,(char **)&screen, pos)<0 )
801066f5:	83 ec 08             	sub    $0x8,%esp
801066f8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066fb:	50                   	push   %eax
801066fc:	6a 01                	push   $0x1
801066fe:	e8 9b ef ff ff       	call   8010569e <argint>
80106703:	83 c4 10             	add    $0x10,%esp
80106706:	85 c0                	test   %eax,%eax
80106708:	78 19                	js     80106723 <sys_saveScreen+0x34>
8010670a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010670d:	83 ec 04             	sub    $0x4,%esp
80106710:	50                   	push   %eax
80106711:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106714:	50                   	push   %eax
80106715:	6a 00                	push   $0x0
80106717:	e8 aa ef ff ff       	call   801056c6 <argptr>
8010671c:	83 c4 10             	add    $0x10,%esp
8010671f:	85 c0                	test   %eax,%eax
80106721:	79 07                	jns    8010672a <sys_saveScreen+0x3b>
		return -1;
80106723:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106728:	eb 18                	jmp    80106742 <sys_saveScreen+0x53>
  saveScreen(screen, pos);
8010672a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010672d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106730:	83 ec 08             	sub    $0x8,%esp
80106733:	52                   	push   %edx
80106734:	50                   	push   %eax
80106735:	e8 b5 a5 ff ff       	call   80100cef <saveScreen>
8010673a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010673d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106742:	c9                   	leave  
80106743:	c3                   	ret    

80106744 <sys_recorverScreen>:

int sys_recorverScreen(void){
80106744:	55                   	push   %ebp
80106745:	89 e5                	mov    %esp,%ebp
80106747:	83 ec 18             	sub    $0x18,%esp
  ushort *screen;
  int pos;
  if( argint(1,&pos)<0 || argptr(0,(char **)&screen, pos)<0 )
8010674a:	83 ec 08             	sub    $0x8,%esp
8010674d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106750:	50                   	push   %eax
80106751:	6a 01                	push   $0x1
80106753:	e8 46 ef ff ff       	call   8010569e <argint>
80106758:	83 c4 10             	add    $0x10,%esp
8010675b:	85 c0                	test   %eax,%eax
8010675d:	78 19                	js     80106778 <sys_recorverScreen+0x34>
8010675f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106762:	83 ec 04             	sub    $0x4,%esp
80106765:	50                   	push   %eax
80106766:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106769:	50                   	push   %eax
8010676a:	6a 00                	push   $0x0
8010676c:	e8 55 ef ff ff       	call   801056c6 <argptr>
80106771:	83 c4 10             	add    $0x10,%esp
80106774:	85 c0                	test   %eax,%eax
80106776:	79 07                	jns    8010677f <sys_recorverScreen+0x3b>
		return -1;
80106778:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010677d:	eb 18                	jmp    80106797 <sys_recorverScreen+0x53>
  recorverScreen(screen, pos);
8010677f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106782:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106785:	83 ec 08             	sub    $0x8,%esp
80106788:	52                   	push   %edx
80106789:	50                   	push   %eax
8010678a:	e8 89 a5 ff ff       	call   80100d18 <recorverScreen>
8010678f:	83 c4 10             	add    $0x10,%esp
  return 0;
80106792:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106797:	c9                   	leave  
80106798:	c3                   	ret    

80106799 <sys_ToScreen>:

int sys_ToScreen(void){
80106799:	55                   	push   %ebp
8010679a:	89 e5                	mov    %esp,%ebp
8010679c:	53                   	push   %ebx
8010679d:	83 ec 14             	sub    $0x14,%esp
	char *text;
	int pos,len;
  int *color;
	if(argstr(0,&text)<0 || argint(1,&pos)<0 || argint(2,&len)<0 || argint(3,(int*)&color)<0)
801067a0:	83 ec 08             	sub    $0x8,%esp
801067a3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067a6:	50                   	push   %eax
801067a7:	6a 00                	push   $0x0
801067a9:	e8 75 ef ff ff       	call   80105723 <argstr>
801067ae:	83 c4 10             	add    $0x10,%esp
801067b1:	85 c0                	test   %eax,%eax
801067b3:	78 3f                	js     801067f4 <sys_ToScreen+0x5b>
801067b5:	83 ec 08             	sub    $0x8,%esp
801067b8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067bb:	50                   	push   %eax
801067bc:	6a 01                	push   $0x1
801067be:	e8 db ee ff ff       	call   8010569e <argint>
801067c3:	83 c4 10             	add    $0x10,%esp
801067c6:	85 c0                	test   %eax,%eax
801067c8:	78 2a                	js     801067f4 <sys_ToScreen+0x5b>
801067ca:	83 ec 08             	sub    $0x8,%esp
801067cd:	8d 45 ec             	lea    -0x14(%ebp),%eax
801067d0:	50                   	push   %eax
801067d1:	6a 02                	push   $0x2
801067d3:	e8 c6 ee ff ff       	call   8010569e <argint>
801067d8:	83 c4 10             	add    $0x10,%esp
801067db:	85 c0                	test   %eax,%eax
801067dd:	78 15                	js     801067f4 <sys_ToScreen+0x5b>
801067df:	83 ec 08             	sub    $0x8,%esp
801067e2:	8d 45 e8             	lea    -0x18(%ebp),%eax
801067e5:	50                   	push   %eax
801067e6:	6a 03                	push   $0x3
801067e8:	e8 b1 ee ff ff       	call   8010569e <argint>
801067ed:	83 c4 10             	add    $0x10,%esp
801067f0:	85 c0                	test   %eax,%eax
801067f2:	79 07                	jns    801067fb <sys_ToScreen+0x62>
		return -1;
801067f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067f9:	eb 1d                	jmp    80106818 <sys_ToScreen+0x7f>
	ToScreen(text,pos,len,color);
801067fb:	8b 5d e8             	mov    -0x18(%ebp),%ebx
801067fe:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80106801:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106807:	53                   	push   %ebx
80106808:	51                   	push   %ecx
80106809:	52                   	push   %edx
8010680a:	50                   	push   %eax
8010680b:	e8 5f a6 ff ff       	call   80100e6f <ToScreen>
80106810:	83 c4 10             	add    $0x10,%esp
	return 0;
80106813:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106818:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010681b:	c9                   	leave  
8010681c:	c3                   	ret    

8010681d <sys_getColor>:

int sys_getColor(void){
8010681d:	55                   	push   %ebp
8010681e:	89 e5                	mov    %esp,%ebp
80106820:	83 ec 18             	sub    $0x18,%esp
  uchar tcolor;
  uchar bcolor;
  if( argstr(0,(char **)&tcolor)<0 || argstr(1,(char **)&bcolor)<0 )
80106823:	83 ec 08             	sub    $0x8,%esp
80106826:	8d 45 f7             	lea    -0x9(%ebp),%eax
80106829:	50                   	push   %eax
8010682a:	6a 00                	push   $0x0
8010682c:	e8 f2 ee ff ff       	call   80105723 <argstr>
80106831:	83 c4 10             	add    $0x10,%esp
80106834:	85 c0                	test   %eax,%eax
80106836:	78 15                	js     8010684d <sys_getColor+0x30>
80106838:	83 ec 08             	sub    $0x8,%esp
8010683b:	8d 45 f6             	lea    -0xa(%ebp),%eax
8010683e:	50                   	push   %eax
8010683f:	6a 01                	push   $0x1
80106841:	e8 dd ee ff ff       	call   80105723 <argstr>
80106846:	83 c4 10             	add    $0x10,%esp
80106849:	85 c0                	test   %eax,%eax
8010684b:	79 07                	jns    80106854 <sys_getColor+0x37>
		return -1;
8010684d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106852:	eb 20                	jmp    80106874 <sys_getColor+0x57>
  getColor(tcolor, bcolor);
80106854:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
80106858:	0f b6 d0             	movzbl %al,%edx
8010685b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
8010685f:	0f b6 c0             	movzbl %al,%eax
80106862:	83 ec 08             	sub    $0x8,%esp
80106865:	52                   	push   %edx
80106866:	50                   	push   %eax
80106867:	e8 ef a6 ff ff       	call   80100f5b <getColor>
8010686c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010686f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106874:	c9                   	leave  
80106875:	c3                   	ret    

80106876 <sys_showC>:

int sys_showC(void){
80106876:	55                   	push   %ebp
80106877:	89 e5                	mov    %esp,%ebp
80106879:	83 ec 18             	sub    $0x18,%esp
  int c;
  uchar color;
  if( argint(0,&c)<0 || argstr(1,(char **)&color)<0 )
8010687c:	83 ec 08             	sub    $0x8,%esp
8010687f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106882:	50                   	push   %eax
80106883:	6a 00                	push   $0x0
80106885:	e8 14 ee ff ff       	call   8010569e <argint>
8010688a:	83 c4 10             	add    $0x10,%esp
8010688d:	85 c0                	test   %eax,%eax
8010688f:	78 15                	js     801068a6 <sys_showC+0x30>
80106891:	83 ec 08             	sub    $0x8,%esp
80106894:	8d 45 f3             	lea    -0xd(%ebp),%eax
80106897:	50                   	push   %eax
80106898:	6a 01                	push   $0x1
8010689a:	e8 84 ee ff ff       	call   80105723 <argstr>
8010689f:	83 c4 10             	add    $0x10,%esp
801068a2:	85 c0                	test   %eax,%eax
801068a4:	79 07                	jns    801068ad <sys_showC+0x37>
		return -1;
801068a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068ab:	eb 1c                	jmp    801068c9 <sys_showC+0x53>
  showC(c, color);
801068ad:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
801068b1:	0f b6 d0             	movzbl %al,%edx
801068b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068b7:	83 ec 08             	sub    $0x8,%esp
801068ba:	52                   	push   %edx
801068bb:	50                   	push   %eax
801068bc:	e8 bd a6 ff ff       	call   80100f7e <showC>
801068c1:	83 c4 10             	add    $0x10,%esp
  return 0;
801068c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801068c9:	c9                   	leave  
801068ca:	c3                   	ret    

801068cb <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801068cb:	55                   	push   %ebp
801068cc:	89 e5                	mov    %esp,%ebp
801068ce:	83 ec 08             	sub    $0x8,%esp
  return fork();
801068d1:	e8 b7 df ff ff       	call   8010488d <fork>
}
801068d6:	c9                   	leave  
801068d7:	c3                   	ret    

801068d8 <sys_exit>:

int
sys_exit(void)
{
801068d8:	55                   	push   %ebp
801068d9:	89 e5                	mov    %esp,%ebp
801068db:	83 ec 08             	sub    $0x8,%esp
  exit();
801068de:	e8 1b e1 ff ff       	call   801049fe <exit>
  return 0;  // not reached
801068e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801068e8:	c9                   	leave  
801068e9:	c3                   	ret    

801068ea <sys_wait>:

int
sys_wait(void)
{
801068ea:	55                   	push   %ebp
801068eb:	89 e5                	mov    %esp,%ebp
801068ed:	83 ec 08             	sub    $0x8,%esp
  return wait();
801068f0:	e8 37 e2 ff ff       	call   80104b2c <wait>
}
801068f5:	c9                   	leave  
801068f6:	c3                   	ret    

801068f7 <sys_kill>:

int
sys_kill(void)
{
801068f7:	55                   	push   %ebp
801068f8:	89 e5                	mov    %esp,%ebp
801068fa:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801068fd:	83 ec 08             	sub    $0x8,%esp
80106900:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106903:	50                   	push   %eax
80106904:	6a 00                	push   $0x0
80106906:	e8 93 ed ff ff       	call   8010569e <argint>
8010690b:	83 c4 10             	add    $0x10,%esp
8010690e:	85 c0                	test   %eax,%eax
80106910:	79 07                	jns    80106919 <sys_kill+0x22>
    return -1;
80106912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106917:	eb 0f                	jmp    80106928 <sys_kill+0x31>
  return kill(pid);
80106919:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010691c:	83 ec 0c             	sub    $0xc,%esp
8010691f:	50                   	push   %eax
80106920:	e8 1a e6 ff ff       	call   80104f3f <kill>
80106925:	83 c4 10             	add    $0x10,%esp
}
80106928:	c9                   	leave  
80106929:	c3                   	ret    

8010692a <sys_getpid>:

int
sys_getpid(void)
{
8010692a:	55                   	push   %ebp
8010692b:	89 e5                	mov    %esp,%ebp
  return proc->pid;
8010692d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106933:	8b 40 10             	mov    0x10(%eax),%eax
}
80106936:	5d                   	pop    %ebp
80106937:	c3                   	ret    

80106938 <sys_sbrk>:

int
sys_sbrk(void)
{
80106938:	55                   	push   %ebp
80106939:	89 e5                	mov    %esp,%ebp
8010693b:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010693e:	83 ec 08             	sub    $0x8,%esp
80106941:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106944:	50                   	push   %eax
80106945:	6a 00                	push   $0x0
80106947:	e8 52 ed ff ff       	call   8010569e <argint>
8010694c:	83 c4 10             	add    $0x10,%esp
8010694f:	85 c0                	test   %eax,%eax
80106951:	79 07                	jns    8010695a <sys_sbrk+0x22>
    return -1;
80106953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106958:	eb 28                	jmp    80106982 <sys_sbrk+0x4a>
  addr = proc->sz;
8010695a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106960:	8b 00                	mov    (%eax),%eax
80106962:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106965:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106968:	83 ec 0c             	sub    $0xc,%esp
8010696b:	50                   	push   %eax
8010696c:	e8 79 de ff ff       	call   801047ea <growproc>
80106971:	83 c4 10             	add    $0x10,%esp
80106974:	85 c0                	test   %eax,%eax
80106976:	79 07                	jns    8010697f <sys_sbrk+0x47>
    return -1;
80106978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010697d:	eb 03                	jmp    80106982 <sys_sbrk+0x4a>
  return addr;
8010697f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106982:	c9                   	leave  
80106983:	c3                   	ret    

80106984 <sys_sleep>:

int
sys_sleep(void)
{
80106984:	55                   	push   %ebp
80106985:	89 e5                	mov    %esp,%ebp
80106987:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
8010698a:	83 ec 08             	sub    $0x8,%esp
8010698d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106990:	50                   	push   %eax
80106991:	6a 00                	push   $0x0
80106993:	e8 06 ed ff ff       	call   8010569e <argint>
80106998:	83 c4 10             	add    $0x10,%esp
8010699b:	85 c0                	test   %eax,%eax
8010699d:	79 07                	jns    801069a6 <sys_sleep+0x22>
    return -1;
8010699f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069a4:	eb 77                	jmp    80106a1d <sys_sleep+0x99>
  acquire(&tickslock);
801069a6:	83 ec 0c             	sub    $0xc,%esp
801069a9:	68 e0 2f 11 80       	push   $0x80112fe0
801069ae:	e8 63 e7 ff ff       	call   80105116 <acquire>
801069b3:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801069b6:	a1 20 38 11 80       	mov    0x80113820,%eax
801069bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801069be:	eb 39                	jmp    801069f9 <sys_sleep+0x75>
    if(proc->killed){
801069c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069c6:	8b 40 24             	mov    0x24(%eax),%eax
801069c9:	85 c0                	test   %eax,%eax
801069cb:	74 17                	je     801069e4 <sys_sleep+0x60>
      release(&tickslock);
801069cd:	83 ec 0c             	sub    $0xc,%esp
801069d0:	68 e0 2f 11 80       	push   $0x80112fe0
801069d5:	e8 a3 e7 ff ff       	call   8010517d <release>
801069da:	83 c4 10             	add    $0x10,%esp
      return -1;
801069dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069e2:	eb 39                	jmp    80106a1d <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
801069e4:	83 ec 08             	sub    $0x8,%esp
801069e7:	68 e0 2f 11 80       	push   $0x80112fe0
801069ec:	68 20 38 11 80       	push   $0x80113820
801069f1:	e8 27 e4 ff ff       	call   80104e1d <sleep>
801069f6:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801069f9:	a1 20 38 11 80       	mov    0x80113820,%eax
801069fe:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106a01:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106a04:	39 d0                	cmp    %edx,%eax
80106a06:	72 b8                	jb     801069c0 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106a08:	83 ec 0c             	sub    $0xc,%esp
80106a0b:	68 e0 2f 11 80       	push   $0x80112fe0
80106a10:	e8 68 e7 ff ff       	call   8010517d <release>
80106a15:	83 c4 10             	add    $0x10,%esp
  return 0;
80106a18:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106a1d:	c9                   	leave  
80106a1e:	c3                   	ret    

80106a1f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106a1f:	55                   	push   %ebp
80106a20:	89 e5                	mov    %esp,%ebp
80106a22:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
80106a25:	83 ec 0c             	sub    $0xc,%esp
80106a28:	68 e0 2f 11 80       	push   $0x80112fe0
80106a2d:	e8 e4 e6 ff ff       	call   80105116 <acquire>
80106a32:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80106a35:	a1 20 38 11 80       	mov    0x80113820,%eax
80106a3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106a3d:	83 ec 0c             	sub    $0xc,%esp
80106a40:	68 e0 2f 11 80       	push   $0x80112fe0
80106a45:	e8 33 e7 ff ff       	call   8010517d <release>
80106a4a:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106a50:	c9                   	leave  
80106a51:	c3                   	ret    

80106a52 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106a52:	55                   	push   %ebp
80106a53:	89 e5                	mov    %esp,%ebp
80106a55:	83 ec 08             	sub    $0x8,%esp
80106a58:	8b 55 08             	mov    0x8(%ebp),%edx
80106a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a5e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106a62:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a65:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106a69:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106a6d:	ee                   	out    %al,(%dx)
}
80106a6e:	90                   	nop
80106a6f:	c9                   	leave  
80106a70:	c3                   	ret    

80106a71 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106a71:	55                   	push   %ebp
80106a72:	89 e5                	mov    %esp,%ebp
80106a74:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106a77:	6a 34                	push   $0x34
80106a79:	6a 43                	push   $0x43
80106a7b:	e8 d2 ff ff ff       	call   80106a52 <outb>
80106a80:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106a83:	68 9c 00 00 00       	push   $0x9c
80106a88:	6a 40                	push   $0x40
80106a8a:	e8 c3 ff ff ff       	call   80106a52 <outb>
80106a8f:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106a92:	6a 2e                	push   $0x2e
80106a94:	6a 40                	push   $0x40
80106a96:	e8 b7 ff ff ff       	call   80106a52 <outb>
80106a9b:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106a9e:	83 ec 0c             	sub    $0xc,%esp
80106aa1:	6a 00                	push   $0x0
80106aa3:	e8 d9 d5 ff ff       	call   80104081 <picenable>
80106aa8:	83 c4 10             	add    $0x10,%esp
}
80106aab:	90                   	nop
80106aac:	c9                   	leave  
80106aad:	c3                   	ret    

80106aae <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106aae:	1e                   	push   %ds
  pushl %es
80106aaf:	06                   	push   %es
  pushl %fs
80106ab0:	0f a0                	push   %fs
  pushl %gs
80106ab2:	0f a8                	push   %gs
  pushal
80106ab4:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106ab5:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106ab9:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106abb:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106abd:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106ac1:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106ac3:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106ac5:	54                   	push   %esp
  call trap
80106ac6:	e8 d7 01 00 00       	call   80106ca2 <trap>
  addl $4, %esp
80106acb:	83 c4 04             	add    $0x4,%esp

80106ace <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106ace:	61                   	popa   
  popl %gs
80106acf:	0f a9                	pop    %gs
  popl %fs
80106ad1:	0f a1                	pop    %fs
  popl %es
80106ad3:	07                   	pop    %es
  popl %ds
80106ad4:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106ad5:	83 c4 08             	add    $0x8,%esp
  iret
80106ad8:	cf                   	iret   

80106ad9 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106ad9:	55                   	push   %ebp
80106ada:	89 e5                	mov    %esp,%ebp
80106adc:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106adf:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ae2:	83 e8 01             	sub    $0x1,%eax
80106ae5:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80106aec:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106af0:	8b 45 08             	mov    0x8(%ebp),%eax
80106af3:	c1 e8 10             	shr    $0x10,%eax
80106af6:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106afa:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106afd:	0f 01 18             	lidtl  (%eax)
}
80106b00:	90                   	nop
80106b01:	c9                   	leave  
80106b02:	c3                   	ret    

80106b03 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106b03:	55                   	push   %ebp
80106b04:	89 e5                	mov    %esp,%ebp
80106b06:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106b09:	0f 20 d0             	mov    %cr2,%eax
80106b0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106b0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106b12:	c9                   	leave  
80106b13:	c3                   	ret    

80106b14 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106b14:	55                   	push   %ebp
80106b15:	89 e5                	mov    %esp,%ebp
80106b17:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106b1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106b21:	e9 c3 00 00 00       	jmp    80106be9 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b29:	8b 04 85 c8 c0 10 80 	mov    -0x7fef3f38(,%eax,4),%eax
80106b30:	89 c2                	mov    %eax,%edx
80106b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b35:	66 89 14 c5 20 30 11 	mov    %dx,-0x7feecfe0(,%eax,8)
80106b3c:	80 
80106b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b40:	66 c7 04 c5 22 30 11 	movw   $0x8,-0x7feecfde(,%eax,8)
80106b47:	80 08 00 
80106b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b4d:	0f b6 14 c5 24 30 11 	movzbl -0x7feecfdc(,%eax,8),%edx
80106b54:	80 
80106b55:	83 e2 e0             	and    $0xffffffe0,%edx
80106b58:	88 14 c5 24 30 11 80 	mov    %dl,-0x7feecfdc(,%eax,8)
80106b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b62:	0f b6 14 c5 24 30 11 	movzbl -0x7feecfdc(,%eax,8),%edx
80106b69:	80 
80106b6a:	83 e2 1f             	and    $0x1f,%edx
80106b6d:	88 14 c5 24 30 11 80 	mov    %dl,-0x7feecfdc(,%eax,8)
80106b74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b77:	0f b6 14 c5 25 30 11 	movzbl -0x7feecfdb(,%eax,8),%edx
80106b7e:	80 
80106b7f:	83 e2 f0             	and    $0xfffffff0,%edx
80106b82:	83 ca 0e             	or     $0xe,%edx
80106b85:	88 14 c5 25 30 11 80 	mov    %dl,-0x7feecfdb(,%eax,8)
80106b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b8f:	0f b6 14 c5 25 30 11 	movzbl -0x7feecfdb(,%eax,8),%edx
80106b96:	80 
80106b97:	83 e2 ef             	and    $0xffffffef,%edx
80106b9a:	88 14 c5 25 30 11 80 	mov    %dl,-0x7feecfdb(,%eax,8)
80106ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ba4:	0f b6 14 c5 25 30 11 	movzbl -0x7feecfdb(,%eax,8),%edx
80106bab:	80 
80106bac:	83 e2 9f             	and    $0xffffff9f,%edx
80106baf:	88 14 c5 25 30 11 80 	mov    %dl,-0x7feecfdb(,%eax,8)
80106bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bb9:	0f b6 14 c5 25 30 11 	movzbl -0x7feecfdb(,%eax,8),%edx
80106bc0:	80 
80106bc1:	83 ca 80             	or     $0xffffff80,%edx
80106bc4:	88 14 c5 25 30 11 80 	mov    %dl,-0x7feecfdb(,%eax,8)
80106bcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bce:	8b 04 85 c8 c0 10 80 	mov    -0x7fef3f38(,%eax,4),%eax
80106bd5:	c1 e8 10             	shr    $0x10,%eax
80106bd8:	89 c2                	mov    %eax,%edx
80106bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bdd:	66 89 14 c5 26 30 11 	mov    %dx,-0x7feecfda(,%eax,8)
80106be4:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106be5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106be9:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106bf0:	0f 8e 30 ff ff ff    	jle    80106b26 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106bf6:	a1 c8 c1 10 80       	mov    0x8010c1c8,%eax
80106bfb:	66 a3 20 32 11 80    	mov    %ax,0x80113220
80106c01:	66 c7 05 22 32 11 80 	movw   $0x8,0x80113222
80106c08:	08 00 
80106c0a:	0f b6 05 24 32 11 80 	movzbl 0x80113224,%eax
80106c11:	83 e0 e0             	and    $0xffffffe0,%eax
80106c14:	a2 24 32 11 80       	mov    %al,0x80113224
80106c19:	0f b6 05 24 32 11 80 	movzbl 0x80113224,%eax
80106c20:	83 e0 1f             	and    $0x1f,%eax
80106c23:	a2 24 32 11 80       	mov    %al,0x80113224
80106c28:	0f b6 05 25 32 11 80 	movzbl 0x80113225,%eax
80106c2f:	83 c8 0f             	or     $0xf,%eax
80106c32:	a2 25 32 11 80       	mov    %al,0x80113225
80106c37:	0f b6 05 25 32 11 80 	movzbl 0x80113225,%eax
80106c3e:	83 e0 ef             	and    $0xffffffef,%eax
80106c41:	a2 25 32 11 80       	mov    %al,0x80113225
80106c46:	0f b6 05 25 32 11 80 	movzbl 0x80113225,%eax
80106c4d:	83 c8 60             	or     $0x60,%eax
80106c50:	a2 25 32 11 80       	mov    %al,0x80113225
80106c55:	0f b6 05 25 32 11 80 	movzbl 0x80113225,%eax
80106c5c:	83 c8 80             	or     $0xffffff80,%eax
80106c5f:	a2 25 32 11 80       	mov    %al,0x80113225
80106c64:	a1 c8 c1 10 80       	mov    0x8010c1c8,%eax
80106c69:	c1 e8 10             	shr    $0x10,%eax
80106c6c:	66 a3 26 32 11 80    	mov    %ax,0x80113226
  
  initlock(&tickslock, "time");
80106c72:	83 ec 08             	sub    $0x8,%esp
80106c75:	68 24 98 10 80       	push   $0x80109824
80106c7a:	68 e0 2f 11 80       	push   $0x80112fe0
80106c7f:	e8 70 e4 ff ff       	call   801050f4 <initlock>
80106c84:	83 c4 10             	add    $0x10,%esp
}
80106c87:	90                   	nop
80106c88:	c9                   	leave  
80106c89:	c3                   	ret    

80106c8a <idtinit>:

void
idtinit(void)
{
80106c8a:	55                   	push   %ebp
80106c8b:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106c8d:	68 00 08 00 00       	push   $0x800
80106c92:	68 20 30 11 80       	push   $0x80113020
80106c97:	e8 3d fe ff ff       	call   80106ad9 <lidt>
80106c9c:	83 c4 08             	add    $0x8,%esp
}
80106c9f:	90                   	nop
80106ca0:	c9                   	leave  
80106ca1:	c3                   	ret    

80106ca2 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106ca2:	55                   	push   %ebp
80106ca3:	89 e5                	mov    %esp,%ebp
80106ca5:	57                   	push   %edi
80106ca6:	56                   	push   %esi
80106ca7:	53                   	push   %ebx
80106ca8:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106cab:	8b 45 08             	mov    0x8(%ebp),%eax
80106cae:	8b 40 30             	mov    0x30(%eax),%eax
80106cb1:	83 f8 40             	cmp    $0x40,%eax
80106cb4:	75 3e                	jne    80106cf4 <trap+0x52>
    if(proc->killed)
80106cb6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cbc:	8b 40 24             	mov    0x24(%eax),%eax
80106cbf:	85 c0                	test   %eax,%eax
80106cc1:	74 05                	je     80106cc8 <trap+0x26>
      exit();
80106cc3:	e8 36 dd ff ff       	call   801049fe <exit>
    proc->tf = tf;
80106cc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cce:	8b 55 08             	mov    0x8(%ebp),%edx
80106cd1:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106cd4:	e8 7b ea ff ff       	call   80105754 <syscall>
    if(proc->killed)
80106cd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cdf:	8b 40 24             	mov    0x24(%eax),%eax
80106ce2:	85 c0                	test   %eax,%eax
80106ce4:	0f 84 1b 02 00 00    	je     80106f05 <trap+0x263>
      exit();
80106cea:	e8 0f dd ff ff       	call   801049fe <exit>
    return;
80106cef:	e9 11 02 00 00       	jmp    80106f05 <trap+0x263>
  }

  switch(tf->trapno){
80106cf4:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf7:	8b 40 30             	mov    0x30(%eax),%eax
80106cfa:	83 e8 20             	sub    $0x20,%eax
80106cfd:	83 f8 1f             	cmp    $0x1f,%eax
80106d00:	0f 87 c0 00 00 00    	ja     80106dc6 <trap+0x124>
80106d06:	8b 04 85 cc 98 10 80 	mov    -0x7fef6734(,%eax,4),%eax
80106d0d:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106d0f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106d15:	0f b6 00             	movzbl (%eax),%eax
80106d18:	84 c0                	test   %al,%al
80106d1a:	75 3d                	jne    80106d59 <trap+0xb7>
      acquire(&tickslock);
80106d1c:	83 ec 0c             	sub    $0xc,%esp
80106d1f:	68 e0 2f 11 80       	push   $0x80112fe0
80106d24:	e8 ed e3 ff ff       	call   80105116 <acquire>
80106d29:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106d2c:	a1 20 38 11 80       	mov    0x80113820,%eax
80106d31:	83 c0 01             	add    $0x1,%eax
80106d34:	a3 20 38 11 80       	mov    %eax,0x80113820
      wakeup(&ticks);
80106d39:	83 ec 0c             	sub    $0xc,%esp
80106d3c:	68 20 38 11 80       	push   $0x80113820
80106d41:	e8 c2 e1 ff ff       	call   80104f08 <wakeup>
80106d46:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106d49:	83 ec 0c             	sub    $0xc,%esp
80106d4c:	68 e0 2f 11 80       	push   $0x80112fe0
80106d51:	e8 27 e4 ff ff       	call   8010517d <release>
80106d56:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106d59:	e8 58 c7 ff ff       	call   801034b6 <lapiceoi>
    break;
80106d5e:	e9 1c 01 00 00       	jmp    80106e7f <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106d63:	e8 7e bf ff ff       	call   80102ce6 <ideintr>
    lapiceoi();
80106d68:	e8 49 c7 ff ff       	call   801034b6 <lapiceoi>
    break;
80106d6d:	e9 0d 01 00 00       	jmp    80106e7f <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106d72:	e8 5e c5 ff ff       	call   801032d5 <kbdintr>
    lapiceoi();
80106d77:	e8 3a c7 ff ff       	call   801034b6 <lapiceoi>
    break;
80106d7c:	e9 fe 00 00 00       	jmp    80106e7f <trap+0x1dd>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106d81:	e8 60 03 00 00       	call   801070e6 <uartintr>
    lapiceoi();
80106d86:	e8 2b c7 ff ff       	call   801034b6 <lapiceoi>
    break;
80106d8b:	e9 ef 00 00 00       	jmp    80106e7f <trap+0x1dd>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106d90:	8b 45 08             	mov    0x8(%ebp),%eax
80106d93:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106d96:	8b 45 08             	mov    0x8(%ebp),%eax
80106d99:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106d9d:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106da0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106da6:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106da9:	0f b6 c0             	movzbl %al,%eax
80106dac:	51                   	push   %ecx
80106dad:	52                   	push   %edx
80106dae:	50                   	push   %eax
80106daf:	68 2c 98 10 80       	push   $0x8010982c
80106db4:	e8 29 96 ff ff       	call   801003e2 <cprintf>
80106db9:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106dbc:	e8 f5 c6 ff ff       	call   801034b6 <lapiceoi>
    break;
80106dc1:	e9 b9 00 00 00       	jmp    80106e7f <trap+0x1dd>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106dc6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106dcc:	85 c0                	test   %eax,%eax
80106dce:	74 11                	je     80106de1 <trap+0x13f>
80106dd0:	8b 45 08             	mov    0x8(%ebp),%eax
80106dd3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106dd7:	0f b7 c0             	movzwl %ax,%eax
80106dda:	83 e0 03             	and    $0x3,%eax
80106ddd:	85 c0                	test   %eax,%eax
80106ddf:	75 40                	jne    80106e21 <trap+0x17f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106de1:	e8 1d fd ff ff       	call   80106b03 <rcr2>
80106de6:	89 c3                	mov    %eax,%ebx
80106de8:	8b 45 08             	mov    0x8(%ebp),%eax
80106deb:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106dee:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106df4:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106df7:	0f b6 d0             	movzbl %al,%edx
80106dfa:	8b 45 08             	mov    0x8(%ebp),%eax
80106dfd:	8b 40 30             	mov    0x30(%eax),%eax
80106e00:	83 ec 0c             	sub    $0xc,%esp
80106e03:	53                   	push   %ebx
80106e04:	51                   	push   %ecx
80106e05:	52                   	push   %edx
80106e06:	50                   	push   %eax
80106e07:	68 50 98 10 80       	push   $0x80109850
80106e0c:	e8 d1 95 ff ff       	call   801003e2 <cprintf>
80106e11:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106e14:	83 ec 0c             	sub    $0xc,%esp
80106e17:	68 82 98 10 80       	push   $0x80109882
80106e1c:	e8 61 97 ff ff       	call   80100582 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e21:	e8 dd fc ff ff       	call   80106b03 <rcr2>
80106e26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e29:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2c:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106e2f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106e35:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e38:	0f b6 d8             	movzbl %al,%ebx
80106e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e3e:	8b 48 34             	mov    0x34(%eax),%ecx
80106e41:	8b 45 08             	mov    0x8(%ebp),%eax
80106e44:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106e47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e4d:	8d 78 6c             	lea    0x6c(%eax),%edi
80106e50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e56:	8b 40 10             	mov    0x10(%eax),%eax
80106e59:	ff 75 e4             	pushl  -0x1c(%ebp)
80106e5c:	56                   	push   %esi
80106e5d:	53                   	push   %ebx
80106e5e:	51                   	push   %ecx
80106e5f:	52                   	push   %edx
80106e60:	57                   	push   %edi
80106e61:	50                   	push   %eax
80106e62:	68 88 98 10 80       	push   $0x80109888
80106e67:	e8 76 95 ff ff       	call   801003e2 <cprintf>
80106e6c:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106e6f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e75:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106e7c:	eb 01                	jmp    80106e7f <trap+0x1dd>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106e7e:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106e7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e85:	85 c0                	test   %eax,%eax
80106e87:	74 24                	je     80106ead <trap+0x20b>
80106e89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e8f:	8b 40 24             	mov    0x24(%eax),%eax
80106e92:	85 c0                	test   %eax,%eax
80106e94:	74 17                	je     80106ead <trap+0x20b>
80106e96:	8b 45 08             	mov    0x8(%ebp),%eax
80106e99:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106e9d:	0f b7 c0             	movzwl %ax,%eax
80106ea0:	83 e0 03             	and    $0x3,%eax
80106ea3:	83 f8 03             	cmp    $0x3,%eax
80106ea6:	75 05                	jne    80106ead <trap+0x20b>
    exit();
80106ea8:	e8 51 db ff ff       	call   801049fe <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106ead:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106eb3:	85 c0                	test   %eax,%eax
80106eb5:	74 1e                	je     80106ed5 <trap+0x233>
80106eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ebd:	8b 40 0c             	mov    0xc(%eax),%eax
80106ec0:	83 f8 04             	cmp    $0x4,%eax
80106ec3:	75 10                	jne    80106ed5 <trap+0x233>
80106ec5:	8b 45 08             	mov    0x8(%ebp),%eax
80106ec8:	8b 40 30             	mov    0x30(%eax),%eax
80106ecb:	83 f8 20             	cmp    $0x20,%eax
80106ece:	75 05                	jne    80106ed5 <trap+0x233>
    yield();
80106ed0:	e8 dc de ff ff       	call   80104db1 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106ed5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106edb:	85 c0                	test   %eax,%eax
80106edd:	74 27                	je     80106f06 <trap+0x264>
80106edf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ee5:	8b 40 24             	mov    0x24(%eax),%eax
80106ee8:	85 c0                	test   %eax,%eax
80106eea:	74 1a                	je     80106f06 <trap+0x264>
80106eec:	8b 45 08             	mov    0x8(%ebp),%eax
80106eef:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ef3:	0f b7 c0             	movzwl %ax,%eax
80106ef6:	83 e0 03             	and    $0x3,%eax
80106ef9:	83 f8 03             	cmp    $0x3,%eax
80106efc:	75 08                	jne    80106f06 <trap+0x264>
    exit();
80106efe:	e8 fb da ff ff       	call   801049fe <exit>
80106f03:	eb 01                	jmp    80106f06 <trap+0x264>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106f05:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106f06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f09:	5b                   	pop    %ebx
80106f0a:	5e                   	pop    %esi
80106f0b:	5f                   	pop    %edi
80106f0c:	5d                   	pop    %ebp
80106f0d:	c3                   	ret    

80106f0e <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106f0e:	55                   	push   %ebp
80106f0f:	89 e5                	mov    %esp,%ebp
80106f11:	83 ec 14             	sub    $0x14,%esp
80106f14:	8b 45 08             	mov    0x8(%ebp),%eax
80106f17:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f1b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106f1f:	89 c2                	mov    %eax,%edx
80106f21:	ec                   	in     (%dx),%al
80106f22:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106f25:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106f29:	c9                   	leave  
80106f2a:	c3                   	ret    

80106f2b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106f2b:	55                   	push   %ebp
80106f2c:	89 e5                	mov    %esp,%ebp
80106f2e:	83 ec 08             	sub    $0x8,%esp
80106f31:	8b 55 08             	mov    0x8(%ebp),%edx
80106f34:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f37:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106f3b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106f3e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106f42:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106f46:	ee                   	out    %al,(%dx)
}
80106f47:	90                   	nop
80106f48:	c9                   	leave  
80106f49:	c3                   	ret    

80106f4a <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106f4a:	55                   	push   %ebp
80106f4b:	89 e5                	mov    %esp,%ebp
80106f4d:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106f50:	6a 00                	push   $0x0
80106f52:	68 fa 03 00 00       	push   $0x3fa
80106f57:	e8 cf ff ff ff       	call   80106f2b <outb>
80106f5c:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106f5f:	68 80 00 00 00       	push   $0x80
80106f64:	68 fb 03 00 00       	push   $0x3fb
80106f69:	e8 bd ff ff ff       	call   80106f2b <outb>
80106f6e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106f71:	6a 0c                	push   $0xc
80106f73:	68 f8 03 00 00       	push   $0x3f8
80106f78:	e8 ae ff ff ff       	call   80106f2b <outb>
80106f7d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106f80:	6a 00                	push   $0x0
80106f82:	68 f9 03 00 00       	push   $0x3f9
80106f87:	e8 9f ff ff ff       	call   80106f2b <outb>
80106f8c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106f8f:	6a 03                	push   $0x3
80106f91:	68 fb 03 00 00       	push   $0x3fb
80106f96:	e8 90 ff ff ff       	call   80106f2b <outb>
80106f9b:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106f9e:	6a 00                	push   $0x0
80106fa0:	68 fc 03 00 00       	push   $0x3fc
80106fa5:	e8 81 ff ff ff       	call   80106f2b <outb>
80106faa:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106fad:	6a 01                	push   $0x1
80106faf:	68 f9 03 00 00       	push   $0x3f9
80106fb4:	e8 72 ff ff ff       	call   80106f2b <outb>
80106fb9:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106fbc:	68 fd 03 00 00       	push   $0x3fd
80106fc1:	e8 48 ff ff ff       	call   80106f0e <inb>
80106fc6:	83 c4 04             	add    $0x4,%esp
80106fc9:	3c ff                	cmp    $0xff,%al
80106fcb:	74 6e                	je     8010703b <uartinit+0xf1>
    return;
  uart = 1;
80106fcd:	c7 05 8c c6 10 80 01 	movl   $0x1,0x8010c68c
80106fd4:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106fd7:	68 fa 03 00 00       	push   $0x3fa
80106fdc:	e8 2d ff ff ff       	call   80106f0e <inb>
80106fe1:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106fe4:	68 f8 03 00 00       	push   $0x3f8
80106fe9:	e8 20 ff ff ff       	call   80106f0e <inb>
80106fee:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106ff1:	83 ec 0c             	sub    $0xc,%esp
80106ff4:	6a 04                	push   $0x4
80106ff6:	e8 86 d0 ff ff       	call   80104081 <picenable>
80106ffb:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106ffe:	83 ec 08             	sub    $0x8,%esp
80107001:	6a 00                	push   $0x0
80107003:	6a 04                	push   $0x4
80107005:	e8 7e bf ff ff       	call   80102f88 <ioapicenable>
8010700a:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010700d:	c7 45 f4 4c 99 10 80 	movl   $0x8010994c,-0xc(%ebp)
80107014:	eb 19                	jmp    8010702f <uartinit+0xe5>
    uartputc(*p);
80107016:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107019:	0f b6 00             	movzbl (%eax),%eax
8010701c:	0f be c0             	movsbl %al,%eax
8010701f:	83 ec 0c             	sub    $0xc,%esp
80107022:	50                   	push   %eax
80107023:	e8 16 00 00 00       	call   8010703e <uartputc>
80107028:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010702b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010702f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107032:	0f b6 00             	movzbl (%eax),%eax
80107035:	84 c0                	test   %al,%al
80107037:	75 dd                	jne    80107016 <uartinit+0xcc>
80107039:	eb 01                	jmp    8010703c <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
8010703b:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
8010703c:	c9                   	leave  
8010703d:	c3                   	ret    

8010703e <uartputc>:

void
uartputc(int c)
{
8010703e:	55                   	push   %ebp
8010703f:	89 e5                	mov    %esp,%ebp
80107041:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80107044:	a1 8c c6 10 80       	mov    0x8010c68c,%eax
80107049:	85 c0                	test   %eax,%eax
8010704b:	74 53                	je     801070a0 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010704d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107054:	eb 11                	jmp    80107067 <uartputc+0x29>
    microdelay(10);
80107056:	83 ec 0c             	sub    $0xc,%esp
80107059:	6a 0a                	push   $0xa
8010705b:	e8 71 c4 ff ff       	call   801034d1 <microdelay>
80107060:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107063:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107067:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
8010706b:	7f 1a                	jg     80107087 <uartputc+0x49>
8010706d:	83 ec 0c             	sub    $0xc,%esp
80107070:	68 fd 03 00 00       	push   $0x3fd
80107075:	e8 94 fe ff ff       	call   80106f0e <inb>
8010707a:	83 c4 10             	add    $0x10,%esp
8010707d:	0f b6 c0             	movzbl %al,%eax
80107080:	83 e0 20             	and    $0x20,%eax
80107083:	85 c0                	test   %eax,%eax
80107085:	74 cf                	je     80107056 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80107087:	8b 45 08             	mov    0x8(%ebp),%eax
8010708a:	0f b6 c0             	movzbl %al,%eax
8010708d:	83 ec 08             	sub    $0x8,%esp
80107090:	50                   	push   %eax
80107091:	68 f8 03 00 00       	push   $0x3f8
80107096:	e8 90 fe ff ff       	call   80106f2b <outb>
8010709b:	83 c4 10             	add    $0x10,%esp
8010709e:	eb 01                	jmp    801070a1 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
801070a0:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
801070a1:	c9                   	leave  
801070a2:	c3                   	ret    

801070a3 <uartgetc>:

static int
uartgetc(void)
{
801070a3:	55                   	push   %ebp
801070a4:	89 e5                	mov    %esp,%ebp
  if(!uart)
801070a6:	a1 8c c6 10 80       	mov    0x8010c68c,%eax
801070ab:	85 c0                	test   %eax,%eax
801070ad:	75 07                	jne    801070b6 <uartgetc+0x13>
    return -1;
801070af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070b4:	eb 2e                	jmp    801070e4 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
801070b6:	68 fd 03 00 00       	push   $0x3fd
801070bb:	e8 4e fe ff ff       	call   80106f0e <inb>
801070c0:	83 c4 04             	add    $0x4,%esp
801070c3:	0f b6 c0             	movzbl %al,%eax
801070c6:	83 e0 01             	and    $0x1,%eax
801070c9:	85 c0                	test   %eax,%eax
801070cb:	75 07                	jne    801070d4 <uartgetc+0x31>
    return -1;
801070cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070d2:	eb 10                	jmp    801070e4 <uartgetc+0x41>
  return inb(COM1+0);
801070d4:	68 f8 03 00 00       	push   $0x3f8
801070d9:	e8 30 fe ff ff       	call   80106f0e <inb>
801070de:	83 c4 04             	add    $0x4,%esp
801070e1:	0f b6 c0             	movzbl %al,%eax
}
801070e4:	c9                   	leave  
801070e5:	c3                   	ret    

801070e6 <uartintr>:

void
uartintr(void)
{
801070e6:	55                   	push   %ebp
801070e7:	89 e5                	mov    %esp,%ebp
801070e9:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
801070ec:	83 ec 0c             	sub    $0xc,%esp
801070ef:	68 a3 70 10 80       	push   $0x801070a3
801070f4:	e8 98 97 ff ff       	call   80100891 <consoleintr>
801070f9:	83 c4 10             	add    $0x10,%esp
}
801070fc:	90                   	nop
801070fd:	c9                   	leave  
801070fe:	c3                   	ret    

801070ff <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $0
80107101:	6a 00                	push   $0x0
  jmp alltraps
80107103:	e9 a6 f9 ff ff       	jmp    80106aae <alltraps>

80107108 <vector1>:
.globl vector1
vector1:
  pushl $0
80107108:	6a 00                	push   $0x0
  pushl $1
8010710a:	6a 01                	push   $0x1
  jmp alltraps
8010710c:	e9 9d f9 ff ff       	jmp    80106aae <alltraps>

80107111 <vector2>:
.globl vector2
vector2:
  pushl $0
80107111:	6a 00                	push   $0x0
  pushl $2
80107113:	6a 02                	push   $0x2
  jmp alltraps
80107115:	e9 94 f9 ff ff       	jmp    80106aae <alltraps>

8010711a <vector3>:
.globl vector3
vector3:
  pushl $0
8010711a:	6a 00                	push   $0x0
  pushl $3
8010711c:	6a 03                	push   $0x3
  jmp alltraps
8010711e:	e9 8b f9 ff ff       	jmp    80106aae <alltraps>

80107123 <vector4>:
.globl vector4
vector4:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $4
80107125:	6a 04                	push   $0x4
  jmp alltraps
80107127:	e9 82 f9 ff ff       	jmp    80106aae <alltraps>

8010712c <vector5>:
.globl vector5
vector5:
  pushl $0
8010712c:	6a 00                	push   $0x0
  pushl $5
8010712e:	6a 05                	push   $0x5
  jmp alltraps
80107130:	e9 79 f9 ff ff       	jmp    80106aae <alltraps>

80107135 <vector6>:
.globl vector6
vector6:
  pushl $0
80107135:	6a 00                	push   $0x0
  pushl $6
80107137:	6a 06                	push   $0x6
  jmp alltraps
80107139:	e9 70 f9 ff ff       	jmp    80106aae <alltraps>

8010713e <vector7>:
.globl vector7
vector7:
  pushl $0
8010713e:	6a 00                	push   $0x0
  pushl $7
80107140:	6a 07                	push   $0x7
  jmp alltraps
80107142:	e9 67 f9 ff ff       	jmp    80106aae <alltraps>

80107147 <vector8>:
.globl vector8
vector8:
  pushl $8
80107147:	6a 08                	push   $0x8
  jmp alltraps
80107149:	e9 60 f9 ff ff       	jmp    80106aae <alltraps>

8010714e <vector9>:
.globl vector9
vector9:
  pushl $0
8010714e:	6a 00                	push   $0x0
  pushl $9
80107150:	6a 09                	push   $0x9
  jmp alltraps
80107152:	e9 57 f9 ff ff       	jmp    80106aae <alltraps>

80107157 <vector10>:
.globl vector10
vector10:
  pushl $10
80107157:	6a 0a                	push   $0xa
  jmp alltraps
80107159:	e9 50 f9 ff ff       	jmp    80106aae <alltraps>

8010715e <vector11>:
.globl vector11
vector11:
  pushl $11
8010715e:	6a 0b                	push   $0xb
  jmp alltraps
80107160:	e9 49 f9 ff ff       	jmp    80106aae <alltraps>

80107165 <vector12>:
.globl vector12
vector12:
  pushl $12
80107165:	6a 0c                	push   $0xc
  jmp alltraps
80107167:	e9 42 f9 ff ff       	jmp    80106aae <alltraps>

8010716c <vector13>:
.globl vector13
vector13:
  pushl $13
8010716c:	6a 0d                	push   $0xd
  jmp alltraps
8010716e:	e9 3b f9 ff ff       	jmp    80106aae <alltraps>

80107173 <vector14>:
.globl vector14
vector14:
  pushl $14
80107173:	6a 0e                	push   $0xe
  jmp alltraps
80107175:	e9 34 f9 ff ff       	jmp    80106aae <alltraps>

8010717a <vector15>:
.globl vector15
vector15:
  pushl $0
8010717a:	6a 00                	push   $0x0
  pushl $15
8010717c:	6a 0f                	push   $0xf
  jmp alltraps
8010717e:	e9 2b f9 ff ff       	jmp    80106aae <alltraps>

80107183 <vector16>:
.globl vector16
vector16:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $16
80107185:	6a 10                	push   $0x10
  jmp alltraps
80107187:	e9 22 f9 ff ff       	jmp    80106aae <alltraps>

8010718c <vector17>:
.globl vector17
vector17:
  pushl $17
8010718c:	6a 11                	push   $0x11
  jmp alltraps
8010718e:	e9 1b f9 ff ff       	jmp    80106aae <alltraps>

80107193 <vector18>:
.globl vector18
vector18:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $18
80107195:	6a 12                	push   $0x12
  jmp alltraps
80107197:	e9 12 f9 ff ff       	jmp    80106aae <alltraps>

8010719c <vector19>:
.globl vector19
vector19:
  pushl $0
8010719c:	6a 00                	push   $0x0
  pushl $19
8010719e:	6a 13                	push   $0x13
  jmp alltraps
801071a0:	e9 09 f9 ff ff       	jmp    80106aae <alltraps>

801071a5 <vector20>:
.globl vector20
vector20:
  pushl $0
801071a5:	6a 00                	push   $0x0
  pushl $20
801071a7:	6a 14                	push   $0x14
  jmp alltraps
801071a9:	e9 00 f9 ff ff       	jmp    80106aae <alltraps>

801071ae <vector21>:
.globl vector21
vector21:
  pushl $0
801071ae:	6a 00                	push   $0x0
  pushl $21
801071b0:	6a 15                	push   $0x15
  jmp alltraps
801071b2:	e9 f7 f8 ff ff       	jmp    80106aae <alltraps>

801071b7 <vector22>:
.globl vector22
vector22:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $22
801071b9:	6a 16                	push   $0x16
  jmp alltraps
801071bb:	e9 ee f8 ff ff       	jmp    80106aae <alltraps>

801071c0 <vector23>:
.globl vector23
vector23:
  pushl $0
801071c0:	6a 00                	push   $0x0
  pushl $23
801071c2:	6a 17                	push   $0x17
  jmp alltraps
801071c4:	e9 e5 f8 ff ff       	jmp    80106aae <alltraps>

801071c9 <vector24>:
.globl vector24
vector24:
  pushl $0
801071c9:	6a 00                	push   $0x0
  pushl $24
801071cb:	6a 18                	push   $0x18
  jmp alltraps
801071cd:	e9 dc f8 ff ff       	jmp    80106aae <alltraps>

801071d2 <vector25>:
.globl vector25
vector25:
  pushl $0
801071d2:	6a 00                	push   $0x0
  pushl $25
801071d4:	6a 19                	push   $0x19
  jmp alltraps
801071d6:	e9 d3 f8 ff ff       	jmp    80106aae <alltraps>

801071db <vector26>:
.globl vector26
vector26:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $26
801071dd:	6a 1a                	push   $0x1a
  jmp alltraps
801071df:	e9 ca f8 ff ff       	jmp    80106aae <alltraps>

801071e4 <vector27>:
.globl vector27
vector27:
  pushl $0
801071e4:	6a 00                	push   $0x0
  pushl $27
801071e6:	6a 1b                	push   $0x1b
  jmp alltraps
801071e8:	e9 c1 f8 ff ff       	jmp    80106aae <alltraps>

801071ed <vector28>:
.globl vector28
vector28:
  pushl $0
801071ed:	6a 00                	push   $0x0
  pushl $28
801071ef:	6a 1c                	push   $0x1c
  jmp alltraps
801071f1:	e9 b8 f8 ff ff       	jmp    80106aae <alltraps>

801071f6 <vector29>:
.globl vector29
vector29:
  pushl $0
801071f6:	6a 00                	push   $0x0
  pushl $29
801071f8:	6a 1d                	push   $0x1d
  jmp alltraps
801071fa:	e9 af f8 ff ff       	jmp    80106aae <alltraps>

801071ff <vector30>:
.globl vector30
vector30:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $30
80107201:	6a 1e                	push   $0x1e
  jmp alltraps
80107203:	e9 a6 f8 ff ff       	jmp    80106aae <alltraps>

80107208 <vector31>:
.globl vector31
vector31:
  pushl $0
80107208:	6a 00                	push   $0x0
  pushl $31
8010720a:	6a 1f                	push   $0x1f
  jmp alltraps
8010720c:	e9 9d f8 ff ff       	jmp    80106aae <alltraps>

80107211 <vector32>:
.globl vector32
vector32:
  pushl $0
80107211:	6a 00                	push   $0x0
  pushl $32
80107213:	6a 20                	push   $0x20
  jmp alltraps
80107215:	e9 94 f8 ff ff       	jmp    80106aae <alltraps>

8010721a <vector33>:
.globl vector33
vector33:
  pushl $0
8010721a:	6a 00                	push   $0x0
  pushl $33
8010721c:	6a 21                	push   $0x21
  jmp alltraps
8010721e:	e9 8b f8 ff ff       	jmp    80106aae <alltraps>

80107223 <vector34>:
.globl vector34
vector34:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $34
80107225:	6a 22                	push   $0x22
  jmp alltraps
80107227:	e9 82 f8 ff ff       	jmp    80106aae <alltraps>

8010722c <vector35>:
.globl vector35
vector35:
  pushl $0
8010722c:	6a 00                	push   $0x0
  pushl $35
8010722e:	6a 23                	push   $0x23
  jmp alltraps
80107230:	e9 79 f8 ff ff       	jmp    80106aae <alltraps>

80107235 <vector36>:
.globl vector36
vector36:
  pushl $0
80107235:	6a 00                	push   $0x0
  pushl $36
80107237:	6a 24                	push   $0x24
  jmp alltraps
80107239:	e9 70 f8 ff ff       	jmp    80106aae <alltraps>

8010723e <vector37>:
.globl vector37
vector37:
  pushl $0
8010723e:	6a 00                	push   $0x0
  pushl $37
80107240:	6a 25                	push   $0x25
  jmp alltraps
80107242:	e9 67 f8 ff ff       	jmp    80106aae <alltraps>

80107247 <vector38>:
.globl vector38
vector38:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $38
80107249:	6a 26                	push   $0x26
  jmp alltraps
8010724b:	e9 5e f8 ff ff       	jmp    80106aae <alltraps>

80107250 <vector39>:
.globl vector39
vector39:
  pushl $0
80107250:	6a 00                	push   $0x0
  pushl $39
80107252:	6a 27                	push   $0x27
  jmp alltraps
80107254:	e9 55 f8 ff ff       	jmp    80106aae <alltraps>

80107259 <vector40>:
.globl vector40
vector40:
  pushl $0
80107259:	6a 00                	push   $0x0
  pushl $40
8010725b:	6a 28                	push   $0x28
  jmp alltraps
8010725d:	e9 4c f8 ff ff       	jmp    80106aae <alltraps>

80107262 <vector41>:
.globl vector41
vector41:
  pushl $0
80107262:	6a 00                	push   $0x0
  pushl $41
80107264:	6a 29                	push   $0x29
  jmp alltraps
80107266:	e9 43 f8 ff ff       	jmp    80106aae <alltraps>

8010726b <vector42>:
.globl vector42
vector42:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $42
8010726d:	6a 2a                	push   $0x2a
  jmp alltraps
8010726f:	e9 3a f8 ff ff       	jmp    80106aae <alltraps>

80107274 <vector43>:
.globl vector43
vector43:
  pushl $0
80107274:	6a 00                	push   $0x0
  pushl $43
80107276:	6a 2b                	push   $0x2b
  jmp alltraps
80107278:	e9 31 f8 ff ff       	jmp    80106aae <alltraps>

8010727d <vector44>:
.globl vector44
vector44:
  pushl $0
8010727d:	6a 00                	push   $0x0
  pushl $44
8010727f:	6a 2c                	push   $0x2c
  jmp alltraps
80107281:	e9 28 f8 ff ff       	jmp    80106aae <alltraps>

80107286 <vector45>:
.globl vector45
vector45:
  pushl $0
80107286:	6a 00                	push   $0x0
  pushl $45
80107288:	6a 2d                	push   $0x2d
  jmp alltraps
8010728a:	e9 1f f8 ff ff       	jmp    80106aae <alltraps>

8010728f <vector46>:
.globl vector46
vector46:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $46
80107291:	6a 2e                	push   $0x2e
  jmp alltraps
80107293:	e9 16 f8 ff ff       	jmp    80106aae <alltraps>

80107298 <vector47>:
.globl vector47
vector47:
  pushl $0
80107298:	6a 00                	push   $0x0
  pushl $47
8010729a:	6a 2f                	push   $0x2f
  jmp alltraps
8010729c:	e9 0d f8 ff ff       	jmp    80106aae <alltraps>

801072a1 <vector48>:
.globl vector48
vector48:
  pushl $0
801072a1:	6a 00                	push   $0x0
  pushl $48
801072a3:	6a 30                	push   $0x30
  jmp alltraps
801072a5:	e9 04 f8 ff ff       	jmp    80106aae <alltraps>

801072aa <vector49>:
.globl vector49
vector49:
  pushl $0
801072aa:	6a 00                	push   $0x0
  pushl $49
801072ac:	6a 31                	push   $0x31
  jmp alltraps
801072ae:	e9 fb f7 ff ff       	jmp    80106aae <alltraps>

801072b3 <vector50>:
.globl vector50
vector50:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $50
801072b5:	6a 32                	push   $0x32
  jmp alltraps
801072b7:	e9 f2 f7 ff ff       	jmp    80106aae <alltraps>

801072bc <vector51>:
.globl vector51
vector51:
  pushl $0
801072bc:	6a 00                	push   $0x0
  pushl $51
801072be:	6a 33                	push   $0x33
  jmp alltraps
801072c0:	e9 e9 f7 ff ff       	jmp    80106aae <alltraps>

801072c5 <vector52>:
.globl vector52
vector52:
  pushl $0
801072c5:	6a 00                	push   $0x0
  pushl $52
801072c7:	6a 34                	push   $0x34
  jmp alltraps
801072c9:	e9 e0 f7 ff ff       	jmp    80106aae <alltraps>

801072ce <vector53>:
.globl vector53
vector53:
  pushl $0
801072ce:	6a 00                	push   $0x0
  pushl $53
801072d0:	6a 35                	push   $0x35
  jmp alltraps
801072d2:	e9 d7 f7 ff ff       	jmp    80106aae <alltraps>

801072d7 <vector54>:
.globl vector54
vector54:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $54
801072d9:	6a 36                	push   $0x36
  jmp alltraps
801072db:	e9 ce f7 ff ff       	jmp    80106aae <alltraps>

801072e0 <vector55>:
.globl vector55
vector55:
  pushl $0
801072e0:	6a 00                	push   $0x0
  pushl $55
801072e2:	6a 37                	push   $0x37
  jmp alltraps
801072e4:	e9 c5 f7 ff ff       	jmp    80106aae <alltraps>

801072e9 <vector56>:
.globl vector56
vector56:
  pushl $0
801072e9:	6a 00                	push   $0x0
  pushl $56
801072eb:	6a 38                	push   $0x38
  jmp alltraps
801072ed:	e9 bc f7 ff ff       	jmp    80106aae <alltraps>

801072f2 <vector57>:
.globl vector57
vector57:
  pushl $0
801072f2:	6a 00                	push   $0x0
  pushl $57
801072f4:	6a 39                	push   $0x39
  jmp alltraps
801072f6:	e9 b3 f7 ff ff       	jmp    80106aae <alltraps>

801072fb <vector58>:
.globl vector58
vector58:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $58
801072fd:	6a 3a                	push   $0x3a
  jmp alltraps
801072ff:	e9 aa f7 ff ff       	jmp    80106aae <alltraps>

80107304 <vector59>:
.globl vector59
vector59:
  pushl $0
80107304:	6a 00                	push   $0x0
  pushl $59
80107306:	6a 3b                	push   $0x3b
  jmp alltraps
80107308:	e9 a1 f7 ff ff       	jmp    80106aae <alltraps>

8010730d <vector60>:
.globl vector60
vector60:
  pushl $0
8010730d:	6a 00                	push   $0x0
  pushl $60
8010730f:	6a 3c                	push   $0x3c
  jmp alltraps
80107311:	e9 98 f7 ff ff       	jmp    80106aae <alltraps>

80107316 <vector61>:
.globl vector61
vector61:
  pushl $0
80107316:	6a 00                	push   $0x0
  pushl $61
80107318:	6a 3d                	push   $0x3d
  jmp alltraps
8010731a:	e9 8f f7 ff ff       	jmp    80106aae <alltraps>

8010731f <vector62>:
.globl vector62
vector62:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $62
80107321:	6a 3e                	push   $0x3e
  jmp alltraps
80107323:	e9 86 f7 ff ff       	jmp    80106aae <alltraps>

80107328 <vector63>:
.globl vector63
vector63:
  pushl $0
80107328:	6a 00                	push   $0x0
  pushl $63
8010732a:	6a 3f                	push   $0x3f
  jmp alltraps
8010732c:	e9 7d f7 ff ff       	jmp    80106aae <alltraps>

80107331 <vector64>:
.globl vector64
vector64:
  pushl $0
80107331:	6a 00                	push   $0x0
  pushl $64
80107333:	6a 40                	push   $0x40
  jmp alltraps
80107335:	e9 74 f7 ff ff       	jmp    80106aae <alltraps>

8010733a <vector65>:
.globl vector65
vector65:
  pushl $0
8010733a:	6a 00                	push   $0x0
  pushl $65
8010733c:	6a 41                	push   $0x41
  jmp alltraps
8010733e:	e9 6b f7 ff ff       	jmp    80106aae <alltraps>

80107343 <vector66>:
.globl vector66
vector66:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $66
80107345:	6a 42                	push   $0x42
  jmp alltraps
80107347:	e9 62 f7 ff ff       	jmp    80106aae <alltraps>

8010734c <vector67>:
.globl vector67
vector67:
  pushl $0
8010734c:	6a 00                	push   $0x0
  pushl $67
8010734e:	6a 43                	push   $0x43
  jmp alltraps
80107350:	e9 59 f7 ff ff       	jmp    80106aae <alltraps>

80107355 <vector68>:
.globl vector68
vector68:
  pushl $0
80107355:	6a 00                	push   $0x0
  pushl $68
80107357:	6a 44                	push   $0x44
  jmp alltraps
80107359:	e9 50 f7 ff ff       	jmp    80106aae <alltraps>

8010735e <vector69>:
.globl vector69
vector69:
  pushl $0
8010735e:	6a 00                	push   $0x0
  pushl $69
80107360:	6a 45                	push   $0x45
  jmp alltraps
80107362:	e9 47 f7 ff ff       	jmp    80106aae <alltraps>

80107367 <vector70>:
.globl vector70
vector70:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $70
80107369:	6a 46                	push   $0x46
  jmp alltraps
8010736b:	e9 3e f7 ff ff       	jmp    80106aae <alltraps>

80107370 <vector71>:
.globl vector71
vector71:
  pushl $0
80107370:	6a 00                	push   $0x0
  pushl $71
80107372:	6a 47                	push   $0x47
  jmp alltraps
80107374:	e9 35 f7 ff ff       	jmp    80106aae <alltraps>

80107379 <vector72>:
.globl vector72
vector72:
  pushl $0
80107379:	6a 00                	push   $0x0
  pushl $72
8010737b:	6a 48                	push   $0x48
  jmp alltraps
8010737d:	e9 2c f7 ff ff       	jmp    80106aae <alltraps>

80107382 <vector73>:
.globl vector73
vector73:
  pushl $0
80107382:	6a 00                	push   $0x0
  pushl $73
80107384:	6a 49                	push   $0x49
  jmp alltraps
80107386:	e9 23 f7 ff ff       	jmp    80106aae <alltraps>

8010738b <vector74>:
.globl vector74
vector74:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $74
8010738d:	6a 4a                	push   $0x4a
  jmp alltraps
8010738f:	e9 1a f7 ff ff       	jmp    80106aae <alltraps>

80107394 <vector75>:
.globl vector75
vector75:
  pushl $0
80107394:	6a 00                	push   $0x0
  pushl $75
80107396:	6a 4b                	push   $0x4b
  jmp alltraps
80107398:	e9 11 f7 ff ff       	jmp    80106aae <alltraps>

8010739d <vector76>:
.globl vector76
vector76:
  pushl $0
8010739d:	6a 00                	push   $0x0
  pushl $76
8010739f:	6a 4c                	push   $0x4c
  jmp alltraps
801073a1:	e9 08 f7 ff ff       	jmp    80106aae <alltraps>

801073a6 <vector77>:
.globl vector77
vector77:
  pushl $0
801073a6:	6a 00                	push   $0x0
  pushl $77
801073a8:	6a 4d                	push   $0x4d
  jmp alltraps
801073aa:	e9 ff f6 ff ff       	jmp    80106aae <alltraps>

801073af <vector78>:
.globl vector78
vector78:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $78
801073b1:	6a 4e                	push   $0x4e
  jmp alltraps
801073b3:	e9 f6 f6 ff ff       	jmp    80106aae <alltraps>

801073b8 <vector79>:
.globl vector79
vector79:
  pushl $0
801073b8:	6a 00                	push   $0x0
  pushl $79
801073ba:	6a 4f                	push   $0x4f
  jmp alltraps
801073bc:	e9 ed f6 ff ff       	jmp    80106aae <alltraps>

801073c1 <vector80>:
.globl vector80
vector80:
  pushl $0
801073c1:	6a 00                	push   $0x0
  pushl $80
801073c3:	6a 50                	push   $0x50
  jmp alltraps
801073c5:	e9 e4 f6 ff ff       	jmp    80106aae <alltraps>

801073ca <vector81>:
.globl vector81
vector81:
  pushl $0
801073ca:	6a 00                	push   $0x0
  pushl $81
801073cc:	6a 51                	push   $0x51
  jmp alltraps
801073ce:	e9 db f6 ff ff       	jmp    80106aae <alltraps>

801073d3 <vector82>:
.globl vector82
vector82:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $82
801073d5:	6a 52                	push   $0x52
  jmp alltraps
801073d7:	e9 d2 f6 ff ff       	jmp    80106aae <alltraps>

801073dc <vector83>:
.globl vector83
vector83:
  pushl $0
801073dc:	6a 00                	push   $0x0
  pushl $83
801073de:	6a 53                	push   $0x53
  jmp alltraps
801073e0:	e9 c9 f6 ff ff       	jmp    80106aae <alltraps>

801073e5 <vector84>:
.globl vector84
vector84:
  pushl $0
801073e5:	6a 00                	push   $0x0
  pushl $84
801073e7:	6a 54                	push   $0x54
  jmp alltraps
801073e9:	e9 c0 f6 ff ff       	jmp    80106aae <alltraps>

801073ee <vector85>:
.globl vector85
vector85:
  pushl $0
801073ee:	6a 00                	push   $0x0
  pushl $85
801073f0:	6a 55                	push   $0x55
  jmp alltraps
801073f2:	e9 b7 f6 ff ff       	jmp    80106aae <alltraps>

801073f7 <vector86>:
.globl vector86
vector86:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $86
801073f9:	6a 56                	push   $0x56
  jmp alltraps
801073fb:	e9 ae f6 ff ff       	jmp    80106aae <alltraps>

80107400 <vector87>:
.globl vector87
vector87:
  pushl $0
80107400:	6a 00                	push   $0x0
  pushl $87
80107402:	6a 57                	push   $0x57
  jmp alltraps
80107404:	e9 a5 f6 ff ff       	jmp    80106aae <alltraps>

80107409 <vector88>:
.globl vector88
vector88:
  pushl $0
80107409:	6a 00                	push   $0x0
  pushl $88
8010740b:	6a 58                	push   $0x58
  jmp alltraps
8010740d:	e9 9c f6 ff ff       	jmp    80106aae <alltraps>

80107412 <vector89>:
.globl vector89
vector89:
  pushl $0
80107412:	6a 00                	push   $0x0
  pushl $89
80107414:	6a 59                	push   $0x59
  jmp alltraps
80107416:	e9 93 f6 ff ff       	jmp    80106aae <alltraps>

8010741b <vector90>:
.globl vector90
vector90:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $90
8010741d:	6a 5a                	push   $0x5a
  jmp alltraps
8010741f:	e9 8a f6 ff ff       	jmp    80106aae <alltraps>

80107424 <vector91>:
.globl vector91
vector91:
  pushl $0
80107424:	6a 00                	push   $0x0
  pushl $91
80107426:	6a 5b                	push   $0x5b
  jmp alltraps
80107428:	e9 81 f6 ff ff       	jmp    80106aae <alltraps>

8010742d <vector92>:
.globl vector92
vector92:
  pushl $0
8010742d:	6a 00                	push   $0x0
  pushl $92
8010742f:	6a 5c                	push   $0x5c
  jmp alltraps
80107431:	e9 78 f6 ff ff       	jmp    80106aae <alltraps>

80107436 <vector93>:
.globl vector93
vector93:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $93
80107438:	6a 5d                	push   $0x5d
  jmp alltraps
8010743a:	e9 6f f6 ff ff       	jmp    80106aae <alltraps>

8010743f <vector94>:
.globl vector94
vector94:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $94
80107441:	6a 5e                	push   $0x5e
  jmp alltraps
80107443:	e9 66 f6 ff ff       	jmp    80106aae <alltraps>

80107448 <vector95>:
.globl vector95
vector95:
  pushl $0
80107448:	6a 00                	push   $0x0
  pushl $95
8010744a:	6a 5f                	push   $0x5f
  jmp alltraps
8010744c:	e9 5d f6 ff ff       	jmp    80106aae <alltraps>

80107451 <vector96>:
.globl vector96
vector96:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $96
80107453:	6a 60                	push   $0x60
  jmp alltraps
80107455:	e9 54 f6 ff ff       	jmp    80106aae <alltraps>

8010745a <vector97>:
.globl vector97
vector97:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $97
8010745c:	6a 61                	push   $0x61
  jmp alltraps
8010745e:	e9 4b f6 ff ff       	jmp    80106aae <alltraps>

80107463 <vector98>:
.globl vector98
vector98:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $98
80107465:	6a 62                	push   $0x62
  jmp alltraps
80107467:	e9 42 f6 ff ff       	jmp    80106aae <alltraps>

8010746c <vector99>:
.globl vector99
vector99:
  pushl $0
8010746c:	6a 00                	push   $0x0
  pushl $99
8010746e:	6a 63                	push   $0x63
  jmp alltraps
80107470:	e9 39 f6 ff ff       	jmp    80106aae <alltraps>

80107475 <vector100>:
.globl vector100
vector100:
  pushl $0
80107475:	6a 00                	push   $0x0
  pushl $100
80107477:	6a 64                	push   $0x64
  jmp alltraps
80107479:	e9 30 f6 ff ff       	jmp    80106aae <alltraps>

8010747e <vector101>:
.globl vector101
vector101:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $101
80107480:	6a 65                	push   $0x65
  jmp alltraps
80107482:	e9 27 f6 ff ff       	jmp    80106aae <alltraps>

80107487 <vector102>:
.globl vector102
vector102:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $102
80107489:	6a 66                	push   $0x66
  jmp alltraps
8010748b:	e9 1e f6 ff ff       	jmp    80106aae <alltraps>

80107490 <vector103>:
.globl vector103
vector103:
  pushl $0
80107490:	6a 00                	push   $0x0
  pushl $103
80107492:	6a 67                	push   $0x67
  jmp alltraps
80107494:	e9 15 f6 ff ff       	jmp    80106aae <alltraps>

80107499 <vector104>:
.globl vector104
vector104:
  pushl $0
80107499:	6a 00                	push   $0x0
  pushl $104
8010749b:	6a 68                	push   $0x68
  jmp alltraps
8010749d:	e9 0c f6 ff ff       	jmp    80106aae <alltraps>

801074a2 <vector105>:
.globl vector105
vector105:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $105
801074a4:	6a 69                	push   $0x69
  jmp alltraps
801074a6:	e9 03 f6 ff ff       	jmp    80106aae <alltraps>

801074ab <vector106>:
.globl vector106
vector106:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $106
801074ad:	6a 6a                	push   $0x6a
  jmp alltraps
801074af:	e9 fa f5 ff ff       	jmp    80106aae <alltraps>

801074b4 <vector107>:
.globl vector107
vector107:
  pushl $0
801074b4:	6a 00                	push   $0x0
  pushl $107
801074b6:	6a 6b                	push   $0x6b
  jmp alltraps
801074b8:	e9 f1 f5 ff ff       	jmp    80106aae <alltraps>

801074bd <vector108>:
.globl vector108
vector108:
  pushl $0
801074bd:	6a 00                	push   $0x0
  pushl $108
801074bf:	6a 6c                	push   $0x6c
  jmp alltraps
801074c1:	e9 e8 f5 ff ff       	jmp    80106aae <alltraps>

801074c6 <vector109>:
.globl vector109
vector109:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $109
801074c8:	6a 6d                	push   $0x6d
  jmp alltraps
801074ca:	e9 df f5 ff ff       	jmp    80106aae <alltraps>

801074cf <vector110>:
.globl vector110
vector110:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $110
801074d1:	6a 6e                	push   $0x6e
  jmp alltraps
801074d3:	e9 d6 f5 ff ff       	jmp    80106aae <alltraps>

801074d8 <vector111>:
.globl vector111
vector111:
  pushl $0
801074d8:	6a 00                	push   $0x0
  pushl $111
801074da:	6a 6f                	push   $0x6f
  jmp alltraps
801074dc:	e9 cd f5 ff ff       	jmp    80106aae <alltraps>

801074e1 <vector112>:
.globl vector112
vector112:
  pushl $0
801074e1:	6a 00                	push   $0x0
  pushl $112
801074e3:	6a 70                	push   $0x70
  jmp alltraps
801074e5:	e9 c4 f5 ff ff       	jmp    80106aae <alltraps>

801074ea <vector113>:
.globl vector113
vector113:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $113
801074ec:	6a 71                	push   $0x71
  jmp alltraps
801074ee:	e9 bb f5 ff ff       	jmp    80106aae <alltraps>

801074f3 <vector114>:
.globl vector114
vector114:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $114
801074f5:	6a 72                	push   $0x72
  jmp alltraps
801074f7:	e9 b2 f5 ff ff       	jmp    80106aae <alltraps>

801074fc <vector115>:
.globl vector115
vector115:
  pushl $0
801074fc:	6a 00                	push   $0x0
  pushl $115
801074fe:	6a 73                	push   $0x73
  jmp alltraps
80107500:	e9 a9 f5 ff ff       	jmp    80106aae <alltraps>

80107505 <vector116>:
.globl vector116
vector116:
  pushl $0
80107505:	6a 00                	push   $0x0
  pushl $116
80107507:	6a 74                	push   $0x74
  jmp alltraps
80107509:	e9 a0 f5 ff ff       	jmp    80106aae <alltraps>

8010750e <vector117>:
.globl vector117
vector117:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $117
80107510:	6a 75                	push   $0x75
  jmp alltraps
80107512:	e9 97 f5 ff ff       	jmp    80106aae <alltraps>

80107517 <vector118>:
.globl vector118
vector118:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $118
80107519:	6a 76                	push   $0x76
  jmp alltraps
8010751b:	e9 8e f5 ff ff       	jmp    80106aae <alltraps>

80107520 <vector119>:
.globl vector119
vector119:
  pushl $0
80107520:	6a 00                	push   $0x0
  pushl $119
80107522:	6a 77                	push   $0x77
  jmp alltraps
80107524:	e9 85 f5 ff ff       	jmp    80106aae <alltraps>

80107529 <vector120>:
.globl vector120
vector120:
  pushl $0
80107529:	6a 00                	push   $0x0
  pushl $120
8010752b:	6a 78                	push   $0x78
  jmp alltraps
8010752d:	e9 7c f5 ff ff       	jmp    80106aae <alltraps>

80107532 <vector121>:
.globl vector121
vector121:
  pushl $0
80107532:	6a 00                	push   $0x0
  pushl $121
80107534:	6a 79                	push   $0x79
  jmp alltraps
80107536:	e9 73 f5 ff ff       	jmp    80106aae <alltraps>

8010753b <vector122>:
.globl vector122
vector122:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $122
8010753d:	6a 7a                	push   $0x7a
  jmp alltraps
8010753f:	e9 6a f5 ff ff       	jmp    80106aae <alltraps>

80107544 <vector123>:
.globl vector123
vector123:
  pushl $0
80107544:	6a 00                	push   $0x0
  pushl $123
80107546:	6a 7b                	push   $0x7b
  jmp alltraps
80107548:	e9 61 f5 ff ff       	jmp    80106aae <alltraps>

8010754d <vector124>:
.globl vector124
vector124:
  pushl $0
8010754d:	6a 00                	push   $0x0
  pushl $124
8010754f:	6a 7c                	push   $0x7c
  jmp alltraps
80107551:	e9 58 f5 ff ff       	jmp    80106aae <alltraps>

80107556 <vector125>:
.globl vector125
vector125:
  pushl $0
80107556:	6a 00                	push   $0x0
  pushl $125
80107558:	6a 7d                	push   $0x7d
  jmp alltraps
8010755a:	e9 4f f5 ff ff       	jmp    80106aae <alltraps>

8010755f <vector126>:
.globl vector126
vector126:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $126
80107561:	6a 7e                	push   $0x7e
  jmp alltraps
80107563:	e9 46 f5 ff ff       	jmp    80106aae <alltraps>

80107568 <vector127>:
.globl vector127
vector127:
  pushl $0
80107568:	6a 00                	push   $0x0
  pushl $127
8010756a:	6a 7f                	push   $0x7f
  jmp alltraps
8010756c:	e9 3d f5 ff ff       	jmp    80106aae <alltraps>

80107571 <vector128>:
.globl vector128
vector128:
  pushl $0
80107571:	6a 00                	push   $0x0
  pushl $128
80107573:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107578:	e9 31 f5 ff ff       	jmp    80106aae <alltraps>

8010757d <vector129>:
.globl vector129
vector129:
  pushl $0
8010757d:	6a 00                	push   $0x0
  pushl $129
8010757f:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107584:	e9 25 f5 ff ff       	jmp    80106aae <alltraps>

80107589 <vector130>:
.globl vector130
vector130:
  pushl $0
80107589:	6a 00                	push   $0x0
  pushl $130
8010758b:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107590:	e9 19 f5 ff ff       	jmp    80106aae <alltraps>

80107595 <vector131>:
.globl vector131
vector131:
  pushl $0
80107595:	6a 00                	push   $0x0
  pushl $131
80107597:	68 83 00 00 00       	push   $0x83
  jmp alltraps
8010759c:	e9 0d f5 ff ff       	jmp    80106aae <alltraps>

801075a1 <vector132>:
.globl vector132
vector132:
  pushl $0
801075a1:	6a 00                	push   $0x0
  pushl $132
801075a3:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801075a8:	e9 01 f5 ff ff       	jmp    80106aae <alltraps>

801075ad <vector133>:
.globl vector133
vector133:
  pushl $0
801075ad:	6a 00                	push   $0x0
  pushl $133
801075af:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801075b4:	e9 f5 f4 ff ff       	jmp    80106aae <alltraps>

801075b9 <vector134>:
.globl vector134
vector134:
  pushl $0
801075b9:	6a 00                	push   $0x0
  pushl $134
801075bb:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801075c0:	e9 e9 f4 ff ff       	jmp    80106aae <alltraps>

801075c5 <vector135>:
.globl vector135
vector135:
  pushl $0
801075c5:	6a 00                	push   $0x0
  pushl $135
801075c7:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801075cc:	e9 dd f4 ff ff       	jmp    80106aae <alltraps>

801075d1 <vector136>:
.globl vector136
vector136:
  pushl $0
801075d1:	6a 00                	push   $0x0
  pushl $136
801075d3:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801075d8:	e9 d1 f4 ff ff       	jmp    80106aae <alltraps>

801075dd <vector137>:
.globl vector137
vector137:
  pushl $0
801075dd:	6a 00                	push   $0x0
  pushl $137
801075df:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801075e4:	e9 c5 f4 ff ff       	jmp    80106aae <alltraps>

801075e9 <vector138>:
.globl vector138
vector138:
  pushl $0
801075e9:	6a 00                	push   $0x0
  pushl $138
801075eb:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801075f0:	e9 b9 f4 ff ff       	jmp    80106aae <alltraps>

801075f5 <vector139>:
.globl vector139
vector139:
  pushl $0
801075f5:	6a 00                	push   $0x0
  pushl $139
801075f7:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801075fc:	e9 ad f4 ff ff       	jmp    80106aae <alltraps>

80107601 <vector140>:
.globl vector140
vector140:
  pushl $0
80107601:	6a 00                	push   $0x0
  pushl $140
80107603:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107608:	e9 a1 f4 ff ff       	jmp    80106aae <alltraps>

8010760d <vector141>:
.globl vector141
vector141:
  pushl $0
8010760d:	6a 00                	push   $0x0
  pushl $141
8010760f:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107614:	e9 95 f4 ff ff       	jmp    80106aae <alltraps>

80107619 <vector142>:
.globl vector142
vector142:
  pushl $0
80107619:	6a 00                	push   $0x0
  pushl $142
8010761b:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107620:	e9 89 f4 ff ff       	jmp    80106aae <alltraps>

80107625 <vector143>:
.globl vector143
vector143:
  pushl $0
80107625:	6a 00                	push   $0x0
  pushl $143
80107627:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010762c:	e9 7d f4 ff ff       	jmp    80106aae <alltraps>

80107631 <vector144>:
.globl vector144
vector144:
  pushl $0
80107631:	6a 00                	push   $0x0
  pushl $144
80107633:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107638:	e9 71 f4 ff ff       	jmp    80106aae <alltraps>

8010763d <vector145>:
.globl vector145
vector145:
  pushl $0
8010763d:	6a 00                	push   $0x0
  pushl $145
8010763f:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107644:	e9 65 f4 ff ff       	jmp    80106aae <alltraps>

80107649 <vector146>:
.globl vector146
vector146:
  pushl $0
80107649:	6a 00                	push   $0x0
  pushl $146
8010764b:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107650:	e9 59 f4 ff ff       	jmp    80106aae <alltraps>

80107655 <vector147>:
.globl vector147
vector147:
  pushl $0
80107655:	6a 00                	push   $0x0
  pushl $147
80107657:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010765c:	e9 4d f4 ff ff       	jmp    80106aae <alltraps>

80107661 <vector148>:
.globl vector148
vector148:
  pushl $0
80107661:	6a 00                	push   $0x0
  pushl $148
80107663:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107668:	e9 41 f4 ff ff       	jmp    80106aae <alltraps>

8010766d <vector149>:
.globl vector149
vector149:
  pushl $0
8010766d:	6a 00                	push   $0x0
  pushl $149
8010766f:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107674:	e9 35 f4 ff ff       	jmp    80106aae <alltraps>

80107679 <vector150>:
.globl vector150
vector150:
  pushl $0
80107679:	6a 00                	push   $0x0
  pushl $150
8010767b:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107680:	e9 29 f4 ff ff       	jmp    80106aae <alltraps>

80107685 <vector151>:
.globl vector151
vector151:
  pushl $0
80107685:	6a 00                	push   $0x0
  pushl $151
80107687:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010768c:	e9 1d f4 ff ff       	jmp    80106aae <alltraps>

80107691 <vector152>:
.globl vector152
vector152:
  pushl $0
80107691:	6a 00                	push   $0x0
  pushl $152
80107693:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107698:	e9 11 f4 ff ff       	jmp    80106aae <alltraps>

8010769d <vector153>:
.globl vector153
vector153:
  pushl $0
8010769d:	6a 00                	push   $0x0
  pushl $153
8010769f:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801076a4:	e9 05 f4 ff ff       	jmp    80106aae <alltraps>

801076a9 <vector154>:
.globl vector154
vector154:
  pushl $0
801076a9:	6a 00                	push   $0x0
  pushl $154
801076ab:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801076b0:	e9 f9 f3 ff ff       	jmp    80106aae <alltraps>

801076b5 <vector155>:
.globl vector155
vector155:
  pushl $0
801076b5:	6a 00                	push   $0x0
  pushl $155
801076b7:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801076bc:	e9 ed f3 ff ff       	jmp    80106aae <alltraps>

801076c1 <vector156>:
.globl vector156
vector156:
  pushl $0
801076c1:	6a 00                	push   $0x0
  pushl $156
801076c3:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801076c8:	e9 e1 f3 ff ff       	jmp    80106aae <alltraps>

801076cd <vector157>:
.globl vector157
vector157:
  pushl $0
801076cd:	6a 00                	push   $0x0
  pushl $157
801076cf:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801076d4:	e9 d5 f3 ff ff       	jmp    80106aae <alltraps>

801076d9 <vector158>:
.globl vector158
vector158:
  pushl $0
801076d9:	6a 00                	push   $0x0
  pushl $158
801076db:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801076e0:	e9 c9 f3 ff ff       	jmp    80106aae <alltraps>

801076e5 <vector159>:
.globl vector159
vector159:
  pushl $0
801076e5:	6a 00                	push   $0x0
  pushl $159
801076e7:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801076ec:	e9 bd f3 ff ff       	jmp    80106aae <alltraps>

801076f1 <vector160>:
.globl vector160
vector160:
  pushl $0
801076f1:	6a 00                	push   $0x0
  pushl $160
801076f3:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801076f8:	e9 b1 f3 ff ff       	jmp    80106aae <alltraps>

801076fd <vector161>:
.globl vector161
vector161:
  pushl $0
801076fd:	6a 00                	push   $0x0
  pushl $161
801076ff:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107704:	e9 a5 f3 ff ff       	jmp    80106aae <alltraps>

80107709 <vector162>:
.globl vector162
vector162:
  pushl $0
80107709:	6a 00                	push   $0x0
  pushl $162
8010770b:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107710:	e9 99 f3 ff ff       	jmp    80106aae <alltraps>

80107715 <vector163>:
.globl vector163
vector163:
  pushl $0
80107715:	6a 00                	push   $0x0
  pushl $163
80107717:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010771c:	e9 8d f3 ff ff       	jmp    80106aae <alltraps>

80107721 <vector164>:
.globl vector164
vector164:
  pushl $0
80107721:	6a 00                	push   $0x0
  pushl $164
80107723:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107728:	e9 81 f3 ff ff       	jmp    80106aae <alltraps>

8010772d <vector165>:
.globl vector165
vector165:
  pushl $0
8010772d:	6a 00                	push   $0x0
  pushl $165
8010772f:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107734:	e9 75 f3 ff ff       	jmp    80106aae <alltraps>

80107739 <vector166>:
.globl vector166
vector166:
  pushl $0
80107739:	6a 00                	push   $0x0
  pushl $166
8010773b:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107740:	e9 69 f3 ff ff       	jmp    80106aae <alltraps>

80107745 <vector167>:
.globl vector167
vector167:
  pushl $0
80107745:	6a 00                	push   $0x0
  pushl $167
80107747:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010774c:	e9 5d f3 ff ff       	jmp    80106aae <alltraps>

80107751 <vector168>:
.globl vector168
vector168:
  pushl $0
80107751:	6a 00                	push   $0x0
  pushl $168
80107753:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107758:	e9 51 f3 ff ff       	jmp    80106aae <alltraps>

8010775d <vector169>:
.globl vector169
vector169:
  pushl $0
8010775d:	6a 00                	push   $0x0
  pushl $169
8010775f:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107764:	e9 45 f3 ff ff       	jmp    80106aae <alltraps>

80107769 <vector170>:
.globl vector170
vector170:
  pushl $0
80107769:	6a 00                	push   $0x0
  pushl $170
8010776b:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107770:	e9 39 f3 ff ff       	jmp    80106aae <alltraps>

80107775 <vector171>:
.globl vector171
vector171:
  pushl $0
80107775:	6a 00                	push   $0x0
  pushl $171
80107777:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010777c:	e9 2d f3 ff ff       	jmp    80106aae <alltraps>

80107781 <vector172>:
.globl vector172
vector172:
  pushl $0
80107781:	6a 00                	push   $0x0
  pushl $172
80107783:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107788:	e9 21 f3 ff ff       	jmp    80106aae <alltraps>

8010778d <vector173>:
.globl vector173
vector173:
  pushl $0
8010778d:	6a 00                	push   $0x0
  pushl $173
8010778f:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107794:	e9 15 f3 ff ff       	jmp    80106aae <alltraps>

80107799 <vector174>:
.globl vector174
vector174:
  pushl $0
80107799:	6a 00                	push   $0x0
  pushl $174
8010779b:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801077a0:	e9 09 f3 ff ff       	jmp    80106aae <alltraps>

801077a5 <vector175>:
.globl vector175
vector175:
  pushl $0
801077a5:	6a 00                	push   $0x0
  pushl $175
801077a7:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801077ac:	e9 fd f2 ff ff       	jmp    80106aae <alltraps>

801077b1 <vector176>:
.globl vector176
vector176:
  pushl $0
801077b1:	6a 00                	push   $0x0
  pushl $176
801077b3:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801077b8:	e9 f1 f2 ff ff       	jmp    80106aae <alltraps>

801077bd <vector177>:
.globl vector177
vector177:
  pushl $0
801077bd:	6a 00                	push   $0x0
  pushl $177
801077bf:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801077c4:	e9 e5 f2 ff ff       	jmp    80106aae <alltraps>

801077c9 <vector178>:
.globl vector178
vector178:
  pushl $0
801077c9:	6a 00                	push   $0x0
  pushl $178
801077cb:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801077d0:	e9 d9 f2 ff ff       	jmp    80106aae <alltraps>

801077d5 <vector179>:
.globl vector179
vector179:
  pushl $0
801077d5:	6a 00                	push   $0x0
  pushl $179
801077d7:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801077dc:	e9 cd f2 ff ff       	jmp    80106aae <alltraps>

801077e1 <vector180>:
.globl vector180
vector180:
  pushl $0
801077e1:	6a 00                	push   $0x0
  pushl $180
801077e3:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801077e8:	e9 c1 f2 ff ff       	jmp    80106aae <alltraps>

801077ed <vector181>:
.globl vector181
vector181:
  pushl $0
801077ed:	6a 00                	push   $0x0
  pushl $181
801077ef:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801077f4:	e9 b5 f2 ff ff       	jmp    80106aae <alltraps>

801077f9 <vector182>:
.globl vector182
vector182:
  pushl $0
801077f9:	6a 00                	push   $0x0
  pushl $182
801077fb:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107800:	e9 a9 f2 ff ff       	jmp    80106aae <alltraps>

80107805 <vector183>:
.globl vector183
vector183:
  pushl $0
80107805:	6a 00                	push   $0x0
  pushl $183
80107807:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010780c:	e9 9d f2 ff ff       	jmp    80106aae <alltraps>

80107811 <vector184>:
.globl vector184
vector184:
  pushl $0
80107811:	6a 00                	push   $0x0
  pushl $184
80107813:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107818:	e9 91 f2 ff ff       	jmp    80106aae <alltraps>

8010781d <vector185>:
.globl vector185
vector185:
  pushl $0
8010781d:	6a 00                	push   $0x0
  pushl $185
8010781f:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107824:	e9 85 f2 ff ff       	jmp    80106aae <alltraps>

80107829 <vector186>:
.globl vector186
vector186:
  pushl $0
80107829:	6a 00                	push   $0x0
  pushl $186
8010782b:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107830:	e9 79 f2 ff ff       	jmp    80106aae <alltraps>

80107835 <vector187>:
.globl vector187
vector187:
  pushl $0
80107835:	6a 00                	push   $0x0
  pushl $187
80107837:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010783c:	e9 6d f2 ff ff       	jmp    80106aae <alltraps>

80107841 <vector188>:
.globl vector188
vector188:
  pushl $0
80107841:	6a 00                	push   $0x0
  pushl $188
80107843:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107848:	e9 61 f2 ff ff       	jmp    80106aae <alltraps>

8010784d <vector189>:
.globl vector189
vector189:
  pushl $0
8010784d:	6a 00                	push   $0x0
  pushl $189
8010784f:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107854:	e9 55 f2 ff ff       	jmp    80106aae <alltraps>

80107859 <vector190>:
.globl vector190
vector190:
  pushl $0
80107859:	6a 00                	push   $0x0
  pushl $190
8010785b:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107860:	e9 49 f2 ff ff       	jmp    80106aae <alltraps>

80107865 <vector191>:
.globl vector191
vector191:
  pushl $0
80107865:	6a 00                	push   $0x0
  pushl $191
80107867:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010786c:	e9 3d f2 ff ff       	jmp    80106aae <alltraps>

80107871 <vector192>:
.globl vector192
vector192:
  pushl $0
80107871:	6a 00                	push   $0x0
  pushl $192
80107873:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107878:	e9 31 f2 ff ff       	jmp    80106aae <alltraps>

8010787d <vector193>:
.globl vector193
vector193:
  pushl $0
8010787d:	6a 00                	push   $0x0
  pushl $193
8010787f:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107884:	e9 25 f2 ff ff       	jmp    80106aae <alltraps>

80107889 <vector194>:
.globl vector194
vector194:
  pushl $0
80107889:	6a 00                	push   $0x0
  pushl $194
8010788b:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107890:	e9 19 f2 ff ff       	jmp    80106aae <alltraps>

80107895 <vector195>:
.globl vector195
vector195:
  pushl $0
80107895:	6a 00                	push   $0x0
  pushl $195
80107897:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
8010789c:	e9 0d f2 ff ff       	jmp    80106aae <alltraps>

801078a1 <vector196>:
.globl vector196
vector196:
  pushl $0
801078a1:	6a 00                	push   $0x0
  pushl $196
801078a3:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801078a8:	e9 01 f2 ff ff       	jmp    80106aae <alltraps>

801078ad <vector197>:
.globl vector197
vector197:
  pushl $0
801078ad:	6a 00                	push   $0x0
  pushl $197
801078af:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801078b4:	e9 f5 f1 ff ff       	jmp    80106aae <alltraps>

801078b9 <vector198>:
.globl vector198
vector198:
  pushl $0
801078b9:	6a 00                	push   $0x0
  pushl $198
801078bb:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801078c0:	e9 e9 f1 ff ff       	jmp    80106aae <alltraps>

801078c5 <vector199>:
.globl vector199
vector199:
  pushl $0
801078c5:	6a 00                	push   $0x0
  pushl $199
801078c7:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801078cc:	e9 dd f1 ff ff       	jmp    80106aae <alltraps>

801078d1 <vector200>:
.globl vector200
vector200:
  pushl $0
801078d1:	6a 00                	push   $0x0
  pushl $200
801078d3:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801078d8:	e9 d1 f1 ff ff       	jmp    80106aae <alltraps>

801078dd <vector201>:
.globl vector201
vector201:
  pushl $0
801078dd:	6a 00                	push   $0x0
  pushl $201
801078df:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801078e4:	e9 c5 f1 ff ff       	jmp    80106aae <alltraps>

801078e9 <vector202>:
.globl vector202
vector202:
  pushl $0
801078e9:	6a 00                	push   $0x0
  pushl $202
801078eb:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801078f0:	e9 b9 f1 ff ff       	jmp    80106aae <alltraps>

801078f5 <vector203>:
.globl vector203
vector203:
  pushl $0
801078f5:	6a 00                	push   $0x0
  pushl $203
801078f7:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801078fc:	e9 ad f1 ff ff       	jmp    80106aae <alltraps>

80107901 <vector204>:
.globl vector204
vector204:
  pushl $0
80107901:	6a 00                	push   $0x0
  pushl $204
80107903:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107908:	e9 a1 f1 ff ff       	jmp    80106aae <alltraps>

8010790d <vector205>:
.globl vector205
vector205:
  pushl $0
8010790d:	6a 00                	push   $0x0
  pushl $205
8010790f:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107914:	e9 95 f1 ff ff       	jmp    80106aae <alltraps>

80107919 <vector206>:
.globl vector206
vector206:
  pushl $0
80107919:	6a 00                	push   $0x0
  pushl $206
8010791b:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107920:	e9 89 f1 ff ff       	jmp    80106aae <alltraps>

80107925 <vector207>:
.globl vector207
vector207:
  pushl $0
80107925:	6a 00                	push   $0x0
  pushl $207
80107927:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010792c:	e9 7d f1 ff ff       	jmp    80106aae <alltraps>

80107931 <vector208>:
.globl vector208
vector208:
  pushl $0
80107931:	6a 00                	push   $0x0
  pushl $208
80107933:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107938:	e9 71 f1 ff ff       	jmp    80106aae <alltraps>

8010793d <vector209>:
.globl vector209
vector209:
  pushl $0
8010793d:	6a 00                	push   $0x0
  pushl $209
8010793f:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107944:	e9 65 f1 ff ff       	jmp    80106aae <alltraps>

80107949 <vector210>:
.globl vector210
vector210:
  pushl $0
80107949:	6a 00                	push   $0x0
  pushl $210
8010794b:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107950:	e9 59 f1 ff ff       	jmp    80106aae <alltraps>

80107955 <vector211>:
.globl vector211
vector211:
  pushl $0
80107955:	6a 00                	push   $0x0
  pushl $211
80107957:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010795c:	e9 4d f1 ff ff       	jmp    80106aae <alltraps>

80107961 <vector212>:
.globl vector212
vector212:
  pushl $0
80107961:	6a 00                	push   $0x0
  pushl $212
80107963:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107968:	e9 41 f1 ff ff       	jmp    80106aae <alltraps>

8010796d <vector213>:
.globl vector213
vector213:
  pushl $0
8010796d:	6a 00                	push   $0x0
  pushl $213
8010796f:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107974:	e9 35 f1 ff ff       	jmp    80106aae <alltraps>

80107979 <vector214>:
.globl vector214
vector214:
  pushl $0
80107979:	6a 00                	push   $0x0
  pushl $214
8010797b:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107980:	e9 29 f1 ff ff       	jmp    80106aae <alltraps>

80107985 <vector215>:
.globl vector215
vector215:
  pushl $0
80107985:	6a 00                	push   $0x0
  pushl $215
80107987:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010798c:	e9 1d f1 ff ff       	jmp    80106aae <alltraps>

80107991 <vector216>:
.globl vector216
vector216:
  pushl $0
80107991:	6a 00                	push   $0x0
  pushl $216
80107993:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107998:	e9 11 f1 ff ff       	jmp    80106aae <alltraps>

8010799d <vector217>:
.globl vector217
vector217:
  pushl $0
8010799d:	6a 00                	push   $0x0
  pushl $217
8010799f:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801079a4:	e9 05 f1 ff ff       	jmp    80106aae <alltraps>

801079a9 <vector218>:
.globl vector218
vector218:
  pushl $0
801079a9:	6a 00                	push   $0x0
  pushl $218
801079ab:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801079b0:	e9 f9 f0 ff ff       	jmp    80106aae <alltraps>

801079b5 <vector219>:
.globl vector219
vector219:
  pushl $0
801079b5:	6a 00                	push   $0x0
  pushl $219
801079b7:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801079bc:	e9 ed f0 ff ff       	jmp    80106aae <alltraps>

801079c1 <vector220>:
.globl vector220
vector220:
  pushl $0
801079c1:	6a 00                	push   $0x0
  pushl $220
801079c3:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801079c8:	e9 e1 f0 ff ff       	jmp    80106aae <alltraps>

801079cd <vector221>:
.globl vector221
vector221:
  pushl $0
801079cd:	6a 00                	push   $0x0
  pushl $221
801079cf:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801079d4:	e9 d5 f0 ff ff       	jmp    80106aae <alltraps>

801079d9 <vector222>:
.globl vector222
vector222:
  pushl $0
801079d9:	6a 00                	push   $0x0
  pushl $222
801079db:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801079e0:	e9 c9 f0 ff ff       	jmp    80106aae <alltraps>

801079e5 <vector223>:
.globl vector223
vector223:
  pushl $0
801079e5:	6a 00                	push   $0x0
  pushl $223
801079e7:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801079ec:	e9 bd f0 ff ff       	jmp    80106aae <alltraps>

801079f1 <vector224>:
.globl vector224
vector224:
  pushl $0
801079f1:	6a 00                	push   $0x0
  pushl $224
801079f3:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801079f8:	e9 b1 f0 ff ff       	jmp    80106aae <alltraps>

801079fd <vector225>:
.globl vector225
vector225:
  pushl $0
801079fd:	6a 00                	push   $0x0
  pushl $225
801079ff:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107a04:	e9 a5 f0 ff ff       	jmp    80106aae <alltraps>

80107a09 <vector226>:
.globl vector226
vector226:
  pushl $0
80107a09:	6a 00                	push   $0x0
  pushl $226
80107a0b:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107a10:	e9 99 f0 ff ff       	jmp    80106aae <alltraps>

80107a15 <vector227>:
.globl vector227
vector227:
  pushl $0
80107a15:	6a 00                	push   $0x0
  pushl $227
80107a17:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107a1c:	e9 8d f0 ff ff       	jmp    80106aae <alltraps>

80107a21 <vector228>:
.globl vector228
vector228:
  pushl $0
80107a21:	6a 00                	push   $0x0
  pushl $228
80107a23:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107a28:	e9 81 f0 ff ff       	jmp    80106aae <alltraps>

80107a2d <vector229>:
.globl vector229
vector229:
  pushl $0
80107a2d:	6a 00                	push   $0x0
  pushl $229
80107a2f:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107a34:	e9 75 f0 ff ff       	jmp    80106aae <alltraps>

80107a39 <vector230>:
.globl vector230
vector230:
  pushl $0
80107a39:	6a 00                	push   $0x0
  pushl $230
80107a3b:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107a40:	e9 69 f0 ff ff       	jmp    80106aae <alltraps>

80107a45 <vector231>:
.globl vector231
vector231:
  pushl $0
80107a45:	6a 00                	push   $0x0
  pushl $231
80107a47:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107a4c:	e9 5d f0 ff ff       	jmp    80106aae <alltraps>

80107a51 <vector232>:
.globl vector232
vector232:
  pushl $0
80107a51:	6a 00                	push   $0x0
  pushl $232
80107a53:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107a58:	e9 51 f0 ff ff       	jmp    80106aae <alltraps>

80107a5d <vector233>:
.globl vector233
vector233:
  pushl $0
80107a5d:	6a 00                	push   $0x0
  pushl $233
80107a5f:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107a64:	e9 45 f0 ff ff       	jmp    80106aae <alltraps>

80107a69 <vector234>:
.globl vector234
vector234:
  pushl $0
80107a69:	6a 00                	push   $0x0
  pushl $234
80107a6b:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107a70:	e9 39 f0 ff ff       	jmp    80106aae <alltraps>

80107a75 <vector235>:
.globl vector235
vector235:
  pushl $0
80107a75:	6a 00                	push   $0x0
  pushl $235
80107a77:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107a7c:	e9 2d f0 ff ff       	jmp    80106aae <alltraps>

80107a81 <vector236>:
.globl vector236
vector236:
  pushl $0
80107a81:	6a 00                	push   $0x0
  pushl $236
80107a83:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107a88:	e9 21 f0 ff ff       	jmp    80106aae <alltraps>

80107a8d <vector237>:
.globl vector237
vector237:
  pushl $0
80107a8d:	6a 00                	push   $0x0
  pushl $237
80107a8f:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107a94:	e9 15 f0 ff ff       	jmp    80106aae <alltraps>

80107a99 <vector238>:
.globl vector238
vector238:
  pushl $0
80107a99:	6a 00                	push   $0x0
  pushl $238
80107a9b:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107aa0:	e9 09 f0 ff ff       	jmp    80106aae <alltraps>

80107aa5 <vector239>:
.globl vector239
vector239:
  pushl $0
80107aa5:	6a 00                	push   $0x0
  pushl $239
80107aa7:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107aac:	e9 fd ef ff ff       	jmp    80106aae <alltraps>

80107ab1 <vector240>:
.globl vector240
vector240:
  pushl $0
80107ab1:	6a 00                	push   $0x0
  pushl $240
80107ab3:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107ab8:	e9 f1 ef ff ff       	jmp    80106aae <alltraps>

80107abd <vector241>:
.globl vector241
vector241:
  pushl $0
80107abd:	6a 00                	push   $0x0
  pushl $241
80107abf:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107ac4:	e9 e5 ef ff ff       	jmp    80106aae <alltraps>

80107ac9 <vector242>:
.globl vector242
vector242:
  pushl $0
80107ac9:	6a 00                	push   $0x0
  pushl $242
80107acb:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107ad0:	e9 d9 ef ff ff       	jmp    80106aae <alltraps>

80107ad5 <vector243>:
.globl vector243
vector243:
  pushl $0
80107ad5:	6a 00                	push   $0x0
  pushl $243
80107ad7:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107adc:	e9 cd ef ff ff       	jmp    80106aae <alltraps>

80107ae1 <vector244>:
.globl vector244
vector244:
  pushl $0
80107ae1:	6a 00                	push   $0x0
  pushl $244
80107ae3:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107ae8:	e9 c1 ef ff ff       	jmp    80106aae <alltraps>

80107aed <vector245>:
.globl vector245
vector245:
  pushl $0
80107aed:	6a 00                	push   $0x0
  pushl $245
80107aef:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107af4:	e9 b5 ef ff ff       	jmp    80106aae <alltraps>

80107af9 <vector246>:
.globl vector246
vector246:
  pushl $0
80107af9:	6a 00                	push   $0x0
  pushl $246
80107afb:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107b00:	e9 a9 ef ff ff       	jmp    80106aae <alltraps>

80107b05 <vector247>:
.globl vector247
vector247:
  pushl $0
80107b05:	6a 00                	push   $0x0
  pushl $247
80107b07:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107b0c:	e9 9d ef ff ff       	jmp    80106aae <alltraps>

80107b11 <vector248>:
.globl vector248
vector248:
  pushl $0
80107b11:	6a 00                	push   $0x0
  pushl $248
80107b13:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107b18:	e9 91 ef ff ff       	jmp    80106aae <alltraps>

80107b1d <vector249>:
.globl vector249
vector249:
  pushl $0
80107b1d:	6a 00                	push   $0x0
  pushl $249
80107b1f:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107b24:	e9 85 ef ff ff       	jmp    80106aae <alltraps>

80107b29 <vector250>:
.globl vector250
vector250:
  pushl $0
80107b29:	6a 00                	push   $0x0
  pushl $250
80107b2b:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107b30:	e9 79 ef ff ff       	jmp    80106aae <alltraps>

80107b35 <vector251>:
.globl vector251
vector251:
  pushl $0
80107b35:	6a 00                	push   $0x0
  pushl $251
80107b37:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107b3c:	e9 6d ef ff ff       	jmp    80106aae <alltraps>

80107b41 <vector252>:
.globl vector252
vector252:
  pushl $0
80107b41:	6a 00                	push   $0x0
  pushl $252
80107b43:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107b48:	e9 61 ef ff ff       	jmp    80106aae <alltraps>

80107b4d <vector253>:
.globl vector253
vector253:
  pushl $0
80107b4d:	6a 00                	push   $0x0
  pushl $253
80107b4f:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107b54:	e9 55 ef ff ff       	jmp    80106aae <alltraps>

80107b59 <vector254>:
.globl vector254
vector254:
  pushl $0
80107b59:	6a 00                	push   $0x0
  pushl $254
80107b5b:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107b60:	e9 49 ef ff ff       	jmp    80106aae <alltraps>

80107b65 <vector255>:
.globl vector255
vector255:
  pushl $0
80107b65:	6a 00                	push   $0x0
  pushl $255
80107b67:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107b6c:	e9 3d ef ff ff       	jmp    80106aae <alltraps>

80107b71 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107b71:	55                   	push   %ebp
80107b72:	89 e5                	mov    %esp,%ebp
80107b74:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107b77:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b7a:	83 e8 01             	sub    $0x1,%eax
80107b7d:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107b81:	8b 45 08             	mov    0x8(%ebp),%eax
80107b84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107b88:	8b 45 08             	mov    0x8(%ebp),%eax
80107b8b:	c1 e8 10             	shr    $0x10,%eax
80107b8e:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107b92:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107b95:	0f 01 10             	lgdtl  (%eax)
}
80107b98:	90                   	nop
80107b99:	c9                   	leave  
80107b9a:	c3                   	ret    

80107b9b <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107b9b:	55                   	push   %ebp
80107b9c:	89 e5                	mov    %esp,%ebp
80107b9e:	83 ec 04             	sub    $0x4,%esp
80107ba1:	8b 45 08             	mov    0x8(%ebp),%eax
80107ba4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107ba8:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107bac:	0f 00 d8             	ltr    %ax
}
80107baf:	90                   	nop
80107bb0:	c9                   	leave  
80107bb1:	c3                   	ret    

80107bb2 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107bb2:	55                   	push   %ebp
80107bb3:	89 e5                	mov    %esp,%ebp
80107bb5:	83 ec 04             	sub    $0x4,%esp
80107bb8:	8b 45 08             	mov    0x8(%ebp),%eax
80107bbb:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107bbf:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107bc3:	8e e8                	mov    %eax,%gs
}
80107bc5:	90                   	nop
80107bc6:	c9                   	leave  
80107bc7:	c3                   	ret    

80107bc8 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107bc8:	55                   	push   %ebp
80107bc9:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107bcb:	8b 45 08             	mov    0x8(%ebp),%eax
80107bce:	0f 22 d8             	mov    %eax,%cr3
}
80107bd1:	90                   	nop
80107bd2:	5d                   	pop    %ebp
80107bd3:	c3                   	ret    

80107bd4 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107bd4:	55                   	push   %ebp
80107bd5:	89 e5                	mov    %esp,%ebp
80107bd7:	8b 45 08             	mov    0x8(%ebp),%eax
80107bda:	05 00 00 00 80       	add    $0x80000000,%eax
80107bdf:	5d                   	pop    %ebp
80107be0:	c3                   	ret    

80107be1 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107be1:	55                   	push   %ebp
80107be2:	89 e5                	mov    %esp,%ebp
80107be4:	8b 45 08             	mov    0x8(%ebp),%eax
80107be7:	05 00 00 00 80       	add    $0x80000000,%eax
80107bec:	5d                   	pop    %ebp
80107bed:	c3                   	ret    

80107bee <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107bee:	55                   	push   %ebp
80107bef:	89 e5                	mov    %esp,%ebp
80107bf1:	53                   	push   %ebx
80107bf2:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107bf5:	e8 63 b8 ff ff       	call   8010345d <cpunum>
80107bfa:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107c00:	05 a0 0a 11 80       	add    $0x80110aa0,%eax
80107c05:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c0b:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c14:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c1d:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c24:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107c28:	83 e2 f0             	and    $0xfffffff0,%edx
80107c2b:	83 ca 0a             	or     $0xa,%edx
80107c2e:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c34:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107c38:	83 ca 10             	or     $0x10,%edx
80107c3b:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c41:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107c45:	83 e2 9f             	and    $0xffffff9f,%edx
80107c48:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4e:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107c52:	83 ca 80             	or     $0xffffff80,%edx
80107c55:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c5f:	83 ca 0f             	or     $0xf,%edx
80107c62:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c68:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c6c:	83 e2 ef             	and    $0xffffffef,%edx
80107c6f:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c75:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c79:	83 e2 df             	and    $0xffffffdf,%edx
80107c7c:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c82:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c86:	83 ca 40             	or     $0x40,%edx
80107c89:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c93:	83 ca 80             	or     $0xffffff80,%edx
80107c96:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c9c:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca3:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107caa:	ff ff 
80107cac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107caf:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107cb6:	00 00 
80107cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cbb:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107ccc:	83 e2 f0             	and    $0xfffffff0,%edx
80107ccf:	83 ca 02             	or     $0x2,%edx
80107cd2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cdb:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107ce2:	83 ca 10             	or     $0x10,%edx
80107ce5:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cee:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107cf5:	83 e2 9f             	and    $0xffffff9f,%edx
80107cf8:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d01:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107d08:	83 ca 80             	or     $0xffffff80,%edx
80107d0b:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d14:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d1b:	83 ca 0f             	or     $0xf,%edx
80107d1e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d27:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d2e:	83 e2 ef             	and    $0xffffffef,%edx
80107d31:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d3a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d41:	83 e2 df             	and    $0xffffffdf,%edx
80107d44:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d4d:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d54:	83 ca 40             	or     $0x40,%edx
80107d57:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d60:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d67:	83 ca 80             	or     $0xffffff80,%edx
80107d6a:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d73:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d7d:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107d84:	ff ff 
80107d86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d89:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107d90:	00 00 
80107d92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d95:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107d9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107da6:	83 e2 f0             	and    $0xfffffff0,%edx
80107da9:	83 ca 0a             	or     $0xa,%edx
80107dac:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db5:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107dbc:	83 ca 10             	or     $0x10,%edx
80107dbf:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc8:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107dcf:	83 ca 60             	or     $0x60,%edx
80107dd2:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ddb:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107de2:	83 ca 80             	or     $0xffffff80,%edx
80107de5:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dee:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107df5:	83 ca 0f             	or     $0xf,%edx
80107df8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e01:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e08:	83 e2 ef             	and    $0xffffffef,%edx
80107e0b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e14:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e1b:	83 e2 df             	and    $0xffffffdf,%edx
80107e1e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e27:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e2e:	83 ca 40             	or     $0x40,%edx
80107e31:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107e41:	83 ca 80             	or     $0xffffff80,%edx
80107e44:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107e4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e4d:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e57:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107e5e:	ff ff 
80107e60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e63:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107e6a:	00 00 
80107e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e6f:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e79:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e80:	83 e2 f0             	and    $0xfffffff0,%edx
80107e83:	83 ca 02             	or     $0x2,%edx
80107e86:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e8f:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e96:	83 ca 10             	or     $0x10,%edx
80107e99:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ea2:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ea9:	83 ca 60             	or     $0x60,%edx
80107eac:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eb5:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ebc:	83 ca 80             	or     $0xffffff80,%edx
80107ebf:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ecf:	83 ca 0f             	or     $0xf,%edx
80107ed2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107edb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ee2:	83 e2 ef             	and    $0xffffffef,%edx
80107ee5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107eeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eee:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ef5:	83 e2 df             	and    $0xffffffdf,%edx
80107ef8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107efe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f01:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107f08:	83 ca 40             	or     $0x40,%edx
80107f0b:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f14:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107f1b:	83 ca 80             	or     $0xffffff80,%edx
80107f1e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107f24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f27:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107f2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f31:	05 b4 00 00 00       	add    $0xb4,%eax
80107f36:	89 c3                	mov    %eax,%ebx
80107f38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f3b:	05 b4 00 00 00       	add    $0xb4,%eax
80107f40:	c1 e8 10             	shr    $0x10,%eax
80107f43:	89 c2                	mov    %eax,%edx
80107f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f48:	05 b4 00 00 00       	add    $0xb4,%eax
80107f4d:	c1 e8 18             	shr    $0x18,%eax
80107f50:	89 c1                	mov    %eax,%ecx
80107f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f55:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107f5c:	00 00 
80107f5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f61:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107f68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f6b:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107f71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f74:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f7b:	83 e2 f0             	and    $0xfffffff0,%edx
80107f7e:	83 ca 02             	or     $0x2,%edx
80107f81:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f8a:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f91:	83 ca 10             	or     $0x10,%edx
80107f94:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f9d:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107fa4:	83 e2 9f             	and    $0xffffff9f,%edx
80107fa7:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fb0:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107fb7:	83 ca 80             	or     $0xffffff80,%edx
80107fba:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107fca:	83 e2 f0             	and    $0xfffffff0,%edx
80107fcd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107fdd:	83 e2 ef             	and    $0xffffffef,%edx
80107fe0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fe6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fe9:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107ff0:	83 e2 df             	and    $0xffffffdf,%edx
80107ff3:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ffc:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108003:	83 ca 40             	or     $0x40,%edx
80108006:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010800c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010800f:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108016:	83 ca 80             	or     $0xffffff80,%edx
80108019:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010801f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108022:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80108028:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010802b:	83 c0 70             	add    $0x70,%eax
8010802e:	83 ec 08             	sub    $0x8,%esp
80108031:	6a 38                	push   $0x38
80108033:	50                   	push   %eax
80108034:	e8 38 fb ff ff       	call   80107b71 <lgdt>
80108039:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
8010803c:	83 ec 0c             	sub    $0xc,%esp
8010803f:	6a 18                	push   $0x18
80108041:	e8 6c fb ff ff       	call   80107bb2 <loadgs>
80108046:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80108049:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010804c:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80108052:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80108059:	00 00 00 00 
}
8010805d:	90                   	nop
8010805e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108061:	c9                   	leave  
80108062:	c3                   	ret    

80108063 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108063:	55                   	push   %ebp
80108064:	89 e5                	mov    %esp,%ebp
80108066:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108069:	8b 45 0c             	mov    0xc(%ebp),%eax
8010806c:	c1 e8 16             	shr    $0x16,%eax
8010806f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108076:	8b 45 08             	mov    0x8(%ebp),%eax
80108079:	01 d0                	add    %edx,%eax
8010807b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
8010807e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108081:	8b 00                	mov    (%eax),%eax
80108083:	83 e0 01             	and    $0x1,%eax
80108086:	85 c0                	test   %eax,%eax
80108088:	74 18                	je     801080a2 <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
8010808a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010808d:	8b 00                	mov    (%eax),%eax
8010808f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108094:	50                   	push   %eax
80108095:	e8 47 fb ff ff       	call   80107be1 <p2v>
8010809a:	83 c4 04             	add    $0x4,%esp
8010809d:	89 45 f4             	mov    %eax,-0xc(%ebp)
801080a0:	eb 48                	jmp    801080ea <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801080a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801080a6:	74 0e                	je     801080b6 <walkpgdir+0x53>
801080a8:	e8 67 b0 ff ff       	call   80103114 <kalloc>
801080ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
801080b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801080b4:	75 07                	jne    801080bd <walkpgdir+0x5a>
      return 0;
801080b6:	b8 00 00 00 00       	mov    $0x0,%eax
801080bb:	eb 44                	jmp    80108101 <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801080bd:	83 ec 04             	sub    $0x4,%esp
801080c0:	68 00 10 00 00       	push   $0x1000
801080c5:	6a 00                	push   $0x0
801080c7:	ff 75 f4             	pushl  -0xc(%ebp)
801080ca:	e8 aa d2 ff ff       	call   80105379 <memset>
801080cf:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
801080d2:	83 ec 0c             	sub    $0xc,%esp
801080d5:	ff 75 f4             	pushl  -0xc(%ebp)
801080d8:	e8 f7 fa ff ff       	call   80107bd4 <v2p>
801080dd:	83 c4 10             	add    $0x10,%esp
801080e0:	83 c8 07             	or     $0x7,%eax
801080e3:	89 c2                	mov    %eax,%edx
801080e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801080e8:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
801080ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801080ed:	c1 e8 0c             	shr    $0xc,%eax
801080f0:	25 ff 03 00 00       	and    $0x3ff,%eax
801080f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ff:	01 d0                	add    %edx,%eax
}
80108101:	c9                   	leave  
80108102:	c3                   	ret    

80108103 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108103:	55                   	push   %ebp
80108104:	89 e5                	mov    %esp,%ebp
80108106:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80108109:	8b 45 0c             	mov    0xc(%ebp),%eax
8010810c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108111:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108114:	8b 55 0c             	mov    0xc(%ebp),%edx
80108117:	8b 45 10             	mov    0x10(%ebp),%eax
8010811a:	01 d0                	add    %edx,%eax
8010811c:	83 e8 01             	sub    $0x1,%eax
8010811f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108124:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108127:	83 ec 04             	sub    $0x4,%esp
8010812a:	6a 01                	push   $0x1
8010812c:	ff 75 f4             	pushl  -0xc(%ebp)
8010812f:	ff 75 08             	pushl  0x8(%ebp)
80108132:	e8 2c ff ff ff       	call   80108063 <walkpgdir>
80108137:	83 c4 10             	add    $0x10,%esp
8010813a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010813d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108141:	75 07                	jne    8010814a <mappages+0x47>
      return -1;
80108143:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108148:	eb 47                	jmp    80108191 <mappages+0x8e>
    if(*pte & PTE_P)
8010814a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010814d:	8b 00                	mov    (%eax),%eax
8010814f:	83 e0 01             	and    $0x1,%eax
80108152:	85 c0                	test   %eax,%eax
80108154:	74 0d                	je     80108163 <mappages+0x60>
      panic("remap");
80108156:	83 ec 0c             	sub    $0xc,%esp
80108159:	68 54 99 10 80       	push   $0x80109954
8010815e:	e8 1f 84 ff ff       	call   80100582 <panic>
    *pte = pa | perm | PTE_P;
80108163:	8b 45 18             	mov    0x18(%ebp),%eax
80108166:	0b 45 14             	or     0x14(%ebp),%eax
80108169:	83 c8 01             	or     $0x1,%eax
8010816c:	89 c2                	mov    %eax,%edx
8010816e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108171:	89 10                	mov    %edx,(%eax)
    if(a == last)
80108173:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108176:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108179:	74 10                	je     8010818b <mappages+0x88>
      break;
    a += PGSIZE;
8010817b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80108182:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80108189:	eb 9c                	jmp    80108127 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
8010818b:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
8010818c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108191:	c9                   	leave  
80108192:	c3                   	ret    

80108193 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108193:	55                   	push   %ebp
80108194:	89 e5                	mov    %esp,%ebp
80108196:	53                   	push   %ebx
80108197:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
8010819a:	e8 75 af ff ff       	call   80103114 <kalloc>
8010819f:	89 45 f0             	mov    %eax,-0x10(%ebp)
801081a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081a6:	75 0a                	jne    801081b2 <setupkvm+0x1f>
    return 0;
801081a8:	b8 00 00 00 00       	mov    $0x0,%eax
801081ad:	e9 8e 00 00 00       	jmp    80108240 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
801081b2:	83 ec 04             	sub    $0x4,%esp
801081b5:	68 00 10 00 00       	push   $0x1000
801081ba:	6a 00                	push   $0x0
801081bc:	ff 75 f0             	pushl  -0x10(%ebp)
801081bf:	e8 b5 d1 ff ff       	call   80105379 <memset>
801081c4:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
801081c7:	83 ec 0c             	sub    $0xc,%esp
801081ca:	68 00 00 00 0e       	push   $0xe000000
801081cf:	e8 0d fa ff ff       	call   80107be1 <p2v>
801081d4:	83 c4 10             	add    $0x10,%esp
801081d7:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
801081dc:	76 0d                	jbe    801081eb <setupkvm+0x58>
    panic("PHYSTOP too high");
801081de:	83 ec 0c             	sub    $0xc,%esp
801081e1:	68 5a 99 10 80       	push   $0x8010995a
801081e6:	e8 97 83 ff ff       	call   80100582 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801081eb:	c7 45 f4 e0 c4 10 80 	movl   $0x8010c4e0,-0xc(%ebp)
801081f2:	eb 40                	jmp    80108234 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
801081f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f7:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
801081fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081fd:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80108200:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108203:	8b 58 08             	mov    0x8(%eax),%ebx
80108206:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108209:	8b 40 04             	mov    0x4(%eax),%eax
8010820c:	29 c3                	sub    %eax,%ebx
8010820e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108211:	8b 00                	mov    (%eax),%eax
80108213:	83 ec 0c             	sub    $0xc,%esp
80108216:	51                   	push   %ecx
80108217:	52                   	push   %edx
80108218:	53                   	push   %ebx
80108219:	50                   	push   %eax
8010821a:	ff 75 f0             	pushl  -0x10(%ebp)
8010821d:	e8 e1 fe ff ff       	call   80108103 <mappages>
80108222:	83 c4 20             	add    $0x20,%esp
80108225:	85 c0                	test   %eax,%eax
80108227:	79 07                	jns    80108230 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80108229:	b8 00 00 00 00       	mov    $0x0,%eax
8010822e:	eb 10                	jmp    80108240 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108230:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80108234:	81 7d f4 20 c5 10 80 	cmpl   $0x8010c520,-0xc(%ebp)
8010823b:	72 b7                	jb     801081f4 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
8010823d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80108240:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108243:	c9                   	leave  
80108244:	c3                   	ret    

80108245 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108245:	55                   	push   %ebp
80108246:	89 e5                	mov    %esp,%ebp
80108248:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010824b:	e8 43 ff ff ff       	call   80108193 <setupkvm>
80108250:	a3 78 38 11 80       	mov    %eax,0x80113878
  switchkvm();
80108255:	e8 03 00 00 00       	call   8010825d <switchkvm>
}
8010825a:	90                   	nop
8010825b:	c9                   	leave  
8010825c:	c3                   	ret    

8010825d <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
8010825d:	55                   	push   %ebp
8010825e:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80108260:	a1 78 38 11 80       	mov    0x80113878,%eax
80108265:	50                   	push   %eax
80108266:	e8 69 f9 ff ff       	call   80107bd4 <v2p>
8010826b:	83 c4 04             	add    $0x4,%esp
8010826e:	50                   	push   %eax
8010826f:	e8 54 f9 ff ff       	call   80107bc8 <lcr3>
80108274:	83 c4 04             	add    $0x4,%esp
}
80108277:	90                   	nop
80108278:	c9                   	leave  
80108279:	c3                   	ret    

8010827a <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
8010827a:	55                   	push   %ebp
8010827b:	89 e5                	mov    %esp,%ebp
8010827d:	56                   	push   %esi
8010827e:	53                   	push   %ebx
  pushcli();
8010827f:	e8 ef cf ff ff       	call   80105273 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80108284:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010828a:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108291:	83 c2 08             	add    $0x8,%edx
80108294:	89 d6                	mov    %edx,%esi
80108296:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010829d:	83 c2 08             	add    $0x8,%edx
801082a0:	c1 ea 10             	shr    $0x10,%edx
801082a3:	89 d3                	mov    %edx,%ebx
801082a5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801082ac:	83 c2 08             	add    $0x8,%edx
801082af:	c1 ea 18             	shr    $0x18,%edx
801082b2:	89 d1                	mov    %edx,%ecx
801082b4:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
801082bb:	67 00 
801082bd:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
801082c4:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
801082ca:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801082d1:	83 e2 f0             	and    $0xfffffff0,%edx
801082d4:	83 ca 09             	or     $0x9,%edx
801082d7:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801082dd:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801082e4:	83 ca 10             	or     $0x10,%edx
801082e7:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801082ed:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801082f4:	83 e2 9f             	and    $0xffffff9f,%edx
801082f7:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
801082fd:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108304:	83 ca 80             	or     $0xffffff80,%edx
80108307:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
8010830d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80108314:	83 e2 f0             	and    $0xfffffff0,%edx
80108317:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
8010831d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80108324:	83 e2 ef             	and    $0xffffffef,%edx
80108327:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
8010832d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80108334:	83 e2 df             	and    $0xffffffdf,%edx
80108337:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
8010833d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80108344:	83 ca 40             	or     $0x40,%edx
80108347:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
8010834d:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80108354:	83 e2 7f             	and    $0x7f,%edx
80108357:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
8010835d:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80108363:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108369:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108370:	83 e2 ef             	and    $0xffffffef,%edx
80108373:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80108379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010837f:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80108385:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010838b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80108392:	8b 52 08             	mov    0x8(%edx),%edx
80108395:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010839b:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
8010839e:	83 ec 0c             	sub    $0xc,%esp
801083a1:	6a 30                	push   $0x30
801083a3:	e8 f3 f7 ff ff       	call   80107b9b <ltr>
801083a8:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
801083ab:	8b 45 08             	mov    0x8(%ebp),%eax
801083ae:	8b 40 04             	mov    0x4(%eax),%eax
801083b1:	85 c0                	test   %eax,%eax
801083b3:	75 0d                	jne    801083c2 <switchuvm+0x148>
    panic("switchuvm: no pgdir");
801083b5:	83 ec 0c             	sub    $0xc,%esp
801083b8:	68 6b 99 10 80       	push   $0x8010996b
801083bd:	e8 c0 81 ff ff       	call   80100582 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
801083c2:	8b 45 08             	mov    0x8(%ebp),%eax
801083c5:	8b 40 04             	mov    0x4(%eax),%eax
801083c8:	83 ec 0c             	sub    $0xc,%esp
801083cb:	50                   	push   %eax
801083cc:	e8 03 f8 ff ff       	call   80107bd4 <v2p>
801083d1:	83 c4 10             	add    $0x10,%esp
801083d4:	83 ec 0c             	sub    $0xc,%esp
801083d7:	50                   	push   %eax
801083d8:	e8 eb f7 ff ff       	call   80107bc8 <lcr3>
801083dd:	83 c4 10             	add    $0x10,%esp
  popcli();
801083e0:	e8 d3 ce ff ff       	call   801052b8 <popcli>
}
801083e5:	90                   	nop
801083e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801083e9:	5b                   	pop    %ebx
801083ea:	5e                   	pop    %esi
801083eb:	5d                   	pop    %ebp
801083ec:	c3                   	ret    

801083ed <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801083ed:	55                   	push   %ebp
801083ee:	89 e5                	mov    %esp,%ebp
801083f0:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
801083f3:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
801083fa:	76 0d                	jbe    80108409 <inituvm+0x1c>
    panic("inituvm: more than a page");
801083fc:	83 ec 0c             	sub    $0xc,%esp
801083ff:	68 7f 99 10 80       	push   $0x8010997f
80108404:	e8 79 81 ff ff       	call   80100582 <panic>
  mem = kalloc();
80108409:	e8 06 ad ff ff       	call   80103114 <kalloc>
8010840e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108411:	83 ec 04             	sub    $0x4,%esp
80108414:	68 00 10 00 00       	push   $0x1000
80108419:	6a 00                	push   $0x0
8010841b:	ff 75 f4             	pushl  -0xc(%ebp)
8010841e:	e8 56 cf ff ff       	call   80105379 <memset>
80108423:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108426:	83 ec 0c             	sub    $0xc,%esp
80108429:	ff 75 f4             	pushl  -0xc(%ebp)
8010842c:	e8 a3 f7 ff ff       	call   80107bd4 <v2p>
80108431:	83 c4 10             	add    $0x10,%esp
80108434:	83 ec 0c             	sub    $0xc,%esp
80108437:	6a 06                	push   $0x6
80108439:	50                   	push   %eax
8010843a:	68 00 10 00 00       	push   $0x1000
8010843f:	6a 00                	push   $0x0
80108441:	ff 75 08             	pushl  0x8(%ebp)
80108444:	e8 ba fc ff ff       	call   80108103 <mappages>
80108449:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
8010844c:	83 ec 04             	sub    $0x4,%esp
8010844f:	ff 75 10             	pushl  0x10(%ebp)
80108452:	ff 75 0c             	pushl  0xc(%ebp)
80108455:	ff 75 f4             	pushl  -0xc(%ebp)
80108458:	e8 db cf ff ff       	call   80105438 <memmove>
8010845d:	83 c4 10             	add    $0x10,%esp
}
80108460:	90                   	nop
80108461:	c9                   	leave  
80108462:	c3                   	ret    

80108463 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108463:	55                   	push   %ebp
80108464:	89 e5                	mov    %esp,%ebp
80108466:	53                   	push   %ebx
80108467:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010846a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010846d:	25 ff 0f 00 00       	and    $0xfff,%eax
80108472:	85 c0                	test   %eax,%eax
80108474:	74 0d                	je     80108483 <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80108476:	83 ec 0c             	sub    $0xc,%esp
80108479:	68 9c 99 10 80       	push   $0x8010999c
8010847e:	e8 ff 80 ff ff       	call   80100582 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108483:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010848a:	e9 95 00 00 00       	jmp    80108524 <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010848f:	8b 55 0c             	mov    0xc(%ebp),%edx
80108492:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108495:	01 d0                	add    %edx,%eax
80108497:	83 ec 04             	sub    $0x4,%esp
8010849a:	6a 00                	push   $0x0
8010849c:	50                   	push   %eax
8010849d:	ff 75 08             	pushl  0x8(%ebp)
801084a0:	e8 be fb ff ff       	call   80108063 <walkpgdir>
801084a5:	83 c4 10             	add    $0x10,%esp
801084a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
801084ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801084af:	75 0d                	jne    801084be <loaduvm+0x5b>
      panic("loaduvm: address should exist");
801084b1:	83 ec 0c             	sub    $0xc,%esp
801084b4:	68 bf 99 10 80       	push   $0x801099bf
801084b9:	e8 c4 80 ff ff       	call   80100582 <panic>
    pa = PTE_ADDR(*pte);
801084be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084c1:	8b 00                	mov    (%eax),%eax
801084c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801084cb:	8b 45 18             	mov    0x18(%ebp),%eax
801084ce:	2b 45 f4             	sub    -0xc(%ebp),%eax
801084d1:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801084d6:	77 0b                	ja     801084e3 <loaduvm+0x80>
      n = sz - i;
801084d8:	8b 45 18             	mov    0x18(%ebp),%eax
801084db:	2b 45 f4             	sub    -0xc(%ebp),%eax
801084de:	89 45 f0             	mov    %eax,-0x10(%ebp)
801084e1:	eb 07                	jmp    801084ea <loaduvm+0x87>
    else
      n = PGSIZE;
801084e3:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
801084ea:	8b 55 14             	mov    0x14(%ebp),%edx
801084ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084f0:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801084f3:	83 ec 0c             	sub    $0xc,%esp
801084f6:	ff 75 e8             	pushl  -0x18(%ebp)
801084f9:	e8 e3 f6 ff ff       	call   80107be1 <p2v>
801084fe:	83 c4 10             	add    $0x10,%esp
80108501:	ff 75 f0             	pushl  -0x10(%ebp)
80108504:	53                   	push   %ebx
80108505:	50                   	push   %eax
80108506:	ff 75 10             	pushl  0x10(%ebp)
80108509:	e8 b4 9e ff ff       	call   801023c2 <readi>
8010850e:	83 c4 10             	add    $0x10,%esp
80108511:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108514:	74 07                	je     8010851d <loaduvm+0xba>
      return -1;
80108516:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010851b:	eb 18                	jmp    80108535 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010851d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108524:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108527:	3b 45 18             	cmp    0x18(%ebp),%eax
8010852a:	0f 82 5f ff ff ff    	jb     8010848f <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80108530:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108535:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108538:	c9                   	leave  
80108539:	c3                   	ret    

8010853a <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010853a:	55                   	push   %ebp
8010853b:	89 e5                	mov    %esp,%ebp
8010853d:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108540:	8b 45 10             	mov    0x10(%ebp),%eax
80108543:	85 c0                	test   %eax,%eax
80108545:	79 0a                	jns    80108551 <allocuvm+0x17>
    return 0;
80108547:	b8 00 00 00 00       	mov    $0x0,%eax
8010854c:	e9 b0 00 00 00       	jmp    80108601 <allocuvm+0xc7>
  if(newsz < oldsz)
80108551:	8b 45 10             	mov    0x10(%ebp),%eax
80108554:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108557:	73 08                	jae    80108561 <allocuvm+0x27>
    return oldsz;
80108559:	8b 45 0c             	mov    0xc(%ebp),%eax
8010855c:	e9 a0 00 00 00       	jmp    80108601 <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80108561:	8b 45 0c             	mov    0xc(%ebp),%eax
80108564:	05 ff 0f 00 00       	add    $0xfff,%eax
80108569:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010856e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80108571:	eb 7f                	jmp    801085f2 <allocuvm+0xb8>
    mem = kalloc();
80108573:	e8 9c ab ff ff       	call   80103114 <kalloc>
80108578:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
8010857b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010857f:	75 2b                	jne    801085ac <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80108581:	83 ec 0c             	sub    $0xc,%esp
80108584:	68 dd 99 10 80       	push   $0x801099dd
80108589:	e8 54 7e ff ff       	call   801003e2 <cprintf>
8010858e:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80108591:	83 ec 04             	sub    $0x4,%esp
80108594:	ff 75 0c             	pushl  0xc(%ebp)
80108597:	ff 75 10             	pushl  0x10(%ebp)
8010859a:	ff 75 08             	pushl  0x8(%ebp)
8010859d:	e8 61 00 00 00       	call   80108603 <deallocuvm>
801085a2:	83 c4 10             	add    $0x10,%esp
      return 0;
801085a5:	b8 00 00 00 00       	mov    $0x0,%eax
801085aa:	eb 55                	jmp    80108601 <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
801085ac:	83 ec 04             	sub    $0x4,%esp
801085af:	68 00 10 00 00       	push   $0x1000
801085b4:	6a 00                	push   $0x0
801085b6:	ff 75 f0             	pushl  -0x10(%ebp)
801085b9:	e8 bb cd ff ff       	call   80105379 <memset>
801085be:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801085c1:	83 ec 0c             	sub    $0xc,%esp
801085c4:	ff 75 f0             	pushl  -0x10(%ebp)
801085c7:	e8 08 f6 ff ff       	call   80107bd4 <v2p>
801085cc:	83 c4 10             	add    $0x10,%esp
801085cf:	89 c2                	mov    %eax,%edx
801085d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d4:	83 ec 0c             	sub    $0xc,%esp
801085d7:	6a 06                	push   $0x6
801085d9:	52                   	push   %edx
801085da:	68 00 10 00 00       	push   $0x1000
801085df:	50                   	push   %eax
801085e0:	ff 75 08             	pushl  0x8(%ebp)
801085e3:	e8 1b fb ff ff       	call   80108103 <mappages>
801085e8:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801085eb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801085f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085f5:	3b 45 10             	cmp    0x10(%ebp),%eax
801085f8:	0f 82 75 ff ff ff    	jb     80108573 <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
801085fe:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108601:	c9                   	leave  
80108602:	c3                   	ret    

80108603 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108603:	55                   	push   %ebp
80108604:	89 e5                	mov    %esp,%ebp
80108606:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108609:	8b 45 10             	mov    0x10(%ebp),%eax
8010860c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010860f:	72 08                	jb     80108619 <deallocuvm+0x16>
    return oldsz;
80108611:	8b 45 0c             	mov    0xc(%ebp),%eax
80108614:	e9 a5 00 00 00       	jmp    801086be <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108619:	8b 45 10             	mov    0x10(%ebp),%eax
8010861c:	05 ff 0f 00 00       	add    $0xfff,%eax
80108621:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108626:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108629:	e9 81 00 00 00       	jmp    801086af <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010862e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108631:	83 ec 04             	sub    $0x4,%esp
80108634:	6a 00                	push   $0x0
80108636:	50                   	push   %eax
80108637:	ff 75 08             	pushl  0x8(%ebp)
8010863a:	e8 24 fa ff ff       	call   80108063 <walkpgdir>
8010863f:	83 c4 10             	add    $0x10,%esp
80108642:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108645:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108649:	75 09                	jne    80108654 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
8010864b:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108652:	eb 54                	jmp    801086a8 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80108654:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108657:	8b 00                	mov    (%eax),%eax
80108659:	83 e0 01             	and    $0x1,%eax
8010865c:	85 c0                	test   %eax,%eax
8010865e:	74 48                	je     801086a8 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80108660:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108663:	8b 00                	mov    (%eax),%eax
80108665:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010866a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010866d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108671:	75 0d                	jne    80108680 <deallocuvm+0x7d>
        panic("kfree");
80108673:	83 ec 0c             	sub    $0xc,%esp
80108676:	68 f5 99 10 80       	push   $0x801099f5
8010867b:	e8 02 7f ff ff       	call   80100582 <panic>
      char *v = p2v(pa);
80108680:	83 ec 0c             	sub    $0xc,%esp
80108683:	ff 75 ec             	pushl  -0x14(%ebp)
80108686:	e8 56 f5 ff ff       	call   80107be1 <p2v>
8010868b:	83 c4 10             	add    $0x10,%esp
8010868e:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108691:	83 ec 0c             	sub    $0xc,%esp
80108694:	ff 75 e8             	pushl  -0x18(%ebp)
80108697:	e8 db a9 ff ff       	call   80103077 <kfree>
8010869c:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
8010869f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801086a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801086a8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801086af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801086b5:	0f 82 73 ff ff ff    	jb     8010862e <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801086bb:	8b 45 10             	mov    0x10(%ebp),%eax
}
801086be:	c9                   	leave  
801086bf:	c3                   	ret    

801086c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801086c0:	55                   	push   %ebp
801086c1:	89 e5                	mov    %esp,%ebp
801086c3:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
801086c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801086ca:	75 0d                	jne    801086d9 <freevm+0x19>
    panic("freevm: no pgdir");
801086cc:	83 ec 0c             	sub    $0xc,%esp
801086cf:	68 fb 99 10 80       	push   $0x801099fb
801086d4:	e8 a9 7e ff ff       	call   80100582 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801086d9:	83 ec 04             	sub    $0x4,%esp
801086dc:	6a 00                	push   $0x0
801086de:	68 00 00 00 80       	push   $0x80000000
801086e3:	ff 75 08             	pushl  0x8(%ebp)
801086e6:	e8 18 ff ff ff       	call   80108603 <deallocuvm>
801086eb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801086ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801086f5:	eb 4f                	jmp    80108746 <freevm+0x86>
    if(pgdir[i] & PTE_P){
801086f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108701:	8b 45 08             	mov    0x8(%ebp),%eax
80108704:	01 d0                	add    %edx,%eax
80108706:	8b 00                	mov    (%eax),%eax
80108708:	83 e0 01             	and    $0x1,%eax
8010870b:	85 c0                	test   %eax,%eax
8010870d:	74 33                	je     80108742 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
8010870f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108712:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108719:	8b 45 08             	mov    0x8(%ebp),%eax
8010871c:	01 d0                	add    %edx,%eax
8010871e:	8b 00                	mov    (%eax),%eax
80108720:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108725:	83 ec 0c             	sub    $0xc,%esp
80108728:	50                   	push   %eax
80108729:	e8 b3 f4 ff ff       	call   80107be1 <p2v>
8010872e:	83 c4 10             	add    $0x10,%esp
80108731:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108734:	83 ec 0c             	sub    $0xc,%esp
80108737:	ff 75 f0             	pushl  -0x10(%ebp)
8010873a:	e8 38 a9 ff ff       	call   80103077 <kfree>
8010873f:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108742:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108746:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
8010874d:	76 a8                	jbe    801086f7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010874f:	83 ec 0c             	sub    $0xc,%esp
80108752:	ff 75 08             	pushl  0x8(%ebp)
80108755:	e8 1d a9 ff ff       	call   80103077 <kfree>
8010875a:	83 c4 10             	add    $0x10,%esp
}
8010875d:	90                   	nop
8010875e:	c9                   	leave  
8010875f:	c3                   	ret    

80108760 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108760:	55                   	push   %ebp
80108761:	89 e5                	mov    %esp,%ebp
80108763:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108766:	83 ec 04             	sub    $0x4,%esp
80108769:	6a 00                	push   $0x0
8010876b:	ff 75 0c             	pushl  0xc(%ebp)
8010876e:	ff 75 08             	pushl  0x8(%ebp)
80108771:	e8 ed f8 ff ff       	call   80108063 <walkpgdir>
80108776:	83 c4 10             	add    $0x10,%esp
80108779:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010877c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108780:	75 0d                	jne    8010878f <clearpteu+0x2f>
    panic("clearpteu");
80108782:	83 ec 0c             	sub    $0xc,%esp
80108785:	68 0c 9a 10 80       	push   $0x80109a0c
8010878a:	e8 f3 7d ff ff       	call   80100582 <panic>
  *pte &= ~PTE_U;
8010878f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108792:	8b 00                	mov    (%eax),%eax
80108794:	83 e0 fb             	and    $0xfffffffb,%eax
80108797:	89 c2                	mov    %eax,%edx
80108799:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010879c:	89 10                	mov    %edx,(%eax)
}
8010879e:	90                   	nop
8010879f:	c9                   	leave  
801087a0:	c3                   	ret    

801087a1 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801087a1:	55                   	push   %ebp
801087a2:	89 e5                	mov    %esp,%ebp
801087a4:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
801087a7:	e8 e7 f9 ff ff       	call   80108193 <setupkvm>
801087ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
801087af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801087b3:	75 0a                	jne    801087bf <copyuvm+0x1e>
    return 0;
801087b5:	b8 00 00 00 00       	mov    $0x0,%eax
801087ba:	e9 e9 00 00 00       	jmp    801088a8 <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
801087bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801087c6:	e9 b5 00 00 00       	jmp    80108880 <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801087cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087ce:	83 ec 04             	sub    $0x4,%esp
801087d1:	6a 00                	push   $0x0
801087d3:	50                   	push   %eax
801087d4:	ff 75 08             	pushl  0x8(%ebp)
801087d7:	e8 87 f8 ff ff       	call   80108063 <walkpgdir>
801087dc:	83 c4 10             	add    $0x10,%esp
801087df:	89 45 ec             	mov    %eax,-0x14(%ebp)
801087e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801087e6:	75 0d                	jne    801087f5 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
801087e8:	83 ec 0c             	sub    $0xc,%esp
801087eb:	68 16 9a 10 80       	push   $0x80109a16
801087f0:	e8 8d 7d ff ff       	call   80100582 <panic>
    if(!(*pte & PTE_P))
801087f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801087f8:	8b 00                	mov    (%eax),%eax
801087fa:	83 e0 01             	and    $0x1,%eax
801087fd:	85 c0                	test   %eax,%eax
801087ff:	75 0d                	jne    8010880e <copyuvm+0x6d>
      panic("copyuvm: page not present");
80108801:	83 ec 0c             	sub    $0xc,%esp
80108804:	68 30 9a 10 80       	push   $0x80109a30
80108809:	e8 74 7d ff ff       	call   80100582 <panic>
    pa = PTE_ADDR(*pte);
8010880e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108811:	8b 00                	mov    (%eax),%eax
80108813:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108818:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
8010881b:	e8 f4 a8 ff ff       	call   80103114 <kalloc>
80108820:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108823:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108827:	74 68                	je     80108891 <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108829:	83 ec 0c             	sub    $0xc,%esp
8010882c:	ff 75 e8             	pushl  -0x18(%ebp)
8010882f:	e8 ad f3 ff ff       	call   80107be1 <p2v>
80108834:	83 c4 10             	add    $0x10,%esp
80108837:	83 ec 04             	sub    $0x4,%esp
8010883a:	68 00 10 00 00       	push   $0x1000
8010883f:	50                   	push   %eax
80108840:	ff 75 e4             	pushl  -0x1c(%ebp)
80108843:	e8 f0 cb ff ff       	call   80105438 <memmove>
80108848:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
8010884b:	83 ec 0c             	sub    $0xc,%esp
8010884e:	ff 75 e4             	pushl  -0x1c(%ebp)
80108851:	e8 7e f3 ff ff       	call   80107bd4 <v2p>
80108856:	83 c4 10             	add    $0x10,%esp
80108859:	89 c2                	mov    %eax,%edx
8010885b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010885e:	83 ec 0c             	sub    $0xc,%esp
80108861:	6a 06                	push   $0x6
80108863:	52                   	push   %edx
80108864:	68 00 10 00 00       	push   $0x1000
80108869:	50                   	push   %eax
8010886a:	ff 75 f0             	pushl  -0x10(%ebp)
8010886d:	e8 91 f8 ff ff       	call   80108103 <mappages>
80108872:	83 c4 20             	add    $0x20,%esp
80108875:	85 c0                	test   %eax,%eax
80108877:	78 1b                	js     80108894 <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108879:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108880:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108883:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108886:	0f 82 3f ff ff ff    	jb     801087cb <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
8010888c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010888f:	eb 17                	jmp    801088a8 <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108891:	90                   	nop
80108892:	eb 01                	jmp    80108895 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
80108894:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108895:	83 ec 0c             	sub    $0xc,%esp
80108898:	ff 75 f0             	pushl  -0x10(%ebp)
8010889b:	e8 20 fe ff ff       	call   801086c0 <freevm>
801088a0:	83 c4 10             	add    $0x10,%esp
  return 0;
801088a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801088a8:	c9                   	leave  
801088a9:	c3                   	ret    

801088aa <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801088aa:	55                   	push   %ebp
801088ab:	89 e5                	mov    %esp,%ebp
801088ad:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801088b0:	83 ec 04             	sub    $0x4,%esp
801088b3:	6a 00                	push   $0x0
801088b5:	ff 75 0c             	pushl  0xc(%ebp)
801088b8:	ff 75 08             	pushl  0x8(%ebp)
801088bb:	e8 a3 f7 ff ff       	call   80108063 <walkpgdir>
801088c0:	83 c4 10             	add    $0x10,%esp
801088c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801088c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088c9:	8b 00                	mov    (%eax),%eax
801088cb:	83 e0 01             	and    $0x1,%eax
801088ce:	85 c0                	test   %eax,%eax
801088d0:	75 07                	jne    801088d9 <uva2ka+0x2f>
    return 0;
801088d2:	b8 00 00 00 00       	mov    $0x0,%eax
801088d7:	eb 29                	jmp    80108902 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801088d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088dc:	8b 00                	mov    (%eax),%eax
801088de:	83 e0 04             	and    $0x4,%eax
801088e1:	85 c0                	test   %eax,%eax
801088e3:	75 07                	jne    801088ec <uva2ka+0x42>
    return 0;
801088e5:	b8 00 00 00 00       	mov    $0x0,%eax
801088ea:	eb 16                	jmp    80108902 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801088ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088ef:	8b 00                	mov    (%eax),%eax
801088f1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801088f6:	83 ec 0c             	sub    $0xc,%esp
801088f9:	50                   	push   %eax
801088fa:	e8 e2 f2 ff ff       	call   80107be1 <p2v>
801088ff:	83 c4 10             	add    $0x10,%esp
}
80108902:	c9                   	leave  
80108903:	c3                   	ret    

80108904 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108904:	55                   	push   %ebp
80108905:	89 e5                	mov    %esp,%ebp
80108907:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010890a:	8b 45 10             	mov    0x10(%ebp),%eax
8010890d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108910:	eb 7f                	jmp    80108991 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80108912:	8b 45 0c             	mov    0xc(%ebp),%eax
80108915:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010891a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010891d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108920:	83 ec 08             	sub    $0x8,%esp
80108923:	50                   	push   %eax
80108924:	ff 75 08             	pushl  0x8(%ebp)
80108927:	e8 7e ff ff ff       	call   801088aa <uva2ka>
8010892c:	83 c4 10             	add    $0x10,%esp
8010892f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108932:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108936:	75 07                	jne    8010893f <copyout+0x3b>
      return -1;
80108938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010893d:	eb 61                	jmp    801089a0 <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010893f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108942:	2b 45 0c             	sub    0xc(%ebp),%eax
80108945:	05 00 10 00 00       	add    $0x1000,%eax
8010894a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010894d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108950:	3b 45 14             	cmp    0x14(%ebp),%eax
80108953:	76 06                	jbe    8010895b <copyout+0x57>
      n = len;
80108955:	8b 45 14             	mov    0x14(%ebp),%eax
80108958:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010895b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010895e:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108961:	89 c2                	mov    %eax,%edx
80108963:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108966:	01 d0                	add    %edx,%eax
80108968:	83 ec 04             	sub    $0x4,%esp
8010896b:	ff 75 f0             	pushl  -0x10(%ebp)
8010896e:	ff 75 f4             	pushl  -0xc(%ebp)
80108971:	50                   	push   %eax
80108972:	e8 c1 ca ff ff       	call   80105438 <memmove>
80108977:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010897a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010897d:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108980:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108983:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108986:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108989:	05 00 10 00 00       	add    $0x1000,%eax
8010898e:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108991:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108995:	0f 85 77 ff ff ff    	jne    80108912 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010899b:	b8 00 00 00 00       	mov    $0x0,%eax
}
801089a0:	c9                   	leave  
801089a1:	c3                   	ret    

801089a2 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
801089a2:	55                   	push   %ebp
801089a3:	89 e5                	mov    %esp,%ebp
801089a5:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
801089a8:	83 ec 0c             	sub    $0xc,%esp
801089ab:	ff 75 08             	pushl  0x8(%ebp)
801089ae:	e8 b0 00 00 00       	call   80108a63 <re_compile>
801089b3:	83 c4 10             	add    $0x10,%esp
801089b6:	83 ec 04             	sub    $0x4,%esp
801089b9:	ff 75 10             	pushl  0x10(%ebp)
801089bc:	ff 75 0c             	pushl  0xc(%ebp)
801089bf:	50                   	push   %eax
801089c0:	e8 05 00 00 00       	call   801089ca <re_matchp>
801089c5:	83 c4 10             	add    $0x10,%esp
}
801089c8:	c9                   	leave  
801089c9:	c3                   	ret    

801089ca <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
801089ca:	55                   	push   %ebp
801089cb:	89 e5                	mov    %esp,%ebp
801089cd:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
801089d0:	8b 45 10             	mov    0x10(%ebp),%eax
801089d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
801089d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801089dd:	74 7d                	je     80108a5c <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
801089df:	8b 45 08             	mov    0x8(%ebp),%eax
801089e2:	0f b6 00             	movzbl (%eax),%eax
801089e5:	3c 02                	cmp    $0x2,%al
801089e7:	75 2a                	jne    80108a13 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
801089e9:	8b 45 08             	mov    0x8(%ebp),%eax
801089ec:	83 c0 08             	add    $0x8,%eax
801089ef:	83 ec 04             	sub    $0x4,%esp
801089f2:	ff 75 10             	pushl  0x10(%ebp)
801089f5:	ff 75 0c             	pushl  0xc(%ebp)
801089f8:	50                   	push   %eax
801089f9:	e8 b0 08 00 00       	call   801092ae <matchpattern>
801089fe:	83 c4 10             	add    $0x10,%esp
80108a01:	85 c0                	test   %eax,%eax
80108a03:	74 07                	je     80108a0c <re_matchp+0x42>
80108a05:	b8 00 00 00 00       	mov    $0x0,%eax
80108a0a:	eb 55                	jmp    80108a61 <re_matchp+0x97>
80108a0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a11:	eb 4e                	jmp    80108a61 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
80108a13:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
80108a1a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
80108a1e:	83 ec 04             	sub    $0x4,%esp
80108a21:	ff 75 10             	pushl  0x10(%ebp)
80108a24:	ff 75 0c             	pushl  0xc(%ebp)
80108a27:	ff 75 08             	pushl  0x8(%ebp)
80108a2a:	e8 7f 08 00 00       	call   801092ae <matchpattern>
80108a2f:	83 c4 10             	add    $0x10,%esp
80108a32:	85 c0                	test   %eax,%eax
80108a34:	74 16                	je     80108a4c <re_matchp+0x82>
        {
          if (text[0] == '\0')
80108a36:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a39:	0f b6 00             	movzbl (%eax),%eax
80108a3c:	84 c0                	test   %al,%al
80108a3e:	75 07                	jne    80108a47 <re_matchp+0x7d>
            return -1;
80108a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a45:	eb 1a                	jmp    80108a61 <re_matchp+0x97>
        
          return idx;
80108a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a4a:	eb 15                	jmp    80108a61 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
80108a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a4f:	8d 50 01             	lea    0x1(%eax),%edx
80108a52:	89 55 0c             	mov    %edx,0xc(%ebp)
80108a55:	0f b6 00             	movzbl (%eax),%eax
80108a58:	84 c0                	test   %al,%al
80108a5a:	75 be                	jne    80108a1a <re_matchp+0x50>
    }
  }
  return -1;
80108a5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108a61:	c9                   	leave  
80108a62:	c3                   	ret    

80108a63 <re_compile>:

re_t re_compile(const char* pattern)
{
80108a63:	55                   	push   %ebp
80108a64:	89 e5                	mov    %esp,%ebp
80108a66:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
80108a69:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
80108a70:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
80108a77:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
80108a7e:	e9 55 02 00 00       	jmp    80108cd8 <re_compile+0x275>
  {
    c = pattern[i];
80108a83:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108a86:	8b 45 08             	mov    0x8(%ebp),%eax
80108a89:	01 d0                	add    %edx,%eax
80108a8b:	0f b6 00             	movzbl (%eax),%eax
80108a8e:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
80108a91:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
80108a95:	83 e8 24             	sub    $0x24,%eax
80108a98:	83 f8 3a             	cmp    $0x3a,%eax
80108a9b:	0f 87 13 02 00 00    	ja     80108cb4 <re_compile+0x251>
80108aa1:	8b 04 85 4c 9a 10 80 	mov    -0x7fef65b4(,%eax,4),%eax
80108aa8:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
80108aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aad:	c6 04 c5 a0 c6 10 80 	movb   $0x2,-0x7fef3960(,%eax,8)
80108ab4:	02 
80108ab5:	e9 16 02 00 00       	jmp    80108cd0 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
80108aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108abd:	c6 04 c5 a0 c6 10 80 	movb   $0x3,-0x7fef3960(,%eax,8)
80108ac4:	03 
80108ac5:	e9 06 02 00 00       	jmp    80108cd0 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
80108aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108acd:	c6 04 c5 a0 c6 10 80 	movb   $0x1,-0x7fef3960(,%eax,8)
80108ad4:	01 
80108ad5:	e9 f6 01 00 00       	jmp    80108cd0 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
80108ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108add:	c6 04 c5 a0 c6 10 80 	movb   $0x5,-0x7fef3960(,%eax,8)
80108ae4:	05 
80108ae5:	e9 e6 01 00 00       	jmp    80108cd0 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
80108aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aed:	c6 04 c5 a0 c6 10 80 	movb   $0x6,-0x7fef3960(,%eax,8)
80108af4:	06 
80108af5:	e9 d6 01 00 00       	jmp    80108cd0 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
80108afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108afd:	c6 04 c5 a0 c6 10 80 	movb   $0x4,-0x7fef3960(,%eax,8)
80108b04:	04 
80108b05:	e9 c6 01 00 00       	jmp    80108cd0 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
80108b0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
80108b0d:	8d 50 01             	lea    0x1(%eax),%edx
80108b10:	8b 45 08             	mov    0x8(%ebp),%eax
80108b13:	01 d0                	add    %edx,%eax
80108b15:	0f b6 00             	movzbl (%eax),%eax
80108b18:	84 c0                	test   %al,%al
80108b1a:	0f 84 af 01 00 00    	je     80108ccf <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
80108b20:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
80108b24:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108b27:	8b 45 08             	mov    0x8(%ebp),%eax
80108b2a:	01 d0                	add    %edx,%eax
80108b2c:	0f b6 00             	movzbl (%eax),%eax
80108b2f:	0f be c0             	movsbl %al,%eax
80108b32:	83 e8 44             	sub    $0x44,%eax
80108b35:	83 f8 33             	cmp    $0x33,%eax
80108b38:	77 57                	ja     80108b91 <re_compile+0x12e>
80108b3a:	8b 04 85 38 9b 10 80 	mov    -0x7fef64c8(,%eax,4),%eax
80108b41:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
80108b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b46:	c6 04 c5 a0 c6 10 80 	movb   $0xa,-0x7fef3960(,%eax,8)
80108b4d:	0a 
80108b4e:	eb 64                	jmp    80108bb4 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
80108b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b53:	c6 04 c5 a0 c6 10 80 	movb   $0xb,-0x7fef3960(,%eax,8)
80108b5a:	0b 
80108b5b:	eb 57                	jmp    80108bb4 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
80108b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b60:	c6 04 c5 a0 c6 10 80 	movb   $0xc,-0x7fef3960(,%eax,8)
80108b67:	0c 
80108b68:	eb 4a                	jmp    80108bb4 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
80108b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b6d:	c6 04 c5 a0 c6 10 80 	movb   $0xd,-0x7fef3960(,%eax,8)
80108b74:	0d 
80108b75:	eb 3d                	jmp    80108bb4 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
80108b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b7a:	c6 04 c5 a0 c6 10 80 	movb   $0xe,-0x7fef3960(,%eax,8)
80108b81:	0e 
80108b82:	eb 30                	jmp    80108bb4 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
80108b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b87:	c6 04 c5 a0 c6 10 80 	movb   $0xf,-0x7fef3960(,%eax,8)
80108b8e:	0f 
80108b8f:	eb 23                	jmp    80108bb4 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
80108b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b94:	c6 04 c5 a0 c6 10 80 	movb   $0x7,-0x7fef3960(,%eax,8)
80108b9b:	07 
              re_compiled[j].ch = pattern[i];
80108b9c:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108b9f:	8b 45 08             	mov    0x8(%ebp),%eax
80108ba2:	01 d0                	add    %edx,%eax
80108ba4:	0f b6 00             	movzbl (%eax),%eax
80108ba7:	89 c2                	mov    %eax,%edx
80108ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bac:	88 14 c5 a4 c6 10 80 	mov    %dl,-0x7fef395c(,%eax,8)
            } break;
80108bb3:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
80108bb4:	e9 16 01 00 00       	jmp    80108ccf <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
80108bb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108bbc:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
80108bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
80108bc2:	8d 50 01             	lea    0x1(%eax),%edx
80108bc5:	8b 45 08             	mov    0x8(%ebp),%eax
80108bc8:	01 d0                	add    %edx,%eax
80108bca:	0f b6 00             	movzbl (%eax),%eax
80108bcd:	3c 5e                	cmp    $0x5e,%al
80108bcf:	75 11                	jne    80108be2 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
80108bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bd4:	c6 04 c5 a0 c6 10 80 	movb   $0x9,-0x7fef3960(,%eax,8)
80108bdb:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
80108bdc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80108be0:	eb 7a                	jmp    80108c5c <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
80108be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108be5:	c6 04 c5 a0 c6 10 80 	movb   $0x8,-0x7fef3960(,%eax,8)
80108bec:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
80108bed:	eb 6d                	jmp    80108c5c <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
80108bef:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108bf2:	8b 45 08             	mov    0x8(%ebp),%eax
80108bf5:	01 d0                	add    %edx,%eax
80108bf7:	0f b6 00             	movzbl (%eax),%eax
80108bfa:	3c 5c                	cmp    $0x5c,%al
80108bfc:	75 34                	jne    80108c32 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
80108bfe:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
80108c02:	7e 0a                	jle    80108c0e <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
80108c04:	b8 00 00 00 00       	mov    $0x0,%eax
80108c09:	e9 f8 00 00 00       	jmp    80108d06 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
80108c0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108c11:	8d 50 01             	lea    0x1(%eax),%edx
80108c14:	89 55 fc             	mov    %edx,-0x4(%ebp)
80108c17:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108c1a:	8d 4a 01             	lea    0x1(%edx),%ecx
80108c1d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80108c20:	89 d1                	mov    %edx,%ecx
80108c22:	8b 55 08             	mov    0x8(%ebp),%edx
80108c25:	01 ca                	add    %ecx,%edx
80108c27:	0f b6 12             	movzbl (%edx),%edx
80108c2a:	88 90 a0 c7 10 80    	mov    %dl,-0x7fef3860(%eax)
80108c30:	eb 10                	jmp    80108c42 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
80108c32:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
80108c36:	7e 0a                	jle    80108c42 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
80108c38:	b8 00 00 00 00       	mov    $0x0,%eax
80108c3d:	e9 c4 00 00 00       	jmp    80108d06 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
80108c42:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108c45:	8d 50 01             	lea    0x1(%eax),%edx
80108c48:	89 55 fc             	mov    %edx,-0x4(%ebp)
80108c4b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
80108c4e:	8b 55 08             	mov    0x8(%ebp),%edx
80108c51:	01 ca                	add    %ecx,%edx
80108c53:	0f b6 12             	movzbl (%edx),%edx
80108c56:	88 90 a0 c7 10 80    	mov    %dl,-0x7fef3860(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
80108c5c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80108c60:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108c63:	8b 45 08             	mov    0x8(%ebp),%eax
80108c66:	01 d0                	add    %edx,%eax
80108c68:	0f b6 00             	movzbl (%eax),%eax
80108c6b:	3c 5d                	cmp    $0x5d,%al
80108c6d:	74 13                	je     80108c82 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
80108c6f:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108c72:	8b 45 08             	mov    0x8(%ebp),%eax
80108c75:	01 d0                	add    %edx,%eax
80108c77:	0f b6 00             	movzbl (%eax),%eax
80108c7a:	84 c0                	test   %al,%al
80108c7c:	0f 85 6d ff ff ff    	jne    80108bef <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
80108c82:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
80108c86:	7e 07                	jle    80108c8f <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
80108c88:	b8 00 00 00 00       	mov    $0x0,%eax
80108c8d:	eb 77                	jmp    80108d06 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
80108c8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108c92:	8d 50 01             	lea    0x1(%eax),%edx
80108c95:	89 55 fc             	mov    %edx,-0x4(%ebp)
80108c98:	c6 80 a0 c7 10 80 00 	movb   $0x0,-0x7fef3860(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
80108c9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108ca2:	8d 90 a0 c7 10 80    	lea    -0x7fef3860(%eax),%edx
80108ca8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cab:	89 14 c5 a4 c6 10 80 	mov    %edx,-0x7fef395c(,%eax,8)
      } break;
80108cb2:	eb 1c                	jmp    80108cd0 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
80108cb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cb7:	c6 04 c5 a0 c6 10 80 	movb   $0x7,-0x7fef3960(,%eax,8)
80108cbe:	07 
        re_compiled[j].ch = c;
80108cbf:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
80108cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cc6:	88 14 c5 a4 c6 10 80 	mov    %dl,-0x7fef395c(,%eax,8)
      } break;
80108ccd:	eb 01                	jmp    80108cd0 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
80108ccf:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
80108cd0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
80108cd4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
80108cd8:	8b 55 f8             	mov    -0x8(%ebp),%edx
80108cdb:	8b 45 08             	mov    0x8(%ebp),%eax
80108cde:	01 d0                	add    %edx,%eax
80108ce0:	0f b6 00             	movzbl (%eax),%eax
80108ce3:	84 c0                	test   %al,%al
80108ce5:	74 0f                	je     80108cf6 <re_compile+0x293>
80108ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cea:	83 c0 01             	add    $0x1,%eax
80108ced:	83 f8 1d             	cmp    $0x1d,%eax
80108cf0:	0f 8e 8d fd ff ff    	jle    80108a83 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
80108cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cf9:	c6 04 c5 a0 c6 10 80 	movb   $0x0,-0x7fef3960(,%eax,8)
80108d00:	00 

  return (re_t) re_compiled;
80108d01:	b8 a0 c6 10 80       	mov    $0x8010c6a0,%eax
}
80108d06:	c9                   	leave  
80108d07:	c3                   	ret    

80108d08 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
80108d08:	55                   	push   %ebp
80108d09:	89 e5                	mov    %esp,%ebp
80108d0b:	83 ec 04             	sub    $0x4,%esp
80108d0e:	8b 45 08             	mov    0x8(%ebp),%eax
80108d11:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
80108d14:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
80108d18:	7e 0d                	jle    80108d27 <matchdigit+0x1f>
80108d1a:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
80108d1e:	7f 07                	jg     80108d27 <matchdigit+0x1f>
80108d20:	b8 01 00 00 00       	mov    $0x1,%eax
80108d25:	eb 05                	jmp    80108d2c <matchdigit+0x24>
80108d27:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108d2c:	c9                   	leave  
80108d2d:	c3                   	ret    

80108d2e <matchalpha>:
static int matchalpha(char c)
{
80108d2e:	55                   	push   %ebp
80108d2f:	89 e5                	mov    %esp,%ebp
80108d31:	83 ec 04             	sub    $0x4,%esp
80108d34:	8b 45 08             	mov    0x8(%ebp),%eax
80108d37:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
80108d3a:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
80108d3e:	7e 06                	jle    80108d46 <matchalpha+0x18>
80108d40:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
80108d44:	7e 0c                	jle    80108d52 <matchalpha+0x24>
80108d46:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
80108d4a:	7e 0d                	jle    80108d59 <matchalpha+0x2b>
80108d4c:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
80108d50:	7f 07                	jg     80108d59 <matchalpha+0x2b>
80108d52:	b8 01 00 00 00       	mov    $0x1,%eax
80108d57:	eb 05                	jmp    80108d5e <matchalpha+0x30>
80108d59:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108d5e:	c9                   	leave  
80108d5f:	c3                   	ret    

80108d60 <matchwhitespace>:
static int matchwhitespace(char c)
{
80108d60:	55                   	push   %ebp
80108d61:	89 e5                	mov    %esp,%ebp
80108d63:	83 ec 04             	sub    $0x4,%esp
80108d66:	8b 45 08             	mov    0x8(%ebp),%eax
80108d69:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
80108d6c:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
80108d70:	74 1e                	je     80108d90 <matchwhitespace+0x30>
80108d72:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
80108d76:	74 18                	je     80108d90 <matchwhitespace+0x30>
80108d78:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
80108d7c:	74 12                	je     80108d90 <matchwhitespace+0x30>
80108d7e:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
80108d82:	74 0c                	je     80108d90 <matchwhitespace+0x30>
80108d84:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
80108d88:	74 06                	je     80108d90 <matchwhitespace+0x30>
80108d8a:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
80108d8e:	75 07                	jne    80108d97 <matchwhitespace+0x37>
80108d90:	b8 01 00 00 00       	mov    $0x1,%eax
80108d95:	eb 05                	jmp    80108d9c <matchwhitespace+0x3c>
80108d97:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108d9c:	c9                   	leave  
80108d9d:	c3                   	ret    

80108d9e <matchalphanum>:
static int matchalphanum(char c)
{
80108d9e:	55                   	push   %ebp
80108d9f:	89 e5                	mov    %esp,%ebp
80108da1:	83 ec 04             	sub    $0x4,%esp
80108da4:	8b 45 08             	mov    0x8(%ebp),%eax
80108da7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
80108daa:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
80108dae:	74 22                	je     80108dd2 <matchalphanum+0x34>
80108db0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108db4:	50                   	push   %eax
80108db5:	e8 74 ff ff ff       	call   80108d2e <matchalpha>
80108dba:	83 c4 04             	add    $0x4,%esp
80108dbd:	85 c0                	test   %eax,%eax
80108dbf:	75 11                	jne    80108dd2 <matchalphanum+0x34>
80108dc1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108dc5:	50                   	push   %eax
80108dc6:	e8 3d ff ff ff       	call   80108d08 <matchdigit>
80108dcb:	83 c4 04             	add    $0x4,%esp
80108dce:	85 c0                	test   %eax,%eax
80108dd0:	74 07                	je     80108dd9 <matchalphanum+0x3b>
80108dd2:	b8 01 00 00 00       	mov    $0x1,%eax
80108dd7:	eb 05                	jmp    80108dde <matchalphanum+0x40>
80108dd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108dde:	c9                   	leave  
80108ddf:	c3                   	ret    

80108de0 <matchrange>:
static int matchrange(char c, const char* str)
{
80108de0:	55                   	push   %ebp
80108de1:	89 e5                	mov    %esp,%ebp
80108de3:	83 ec 04             	sub    $0x4,%esp
80108de6:	8b 45 08             	mov    0x8(%ebp),%eax
80108de9:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
80108dec:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
80108df0:	74 5b                	je     80108e4d <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
80108df2:	8b 45 0c             	mov    0xc(%ebp),%eax
80108df5:	0f b6 00             	movzbl (%eax),%eax
80108df8:	84 c0                	test   %al,%al
80108dfa:	74 51                	je     80108e4d <matchrange+0x6d>
80108dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80108dff:	0f b6 00             	movzbl (%eax),%eax
80108e02:	3c 2d                	cmp    $0x2d,%al
80108e04:	74 47                	je     80108e4d <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
80108e06:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e09:	83 c0 01             	add    $0x1,%eax
80108e0c:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
80108e0f:	3c 2d                	cmp    $0x2d,%al
80108e11:	75 3a                	jne    80108e4d <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
80108e13:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e16:	83 c0 01             	add    $0x1,%eax
80108e19:	0f b6 00             	movzbl (%eax),%eax
80108e1c:	84 c0                	test   %al,%al
80108e1e:	74 2d                	je     80108e4d <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
80108e20:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e23:	83 c0 02             	add    $0x2,%eax
80108e26:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
80108e29:	84 c0                	test   %al,%al
80108e2b:	74 20                	je     80108e4d <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
80108e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e30:	0f b6 00             	movzbl (%eax),%eax
80108e33:	3a 45 fc             	cmp    -0x4(%ebp),%al
80108e36:	7f 15                	jg     80108e4d <matchrange+0x6d>
80108e38:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e3b:	83 c0 02             	add    $0x2,%eax
80108e3e:	0f b6 00             	movzbl (%eax),%eax
80108e41:	3a 45 fc             	cmp    -0x4(%ebp),%al
80108e44:	7c 07                	jl     80108e4d <matchrange+0x6d>
80108e46:	b8 01 00 00 00       	mov    $0x1,%eax
80108e4b:	eb 05                	jmp    80108e52 <matchrange+0x72>
80108e4d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108e52:	c9                   	leave  
80108e53:	c3                   	ret    

80108e54 <ismetachar>:
static int ismetachar(char c)
{
80108e54:	55                   	push   %ebp
80108e55:	89 e5                	mov    %esp,%ebp
80108e57:	83 ec 04             	sub    $0x4,%esp
80108e5a:	8b 45 08             	mov    0x8(%ebp),%eax
80108e5d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
80108e60:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
80108e64:	74 1e                	je     80108e84 <ismetachar+0x30>
80108e66:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
80108e6a:	74 18                	je     80108e84 <ismetachar+0x30>
80108e6c:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
80108e70:	74 12                	je     80108e84 <ismetachar+0x30>
80108e72:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
80108e76:	74 0c                	je     80108e84 <ismetachar+0x30>
80108e78:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
80108e7c:	74 06                	je     80108e84 <ismetachar+0x30>
80108e7e:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
80108e82:	75 07                	jne    80108e8b <ismetachar+0x37>
80108e84:	b8 01 00 00 00       	mov    $0x1,%eax
80108e89:	eb 05                	jmp    80108e90 <ismetachar+0x3c>
80108e8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108e90:	c9                   	leave  
80108e91:	c3                   	ret    

80108e92 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
80108e92:	55                   	push   %ebp
80108e93:	89 e5                	mov    %esp,%ebp
80108e95:	83 ec 04             	sub    $0x4,%esp
80108e98:	8b 45 08             	mov    0x8(%ebp),%eax
80108e9b:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
80108e9e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ea1:	0f b6 00             	movzbl (%eax),%eax
80108ea4:	0f be c0             	movsbl %al,%eax
80108ea7:	83 e8 44             	sub    $0x44,%eax
80108eaa:	83 f8 33             	cmp    $0x33,%eax
80108ead:	77 7b                	ja     80108f2a <matchmetachar+0x98>
80108eaf:	8b 04 85 08 9c 10 80 	mov    -0x7fef63f8(,%eax,4),%eax
80108eb6:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
80108eb8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108ebc:	50                   	push   %eax
80108ebd:	e8 46 fe ff ff       	call   80108d08 <matchdigit>
80108ec2:	83 c4 04             	add    $0x4,%esp
80108ec5:	eb 72                	jmp    80108f39 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
80108ec7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108ecb:	50                   	push   %eax
80108ecc:	e8 37 fe ff ff       	call   80108d08 <matchdigit>
80108ed1:	83 c4 04             	add    $0x4,%esp
80108ed4:	85 c0                	test   %eax,%eax
80108ed6:	0f 94 c0             	sete   %al
80108ed9:	0f b6 c0             	movzbl %al,%eax
80108edc:	eb 5b                	jmp    80108f39 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
80108ede:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108ee2:	50                   	push   %eax
80108ee3:	e8 b6 fe ff ff       	call   80108d9e <matchalphanum>
80108ee8:	83 c4 04             	add    $0x4,%esp
80108eeb:	eb 4c                	jmp    80108f39 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
80108eed:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108ef1:	50                   	push   %eax
80108ef2:	e8 a7 fe ff ff       	call   80108d9e <matchalphanum>
80108ef7:	83 c4 04             	add    $0x4,%esp
80108efa:	85 c0                	test   %eax,%eax
80108efc:	0f 94 c0             	sete   %al
80108eff:	0f b6 c0             	movzbl %al,%eax
80108f02:	eb 35                	jmp    80108f39 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
80108f04:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108f08:	50                   	push   %eax
80108f09:	e8 52 fe ff ff       	call   80108d60 <matchwhitespace>
80108f0e:	83 c4 04             	add    $0x4,%esp
80108f11:	eb 26                	jmp    80108f39 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
80108f13:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108f17:	50                   	push   %eax
80108f18:	e8 43 fe ff ff       	call   80108d60 <matchwhitespace>
80108f1d:	83 c4 04             	add    $0x4,%esp
80108f20:	85 c0                	test   %eax,%eax
80108f22:	0f 94 c0             	sete   %al
80108f25:	0f b6 c0             	movzbl %al,%eax
80108f28:	eb 0f                	jmp    80108f39 <matchmetachar+0xa7>
    default:  return (c == str[0]);
80108f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f2d:	0f b6 00             	movzbl (%eax),%eax
80108f30:	3a 45 fc             	cmp    -0x4(%ebp),%al
80108f33:	0f 94 c0             	sete   %al
80108f36:	0f b6 c0             	movzbl %al,%eax
  }
}
80108f39:	c9                   	leave  
80108f3a:	c3                   	ret    

80108f3b <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
80108f3b:	55                   	push   %ebp
80108f3c:	89 e5                	mov    %esp,%ebp
80108f3e:	83 ec 04             	sub    $0x4,%esp
80108f41:	8b 45 08             	mov    0x8(%ebp),%eax
80108f44:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
80108f47:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108f4b:	ff 75 0c             	pushl  0xc(%ebp)
80108f4e:	50                   	push   %eax
80108f4f:	e8 8c fe ff ff       	call   80108de0 <matchrange>
80108f54:	83 c4 08             	add    $0x8,%esp
80108f57:	85 c0                	test   %eax,%eax
80108f59:	74 0a                	je     80108f65 <matchcharclass+0x2a>
    {
      return 1;
80108f5b:	b8 01 00 00 00       	mov    $0x1,%eax
80108f60:	e9 a5 00 00 00       	jmp    8010900a <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
80108f65:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f68:	0f b6 00             	movzbl (%eax),%eax
80108f6b:	3c 5c                	cmp    $0x5c,%al
80108f6d:	75 42                	jne    80108fb1 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
80108f6f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
80108f73:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108f77:	ff 75 0c             	pushl  0xc(%ebp)
80108f7a:	50                   	push   %eax
80108f7b:	e8 12 ff ff ff       	call   80108e92 <matchmetachar>
80108f80:	83 c4 08             	add    $0x8,%esp
80108f83:	85 c0                	test   %eax,%eax
80108f85:	74 07                	je     80108f8e <matchcharclass+0x53>
      {
        return 1;
80108f87:	b8 01 00 00 00       	mov    $0x1,%eax
80108f8c:	eb 7c                	jmp    8010900a <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
80108f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f91:	0f b6 00             	movzbl (%eax),%eax
80108f94:	3a 45 fc             	cmp    -0x4(%ebp),%al
80108f97:	75 58                	jne    80108ff1 <matchcharclass+0xb6>
80108f99:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80108f9d:	50                   	push   %eax
80108f9e:	e8 b1 fe ff ff       	call   80108e54 <ismetachar>
80108fa3:	83 c4 04             	add    $0x4,%esp
80108fa6:	85 c0                	test   %eax,%eax
80108fa8:	75 47                	jne    80108ff1 <matchcharclass+0xb6>
      {
        return 1;
80108faa:	b8 01 00 00 00       	mov    $0x1,%eax
80108faf:	eb 59                	jmp    8010900a <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
80108fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fb4:	0f b6 00             	movzbl (%eax),%eax
80108fb7:	3a 45 fc             	cmp    -0x4(%ebp),%al
80108fba:	75 35                	jne    80108ff1 <matchcharclass+0xb6>
    {
      if (c == '-')
80108fbc:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
80108fc0:	75 28                	jne    80108fea <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
80108fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fc5:	83 e8 01             	sub    $0x1,%eax
80108fc8:	0f b6 00             	movzbl (%eax),%eax
80108fcb:	84 c0                	test   %al,%al
80108fcd:	74 0d                	je     80108fdc <matchcharclass+0xa1>
80108fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fd2:	83 c0 01             	add    $0x1,%eax
80108fd5:	0f b6 00             	movzbl (%eax),%eax
80108fd8:	84 c0                	test   %al,%al
80108fda:	75 07                	jne    80108fe3 <matchcharclass+0xa8>
80108fdc:	b8 01 00 00 00       	mov    $0x1,%eax
80108fe1:	eb 27                	jmp    8010900a <matchcharclass+0xcf>
80108fe3:	b8 00 00 00 00       	mov    $0x0,%eax
80108fe8:	eb 20                	jmp    8010900a <matchcharclass+0xcf>
      }
      else
      {
        return 1;
80108fea:	b8 01 00 00 00       	mov    $0x1,%eax
80108fef:	eb 19                	jmp    8010900a <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
80108ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ff4:	8d 50 01             	lea    0x1(%eax),%edx
80108ff7:	89 55 0c             	mov    %edx,0xc(%ebp)
80108ffa:	0f b6 00             	movzbl (%eax),%eax
80108ffd:	84 c0                	test   %al,%al
80108fff:	0f 85 42 ff ff ff    	jne    80108f47 <matchcharclass+0xc>

  return 0;
80109005:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010900a:	c9                   	leave  
8010900b:	c3                   	ret    

8010900c <matchone>:

static int matchone(regex_t p, char c)
{
8010900c:	55                   	push   %ebp
8010900d:	89 e5                	mov    %esp,%ebp
8010900f:	83 ec 04             	sub    $0x4,%esp
80109012:	8b 45 10             	mov    0x10(%ebp),%eax
80109015:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
80109018:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
8010901c:	0f b6 c0             	movzbl %al,%eax
8010901f:	83 f8 0f             	cmp    $0xf,%eax
80109022:	0f 87 b9 00 00 00    	ja     801090e1 <matchone+0xd5>
80109028:	8b 04 85 d8 9c 10 80 	mov    -0x7fef6328(,%eax,4),%eax
8010902f:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
80109031:	b8 01 00 00 00       	mov    $0x1,%eax
80109036:	e9 b9 00 00 00       	jmp    801090f4 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
8010903b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010903e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80109042:	52                   	push   %edx
80109043:	50                   	push   %eax
80109044:	e8 f2 fe ff ff       	call   80108f3b <matchcharclass>
80109049:	83 c4 08             	add    $0x8,%esp
8010904c:	e9 a3 00 00 00       	jmp    801090f4 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
80109051:	8b 55 0c             	mov    0xc(%ebp),%edx
80109054:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80109058:	52                   	push   %edx
80109059:	50                   	push   %eax
8010905a:	e8 dc fe ff ff       	call   80108f3b <matchcharclass>
8010905f:	83 c4 08             	add    $0x8,%esp
80109062:	85 c0                	test   %eax,%eax
80109064:	0f 94 c0             	sete   %al
80109067:	0f b6 c0             	movzbl %al,%eax
8010906a:	e9 85 00 00 00       	jmp    801090f4 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
8010906f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80109073:	50                   	push   %eax
80109074:	e8 8f fc ff ff       	call   80108d08 <matchdigit>
80109079:	83 c4 04             	add    $0x4,%esp
8010907c:	eb 76                	jmp    801090f4 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
8010907e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80109082:	50                   	push   %eax
80109083:	e8 80 fc ff ff       	call   80108d08 <matchdigit>
80109088:	83 c4 04             	add    $0x4,%esp
8010908b:	85 c0                	test   %eax,%eax
8010908d:	0f 94 c0             	sete   %al
80109090:	0f b6 c0             	movzbl %al,%eax
80109093:	eb 5f                	jmp    801090f4 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
80109095:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
80109099:	50                   	push   %eax
8010909a:	e8 ff fc ff ff       	call   80108d9e <matchalphanum>
8010909f:	83 c4 04             	add    $0x4,%esp
801090a2:	eb 50                	jmp    801090f4 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
801090a4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
801090a8:	50                   	push   %eax
801090a9:	e8 f0 fc ff ff       	call   80108d9e <matchalphanum>
801090ae:	83 c4 04             	add    $0x4,%esp
801090b1:	85 c0                	test   %eax,%eax
801090b3:	0f 94 c0             	sete   %al
801090b6:	0f b6 c0             	movzbl %al,%eax
801090b9:	eb 39                	jmp    801090f4 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
801090bb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
801090bf:	50                   	push   %eax
801090c0:	e8 9b fc ff ff       	call   80108d60 <matchwhitespace>
801090c5:	83 c4 04             	add    $0x4,%esp
801090c8:	eb 2a                	jmp    801090f4 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
801090ca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
801090ce:	50                   	push   %eax
801090cf:	e8 8c fc ff ff       	call   80108d60 <matchwhitespace>
801090d4:	83 c4 04             	add    $0x4,%esp
801090d7:	85 c0                	test   %eax,%eax
801090d9:	0f 94 c0             	sete   %al
801090dc:	0f b6 c0             	movzbl %al,%eax
801090df:	eb 13                	jmp    801090f4 <matchone+0xe8>
    default:             return  (p.ch == c);
801090e1:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
801090e5:	0f b6 d0             	movzbl %al,%edx
801090e8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
801090ec:	39 c2                	cmp    %eax,%edx
801090ee:	0f 94 c0             	sete   %al
801090f1:	0f b6 c0             	movzbl %al,%eax
  }
}
801090f4:	c9                   	leave  
801090f5:	c3                   	ret    

801090f6 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
801090f6:	55                   	push   %ebp
801090f7:	89 e5                	mov    %esp,%ebp
801090f9:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
801090fc:	8b 45 18             	mov    0x18(%ebp),%eax
801090ff:	8b 00                	mov    (%eax),%eax
80109101:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
80109104:	8b 45 14             	mov    0x14(%ebp),%eax
80109107:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
8010910a:	eb 11                	jmp    8010911d <matchstar+0x27>
  {
    text++;
8010910c:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
80109110:	8b 45 18             	mov    0x18(%ebp),%eax
80109113:	8b 00                	mov    (%eax),%eax
80109115:	8d 50 01             	lea    0x1(%eax),%edx
80109118:	8b 45 18             	mov    0x18(%ebp),%eax
8010911b:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
8010911d:	8b 45 14             	mov    0x14(%ebp),%eax
80109120:	0f b6 00             	movzbl (%eax),%eax
80109123:	84 c0                	test   %al,%al
80109125:	74 51                	je     80109178 <matchstar+0x82>
80109127:	8b 45 14             	mov    0x14(%ebp),%eax
8010912a:	0f b6 00             	movzbl (%eax),%eax
8010912d:	0f be c0             	movsbl %al,%eax
80109130:	50                   	push   %eax
80109131:	ff 75 0c             	pushl  0xc(%ebp)
80109134:	ff 75 08             	pushl  0x8(%ebp)
80109137:	e8 d0 fe ff ff       	call   8010900c <matchone>
8010913c:	83 c4 0c             	add    $0xc,%esp
8010913f:	85 c0                	test   %eax,%eax
80109141:	75 c9                	jne    8010910c <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
80109143:	eb 33                	jmp    80109178 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
80109145:	8b 45 14             	mov    0x14(%ebp),%eax
80109148:	8d 50 ff             	lea    -0x1(%eax),%edx
8010914b:	89 55 14             	mov    %edx,0x14(%ebp)
8010914e:	83 ec 04             	sub    $0x4,%esp
80109151:	ff 75 18             	pushl  0x18(%ebp)
80109154:	50                   	push   %eax
80109155:	ff 75 10             	pushl  0x10(%ebp)
80109158:	e8 51 01 00 00       	call   801092ae <matchpattern>
8010915d:	83 c4 10             	add    $0x10,%esp
80109160:	85 c0                	test   %eax,%eax
80109162:	74 07                	je     8010916b <matchstar+0x75>
      return 1;
80109164:	b8 01 00 00 00       	mov    $0x1,%eax
80109169:	eb 22                	jmp    8010918d <matchstar+0x97>
    (*matchlength)--;
8010916b:	8b 45 18             	mov    0x18(%ebp),%eax
8010916e:	8b 00                	mov    (%eax),%eax
80109170:	8d 50 ff             	lea    -0x1(%eax),%edx
80109173:	8b 45 18             	mov    0x18(%ebp),%eax
80109176:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
80109178:	8b 45 14             	mov    0x14(%ebp),%eax
8010917b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010917e:	73 c5                	jae    80109145 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
80109180:	8b 45 18             	mov    0x18(%ebp),%eax
80109183:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109186:	89 10                	mov    %edx,(%eax)
  return 0;
80109188:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010918d:	c9                   	leave  
8010918e:	c3                   	ret    

8010918f <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
8010918f:	55                   	push   %ebp
80109190:	89 e5                	mov    %esp,%ebp
80109192:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
80109195:	8b 45 14             	mov    0x14(%ebp),%eax
80109198:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
8010919b:	eb 11                	jmp    801091ae <matchplus+0x1f>
  {
    text++;
8010919d:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
801091a1:	8b 45 18             	mov    0x18(%ebp),%eax
801091a4:	8b 00                	mov    (%eax),%eax
801091a6:	8d 50 01             	lea    0x1(%eax),%edx
801091a9:	8b 45 18             	mov    0x18(%ebp),%eax
801091ac:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
801091ae:	8b 45 14             	mov    0x14(%ebp),%eax
801091b1:	0f b6 00             	movzbl (%eax),%eax
801091b4:	84 c0                	test   %al,%al
801091b6:	74 51                	je     80109209 <matchplus+0x7a>
801091b8:	8b 45 14             	mov    0x14(%ebp),%eax
801091bb:	0f b6 00             	movzbl (%eax),%eax
801091be:	0f be c0             	movsbl %al,%eax
801091c1:	50                   	push   %eax
801091c2:	ff 75 0c             	pushl  0xc(%ebp)
801091c5:	ff 75 08             	pushl  0x8(%ebp)
801091c8:	e8 3f fe ff ff       	call   8010900c <matchone>
801091cd:	83 c4 0c             	add    $0xc,%esp
801091d0:	85 c0                	test   %eax,%eax
801091d2:	75 c9                	jne    8010919d <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
801091d4:	eb 33                	jmp    80109209 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
801091d6:	8b 45 14             	mov    0x14(%ebp),%eax
801091d9:	8d 50 ff             	lea    -0x1(%eax),%edx
801091dc:	89 55 14             	mov    %edx,0x14(%ebp)
801091df:	83 ec 04             	sub    $0x4,%esp
801091e2:	ff 75 18             	pushl  0x18(%ebp)
801091e5:	50                   	push   %eax
801091e6:	ff 75 10             	pushl  0x10(%ebp)
801091e9:	e8 c0 00 00 00       	call   801092ae <matchpattern>
801091ee:	83 c4 10             	add    $0x10,%esp
801091f1:	85 c0                	test   %eax,%eax
801091f3:	74 07                	je     801091fc <matchplus+0x6d>
      return 1;
801091f5:	b8 01 00 00 00       	mov    $0x1,%eax
801091fa:	eb 1a                	jmp    80109216 <matchplus+0x87>
    (*matchlength)--;
801091fc:	8b 45 18             	mov    0x18(%ebp),%eax
801091ff:	8b 00                	mov    (%eax),%eax
80109201:	8d 50 ff             	lea    -0x1(%eax),%edx
80109204:	8b 45 18             	mov    0x18(%ebp),%eax
80109207:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
80109209:	8b 45 14             	mov    0x14(%ebp),%eax
8010920c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010920f:	77 c5                	ja     801091d6 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
80109211:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109216:	c9                   	leave  
80109217:	c3                   	ret    

80109218 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
80109218:	55                   	push   %ebp
80109219:	89 e5                	mov    %esp,%ebp
8010921b:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
8010921e:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80109222:	84 c0                	test   %al,%al
80109224:	75 07                	jne    8010922d <matchquestion+0x15>
    return 1;
80109226:	b8 01 00 00 00       	mov    $0x1,%eax
8010922b:	eb 7f                	jmp    801092ac <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
8010922d:	83 ec 04             	sub    $0x4,%esp
80109230:	ff 75 18             	pushl  0x18(%ebp)
80109233:	ff 75 14             	pushl  0x14(%ebp)
80109236:	ff 75 10             	pushl  0x10(%ebp)
80109239:	e8 70 00 00 00       	call   801092ae <matchpattern>
8010923e:	83 c4 10             	add    $0x10,%esp
80109241:	85 c0                	test   %eax,%eax
80109243:	74 07                	je     8010924c <matchquestion+0x34>
      return 1;
80109245:	b8 01 00 00 00       	mov    $0x1,%eax
8010924a:	eb 60                	jmp    801092ac <matchquestion+0x94>
  if (*text && matchone(p, *text++))
8010924c:	8b 45 14             	mov    0x14(%ebp),%eax
8010924f:	0f b6 00             	movzbl (%eax),%eax
80109252:	84 c0                	test   %al,%al
80109254:	74 51                	je     801092a7 <matchquestion+0x8f>
80109256:	8b 45 14             	mov    0x14(%ebp),%eax
80109259:	8d 50 01             	lea    0x1(%eax),%edx
8010925c:	89 55 14             	mov    %edx,0x14(%ebp)
8010925f:	0f b6 00             	movzbl (%eax),%eax
80109262:	0f be c0             	movsbl %al,%eax
80109265:	83 ec 04             	sub    $0x4,%esp
80109268:	50                   	push   %eax
80109269:	ff 75 0c             	pushl  0xc(%ebp)
8010926c:	ff 75 08             	pushl  0x8(%ebp)
8010926f:	e8 98 fd ff ff       	call   8010900c <matchone>
80109274:	83 c4 10             	add    $0x10,%esp
80109277:	85 c0                	test   %eax,%eax
80109279:	74 2c                	je     801092a7 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
8010927b:	83 ec 04             	sub    $0x4,%esp
8010927e:	ff 75 18             	pushl  0x18(%ebp)
80109281:	ff 75 14             	pushl  0x14(%ebp)
80109284:	ff 75 10             	pushl  0x10(%ebp)
80109287:	e8 22 00 00 00       	call   801092ae <matchpattern>
8010928c:	83 c4 10             	add    $0x10,%esp
8010928f:	85 c0                	test   %eax,%eax
80109291:	74 14                	je     801092a7 <matchquestion+0x8f>
    {
      (*matchlength)++;
80109293:	8b 45 18             	mov    0x18(%ebp),%eax
80109296:	8b 00                	mov    (%eax),%eax
80109298:	8d 50 01             	lea    0x1(%eax),%edx
8010929b:	8b 45 18             	mov    0x18(%ebp),%eax
8010929e:	89 10                	mov    %edx,(%eax)
      return 1;
801092a0:	b8 01 00 00 00       	mov    $0x1,%eax
801092a5:	eb 05                	jmp    801092ac <matchquestion+0x94>
    }
  }
  return 0;
801092a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801092ac:	c9                   	leave  
801092ad:	c3                   	ret    

801092ae <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
801092ae:	55                   	push   %ebp
801092af:	89 e5                	mov    %esp,%ebp
801092b1:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
801092b4:	8b 45 10             	mov    0x10(%ebp),%eax
801092b7:	8b 00                	mov    (%eax),%eax
801092b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
801092bc:	8b 45 08             	mov    0x8(%ebp),%eax
801092bf:	0f b6 00             	movzbl (%eax),%eax
801092c2:	84 c0                	test   %al,%al
801092c4:	74 0d                	je     801092d3 <matchpattern+0x25>
801092c6:	8b 45 08             	mov    0x8(%ebp),%eax
801092c9:	83 c0 08             	add    $0x8,%eax
801092cc:	0f b6 00             	movzbl (%eax),%eax
801092cf:	3c 04                	cmp    $0x4,%al
801092d1:	75 25                	jne    801092f8 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
801092d3:	8b 45 08             	mov    0x8(%ebp),%eax
801092d6:	83 c0 10             	add    $0x10,%eax
801092d9:	83 ec 0c             	sub    $0xc,%esp
801092dc:	ff 75 10             	pushl  0x10(%ebp)
801092df:	ff 75 0c             	pushl  0xc(%ebp)
801092e2:	50                   	push   %eax
801092e3:	8b 45 08             	mov    0x8(%ebp),%eax
801092e6:	ff 70 04             	pushl  0x4(%eax)
801092e9:	ff 30                	pushl  (%eax)
801092eb:	e8 28 ff ff ff       	call   80109218 <matchquestion>
801092f0:	83 c4 20             	add    $0x20,%esp
801092f3:	e9 dd 00 00 00       	jmp    801093d5 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
801092f8:	8b 45 08             	mov    0x8(%ebp),%eax
801092fb:	83 c0 08             	add    $0x8,%eax
801092fe:	0f b6 00             	movzbl (%eax),%eax
80109301:	3c 05                	cmp    $0x5,%al
80109303:	75 25                	jne    8010932a <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
80109305:	8b 45 08             	mov    0x8(%ebp),%eax
80109308:	83 c0 10             	add    $0x10,%eax
8010930b:	83 ec 0c             	sub    $0xc,%esp
8010930e:	ff 75 10             	pushl  0x10(%ebp)
80109311:	ff 75 0c             	pushl  0xc(%ebp)
80109314:	50                   	push   %eax
80109315:	8b 45 08             	mov    0x8(%ebp),%eax
80109318:	ff 70 04             	pushl  0x4(%eax)
8010931b:	ff 30                	pushl  (%eax)
8010931d:	e8 d4 fd ff ff       	call   801090f6 <matchstar>
80109322:	83 c4 20             	add    $0x20,%esp
80109325:	e9 ab 00 00 00       	jmp    801093d5 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
8010932a:	8b 45 08             	mov    0x8(%ebp),%eax
8010932d:	83 c0 08             	add    $0x8,%eax
80109330:	0f b6 00             	movzbl (%eax),%eax
80109333:	3c 06                	cmp    $0x6,%al
80109335:	75 22                	jne    80109359 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
80109337:	8b 45 08             	mov    0x8(%ebp),%eax
8010933a:	83 c0 10             	add    $0x10,%eax
8010933d:	83 ec 0c             	sub    $0xc,%esp
80109340:	ff 75 10             	pushl  0x10(%ebp)
80109343:	ff 75 0c             	pushl  0xc(%ebp)
80109346:	50                   	push   %eax
80109347:	8b 45 08             	mov    0x8(%ebp),%eax
8010934a:	ff 70 04             	pushl  0x4(%eax)
8010934d:	ff 30                	pushl  (%eax)
8010934f:	e8 3b fe ff ff       	call   8010918f <matchplus>
80109354:	83 c4 20             	add    $0x20,%esp
80109357:	eb 7c                	jmp    801093d5 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
80109359:	8b 45 08             	mov    0x8(%ebp),%eax
8010935c:	0f b6 00             	movzbl (%eax),%eax
8010935f:	3c 03                	cmp    $0x3,%al
80109361:	75 1d                	jne    80109380 <matchpattern+0xd2>
80109363:	8b 45 08             	mov    0x8(%ebp),%eax
80109366:	83 c0 08             	add    $0x8,%eax
80109369:	0f b6 00             	movzbl (%eax),%eax
8010936c:	84 c0                	test   %al,%al
8010936e:	75 10                	jne    80109380 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
80109370:	8b 45 0c             	mov    0xc(%ebp),%eax
80109373:	0f b6 00             	movzbl (%eax),%eax
80109376:	84 c0                	test   %al,%al
80109378:	0f 94 c0             	sete   %al
8010937b:	0f b6 c0             	movzbl %al,%eax
8010937e:	eb 55                	jmp    801093d5 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
80109380:	8b 45 10             	mov    0x10(%ebp),%eax
80109383:	8b 00                	mov    (%eax),%eax
80109385:	8d 50 01             	lea    0x1(%eax),%edx
80109388:	8b 45 10             	mov    0x10(%ebp),%eax
8010938b:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
8010938d:	8b 45 0c             	mov    0xc(%ebp),%eax
80109390:	0f b6 00             	movzbl (%eax),%eax
80109393:	84 c0                	test   %al,%al
80109395:	74 31                	je     801093c8 <matchpattern+0x11a>
80109397:	8b 45 0c             	mov    0xc(%ebp),%eax
8010939a:	8d 50 01             	lea    0x1(%eax),%edx
8010939d:	89 55 0c             	mov    %edx,0xc(%ebp)
801093a0:	0f b6 00             	movzbl (%eax),%eax
801093a3:	0f be d0             	movsbl %al,%edx
801093a6:	8b 45 08             	mov    0x8(%ebp),%eax
801093a9:	8d 48 08             	lea    0x8(%eax),%ecx
801093ac:	89 4d 08             	mov    %ecx,0x8(%ebp)
801093af:	83 ec 04             	sub    $0x4,%esp
801093b2:	52                   	push   %edx
801093b3:	ff 70 04             	pushl  0x4(%eax)
801093b6:	ff 30                	pushl  (%eax)
801093b8:	e8 4f fc ff ff       	call   8010900c <matchone>
801093bd:	83 c4 10             	add    $0x10,%esp
801093c0:	85 c0                	test   %eax,%eax
801093c2:	0f 85 f4 fe ff ff    	jne    801092bc <matchpattern+0xe>

  *matchlength = pre;
801093c8:	8b 45 10             	mov    0x10(%ebp),%eax
801093cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801093ce:	89 10                	mov    %edx,(%eax)
  return 0;
801093d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801093d5:	c9                   	leave  
801093d6:	c3                   	ret    
