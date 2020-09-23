
_vi:     file format elf32-i386


Disassembly of section .text:

00000000 <dot_increase>:

int flagCfile = 0;			// Ｃ文件标识

// 内联函数
void dot_increase();        
inline void dot_increase(){		
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
	if(dot<end-1)
       3:	a1 04 3d 00 00       	mov    0x3d04,%eax
       8:	8d 50 ff             	lea    -0x1(%eax),%edx
       b:	a1 14 3d 00 00       	mov    0x3d14,%eax
      10:	39 c2                	cmp    %eax,%edx
      12:	76 0d                	jbe    21 <dot_increase+0x21>
		dot++;
      14:	a1 14 3d 00 00       	mov    0x3d14,%eax
      19:	83 c0 01             	add    $0x1,%eax
      1c:	a3 14 3d 00 00       	mov    %eax,0x3d14
}
      21:	90                   	nop
      22:	5d                   	pop    %ebp
      23:	c3                   	ret    

00000024 <dot_decrease>:
void dot_decrease();
inline void dot_decrease(){
      24:	55                   	push   %ebp
      25:	89 e5                	mov    %esp,%ebp
	if(dot>text)
      27:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
      2d:	a1 00 3d 00 00       	mov    0x3d00,%eax
      32:	39 c2                	cmp    %eax,%edx
      34:	76 0d                	jbe    43 <dot_decrease+0x1f>
		dot--;
      36:	a1 14 3d 00 00       	mov    0x3d14,%eax
      3b:	83 e8 01             	sub    $0x1,%eax
      3e:	a3 14 3d 00 00       	mov    %eax,0x3d14
}
      43:	90                   	nop
      44:	5d                   	pop    %ebp
      45:	c3                   	ret    

00000046 <main>:
char* moveC(char* _to,char* _from,int count);


// 主函数
int main(int argc, char **argv)
{
      46:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      4a:	83 e4 f0             	and    $0xfffffff0,%esp
      4d:	ff 71 fc             	pushl  -0x4(%ecx)
      50:	55                   	push   %ebp
      51:	89 e5                	mov    %esp,%ebp
      53:	53                   	push   %ebx
      54:	51                   	push   %ecx
      55:	83 ec 10             	sub    $0x10,%esp
      58:	89 cb                	mov    %ecx,%ebx

	if(argc!=2){
      5a:	83 3b 02             	cmpl   $0x2,(%ebx)
      5d:	74 33                	je     92 <main+0x4c>
		if(argc==1)
      5f:	83 3b 01             	cmpl   $0x1,(%ebx)
      62:	75 17                	jne    7b <main+0x35>
			printf(1,"need a file name behind \"vi\" ");
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 b0 2c 00 00       	push   $0x2cb0
      6c:	6a 01                	push   $0x1
      6e:	e8 50 1e 00 00       	call   1ec3 <printf>
      73:	83 c4 10             	add    $0x10,%esp
      76:	e9 a5 00 00 00       	jmp    120 <main+0xda>
		else
			printf(1,"too many arguments!");
      7b:	83 ec 08             	sub    $0x8,%esp
      7e:	68 ce 2c 00 00       	push   $0x2cce
      83:	6a 01                	push   $0x1
      85:	e8 39 1e 00 00       	call   1ec3 <printf>
      8a:	83 c4 10             	add    $0x10,%esp
      8d:	e9 8e 00 00 00       	jmp    120 <main+0xda>
	}
	else{
		int fd;
		// 测试文件是否存在
		if ((fd = open(argv[1], O_RDONLY)) < 0){
      92:	8b 43 04             	mov    0x4(%ebx),%eax
      95:	83 c0 04             	add    $0x4,%eax
      98:	8b 00                	mov    (%eax),%eax
      9a:	83 ec 08             	sub    $0x8,%esp
      9d:	6a 00                	push   $0x0
      9f:	50                   	push   %eax
      a0:	e8 87 1c 00 00       	call   1d2c <open>
      a5:	83 c4 10             	add    $0x10,%esp
      a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      af:	79 10                	jns    c1 <main+0x7b>
			create_new_file(argc, argv);
      b1:	83 ec 08             	sub    $0x8,%esp
      b4:	ff 73 04             	pushl  0x4(%ebx)
      b7:	ff 33                	pushl  (%ebx)
      b9:	e8 67 00 00 00       	call   125 <create_new_file>
      be:	83 c4 10             	add    $0x10,%esp
		}
		editing = 1;	// 0=exit, 1=one file
      c1:	c7 05 18 3d 00 00 01 	movl   $0x1,0x3d18
      c8:	00 00 00 
		re_t pattern = re_compile(".c");     //　匹配.Ｃ文件
      cb:	83 ec 0c             	sub    $0xc,%esp
      ce:	68 e2 2c 00 00       	push   $0x2ce2
      d3:	e8 62 22 00 00       	call   233a <re_compile>
      d8:	83 c4 10             	add    $0x10,%esp
      db:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int match_length;
		int match_idx = re_matchp(pattern, argv[1], &match_length);
      de:	8b 43 04             	mov    0x4(%ebx),%eax
      e1:	83 c0 04             	add    $0x4,%eax
      e4:	8b 00                	mov    (%eax),%eax
      e6:	83 ec 04             	sub    $0x4,%esp
      e9:	8d 55 e8             	lea    -0x18(%ebp),%edx
      ec:	52                   	push   %edx
      ed:	50                   	push   %eax
      ee:	ff 75 f0             	pushl  -0x10(%ebp)
      f1:	e8 ab 21 00 00       	call   22a1 <re_matchp>
      f6:	83 c4 10             	add    $0x10,%esp
      f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if(match_idx != -1){
      fc:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     100:	74 0a                	je     10c <main+0xc6>
			flagCfile = 1;
     102:	c7 05 60 3b 00 00 01 	movl   $0x1,0x3b60
     109:	00 00 00 
		}
		intoVi(argv[1]);  // 进入vi
     10c:	8b 43 04             	mov    0x4(%ebx),%eax
     10f:	83 c0 04             	add    $0x4,%eax
     112:	8b 00                	mov    (%eax),%eax
     114:	83 ec 0c             	sub    $0xc,%esp
     117:	50                   	push   %eax
     118:	e8 54 00 00 00       	call   171 <intoVi>
     11d:	83 c4 10             	add    $0x10,%esp
	}
	
	exit();
     120:	e8 c7 1b 00 00       	call   1cec <exit>

00000125 <create_new_file>:

}

void create_new_file(int argc, char *argv[])
{
     125:	55                   	push   %ebp
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 18             	sub    $0x18,%esp
	int fd;
	fd = open(argv[1], O_CREATE|O_WRONLY);
     12b:	8b 45 0c             	mov    0xc(%ebp),%eax
     12e:	83 c0 04             	add    $0x4,%eax
     131:	8b 00                	mov    (%eax),%eax
     133:	83 ec 08             	sub    $0x8,%esp
     136:	68 01 02 00 00       	push   $0x201
     13b:	50                   	push   %eax
     13c:	e8 eb 1b 00 00       	call   1d2c <open>
     141:	83 c4 10             	add    $0x10,%esp
     144:	89 45 f4             	mov    %eax,-0xc(%ebp)
	char c[1] ;
	char *cf ;
	cf = c;
     147:	8d 45 ef             	lea    -0x11(%ebp),%eax
     14a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	write(fd, cf, 1);	// 写入'\0'
     14d:	83 ec 04             	sub    $0x4,%esp
     150:	6a 01                	push   $0x1
     152:	ff 75 f0             	pushl  -0x10(%ebp)
     155:	ff 75 f4             	pushl  -0xc(%ebp)
     158:	e8 af 1b 00 00       	call   1d0c <write>
     15d:	83 c4 10             	add    $0x10,%esp
	close(fd);
     160:	83 ec 0c             	sub    $0xc,%esp
     163:	ff 75 f4             	pushl  -0xc(%ebp)
     166:	e8 a9 1b 00 00       	call   1d14 <close>
     16b:	83 c4 10             	add    $0x10,%esp

}
     16e:	90                   	nop
     16f:	c9                   	leave  
     170:	c3                   	ret    

00000171 <intoVi>:

void intoVi(char * fn)
{
     171:	55                   	push   %ebp
     172:	89 e5                	mov    %esp,%ebp
     174:	83 ec 28             	sub    $0x28,%esp
	// 初始化变量
	rows = 24;
     177:	c7 05 e8 3c 00 00 18 	movl   $0x18,0x3ce8
     17e:	00 00 00 
	columns = 80;
     181:	c7 05 ec 3c 00 00 50 	movl   $0x50,0x3cec
     188:	00 00 00 

	TabLength = 4;
     18b:	c7 05 34 3b 00 00 04 	movl   $0x4,0x3b34
     192:	00 00 00 

	editing = 1;
     195:	c7 05 18 3d 00 00 01 	movl   $0x1,0x3d18
     19c:	00 00 00 
	hasChanged = 0;
     19f:	c7 05 08 3d 00 00 00 	movl   $0x0,0x3d08
     1a6:	00 00 00 
	

	// 状态栏
	if(status_buffer!=NULL){
     1a9:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
     1ae:	85 c0                	test   %eax,%eax
     1b0:	74 11                	je     1c3 <intoVi+0x52>
		free(status_buffer);
     1b2:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
     1b7:	83 ec 0c             	sub    $0xc,%esp
     1ba:	50                   	push   %eax
     1bb:	e8 94 1e 00 00       	call   2054 <free>
     1c0:	83 c4 10             	add    $0x10,%esp
	}
	status_buffer = (char*)malloc(128);
     1c3:	83 ec 0c             	sub    $0xc,%esp
     1c6:	68 80 00 00 00       	push   $0x80
     1cb:	e8 c6 1f 00 00       	call   2196 <malloc>
     1d0:	83 c4 10             	add    $0x10,%esp
     1d3:	a3 f8 3c 00 00       	mov    %eax,0x3cf8

	// 初始化text[]
	int size,cnt;
	cnt = file_size(fn);
     1d8:	83 ec 0c             	sub    $0xc,%esp
     1db:	ff 75 08             	pushl  0x8(%ebp)
     1de:	e8 da 10 00 00       	call   12bd <file_size>
     1e3:	83 c4 10             	add    $0x10,%esp
     1e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	size = cnt*2;
     1e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ec:	01 c0                	add    %eax,%eax
     1ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	new_text(size);	// 设置text[]
     1f1:	83 ec 0c             	sub    $0xc,%esp
     1f4:	ff 75 f0             	pushl  -0x10(%ebp)
     1f7:	e8 50 10 00 00       	call   124c <new_text>
     1fc:	83 c4 10             	add    $0x10,%esp
	

	//将文本读入内存
	size = readFile(fn, text, cnt);
     1ff:	a1 00 3d 00 00       	mov    0x3d00,%eax
     204:	83 ec 04             	sub    $0x4,%esp
     207:	ff 75 f4             	pushl  -0xc(%ebp)
     20a:	50                   	push   %eax
     20b:	ff 75 08             	pushl  0x8(%ebp)
     20e:	e8 dd 10 00 00       	call   12f0 <readFile>
     213:	83 c4 10             	add    $0x10,%esp
     216:	89 45 f0             	mov    %eax,-0x10(%ebp)

	cfn = fn;
     219:	8b 45 08             	mov    0x8(%ebp),%eax
     21c:	a3 f4 3c 00 00       	mov    %eax,0x3cf4
	screenbegin = dot = text;
     221:	a1 00 3d 00 00       	mov    0x3d00,%eax
     226:	a3 14 3d 00 00       	mov    %eax,0x3d14
     22b:	a1 14 3d 00 00       	mov    0x3d14,%eax
     230:	a3 10 3d 00 00       	mov    %eax,0x3d10
	end = text + cnt;		// *(end-1)才是最后一个字符
     235:	8b 15 00 3d 00 00    	mov    0x3d00,%edx
     23b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     23e:	01 d0                	add    %edx,%eax
     240:	a3 04 3d 00 00       	mov    %eax,0x3d04
	int pos_screen = getCursorPos();
     245:	e8 72 1b 00 00       	call   1dbc <getCursorPos>
     24a:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int screen_size = pos_screen * sizeof(savescreen[0]);
     24d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     250:	01 c0                	add    %eax,%eax
     252:	89 45 e8             	mov    %eax,-0x18(%ebp)
	savescreen = (ushort *) malloc(screen_size);
     255:	8b 45 e8             	mov    -0x18(%ebp),%eax
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	50                   	push   %eax
     25c:	e8 35 1f 00 00       	call   2196 <malloc>
     261:	83 c4 10             	add    $0x10,%esp
     264:	a3 fc 3c 00 00       	mov    %eax,0x3cfc
	
	saveScreen(savescreen, pos_screen);			// 保存屏幕
     269:	a1 fc 3c 00 00       	mov    0x3cfc,%eax
     26e:	83 ec 08             	sub    $0x8,%esp
     271:	ff 75 ec             	pushl  -0x14(%ebp)
     274:	50                   	push   %eax
     275:	e8 4a 1b 00 00       	call   1dc4 <saveScreen>
     27a:	83 c4 10             	add    $0x10,%esp

	// 显示界面
	if (flagCfile == 1){
     27d:	a1 60 3b 00 00       	mov    0x3b60,%eax
     282:	83 f8 01             	cmp    $0x1,%eax
     285:	75 07                	jne    28e <intoVi+0x11d>
		reDrawC();
     287:	e8 10 14 00 00       	call   169c <reDrawC>
     28c:	eb 05                	jmp    293 <intoVi+0x122>
	}
	else{
		reDraw();
     28e:	e8 a2 00 00 00       	call   335 <reDraw>
	}
	
	setCursorPos(0,0);
     293:	83 ec 08             	sub    $0x8,%esp
     296:	6a 00                	push   $0x0
     298:	6a 00                	push   $0x0
     29a:	e8 ed 1a 00 00       	call   1d8c <setCursorPos>
     29f:	83 c4 10             	add    $0x10,%esp

	char c;
	setBufferFlag(0);
     2a2:	83 ec 0c             	sub    $0xc,%esp
     2a5:	6a 00                	push   $0x0
     2a7:	e8 00 1b 00 00       	call   1dac <setBufferFlag>
     2ac:	83 c4 10             	add    $0x10,%esp
	setShowAtOnce(0);
     2af:	83 ec 0c             	sub    $0xc,%esp
     2b2:	6a 00                	push   $0x0
     2b4:	e8 fb 1a 00 00       	call   1db4 <setShowAtOnce>
     2b9:	83 c4 10             	add    $0x10,%esp
	while(editing>0){
     2bc:	eb 3d                	jmp    2fb <intoVi+0x18a>
		read(0,&c,1);
     2be:	83 ec 04             	sub    $0x4,%esp
     2c1:	6a 01                	push   $0x1
     2c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
     2c6:	50                   	push   %eax
     2c7:	6a 00                	push   $0x0
     2c9:	e8 36 1a 00 00       	call   1d04 <read>
     2ce:	83 c4 10             	add    $0x10,%esp
		showStatus("--COMMAND--", YELLOW);		// 清除状态行中的缓存
     2d1:	83 ec 08             	sub    $0x8,%esp
     2d4:	6a 0e                	push   $0xe
     2d6:	68 e5 2c 00 00       	push   $0x2ce5
     2db:	e8 f7 00 00 00       	call   3d7 <showStatus>
     2e0:	83 c4 10             	add    $0x10,%esp
		doCmd(c);								// 指令处理
     2e3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     2e7:	0f be c0             	movsbl %al,%eax
     2ea:	83 ec 0c             	sub    $0xc,%esp
     2ed:	50                   	push   %eax
     2ee:	e8 6b 04 00 00       	call   75e <doCmd>
     2f3:	83 c4 10             	add    $0x10,%esp
		synchronizeDandS();							// 对光标、screenbegin进行同步
     2f6:	e8 4a 03 00 00       	call   645 <synchronizeDandS>
	setCursorPos(0,0);

	char c;
	setBufferFlag(0);
	setShowAtOnce(0);
	while(editing>0){
     2fb:	a1 18 3d 00 00       	mov    0x3d18,%eax
     300:	85 c0                	test   %eax,%eax
     302:	7f ba                	jg     2be <intoVi+0x14d>
		read(0,&c,1);
		showStatus("--COMMAND--", YELLOW);		// 清除状态行中的缓存
		doCmd(c);								// 指令处理
		synchronizeDandS();							// 对光标、screenbegin进行同步
	}
	setBufferFlag(1);
     304:	83 ec 0c             	sub    $0xc,%esp
     307:	6a 01                	push   $0x1
     309:	e8 9e 1a 00 00       	call   1dac <setBufferFlag>
     30e:	83 c4 10             	add    $0x10,%esp
	setShowAtOnce(1);
     311:	83 ec 0c             	sub    $0xc,%esp
     314:	6a 01                	push   $0x1
     316:	e8 99 1a 00 00       	call   1db4 <setShowAtOnce>
     31b:	83 c4 10             	add    $0x10,%esp
	recorverScreen(savescreen, pos_screen);		// 恢复屏幕
     31e:	a1 fc 3c 00 00       	mov    0x3cfc,%eax
     323:	83 ec 08             	sub    $0x8,%esp
     326:	ff 75 ec             	pushl  -0x14(%ebp)
     329:	50                   	push   %eax
     32a:	e8 9d 1a 00 00       	call   1dcc <recorverScreen>
     32f:	83 c4 10             	add    $0x10,%esp
}
     332:	90                   	nop
     333:	c9                   	leave  
     334:	c3                   	ret    

00000335 <reDraw>:

// 刷新显示器。
void reDraw(){
     335:	55                   	push   %ebp
     336:	89 e5                	mov    %esp,%ebp
     338:	83 ec 08             	sub    $0x8,%esp
	clearScreen();
     33b:	e8 5c 1a 00 00       	call   1d9c <clearScreen>
	resetScreenBegin();
     340:	e8 29 00 00 00       	call   36e <resetScreenBegin>
	copyFromTextToScreen((char*)screenbegin,0,strlen((char*)screenbegin),WHITE);
     345:	a1 10 3d 00 00       	mov    0x3d10,%eax
     34a:	83 ec 0c             	sub    $0xc,%esp
     34d:	50                   	push   %eax
     34e:	e8 d7 17 00 00       	call   1b2a <strlen>
     353:	83 c4 10             	add    $0x10,%esp
     356:	89 c2                	mov    %eax,%edx
     358:	a1 10 3d 00 00       	mov    0x3d10,%eax
     35d:	6a 0f                	push   $0xf
     35f:	52                   	push   %edx
     360:	6a 00                	push   $0x0
     362:	50                   	push   %eax
     363:	e8 2c 1a 00 00       	call   1d94 <copyFromTextToScreen>
     368:	83 c4 10             	add    $0x10,%esp
}
     36b:	90                   	nop
     36c:	c9                   	leave  
     36d:	c3                   	ret    

0000036e <resetScreenBegin>:
void resetScreenBegin(){
     36e:	55                   	push   %ebp
     36f:	89 e5                	mov    %esp,%ebp
     371:	83 ec 08             	sub    $0x8,%esp
	if(dot<screenbegin){
     374:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
     37a:	a1 10 3d 00 00       	mov    0x3d10,%eax
     37f:	39 c2                	cmp    %eax,%edx
     381:	73 38                	jae    3bb <resetScreenBegin+0x4d>
		screenbegin = dot;
     383:	a1 14 3d 00 00       	mov    0x3d14,%eax
     388:	a3 10 3d 00 00       	mov    %eax,0x3d10
		screenbegin = begin_line(screenbegin);
     38d:	a1 10 3d 00 00       	mov    0x3d10,%eax
     392:	83 ec 0c             	sub    $0xc,%esp
     395:	50                   	push   %eax
     396:	e8 09 03 00 00       	call   6a4 <begin_line>
     39b:	83 c4 10             	add    $0x10,%esp
     39e:	a3 10 3d 00 00       	mov    %eax,0x3d10
	}
	while(distanceDtoS()>=rows*columns){
     3a3:	eb 16                	jmp    3bb <resetScreenBegin+0x4d>
		screenbegin = next_line(screenbegin);
     3a5:	a1 10 3d 00 00       	mov    0x3d10,%eax
     3aa:	83 ec 0c             	sub    $0xc,%esp
     3ad:	50                   	push   %eax
     3ae:	e8 7a 03 00 00       	call   72d <next_line>
     3b3:	83 c4 10             	add    $0x10,%esp
     3b6:	a3 10 3d 00 00       	mov    %eax,0x3d10
void resetScreenBegin(){
	if(dot<screenbegin){
		screenbegin = dot;
		screenbegin = begin_line(screenbegin);
	}
	while(distanceDtoS()>=rows*columns){
     3bb:	e8 ce 01 00 00       	call   58e <distanceDtoS>
     3c0:	89 c1                	mov    %eax,%ecx
     3c2:	8b 15 e8 3c 00 00    	mov    0x3ce8,%edx
     3c8:	a1 ec 3c 00 00       	mov    0x3cec,%eax
     3cd:	0f af c2             	imul   %edx,%eax
     3d0:	39 c1                	cmp    %eax,%ecx
     3d2:	7d d1                	jge    3a5 <resetScreenBegin+0x37>
		screenbegin = next_line(screenbegin);
	}
}
     3d4:	90                   	nop
     3d5:	c9                   	leave  
     3d6:	c3                   	ret    

000003d7 <showStatus>:
// 显示状态栏
void showStatus(char* s, int col){
     3d7:	55                   	push   %ebp
     3d8:	89 e5                	mov    %esp,%ebp
     3da:	53                   	push   %ebx
     3db:	83 ec 24             	sub    $0x24,%esp
	int x,y;
	int pos = getCursorPos();
     3de:	e8 d9 19 00 00       	call   1dbc <getCursorPos>
     3e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	x = pos/columns+1;			//　光标坐标
     3e6:	8b 1d ec 3c 00 00    	mov    0x3cec,%ebx
     3ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     3ef:	99                   	cltd   
     3f0:	f7 fb                	idiv   %ebx
     3f2:	83 c0 01             	add    $0x1,%eax
     3f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = pos%columns+1;
     3f8:	8b 0d ec 3c 00 00    	mov    0x3cec,%ecx
     3fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     401:	99                   	cltd   
     402:	f7 f9                	idiv   %ecx
     404:	89 d0                	mov    %edx,%eax
     406:	83 c0 01             	add    $0x1,%eax
     409:	89 45 f0             	mov    %eax,-0x10(%ebp)
	memset(status_buffer,' ',columns-2);
     40c:	a1 ec 3c 00 00       	mov    0x3cec,%eax
     411:	83 e8 02             	sub    $0x2,%eax
     414:	89 c2                	mov    %eax,%edx
     416:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
     41b:	83 ec 04             	sub    $0x4,%esp
     41e:	52                   	push   %edx
     41f:	6a 20                	push   $0x20
     421:	50                   	push   %eax
     422:	e8 2a 17 00 00       	call   1b51 <memset>
     427:	83 c4 10             	add    $0x10,%esp
	int j = columns-2;
     42a:	a1 ec 3c 00 00       	mov    0x3cec,%eax
     42f:	83 e8 02             	sub    $0x2,%eax
     432:	89 45 ec             	mov    %eax,-0x14(%ebp)
    do{
		status_buffer[j] = '0'+ y%10;
     435:	8b 15 f8 3c 00 00    	mov    0x3cf8,%edx
     43b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     43e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     441:	8b 4d f0             	mov    -0x10(%ebp),%ecx
     444:	ba 67 66 66 66       	mov    $0x66666667,%edx
     449:	89 c8                	mov    %ecx,%eax
     44b:	f7 ea                	imul   %edx
     44d:	c1 fa 02             	sar    $0x2,%edx
     450:	89 c8                	mov    %ecx,%eax
     452:	c1 f8 1f             	sar    $0x1f,%eax
     455:	29 c2                	sub    %eax,%edx
     457:	89 d0                	mov    %edx,%eax
     459:	c1 e0 02             	shl    $0x2,%eax
     45c:	01 d0                	add    %edx,%eax
     45e:	01 c0                	add    %eax,%eax
     460:	29 c1                	sub    %eax,%ecx
     462:	89 ca                	mov    %ecx,%edx
     464:	89 d0                	mov    %edx,%eax
     466:	83 c0 30             	add    $0x30,%eax
     469:	88 03                	mov    %al,(%ebx)
		y=y/10;
     46b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
     46e:	ba 67 66 66 66       	mov    $0x66666667,%edx
     473:	89 c8                	mov    %ecx,%eax
     475:	f7 ea                	imul   %edx
     477:	c1 fa 02             	sar    $0x2,%edx
     47a:	89 c8                	mov    %ecx,%eax
     47c:	c1 f8 1f             	sar    $0x1f,%eax
     47f:	29 c2                	sub    %eax,%edx
     481:	89 d0                	mov    %edx,%eax
     483:	89 45 f0             	mov    %eax,-0x10(%ebp)
		j--;
     486:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
	}while(y);
     48a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     48e:	75 a5                	jne    435 <showStatus+0x5e>
	status_buffer[j] = ',';
     490:	8b 15 f8 3c 00 00    	mov    0x3cf8,%edx
     496:	8b 45 ec             	mov    -0x14(%ebp),%eax
     499:	01 d0                	add    %edx,%eax
     49b:	c6 00 2c             	movb   $0x2c,(%eax)
	j--;
     49e:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
	do{
		status_buffer[j] = '0'+ x%10;
     4a2:	8b 15 f8 3c 00 00    	mov    0x3cf8,%edx
     4a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4ab:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     4ae:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4b1:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4b6:	89 c8                	mov    %ecx,%eax
     4b8:	f7 ea                	imul   %edx
     4ba:	c1 fa 02             	sar    $0x2,%edx
     4bd:	89 c8                	mov    %ecx,%eax
     4bf:	c1 f8 1f             	sar    $0x1f,%eax
     4c2:	29 c2                	sub    %eax,%edx
     4c4:	89 d0                	mov    %edx,%eax
     4c6:	c1 e0 02             	shl    $0x2,%eax
     4c9:	01 d0                	add    %edx,%eax
     4cb:	01 c0                	add    %eax,%eax
     4cd:	29 c1                	sub    %eax,%ecx
     4cf:	89 ca                	mov    %ecx,%edx
     4d1:	89 d0                	mov    %edx,%eax
     4d3:	83 c0 30             	add    $0x30,%eax
     4d6:	88 03                	mov    %al,(%ebx)
		x=x/10;
     4d8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4db:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4e0:	89 c8                	mov    %ecx,%eax
     4e2:	f7 ea                	imul   %edx
     4e4:	c1 fa 02             	sar    $0x2,%edx
     4e7:	89 c8                	mov    %ecx,%eax
     4e9:	c1 f8 1f             	sar    $0x1f,%eax
     4ec:	29 c2                	sub    %eax,%edx
     4ee:	89 d0                	mov    %edx,%eax
     4f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		j--;
     4f3:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
	}while(x);
     4f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4fb:	75 a5                	jne    4a2 <showStatus+0xcb>
	int i;
	for(i=0;*s!='\0';i++){		//  模式状态
     4fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
     504:	eb 1b                	jmp    521 <showStatus+0x14a>
		status_buffer[i] = *s;
     506:	8b 15 f8 3c 00 00    	mov    0x3cf8,%edx
     50c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50f:	01 c2                	add    %eax,%edx
     511:	8b 45 08             	mov    0x8(%ebp),%eax
     514:	0f b6 00             	movzbl (%eax),%eax
     517:	88 02                	mov    %al,(%edx)
		s++;
     519:	83 45 08 01          	addl   $0x1,0x8(%ebp)
		status_buffer[j] = '0'+ x%10;
		x=x/10;
		j--;
	}while(x);
	int i;
	for(i=0;*s!='\0';i++){		//  模式状态
     51d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
     521:	8b 45 08             	mov    0x8(%ebp),%eax
     524:	0f b6 00             	movzbl (%eax),%eax
     527:	84 c0                	test   %al,%al
     529:	75 db                	jne    506 <showStatus+0x12f>
		status_buffer[i] = *s;
		s++;
	}
	
	setCursorPos(rows,0);
     52b:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     530:	83 ec 08             	sub    $0x8,%esp
     533:	6a 00                	push   $0x0
     535:	50                   	push   %eax
     536:	e8 51 18 00 00       	call   1d8c <setCursorPos>
     53b:	83 c4 10             	add    $0x10,%esp
	int pos1 = getCursorPos();
     53e:	e8 79 18 00 00       	call   1dbc <getCursorPos>
     543:	89 45 e0             	mov    %eax,-0x20(%ebp)
    copyFromTextToScreen(status_buffer, pos1, columns,col);
     546:	8b 15 ec 3c 00 00    	mov    0x3cec,%edx
     54c:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
     551:	ff 75 0c             	pushl  0xc(%ebp)
     554:	52                   	push   %edx
     555:	ff 75 e0             	pushl  -0x20(%ebp)
     558:	50                   	push   %eax
     559:	e8 36 18 00 00       	call   1d94 <copyFromTextToScreen>
     55e:	83 c4 10             	add    $0x10,%esp
	setCursorPos(pos/columns,pos%columns);
     561:	8b 0d ec 3c 00 00    	mov    0x3cec,%ecx
     567:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     56a:	99                   	cltd   
     56b:	f7 f9                	idiv   %ecx
     56d:	89 d1                	mov    %edx,%ecx
     56f:	8b 1d ec 3c 00 00    	mov    0x3cec,%ebx
     575:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     578:	99                   	cltd   
     579:	f7 fb                	idiv   %ebx
     57b:	83 ec 08             	sub    $0x8,%esp
     57e:	51                   	push   %ecx
     57f:	50                   	push   %eax
     580:	e8 07 18 00 00       	call   1d8c <setCursorPos>
     585:	83 c4 10             	add    $0x10,%esp
}
     588:	90                   	nop
     589:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     58c:	c9                   	leave  
     58d:	c3                   	ret    

0000058e <distanceDtoS>:



// 计算从screenbegin到dot的相对位移。只考虑可打印字符、'\n','\t'。
int distanceDtoS(){
     58e:	55                   	push   %ebp
     58f:	89 e5                	mov    %esp,%ebp
     591:	83 ec 18             	sub    $0x18,%esp
	if(screenbegin>dot){
     594:	8b 15 10 3d 00 00    	mov    0x3d10,%edx
     59a:	a1 14 3d 00 00       	mov    0x3d14,%eax
     59f:	39 c2                	cmp    %eax,%edx
     5a1:	76 16                	jbe    5b9 <distanceDtoS+0x2b>
		screenbegin = begin_line(dot);
     5a3:	a1 14 3d 00 00       	mov    0x3d14,%eax
     5a8:	83 ec 0c             	sub    $0xc,%esp
     5ab:	50                   	push   %eax
     5ac:	e8 f3 00 00 00       	call   6a4 <begin_line>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	a3 10 3d 00 00       	mov    %eax,0x3d10
	}
	char* p = screenbegin;
     5b9:	a1 10 3d 00 00       	mov    0x3d10,%eax
     5be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int cnt = 0;
     5c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	for(; p<dot; p++){			// 是p<dot,小于，没有等号
     5c8:	eb 6c                	jmp    636 <distanceDtoS+0xa8>

		// 判断*p及*(p-1)的相关情况
		if(*p>=' ' && *p<='~'){		// 32-126 可打印字符
     5ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5cd:	0f b6 00             	movzbl (%eax),%eax
     5d0:	3c 1f                	cmp    $0x1f,%al
     5d2:	7e 10                	jle    5e4 <distanceDtoS+0x56>
     5d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5d7:	0f b6 00             	movzbl (%eax),%eax
     5da:	3c 7f                	cmp    $0x7f,%al
     5dc:	74 06                	je     5e4 <distanceDtoS+0x56>
			cnt++;
     5de:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5e2:	eb 4e                	jmp    632 <distanceDtoS+0xa4>
		}		
		else if(*p=='\t'){		// Tab = 4
     5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e7:	0f b6 00             	movzbl (%eax),%eax
     5ea:	3c 09                	cmp    $0x9,%al
     5ec:	75 0a                	jne    5f8 <distanceDtoS+0x6a>
			cnt += TabLength;
     5ee:	a1 34 3b 00 00       	mov    0x3b34,%eax
     5f3:	01 45 f0             	add    %eax,-0x10(%ebp)
     5f6:	eb 3a                	jmp    632 <distanceDtoS+0xa4>
		}
		else if(*p=='\n'){
     5f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fb:	0f b6 00             	movzbl (%eax),%eax
     5fe:	3c 0a                	cmp    $0xa,%al
     600:	75 30                	jne    632 <distanceDtoS+0xa4>
			cnt++;
     602:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			if(cnt%columns!=0)
     606:	8b 0d ec 3c 00 00    	mov    0x3cec,%ecx
     60c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60f:	99                   	cltd   
     610:	f7 f9                	idiv   %ecx
     612:	89 d0                	mov    %edx,%eax
     614:	85 c0                	test   %eax,%eax
     616:	74 1a                	je     632 <distanceDtoS+0xa4>
				cnt = cnt/columns*columns+columns;
     618:	8b 0d ec 3c 00 00    	mov    0x3cec,%ecx
     61e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     621:	99                   	cltd   
     622:	f7 f9                	idiv   %ecx
     624:	8d 50 01             	lea    0x1(%eax),%edx
     627:	a1 ec 3c 00 00       	mov    0x3cec,%eax
     62c:	0f af c2             	imul   %edx,%eax
     62f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		screenbegin = begin_line(dot);
	}
	char* p = screenbegin;
	int cnt = 0;

	for(; p<dot; p++){			// 是p<dot,小于，没有等号
     632:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     636:	a1 14 3d 00 00       	mov    0x3d14,%eax
     63b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     63e:	72 8a                	jb     5ca <distanceDtoS+0x3c>
		else{
			// show error!
			;
		}
	}
	return cnt;
     640:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     643:	c9                   	leave  
     644:	c3                   	ret    

00000645 <synchronizeDandS>:

// 检查screenbegin是否变化过，以便更新屏幕
void synchronizeDandS(){
     645:	55                   	push   %ebp
     646:	89 e5                	mov    %esp,%ebp
     648:	53                   	push   %ebx
     649:	83 ec 14             	sub    $0x14,%esp
	static char* syn_screenbegin = 0;

	resetScreenBegin();
     64c:	e8 1d fd ff ff       	call   36e <resetScreenBegin>
	if(syn_screenbegin!=screenbegin){
     651:	8b 15 64 3b 00 00    	mov    0x3b64,%edx
     657:	a1 10 3d 00 00       	mov    0x3d10,%eax
     65c:	39 c2                	cmp    %eax,%edx
     65e:	74 0f                	je     66f <synchronizeDandS+0x2a>
		syn_screenbegin = screenbegin;
     660:	a1 10 3d 00 00       	mov    0x3d10,%eax
     665:	a3 64 3b 00 00       	mov    %eax,0x3b64
		reDraw();	
     66a:	e8 c6 fc ff ff       	call   335 <reDraw>
	}
	int pos = distanceDtoS();
     66f:	e8 1a ff ff ff       	call   58e <distanceDtoS>
     674:	89 45 f4             	mov    %eax,-0xc(%ebp)
	setCursorPos(pos/columns,pos%columns);
     677:	8b 0d ec 3c 00 00    	mov    0x3cec,%ecx
     67d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     680:	99                   	cltd   
     681:	f7 f9                	idiv   %ecx
     683:	89 d1                	mov    %edx,%ecx
     685:	8b 1d ec 3c 00 00    	mov    0x3cec,%ebx
     68b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     68e:	99                   	cltd   
     68f:	f7 fb                	idiv   %ebx
     691:	83 ec 08             	sub    $0x8,%esp
     694:	51                   	push   %ecx
     695:	50                   	push   %eax
     696:	e8 f1 16 00 00       	call   1d8c <setCursorPos>
     69b:	83 c4 10             	add    $0x10,%esp
}
     69e:	90                   	nop
     69f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6a2:	c9                   	leave  
     6a3:	c3                   	ret    

000006a4 <begin_line>:

// char指针操作
// 返回指针p所在行的行首
char *begin_line(char * p){
     6a4:	55                   	push   %ebp
     6a5:	89 e5                	mov    %esp,%ebp
	while (p>text && p[-1]!='\n')
     6a7:	eb 04                	jmp    6ad <begin_line+0x9>
		p--;
     6a9:	83 6d 08 01          	subl   $0x1,0x8(%ebp)
}

// char指针操作
// 返回指针p所在行的行首
char *begin_line(char * p){
	while (p>text && p[-1]!='\n')
     6ad:	a1 00 3d 00 00       	mov    0x3d00,%eax
     6b2:	39 45 08             	cmp    %eax,0x8(%ebp)
     6b5:	76 0d                	jbe    6c4 <begin_line+0x20>
     6b7:	8b 45 08             	mov    0x8(%ebp),%eax
     6ba:	83 e8 01             	sub    $0x1,%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	3c 0a                	cmp    $0xa,%al
     6c2:	75 e5                	jne    6a9 <begin_line+0x5>
		p--;
	return p;
     6c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6c7:	5d                   	pop    %ebp
     6c8:	c3                   	ret    

000006c9 <end_line>:

// 返回指针p所在行的行尾
char *end_line(char * p){
     6c9:	55                   	push   %ebp
     6ca:	89 e5                	mov    %esp,%ebp
	while (p<end-1 && *p != '\n')
     6cc:	eb 04                	jmp    6d2 <end_line+0x9>
		p++;
     6ce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
	return p;
}

// 返回指针p所在行的行尾
char *end_line(char * p){
	while (p<end-1 && *p != '\n')
     6d2:	a1 04 3d 00 00       	mov    0x3d04,%eax
     6d7:	83 e8 01             	sub    $0x1,%eax
     6da:	3b 45 08             	cmp    0x8(%ebp),%eax
     6dd:	76 0a                	jbe    6e9 <end_line+0x20>
     6df:	8b 45 08             	mov    0x8(%ebp),%eax
     6e2:	0f b6 00             	movzbl (%eax),%eax
     6e5:	3c 0a                	cmp    $0xa,%al
     6e7:	75 e5                	jne    6ce <end_line+0x5>
		p++;
	return p;
     6e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6ec:	5d                   	pop    %ebp
     6ed:	c3                   	ret    

000006ee <prev_line>:
// 将指针p指向当前行的上一行 行首
char *prev_line(char * p){
     6ee:	55                   	push   %ebp
     6ef:	89 e5                	mov    %esp,%ebp
	p = begin_line(p);	
     6f1:	ff 75 08             	pushl  0x8(%ebp)
     6f4:	e8 ab ff ff ff       	call   6a4 <begin_line>
     6f9:	83 c4 04             	add    $0x4,%esp
     6fc:	89 45 08             	mov    %eax,0x8(%ebp)
	if (p>text && p[-1]=='\n')
     6ff:	a1 00 3d 00 00       	mov    0x3d00,%eax
     704:	39 45 08             	cmp    %eax,0x8(%ebp)
     707:	76 11                	jbe    71a <prev_line+0x2c>
     709:	8b 45 08             	mov    0x8(%ebp),%eax
     70c:	83 e8 01             	sub    $0x1,%eax
     70f:	0f b6 00             	movzbl (%eax),%eax
     712:	3c 0a                	cmp    $0xa,%al
     714:	75 04                	jne    71a <prev_line+0x2c>
		p--;			
     716:	83 6d 08 01          	subl   $0x1,0x8(%ebp)
	p = begin_line(p);
     71a:	ff 75 08             	pushl  0x8(%ebp)
     71d:	e8 82 ff ff ff       	call   6a4 <begin_line>
     722:	83 c4 04             	add    $0x4,%esp
     725:	89 45 08             	mov    %eax,0x8(%ebp)
	return p;
     728:	8b 45 08             	mov    0x8(%ebp),%eax
}
     72b:	c9                   	leave  
     72c:	c3                   	ret    

0000072d <next_line>:
// 返回指针p所在行的下一行行首
char *next_line(char * p){
     72d:	55                   	push   %ebp
     72e:	89 e5                	mov    %esp,%ebp
	p = end_line(p);
     730:	ff 75 08             	pushl  0x8(%ebp)
     733:	e8 91 ff ff ff       	call   6c9 <end_line>
     738:	83 c4 04             	add    $0x4,%esp
     73b:	89 45 08             	mov    %eax,0x8(%ebp)
	if (p<end-1 && *p=='\n')
     73e:	a1 04 3d 00 00       	mov    0x3d04,%eax
     743:	83 e8 01             	sub    $0x1,%eax
     746:	3b 45 08             	cmp    0x8(%ebp),%eax
     749:	76 0e                	jbe    759 <next_line+0x2c>
     74b:	8b 45 08             	mov    0x8(%ebp),%eax
     74e:	0f b6 00             	movzbl (%eax),%eax
     751:	3c 0a                	cmp    $0xa,%al
     753:	75 04                	jne    759 <next_line+0x2c>
		p++;			
     755:	83 45 08 01          	addl   $0x1,0x8(%ebp)
	return p;
     759:	8b 45 08             	mov    0x8(%ebp),%eax
}
     75c:	c9                   	leave  
     75d:	c3                   	ret    

0000075e <doCmd>:

void doCmd(char C){
     75e:	55                   	push   %ebp
     75f:	89 e5                	mov    %esp,%ebp
     761:	53                   	push   %ebx
     762:	83 ec 44             	sub    $0x44,%esp
     765:	8b 45 08             	mov    0x8(%ebp),%eax
     768:	88 45 c4             	mov    %al,-0x3c(%ebp)
	unsigned char c = (unsigned char) C;
     76b:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
     76f:	88 45 f3             	mov    %al,-0xd(%ebp)
	int i = 0;
     772:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char tmp;
	static char lastFindString[findStringLength] = "";
	char currentFindString[findStringLength];
	int pos = 0;
     779:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

	switch(c){
     780:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
     784:	83 f8 6e             	cmp    $0x6e,%eax
     787:	0f 84 2d 03 00 00    	je     aba <doCmd+0x35c>
     78d:	83 f8 6e             	cmp    $0x6e,%eax
     790:	7f 61                	jg     7f3 <doCmd+0x95>
     792:	83 f8 41             	cmp    $0x41,%eax
     795:	0f 84 f8 03 00 00    	je     b93 <doCmd+0x435>
     79b:	83 f8 41             	cmp    $0x41,%eax
     79e:	7f 20                	jg     7c0 <doCmd+0x62>
     7a0:	83 f8 2f             	cmp    $0x2f,%eax
     7a3:	0f 84 d4 01 00 00    	je     97d <doCmd+0x21f>
     7a9:	83 f8 3a             	cmp    $0x3a,%eax
     7ac:	0f 84 f7 03 00 00    	je     ba9 <doCmd+0x44b>
     7b2:	83 f8 0a             	cmp    $0xa,%eax
     7b5:	0f 84 cb 00 00 00    	je     886 <doCmd+0x128>
     7bb:	e9 f0 03 00 00       	jmp    bb0 <doCmd+0x452>
     7c0:	83 f8 4e             	cmp    $0x4e,%eax
     7c3:	0f 84 4d 03 00 00    	je     b16 <doCmd+0x3b8>
     7c9:	83 f8 4e             	cmp    $0x4e,%eax
     7cc:	7f 0e                	jg     7dc <doCmd+0x7e>
     7ce:	83 f8 49             	cmp    $0x49,%eax
     7d1:	0f 84 9f 03 00 00    	je     b76 <doCmd+0x418>
     7d7:	e9 d4 03 00 00       	jmp    bb0 <doCmd+0x452>
     7dc:	83 f8 61             	cmp    $0x61,%eax
     7df:	0f 84 a2 03 00 00    	je     b87 <doCmd+0x429>
     7e5:	83 f8 69             	cmp    $0x69,%eax
     7e8:	0f 84 81 03 00 00    	je     b6f <doCmd+0x411>
     7ee:	e9 bd 03 00 00       	jmp    bb0 <doCmd+0x452>
     7f3:	3d e5 00 00 00       	cmp    $0xe5,%eax
     7f8:	0f 84 ca 00 00 00    	je     8c8 <doCmd+0x16a>
     7fe:	3d e5 00 00 00       	cmp    $0xe5,%eax
     803:	7f 2f                	jg     834 <doCmd+0xd6>
     805:	3d e2 00 00 00       	cmp    $0xe2,%eax
     80a:	74 59                	je     865 <doCmd+0x107>
     80c:	3d e2 00 00 00       	cmp    $0xe2,%eax
     811:	7f 0e                	jg     821 <doCmd+0xc3>
     813:	83 f8 78             	cmp    $0x78,%eax
     816:	0f 84 4d 01 00 00    	je     969 <doCmd+0x20b>
     81c:	e9 8f 03 00 00       	jmp    bb0 <doCmd+0x452>
     821:	3d e3 00 00 00       	cmp    $0xe3,%eax
     826:	74 5e                	je     886 <doCmd+0x128>
     828:	3d e4 00 00 00       	cmp    $0xe4,%eax
     82d:	74 78                	je     8a7 <doCmd+0x149>
     82f:	e9 7c 03 00 00       	jmp    bb0 <doCmd+0x452>
     834:	3d e7 00 00 00       	cmp    $0xe7,%eax
     839:	0f 84 ea 00 00 00    	je     929 <doCmd+0x1cb>
     83f:	3d e7 00 00 00       	cmp    $0xe7,%eax
     844:	0f 8c 9f 00 00 00    	jl     8e9 <doCmd+0x18b>
     84a:	3d e8 00 00 00       	cmp    $0xe8,%eax
     84f:	0f 84 1a 03 00 00    	je     b6f <doCmd+0x411>
     855:	3d e9 00 00 00       	cmp    $0xe9,%eax
     85a:	0f 84 09 01 00 00    	je     969 <doCmd+0x20b>
     860:	e9 4b 03 00 00       	jmp    bb0 <doCmd+0x452>
	// 光标移动：上下左右，向上翻页、向下翻页
		case VI_K_UP:               // up
			dot_up();
     865:	e8 ed 04 00 00       	call   d57 <dot_up>
			synchronizeDandS();
     86a:	e8 d6 fd ff ff       	call   645 <synchronizeDandS>
			showStatus("--COMMAND--", YELLOW);
     86f:	83 ec 08             	sub    $0x8,%esp
     872:	6a 0e                	push   $0xe
     874:	68 e5 2c 00 00       	push   $0x2ce5
     879:	e8 59 fb ff ff       	call   3d7 <showStatus>
     87e:	83 c4 10             	add    $0x10,%esp
			break;
     881:	e9 3c 03 00 00       	jmp    bc2 <doCmd+0x464>
		case VI_K_DOWN:             // down
		case VI_K_ENTER:
			dot_down();
     886:	e8 20 05 00 00       	call   dab <dot_down>
			synchronizeDandS();
     88b:	e8 b5 fd ff ff       	call   645 <synchronizeDandS>
			showStatus("--COMMAND--", YELLOW);
     890:	83 ec 08             	sub    $0x8,%esp
     893:	6a 0e                	push   $0xe
     895:	68 e5 2c 00 00       	push   $0x2ce5
     89a:	e8 38 fb ff ff       	call   3d7 <showStatus>
     89f:	83 c4 10             	add    $0x10,%esp
			break;
     8a2:	e9 1b 03 00 00       	jmp    bc2 <doCmd+0x464>
		case VI_K_LEFT:             // left
			dot_left();
     8a7:	e8 5a 04 00 00       	call   d06 <dot_left>
			synchronizeDandS();
     8ac:	e8 94 fd ff ff       	call   645 <synchronizeDandS>
			showStatus("--COMMAND--", YELLOW);
     8b1:	83 ec 08             	sub    $0x8,%esp
     8b4:	6a 0e                	push   $0xe
     8b6:	68 e5 2c 00 00       	push   $0x2ce5
     8bb:	e8 17 fb ff ff       	call   3d7 <showStatus>
     8c0:	83 c4 10             	add    $0x10,%esp
			break;
     8c3:	e9 fa 02 00 00       	jmp    bc2 <doCmd+0x464>
		case VI_K_RIGHT:            // right
            dot_right();
     8c8:	e8 62 04 00 00       	call   d2f <dot_right>
			synchronizeDandS();
     8cd:	e8 73 fd ff ff       	call   645 <synchronizeDandS>
			showStatus("--COMMAND--", YELLOW);
     8d2:	83 ec 08             	sub    $0x8,%esp
     8d5:	6a 0e                	push   $0xe
     8d7:	68 e5 2c 00 00       	push   $0x2ce5
     8dc:	e8 f6 fa ff ff       	call   3d7 <showStatus>
     8e1:	83 c4 10             	add    $0x10,%esp
			break;
     8e4:	e9 d9 02 00 00       	jmp    bc2 <doCmd+0x464>
		case VI_K_PAGEUP:			// page up
			for(i=0;i<rows-1;i++)
     8e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     8f0:	eb 09                	jmp    8fb <doCmd+0x19d>
				dot_preLine();
     8f2:	e8 08 05 00 00       	call   dff <dot_preLine>
            dot_right();
			synchronizeDandS();
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_PAGEUP:			// page up
			for(i=0;i<rows-1;i++)
     8f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     8fb:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     900:	83 e8 01             	sub    $0x1,%eax
     903:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     906:	7f ea                	jg     8f2 <doCmd+0x194>
				dot_preLine();
			screenbegin = dot;
     908:	a1 14 3d 00 00       	mov    0x3d14,%eax
     90d:	a3 10 3d 00 00       	mov    %eax,0x3d10
			showStatus("--COMMAND--", YELLOW);
     912:	83 ec 08             	sub    $0x8,%esp
     915:	6a 0e                	push   $0xe
     917:	68 e5 2c 00 00       	push   $0x2ce5
     91c:	e8 b6 fa ff ff       	call   3d7 <showStatus>
     921:	83 c4 10             	add    $0x10,%esp
			break;
     924:	e9 99 02 00 00       	jmp    bc2 <doCmd+0x464>
		case VI_K_PAGEDN:			// page down
			for(i=0;i<rows-1;i++)
     929:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     930:	eb 09                	jmp    93b <doCmd+0x1dd>
				dot_nextLine();
     932:	e8 48 05 00 00       	call   e7f <dot_nextLine>
				dot_preLine();
			screenbegin = dot;
			showStatus("--COMMAND--", YELLOW);
			break;
		case VI_K_PAGEDN:			// page down
			for(i=0;i<rows-1;i++)
     937:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     93b:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     940:	83 e8 01             	sub    $0x1,%eax
     943:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     946:	7f ea                	jg     932 <doCmd+0x1d4>
				dot_nextLine();
			screenbegin = dot;
     948:	a1 14 3d 00 00       	mov    0x3d14,%eax
     94d:	a3 10 3d 00 00       	mov    %eax,0x3d10
			showStatus("--COMMAND--", YELLOW);
     952:	83 ec 08             	sub    $0x8,%esp
     955:	6a 0e                	push   $0xe
     957:	68 e5 2c 00 00       	push   $0x2ce5
     95c:	e8 76 fa ff ff       	call   3d7 <showStatus>
     961:	83 c4 10             	add    $0x10,%esp
			break;
     964:	e9 59 02 00 00       	jmp    bc2 <doCmd+0x464>
	// 删除
		case 'x':						// 删除光标所在处的字符
		case VI_K_DELETE:
			hasChanged = 1;
     969:	c7 05 08 3d 00 00 01 	movl   $0x1,0x3d08
     970:	00 00 00 
			dot_delete();
     973:	e8 f1 09 00 00       	call   1369 <dot_delete>
			break;
     978:	e9 45 02 00 00       	jmp    bc2 <doCmd+0x464>
	// 查找命令
		case '/':					// 只能查找31个字符(33->126)以内的。查找字符串不包含空格（' ','\t','\n'）
			pos = getCursorPos();
     97d:	e8 3a 14 00 00       	call   1dbc <getCursorPos>
     982:	89 45 ec             	mov    %eax,-0x14(%ebp)
			showStatus("",0);
     985:	83 ec 08             	sub    $0x8,%esp
     988:	6a 00                	push   $0x0
     98a:	68 f1 2c 00 00       	push   $0x2cf1
     98f:	e8 43 fa ff ff       	call   3d7 <showStatus>
     994:	83 c4 10             	add    $0x10,%esp
			writeAt(rows,0,'/');
     997:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     99c:	83 ec 04             	sub    $0x4,%esp
     99f:	6a 2f                	push   $0x2f
     9a1:	6a 00                	push   $0x0
     9a3:	50                   	push   %eax
     9a4:	e8 fb 13 00 00       	call   1da4 <writeAt>
     9a9:	83 c4 10             	add    $0x10,%esp
			i = 0;
     9ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
			while(i<findStringLength-1){
     9b3:	eb 7b                	jmp    a30 <doCmd+0x2d2>
				read(0,&tmp,1);
     9b5:	83 ec 04             	sub    $0x4,%esp
     9b8:	6a 01                	push   $0x1
     9ba:	8d 45 eb             	lea    -0x15(%ebp),%eax
     9bd:	50                   	push   %eax
     9be:	6a 00                	push   $0x0
     9c0:	e8 3f 13 00 00       	call   1d04 <read>
     9c5:	83 c4 10             	add    $0x10,%esp
				if(tmp==VI_K_ESC){
     9c8:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
     9cc:	3c 1b                	cmp    $0x1b,%al
     9ce:	75 17                	jne    9e7 <doCmd+0x289>
					showStatus("--COMMAND--", YELLOW);	// 清除状态行
     9d0:	83 ec 08             	sub    $0x8,%esp
     9d3:	6a 0e                	push   $0xe
     9d5:	68 e5 2c 00 00       	push   $0x2ce5
     9da:	e8 f8 f9 ff ff       	call   3d7 <showStatus>
     9df:	83 c4 10             	add    $0x10,%esp
     9e2:	e9 db 01 00 00       	jmp    bc2 <doCmd+0x464>
					return;
				}
				if(tmp=='\n')	
     9e7:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
     9eb:	3c 0a                	cmp    $0xa,%al
     9ed:	74 4d                	je     a3c <doCmd+0x2de>
					break;
				if(tmp>=33 && tmp<=126){
     9ef:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
     9f3:	3c 20                	cmp    $0x20,%al
     9f5:	7e 39                	jle    a30 <doCmd+0x2d2>
     9f7:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
     9fb:	3c 7f                	cmp    $0x7f,%al
     9fd:	74 31                	je     a30 <doCmd+0x2d2>
					currentFindString[i++] = tmp;
     9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a02:	8d 50 01             	lea    0x1(%eax),%edx
     a05:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a08:	0f b6 55 eb          	movzbl -0x15(%ebp),%edx
     a0c:	88 54 05 cb          	mov    %dl,-0x35(%ebp,%eax,1)
					writeAt(rows,i+1,tmp);
     a10:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
     a14:	0f be d0             	movsbl %al,%edx
     a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1a:	8d 48 01             	lea    0x1(%eax),%ecx
     a1d:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     a22:	83 ec 04             	sub    $0x4,%esp
     a25:	52                   	push   %edx
     a26:	51                   	push   %ecx
     a27:	50                   	push   %eax
     a28:	e8 77 13 00 00       	call   1da4 <writeAt>
     a2d:	83 c4 10             	add    $0x10,%esp
		case '/':					// 只能查找31个字符(33->126)以内的。查找字符串不包含空格（' ','\t','\n'）
			pos = getCursorPos();
			showStatus("",0);
			writeAt(rows,0,'/');
			i = 0;
			while(i<findStringLength-1){
     a30:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
     a34:	0f 8e 7b ff ff ff    	jle    9b5 <doCmd+0x257>
     a3a:	eb 01                	jmp    a3d <doCmd+0x2df>
				if(tmp==VI_K_ESC){
					showStatus("--COMMAND--", YELLOW);	// 清除状态行
					return;
				}
				if(tmp=='\n')	
					break;
     a3c:	90                   	nop
				if(tmp>=33 && tmp<=126){
					currentFindString[i++] = tmp;
					writeAt(rows,i+1,tmp);
				}
			}
			currentFindString[i] = '\0';
     a3d:	8d 55 cb             	lea    -0x35(%ebp),%edx
     a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a43:	01 d0                	add    %edx,%eax
     a45:	c6 00 00             	movb   $0x0,(%eax)

			setCursorPos(pos/80,pos%80);
     a48:	8b 5d ec             	mov    -0x14(%ebp),%ebx
     a4b:	ba 67 66 66 66       	mov    $0x66666667,%edx
     a50:	89 d8                	mov    %ebx,%eax
     a52:	f7 ea                	imul   %edx
     a54:	c1 fa 05             	sar    $0x5,%edx
     a57:	89 d8                	mov    %ebx,%eax
     a59:	c1 f8 1f             	sar    $0x1f,%eax
     a5c:	89 d1                	mov    %edx,%ecx
     a5e:	29 c1                	sub    %eax,%ecx
     a60:	89 c8                	mov    %ecx,%eax
     a62:	c1 e0 02             	shl    $0x2,%eax
     a65:	01 c8                	add    %ecx,%eax
     a67:	c1 e0 04             	shl    $0x4,%eax
     a6a:	29 c3                	sub    %eax,%ebx
     a6c:	89 d9                	mov    %ebx,%ecx
     a6e:	8b 5d ec             	mov    -0x14(%ebp),%ebx
     a71:	ba 67 66 66 66       	mov    $0x66666667,%edx
     a76:	89 d8                	mov    %ebx,%eax
     a78:	f7 ea                	imul   %edx
     a7a:	c1 fa 05             	sar    $0x5,%edx
     a7d:	89 d8                	mov    %ebx,%eax
     a7f:	c1 f8 1f             	sar    $0x1f,%eax
     a82:	29 c2                	sub    %eax,%edx
     a84:	89 d0                	mov    %edx,%eax
     a86:	83 ec 08             	sub    $0x8,%esp
     a89:	51                   	push   %ecx
     a8a:	50                   	push   %eax
     a8b:	e8 fc 12 00 00       	call   1d8c <setCursorPos>
     a90:	83 c4 10             	add    $0x10,%esp

			if(strlen(currentFindString)>0){
     a93:	83 ec 0c             	sub    $0xc,%esp
     a96:	8d 45 cb             	lea    -0x35(%ebp),%eax
     a99:	50                   	push   %eax
     a9a:	e8 8b 10 00 00       	call   1b2a <strlen>
     a9f:	83 c4 10             	add    $0x10,%esp
     aa2:	85 c0                	test   %eax,%eax
     aa4:	74 14                	je     aba <doCmd+0x35c>
				strcpy(lastFindString,currentFindString);
     aa6:	83 ec 08             	sub    $0x8,%esp
     aa9:	8d 45 cb             	lea    -0x35(%ebp),%eax
     aac:	50                   	push   %eax
     aad:	68 80 3b 00 00       	push   $0x3b80
     ab2:	e8 04 10 00 00       	call   1abb <strcpy>
     ab7:	83 c4 10             	add    $0x10,%esp
			}
		case 'n':
			if(strlen(lastFindString)==0){
     aba:	83 ec 0c             	sub    $0xc,%esp
     abd:	68 80 3b 00 00       	push   $0x3b80
     ac2:	e8 63 10 00 00       	call   1b2a <strlen>
     ac7:	83 c4 10             	add    $0x10,%esp
     aca:	85 c0                	test   %eax,%eax
     acc:	75 17                	jne    ae5 <doCmd+0x387>
				showStatus("No previous regular expression", RED);
     ace:	83 ec 08             	sub    $0x8,%esp
     ad1:	6a 04                	push   $0x4
     ad3:	68 f4 2c 00 00       	push   $0x2cf4
     ad8:	e8 fa f8 ff ff       	call   3d7 <showStatus>
     add:	83 c4 10             	add    $0x10,%esp

				dot = findString(lastFindString);
				synchronizeDandS();
				showStatus(lastFindString, GREEN);
			}
			break;
     ae0:	e9 dd 00 00 00       	jmp    bc2 <doCmd+0x464>
			if(strlen(lastFindString)==0){
				showStatus("No previous regular expression", RED);
			}
			else{

				dot = findString(lastFindString);
     ae5:	83 ec 0c             	sub    $0xc,%esp
     ae8:	68 80 3b 00 00       	push   $0x3b80
     aed:	e8 f6 09 00 00       	call   14e8 <findString>
     af2:	83 c4 10             	add    $0x10,%esp
     af5:	a3 14 3d 00 00       	mov    %eax,0x3d14
				synchronizeDandS();
     afa:	e8 46 fb ff ff       	call   645 <synchronizeDandS>
				showStatus(lastFindString, GREEN);
     aff:	83 ec 08             	sub    $0x8,%esp
     b02:	6a 02                	push   $0x2
     b04:	68 80 3b 00 00       	push   $0x3b80
     b09:	e8 c9 f8 ff ff       	call   3d7 <showStatus>
     b0e:	83 c4 10             	add    $0x10,%esp
			}
			break;
     b11:	e9 ac 00 00 00       	jmp    bc2 <doCmd+0x464>
		case 'N':
			if(strlen(lastFindString)==0){
     b16:	83 ec 0c             	sub    $0xc,%esp
     b19:	68 80 3b 00 00       	push   $0x3b80
     b1e:	e8 07 10 00 00       	call   1b2a <strlen>
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	85 c0                	test   %eax,%eax
     b28:	75 17                	jne    b41 <doCmd+0x3e3>
				showStatus("No previous regular expression",RED);
     b2a:	83 ec 08             	sub    $0x8,%esp
     b2d:	6a 04                	push   $0x4
     b2f:	68 f4 2c 00 00       	push   $0x2cf4
     b34:	e8 9e f8 ff ff       	call   3d7 <showStatus>
     b39:	83 c4 10             	add    $0x10,%esp
			else{
				dot = reverseFind(lastFindString);
				synchronizeDandS();
				showStatus(lastFindString, GREEN);
			}
			break;		
     b3c:	e9 81 00 00 00       	jmp    bc2 <doCmd+0x464>
		case 'N':
			if(strlen(lastFindString)==0){
				showStatus("No previous regular expression",RED);
			}
			else{
				dot = reverseFind(lastFindString);
     b41:	83 ec 0c             	sub    $0xc,%esp
     b44:	68 80 3b 00 00       	push   $0x3b80
     b49:	e8 4b 0a 00 00       	call   1599 <reverseFind>
     b4e:	83 c4 10             	add    $0x10,%esp
     b51:	a3 14 3d 00 00       	mov    %eax,0x3d14
				synchronizeDandS();
     b56:	e8 ea fa ff ff       	call   645 <synchronizeDandS>
				showStatus(lastFindString, GREEN);
     b5b:	83 ec 08             	sub    $0x8,%esp
     b5e:	6a 02                	push   $0x2
     b60:	68 80 3b 00 00       	push   $0x3b80
     b65:	e8 6d f8 ff ff       	call   3d7 <showStatus>
     b6a:	83 c4 10             	add    $0x10,%esp
			}
			break;		
     b6d:	eb 53                	jmp    bc2 <doCmd+0x464>
	// 模式切换命令
		case 'i':					// 进入插入模式
		case VI_K_INSERT:
			insert();
     b6f:	e8 53 00 00 00       	call   bc7 <insert>
			break;
     b74:	eb 4c                	jmp    bc2 <doCmd+0x464>
		case 'I':					// dot移到行首再进入插入模式
			dot_head();
     b76:	e8 83 03 00 00       	call   efe <dot_head>
			synchronizeDandS();
     b7b:	e8 c5 fa ff ff       	call   645 <synchronizeDandS>
			insert();
     b80:	e8 42 00 00 00       	call   bc7 <insert>
			break;
     b85:	eb 3b                	jmp    bc2 <doCmd+0x464>
		case 'a':					// 进入追加模式
			dot_right();
     b87:	e8 a3 01 00 00       	call   d2f <dot_right>
			insert();
     b8c:	e8 36 00 00 00       	call   bc7 <insert>
			break;
     b91:	eb 2f                	jmp    bc2 <doCmd+0x464>
		case 'A':					// dot移到行尾再进入插入模式
			dot_tail();
     b93:	e8 91 03 00 00       	call   f29 <dot_tail>
			dot_decrease();			// 插入是在'\n'前面插入
     b98:	e8 87 f4 ff ff       	call   24 <dot_decrease>
			synchronizeDandS();
     b9d:	e8 a3 fa ff ff       	call   645 <synchronizeDandS>
			insert();
     ba2:	e8 20 00 00 00       	call   bc7 <insert>
			break;
     ba7:	eb 19                	jmp    bc2 <doCmd+0x464>

	// 一些其他命令
		case ':':						
			doColon();
     ba9:	e8 a5 03 00 00       	call   f53 <doColon>
			break;
     bae:	eb 12                	jmp    bc2 <doCmd+0x464>
		default:
			showStatus("encounter a wrong char !!!!!!", RED);
     bb0:	83 ec 08             	sub    $0x8,%esp
     bb3:	6a 04                	push   $0x4
     bb5:	68 13 2d 00 00       	push   $0x2d13
     bba:	e8 18 f8 ff ff       	call   3d7 <showStatus>
     bbf:	83 c4 10             	add    $0x10,%esp
	}
}
     bc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bc5:	c9                   	leave  
     bc6:	c3                   	ret    

00000bc7 <insert>:

void insert(){
     bc7:	55                   	push   %ebp
     bc8:	89 e5                	mov    %esp,%ebp
     bca:	83 ec 18             	sub    $0x18,%esp
	char c;
	unsigned char C;
	hasChanged = 1;
     bcd:	c7 05 08 3d 00 00 01 	movl   $0x1,0x3d08
     bd4:	00 00 00 
	while(1){
		showStatus("--INSERT--",WHITE);
     bd7:	83 ec 08             	sub    $0x8,%esp
     bda:	6a 0f                	push   $0xf
     bdc:	68 31 2d 00 00       	push   $0x2d31
     be1:	e8 f1 f7 ff ff       	call   3d7 <showStatus>
     be6:	83 c4 10             	add    $0x10,%esp
		read(0,&c,1);
     be9:	83 ec 04             	sub    $0x4,%esp
     bec:	6a 01                	push   $0x1
     bee:	8d 45 f6             	lea    -0xa(%ebp),%eax
     bf1:	50                   	push   %eax
     bf2:	6a 00                	push   $0x0
     bf4:	e8 0b 11 00 00       	call   1d04 <read>
     bf9:	83 c4 10             	add    $0x10,%esp
		if(c==VI_K_ESC){
     bfc:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     c00:	3c 1b                	cmp    $0x1b,%al
     c02:	75 26                	jne    c2a <insert+0x63>
			if (flagCfile == 1)
     c04:	a1 60 3b 00 00       	mov    0x3b60,%eax
     c09:	83 f8 01             	cmp    $0x1,%eax
     c0c:	75 05                	jne    c13 <insert+0x4c>
				reDrawC();
     c0e:	e8 89 0a 00 00       	call   169c <reDrawC>
			showStatus("--COMMAND--", YELLOW);
     c13:	83 ec 08             	sub    $0x8,%esp
     c16:	6a 0e                	push   $0xe
     c18:	68 e5 2c 00 00       	push   $0x2ce5
     c1d:	e8 b5 f7 ff ff       	call   3d7 <showStatus>
     c22:	83 c4 10             	add    $0x10,%esp
			break;
     c25:	e9 95 00 00 00       	jmp    cbf <insert+0xf8>
		}	
		if(ifPrintChar(c)){
     c2a:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     c2e:	0f be c0             	movsbl %al,%eax
     c31:	83 ec 0c             	sub    $0xc,%esp
     c34:	50                   	push   %eax
     c35:	e8 9a 00 00 00       	call   cd4 <ifPrintChar>
     c3a:	83 c4 10             	add    $0x10,%esp
     c3d:	85 c0                	test   %eax,%eax
     c3f:	74 2f                	je     c70 <insert+0xa9>
			insertText(dot,1);
     c41:	a1 14 3d 00 00       	mov    0x3d14,%eax
     c46:	83 ec 08             	sub    $0x8,%esp
     c49:	6a 01                	push   $0x1
     c4b:	50                   	push   %eax
     c4c:	e8 cd 07 00 00       	call   141e <insertText>
     c51:	83 c4 10             	add    $0x10,%esp
			*dot = c;
     c54:	a1 14 3d 00 00       	mov    0x3d14,%eax
     c59:	0f b6 55 f6          	movzbl -0xa(%ebp),%edx
     c5d:	88 10                	mov    %dl,(%eax)
			dot_increase();
     c5f:	e8 9c f3 ff ff       	call   0 <dot_increase>
			reDraw();
     c64:	e8 cc f6 ff ff       	call   335 <reDraw>
			synchronizeDandS();
     c69:	e8 d7 f9 ff ff       	call   645 <synchronizeDandS>
			continue;
     c6e:	eb 4a                	jmp    cba <insert+0xf3>
		}
		C = (unsigned char)c;
     c70:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
     c74:	88 45 f7             	mov    %al,-0x9(%ebp)
		switch(C){
     c77:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     c7b:	2d e1 00 00 00       	sub    $0xe1,%eax
     c80:	83 f8 04             	cmp    $0x4,%eax
     c83:	77 30                	ja     cb5 <insert+0xee>
     c85:	8b 04 85 3c 2d 00 00 	mov    0x2d3c(,%eax,4),%eax
     c8c:	ff e0                	jmp    *%eax
			case VI_K_UP:
				dot_up();
     c8e:	e8 c4 00 00 00       	call   d57 <dot_up>
				break;
     c93:	eb 20                	jmp    cb5 <insert+0xee>
			case VI_K_DOWN:
				dot_down();
     c95:	e8 11 01 00 00       	call   dab <dot_down>
				break;
     c9a:	eb 19                	jmp    cb5 <insert+0xee>
			case VI_K_LEFT:
				dot_left();
     c9c:	e8 65 00 00 00       	call   d06 <dot_left>
				break;
     ca1:	eb 12                	jmp    cb5 <insert+0xee>
			case VI_K_RIGHT:
				dot_right();
     ca3:	e8 87 00 00 00       	call   d2f <dot_right>
				break;
     ca8:	eb 0b                	jmp    cb5 <insert+0xee>
			case VI_K_END:
				dot_tail();
     caa:	e8 7a 02 00 00       	call   f29 <dot_tail>
				dot_left();
     caf:	e8 52 00 00 00       	call   d06 <dot_left>
				break;
     cb4:	90                   	nop
		}
		synchronizeDandS();
     cb5:	e8 8b f9 ff ff       	call   645 <synchronizeDandS>
	}
     cba:	e9 18 ff ff ff       	jmp    bd7 <insert+0x10>
	showStatus("",0);
     cbf:	83 ec 08             	sub    $0x8,%esp
     cc2:	6a 00                	push   $0x0
     cc4:	68 f1 2c 00 00       	push   $0x2cf1
     cc9:	e8 09 f7 ff ff       	call   3d7 <showStatus>
     cce:	83 c4 10             	add    $0x10,%esp
}
     cd1:	90                   	nop
     cd2:	c9                   	leave  
     cd3:	c3                   	ret    

00000cd4 <ifPrintChar>:

// 是可打印字符
int ifPrintChar(char c){
     cd4:	55                   	push   %ebp
     cd5:	89 e5                	mov    %esp,%ebp
     cd7:	83 ec 04             	sub    $0x4,%esp
     cda:	8b 45 08             	mov    0x8(%ebp),%eax
     cdd:	88 45 fc             	mov    %al,-0x4(%ebp)
	if((c>=' '&&c<='~') || c=='\n' || c=='\t')
     ce0:	80 7d fc 1f          	cmpb   $0x1f,-0x4(%ebp)
     ce4:	7e 06                	jle    cec <ifPrintChar+0x18>
     ce6:	80 7d fc 7f          	cmpb   $0x7f,-0x4(%ebp)
     cea:	75 0c                	jne    cf8 <ifPrintChar+0x24>
     cec:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     cf0:	74 06                	je     cf8 <ifPrintChar+0x24>
     cf2:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     cf6:	75 07                	jne    cff <ifPrintChar+0x2b>
		return true;
     cf8:	b8 01 00 00 00       	mov    $0x1,%eax
     cfd:	eb 05                	jmp    d04 <ifPrintChar+0x30>
	else
		return false;
     cff:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d04:	c9                   	leave  
     d05:	c3                   	ret    

00000d06 <dot_left>:

void dot_left(){
     d06:	55                   	push   %ebp
     d07:	89 e5                	mov    %esp,%ebp
	if(dot>text && dot[-1]!='\n'){	// && 短路运算符
     d09:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
     d0f:	a1 00 3d 00 00       	mov    0x3d00,%eax
     d14:	39 c2                	cmp    %eax,%edx
     d16:	76 14                	jbe    d2c <dot_left+0x26>
     d18:	a1 14 3d 00 00       	mov    0x3d14,%eax
     d1d:	83 e8 01             	sub    $0x1,%eax
     d20:	0f b6 00             	movzbl (%eax),%eax
     d23:	3c 0a                	cmp    $0xa,%al
     d25:	74 05                	je     d2c <dot_left+0x26>
		dot_decrease();
     d27:	e8 f8 f2 ff ff       	call   24 <dot_decrease>
	}
}
     d2c:	90                   	nop
     d2d:	5d                   	pop    %ebp
     d2e:	c3                   	ret    

00000d2f <dot_right>:
void dot_right(){
     d2f:	55                   	push   %ebp
     d30:	89 e5                	mov    %esp,%ebp
	if(dot<end-1 && *dot!='\n'){
     d32:	a1 04 3d 00 00       	mov    0x3d04,%eax
     d37:	8d 50 ff             	lea    -0x1(%eax),%edx
     d3a:	a1 14 3d 00 00       	mov    0x3d14,%eax
     d3f:	39 c2                	cmp    %eax,%edx
     d41:	76 11                	jbe    d54 <dot_right+0x25>
     d43:	a1 14 3d 00 00       	mov    0x3d14,%eax
     d48:	0f b6 00             	movzbl (%eax),%eax
     d4b:	3c 0a                	cmp    $0xa,%al
     d4d:	74 05                	je     d54 <dot_right+0x25>
		dot_increase();
     d4f:	e8 ac f2 ff ff       	call   0 <dot_increase>
	}
}
     d54:	90                   	nop
     d55:	5d                   	pop    %ebp
     d56:	c3                   	ret    

00000d57 <dot_up>:
int dot_up(){
     d57:	55                   	push   %ebp
     d58:	89 e5                	mov    %esp,%ebp
     d5a:	83 ec 18             	sub    $0x18,%esp
	char* p=dot;
     d5d:	a1 14 3d 00 00       	mov    0x3d14,%eax
     d62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if(!dot_preLine()){
     d65:	e8 95 00 00 00       	call   dff <dot_preLine>
     d6a:	85 c0                	test   %eax,%eax
     d6c:	75 1c                	jne    d8a <dot_up+0x33>
		return false;
     d6e:	b8 00 00 00 00       	mov    $0x0,%eax
     d73:	eb 34                	jmp    da9 <dot_up+0x52>
	}
	while(p>text && p[-1]!='\n'){
		p--;
     d75:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		dot_right();
     d79:	e8 b1 ff ff ff       	call   d2f <dot_right>
		if(*dot=='\n')
     d7e:	a1 14 3d 00 00       	mov    0x3d14,%eax
     d83:	0f b6 00             	movzbl (%eax),%eax
     d86:	3c 0a                	cmp    $0xa,%al
     d88:	74 19                	je     da3 <dot_up+0x4c>
int dot_up(){
	char* p=dot;
	if(!dot_preLine()){
		return false;
	}
	while(p>text && p[-1]!='\n'){
     d8a:	a1 00 3d 00 00       	mov    0x3d00,%eax
     d8f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     d92:	76 10                	jbe    da4 <dot_up+0x4d>
     d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d97:	83 e8 01             	sub    $0x1,%eax
     d9a:	0f b6 00             	movzbl (%eax),%eax
     d9d:	3c 0a                	cmp    $0xa,%al
     d9f:	75 d4                	jne    d75 <dot_up+0x1e>
     da1:	eb 01                	jmp    da4 <dot_up+0x4d>
		p--;
		dot_right();
		if(*dot=='\n')
			break;
     da3:	90                   	nop
	}
	return true;
     da4:	b8 01 00 00 00       	mov    $0x1,%eax
}
     da9:	c9                   	leave  
     daa:	c3                   	ret    

00000dab <dot_down>:
int dot_down(){
     dab:	55                   	push   %ebp
     dac:	89 e5                	mov    %esp,%ebp
     dae:	83 ec 18             	sub    $0x18,%esp
	char* p = dot;
     db1:	a1 14 3d 00 00       	mov    0x3d14,%eax
     db6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if(!dot_nextLine()){
     db9:	e8 c1 00 00 00       	call   e7f <dot_nextLine>
     dbe:	85 c0                	test   %eax,%eax
     dc0:	75 1c                	jne    dde <dot_down+0x33>
		return false;
     dc2:	b8 00 00 00 00       	mov    $0x0,%eax
     dc7:	eb 34                	jmp    dfd <dot_down+0x52>
	}
	while(p>text && p[-1]!='\n'){
		p--;
     dc9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		dot_right();
     dcd:	e8 5d ff ff ff       	call   d2f <dot_right>
		if(*dot=='\n')
     dd2:	a1 14 3d 00 00       	mov    0x3d14,%eax
     dd7:	0f b6 00             	movzbl (%eax),%eax
     dda:	3c 0a                	cmp    $0xa,%al
     ddc:	74 19                	je     df7 <dot_down+0x4c>
int dot_down(){
	char* p = dot;
	if(!dot_nextLine()){
		return false;
	}
	while(p>text && p[-1]!='\n'){
     dde:	a1 00 3d 00 00       	mov    0x3d00,%eax
     de3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     de6:	76 10                	jbe    df8 <dot_down+0x4d>
     de8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     deb:	83 e8 01             	sub    $0x1,%eax
     dee:	0f b6 00             	movzbl (%eax),%eax
     df1:	3c 0a                	cmp    $0xa,%al
     df3:	75 d4                	jne    dc9 <dot_down+0x1e>
     df5:	eb 01                	jmp    df8 <dot_down+0x4d>
		p--;
		dot_right();
		if(*dot=='\n')
			break;
     df7:	90                   	nop
	}
	return true;
     df8:	b8 01 00 00 00       	mov    $0x1,%eax
}
     dfd:	c9                   	leave  
     dfe:	c3                   	ret    

00000dff <dot_preLine>:

// 上一行开头，如果没有上一行，dot不变。会调整screenbegin
int dot_preLine(){
     dff:	55                   	push   %ebp
     e00:	89 e5                	mov    %esp,%ebp
     e02:	83 ec 18             	sub    $0x18,%esp
	char* p = dot;
     e05:	a1 14 3d 00 00       	mov    0x3d14,%eax
     e0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	dot_head();
     e0d:	e8 ec 00 00 00       	call   efe <dot_head>
	if(dot>text && dot[-1]=='\n'){
     e12:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
     e18:	a1 00 3d 00 00       	mov    0x3d00,%eax
     e1d:	39 c2                	cmp    %eax,%edx
     e1f:	76 4f                	jbe    e70 <dot_preLine+0x71>
     e21:	a1 14 3d 00 00       	mov    0x3d14,%eax
     e26:	83 e8 01             	sub    $0x1,%eax
     e29:	0f b6 00             	movzbl (%eax),%eax
     e2c:	3c 0a                	cmp    $0xa,%al
     e2e:	75 40                	jne    e70 <dot_preLine+0x71>
		dot_decrease();
     e30:	e8 ef f1 ff ff       	call   24 <dot_decrease>
		dot_head();
     e35:	e8 c4 00 00 00       	call   efe <dot_head>
		// 更新screenbegin和cursorPos
		if(dot<screenbegin){
     e3a:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
     e40:	a1 10 3d 00 00       	mov    0x3d10,%eax
     e45:	39 c2                	cmp    %eax,%edx
     e47:	73 20                	jae    e69 <dot_preLine+0x6a>
			screenbegin = dot;
     e49:	a1 14 3d 00 00       	mov    0x3d14,%eax
     e4e:	a3 10 3d 00 00       	mov    %eax,0x3d10
			screenbegin = begin_line(screenbegin);
     e53:	a1 10 3d 00 00       	mov    0x3d10,%eax
     e58:	83 ec 0c             	sub    $0xc,%esp
     e5b:	50                   	push   %eax
     e5c:	e8 43 f8 ff ff       	call   6a4 <begin_line>
     e61:	83 c4 10             	add    $0x10,%esp
     e64:	a3 10 3d 00 00       	mov    %eax,0x3d10
		}
		return true;
     e69:	b8 01 00 00 00       	mov    $0x1,%eax
     e6e:	eb 0d                	jmp    e7d <dot_preLine+0x7e>
	}
	else{
		dot = p;
     e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e73:	a3 14 3d 00 00       	mov    %eax,0x3d14
		return false;
     e78:	b8 00 00 00 00       	mov    $0x0,%eax
	}
}
     e7d:	c9                   	leave  
     e7e:	c3                   	ret    

00000e7f <dot_nextLine>:
// 下一行开头，如果没有下一行，dot不变.会调整screenbegin
int dot_nextLine(){
     e7f:	55                   	push   %ebp
     e80:	89 e5                	mov    %esp,%ebp
     e82:	83 ec 18             	sub    $0x18,%esp
	char* p = dot;
     e85:	a1 14 3d 00 00       	mov    0x3d14,%eax
     e8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	dot_tail();
     e8d:	e8 97 00 00 00       	call   f29 <dot_tail>
	if(dot<end-1 && *dot=='\n'){
     e92:	a1 04 3d 00 00       	mov    0x3d04,%eax
     e97:	8d 50 ff             	lea    -0x1(%eax),%edx
     e9a:	a1 14 3d 00 00       	mov    0x3d14,%eax
     e9f:	39 c2                	cmp    %eax,%edx
     ea1:	76 4c                	jbe    eef <dot_nextLine+0x70>
     ea3:	a1 14 3d 00 00       	mov    0x3d14,%eax
     ea8:	0f b6 00             	movzbl (%eax),%eax
     eab:	3c 0a                	cmp    $0xa,%al
     ead:	75 40                	jne    eef <dot_nextLine+0x70>
		dot_increase();
     eaf:	e8 4c f1 ff ff       	call   0 <dot_increase>
		dot_head();
     eb4:	e8 45 00 00 00       	call   efe <dot_head>
		if(distanceDtoS()>=rows*columns){
     eb9:	e8 d0 f6 ff ff       	call   58e <distanceDtoS>
     ebe:	89 c1                	mov    %eax,%ecx
     ec0:	8b 15 e8 3c 00 00    	mov    0x3ce8,%edx
     ec6:	a1 ec 3c 00 00       	mov    0x3cec,%eax
     ecb:	0f af c2             	imul   %edx,%eax
     ece:	39 c1                	cmp    %eax,%ecx
     ed0:	7c 16                	jl     ee8 <dot_nextLine+0x69>
			screenbegin = next_line(screenbegin);
     ed2:	a1 10 3d 00 00       	mov    0x3d10,%eax
     ed7:	83 ec 0c             	sub    $0xc,%esp
     eda:	50                   	push   %eax
     edb:	e8 4d f8 ff ff       	call   72d <next_line>
     ee0:	83 c4 10             	add    $0x10,%esp
     ee3:	a3 10 3d 00 00       	mov    %eax,0x3d10
		}
		return true;
     ee8:	b8 01 00 00 00       	mov    $0x1,%eax
     eed:	eb 0d                	jmp    efc <dot_nextLine+0x7d>
	}
	else{
		dot = p;
     eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef2:	a3 14 3d 00 00       	mov    %eax,0x3d14
		return false;
     ef7:	b8 00 00 00 00       	mov    $0x0,%eax
	}
}
     efc:	c9                   	leave  
     efd:	c3                   	ret    

00000efe <dot_head>:
void dot_head(){
     efe:	55                   	push   %ebp
     eff:	89 e5                	mov    %esp,%ebp
	while(dot>text && dot[-1]!='\n'){
     f01:	eb 05                	jmp    f08 <dot_head+0xa>
		dot_decrease();		
     f03:	e8 1c f1 ff ff       	call   24 <dot_decrease>
		dot = p;
		return false;
	}
}
void dot_head(){
	while(dot>text && dot[-1]!='\n'){
     f08:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
     f0e:	a1 00 3d 00 00       	mov    0x3d00,%eax
     f13:	39 c2                	cmp    %eax,%edx
     f15:	76 0f                	jbe    f26 <dot_head+0x28>
     f17:	a1 14 3d 00 00       	mov    0x3d14,%eax
     f1c:	83 e8 01             	sub    $0x1,%eax
     f1f:	0f b6 00             	movzbl (%eax),%eax
     f22:	3c 0a                	cmp    $0xa,%al
     f24:	75 dd                	jne    f03 <dot_head+0x5>
		dot_decrease();		
	}
}
     f26:	90                   	nop
     f27:	5d                   	pop    %ebp
     f28:	c3                   	ret    

00000f29 <dot_tail>:

void dot_tail(){
     f29:	55                   	push   %ebp
     f2a:	89 e5                	mov    %esp,%ebp
	while(dot<end-1 && *dot!='\n'){
     f2c:	eb 05                	jmp    f33 <dot_tail+0xa>
		dot_increase();
     f2e:	e8 cd f0 ff ff       	call   0 <dot_increase>
		dot_decrease();		
	}
}

void dot_tail(){
	while(dot<end-1 && *dot!='\n'){
     f33:	a1 04 3d 00 00       	mov    0x3d04,%eax
     f38:	8d 50 ff             	lea    -0x1(%eax),%edx
     f3b:	a1 14 3d 00 00       	mov    0x3d14,%eax
     f40:	39 c2                	cmp    %eax,%edx
     f42:	76 0c                	jbe    f50 <dot_tail+0x27>
     f44:	a1 14 3d 00 00       	mov    0x3d14,%eax
     f49:	0f b6 00             	movzbl (%eax),%eax
     f4c:	3c 0a                	cmp    $0xa,%al
     f4e:	75 de                	jne    f2e <dot_tail+0x5>
		dot_increase();
	}
}
     f50:	90                   	nop
     f51:	5d                   	pop    %ebp
     f52:	c3                   	ret    

00000f53 <doColon>:

// 正对冒号后面的
void doColon(){
     f53:	55                   	push   %ebp
     f54:	89 e5                	mov    %esp,%ebp
     f56:	56                   	push   %esi
     f57:	53                   	push   %ebx
     f58:	83 ec 20             	sub    $0x20,%esp
     f5b:	89 e0                	mov    %esp,%eax
     f5d:	89 c6                	mov    %eax,%esi
	int pos = getCursorPos();
     f5f:	e8 58 0e 00 00       	call   1dbc <getCursorPos>
     f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	showStatus("",0);
     f67:	83 ec 08             	sub    $0x8,%esp
     f6a:	6a 00                	push   $0x0
     f6c:	68 f1 2c 00 00       	push   $0x2cf1
     f71:	e8 61 f4 ff ff       	call   3d7 <showStatus>
     f76:	83 c4 10             	add    $0x10,%esp
	// 获取命令输入并且显示在状态行上
	writeAt(rows,0,':');
     f79:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
     f7e:	83 ec 04             	sub    $0x4,%esp
     f81:	6a 3a                	push   $0x3a
     f83:	6a 00                	push   $0x0
     f85:	50                   	push   %eax
     f86:	e8 19 0e 00 00       	call   1da4 <writeAt>
     f8b:	83 c4 10             	add    $0x10,%esp
	int orderSize = 11;
     f8e:	c7 45 ec 0b 00 00 00 	movl   $0xb,-0x14(%ebp)
	char order[orderSize];
     f95:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f98:	8d 50 ff             	lea    -0x1(%eax),%edx
     f9b:	89 55 e8             	mov    %edx,-0x18(%ebp)
     f9e:	89 c2                	mov    %eax,%edx
     fa0:	b8 10 00 00 00       	mov    $0x10,%eax
     fa5:	83 e8 01             	sub    $0x1,%eax
     fa8:	01 d0                	add    %edx,%eax
     faa:	b9 10 00 00 00       	mov    $0x10,%ecx
     faf:	ba 00 00 00 00       	mov    $0x0,%edx
     fb4:	f7 f1                	div    %ecx
     fb6:	6b c0 10             	imul   $0x10,%eax,%eax
     fb9:	29 c4                	sub    %eax,%esp
     fbb:	89 e0                	mov    %esp,%eax
     fbd:	83 c0 00             	add    $0x0,%eax
     fc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int i=0;
     fc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(1){
		read(0,order+i,1);
     fca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd0:	01 d0                	add    %edx,%eax
     fd2:	83 ec 04             	sub    $0x4,%esp
     fd5:	6a 01                	push   $0x1
     fd7:	50                   	push   %eax
     fd8:	6a 00                	push   $0x0
     fda:	e8 25 0d 00 00       	call   1d04 <read>
     fdf:	83 c4 10             	add    $0x10,%esp
		if(order[i]=='\n')
     fe2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe8:	01 d0                	add    %edx,%eax
     fea:	0f b6 00             	movzbl (%eax),%eax
     fed:	3c 0a                	cmp    $0xa,%al
     fef:	74 38                	je     1029 <doColon+0xd6>
			break;
		writeAt(rows,i+1,order[i]);
     ff1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     ff4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ff7:	01 d0                	add    %edx,%eax
     ff9:	0f b6 00             	movzbl (%eax),%eax
     ffc:	0f be d0             	movsbl %al,%edx
     fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1002:	8d 48 01             	lea    0x1(%eax),%ecx
    1005:	a1 e8 3c 00 00       	mov    0x3ce8,%eax
    100a:	83 ec 04             	sub    $0x4,%esp
    100d:	52                   	push   %edx
    100e:	51                   	push   %ecx
    100f:	50                   	push   %eax
    1010:	e8 8f 0d 00 00       	call   1da4 <writeAt>
    1015:	83 c4 10             	add    $0x10,%esp
		i++;
    1018:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
		if(i==orderSize-1)
    101c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    101f:	83 e8 01             	sub    $0x1,%eax
    1022:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1025:	74 05                	je     102c <doColon+0xd9>
			break;
	}
    1027:	eb a1                	jmp    fca <doColon+0x77>
	char order[orderSize];
	int i=0;
	while(1){
		read(0,order+i,1);
		if(order[i]=='\n')
			break;
    1029:	90                   	nop
    102a:	eb 01                	jmp    102d <doColon+0xda>
		writeAt(rows,i+1,order[i]);
		i++;
		if(i==orderSize-1)
			break;
    102c:	90                   	nop
	}
	order[i]='\0';
    102d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1030:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1033:	01 d0                	add    %edx,%eax
    1035:	c6 00 00             	movb   $0x0,(%eax)

	// 对命令进行解析
	if(strcmp(order,"q!")==0){
    1038:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 50 2d 00 00       	push   $0x2d50
    1043:	50                   	push   %eax
    1044:	e8 a2 0a 00 00       	call   1aeb <strcmp>
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	85 c0                	test   %eax,%eax
    104e:	75 0f                	jne    105f <doColon+0x10c>
		editing = 0;
    1050:	c7 05 18 3d 00 00 00 	movl   $0x0,0x3d18
    1057:	00 00 00 
    105a:	e9 a6 00 00 00       	jmp    1105 <doColon+0x1b2>
	}
	else if(strcmp(order,"q")==0){
    105f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1062:	83 ec 08             	sub    $0x8,%esp
    1065:	68 53 2d 00 00       	push   $0x2d53
    106a:	50                   	push   %eax
    106b:	e8 7b 0a 00 00       	call   1aeb <strcmp>
    1070:	83 c4 10             	add    $0x10,%esp
    1073:	85 c0                	test   %eax,%eax
    1075:	75 2a                	jne    10a1 <doColon+0x14e>
		if(hasChanged==1){
    1077:	a1 08 3d 00 00       	mov    0x3d08,%eax
    107c:	83 f8 01             	cmp    $0x1,%eax
    107f:	75 14                	jne    1095 <doColon+0x142>
			showStatus("No write since last change (add ! to override)", RED);
    1081:	83 ec 08             	sub    $0x8,%esp
    1084:	6a 04                	push   $0x4
    1086:	68 58 2d 00 00       	push   $0x2d58
    108b:	e8 47 f3 ff ff       	call   3d7 <showStatus>
    1090:	83 c4 10             	add    $0x10,%esp
    1093:	eb 70                	jmp    1105 <doColon+0x1b2>
		}
		else{
			editing = 0;
    1095:	c7 05 18 3d 00 00 00 	movl   $0x0,0x3d18
    109c:	00 00 00 
    109f:	eb 64                	jmp    1105 <doColon+0x1b2>
		}
	}
	else if(strcmp(order,"wq")==0){
    10a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10a4:	83 ec 08             	sub    $0x8,%esp
    10a7:	68 87 2d 00 00       	push   $0x2d87
    10ac:	50                   	push   %eax
    10ad:	e8 39 0a 00 00       	call   1aeb <strcmp>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	85 c0                	test   %eax,%eax
    10b7:	75 11                	jne    10ca <doColon+0x177>
		file_save();
    10b9:	e8 9c 00 00 00       	call   115a <file_save>
		editing = 0;
    10be:	c7 05 18 3d 00 00 00 	movl   $0x0,0x3d18
    10c5:	00 00 00 
    10c8:	eb 3b                	jmp    1105 <doColon+0x1b2>
	}
	else if(strcmp(order,"w")==0){
    10ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10cd:	83 ec 08             	sub    $0x8,%esp
    10d0:	68 8a 2d 00 00       	push   $0x2d8a
    10d5:	50                   	push   %eax
    10d6:	e8 10 0a 00 00       	call   1aeb <strcmp>
    10db:	83 c4 10             	add    $0x10,%esp
    10de:	85 c0                	test   %eax,%eax
    10e0:	75 11                	jne    10f3 <doColon+0x1a0>
		hasChanged = 0;
    10e2:	c7 05 08 3d 00 00 00 	movl   $0x0,0x3d08
    10e9:	00 00 00 
		file_save();
    10ec:	e8 69 00 00 00       	call   115a <file_save>
    10f1:	eb 12                	jmp    1105 <doColon+0x1b2>
	}
	else{
		showStatus("wrong command!", RED);
    10f3:	83 ec 08             	sub    $0x8,%esp
    10f6:	6a 04                	push   $0x4
    10f8:	68 8c 2d 00 00       	push   $0x2d8c
    10fd:	e8 d5 f2 ff ff       	call   3d7 <showStatus>
    1102:	83 c4 10             	add    $0x10,%esp
	}
	setCursorPos(pos/80,pos%80);
    1105:	8b 5d f0             	mov    -0x10(%ebp),%ebx
    1108:	ba 67 66 66 66       	mov    $0x66666667,%edx
    110d:	89 d8                	mov    %ebx,%eax
    110f:	f7 ea                	imul   %edx
    1111:	c1 fa 05             	sar    $0x5,%edx
    1114:	89 d8                	mov    %ebx,%eax
    1116:	c1 f8 1f             	sar    $0x1f,%eax
    1119:	89 d1                	mov    %edx,%ecx
    111b:	29 c1                	sub    %eax,%ecx
    111d:	89 c8                	mov    %ecx,%eax
    111f:	c1 e0 02             	shl    $0x2,%eax
    1122:	01 c8                	add    %ecx,%eax
    1124:	c1 e0 04             	shl    $0x4,%eax
    1127:	29 c3                	sub    %eax,%ebx
    1129:	89 d9                	mov    %ebx,%ecx
    112b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
    112e:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1133:	89 d8                	mov    %ebx,%eax
    1135:	f7 ea                	imul   %edx
    1137:	c1 fa 05             	sar    $0x5,%edx
    113a:	89 d8                	mov    %ebx,%eax
    113c:	c1 f8 1f             	sar    $0x1f,%eax
    113f:	29 c2                	sub    %eax,%edx
    1141:	89 d0                	mov    %edx,%eax
    1143:	83 ec 08             	sub    $0x8,%esp
    1146:	51                   	push   %ecx
    1147:	50                   	push   %eax
    1148:	e8 3f 0c 00 00       	call   1d8c <setCursorPos>
    114d:	83 c4 10             	add    $0x10,%esp
    1150:	89 f4                	mov    %esi,%esp
}
    1152:	90                   	nop
    1153:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1156:	5b                   	pop    %ebx
    1157:	5e                   	pop    %esi
    1158:	5d                   	pop    %ebp
    1159:	c3                   	ret    

0000115a <file_save>:

// 保存text到文件cfn中
int file_save(){
    115a:	55                   	push   %ebp
    115b:	89 e5                	mov    %esp,%ebp
    115d:	83 ec 18             	sub    $0x18,%esp
	if(cfn==NULL){
    1160:	a1 f4 3c 00 00       	mov    0x3cf4,%eax
    1165:	85 c0                	test   %eax,%eax
    1167:	75 1c                	jne    1185 <file_save+0x2b>
		showStatus("No current filename!!!",RED);
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	6a 04                	push   $0x4
    116e:	68 9b 2d 00 00       	push   $0x2d9b
    1173:	e8 5f f2 ff ff       	call   3d7 <showStatus>
    1178:	83 c4 10             	add    $0x10,%esp
		return -1;
    117b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1180:	e9 88 00 00 00       	jmp    120d <file_save+0xb3>
	}
	int fd,cnt,resCnt;

	fd = open(cfn,O_WRONLY|O_CREATE);
    1185:	a1 f4 3c 00 00       	mov    0x3cf4,%eax
    118a:	83 ec 08             	sub    $0x8,%esp
    118d:	68 01 02 00 00       	push   $0x201
    1192:	50                   	push   %eax
    1193:	e8 94 0b 00 00       	call   1d2c <open>
    1198:	83 c4 10             	add    $0x10,%esp
    119b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if(fd<0)
    119e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11a2:	79 07                	jns    11ab <file_save+0x51>
		return -1;
    11a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11a9:	eb 62                	jmp    120d <file_save+0xb3>
	cnt = end - text + 1;
    11ab:	a1 04 3d 00 00       	mov    0x3d04,%eax
    11b0:	89 c2                	mov    %eax,%edx
    11b2:	a1 00 3d 00 00       	mov    0x3d00,%eax
    11b7:	29 c2                	sub    %eax,%edx
    11b9:	89 d0                	mov    %edx,%eax
    11bb:	83 c0 01             	add    $0x1,%eax
    11be:	89 45 f0             	mov    %eax,-0x10(%ebp)

	resCnt = write(fd,text,cnt);
    11c1:	a1 00 3d 00 00       	mov    0x3d00,%eax
    11c6:	83 ec 04             	sub    $0x4,%esp
    11c9:	ff 75 f0             	pushl  -0x10(%ebp)
    11cc:	50                   	push   %eax
    11cd:	ff 75 f4             	pushl  -0xc(%ebp)
    11d0:	e8 37 0b 00 00       	call   1d0c <write>
    11d5:	83 c4 10             	add    $0x10,%esp
    11d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if(resCnt!=cnt){
    11db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11e1:	74 19                	je     11fc <file_save+0xa2>
		showStatus("save error!!!",RED);
    11e3:	83 ec 08             	sub    $0x8,%esp
    11e6:	6a 04                	push   $0x4
    11e8:	68 b2 2d 00 00       	push   $0x2db2
    11ed:	e8 e5 f1 ff ff       	call   3d7 <showStatus>
    11f2:	83 c4 10             	add    $0x10,%esp
		return 0;
    11f5:	b8 00 00 00 00       	mov    $0x0,%eax
    11fa:	eb 11                	jmp    120d <file_save+0xb3>
	}
	close(fd);
    11fc:	83 ec 0c             	sub    $0xc,%esp
    11ff:	ff 75 f4             	pushl  -0xc(%ebp)
    1202:	e8 0d 0b 00 00       	call   1d14 <close>
    1207:	83 c4 10             	add    $0x10,%esp
	return resCnt;
    120a:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    120d:	c9                   	leave  
    120e:	c3                   	ret    

0000120f <freeResource>:
void freeResource(){
    120f:	55                   	push   %ebp
    1210:	89 e5                	mov    %esp,%ebp
    1212:	83 ec 08             	sub    $0x8,%esp
	if(status_buffer!=NULL)
    1215:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
    121a:	85 c0                	test   %eax,%eax
    121c:	74 11                	je     122f <freeResource+0x20>
		free(status_buffer);
    121e:	a1 f8 3c 00 00       	mov    0x3cf8,%eax
    1223:	83 ec 0c             	sub    $0xc,%esp
    1226:	50                   	push   %eax
    1227:	e8 28 0e 00 00       	call   2054 <free>
    122c:	83 c4 10             	add    $0x10,%esp
	if(text!=NULL)
    122f:	a1 00 3d 00 00       	mov    0x3d00,%eax
    1234:	85 c0                	test   %eax,%eax
    1236:	74 11                	je     1249 <freeResource+0x3a>
		free(text);
    1238:	a1 00 3d 00 00       	mov    0x3d00,%eax
    123d:	83 ec 0c             	sub    $0xc,%esp
    1240:	50                   	push   %eax
    1241:	e8 0e 0e 00 00       	call   2054 <free>
    1246:	83 c4 10             	add    $0x10,%esp
}
    1249:	90                   	nop
    124a:	c9                   	leave  
    124b:	c3                   	ret    

0000124c <new_text>:
// 创建一个text缓存，存放打开的文件（大小为文件大小的2倍+8）
void new_text(int size){
    124c:	55                   	push   %ebp
    124d:	89 e5                	mov    %esp,%ebp
    124f:	83 ec 08             	sub    $0x8,%esp
	if (size < 10240)
    1252:	81 7d 08 ff 27 00 00 	cmpl   $0x27ff,0x8(%ebp)
    1259:	7f 07                	jg     1262 <new_text+0x16>
		size = 10240;	// have a minimum size for new files
    125b:	c7 45 08 00 28 00 00 	movl   $0x2800,0x8(%ebp)
	if (text != NULL)
    1262:	a1 00 3d 00 00       	mov    0x3d00,%eax
    1267:	85 c0                	test   %eax,%eax
    1269:	74 11                	je     127c <new_text+0x30>
		free(text);
    126b:	a1 00 3d 00 00       	mov    0x3d00,%eax
    1270:	83 ec 0c             	sub    $0xc,%esp
    1273:	50                   	push   %eax
    1274:	e8 db 0d 00 00       	call   2054 <free>
    1279:	83 c4 10             	add    $0x10,%esp
	text = (char *) malloc(size + 8);
    127c:	8b 45 08             	mov    0x8(%ebp),%eax
    127f:	83 c0 08             	add    $0x8,%eax
    1282:	83 ec 0c             	sub    $0xc,%esp
    1285:	50                   	push   %eax
    1286:	e8 0b 0f 00 00       	call   2196 <malloc>
    128b:	83 c4 10             	add    $0x10,%esp
    128e:	a3 00 3d 00 00       	mov    %eax,0x3d00
	memset(text, '\0', size);	// clear new text[]
    1293:	8b 55 08             	mov    0x8(%ebp),%edx
    1296:	a1 00 3d 00 00       	mov    0x3d00,%eax
    129b:	83 ec 04             	sub    $0x4,%esp
    129e:	52                   	push   %edx
    129f:	6a 00                	push   $0x0
    12a1:	50                   	push   %eax
    12a2:	e8 aa 08 00 00       	call   1b51 <memset>
    12a7:	83 c4 10             	add    $0x10,%esp

	textend = text + size;	
    12aa:	8b 15 00 3d 00 00    	mov    0x3d00,%edx
    12b0:	8b 45 08             	mov    0x8(%ebp),%eax
    12b3:	01 d0                	add    %edx,%eax
    12b5:	a3 f0 3c 00 00       	mov    %eax,0x3cf0
	return;
    12ba:	90                   	nop
}
    12bb:	c9                   	leave  
    12bc:	c3                   	ret    

000012bd <file_size>:

// -1代表失败，其他代表文件大小
int file_size(char* fn){
    12bd:	55                   	push   %ebp
    12be:	89 e5                	mov    %esp,%ebp
    12c0:	83 ec 28             	sub    $0x28,%esp
	struct stat st_buf;
	int cnt, sr;
	cnt = -1;
    12c3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
	sr = stat(fn, &st_buf);	// see if file exists
    12ca:	83 ec 08             	sub    $0x8,%esp
    12cd:	8d 45 dc             	lea    -0x24(%ebp),%eax
    12d0:	50                   	push   %eax
    12d1:	ff 75 08             	pushl  0x8(%ebp)
    12d4:	e8 34 09 00 00       	call   1c0d <stat>
    12d9:	83 c4 10             	add    $0x10,%esp
    12dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (sr >= 0)
    12df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12e3:	78 06                	js     12eb <file_size+0x2e>
		cnt = (int) st_buf.size;
    12e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return cnt;
    12eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12ee:	c9                   	leave  
    12ef:	c3                   	ret    

000012f0 <readFile>:
// 从文件fn中读入size个字节，插入到指针p处，返回插入字节数
int readFile(char * fn, char * p, int size){
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	83 ec 18             	sub    $0x18,%esp
	int fd, cnt;
	cnt = -1;
    12f6:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)

	// 打开文件
	fd = open(fn, O_RDWR);			// assume read & write
    12fd:	83 ec 08             	sub    $0x8,%esp
    1300:	6a 02                	push   $0x2
    1302:	ff 75 08             	pushl  0x8(%ebp)
    1305:	e8 22 0a 00 00       	call   1d2c <open>
    130a:	83 c4 10             	add    $0x10,%esp
    130d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (fd < 0) {
    1310:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1314:	79 19                	jns    132f <readFile+0x3f>
		// could not open for writing- maybe file is read only
		fd = open((char *) fn, O_RDONLY);	// try read-only
    1316:	83 ec 08             	sub    $0x8,%esp
    1319:	6a 00                	push   $0x0
    131b:	ff 75 08             	pushl  0x8(%ebp)
    131e:	e8 09 0a 00 00       	call   1d2c <open>
    1323:	83 c4 10             	add    $0x10,%esp
    1326:	89 45 f4             	mov    %eax,-0xc(%ebp)
		if (fd < 0) {
    1329:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    132d:	78 34                	js     1363 <readFile+0x73>
			goto fi0;
		}
	}

	cnt = read(fd, p, size);
    132f:	83 ec 04             	sub    $0x4,%esp
    1332:	ff 75 10             	pushl  0x10(%ebp)
    1335:	ff 75 0c             	pushl  0xc(%ebp)
    1338:	ff 75 f4             	pushl  -0xc(%ebp)
    133b:	e8 c4 09 00 00       	call   1d04 <read>
    1340:	83 c4 10             	add    $0x10,%esp
    1343:	89 45 f0             	mov    %eax,-0x10(%ebp)
	close(fd);
    1346:	83 ec 0c             	sub    $0xc,%esp
    1349:	ff 75 f4             	pushl  -0xc(%ebp)
    134c:	e8 c3 09 00 00       	call   1d14 <close>
    1351:	83 c4 10             	add    $0x10,%esp

	if(cnt < 0)
    1354:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1358:	79 0a                	jns    1364 <readFile+0x74>
		cnt = -1;
    135a:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    1361:	eb 01                	jmp    1364 <readFile+0x74>
	fd = open(fn, O_RDWR);			// assume read & write
	if (fd < 0) {
		// could not open for writing- maybe file is read only
		fd = open((char *) fn, O_RDONLY);	// try read-only
		if (fd < 0) {
			goto fi0;
    1363:	90                   	nop

	if(cnt < 0)
		cnt = -1;
	
	fi0:
	return cnt;
    1364:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1367:	c9                   	leave  
    1368:	c3                   	ret    

00001369 <dot_delete>:

void dot_delete(){
    1369:	55                   	push   %ebp
    136a:	89 e5                	mov    %esp,%ebp
    136c:	83 ec 08             	sub    $0x8,%esp
	deleteText(dot,dot);
    136f:	8b 15 14 3d 00 00    	mov    0x3d14,%edx
    1375:	a1 14 3d 00 00       	mov    0x3d14,%eax
    137a:	83 ec 08             	sub    $0x8,%esp
    137d:	52                   	push   %edx
    137e:	50                   	push   %eax
    137f:	e8 1d 00 00 00       	call   13a1 <deleteText>
    1384:	83 c4 10             	add    $0x10,%esp
	reDraw();
    1387:	e8 a9 ef ff ff       	call   335 <reDraw>
	showStatus("--DELETE--",WHITE);
    138c:	83 ec 08             	sub    $0x8,%esp
    138f:	6a 0f                	push   $0xf
    1391:	68 c0 2d 00 00       	push   $0x2dc0
    1396:	e8 3c f0 ff ff       	call   3d7 <showStatus>
    139b:	83 c4 10             	add    $0x10,%esp
}
    139e:	90                   	nop
    139f:	c9                   	leave  
    13a0:	c3                   	ret    

000013a1 <deleteText>:
//删除从_start到_end（包括_end)的空间
void deleteText(char* _start,char* _end){
    13a1:	55                   	push   %ebp
    13a2:	89 e5                	mov    %esp,%ebp
    13a4:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	char* tmp;

	if(_start>_end){
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13ad:	76 12                	jbe    13c1 <deleteText+0x20>
		tmp = _start;
    13af:	8b 45 08             	mov    0x8(%ebp),%eax
    13b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		_start = _end;
    13b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b8:	89 45 08             	mov    %eax,0x8(%ebp)
		_end = tmp;
    13bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13be:	89 45 0c             	mov    %eax,0xc(%ebp)
	}
	// cnt = _end - _start + 1;
	cnt = end - _end;
    13c1:	a1 04 3d 00 00       	mov    0x3d04,%eax
    13c6:	89 c2                	mov    %eax,%edx
    13c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cb:	29 c2                	sub    %eax,%edx
    13cd:	89 d0                	mov    %edx,%eax
    13cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if(memmove(_start,_end+1,cnt)==_start){
    13d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d5:	83 c0 01             	add    $0x1,%eax
    13d8:	83 ec 04             	sub    $0x4,%esp
    13db:	ff 75 f0             	pushl  -0x10(%ebp)
    13de:	50                   	push   %eax
    13df:	ff 75 08             	pushl  0x8(%ebp)
    13e2:	e8 c0 08 00 00       	call   1ca7 <memmove>
    13e7:	83 c4 10             	add    $0x10,%esp
    13ea:	3b 45 08             	cmp    0x8(%ebp),%eax
    13ed:	75 1a                	jne    1409 <deleteText+0x68>
		end = end - (_end - _start + 1);
    13ef:	a1 04 3d 00 00       	mov    0x3d04,%eax
    13f4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13f7:	8b 55 08             	mov    0x8(%ebp),%edx
    13fa:	29 d1                	sub    %edx,%ecx
    13fc:	89 ca                	mov    %ecx,%edx
    13fe:	f7 d2                	not    %edx
    1400:	01 d0                	add    %edx,%eax
    1402:	a3 04 3d 00 00       	mov    %eax,0x3d04
		
	}
	else{
		showStatus("can't delete the character!!!",RED);
	}
}
    1407:	eb 12                	jmp    141b <deleteText+0x7a>
	if(memmove(_start,_end+1,cnt)==_start){
		end = end - (_end - _start + 1);
		
	}
	else{
		showStatus("can't delete the character!!!",RED);
    1409:	83 ec 08             	sub    $0x8,%esp
    140c:	6a 04                	push   $0x4
    140e:	68 cb 2d 00 00       	push   $0x2dcb
    1413:	e8 bf ef ff ff       	call   3d7 <showStatus>
    1418:	83 c4 10             	add    $0x10,%esp
	}
}
    141b:	90                   	nop
    141c:	c9                   	leave  
    141d:	c3                   	ret    

0000141e <insertText>:

// 在*p前面插入n个字节
int insertText(char* p,int n){
    141e:	55                   	push   %ebp
    141f:	89 e5                	mov    %esp,%ebp
    1421:	83 ec 18             	sub    $0x18,%esp
	char* q = p + n;
    1424:	8b 55 0c             	mov    0xc(%ebp),%edx
    1427:	8b 45 08             	mov    0x8(%ebp),%eax
    142a:	01 d0                	add    %edx,%eax
    142c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int cnt = end - p + 1;
    142f:	a1 04 3d 00 00       	mov    0x3d04,%eax
    1434:	89 c2                	mov    %eax,%edx
    1436:	8b 45 08             	mov    0x8(%ebp),%eax
    1439:	29 c2                	sub    %eax,%edx
    143b:	89 d0                	mov    %edx,%eax
    143d:	83 c0 01             	add    $0x1,%eax
    1440:	89 45 f0             	mov    %eax,-0x10(%ebp)

	if(end+n>textend)
    1443:	8b 15 04 3d 00 00    	mov    0x3d04,%edx
    1449:	8b 45 0c             	mov    0xc(%ebp),%eax
    144c:	01 c2                	add    %eax,%edx
    144e:	a1 f0 3c 00 00       	mov    0x3cf0,%eax
    1453:	39 c2                	cmp    %eax,%edx
    1455:	76 07                	jbe    145e <insertText+0x40>
		return -1;
    1457:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    145c:	eb 3b                	jmp    1499 <insertText+0x7b>
	end = end + n;
    145e:	8b 15 04 3d 00 00    	mov    0x3d04,%edx
    1464:	8b 45 0c             	mov    0xc(%ebp),%eax
    1467:	01 d0                	add    %edx,%eax
    1469:	a3 04 3d 00 00       	mov    %eax,0x3d04
	moveC(q,p,cnt);
    146e:	83 ec 04             	sub    $0x4,%esp
    1471:	ff 75 f0             	pushl  -0x10(%ebp)
    1474:	ff 75 08             	pushl  0x8(%ebp)
    1477:	ff 75 f4             	pushl  -0xc(%ebp)
    147a:	e8 1c 00 00 00       	call   149b <moveC>
    147f:	83 c4 10             	add    $0x10,%esp
	memset(p,' ',n);		// 将申请的n个字节置为空格。
    1482:	8b 45 0c             	mov    0xc(%ebp),%eax
    1485:	83 ec 04             	sub    $0x4,%esp
    1488:	50                   	push   %eax
    1489:	6a 20                	push   $0x20
    148b:	ff 75 08             	pushl  0x8(%ebp)
    148e:	e8 be 06 00 00       	call   1b51 <memset>
    1493:	83 c4 10             	add    $0x10,%esp
	return n;
    1496:	8b 45 0c             	mov    0xc(%ebp),%eax
}
    1499:	c9                   	leave  
    149a:	c3                   	ret    

0000149b <moveC>:
char* moveC(char* _to,char* _from,int count){
    149b:	55                   	push   %ebp
    149c:	89 e5                	mov    %esp,%ebp
    149e:	83 ec 10             	sub    $0x10,%esp
	char *from,*to;
	from = _from + count - 1;
    14a1:	8b 45 10             	mov    0x10(%ebp),%eax
    14a4:	8d 50 ff             	lea    -0x1(%eax),%edx
    14a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    14aa:	01 d0                	add    %edx,%eax
    14ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	to = _to + count - 1;
    14af:	8b 45 10             	mov    0x10(%ebp),%eax
    14b2:	8d 50 ff             	lea    -0x1(%eax),%edx
    14b5:	8b 45 08             	mov    0x8(%ebp),%eax
    14b8:	01 d0                	add    %edx,%eax
    14ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while(count-- > 0){
    14bd:	eb 17                	jmp    14d6 <moveC+0x3b>
		*to-- = *from--;
    14bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14c2:	8d 50 ff             	lea    -0x1(%eax),%edx
    14c5:	89 55 f8             	mov    %edx,-0x8(%ebp)
    14c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14cb:	8d 4a ff             	lea    -0x1(%edx),%ecx
    14ce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    14d1:	0f b6 12             	movzbl (%edx),%edx
    14d4:	88 10                	mov    %dl,(%eax)
}
char* moveC(char* _to,char* _from,int count){
	char *from,*to;
	from = _from + count - 1;
	to = _to + count - 1;
	while(count-- > 0){
    14d6:	8b 45 10             	mov    0x10(%ebp),%eax
    14d9:	8d 50 ff             	lea    -0x1(%eax),%edx
    14dc:	89 55 10             	mov    %edx,0x10(%ebp)
    14df:	85 c0                	test   %eax,%eax
    14e1:	7f dc                	jg     14bf <moveC+0x24>
		*to-- = *from--;
	}
	return _to;
    14e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14e6:	c9                   	leave  
    14e7:	c3                   	ret    

000014e8 <findString>:

// 正向查找字符串s
char* findString(char* s){
    14e8:	55                   	push   %ebp
    14e9:	89 e5                	mov    %esp,%ebp
    14eb:	83 ec 18             	sub    $0x18,%esp
	char* p=dot;
    14ee:	a1 14 3d 00 00       	mov    0x3d14,%eax
    14f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int count=0;
    14f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int res = 0;
    14fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while(1){
		if(p==end-1){	
    1504:	a1 04 3d 00 00       	mov    0x3d04,%eax
    1509:	83 e8 01             	sub    $0x1,%eax
    150c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    150f:	75 42                	jne    1553 <findString+0x6b>
			if(count==1)
    1511:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    1515:	75 07                	jne    151e <findString+0x36>
				return dot;
    1517:	a1 14 3d 00 00       	mov    0x3d14,%eax
    151c:	eb 79                	jmp    1597 <findString+0xaf>
			count++;
    151e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

			showStatus("search hit BOTTOM, continuing at TOP",WHITE);	
    1522:	83 ec 08             	sub    $0x8,%esp
    1525:	6a 0f                	push   $0xf
    1527:	68 ec 2d 00 00       	push   $0x2dec
    152c:	e8 a6 ee ff ff       	call   3d7 <showStatus>
    1531:	83 c4 10             	add    $0x10,%esp
			sleep(30);	
    1534:	83 ec 0c             	sub    $0xc,%esp
    1537:	6a 1e                	push   $0x1e
    1539:	e8 3e 08 00 00       	call   1d7c <sleep>
    153e:	83 c4 10             	add    $0x10,%esp
			p = text;
    1541:	a1 00 3d 00 00       	mov    0x3d00,%eax
    1546:	89 45 f4             	mov    %eax,-0xc(%ebp)
			synchronizeDandS();
    1549:	e8 f7 f0 ff ff       	call   645 <synchronizeDandS>
			reDraw();
    154e:	e8 e2 ed ff ff       	call   335 <reDraw>
		}
		p++;
    1553:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
		res = equal(p,s);
    1557:	83 ec 08             	sub    $0x8,%esp
    155a:	ff 75 08             	pushl  0x8(%ebp)
    155d:	ff 75 f4             	pushl  -0xc(%ebp)
    1560:	e8 e5 00 00 00       	call   164a <equal>
    1565:	83 c4 10             	add    $0x10,%esp
    1568:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if(res==1){
    156b:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    156f:	75 05                	jne    1576 <findString+0x8e>
			return p;
    1571:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1574:	eb 21                	jmp    1597 <findString+0xaf>
		}
		
		if(p==dot){
    1576:	a1 14 3d 00 00       	mov    0x3d14,%eax
    157b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    157e:	75 84                	jne    1504 <findString+0x1c>
			showStatus("Pattern not found",RED);
    1580:	83 ec 08             	sub    $0x8,%esp
    1583:	6a 04                	push   $0x4
    1585:	68 11 2e 00 00       	push   $0x2e11
    158a:	e8 48 ee ff ff       	call   3d7 <showStatus>
    158f:	83 c4 10             	add    $0x10,%esp
			return dot;
    1592:	a1 14 3d 00 00       	mov    0x3d14,%eax
		}
	}
	return p;
}
    1597:	c9                   	leave  
    1598:	c3                   	ret    

00001599 <reverseFind>:
// 反向查找字符串s
char* reverseFind(char* s){
    1599:	55                   	push   %ebp
    159a:	89 e5                	mov    %esp,%ebp
    159c:	83 ec 18             	sub    $0x18,%esp
	char* p = dot;
    159f:	a1 14 3d 00 00       	mov    0x3d14,%eax
    15a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int count = 0;
    15a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int res = 0;
    15ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while(1){
		if(p==text){
    15b5:	a1 00 3d 00 00       	mov    0x3d00,%eax
    15ba:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    15bd:	75 45                	jne    1604 <reverseFind+0x6b>
			if(count==1)
    15bf:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    15c3:	75 07                	jne    15cc <reverseFind+0x33>
				return dot;
    15c5:	a1 14 3d 00 00       	mov    0x3d14,%eax
    15ca:	eb 7c                	jmp    1648 <reverseFind+0xaf>
			count++;
    15cc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			
			showStatus("search hit TOP, continuing at BOTTOM",WHITE);	
    15d0:	83 ec 08             	sub    $0x8,%esp
    15d3:	6a 0f                	push   $0xf
    15d5:	68 24 2e 00 00       	push   $0x2e24
    15da:	e8 f8 ed ff ff       	call   3d7 <showStatus>
    15df:	83 c4 10             	add    $0x10,%esp
			sleep(30);		
    15e2:	83 ec 0c             	sub    $0xc,%esp
    15e5:	6a 1e                	push   $0x1e
    15e7:	e8 90 07 00 00       	call   1d7c <sleep>
    15ec:	83 c4 10             	add    $0x10,%esp
			p = end - 1;
    15ef:	a1 04 3d 00 00       	mov    0x3d04,%eax
    15f4:	83 e8 01             	sub    $0x1,%eax
    15f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
			synchronizeDandS();
    15fa:	e8 46 f0 ff ff       	call   645 <synchronizeDandS>
			reDraw();					
    15ff:	e8 31 ed ff ff       	call   335 <reDraw>
		}
		p--;
    1604:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
		res = equal(p,s);
    1608:	83 ec 08             	sub    $0x8,%esp
    160b:	ff 75 08             	pushl  0x8(%ebp)
    160e:	ff 75 f4             	pushl  -0xc(%ebp)
    1611:	e8 34 00 00 00       	call   164a <equal>
    1616:	83 c4 10             	add    $0x10,%esp
    1619:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if(res==1){
    161c:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    1620:	75 05                	jne    1627 <reverseFind+0x8e>
			return p;
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	eb 21                	jmp    1648 <reverseFind+0xaf>
		}
		if(p==dot){
    1627:	a1 14 3d 00 00       	mov    0x3d14,%eax
    162c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    162f:	75 84                	jne    15b5 <reverseFind+0x1c>
			showStatus("Pattern not found",RED);
    1631:	83 ec 08             	sub    $0x8,%esp
    1634:	6a 04                	push   $0x4
    1636:	68 11 2e 00 00       	push   $0x2e11
    163b:	e8 97 ed ff ff       	call   3d7 <showStatus>
    1640:	83 c4 10             	add    $0x10,%esp
			return dot;
    1643:	a1 14 3d 00 00       	mov    0x3d14,%eax
		}
	}	
	return p;
}
    1648:	c9                   	leave  
    1649:	c3                   	ret    

0000164a <equal>:
int equal(char* p,char* s){
    164a:	55                   	push   %ebp
    164b:	89 e5                	mov    %esp,%ebp
    164d:	83 ec 18             	sub    $0x18,%esp
	int i;
	int n = strlen(s);
    1650:	83 ec 0c             	sub    $0xc,%esp
    1653:	ff 75 0c             	pushl  0xc(%ebp)
    1656:	e8 cf 04 00 00       	call   1b2a <strlen>
    165b:	83 c4 10             	add    $0x10,%esp
    165e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for(i=0;i<n;i++){
    1661:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1668:	eb 23                	jmp    168d <equal+0x43>
		if(*p!=*s){
    166a:	8b 45 08             	mov    0x8(%ebp),%eax
    166d:	0f b6 10             	movzbl (%eax),%edx
    1670:	8b 45 0c             	mov    0xc(%ebp),%eax
    1673:	0f b6 00             	movzbl (%eax),%eax
    1676:	38 c2                	cmp    %al,%dl
    1678:	74 07                	je     1681 <equal+0x37>
			return 0;
    167a:	b8 00 00 00 00       	mov    $0x0,%eax
    167f:	eb 19                	jmp    169a <equal+0x50>
		}
		p++;s++;
    1681:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1685:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
	return p;
}
int equal(char* p,char* s){
	int i;
	int n = strlen(s);
	for(i=0;i<n;i++){
    1689:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    168d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1690:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1693:	7c d5                	jl     166a <equal+0x20>
		if(*p!=*s){
			return 0;
		}
		p++;s++;
	}
	return 1;
    1695:	b8 01 00 00 00       	mov    $0x1,%eax
}
    169a:	c9                   	leave  
    169b:	c3                   	ret    

0000169c <reDrawC>:

void reDrawC(){
    169c:	55                   	push   %ebp
    169d:	89 e5                	mov    %esp,%ebp
    169f:	53                   	push   %ebx
    16a0:	83 ec 04             	sub    $0x4,%esp
	clearScreen();
    16a3:	e8 f4 06 00 00       	call   1d9c <clearScreen>
	resetScreenBegin();
    16a8:	e8 c1 ec ff ff       	call   36e <resetScreenBegin>
	highlightText();
    16ad:	e8 31 00 00 00       	call   16e3 <highlightText>
	ToScreen(text,0,strlen(text),ColorText);
    16b2:	8b 1d 0c 3d 00 00    	mov    0x3d0c,%ebx
    16b8:	a1 00 3d 00 00       	mov    0x3d00,%eax
    16bd:	83 ec 0c             	sub    $0xc,%esp
    16c0:	50                   	push   %eax
    16c1:	e8 64 04 00 00       	call   1b2a <strlen>
    16c6:	83 c4 10             	add    $0x10,%esp
    16c9:	89 c2                	mov    %eax,%edx
    16cb:	a1 00 3d 00 00       	mov    0x3d00,%eax
    16d0:	53                   	push   %ebx
    16d1:	52                   	push   %edx
    16d2:	6a 00                	push   $0x0
    16d4:	50                   	push   %eax
    16d5:	e8 fa 06 00 00       	call   1dd4 <ToScreen>
    16da:	83 c4 10             	add    $0x10,%esp
}
    16dd:	90                   	nop
    16de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16e1:	c9                   	leave  
    16e2:	c3                   	ret    

000016e3 <highlightText>:

void highlightText(){     // Ｃ文件上色
    16e3:	55                   	push   %ebp
    16e4:	89 e5                	mov    %esp,%ebp
    16e6:	83 ec 28             	sub    $0x28,%esp
	char *p=text;
    16e9:	a1 00 3d 00 00       	mov    0x3d00,%eax
    16ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int i;
	int len = strlen(text);
    16f1:	a1 00 3d 00 00       	mov    0x3d00,%eax
    16f6:	83 ec 0c             	sub    $0xc,%esp
    16f9:	50                   	push   %eax
    16fa:	e8 2b 04 00 00       	call   1b2a <strlen>
    16ff:	83 c4 10             	add    $0x10,%esp
    1702:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ColorText = malloc((len+1)*sizeof(int));
    1705:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1708:	83 c0 01             	add    $0x1,%eax
    170b:	c1 e0 02             	shl    $0x2,%eax
    170e:	83 ec 0c             	sub    $0xc,%esp
    1711:	50                   	push   %eax
    1712:	e8 7f 0a 00 00       	call   2196 <malloc>
    1717:	83 c4 10             	add    $0x10,%esp
    171a:	a3 0c 3d 00 00       	mov    %eax,0x3d0c
	for(i=0;i<len;i++){
    171f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1726:	eb 17                	jmp    173f <highlightText+0x5c>
		ColorText[i] = WHITE;
    1728:	a1 0c 3d 00 00       	mov    0x3d0c,%eax
    172d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1730:	c1 e2 02             	shl    $0x2,%edx
    1733:	01 d0                	add    %edx,%eax
    1735:	c7 00 0f 00 00 00    	movl   $0xf,(%eax)
void highlightText(){     // Ｃ文件上色
	char *p=text;
	int i;
	int len = strlen(text);
	ColorText = malloc((len+1)*sizeof(int));
	for(i=0;i<len;i++){
    173b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    173f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1742:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1745:	7c e1                	jl     1728 <highlightText+0x45>
		ColorText[i] = WHITE;
	}
	i=0;
    1747:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	//int i;
    for(i=0;i<len;){
    174e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1755:	e9 d0 02 00 00       	jmp    1a2a <highlightText+0x347>
		int col = GREEN;
    175a:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
		re_t pattern = re_compile("\\svoid\\s");
    1761:	83 ec 0c             	sub    $0xc,%esp
    1764:	68 49 2e 00 00       	push   $0x2e49
    1769:	e8 cc 0b 00 00       	call   233a <re_compile>
    176e:	83 c4 10             	add    $0x10,%esp
    1771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1774:	ff 75 e8             	pushl  -0x18(%ebp)
    1777:	ff 75 f0             	pushl  -0x10(%ebp)
    177a:	ff 75 f4             	pushl  -0xc(%ebp)
    177d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1780:	e8 b4 02 00 00       	call   1a39 <setColorC>
    1785:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sint\\s");
    1788:	83 ec 0c             	sub    $0xc,%esp
    178b:	68 52 2e 00 00       	push   $0x2e52
    1790:	e8 a5 0b 00 00       	call   233a <re_compile>
    1795:	83 c4 10             	add    $0x10,%esp
    1798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    179b:	ff 75 e8             	pushl  -0x18(%ebp)
    179e:	ff 75 f0             	pushl  -0x10(%ebp)
    17a1:	ff 75 f4             	pushl  -0xc(%ebp)
    17a4:	ff 75 e4             	pushl  -0x1c(%ebp)
    17a7:	e8 8d 02 00 00       	call   1a39 <setColorC>
    17ac:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sdouble\\s");
    17af:	83 ec 0c             	sub    $0xc,%esp
    17b2:	68 5a 2e 00 00       	push   $0x2e5a
    17b7:	e8 7e 0b 00 00       	call   233a <re_compile>
    17bc:	83 c4 10             	add    $0x10,%esp
    17bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    17c2:	ff 75 e8             	pushl  -0x18(%ebp)
    17c5:	ff 75 f0             	pushl  -0x10(%ebp)
    17c8:	ff 75 f4             	pushl  -0xc(%ebp)
    17cb:	ff 75 e4             	pushl  -0x1c(%ebp)
    17ce:	e8 66 02 00 00       	call   1a39 <setColorC>
    17d3:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\schar\\s");
    17d6:	83 ec 0c             	sub    $0xc,%esp
    17d9:	68 65 2e 00 00       	push   $0x2e65
    17de:	e8 57 0b 00 00       	call   233a <re_compile>
    17e3:	83 c4 10             	add    $0x10,%esp
    17e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    17e9:	ff 75 e8             	pushl  -0x18(%ebp)
    17ec:	ff 75 f0             	pushl  -0x10(%ebp)
    17ef:	ff 75 f4             	pushl  -0xc(%ebp)
    17f2:	ff 75 e4             	pushl  -0x1c(%ebp)
    17f5:	e8 3f 02 00 00       	call   1a39 <setColorC>
    17fa:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sfloa\\s");
    17fd:	83 ec 0c             	sub    $0xc,%esp
    1800:	68 6e 2e 00 00       	push   $0x2e6e
    1805:	e8 30 0b 00 00       	call   233a <re_compile>
    180a:	83 c4 10             	add    $0x10,%esp
    180d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1810:	ff 75 e8             	pushl  -0x18(%ebp)
    1813:	ff 75 f0             	pushl  -0x10(%ebp)
    1816:	ff 75 f4             	pushl  -0xc(%ebp)
    1819:	ff 75 e4             	pushl  -0x1c(%ebp)
    181c:	e8 18 02 00 00       	call   1a39 <setColorC>
    1821:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sstatic\\s");
    1824:	83 ec 0c             	sub    $0xc,%esp
    1827:	68 77 2e 00 00       	push   $0x2e77
    182c:	e8 09 0b 00 00       	call   233a <re_compile>
    1831:	83 c4 10             	add    $0x10,%esp
    1834:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1837:	ff 75 e8             	pushl  -0x18(%ebp)
    183a:	ff 75 f0             	pushl  -0x10(%ebp)
    183d:	ff 75 f4             	pushl  -0xc(%ebp)
    1840:	ff 75 e4             	pushl  -0x1c(%ebp)
    1843:	e8 f1 01 00 00       	call   1a39 <setColorC>
    1848:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sunsigned\\s");
    184b:	83 ec 0c             	sub    $0xc,%esp
    184e:	68 82 2e 00 00       	push   $0x2e82
    1853:	e8 e2 0a 00 00       	call   233a <re_compile>
    1858:	83 c4 10             	add    $0x10,%esp
    185b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    185e:	ff 75 e8             	pushl  -0x18(%ebp)
    1861:	ff 75 f0             	pushl  -0x10(%ebp)
    1864:	ff 75 f4             	pushl  -0xc(%ebp)
    1867:	ff 75 e4             	pushl  -0x1c(%ebp)
    186a:	e8 ca 01 00 00       	call   1a39 <setColorC>
    186f:	83 c4 10             	add    $0x10,%esp

		col = YELLOW;
    1872:	c7 45 e8 0e 00 00 00 	movl   $0xe,-0x18(%ebp)
		pattern = re_compile("\\sif\\s");
    1879:	83 ec 0c             	sub    $0xc,%esp
    187c:	68 8f 2e 00 00       	push   $0x2e8f
    1881:	e8 b4 0a 00 00       	call   233a <re_compile>
    1886:	83 c4 10             	add    $0x10,%esp
    1889:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    188c:	ff 75 e8             	pushl  -0x18(%ebp)
    188f:	ff 75 f0             	pushl  -0x10(%ebp)
    1892:	ff 75 f4             	pushl  -0xc(%ebp)
    1895:	ff 75 e4             	pushl  -0x1c(%ebp)
    1898:	e8 9c 01 00 00       	call   1a39 <setColorC>
    189d:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\selse\\s");
    18a0:	83 ec 0c             	sub    $0xc,%esp
    18a3:	68 96 2e 00 00       	push   $0x2e96
    18a8:	e8 8d 0a 00 00       	call   233a <re_compile>
    18ad:	83 c4 10             	add    $0x10,%esp
    18b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    18b3:	ff 75 e8             	pushl  -0x18(%ebp)
    18b6:	ff 75 f0             	pushl  -0x10(%ebp)
    18b9:	ff 75 f4             	pushl  -0xc(%ebp)
    18bc:	ff 75 e4             	pushl  -0x1c(%ebp)
    18bf:	e8 75 01 00 00       	call   1a39 <setColorC>
    18c4:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sswitch\\s");
    18c7:	83 ec 0c             	sub    $0xc,%esp
    18ca:	68 9f 2e 00 00       	push   $0x2e9f
    18cf:	e8 66 0a 00 00       	call   233a <re_compile>
    18d4:	83 c4 10             	add    $0x10,%esp
    18d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    18da:	ff 75 e8             	pushl  -0x18(%ebp)
    18dd:	ff 75 f0             	pushl  -0x10(%ebp)
    18e0:	ff 75 f4             	pushl  -0xc(%ebp)
    18e3:	ff 75 e4             	pushl  -0x1c(%ebp)
    18e6:	e8 4e 01 00 00       	call   1a39 <setColorC>
    18eb:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\scase\\s");
    18ee:	83 ec 0c             	sub    $0xc,%esp
    18f1:	68 aa 2e 00 00       	push   $0x2eaa
    18f6:	e8 3f 0a 00 00       	call   233a <re_compile>
    18fb:	83 c4 10             	add    $0x10,%esp
    18fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1901:	ff 75 e8             	pushl  -0x18(%ebp)
    1904:	ff 75 f0             	pushl  -0x10(%ebp)
    1907:	ff 75 f4             	pushl  -0xc(%ebp)
    190a:	ff 75 e4             	pushl  -0x1c(%ebp)
    190d:	e8 27 01 00 00       	call   1a39 <setColorC>
    1912:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sreturn\\s");
    1915:	83 ec 0c             	sub    $0xc,%esp
    1918:	68 b3 2e 00 00       	push   $0x2eb3
    191d:	e8 18 0a 00 00       	call   233a <re_compile>
    1922:	83 c4 10             	add    $0x10,%esp
    1925:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1928:	ff 75 e8             	pushl  -0x18(%ebp)
    192b:	ff 75 f0             	pushl  -0x10(%ebp)
    192e:	ff 75 f4             	pushl  -0xc(%ebp)
    1931:	ff 75 e4             	pushl  -0x1c(%ebp)
    1934:	e8 00 01 00 00       	call   1a39 <setColorC>
    1939:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\swhile\\s");
    193c:	83 ec 0c             	sub    $0xc,%esp
    193f:	68 be 2e 00 00       	push   $0x2ebe
    1944:	e8 f1 09 00 00       	call   233a <re_compile>
    1949:	83 c4 10             	add    $0x10,%esp
    194c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    194f:	ff 75 e8             	pushl  -0x18(%ebp)
    1952:	ff 75 f0             	pushl  -0x10(%ebp)
    1955:	ff 75 f4             	pushl  -0xc(%ebp)
    1958:	ff 75 e4             	pushl  -0x1c(%ebp)
    195b:	e8 d9 00 00 00       	call   1a39 <setColorC>
    1960:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\sbreak\\s");
    1963:	83 ec 0c             	sub    $0xc,%esp
    1966:	68 c8 2e 00 00       	push   $0x2ec8
    196b:	e8 ca 09 00 00       	call   233a <re_compile>
    1970:	83 c4 10             	add    $0x10,%esp
    1973:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    1976:	ff 75 e8             	pushl  -0x18(%ebp)
    1979:	ff 75 f0             	pushl  -0x10(%ebp)
    197c:	ff 75 f4             	pushl  -0xc(%ebp)
    197f:	ff 75 e4             	pushl  -0x1c(%ebp)
    1982:	e8 b2 00 00 00       	call   1a39 <setColorC>
    1987:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\scontinue\\s");
    198a:	83 ec 0c             	sub    $0xc,%esp
    198d:	68 d2 2e 00 00       	push   $0x2ed2
    1992:	e8 a3 09 00 00       	call   233a <re_compile>
    1997:	83 c4 10             	add    $0x10,%esp
    199a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    199d:	ff 75 e8             	pushl  -0x18(%ebp)
    19a0:	ff 75 f0             	pushl  -0x10(%ebp)
    19a3:	ff 75 f4             	pushl  -0xc(%ebp)
    19a6:	ff 75 e4             	pushl  -0x1c(%ebp)
    19a9:	e8 8b 00 00 00       	call   1a39 <setColorC>
    19ae:	83 c4 10             	add    $0x10,%esp

		col = LIGHT_BLUE;
    19b1:	c7 45 e8 09 00 00 00 	movl   $0x9,-0x18(%ebp)
		pattern = re_compile("\\s#define\\s");
    19b8:	83 ec 0c             	sub    $0xc,%esp
    19bb:	68 df 2e 00 00       	push   $0x2edf
    19c0:	e8 75 09 00 00       	call   233a <re_compile>
    19c5:	83 c4 10             	add    $0x10,%esp
    19c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    19cb:	ff 75 e8             	pushl  -0x18(%ebp)
    19ce:	ff 75 f0             	pushl  -0x10(%ebp)
    19d1:	ff 75 f4             	pushl  -0xc(%ebp)
    19d4:	ff 75 e4             	pushl  -0x1c(%ebp)
    19d7:	e8 5d 00 00 00       	call   1a39 <setColorC>
    19dc:	83 c4 10             	add    $0x10,%esp
		pattern = re_compile("\\s#include\\s");
    19df:	83 ec 0c             	sub    $0xc,%esp
    19e2:	68 eb 2e 00 00       	push   $0x2eeb
    19e7:	e8 4e 09 00 00       	call   233a <re_compile>
    19ec:	83 c4 10             	add    $0x10,%esp
    19ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		setColorC(pattern,p,i,col);
    19f2:	ff 75 e8             	pushl  -0x18(%ebp)
    19f5:	ff 75 f0             	pushl  -0x10(%ebp)
    19f8:	ff 75 f4             	pushl  -0xc(%ebp)
    19fb:	ff 75 e4             	pushl  -0x1c(%ebp)
    19fe:	e8 36 00 00 00       	call   1a39 <setColorC>
    1a03:	83 c4 10             	add    $0x10,%esp

		while(*p!='\n' && i<len){
    1a06:	eb 08                	jmp    1a10 <highlightText+0x32d>
			p++;
    1a08:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
			i++;
    1a0c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
		pattern = re_compile("\\s#define\\s");
		setColorC(pattern,p,i,col);
		pattern = re_compile("\\s#include\\s");
		setColorC(pattern,p,i,col);

		while(*p!='\n' && i<len){
    1a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a13:	0f b6 00             	movzbl (%eax),%eax
    1a16:	3c 0a                	cmp    $0xa,%al
    1a18:	74 08                	je     1a22 <highlightText+0x33f>
    1a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a1d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a20:	7c e6                	jl     1a08 <highlightText+0x325>
			p++;
			i++;
		}
		p++;
    1a22:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
		i++;
    1a26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	for(i=0;i<len;i++){
		ColorText[i] = WHITE;
	}
	i=0;
	//int i;
    for(i=0;i<len;){
    1a2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a2d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1a30:	0f 8c 24 fd ff ff    	jl     175a <highlightText+0x77>
			i++;
		}
		p++;
		i++;
   }
}
    1a36:	90                   	nop
    1a37:	c9                   	leave  
    1a38:	c3                   	ret    

00001a39 <setColorC>:

void setColorC(re_t pattern,char *p,int i_pos,int col){   // 给匹配的字符设置颜色
    1a39:	55                   	push   %ebp
    1a3a:	89 e5                	mov    %esp,%ebp
    1a3c:	83 ec 18             	sub    $0x18,%esp
	int i;
	int match_length;
	int match_idx = re_matchp(pattern, p, &match_length);
    1a3f:	83 ec 04             	sub    $0x4,%esp
    1a42:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1a45:	50                   	push   %eax
    1a46:	ff 75 0c             	pushl  0xc(%ebp)
    1a49:	ff 75 08             	pushl  0x8(%ebp)
    1a4c:	e8 50 08 00 00       	call   22a1 <re_matchp>
    1a51:	83 c4 10             	add    $0x10,%esp
    1a54:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if(match_idx!=-1){
    1a57:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a5b:	74 35                	je     1a92 <setColorC+0x59>
		for(i = match_idx+i_pos;i<match_idx+i_pos+match_length;i++){
    1a5d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1a60:	8b 45 10             	mov    0x10(%ebp),%eax
    1a63:	01 d0                	add    %edx,%eax
    1a65:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a68:	eb 16                	jmp    1a80 <setColorC+0x47>
			ColorText[i] = col;	
    1a6a:	a1 0c 3d 00 00       	mov    0x3d0c,%eax
    1a6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a72:	c1 e2 02             	shl    $0x2,%edx
    1a75:	01 c2                	add    %eax,%edx
    1a77:	8b 45 14             	mov    0x14(%ebp),%eax
    1a7a:	89 02                	mov    %eax,(%edx)
void setColorC(re_t pattern,char *p,int i_pos,int col){   // 给匹配的字符设置颜色
	int i;
	int match_length;
	int match_idx = re_matchp(pattern, p, &match_length);
	if(match_idx!=-1){
		for(i = match_idx+i_pos;i<match_idx+i_pos+match_length;i++){
    1a7c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a80:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1a83:	8b 45 10             	mov    0x10(%ebp),%eax
    1a86:	01 c2                	add    %eax,%edx
    1a88:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a8b:	01 d0                	add    %edx,%eax
    1a8d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a90:	7f d8                	jg     1a6a <setColorC+0x31>
			ColorText[i] = col;	
		}		
	}
    1a92:	90                   	nop
    1a93:	c9                   	leave  
    1a94:	c3                   	ret    

00001a95 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1a95:	55                   	push   %ebp
    1a96:	89 e5                	mov    %esp,%ebp
    1a98:	57                   	push   %edi
    1a99:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1a9a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a9d:	8b 55 10             	mov    0x10(%ebp),%edx
    1aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa3:	89 cb                	mov    %ecx,%ebx
    1aa5:	89 df                	mov    %ebx,%edi
    1aa7:	89 d1                	mov    %edx,%ecx
    1aa9:	fc                   	cld    
    1aaa:	f3 aa                	rep stos %al,%es:(%edi)
    1aac:	89 ca                	mov    %ecx,%edx
    1aae:	89 fb                	mov    %edi,%ebx
    1ab0:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1ab3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1ab6:	90                   	nop
    1ab7:	5b                   	pop    %ebx
    1ab8:	5f                   	pop    %edi
    1ab9:	5d                   	pop    %ebp
    1aba:	c3                   	ret    

00001abb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1abb:	55                   	push   %ebp
    1abc:	89 e5                	mov    %esp,%ebp
    1abe:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1ac1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1ac7:	90                   	nop
    1ac8:	8b 45 08             	mov    0x8(%ebp),%eax
    1acb:	8d 50 01             	lea    0x1(%eax),%edx
    1ace:	89 55 08             	mov    %edx,0x8(%ebp)
    1ad1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ad4:	8d 4a 01             	lea    0x1(%edx),%ecx
    1ad7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    1ada:	0f b6 12             	movzbl (%edx),%edx
    1add:	88 10                	mov    %dl,(%eax)
    1adf:	0f b6 00             	movzbl (%eax),%eax
    1ae2:	84 c0                	test   %al,%al
    1ae4:	75 e2                	jne    1ac8 <strcpy+0xd>
    ;
  return os;
    1ae6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1ae9:	c9                   	leave  
    1aea:	c3                   	ret    

00001aeb <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1aeb:	55                   	push   %ebp
    1aec:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1aee:	eb 08                	jmp    1af8 <strcmp+0xd>
    p++, q++;
    1af0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1af4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1af8:	8b 45 08             	mov    0x8(%ebp),%eax
    1afb:	0f b6 00             	movzbl (%eax),%eax
    1afe:	84 c0                	test   %al,%al
    1b00:	74 10                	je     1b12 <strcmp+0x27>
    1b02:	8b 45 08             	mov    0x8(%ebp),%eax
    1b05:	0f b6 10             	movzbl (%eax),%edx
    1b08:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b0b:	0f b6 00             	movzbl (%eax),%eax
    1b0e:	38 c2                	cmp    %al,%dl
    1b10:	74 de                	je     1af0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1b12:	8b 45 08             	mov    0x8(%ebp),%eax
    1b15:	0f b6 00             	movzbl (%eax),%eax
    1b18:	0f b6 d0             	movzbl %al,%edx
    1b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b1e:	0f b6 00             	movzbl (%eax),%eax
    1b21:	0f b6 c0             	movzbl %al,%eax
    1b24:	29 c2                	sub    %eax,%edx
    1b26:	89 d0                	mov    %edx,%eax
}
    1b28:	5d                   	pop    %ebp
    1b29:	c3                   	ret    

00001b2a <strlen>:

uint
strlen(char *s)
{
    1b2a:	55                   	push   %ebp
    1b2b:	89 e5                	mov    %esp,%ebp
    1b2d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1b30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1b37:	eb 04                	jmp    1b3d <strlen+0x13>
    1b39:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1b3d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1b40:	8b 45 08             	mov    0x8(%ebp),%eax
    1b43:	01 d0                	add    %edx,%eax
    1b45:	0f b6 00             	movzbl (%eax),%eax
    1b48:	84 c0                	test   %al,%al
    1b4a:	75 ed                	jne    1b39 <strlen+0xf>
    ;
  return n;
    1b4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b4f:	c9                   	leave  
    1b50:	c3                   	ret    

00001b51 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1b51:	55                   	push   %ebp
    1b52:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1b54:	8b 45 10             	mov    0x10(%ebp),%eax
    1b57:	50                   	push   %eax
    1b58:	ff 75 0c             	pushl  0xc(%ebp)
    1b5b:	ff 75 08             	pushl  0x8(%ebp)
    1b5e:	e8 32 ff ff ff       	call   1a95 <stosb>
    1b63:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1b66:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1b69:	c9                   	leave  
    1b6a:	c3                   	ret    

00001b6b <strchr>:

char*
strchr(const char *s, char c)
{
    1b6b:	55                   	push   %ebp
    1b6c:	89 e5                	mov    %esp,%ebp
    1b6e:	83 ec 04             	sub    $0x4,%esp
    1b71:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b74:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1b77:	eb 14                	jmp    1b8d <strchr+0x22>
    if(*s == c)
    1b79:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7c:	0f b6 00             	movzbl (%eax),%eax
    1b7f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1b82:	75 05                	jne    1b89 <strchr+0x1e>
      return (char*)s;
    1b84:	8b 45 08             	mov    0x8(%ebp),%eax
    1b87:	eb 13                	jmp    1b9c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1b89:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1b8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b90:	0f b6 00             	movzbl (%eax),%eax
    1b93:	84 c0                	test   %al,%al
    1b95:	75 e2                	jne    1b79 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1b97:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b9c:	c9                   	leave  
    1b9d:	c3                   	ret    

00001b9e <gets>:

char*
gets(char *buf, int max)
{
    1b9e:	55                   	push   %ebp
    1b9f:	89 e5                	mov    %esp,%ebp
    1ba1:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1ba4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bab:	eb 42                	jmp    1bef <gets+0x51>
    cc = read(0, &c, 1);
    1bad:	83 ec 04             	sub    $0x4,%esp
    1bb0:	6a 01                	push   $0x1
    1bb2:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1bb5:	50                   	push   %eax
    1bb6:	6a 00                	push   $0x0
    1bb8:	e8 47 01 00 00       	call   1d04 <read>
    1bbd:	83 c4 10             	add    $0x10,%esp
    1bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1bc3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bc7:	7e 33                	jle    1bfc <gets+0x5e>
      break;
    buf[i++] = c;
    1bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bcc:	8d 50 01             	lea    0x1(%eax),%edx
    1bcf:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1bd2:	89 c2                	mov    %eax,%edx
    1bd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd7:	01 c2                	add    %eax,%edx
    1bd9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1bdd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1bdf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1be3:	3c 0a                	cmp    $0xa,%al
    1be5:	74 16                	je     1bfd <gets+0x5f>
    1be7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1beb:	3c 0d                	cmp    $0xd,%al
    1bed:	74 0e                	je     1bfd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1bef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf2:	83 c0 01             	add    $0x1,%eax
    1bf5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1bf8:	7c b3                	jl     1bad <gets+0xf>
    1bfa:	eb 01                	jmp    1bfd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1bfc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1bfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c00:	8b 45 08             	mov    0x8(%ebp),%eax
    1c03:	01 d0                	add    %edx,%eax
    1c05:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1c08:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1c0b:	c9                   	leave  
    1c0c:	c3                   	ret    

00001c0d <stat>:

int
stat(char *n, struct stat *st)
{
    1c0d:	55                   	push   %ebp
    1c0e:	89 e5                	mov    %esp,%ebp
    1c10:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1c13:	83 ec 08             	sub    $0x8,%esp
    1c16:	6a 00                	push   $0x0
    1c18:	ff 75 08             	pushl  0x8(%ebp)
    1c1b:	e8 0c 01 00 00       	call   1d2c <open>
    1c20:	83 c4 10             	add    $0x10,%esp
    1c23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1c26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c2a:	79 07                	jns    1c33 <stat+0x26>
    return -1;
    1c2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1c31:	eb 25                	jmp    1c58 <stat+0x4b>
  r = fstat(fd, st);
    1c33:	83 ec 08             	sub    $0x8,%esp
    1c36:	ff 75 0c             	pushl  0xc(%ebp)
    1c39:	ff 75 f4             	pushl  -0xc(%ebp)
    1c3c:	e8 03 01 00 00       	call   1d44 <fstat>
    1c41:	83 c4 10             	add    $0x10,%esp
    1c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1c47:	83 ec 0c             	sub    $0xc,%esp
    1c4a:	ff 75 f4             	pushl  -0xc(%ebp)
    1c4d:	e8 c2 00 00 00       	call   1d14 <close>
    1c52:	83 c4 10             	add    $0x10,%esp
  return r;
    1c55:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1c58:	c9                   	leave  
    1c59:	c3                   	ret    

00001c5a <atoi>:

int
atoi(const char *s)
{
    1c5a:	55                   	push   %ebp
    1c5b:	89 e5                	mov    %esp,%ebp
    1c5d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1c60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1c67:	eb 25                	jmp    1c8e <atoi+0x34>
    n = n*10 + *s++ - '0';
    1c69:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1c6c:	89 d0                	mov    %edx,%eax
    1c6e:	c1 e0 02             	shl    $0x2,%eax
    1c71:	01 d0                	add    %edx,%eax
    1c73:	01 c0                	add    %eax,%eax
    1c75:	89 c1                	mov    %eax,%ecx
    1c77:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7a:	8d 50 01             	lea    0x1(%eax),%edx
    1c7d:	89 55 08             	mov    %edx,0x8(%ebp)
    1c80:	0f b6 00             	movzbl (%eax),%eax
    1c83:	0f be c0             	movsbl %al,%eax
    1c86:	01 c8                	add    %ecx,%eax
    1c88:	83 e8 30             	sub    $0x30,%eax
    1c8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1c8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c91:	0f b6 00             	movzbl (%eax),%eax
    1c94:	3c 2f                	cmp    $0x2f,%al
    1c96:	7e 0a                	jle    1ca2 <atoi+0x48>
    1c98:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9b:	0f b6 00             	movzbl (%eax),%eax
    1c9e:	3c 39                	cmp    $0x39,%al
    1ca0:	7e c7                	jle    1c69 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1ca5:	c9                   	leave  
    1ca6:	c3                   	ret    

00001ca7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1ca7:	55                   	push   %ebp
    1ca8:	89 e5                	mov    %esp,%ebp
    1caa:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1cad:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cb6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1cb9:	eb 17                	jmp    1cd2 <memmove+0x2b>
    *dst++ = *src++;
    1cbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cbe:	8d 50 01             	lea    0x1(%eax),%edx
    1cc1:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1cc4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1cc7:	8d 4a 01             	lea    0x1(%edx),%ecx
    1cca:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1ccd:	0f b6 12             	movzbl (%edx),%edx
    1cd0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1cd2:	8b 45 10             	mov    0x10(%ebp),%eax
    1cd5:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cd8:	89 55 10             	mov    %edx,0x10(%ebp)
    1cdb:	85 c0                	test   %eax,%eax
    1cdd:	7f dc                	jg     1cbb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1cdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1ce2:	c9                   	leave  
    1ce3:	c3                   	ret    

00001ce4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1ce4:	b8 01 00 00 00       	mov    $0x1,%eax
    1ce9:	cd 40                	int    $0x40
    1ceb:	c3                   	ret    

00001cec <exit>:
SYSCALL(exit)
    1cec:	b8 02 00 00 00       	mov    $0x2,%eax
    1cf1:	cd 40                	int    $0x40
    1cf3:	c3                   	ret    

00001cf4 <wait>:
SYSCALL(wait)
    1cf4:	b8 03 00 00 00       	mov    $0x3,%eax
    1cf9:	cd 40                	int    $0x40
    1cfb:	c3                   	ret    

00001cfc <pipe>:
SYSCALL(pipe)
    1cfc:	b8 04 00 00 00       	mov    $0x4,%eax
    1d01:	cd 40                	int    $0x40
    1d03:	c3                   	ret    

00001d04 <read>:
SYSCALL(read)
    1d04:	b8 05 00 00 00       	mov    $0x5,%eax
    1d09:	cd 40                	int    $0x40
    1d0b:	c3                   	ret    

00001d0c <write>:
SYSCALL(write)
    1d0c:	b8 10 00 00 00       	mov    $0x10,%eax
    1d11:	cd 40                	int    $0x40
    1d13:	c3                   	ret    

00001d14 <close>:
SYSCALL(close)
    1d14:	b8 15 00 00 00       	mov    $0x15,%eax
    1d19:	cd 40                	int    $0x40
    1d1b:	c3                   	ret    

00001d1c <kill>:
SYSCALL(kill)
    1d1c:	b8 06 00 00 00       	mov    $0x6,%eax
    1d21:	cd 40                	int    $0x40
    1d23:	c3                   	ret    

00001d24 <exec>:
SYSCALL(exec)
    1d24:	b8 07 00 00 00       	mov    $0x7,%eax
    1d29:	cd 40                	int    $0x40
    1d2b:	c3                   	ret    

00001d2c <open>:
SYSCALL(open)
    1d2c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1d31:	cd 40                	int    $0x40
    1d33:	c3                   	ret    

00001d34 <mknod>:
SYSCALL(mknod)
    1d34:	b8 11 00 00 00       	mov    $0x11,%eax
    1d39:	cd 40                	int    $0x40
    1d3b:	c3                   	ret    

00001d3c <unlink>:
SYSCALL(unlink)
    1d3c:	b8 12 00 00 00       	mov    $0x12,%eax
    1d41:	cd 40                	int    $0x40
    1d43:	c3                   	ret    

00001d44 <fstat>:
SYSCALL(fstat)
    1d44:	b8 08 00 00 00       	mov    $0x8,%eax
    1d49:	cd 40                	int    $0x40
    1d4b:	c3                   	ret    

00001d4c <link>:
SYSCALL(link)
    1d4c:	b8 13 00 00 00       	mov    $0x13,%eax
    1d51:	cd 40                	int    $0x40
    1d53:	c3                   	ret    

00001d54 <mkdir>:
SYSCALL(mkdir)
    1d54:	b8 14 00 00 00       	mov    $0x14,%eax
    1d59:	cd 40                	int    $0x40
    1d5b:	c3                   	ret    

00001d5c <chdir>:
SYSCALL(chdir)
    1d5c:	b8 09 00 00 00       	mov    $0x9,%eax
    1d61:	cd 40                	int    $0x40
    1d63:	c3                   	ret    

00001d64 <dup>:
SYSCALL(dup)
    1d64:	b8 0a 00 00 00       	mov    $0xa,%eax
    1d69:	cd 40                	int    $0x40
    1d6b:	c3                   	ret    

00001d6c <getpid>:
SYSCALL(getpid)
    1d6c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1d71:	cd 40                	int    $0x40
    1d73:	c3                   	ret    

00001d74 <sbrk>:
SYSCALL(sbrk)
    1d74:	b8 0c 00 00 00       	mov    $0xc,%eax
    1d79:	cd 40                	int    $0x40
    1d7b:	c3                   	ret    

00001d7c <sleep>:
SYSCALL(sleep)
    1d7c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1d81:	cd 40                	int    $0x40
    1d83:	c3                   	ret    

00001d84 <uptime>:
SYSCALL(uptime)
    1d84:	b8 0e 00 00 00       	mov    $0xe,%eax
    1d89:	cd 40                	int    $0x40
    1d8b:	c3                   	ret    

00001d8c <setCursorPos>:


//add
SYSCALL(setCursorPos)
    1d8c:	b8 16 00 00 00       	mov    $0x16,%eax
    1d91:	cd 40                	int    $0x40
    1d93:	c3                   	ret    

00001d94 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
    1d94:	b8 17 00 00 00       	mov    $0x17,%eax
    1d99:	cd 40                	int    $0x40
    1d9b:	c3                   	ret    

00001d9c <clearScreen>:
SYSCALL(clearScreen)
    1d9c:	b8 18 00 00 00       	mov    $0x18,%eax
    1da1:	cd 40                	int    $0x40
    1da3:	c3                   	ret    

00001da4 <writeAt>:
SYSCALL(writeAt)
    1da4:	b8 19 00 00 00       	mov    $0x19,%eax
    1da9:	cd 40                	int    $0x40
    1dab:	c3                   	ret    

00001dac <setBufferFlag>:
SYSCALL(setBufferFlag)
    1dac:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1db1:	cd 40                	int    $0x40
    1db3:	c3                   	ret    

00001db4 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
    1db4:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1db9:	cd 40                	int    $0x40
    1dbb:	c3                   	ret    

00001dbc <getCursorPos>:
SYSCALL(getCursorPos)
    1dbc:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1dc1:	cd 40                	int    $0x40
    1dc3:	c3                   	ret    

00001dc4 <saveScreen>:
SYSCALL(saveScreen)
    1dc4:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1dc9:	cd 40                	int    $0x40
    1dcb:	c3                   	ret    

00001dcc <recorverScreen>:
SYSCALL(recorverScreen)
    1dcc:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1dd1:	cd 40                	int    $0x40
    1dd3:	c3                   	ret    

00001dd4 <ToScreen>:
SYSCALL(ToScreen)
    1dd4:	b8 1f 00 00 00       	mov    $0x1f,%eax
    1dd9:	cd 40                	int    $0x40
    1ddb:	c3                   	ret    

00001ddc <getColor>:
SYSCALL(getColor)
    1ddc:	b8 20 00 00 00       	mov    $0x20,%eax
    1de1:	cd 40                	int    $0x40
    1de3:	c3                   	ret    

00001de4 <showC>:
SYSCALL(showC)
    1de4:	b8 21 00 00 00       	mov    $0x21,%eax
    1de9:	cd 40                	int    $0x40
    1deb:	c3                   	ret    

00001dec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1dec:	55                   	push   %ebp
    1ded:	89 e5                	mov    %esp,%ebp
    1def:	83 ec 18             	sub    $0x18,%esp
    1df2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1df5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1df8:	83 ec 04             	sub    $0x4,%esp
    1dfb:	6a 01                	push   $0x1
    1dfd:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1e00:	50                   	push   %eax
    1e01:	ff 75 08             	pushl  0x8(%ebp)
    1e04:	e8 03 ff ff ff       	call   1d0c <write>
    1e09:	83 c4 10             	add    $0x10,%esp
}
    1e0c:	90                   	nop
    1e0d:	c9                   	leave  
    1e0e:	c3                   	ret    

00001e0f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1e0f:	55                   	push   %ebp
    1e10:	89 e5                	mov    %esp,%ebp
    1e12:	53                   	push   %ebx
    1e13:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1e16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1e1d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1e21:	74 17                	je     1e3a <printint+0x2b>
    1e23:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e27:	79 11                	jns    1e3a <printint+0x2b>
    neg = 1;
    1e29:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1e30:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e33:	f7 d8                	neg    %eax
    1e35:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e38:	eb 06                	jmp    1e40 <printint+0x31>
  } else {
    x = xx;
    1e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1e40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1e47:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1e4a:	8d 41 01             	lea    0x1(%ecx),%eax
    1e4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1e50:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1e53:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e56:	ba 00 00 00 00       	mov    $0x0,%edx
    1e5b:	f7 f3                	div    %ebx
    1e5d:	89 d0                	mov    %edx,%eax
    1e5f:	0f b6 80 38 3b 00 00 	movzbl 0x3b38(%eax),%eax
    1e66:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1e6a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1e6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e70:	ba 00 00 00 00       	mov    $0x0,%edx
    1e75:	f7 f3                	div    %ebx
    1e77:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e7a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e7e:	75 c7                	jne    1e47 <printint+0x38>
  if(neg)
    1e80:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e84:	74 2d                	je     1eb3 <printint+0xa4>
    buf[i++] = '-';
    1e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e89:	8d 50 01             	lea    0x1(%eax),%edx
    1e8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1e8f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1e94:	eb 1d                	jmp    1eb3 <printint+0xa4>
    putc(fd, buf[i]);
    1e96:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e9c:	01 d0                	add    %edx,%eax
    1e9e:	0f b6 00             	movzbl (%eax),%eax
    1ea1:	0f be c0             	movsbl %al,%eax
    1ea4:	83 ec 08             	sub    $0x8,%esp
    1ea7:	50                   	push   %eax
    1ea8:	ff 75 08             	pushl  0x8(%ebp)
    1eab:	e8 3c ff ff ff       	call   1dec <putc>
    1eb0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1eb3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1eb7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ebb:	79 d9                	jns    1e96 <printint+0x87>
    putc(fd, buf[i]);
}
    1ebd:	90                   	nop
    1ebe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ec1:	c9                   	leave  
    1ec2:	c3                   	ret    

00001ec3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1ec3:	55                   	push   %ebp
    1ec4:	89 e5                	mov    %esp,%ebp
    1ec6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1ec9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1ed0:	8d 45 0c             	lea    0xc(%ebp),%eax
    1ed3:	83 c0 04             	add    $0x4,%eax
    1ed6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1ed9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ee0:	e9 59 01 00 00       	jmp    203e <printf+0x17b>
    c = fmt[i] & 0xff;
    1ee5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ee8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eeb:	01 d0                	add    %edx,%eax
    1eed:	0f b6 00             	movzbl (%eax),%eax
    1ef0:	0f be c0             	movsbl %al,%eax
    1ef3:	25 ff 00 00 00       	and    $0xff,%eax
    1ef8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1efb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1eff:	75 2c                	jne    1f2d <printf+0x6a>
      if(c == '%'){
    1f01:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1f05:	75 0c                	jne    1f13 <printf+0x50>
        state = '%';
    1f07:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1f0e:	e9 27 01 00 00       	jmp    203a <printf+0x177>
      } else {
        putc(fd, c);
    1f13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f16:	0f be c0             	movsbl %al,%eax
    1f19:	83 ec 08             	sub    $0x8,%esp
    1f1c:	50                   	push   %eax
    1f1d:	ff 75 08             	pushl  0x8(%ebp)
    1f20:	e8 c7 fe ff ff       	call   1dec <putc>
    1f25:	83 c4 10             	add    $0x10,%esp
    1f28:	e9 0d 01 00 00       	jmp    203a <printf+0x177>
      }
    } else if(state == '%'){
    1f2d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1f31:	0f 85 03 01 00 00    	jne    203a <printf+0x177>
      if(c == 'd'){
    1f37:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1f3b:	75 1e                	jne    1f5b <printf+0x98>
        printint(fd, *ap, 10, 1);
    1f3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f40:	8b 00                	mov    (%eax),%eax
    1f42:	6a 01                	push   $0x1
    1f44:	6a 0a                	push   $0xa
    1f46:	50                   	push   %eax
    1f47:	ff 75 08             	pushl  0x8(%ebp)
    1f4a:	e8 c0 fe ff ff       	call   1e0f <printint>
    1f4f:	83 c4 10             	add    $0x10,%esp
        ap++;
    1f52:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1f56:	e9 d8 00 00 00       	jmp    2033 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1f5b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1f5f:	74 06                	je     1f67 <printf+0xa4>
    1f61:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1f65:	75 1e                	jne    1f85 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1f67:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f6a:	8b 00                	mov    (%eax),%eax
    1f6c:	6a 00                	push   $0x0
    1f6e:	6a 10                	push   $0x10
    1f70:	50                   	push   %eax
    1f71:	ff 75 08             	pushl  0x8(%ebp)
    1f74:	e8 96 fe ff ff       	call   1e0f <printint>
    1f79:	83 c4 10             	add    $0x10,%esp
        ap++;
    1f7c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1f80:	e9 ae 00 00 00       	jmp    2033 <printf+0x170>
      } else if(c == 's'){
    1f85:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1f89:	75 43                	jne    1fce <printf+0x10b>
        s = (char*)*ap;
    1f8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f8e:	8b 00                	mov    (%eax),%eax
    1f90:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1f93:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1f97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f9b:	75 25                	jne    1fc2 <printf+0xff>
          s = "(null)";
    1f9d:	c7 45 f4 f8 2e 00 00 	movl   $0x2ef8,-0xc(%ebp)
        while(*s != 0){
    1fa4:	eb 1c                	jmp    1fc2 <printf+0xff>
          putc(fd, *s);
    1fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fa9:	0f b6 00             	movzbl (%eax),%eax
    1fac:	0f be c0             	movsbl %al,%eax
    1faf:	83 ec 08             	sub    $0x8,%esp
    1fb2:	50                   	push   %eax
    1fb3:	ff 75 08             	pushl  0x8(%ebp)
    1fb6:	e8 31 fe ff ff       	call   1dec <putc>
    1fbb:	83 c4 10             	add    $0x10,%esp
          s++;
    1fbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1fc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fc5:	0f b6 00             	movzbl (%eax),%eax
    1fc8:	84 c0                	test   %al,%al
    1fca:	75 da                	jne    1fa6 <printf+0xe3>
    1fcc:	eb 65                	jmp    2033 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1fce:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1fd2:	75 1d                	jne    1ff1 <printf+0x12e>
        putc(fd, *ap);
    1fd4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1fd7:	8b 00                	mov    (%eax),%eax
    1fd9:	0f be c0             	movsbl %al,%eax
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	50                   	push   %eax
    1fe0:	ff 75 08             	pushl  0x8(%ebp)
    1fe3:	e8 04 fe ff ff       	call   1dec <putc>
    1fe8:	83 c4 10             	add    $0x10,%esp
        ap++;
    1feb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1fef:	eb 42                	jmp    2033 <printf+0x170>
      } else if(c == '%'){
    1ff1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1ff5:	75 17                	jne    200e <printf+0x14b>
        putc(fd, c);
    1ff7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ffa:	0f be c0             	movsbl %al,%eax
    1ffd:	83 ec 08             	sub    $0x8,%esp
    2000:	50                   	push   %eax
    2001:	ff 75 08             	pushl  0x8(%ebp)
    2004:	e8 e3 fd ff ff       	call   1dec <putc>
    2009:	83 c4 10             	add    $0x10,%esp
    200c:	eb 25                	jmp    2033 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    200e:	83 ec 08             	sub    $0x8,%esp
    2011:	6a 25                	push   $0x25
    2013:	ff 75 08             	pushl  0x8(%ebp)
    2016:	e8 d1 fd ff ff       	call   1dec <putc>
    201b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    201e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2021:	0f be c0             	movsbl %al,%eax
    2024:	83 ec 08             	sub    $0x8,%esp
    2027:	50                   	push   %eax
    2028:	ff 75 08             	pushl  0x8(%ebp)
    202b:	e8 bc fd ff ff       	call   1dec <putc>
    2030:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    2033:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    203a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    203e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2041:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2044:	01 d0                	add    %edx,%eax
    2046:	0f b6 00             	movzbl (%eax),%eax
    2049:	84 c0                	test   %al,%al
    204b:	0f 85 94 fe ff ff    	jne    1ee5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2051:	90                   	nop
    2052:	c9                   	leave  
    2053:	c3                   	ret    

00002054 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2054:	55                   	push   %ebp
    2055:	89 e5                	mov    %esp,%ebp
    2057:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    205a:	8b 45 08             	mov    0x8(%ebp),%eax
    205d:	83 e8 08             	sub    $0x8,%eax
    2060:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2063:	a1 a8 3b 00 00       	mov    0x3ba8,%eax
    2068:	89 45 fc             	mov    %eax,-0x4(%ebp)
    206b:	eb 24                	jmp    2091 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    206d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2070:	8b 00                	mov    (%eax),%eax
    2072:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2075:	77 12                	ja     2089 <free+0x35>
    2077:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    207d:	77 24                	ja     20a3 <free+0x4f>
    207f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2082:	8b 00                	mov    (%eax),%eax
    2084:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2087:	77 1a                	ja     20a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2089:	8b 45 fc             	mov    -0x4(%ebp),%eax
    208c:	8b 00                	mov    (%eax),%eax
    208e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2091:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2094:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2097:	76 d4                	jbe    206d <free+0x19>
    2099:	8b 45 fc             	mov    -0x4(%ebp),%eax
    209c:	8b 00                	mov    (%eax),%eax
    209e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    20a1:	76 ca                	jbe    206d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    20a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20a6:	8b 40 04             	mov    0x4(%eax),%eax
    20a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    20b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20b3:	01 c2                	add    %eax,%edx
    20b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20b8:	8b 00                	mov    (%eax),%eax
    20ba:	39 c2                	cmp    %eax,%edx
    20bc:	75 24                	jne    20e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    20be:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20c1:	8b 50 04             	mov    0x4(%eax),%edx
    20c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20c7:	8b 00                	mov    (%eax),%eax
    20c9:	8b 40 04             	mov    0x4(%eax),%eax
    20cc:	01 c2                	add    %eax,%edx
    20ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    20d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20d7:	8b 00                	mov    (%eax),%eax
    20d9:	8b 10                	mov    (%eax),%edx
    20db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20de:	89 10                	mov    %edx,(%eax)
    20e0:	eb 0a                	jmp    20ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    20e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20e5:	8b 10                	mov    (%eax),%edx
    20e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    20ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20ef:	8b 40 04             	mov    0x4(%eax),%eax
    20f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    20f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    20fc:	01 d0                	add    %edx,%eax
    20fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2101:	75 20                	jne    2123 <free+0xcf>
    p->s.size += bp->s.size;
    2103:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2106:	8b 50 04             	mov    0x4(%eax),%edx
    2109:	8b 45 f8             	mov    -0x8(%ebp),%eax
    210c:	8b 40 04             	mov    0x4(%eax),%eax
    210f:	01 c2                	add    %eax,%edx
    2111:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2114:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2117:	8b 45 f8             	mov    -0x8(%ebp),%eax
    211a:	8b 10                	mov    (%eax),%edx
    211c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    211f:	89 10                	mov    %edx,(%eax)
    2121:	eb 08                	jmp    212b <free+0xd7>
  } else
    p->s.ptr = bp;
    2123:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2126:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2129:	89 10                	mov    %edx,(%eax)
  freep = p;
    212b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    212e:	a3 a8 3b 00 00       	mov    %eax,0x3ba8
}
    2133:	90                   	nop
    2134:	c9                   	leave  
    2135:	c3                   	ret    

00002136 <morecore>:

static Header*
morecore(uint nu)
{
    2136:	55                   	push   %ebp
    2137:	89 e5                	mov    %esp,%ebp
    2139:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    213c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2143:	77 07                	ja     214c <morecore+0x16>
    nu = 4096;
    2145:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    214c:	8b 45 08             	mov    0x8(%ebp),%eax
    214f:	c1 e0 03             	shl    $0x3,%eax
    2152:	83 ec 0c             	sub    $0xc,%esp
    2155:	50                   	push   %eax
    2156:	e8 19 fc ff ff       	call   1d74 <sbrk>
    215b:	83 c4 10             	add    $0x10,%esp
    215e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    2161:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2165:	75 07                	jne    216e <morecore+0x38>
    return 0;
    2167:	b8 00 00 00 00       	mov    $0x0,%eax
    216c:	eb 26                	jmp    2194 <morecore+0x5e>
  hp = (Header*)p;
    216e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2171:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    2174:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2177:	8b 55 08             	mov    0x8(%ebp),%edx
    217a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    217d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2180:	83 c0 08             	add    $0x8,%eax
    2183:	83 ec 0c             	sub    $0xc,%esp
    2186:	50                   	push   %eax
    2187:	e8 c8 fe ff ff       	call   2054 <free>
    218c:	83 c4 10             	add    $0x10,%esp
  return freep;
    218f:	a1 a8 3b 00 00       	mov    0x3ba8,%eax
}
    2194:	c9                   	leave  
    2195:	c3                   	ret    

00002196 <malloc>:

void*
malloc(uint nbytes)
{
    2196:	55                   	push   %ebp
    2197:	89 e5                	mov    %esp,%ebp
    2199:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    219c:	8b 45 08             	mov    0x8(%ebp),%eax
    219f:	83 c0 07             	add    $0x7,%eax
    21a2:	c1 e8 03             	shr    $0x3,%eax
    21a5:	83 c0 01             	add    $0x1,%eax
    21a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    21ab:	a1 a8 3b 00 00       	mov    0x3ba8,%eax
    21b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21b7:	75 23                	jne    21dc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    21b9:	c7 45 f0 a0 3b 00 00 	movl   $0x3ba0,-0x10(%ebp)
    21c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c3:	a3 a8 3b 00 00       	mov    %eax,0x3ba8
    21c8:	a1 a8 3b 00 00       	mov    0x3ba8,%eax
    21cd:	a3 a0 3b 00 00       	mov    %eax,0x3ba0
    base.s.size = 0;
    21d2:	c7 05 a4 3b 00 00 00 	movl   $0x0,0x3ba4
    21d9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    21dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21df:	8b 00                	mov    (%eax),%eax
    21e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    21e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21e7:	8b 40 04             	mov    0x4(%eax),%eax
    21ea:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    21ed:	72 4d                	jb     223c <malloc+0xa6>
      if(p->s.size == nunits)
    21ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f2:	8b 40 04             	mov    0x4(%eax),%eax
    21f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    21f8:	75 0c                	jne    2206 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    21fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21fd:	8b 10                	mov    (%eax),%edx
    21ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2202:	89 10                	mov    %edx,(%eax)
    2204:	eb 26                	jmp    222c <malloc+0x96>
      else {
        p->s.size -= nunits;
    2206:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2209:	8b 40 04             	mov    0x4(%eax),%eax
    220c:	2b 45 ec             	sub    -0x14(%ebp),%eax
    220f:	89 c2                	mov    %eax,%edx
    2211:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2214:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    2217:	8b 45 f4             	mov    -0xc(%ebp),%eax
    221a:	8b 40 04             	mov    0x4(%eax),%eax
    221d:	c1 e0 03             	shl    $0x3,%eax
    2220:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    2223:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2226:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2229:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    222c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    222f:	a3 a8 3b 00 00       	mov    %eax,0x3ba8
      return (void*)(p + 1);
    2234:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2237:	83 c0 08             	add    $0x8,%eax
    223a:	eb 3b                	jmp    2277 <malloc+0xe1>
    }
    if(p == freep)
    223c:	a1 a8 3b 00 00       	mov    0x3ba8,%eax
    2241:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2244:	75 1e                	jne    2264 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    2246:	83 ec 0c             	sub    $0xc,%esp
    2249:	ff 75 ec             	pushl  -0x14(%ebp)
    224c:	e8 e5 fe ff ff       	call   2136 <morecore>
    2251:	83 c4 10             	add    $0x10,%esp
    2254:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2257:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    225b:	75 07                	jne    2264 <malloc+0xce>
        return 0;
    225d:	b8 00 00 00 00       	mov    $0x0,%eax
    2262:	eb 13                	jmp    2277 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2264:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2267:	89 45 f0             	mov    %eax,-0x10(%ebp)
    226a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    226d:	8b 00                	mov    (%eax),%eax
    226f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    2272:	e9 6d ff ff ff       	jmp    21e4 <malloc+0x4e>
}
    2277:	c9                   	leave  
    2278:	c3                   	ret    

00002279 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
    2279:	55                   	push   %ebp
    227a:	89 e5                	mov    %esp,%ebp
    227c:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
    227f:	83 ec 0c             	sub    $0xc,%esp
    2282:	ff 75 08             	pushl  0x8(%ebp)
    2285:	e8 b0 00 00 00       	call   233a <re_compile>
    228a:	83 c4 10             	add    $0x10,%esp
    228d:	83 ec 04             	sub    $0x4,%esp
    2290:	ff 75 10             	pushl  0x10(%ebp)
    2293:	ff 75 0c             	pushl  0xc(%ebp)
    2296:	50                   	push   %eax
    2297:	e8 05 00 00 00       	call   22a1 <re_matchp>
    229c:	83 c4 10             	add    $0x10,%esp
}
    229f:	c9                   	leave  
    22a0:	c3                   	ret    

000022a1 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
    22a1:	55                   	push   %ebp
    22a2:	89 e5                	mov    %esp,%ebp
    22a4:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
    22a7:	8b 45 10             	mov    0x10(%ebp),%eax
    22aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
    22b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    22b4:	74 7d                	je     2333 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
    22b6:	8b 45 08             	mov    0x8(%ebp),%eax
    22b9:	0f b6 00             	movzbl (%eax),%eax
    22bc:	3c 02                	cmp    $0x2,%al
    22be:	75 2a                	jne    22ea <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
    22c0:	8b 45 08             	mov    0x8(%ebp),%eax
    22c3:	83 c0 08             	add    $0x8,%eax
    22c6:	83 ec 04             	sub    $0x4,%esp
    22c9:	ff 75 10             	pushl  0x10(%ebp)
    22cc:	ff 75 0c             	pushl  0xc(%ebp)
    22cf:	50                   	push   %eax
    22d0:	e8 b0 08 00 00       	call   2b85 <matchpattern>
    22d5:	83 c4 10             	add    $0x10,%esp
    22d8:	85 c0                	test   %eax,%eax
    22da:	74 07                	je     22e3 <re_matchp+0x42>
    22dc:	b8 00 00 00 00       	mov    $0x0,%eax
    22e1:	eb 55                	jmp    2338 <re_matchp+0x97>
    22e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    22e8:	eb 4e                	jmp    2338 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
    22ea:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
    22f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
    22f5:	83 ec 04             	sub    $0x4,%esp
    22f8:	ff 75 10             	pushl  0x10(%ebp)
    22fb:	ff 75 0c             	pushl  0xc(%ebp)
    22fe:	ff 75 08             	pushl  0x8(%ebp)
    2301:	e8 7f 08 00 00       	call   2b85 <matchpattern>
    2306:	83 c4 10             	add    $0x10,%esp
    2309:	85 c0                	test   %eax,%eax
    230b:	74 16                	je     2323 <re_matchp+0x82>
        {
          if (text[0] == '\0')
    230d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2310:	0f b6 00             	movzbl (%eax),%eax
    2313:	84 c0                	test   %al,%al
    2315:	75 07                	jne    231e <re_matchp+0x7d>
            return -1;
    2317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    231c:	eb 1a                	jmp    2338 <re_matchp+0x97>
        
          return idx;
    231e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2321:	eb 15                	jmp    2338 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
    2323:	8b 45 0c             	mov    0xc(%ebp),%eax
    2326:	8d 50 01             	lea    0x1(%eax),%edx
    2329:	89 55 0c             	mov    %edx,0xc(%ebp)
    232c:	0f b6 00             	movzbl (%eax),%eax
    232f:	84 c0                	test   %al,%al
    2331:	75 be                	jne    22f1 <re_matchp+0x50>
    }
  }
  return -1;
    2333:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2338:	c9                   	leave  
    2339:	c3                   	ret    

0000233a <re_compile>:

re_t re_compile(const char* pattern)
{
    233a:	55                   	push   %ebp
    233b:	89 e5                	mov    %esp,%ebp
    233d:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
    2340:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
    2347:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
    234e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
    2355:	e9 55 02 00 00       	jmp    25af <re_compile+0x275>
  {
    c = pattern[i];
    235a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    235d:	8b 45 08             	mov    0x8(%ebp),%eax
    2360:	01 d0                	add    %edx,%eax
    2362:	0f b6 00             	movzbl (%eax),%eax
    2365:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
    2368:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
    236c:	83 e8 24             	sub    $0x24,%eax
    236f:	83 f8 3a             	cmp    $0x3a,%eax
    2372:	0f 87 13 02 00 00    	ja     258b <re_compile+0x251>
    2378:	8b 04 85 00 2f 00 00 	mov    0x2f00(,%eax,4),%eax
    237f:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
    2381:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2384:	c6 04 c5 c0 3b 00 00 	movb   $0x2,0x3bc0(,%eax,8)
    238b:	02 
    238c:	e9 16 02 00 00       	jmp    25a7 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
    2391:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2394:	c6 04 c5 c0 3b 00 00 	movb   $0x3,0x3bc0(,%eax,8)
    239b:	03 
    239c:	e9 06 02 00 00       	jmp    25a7 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
    23a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23a4:	c6 04 c5 c0 3b 00 00 	movb   $0x1,0x3bc0(,%eax,8)
    23ab:	01 
    23ac:	e9 f6 01 00 00       	jmp    25a7 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
    23b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23b4:	c6 04 c5 c0 3b 00 00 	movb   $0x5,0x3bc0(,%eax,8)
    23bb:	05 
    23bc:	e9 e6 01 00 00       	jmp    25a7 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
    23c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23c4:	c6 04 c5 c0 3b 00 00 	movb   $0x6,0x3bc0(,%eax,8)
    23cb:	06 
    23cc:	e9 d6 01 00 00       	jmp    25a7 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
    23d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23d4:	c6 04 c5 c0 3b 00 00 	movb   $0x4,0x3bc0(,%eax,8)
    23db:	04 
    23dc:	e9 c6 01 00 00       	jmp    25a7 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
    23e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    23e4:	8d 50 01             	lea    0x1(%eax),%edx
    23e7:	8b 45 08             	mov    0x8(%ebp),%eax
    23ea:	01 d0                	add    %edx,%eax
    23ec:	0f b6 00             	movzbl (%eax),%eax
    23ef:	84 c0                	test   %al,%al
    23f1:	0f 84 af 01 00 00    	je     25a6 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
    23f7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
    23fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    23fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2401:	01 d0                	add    %edx,%eax
    2403:	0f b6 00             	movzbl (%eax),%eax
    2406:	0f be c0             	movsbl %al,%eax
    2409:	83 e8 44             	sub    $0x44,%eax
    240c:	83 f8 33             	cmp    $0x33,%eax
    240f:	77 57                	ja     2468 <re_compile+0x12e>
    2411:	8b 04 85 ec 2f 00 00 	mov    0x2fec(,%eax,4),%eax
    2418:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
    241a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    241d:	c6 04 c5 c0 3b 00 00 	movb   $0xa,0x3bc0(,%eax,8)
    2424:	0a 
    2425:	eb 64                	jmp    248b <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
    2427:	8b 45 f4             	mov    -0xc(%ebp),%eax
    242a:	c6 04 c5 c0 3b 00 00 	movb   $0xb,0x3bc0(,%eax,8)
    2431:	0b 
    2432:	eb 57                	jmp    248b <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
    2434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2437:	c6 04 c5 c0 3b 00 00 	movb   $0xc,0x3bc0(,%eax,8)
    243e:	0c 
    243f:	eb 4a                	jmp    248b <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
    2441:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2444:	c6 04 c5 c0 3b 00 00 	movb   $0xd,0x3bc0(,%eax,8)
    244b:	0d 
    244c:	eb 3d                	jmp    248b <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
    244e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2451:	c6 04 c5 c0 3b 00 00 	movb   $0xe,0x3bc0(,%eax,8)
    2458:	0e 
    2459:	eb 30                	jmp    248b <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
    245b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    245e:	c6 04 c5 c0 3b 00 00 	movb   $0xf,0x3bc0(,%eax,8)
    2465:	0f 
    2466:	eb 23                	jmp    248b <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
    2468:	8b 45 f4             	mov    -0xc(%ebp),%eax
    246b:	c6 04 c5 c0 3b 00 00 	movb   $0x7,0x3bc0(,%eax,8)
    2472:	07 
              re_compiled[j].ch = pattern[i];
    2473:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2476:	8b 45 08             	mov    0x8(%ebp),%eax
    2479:	01 d0                	add    %edx,%eax
    247b:	0f b6 00             	movzbl (%eax),%eax
    247e:	89 c2                	mov    %eax,%edx
    2480:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2483:	88 14 c5 c4 3b 00 00 	mov    %dl,0x3bc4(,%eax,8)
            } break;
    248a:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
    248b:	e9 16 01 00 00       	jmp    25a6 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
    2490:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2493:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
    2496:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2499:	8d 50 01             	lea    0x1(%eax),%edx
    249c:	8b 45 08             	mov    0x8(%ebp),%eax
    249f:	01 d0                	add    %edx,%eax
    24a1:	0f b6 00             	movzbl (%eax),%eax
    24a4:	3c 5e                	cmp    $0x5e,%al
    24a6:	75 11                	jne    24b9 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
    24a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24ab:	c6 04 c5 c0 3b 00 00 	movb   $0x9,0x3bc0(,%eax,8)
    24b2:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
    24b3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    24b7:	eb 7a                	jmp    2533 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
    24b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24bc:	c6 04 c5 c0 3b 00 00 	movb   $0x8,0x3bc0(,%eax,8)
    24c3:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
    24c4:	eb 6d                	jmp    2533 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
    24c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    24c9:	8b 45 08             	mov    0x8(%ebp),%eax
    24cc:	01 d0                	add    %edx,%eax
    24ce:	0f b6 00             	movzbl (%eax),%eax
    24d1:	3c 5c                	cmp    $0x5c,%al
    24d3:	75 34                	jne    2509 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
    24d5:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
    24d9:	7e 0a                	jle    24e5 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
    24db:	b8 00 00 00 00       	mov    $0x0,%eax
    24e0:	e9 f8 00 00 00       	jmp    25dd <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
    24e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    24e8:	8d 50 01             	lea    0x1(%eax),%edx
    24eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
    24ee:	8b 55 f8             	mov    -0x8(%ebp),%edx
    24f1:	8d 4a 01             	lea    0x1(%edx),%ecx
    24f4:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    24f7:	89 d1                	mov    %edx,%ecx
    24f9:	8b 55 08             	mov    0x8(%ebp),%edx
    24fc:	01 ca                	add    %ecx,%edx
    24fe:	0f b6 12             	movzbl (%edx),%edx
    2501:	88 90 c0 3c 00 00    	mov    %dl,0x3cc0(%eax)
    2507:	eb 10                	jmp    2519 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
    2509:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
    250d:	7e 0a                	jle    2519 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
    250f:	b8 00 00 00 00       	mov    $0x0,%eax
    2514:	e9 c4 00 00 00       	jmp    25dd <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
    2519:	8b 45 fc             	mov    -0x4(%ebp),%eax
    251c:	8d 50 01             	lea    0x1(%eax),%edx
    251f:	89 55 fc             	mov    %edx,-0x4(%ebp)
    2522:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2525:	8b 55 08             	mov    0x8(%ebp),%edx
    2528:	01 ca                	add    %ecx,%edx
    252a:	0f b6 12             	movzbl (%edx),%edx
    252d:	88 90 c0 3c 00 00    	mov    %dl,0x3cc0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
    2533:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2537:	8b 55 f8             	mov    -0x8(%ebp),%edx
    253a:	8b 45 08             	mov    0x8(%ebp),%eax
    253d:	01 d0                	add    %edx,%eax
    253f:	0f b6 00             	movzbl (%eax),%eax
    2542:	3c 5d                	cmp    $0x5d,%al
    2544:	74 13                	je     2559 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
    2546:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2549:	8b 45 08             	mov    0x8(%ebp),%eax
    254c:	01 d0                	add    %edx,%eax
    254e:	0f b6 00             	movzbl (%eax),%eax
    2551:	84 c0                	test   %al,%al
    2553:	0f 85 6d ff ff ff    	jne    24c6 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
    2559:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
    255d:	7e 07                	jle    2566 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
    255f:	b8 00 00 00 00       	mov    $0x0,%eax
    2564:	eb 77                	jmp    25dd <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
    2566:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2569:	8d 50 01             	lea    0x1(%eax),%edx
    256c:	89 55 fc             	mov    %edx,-0x4(%ebp)
    256f:	c6 80 c0 3c 00 00 00 	movb   $0x0,0x3cc0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
    2576:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2579:	8d 90 c0 3c 00 00    	lea    0x3cc0(%eax),%edx
    257f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2582:	89 14 c5 c4 3b 00 00 	mov    %edx,0x3bc4(,%eax,8)
      } break;
    2589:	eb 1c                	jmp    25a7 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
    258b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    258e:	c6 04 c5 c0 3b 00 00 	movb   $0x7,0x3bc0(,%eax,8)
    2595:	07 
        re_compiled[j].ch = c;
    2596:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
    259a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    259d:	88 14 c5 c4 3b 00 00 	mov    %dl,0x3bc4(,%eax,8)
      } break;
    25a4:	eb 01                	jmp    25a7 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
    25a6:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
    25a7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
    25ab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
    25af:	8b 55 f8             	mov    -0x8(%ebp),%edx
    25b2:	8b 45 08             	mov    0x8(%ebp),%eax
    25b5:	01 d0                	add    %edx,%eax
    25b7:	0f b6 00             	movzbl (%eax),%eax
    25ba:	84 c0                	test   %al,%al
    25bc:	74 0f                	je     25cd <re_compile+0x293>
    25be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25c1:	83 c0 01             	add    $0x1,%eax
    25c4:	83 f8 1d             	cmp    $0x1d,%eax
    25c7:	0f 8e 8d fd ff ff    	jle    235a <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
    25cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25d0:	c6 04 c5 c0 3b 00 00 	movb   $0x0,0x3bc0(,%eax,8)
    25d7:	00 

  return (re_t) re_compiled;
    25d8:	b8 c0 3b 00 00       	mov    $0x3bc0,%eax
}
    25dd:	c9                   	leave  
    25de:	c3                   	ret    

000025df <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
    25df:	55                   	push   %ebp
    25e0:	89 e5                	mov    %esp,%ebp
    25e2:	83 ec 04             	sub    $0x4,%esp
    25e5:	8b 45 08             	mov    0x8(%ebp),%eax
    25e8:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
    25eb:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
    25ef:	7e 0d                	jle    25fe <matchdigit+0x1f>
    25f1:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
    25f5:	7f 07                	jg     25fe <matchdigit+0x1f>
    25f7:	b8 01 00 00 00       	mov    $0x1,%eax
    25fc:	eb 05                	jmp    2603 <matchdigit+0x24>
    25fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2603:	c9                   	leave  
    2604:	c3                   	ret    

00002605 <matchalpha>:
static int matchalpha(char c)
{
    2605:	55                   	push   %ebp
    2606:	89 e5                	mov    %esp,%ebp
    2608:	83 ec 04             	sub    $0x4,%esp
    260b:	8b 45 08             	mov    0x8(%ebp),%eax
    260e:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
    2611:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
    2615:	7e 06                	jle    261d <matchalpha+0x18>
    2617:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
    261b:	7e 0c                	jle    2629 <matchalpha+0x24>
    261d:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
    2621:	7e 0d                	jle    2630 <matchalpha+0x2b>
    2623:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
    2627:	7f 07                	jg     2630 <matchalpha+0x2b>
    2629:	b8 01 00 00 00       	mov    $0x1,%eax
    262e:	eb 05                	jmp    2635 <matchalpha+0x30>
    2630:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2635:	c9                   	leave  
    2636:	c3                   	ret    

00002637 <matchwhitespace>:
static int matchwhitespace(char c)
{
    2637:	55                   	push   %ebp
    2638:	89 e5                	mov    %esp,%ebp
    263a:	83 ec 04             	sub    $0x4,%esp
    263d:	8b 45 08             	mov    0x8(%ebp),%eax
    2640:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
    2643:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
    2647:	74 1e                	je     2667 <matchwhitespace+0x30>
    2649:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
    264d:	74 18                	je     2667 <matchwhitespace+0x30>
    264f:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
    2653:	74 12                	je     2667 <matchwhitespace+0x30>
    2655:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
    2659:	74 0c                	je     2667 <matchwhitespace+0x30>
    265b:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
    265f:	74 06                	je     2667 <matchwhitespace+0x30>
    2661:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
    2665:	75 07                	jne    266e <matchwhitespace+0x37>
    2667:	b8 01 00 00 00       	mov    $0x1,%eax
    266c:	eb 05                	jmp    2673 <matchwhitespace+0x3c>
    266e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2673:	c9                   	leave  
    2674:	c3                   	ret    

00002675 <matchalphanum>:
static int matchalphanum(char c)
{
    2675:	55                   	push   %ebp
    2676:	89 e5                	mov    %esp,%ebp
    2678:	83 ec 04             	sub    $0x4,%esp
    267b:	8b 45 08             	mov    0x8(%ebp),%eax
    267e:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
    2681:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
    2685:	74 22                	je     26a9 <matchalphanum+0x34>
    2687:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    268b:	50                   	push   %eax
    268c:	e8 74 ff ff ff       	call   2605 <matchalpha>
    2691:	83 c4 04             	add    $0x4,%esp
    2694:	85 c0                	test   %eax,%eax
    2696:	75 11                	jne    26a9 <matchalphanum+0x34>
    2698:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    269c:	50                   	push   %eax
    269d:	e8 3d ff ff ff       	call   25df <matchdigit>
    26a2:	83 c4 04             	add    $0x4,%esp
    26a5:	85 c0                	test   %eax,%eax
    26a7:	74 07                	je     26b0 <matchalphanum+0x3b>
    26a9:	b8 01 00 00 00       	mov    $0x1,%eax
    26ae:	eb 05                	jmp    26b5 <matchalphanum+0x40>
    26b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    26b5:	c9                   	leave  
    26b6:	c3                   	ret    

000026b7 <matchrange>:
static int matchrange(char c, const char* str)
{
    26b7:	55                   	push   %ebp
    26b8:	89 e5                	mov    %esp,%ebp
    26ba:	83 ec 04             	sub    $0x4,%esp
    26bd:	8b 45 08             	mov    0x8(%ebp),%eax
    26c0:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    26c3:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    26c7:	74 5b                	je     2724 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
    26c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    26cc:	0f b6 00             	movzbl (%eax),%eax
    26cf:	84 c0                	test   %al,%al
    26d1:	74 51                	je     2724 <matchrange+0x6d>
    26d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    26d6:	0f b6 00             	movzbl (%eax),%eax
    26d9:	3c 2d                	cmp    $0x2d,%al
    26db:	74 47                	je     2724 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
    26dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    26e0:	83 c0 01             	add    $0x1,%eax
    26e3:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
    26e6:	3c 2d                	cmp    $0x2d,%al
    26e8:	75 3a                	jne    2724 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
    26ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    26ed:	83 c0 01             	add    $0x1,%eax
    26f0:	0f b6 00             	movzbl (%eax),%eax
    26f3:	84 c0                	test   %al,%al
    26f5:	74 2d                	je     2724 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    26f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    26fa:	83 c0 02             	add    $0x2,%eax
    26fd:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
    2700:	84 c0                	test   %al,%al
    2702:	74 20                	je     2724 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    2704:	8b 45 0c             	mov    0xc(%ebp),%eax
    2707:	0f b6 00             	movzbl (%eax),%eax
    270a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    270d:	7f 15                	jg     2724 <matchrange+0x6d>
    270f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2712:	83 c0 02             	add    $0x2,%eax
    2715:	0f b6 00             	movzbl (%eax),%eax
    2718:	3a 45 fc             	cmp    -0x4(%ebp),%al
    271b:	7c 07                	jl     2724 <matchrange+0x6d>
    271d:	b8 01 00 00 00       	mov    $0x1,%eax
    2722:	eb 05                	jmp    2729 <matchrange+0x72>
    2724:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2729:	c9                   	leave  
    272a:	c3                   	ret    

0000272b <ismetachar>:
static int ismetachar(char c)
{
    272b:	55                   	push   %ebp
    272c:	89 e5                	mov    %esp,%ebp
    272e:	83 ec 04             	sub    $0x4,%esp
    2731:	8b 45 08             	mov    0x8(%ebp),%eax
    2734:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
    2737:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
    273b:	74 1e                	je     275b <ismetachar+0x30>
    273d:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
    2741:	74 18                	je     275b <ismetachar+0x30>
    2743:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
    2747:	74 12                	je     275b <ismetachar+0x30>
    2749:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
    274d:	74 0c                	je     275b <ismetachar+0x30>
    274f:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
    2753:	74 06                	je     275b <ismetachar+0x30>
    2755:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
    2759:	75 07                	jne    2762 <ismetachar+0x37>
    275b:	b8 01 00 00 00       	mov    $0x1,%eax
    2760:	eb 05                	jmp    2767 <ismetachar+0x3c>
    2762:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2767:	c9                   	leave  
    2768:	c3                   	ret    

00002769 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
    2769:	55                   	push   %ebp
    276a:	89 e5                	mov    %esp,%ebp
    276c:	83 ec 04             	sub    $0x4,%esp
    276f:	8b 45 08             	mov    0x8(%ebp),%eax
    2772:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
    2775:	8b 45 0c             	mov    0xc(%ebp),%eax
    2778:	0f b6 00             	movzbl (%eax),%eax
    277b:	0f be c0             	movsbl %al,%eax
    277e:	83 e8 44             	sub    $0x44,%eax
    2781:	83 f8 33             	cmp    $0x33,%eax
    2784:	77 7b                	ja     2801 <matchmetachar+0x98>
    2786:	8b 04 85 bc 30 00 00 	mov    0x30bc(,%eax,4),%eax
    278d:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
    278f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2793:	50                   	push   %eax
    2794:	e8 46 fe ff ff       	call   25df <matchdigit>
    2799:	83 c4 04             	add    $0x4,%esp
    279c:	eb 72                	jmp    2810 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
    279e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    27a2:	50                   	push   %eax
    27a3:	e8 37 fe ff ff       	call   25df <matchdigit>
    27a8:	83 c4 04             	add    $0x4,%esp
    27ab:	85 c0                	test   %eax,%eax
    27ad:	0f 94 c0             	sete   %al
    27b0:	0f b6 c0             	movzbl %al,%eax
    27b3:	eb 5b                	jmp    2810 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
    27b5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    27b9:	50                   	push   %eax
    27ba:	e8 b6 fe ff ff       	call   2675 <matchalphanum>
    27bf:	83 c4 04             	add    $0x4,%esp
    27c2:	eb 4c                	jmp    2810 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
    27c4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    27c8:	50                   	push   %eax
    27c9:	e8 a7 fe ff ff       	call   2675 <matchalphanum>
    27ce:	83 c4 04             	add    $0x4,%esp
    27d1:	85 c0                	test   %eax,%eax
    27d3:	0f 94 c0             	sete   %al
    27d6:	0f b6 c0             	movzbl %al,%eax
    27d9:	eb 35                	jmp    2810 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
    27db:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    27df:	50                   	push   %eax
    27e0:	e8 52 fe ff ff       	call   2637 <matchwhitespace>
    27e5:	83 c4 04             	add    $0x4,%esp
    27e8:	eb 26                	jmp    2810 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
    27ea:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    27ee:	50                   	push   %eax
    27ef:	e8 43 fe ff ff       	call   2637 <matchwhitespace>
    27f4:	83 c4 04             	add    $0x4,%esp
    27f7:	85 c0                	test   %eax,%eax
    27f9:	0f 94 c0             	sete   %al
    27fc:	0f b6 c0             	movzbl %al,%eax
    27ff:	eb 0f                	jmp    2810 <matchmetachar+0xa7>
    default:  return (c == str[0]);
    2801:	8b 45 0c             	mov    0xc(%ebp),%eax
    2804:	0f b6 00             	movzbl (%eax),%eax
    2807:	3a 45 fc             	cmp    -0x4(%ebp),%al
    280a:	0f 94 c0             	sete   %al
    280d:	0f b6 c0             	movzbl %al,%eax
  }
}
    2810:	c9                   	leave  
    2811:	c3                   	ret    

00002812 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
    2812:	55                   	push   %ebp
    2813:	89 e5                	mov    %esp,%ebp
    2815:	83 ec 04             	sub    $0x4,%esp
    2818:	8b 45 08             	mov    0x8(%ebp),%eax
    281b:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
    281e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2822:	ff 75 0c             	pushl  0xc(%ebp)
    2825:	50                   	push   %eax
    2826:	e8 8c fe ff ff       	call   26b7 <matchrange>
    282b:	83 c4 08             	add    $0x8,%esp
    282e:	85 c0                	test   %eax,%eax
    2830:	74 0a                	je     283c <matchcharclass+0x2a>
    {
      return 1;
    2832:	b8 01 00 00 00       	mov    $0x1,%eax
    2837:	e9 a5 00 00 00       	jmp    28e1 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
    283c:	8b 45 0c             	mov    0xc(%ebp),%eax
    283f:	0f b6 00             	movzbl (%eax),%eax
    2842:	3c 5c                	cmp    $0x5c,%al
    2844:	75 42                	jne    2888 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
    2846:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
    284a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    284e:	ff 75 0c             	pushl  0xc(%ebp)
    2851:	50                   	push   %eax
    2852:	e8 12 ff ff ff       	call   2769 <matchmetachar>
    2857:	83 c4 08             	add    $0x8,%esp
    285a:	85 c0                	test   %eax,%eax
    285c:	74 07                	je     2865 <matchcharclass+0x53>
      {
        return 1;
    285e:	b8 01 00 00 00       	mov    $0x1,%eax
    2863:	eb 7c                	jmp    28e1 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
    2865:	8b 45 0c             	mov    0xc(%ebp),%eax
    2868:	0f b6 00             	movzbl (%eax),%eax
    286b:	3a 45 fc             	cmp    -0x4(%ebp),%al
    286e:	75 58                	jne    28c8 <matchcharclass+0xb6>
    2870:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2874:	50                   	push   %eax
    2875:	e8 b1 fe ff ff       	call   272b <ismetachar>
    287a:	83 c4 04             	add    $0x4,%esp
    287d:	85 c0                	test   %eax,%eax
    287f:	75 47                	jne    28c8 <matchcharclass+0xb6>
      {
        return 1;
    2881:	b8 01 00 00 00       	mov    $0x1,%eax
    2886:	eb 59                	jmp    28e1 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
    2888:	8b 45 0c             	mov    0xc(%ebp),%eax
    288b:	0f b6 00             	movzbl (%eax),%eax
    288e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    2891:	75 35                	jne    28c8 <matchcharclass+0xb6>
    {
      if (c == '-')
    2893:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    2897:	75 28                	jne    28c1 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
    2899:	8b 45 0c             	mov    0xc(%ebp),%eax
    289c:	83 e8 01             	sub    $0x1,%eax
    289f:	0f b6 00             	movzbl (%eax),%eax
    28a2:	84 c0                	test   %al,%al
    28a4:	74 0d                	je     28b3 <matchcharclass+0xa1>
    28a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    28a9:	83 c0 01             	add    $0x1,%eax
    28ac:	0f b6 00             	movzbl (%eax),%eax
    28af:	84 c0                	test   %al,%al
    28b1:	75 07                	jne    28ba <matchcharclass+0xa8>
    28b3:	b8 01 00 00 00       	mov    $0x1,%eax
    28b8:	eb 27                	jmp    28e1 <matchcharclass+0xcf>
    28ba:	b8 00 00 00 00       	mov    $0x0,%eax
    28bf:	eb 20                	jmp    28e1 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
    28c1:	b8 01 00 00 00       	mov    $0x1,%eax
    28c6:	eb 19                	jmp    28e1 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
    28c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    28cb:	8d 50 01             	lea    0x1(%eax),%edx
    28ce:	89 55 0c             	mov    %edx,0xc(%ebp)
    28d1:	0f b6 00             	movzbl (%eax),%eax
    28d4:	84 c0                	test   %al,%al
    28d6:	0f 85 42 ff ff ff    	jne    281e <matchcharclass+0xc>

  return 0;
    28dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
    28e1:	c9                   	leave  
    28e2:	c3                   	ret    

000028e3 <matchone>:

static int matchone(regex_t p, char c)
{
    28e3:	55                   	push   %ebp
    28e4:	89 e5                	mov    %esp,%ebp
    28e6:	83 ec 04             	sub    $0x4,%esp
    28e9:	8b 45 10             	mov    0x10(%ebp),%eax
    28ec:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
    28ef:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    28f3:	0f b6 c0             	movzbl %al,%eax
    28f6:	83 f8 0f             	cmp    $0xf,%eax
    28f9:	0f 87 b9 00 00 00    	ja     29b8 <matchone+0xd5>
    28ff:	8b 04 85 8c 31 00 00 	mov    0x318c(,%eax,4),%eax
    2906:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
    2908:	b8 01 00 00 00       	mov    $0x1,%eax
    290d:	e9 b9 00 00 00       	jmp    29cb <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
    2912:	8b 55 0c             	mov    0xc(%ebp),%edx
    2915:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2919:	52                   	push   %edx
    291a:	50                   	push   %eax
    291b:	e8 f2 fe ff ff       	call   2812 <matchcharclass>
    2920:	83 c4 08             	add    $0x8,%esp
    2923:	e9 a3 00 00 00       	jmp    29cb <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
    2928:	8b 55 0c             	mov    0xc(%ebp),%edx
    292b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    292f:	52                   	push   %edx
    2930:	50                   	push   %eax
    2931:	e8 dc fe ff ff       	call   2812 <matchcharclass>
    2936:	83 c4 08             	add    $0x8,%esp
    2939:	85 c0                	test   %eax,%eax
    293b:	0f 94 c0             	sete   %al
    293e:	0f b6 c0             	movzbl %al,%eax
    2941:	e9 85 00 00 00       	jmp    29cb <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    2946:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    294a:	50                   	push   %eax
    294b:	e8 8f fc ff ff       	call   25df <matchdigit>
    2950:	83 c4 04             	add    $0x4,%esp
    2953:	eb 76                	jmp    29cb <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    2955:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2959:	50                   	push   %eax
    295a:	e8 80 fc ff ff       	call   25df <matchdigit>
    295f:	83 c4 04             	add    $0x4,%esp
    2962:	85 c0                	test   %eax,%eax
    2964:	0f 94 c0             	sete   %al
    2967:	0f b6 c0             	movzbl %al,%eax
    296a:	eb 5f                	jmp    29cb <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    296c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2970:	50                   	push   %eax
    2971:	e8 ff fc ff ff       	call   2675 <matchalphanum>
    2976:	83 c4 04             	add    $0x4,%esp
    2979:	eb 50                	jmp    29cb <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    297b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    297f:	50                   	push   %eax
    2980:	e8 f0 fc ff ff       	call   2675 <matchalphanum>
    2985:	83 c4 04             	add    $0x4,%esp
    2988:	85 c0                	test   %eax,%eax
    298a:	0f 94 c0             	sete   %al
    298d:	0f b6 c0             	movzbl %al,%eax
    2990:	eb 39                	jmp    29cb <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    2992:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    2996:	50                   	push   %eax
    2997:	e8 9b fc ff ff       	call   2637 <matchwhitespace>
    299c:	83 c4 04             	add    $0x4,%esp
    299f:	eb 2a                	jmp    29cb <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    29a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    29a5:	50                   	push   %eax
    29a6:	e8 8c fc ff ff       	call   2637 <matchwhitespace>
    29ab:	83 c4 04             	add    $0x4,%esp
    29ae:	85 c0                	test   %eax,%eax
    29b0:	0f 94 c0             	sete   %al
    29b3:	0f b6 c0             	movzbl %al,%eax
    29b6:	eb 13                	jmp    29cb <matchone+0xe8>
    default:             return  (p.ch == c);
    29b8:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    29bc:	0f b6 d0             	movzbl %al,%edx
    29bf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    29c3:	39 c2                	cmp    %eax,%edx
    29c5:	0f 94 c0             	sete   %al
    29c8:	0f b6 c0             	movzbl %al,%eax
  }
}
    29cb:	c9                   	leave  
    29cc:	c3                   	ret    

000029cd <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    29cd:	55                   	push   %ebp
    29ce:	89 e5                	mov    %esp,%ebp
    29d0:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    29d3:	8b 45 18             	mov    0x18(%ebp),%eax
    29d6:	8b 00                	mov    (%eax),%eax
    29d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    29db:	8b 45 14             	mov    0x14(%ebp),%eax
    29de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    29e1:	eb 11                	jmp    29f4 <matchstar+0x27>
  {
    text++;
    29e3:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    29e7:	8b 45 18             	mov    0x18(%ebp),%eax
    29ea:	8b 00                	mov    (%eax),%eax
    29ec:	8d 50 01             	lea    0x1(%eax),%edx
    29ef:	8b 45 18             	mov    0x18(%ebp),%eax
    29f2:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    29f4:	8b 45 14             	mov    0x14(%ebp),%eax
    29f7:	0f b6 00             	movzbl (%eax),%eax
    29fa:	84 c0                	test   %al,%al
    29fc:	74 51                	je     2a4f <matchstar+0x82>
    29fe:	8b 45 14             	mov    0x14(%ebp),%eax
    2a01:	0f b6 00             	movzbl (%eax),%eax
    2a04:	0f be c0             	movsbl %al,%eax
    2a07:	50                   	push   %eax
    2a08:	ff 75 0c             	pushl  0xc(%ebp)
    2a0b:	ff 75 08             	pushl  0x8(%ebp)
    2a0e:	e8 d0 fe ff ff       	call   28e3 <matchone>
    2a13:	83 c4 0c             	add    $0xc,%esp
    2a16:	85 c0                	test   %eax,%eax
    2a18:	75 c9                	jne    29e3 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    2a1a:	eb 33                	jmp    2a4f <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    2a1c:	8b 45 14             	mov    0x14(%ebp),%eax
    2a1f:	8d 50 ff             	lea    -0x1(%eax),%edx
    2a22:	89 55 14             	mov    %edx,0x14(%ebp)
    2a25:	83 ec 04             	sub    $0x4,%esp
    2a28:	ff 75 18             	pushl  0x18(%ebp)
    2a2b:	50                   	push   %eax
    2a2c:	ff 75 10             	pushl  0x10(%ebp)
    2a2f:	e8 51 01 00 00       	call   2b85 <matchpattern>
    2a34:	83 c4 10             	add    $0x10,%esp
    2a37:	85 c0                	test   %eax,%eax
    2a39:	74 07                	je     2a42 <matchstar+0x75>
      return 1;
    2a3b:	b8 01 00 00 00       	mov    $0x1,%eax
    2a40:	eb 22                	jmp    2a64 <matchstar+0x97>
    (*matchlength)--;
    2a42:	8b 45 18             	mov    0x18(%ebp),%eax
    2a45:	8b 00                	mov    (%eax),%eax
    2a47:	8d 50 ff             	lea    -0x1(%eax),%edx
    2a4a:	8b 45 18             	mov    0x18(%ebp),%eax
    2a4d:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    2a4f:	8b 45 14             	mov    0x14(%ebp),%eax
    2a52:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2a55:	73 c5                	jae    2a1c <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    2a57:	8b 45 18             	mov    0x18(%ebp),%eax
    2a5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2a5d:	89 10                	mov    %edx,(%eax)
  return 0;
    2a5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2a64:	c9                   	leave  
    2a65:	c3                   	ret    

00002a66 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    2a66:	55                   	push   %ebp
    2a67:	89 e5                	mov    %esp,%ebp
    2a69:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    2a6c:	8b 45 14             	mov    0x14(%ebp),%eax
    2a6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    2a72:	eb 11                	jmp    2a85 <matchplus+0x1f>
  {
    text++;
    2a74:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    2a78:	8b 45 18             	mov    0x18(%ebp),%eax
    2a7b:	8b 00                	mov    (%eax),%eax
    2a7d:	8d 50 01             	lea    0x1(%eax),%edx
    2a80:	8b 45 18             	mov    0x18(%ebp),%eax
    2a83:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    2a85:	8b 45 14             	mov    0x14(%ebp),%eax
    2a88:	0f b6 00             	movzbl (%eax),%eax
    2a8b:	84 c0                	test   %al,%al
    2a8d:	74 51                	je     2ae0 <matchplus+0x7a>
    2a8f:	8b 45 14             	mov    0x14(%ebp),%eax
    2a92:	0f b6 00             	movzbl (%eax),%eax
    2a95:	0f be c0             	movsbl %al,%eax
    2a98:	50                   	push   %eax
    2a99:	ff 75 0c             	pushl  0xc(%ebp)
    2a9c:	ff 75 08             	pushl  0x8(%ebp)
    2a9f:	e8 3f fe ff ff       	call   28e3 <matchone>
    2aa4:	83 c4 0c             	add    $0xc,%esp
    2aa7:	85 c0                	test   %eax,%eax
    2aa9:	75 c9                	jne    2a74 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    2aab:	eb 33                	jmp    2ae0 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    2aad:	8b 45 14             	mov    0x14(%ebp),%eax
    2ab0:	8d 50 ff             	lea    -0x1(%eax),%edx
    2ab3:	89 55 14             	mov    %edx,0x14(%ebp)
    2ab6:	83 ec 04             	sub    $0x4,%esp
    2ab9:	ff 75 18             	pushl  0x18(%ebp)
    2abc:	50                   	push   %eax
    2abd:	ff 75 10             	pushl  0x10(%ebp)
    2ac0:	e8 c0 00 00 00       	call   2b85 <matchpattern>
    2ac5:	83 c4 10             	add    $0x10,%esp
    2ac8:	85 c0                	test   %eax,%eax
    2aca:	74 07                	je     2ad3 <matchplus+0x6d>
      return 1;
    2acc:	b8 01 00 00 00       	mov    $0x1,%eax
    2ad1:	eb 1a                	jmp    2aed <matchplus+0x87>
    (*matchlength)--;
    2ad3:	8b 45 18             	mov    0x18(%ebp),%eax
    2ad6:	8b 00                	mov    (%eax),%eax
    2ad8:	8d 50 ff             	lea    -0x1(%eax),%edx
    2adb:	8b 45 18             	mov    0x18(%ebp),%eax
    2ade:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    2ae0:	8b 45 14             	mov    0x14(%ebp),%eax
    2ae3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2ae6:	77 c5                	ja     2aad <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    2ae8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2aed:	c9                   	leave  
    2aee:	c3                   	ret    

00002aef <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    2aef:	55                   	push   %ebp
    2af0:	89 e5                	mov    %esp,%ebp
    2af2:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    2af5:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    2af9:	84 c0                	test   %al,%al
    2afb:	75 07                	jne    2b04 <matchquestion+0x15>
    return 1;
    2afd:	b8 01 00 00 00       	mov    $0x1,%eax
    2b02:	eb 7f                	jmp    2b83 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    2b04:	83 ec 04             	sub    $0x4,%esp
    2b07:	ff 75 18             	pushl  0x18(%ebp)
    2b0a:	ff 75 14             	pushl  0x14(%ebp)
    2b0d:	ff 75 10             	pushl  0x10(%ebp)
    2b10:	e8 70 00 00 00       	call   2b85 <matchpattern>
    2b15:	83 c4 10             	add    $0x10,%esp
    2b18:	85 c0                	test   %eax,%eax
    2b1a:	74 07                	je     2b23 <matchquestion+0x34>
      return 1;
    2b1c:	b8 01 00 00 00       	mov    $0x1,%eax
    2b21:	eb 60                	jmp    2b83 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    2b23:	8b 45 14             	mov    0x14(%ebp),%eax
    2b26:	0f b6 00             	movzbl (%eax),%eax
    2b29:	84 c0                	test   %al,%al
    2b2b:	74 51                	je     2b7e <matchquestion+0x8f>
    2b2d:	8b 45 14             	mov    0x14(%ebp),%eax
    2b30:	8d 50 01             	lea    0x1(%eax),%edx
    2b33:	89 55 14             	mov    %edx,0x14(%ebp)
    2b36:	0f b6 00             	movzbl (%eax),%eax
    2b39:	0f be c0             	movsbl %al,%eax
    2b3c:	83 ec 04             	sub    $0x4,%esp
    2b3f:	50                   	push   %eax
    2b40:	ff 75 0c             	pushl  0xc(%ebp)
    2b43:	ff 75 08             	pushl  0x8(%ebp)
    2b46:	e8 98 fd ff ff       	call   28e3 <matchone>
    2b4b:	83 c4 10             	add    $0x10,%esp
    2b4e:	85 c0                	test   %eax,%eax
    2b50:	74 2c                	je     2b7e <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    2b52:	83 ec 04             	sub    $0x4,%esp
    2b55:	ff 75 18             	pushl  0x18(%ebp)
    2b58:	ff 75 14             	pushl  0x14(%ebp)
    2b5b:	ff 75 10             	pushl  0x10(%ebp)
    2b5e:	e8 22 00 00 00       	call   2b85 <matchpattern>
    2b63:	83 c4 10             	add    $0x10,%esp
    2b66:	85 c0                	test   %eax,%eax
    2b68:	74 14                	je     2b7e <matchquestion+0x8f>
    {
      (*matchlength)++;
    2b6a:	8b 45 18             	mov    0x18(%ebp),%eax
    2b6d:	8b 00                	mov    (%eax),%eax
    2b6f:	8d 50 01             	lea    0x1(%eax),%edx
    2b72:	8b 45 18             	mov    0x18(%ebp),%eax
    2b75:	89 10                	mov    %edx,(%eax)
      return 1;
    2b77:	b8 01 00 00 00       	mov    $0x1,%eax
    2b7c:	eb 05                	jmp    2b83 <matchquestion+0x94>
    }
  }
  return 0;
    2b7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2b83:	c9                   	leave  
    2b84:	c3                   	ret    

00002b85 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    2b85:	55                   	push   %ebp
    2b86:	89 e5                	mov    %esp,%ebp
    2b88:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    2b8b:	8b 45 10             	mov    0x10(%ebp),%eax
    2b8e:	8b 00                	mov    (%eax),%eax
    2b90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    2b93:	8b 45 08             	mov    0x8(%ebp),%eax
    2b96:	0f b6 00             	movzbl (%eax),%eax
    2b99:	84 c0                	test   %al,%al
    2b9b:	74 0d                	je     2baa <matchpattern+0x25>
    2b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    2ba0:	83 c0 08             	add    $0x8,%eax
    2ba3:	0f b6 00             	movzbl (%eax),%eax
    2ba6:	3c 04                	cmp    $0x4,%al
    2ba8:	75 25                	jne    2bcf <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    2baa:	8b 45 08             	mov    0x8(%ebp),%eax
    2bad:	83 c0 10             	add    $0x10,%eax
    2bb0:	83 ec 0c             	sub    $0xc,%esp
    2bb3:	ff 75 10             	pushl  0x10(%ebp)
    2bb6:	ff 75 0c             	pushl  0xc(%ebp)
    2bb9:	50                   	push   %eax
    2bba:	8b 45 08             	mov    0x8(%ebp),%eax
    2bbd:	ff 70 04             	pushl  0x4(%eax)
    2bc0:	ff 30                	pushl  (%eax)
    2bc2:	e8 28 ff ff ff       	call   2aef <matchquestion>
    2bc7:	83 c4 20             	add    $0x20,%esp
    2bca:	e9 dd 00 00 00       	jmp    2cac <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    2bcf:	8b 45 08             	mov    0x8(%ebp),%eax
    2bd2:	83 c0 08             	add    $0x8,%eax
    2bd5:	0f b6 00             	movzbl (%eax),%eax
    2bd8:	3c 05                	cmp    $0x5,%al
    2bda:	75 25                	jne    2c01 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    2bdc:	8b 45 08             	mov    0x8(%ebp),%eax
    2bdf:	83 c0 10             	add    $0x10,%eax
    2be2:	83 ec 0c             	sub    $0xc,%esp
    2be5:	ff 75 10             	pushl  0x10(%ebp)
    2be8:	ff 75 0c             	pushl  0xc(%ebp)
    2beb:	50                   	push   %eax
    2bec:	8b 45 08             	mov    0x8(%ebp),%eax
    2bef:	ff 70 04             	pushl  0x4(%eax)
    2bf2:	ff 30                	pushl  (%eax)
    2bf4:	e8 d4 fd ff ff       	call   29cd <matchstar>
    2bf9:	83 c4 20             	add    $0x20,%esp
    2bfc:	e9 ab 00 00 00       	jmp    2cac <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    2c01:	8b 45 08             	mov    0x8(%ebp),%eax
    2c04:	83 c0 08             	add    $0x8,%eax
    2c07:	0f b6 00             	movzbl (%eax),%eax
    2c0a:	3c 06                	cmp    $0x6,%al
    2c0c:	75 22                	jne    2c30 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    2c0e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c11:	83 c0 10             	add    $0x10,%eax
    2c14:	83 ec 0c             	sub    $0xc,%esp
    2c17:	ff 75 10             	pushl  0x10(%ebp)
    2c1a:	ff 75 0c             	pushl  0xc(%ebp)
    2c1d:	50                   	push   %eax
    2c1e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c21:	ff 70 04             	pushl  0x4(%eax)
    2c24:	ff 30                	pushl  (%eax)
    2c26:	e8 3b fe ff ff       	call   2a66 <matchplus>
    2c2b:	83 c4 20             	add    $0x20,%esp
    2c2e:	eb 7c                	jmp    2cac <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    2c30:	8b 45 08             	mov    0x8(%ebp),%eax
    2c33:	0f b6 00             	movzbl (%eax),%eax
    2c36:	3c 03                	cmp    $0x3,%al
    2c38:	75 1d                	jne    2c57 <matchpattern+0xd2>
    2c3a:	8b 45 08             	mov    0x8(%ebp),%eax
    2c3d:	83 c0 08             	add    $0x8,%eax
    2c40:	0f b6 00             	movzbl (%eax),%eax
    2c43:	84 c0                	test   %al,%al
    2c45:	75 10                	jne    2c57 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    2c47:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c4a:	0f b6 00             	movzbl (%eax),%eax
    2c4d:	84 c0                	test   %al,%al
    2c4f:	0f 94 c0             	sete   %al
    2c52:	0f b6 c0             	movzbl %al,%eax
    2c55:	eb 55                	jmp    2cac <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    2c57:	8b 45 10             	mov    0x10(%ebp),%eax
    2c5a:	8b 00                	mov    (%eax),%eax
    2c5c:	8d 50 01             	lea    0x1(%eax),%edx
    2c5f:	8b 45 10             	mov    0x10(%ebp),%eax
    2c62:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    2c64:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c67:	0f b6 00             	movzbl (%eax),%eax
    2c6a:	84 c0                	test   %al,%al
    2c6c:	74 31                	je     2c9f <matchpattern+0x11a>
    2c6e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c71:	8d 50 01             	lea    0x1(%eax),%edx
    2c74:	89 55 0c             	mov    %edx,0xc(%ebp)
    2c77:	0f b6 00             	movzbl (%eax),%eax
    2c7a:	0f be d0             	movsbl %al,%edx
    2c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    2c80:	8d 48 08             	lea    0x8(%eax),%ecx
    2c83:	89 4d 08             	mov    %ecx,0x8(%ebp)
    2c86:	83 ec 04             	sub    $0x4,%esp
    2c89:	52                   	push   %edx
    2c8a:	ff 70 04             	pushl  0x4(%eax)
    2c8d:	ff 30                	pushl  (%eax)
    2c8f:	e8 4f fc ff ff       	call   28e3 <matchone>
    2c94:	83 c4 10             	add    $0x10,%esp
    2c97:	85 c0                	test   %eax,%eax
    2c99:	0f 85 f4 fe ff ff    	jne    2b93 <matchpattern+0xe>

  *matchlength = pre;
    2c9f:	8b 45 10             	mov    0x10(%ebp),%eax
    2ca2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2ca5:	89 10                	mov    %edx,(%eax)
  return 0;
    2ca7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2cac:	c9                   	leave  
    2cad:	c3                   	ret    
