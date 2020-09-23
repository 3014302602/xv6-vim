#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "re.h"

// 宏定义
#define NULL 0
#define true ((int)1)
#define false ((int)0)
#define findStringLength 32 	// 查找功能能查找的最大字符串（包括'\0')长度

// -------------------------------------------------------------
// 在xv6中，使用read()读取的特殊按键对应的int值
#define VI_K_UP			226	// -30 cursor key Up
#define VI_K_DOWN		227	// -29 cursor key Down
#define VI_K_LEFT		228	// -27 cursor key Left
#define VI_K_RIGHT		229	// -28 Cursor Key Right
#define VI_K_PAGEUP		230	// -26 Cursor Key Page Up
#define VI_K_PAGEDN		231	// -25 Cursor Key Page Down

#define VI_K_END		225	// -31 Cursor Key End
#define VI_K_INSERT		232	// -24 Cursor Key Insert
#define VI_K_DELETE		233	// -23 Cursor Key Insert

#define VI_K_ESC		27
#define VI_K_TAB		9
#define VI_K_ENTER		10
// -------------------------------------------------------------
// color
#define BLACK               0//0x0
#define BLUE                1//0x1
#define GREEN               2//0x2
#define CYAN                3//0x3
#define RED                 4//0x4
#define PURPLE              5//0x5
#define BROWN               6//0x6
#define GREY                7//0x7
#define DARK_GREY           8//0x8
#define LIGHT_BLUE          9//0x9
#define LIGHT_GREEN         10//0xa
#define LIGHT_CYAN          11//0xb
#define LIGHT_RED           12//0xc
#define LIGHT_PURPLE        13//0xd
#define YELLOW              14//0xe
#define WHITE               15//0xf
// -------------------------------------------------------------
// 全局变量	
int rows, columns;			// vi 占用的窗口大小. rows=24,columns=80

int editing;				// >0时，处于编辑状态。=0时退出程序
int hasChanged;				// 缓存是否被修改过。

char *status_buffer;	   	//　状态栏,一个128字节的空间

char *text, *end, *textend;	// 文本信息
char *screenbegin;			
char *dot;					// 通常情况下，光标所在的位置的字符的指针就是dot，所有动作都发生在dot处

char* cfn;					// 当前文件名字
int TabLength = 4;			// Tab键的宽度：4

ushort *savescreen;         // 保存之前屏幕
int *ColorText;				// 颜色数组

int flagCfile = 0;			// Ｃ文件标识

// 内联函数
void dot_increase();        
inline void dot_increase(){		
	if(dot<end-1)
		dot++;
}
void dot_decrease();
inline void dot_decrease(){
	if(dot>text)
		dot--;
}

// 函数声明
void create_new_file(int argc, char *argv[]);	// 新建文件
void intoVi(char * fn);						    // 进入vi
void doCmd(char c);								// 处理指令

void new_text(int size);						// 申请text[]缓存，用以保存文件内容
void freeResource();							// 释放堆
int  readFile(char * fn, char * p, int size);
void reDraw();									// 重画屏幕
int  distanceDtoS();		// 计算从screenbegin到dot的相对位移。只考虑可打印字符、'\n','\t'。
void synchronizeDandS();								// 对光标、screenbegin进行同步
void resetScreenBegin();						// 根据dot设置screenbegin

int  file_save();								// 将text[]缓存中的内容保存到文件中
void dot_delete();								// 删除dot所在的那个字节
void deleteText(char* _start,char* _end);	// 删除指针[start,end]中的内容
int  insertText(char* p,int n);				// 在指针p前面插入n个字节
void doColon();									// 处理冒号指令
void insert();									// 处理插入字符操作


void showStatus(char* s, int col);				// 输出状态栏
void highlightText();
void reDrawC();
void setColorC(re_t pattern,char *p,int i_pos,int col);

// 操纵dot的移动
void dot_left();
void dot_right(void);
void dot_head();
void dot_tail();
int  dot_preLine();
int  dot_nextLine();
int  dot_up();
int  dot_down();

// 操纵指针的移动
char *begin_line(char * p);
char *next_line(char * p);

// 查找函数
char* findString(char* s);
char* reverseFind(char* s);

// 功能函数
int  ifPrintChar(char c);		// 是否可打印字符，包括'\n','\t',32-126
int  file_size(char* fn);
int  equal(char* p,char* s);	// 字符串s是否是字符串p的前缀

// 将从from开始的count个字节复制到to。from<to。处理from和to内存区重叠的情况：从尾到头复制。
char* moveC(char* _to,char* _from,int count);


// 主函数
int main(int argc, char **argv)
{

	if(argc!=2){
		if(argc==1)
			printf(1,"need a file name behind \"vi\" ");
		else
			printf(1,"too many arguments!");
	}
	else{
		int fd;
		// 测试文件是否存在
		if ((fd = open(argv[1], O_RDONLY)) < 0){
			create_new_file(argc, argv);
		}
		editing = 1;	// 0=exit, 1=one file
		re_t pattern = re_compile(".c");     //　匹配.Ｃ文件
		int match_length;
		int match_idx = re_matchp(pattern, argv[1], &match_length);
		if(match_idx != -1){
			flagCfile = 1;
		}
		intoVi(argv[1]);  // 进入vi
	}
	
	exit();

}

void create_new_file(int argc, char *argv[])
{
	int fd;
	fd = open(argv[1], O_CREATE|O_WRONLY);
	char c[1] ;
	char *cf ;
	cf = c;
	write(fd, cf, 1);	// 写入'\0'
	close(fd);

}

void intoVi(char * fn)
{
	// 初始化变量
	rows = 24;
	columns = 80;

	TabLength = 4;

	editing = 1;
	hasChanged = 0;
	

	// 状态栏
	if(status_buffer!=NULL){
		free(status_buffer);
	}
	status_buffer = (char*)malloc(128);

	// 初始化text[]
	int size,cnt;
	cnt = file_size(fn);
	size = cnt*2;
	new_text(size);	// 设置text[]
	

	//将文本读入内存
	size = readFile(fn, text, cnt);

	cfn = fn;
	screenbegin = dot = text;
	end = text + cnt;		// *(end-1)才是最后一个字符
	int pos_screen = getCursorPos();
	int screen_size = pos_screen * sizeof(savescreen[0]);
	savescreen = (ushort *) malloc(screen_size);
	
	saveScreen(savescreen, pos_screen);			// 保存屏幕

	// 显示界面
	if (flagCfile == 1){
		reDrawC();
	}
	else{
		reDraw();
	}
	
	setCursorPos(0,0);

	char c;
	setBufferFlag(0);
	setShowAtOnce(0);
	while(editing>0){
		read(0,&c,1);
		showStatus("--COMMAND--", YELLOW);		// 清除状态行中的缓存
		doCmd(c);								// 指令处理
		synchronizeDandS();							// 对光标、screenbegin进行同步
	}
	setBufferFlag(1);
	setShowAtOnce(1);
	recorverScreen(savescreen, pos_screen);		// 恢复屏幕
}

// 刷新显示器。
void reDraw(){
	clearScreen();
	resetScreenBegin();
	copyFromTextToScreen((char*)screenbegin,0,strlen((char*)screenbegin),WHITE);
}
void resetScreenBegin(){
	if(dot<screenbegin){
		screenbegin = dot;
		screenbegin = begin_line(screenbegin);
	}
	while(distanceDtoS()>=rows*columns){
		screenbegin = next_line(screenbegin);
	}
}
// 显示状态栏
void showStatus(char* s, int col){
	int x,y;
	int pos = getCursorPos();
	x = pos/columns+1;			//　光标坐标
	y = pos%columns+1;
	memset(status_buffer,' ',columns-2);
	int j = columns-2;
    do{
		status_buffer[j] = '0'+ y%10;
		y=y/10;
		j--;
	}while(y);
	status_buffer[j] = ',';
	j--;
	do{
		status_buffer[j] = '0'+ x%10;
		x=x/10;
		j--;
	}while(x);
	int i;
	for(i=0;*s!='\0';i++){		//  模式状态
		status_buffer[i] = *s;
		s++;
	}
	
	setCursorPos(rows,0);
	int pos1 = getCursorPos();
    copyFromTextToScreen(status_buffer, pos1, columns,col);
	setCursorPos(pos/columns,pos%columns);
}



// 计算从screenbegin到dot的相对位移。只考虑可打印字符、'\n','\t'。
int distanceDtoS(){
	if(screenbegin>dot){
		screenbegin = begin_line(dot);
	}
	char* p = screenbegin;
	int cnt = 0;

	for(; p<dot; p++){			// 是p<dot,小于，没有等号

		// 判断*p及*(p-1)的相关情况
		if(*p>=' ' && *p<='~'){		// 32-126 可打印字符
			cnt++;
		}		
		else if(*p=='\t'){		// Tab = 4
			cnt += TabLength;
		}
		else if(*p=='\n'){
			cnt++;
			if(cnt%columns!=0)
				cnt = cnt/columns*columns+columns;
		}
		else{
			// show error!
			;
		}
	}
	return cnt;
}

// 检查screenbegin是否变化过，以便更新屏幕
void synchronizeDandS(){
	static char* syn_screenbegin = 0;

	resetScreenBegin();
	if(syn_screenbegin!=screenbegin){
		syn_screenbegin = screenbegin;
		reDraw();	
	}
	int pos = distanceDtoS();
	setCursorPos(pos/columns,pos%columns);
}

// char指针操作
// 返回指针p所在行的行首
char *begin_line(char * p){
	while (p>text && p[-1]!='\n')
		p--;
	return p;
}

// 返回指针p所在行的行尾
char *end_line(char * p){
	while (p<end-1 && *p != '\n')
		p++;
	return p;
}
// 将指针p指向当前行的上一行 行首
char *prev_line(char * p){
	p = begin_line(p);	
	if (p>text && p[-1]=='\n')
		p--;			
	p = begin_line(p);
	return p;
}
// 返回指针p所在行的下一行行首
char *next_line(char * p){
	p = end_line(p);
	if (p<end-1 && *p=='\n')
		p++;			
	return p;
}

void doCmd(char C){
	unsigned char c = (unsigned char) C;
	int i = 0;
	char tmp;
	static char lastFindString[findStringLength] = "";
	char currentFindString[findStringLength];
	int pos = 0;

	switch(c){
	// 光标移动：上下左右，向上翻页、向下翻页
		case VI_K_UP:               // up
			dot_up();
			synchronizeDandS();
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_DOWN:             // down
		case VI_K_ENTER:
			dot_down();
			synchronizeDandS();
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_LEFT:             // left
			dot_left();
			synchronizeDandS();
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_RIGHT:            // right
            dot_right();
			synchronizeDandS();
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_PAGEUP:			// page up
			for(i=0;i<rows-1;i++)
				dot_preLine();
			screenbegin = dot;
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_PAGEDN:			// page down
			for(i=0;i<rows-1;i++)
				dot_nextLine();
			screenbegin = dot;
			showStatus("--COMMAND--", YELLOW);
			break;
	// 删除
		case 'x':						// 删除光标所在处的字符
		case VI_K_DELETE:
			hasChanged = 1;
			dot_delete();
			break;
	// 查找命令
		case '/':					// 只能查找31个字符(33->126)以内的。查找字符串不包含空格（' ','\t','\n'）
			pos = getCursorPos();
			showStatus("",0);
			writeAt(rows,0,'/');
			i = 0;
			while(i<findStringLength-1){
				read(0,&tmp,1);
				if(tmp==VI_K_ESC){
					showStatus("--COMMAND--", YELLOW);	// 清除状态行
					return;
				}
				if(tmp=='\n')	
					break;
				if(tmp>=33 && tmp<=126){
					currentFindString[i++] = tmp;
					writeAt(rows,i+1,tmp);
				}
			}
			currentFindString[i] = '\0';

			setCursorPos(pos/80,pos%80);

			if(strlen(currentFindString)>0){
				strcpy(lastFindString,currentFindString);
			}
		case 'n':
			if(strlen(lastFindString)==0){
				showStatus("No previous regular expression", RED);
			}
			else{

				dot = findString(lastFindString);
				synchronizeDandS();
				showStatus(lastFindString, GREEN);
			}
			break;
		case 'N':
			if(strlen(lastFindString)==0){
				showStatus("No previous regular expression",RED);
			}
			else{
				dot = reverseFind(lastFindString);
				synchronizeDandS();
				showStatus(lastFindString, GREEN);
			}
			break;		
	// 模式切换命令
		case 'i':					// 进入插入模式
		case VI_K_INSERT:
			insert();
			break;
		case 'I':					// dot移到行首再进入插入模式
			dot_head();
			synchronizeDandS();
			insert();
			break;
		case 'a':					// 进入追加模式
			dot_right();
			insert();
			break;
		case 'A':					// dot移到行尾再进入插入模式
			dot_tail();
			dot_decrease();			// 插入是在'\n'前面插入
			synchronizeDandS();
			insert();
			break;

	// 一些其他命令
		case ':':						
			doColon();
			break;
		default:
			showStatus("encounter a wrong char !!!!!!", RED);
	}
}

void insert(){
	char c;
	unsigned char C;
	hasChanged = 1;
	while(1){
		showStatus("--INSERT--",WHITE);
		read(0,&c,1);
		if(c==VI_K_ESC){
			if (flagCfile == 1)
				reDrawC();
			showStatus("--COMMAND--", YELLOW);
			break;
		}	
		if(ifPrintChar(c)){
			insertText(dot,1);
			*dot = c;
			dot_increase();
			reDraw();
			synchronizeDandS();
			continue;
		}
		C = (unsigned char)c;
		switch(C){
			case VI_K_UP:
				dot_up();
				break;
			case VI_K_DOWN:
				dot_down();
				break;
			case VI_K_LEFT:
				dot_left();
				break;
			case VI_K_RIGHT:
				dot_right();
				break;
			case VI_K_END:
				dot_tail();
				dot_left();
				break;
		}
		synchronizeDandS();
	}
	showStatus("",0);
}

// 是可打印字符
int ifPrintChar(char c){
	if((c>=' '&&c<='~') || c=='\n' || c=='\t')
		return true;
	else
		return false;
}

void dot_left(){
	if(dot>text && dot[-1]!='\n'){	// && 短路运算符
		dot_decrease();
	}
}
void dot_right(){
	if(dot<end-1 && *dot!='\n'){
		dot_increase();
	}
}
int dot_up(){
	char* p=dot;
	if(!dot_preLine()){
		return false;
	}
	while(p>text && p[-1]!='\n'){
		p--;
		dot_right();
		if(*dot=='\n')
			break;
	}
	return true;
}
int dot_down(){
	char* p = dot;
	if(!dot_nextLine()){
		return false;
	}
	while(p>text && p[-1]!='\n'){
		p--;
		dot_right();
		if(*dot=='\n')
			break;
	}
	return true;
}

// 上一行开头，如果没有上一行，dot不变。会调整screenbegin
int dot_preLine(){
	char* p = dot;
	dot_head();
	if(dot>text && dot[-1]=='\n'){
		dot_decrease();
		dot_head();
		// 更新screenbegin和cursorPos
		if(dot<screenbegin){
			screenbegin = dot;
			screenbegin = begin_line(screenbegin);
		}
		return true;
	}
	else{
		dot = p;
		return false;
	}
}
// 下一行开头，如果没有下一行，dot不变.会调整screenbegin
int dot_nextLine(){
	char* p = dot;
	dot_tail();
	if(dot<end-1 && *dot=='\n'){
		dot_increase();
		dot_head();
		if(distanceDtoS()>=rows*columns){
			screenbegin = next_line(screenbegin);
		}
		return true;
	}
	else{
		dot = p;
		return false;
	}
}
void dot_head(){
	while(dot>text && dot[-1]!='\n'){
		dot_decrease();		
	}
}

void dot_tail(){
	while(dot<end-1 && *dot!='\n'){
		dot_increase();
	}
}

// 正对冒号后面的
void doColon(){
	int pos = getCursorPos();
	showStatus("",0);
	// 获取命令输入并且显示在状态行上
	writeAt(rows,0,':');
	int orderSize = 11;
	char order[orderSize];
	int i=0;
	while(1){
		read(0,order+i,1);
		if(order[i]=='\n')
			break;
		writeAt(rows,i+1,order[i]);
		i++;
		if(i==orderSize-1)
			break;
	}
	order[i]='\0';

	// 对命令进行解析
	if(strcmp(order,"q!")==0){
		editing = 0;
	}
	else if(strcmp(order,"q")==0){
		if(hasChanged==1){
			showStatus("No write since last change (add ! to override)", RED);
		}
		else{
			editing = 0;
		}
	}
	else if(strcmp(order,"wq")==0){
		file_save();
		editing = 0;
	}
	else if(strcmp(order,"w")==0){
		hasChanged = 0;
		file_save();
	}
	else{
		showStatus("wrong command!", RED);
	}
	setCursorPos(pos/80,pos%80);
}

// 保存text到文件cfn中
int file_save(){
	if(cfn==NULL){
		showStatus("No current filename!!!",RED);
		return -1;
	}
	int fd,cnt,resCnt;

	fd = open(cfn,O_WRONLY|O_CREATE);
	if(fd<0)
		return -1;
	cnt = end - text + 1;

	resCnt = write(fd,text,cnt);
	if(resCnt!=cnt){
		showStatus("save error!!!",RED);
		return 0;
	}
	close(fd);
	return resCnt;
}
void freeResource(){
	if(status_buffer!=NULL)
		free(status_buffer);
	if(text!=NULL)
		free(text);
}
// 创建一个text缓存，存放打开的文件（大小为文件大小的2倍+8）
void new_text(int size){
	if (size < 10240)
		size = 10240;	// have a minimum size for new files
	if (text != NULL)
		free(text);
	text = (char *) malloc(size + 8);
	memset(text, '\0', size);	// clear new text[]

	textend = text + size;	
	return;
}

// -1代表失败，其他代表文件大小
int file_size(char* fn){
	struct stat st_buf;
	int cnt, sr;
	cnt = -1;
	sr = stat(fn, &st_buf);	// see if file exists
	if (sr >= 0)
		cnt = (int) st_buf.size;
	return cnt;
}
// 从文件fn中读入size个字节，插入到指针p处，返回插入字节数
int readFile(char * fn, char * p, int size){
	int fd, cnt;
	cnt = -1;

	// 打开文件
	fd = open(fn, O_RDWR);			// assume read & write
	if (fd < 0) {
		// could not open for writing- maybe file is read only
		fd = open((char *) fn, O_RDONLY);	// try read-only
		if (fd < 0) {
			goto fi0;
		}
	}

	cnt = read(fd, p, size);
	close(fd);

	if(cnt < 0)
		cnt = -1;
	
	fi0:
	return cnt;
}

void dot_delete(){
	deleteText(dot,dot);
	reDraw();
	showStatus("--DELETE--",WHITE);
}
//删除从_start到_end（包括_end)的空间
void deleteText(char* _start,char* _end){
	int cnt;
	char* tmp;

	if(_start>_end){
		tmp = _start;
		_start = _end;
		_end = tmp;
	}
	// cnt = _end - _start + 1;
	cnt = end - _end;
	if(memmove(_start,_end+1,cnt)==_start){
		end = end - (_end - _start + 1);
		
	}
	else{
		showStatus("can't delete the character!!!",RED);
	}
}

// 在*p前面插入n个字节
int insertText(char* p,int n){
	char* q = p + n;
	int cnt = end - p + 1;

	if(end+n>textend)
		return -1;
	end = end + n;
	moveC(q,p,cnt);
	memset(p,' ',n);		// 将申请的n个字节置为空格。
	return n;
}
char* moveC(char* _to,char* _from,int count){
	char *from,*to;
	from = _from + count - 1;
	to = _to + count - 1;
	while(count-- > 0){
		*to-- = *from--;
	}
	return _to;
}

// 正向查找字符串s
char* findString(char* s){
	char* p=dot;
	int count=0;
	int res = 0;
	while(1){
		if(p==end-1){	
			if(count==1)
				return dot;
			count++;

			showStatus("search hit BOTTOM, continuing at TOP",WHITE);	
			sleep(30);	
			p = text;
			synchronizeDandS();
			reDraw();
		}
		p++;
		res = equal(p,s);
		if(res==1){
			return p;
		}
		
		if(p==dot){
			showStatus("Pattern not found",RED);
			return dot;
		}
	}
	return p;
}
// 反向查找字符串s
char* reverseFind(char* s){
	char* p = dot;
	int count = 0;
	int res = 0;
	while(1){
		if(p==text){
			if(count==1)
				return dot;
			count++;
			
			showStatus("search hit TOP, continuing at BOTTOM",WHITE);	
			sleep(30);		
			p = end - 1;
			synchronizeDandS();
			reDraw();					
		}
		p--;
		res = equal(p,s);
		if(res==1){
			return p;
		}
		if(p==dot){
			showStatus("Pattern not found",RED);
			return dot;
		}
	}	
	return p;
}
int equal(char* p,char* s){
	int i;
	int n = strlen(s);
	for(i=0;i<n;i++){
		if(*p!=*s){
			return 0;
		}
		p++;s++;
	}
	return 1;
}

void reDrawC(){
	clearScreen();
	resetScreenBegin();
	highlightText();
	ToScreen(text,0,strlen(text),ColorText);
}

void highlightText(){     // Ｃ文件上色
	char *p=text;
	int i;
	int len = strlen(text);
	ColorText = malloc((len+1)*sizeof(int));
	for(i=0;i<len;i++){
		ColorText[i] = WHITE;
	}
	i=0;
	//int i;
    for(i=0;i<len;){
		int col = GREEN;
		re_t pattern = re_compile("\\svoid\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sint\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sdouble\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\schar\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sfloa\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sstatic\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sunsigned\\s");
		setColorC(pattern,p,i,col);

		col = YELLOW;
		pattern = re_compile("\\sif\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\selse\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sswitch\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\scase\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sreturn\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\swhile\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\sbreak\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\scontinue\\s");
		setColorC(pattern,p,i,col);

		col = LIGHT_BLUE;
		pattern = re_compile("\\s#define\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\s#include\\s");
		setColorC(pattern,p,i,col);

		while(*p!='\n' && i<len){
			p++;
			i++;
		}
		p++;
		i++;
   }
}

void setColorC(re_t pattern,char *p,int i_pos,int col){   // 给匹配的字符设置颜色
	int i;
	int match_length;
	int match_idx = re_matchp(pattern, p, &match_length);
	if(match_idx!=-1){
		for(i = match_idx+i_pos;i<match_idx+i_pos+match_length;i++){
			ColorText[i] = col;	
		}		
	}
}