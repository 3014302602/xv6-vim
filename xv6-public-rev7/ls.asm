
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       7:	83 ec 0c             	sub    $0xc,%esp
       a:	ff 75 08             	pushl  0x8(%ebp)
       d:	e8 c9 03 00 00       	call   3db <strlen>
      12:	83 c4 10             	add    $0x10,%esp
      15:	89 c2                	mov    %eax,%edx
      17:	8b 45 08             	mov    0x8(%ebp),%eax
      1a:	01 d0                	add    %edx,%eax
      1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      1f:	eb 04                	jmp    25 <fmtname+0x25>
      21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      25:	8b 45 f4             	mov    -0xc(%ebp),%eax
      28:	3b 45 08             	cmp    0x8(%ebp),%eax
      2b:	72 0a                	jb     37 <fmtname+0x37>
      2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      30:	0f b6 00             	movzbl (%eax),%eax
      33:	3c 2f                	cmp    $0x2f,%al
      35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
      37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      3b:	83 ec 0c             	sub    $0xc,%esp
      3e:	ff 75 f4             	pushl  -0xc(%ebp)
      41:	e8 95 03 00 00       	call   3db <strlen>
      46:	83 c4 10             	add    $0x10,%esp
      49:	83 f8 0d             	cmp    $0xd,%eax
      4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
      4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
      51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
      53:	83 ec 0c             	sub    $0xc,%esp
      56:	ff 75 f4             	pushl  -0xc(%ebp)
      59:	e8 7d 03 00 00       	call   3db <strlen>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	83 ec 04             	sub    $0x4,%esp
      64:	50                   	push   %eax
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	68 40 1d 00 00       	push   $0x1d40
      6d:	e8 e6 04 00 00       	call   558 <memmove>
      72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      75:	83 ec 0c             	sub    $0xc,%esp
      78:	ff 75 f4             	pushl  -0xc(%ebp)
      7b:	e8 5b 03 00 00       	call   3db <strlen>
      80:	83 c4 10             	add    $0x10,%esp
      83:	ba 0e 00 00 00       	mov    $0xe,%edx
      88:	89 d3                	mov    %edx,%ebx
      8a:	29 c3                	sub    %eax,%ebx
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	ff 75 f4             	pushl  -0xc(%ebp)
      92:	e8 44 03 00 00       	call   3db <strlen>
      97:	83 c4 10             	add    $0x10,%esp
      9a:	05 40 1d 00 00       	add    $0x1d40,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 40 1d 00 00       	mov    $0x1d40,%eax
}
      b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      b6:	c9                   	leave  
      b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
      b8:	55                   	push   %ebp
      b9:	89 e5                	mov    %esp,%ebp
      bb:	57                   	push   %edi
      bc:	56                   	push   %esi
      bd:	53                   	push   %ebx
      be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
      c4:	83 ec 08             	sub    $0x8,%esp
      c7:	6a 00                	push   $0x0
      c9:	ff 75 08             	pushl  0x8(%ebp)
      cc:	e8 0c 05 00 00       	call   5dd <open>
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
      dd:	83 ec 04             	sub    $0x4,%esp
      e0:	ff 75 08             	pushl  0x8(%ebp)
      e3:	68 60 15 00 00       	push   $0x1560
      e8:	6a 02                	push   $0x2
      ea:	e8 85 06 00 00       	call   774 <printf>
      ef:	83 c4 10             	add    $0x10,%esp
    return;
      f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
      f7:	83 ec 08             	sub    $0x8,%esp
      fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     100:	50                   	push   %eax
     101:	ff 75 e4             	pushl  -0x1c(%ebp)
     104:	e8 ec 04 00 00       	call   5f5 <fstat>
     109:	83 c4 10             	add    $0x10,%esp
     10c:	85 c0                	test   %eax,%eax
     10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
     110:	83 ec 04             	sub    $0x4,%esp
     113:	ff 75 08             	pushl  0x8(%ebp)
     116:	68 74 15 00 00       	push   $0x1574
     11b:	6a 02                	push   $0x2
     11d:	e8 52 06 00 00       	call   774 <printf>
     122:	83 c4 10             	add    $0x10,%esp
    close(fd);
     125:	83 ec 0c             	sub    $0xc,%esp
     128:	ff 75 e4             	pushl  -0x1c(%ebp)
     12b:	e8 95 04 00 00       	call   5c5 <close>
     130:	83 c4 10             	add    $0x10,%esp
    return;
     133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }
  
  switch(st.type){
     138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     13f:	98                   	cwtl   
     140:	83 f8 01             	cmp    $0x1,%eax
     143:	74 48                	je     18d <ls+0xd5>
     145:	83 f8 02             	cmp    $0x2,%eax
     148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     161:	0f bf d8             	movswl %ax,%ebx
     164:	83 ec 0c             	sub    $0xc,%esp
     167:	ff 75 08             	pushl  0x8(%ebp)
     16a:	e8 91 fe ff ff       	call   0 <fmtname>
     16f:	83 c4 10             	add    $0x10,%esp
     172:	83 ec 08             	sub    $0x8,%esp
     175:	57                   	push   %edi
     176:	56                   	push   %esi
     177:	53                   	push   %ebx
     178:	50                   	push   %eax
     179:	68 88 15 00 00       	push   $0x1588
     17e:	6a 01                	push   $0x1
     180:	e8 ef 05 00 00       	call   774 <printf>
     185:	83 c4 20             	add    $0x20,%esp
    break;
     188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     18d:	83 ec 0c             	sub    $0xc,%esp
     190:	ff 75 08             	pushl  0x8(%ebp)
     193:	e8 43 02 00 00       	call   3db <strlen>
     198:	83 c4 10             	add    $0x10,%esp
     19b:	83 c0 10             	add    $0x10,%eax
     19e:	3d 00 02 00 00       	cmp    $0x200,%eax
     1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 95 15 00 00       	push   $0x1595
     1ad:	6a 01                	push   $0x1
     1af:	e8 c0 05 00 00       	call   774 <printf>
     1b4:	83 c4 10             	add    $0x10,%esp
      break;
     1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
     1bc:	83 ec 08             	sub    $0x8,%esp
     1bf:	ff 75 08             	pushl  0x8(%ebp)
     1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1c8:	50                   	push   %eax
     1c9:	e8 9e 01 00 00       	call   36c <strcpy>
     1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
     1d1:	83 ec 0c             	sub    $0xc,%esp
     1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1da:	50                   	push   %eax
     1db:	e8 fb 01 00 00       	call   3db <strlen>
     1e0:	83 c4 10             	add    $0x10,%esp
     1e3:	89 c2                	mov    %eax,%edx
     1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1eb:	01 d0                	add    %edx,%eax
     1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
     1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1f3:	8d 50 01             	lea    0x1(%eax),%edx
     1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
     1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
     201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     208:	66 85 c0             	test   %ax,%ax
     20b:	75 05                	jne    212 <ls+0x15a>
        continue;
     20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
     212:	83 ec 04             	sub    $0x4,%esp
     215:	6a 0e                	push   $0xe
     217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     21d:	83 c0 02             	add    $0x2,%eax
     220:	50                   	push   %eax
     221:	ff 75 e0             	pushl  -0x20(%ebp)
     224:	e8 2f 03 00 00       	call   558 <memmove>
     229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
     22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     22f:	83 c0 0e             	add    $0xe,%eax
     232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     235:	83 ec 08             	sub    $0x8,%esp
     238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     23e:	50                   	push   %eax
     23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     245:	50                   	push   %eax
     246:	e8 73 02 00 00       	call   4be <stat>
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	85 c0                	test   %eax,%eax
     250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
     252:	83 ec 04             	sub    $0x4,%esp
     255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     25b:	50                   	push   %eax
     25c:	68 74 15 00 00       	push   $0x1574
     261:	6a 01                	push   $0x1
     263:	e8 0c 05 00 00       	call   774 <printf>
     268:	83 c4 10             	add    $0x10,%esp
        continue;
     26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     280:	0f bf d8             	movswl %ax,%ebx
     283:	83 ec 0c             	sub    $0xc,%esp
     286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     28c:	50                   	push   %eax
     28d:	e8 6e fd ff ff       	call   0 <fmtname>
     292:	83 c4 10             	add    $0x10,%esp
     295:	83 ec 08             	sub    $0x8,%esp
     298:	57                   	push   %edi
     299:	56                   	push   %esi
     29a:	53                   	push   %ebx
     29b:	50                   	push   %eax
     29c:	68 88 15 00 00       	push   $0x1588
     2a1:	6a 01                	push   $0x1
     2a3:	e8 cc 04 00 00       	call   774 <printf>
     2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2ab:	83 ec 04             	sub    $0x4,%esp
     2ae:	6a 10                	push   $0x10
     2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     2b6:	50                   	push   %eax
     2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
     2ba:	e8 f6 02 00 00       	call   5b5 <read>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	83 f8 10             	cmp    $0x10,%eax
     2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
     2cb:	90                   	nop
  }
  close(fd);
     2cc:	83 ec 0c             	sub    $0xc,%esp
     2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
     2d2:	e8 ee 02 00 00       	call   5c5 <close>
     2d7:	83 c4 10             	add    $0x10,%esp
}
     2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2dd:	5b                   	pop    %ebx
     2de:	5e                   	pop    %esi
     2df:	5f                   	pop    %edi
     2e0:	5d                   	pop    %ebp
     2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
     2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2e6:	83 e4 f0             	and    $0xfffffff0,%esp
     2e9:	ff 71 fc             	pushl  -0x4(%ecx)
     2ec:	55                   	push   %ebp
     2ed:	89 e5                	mov    %esp,%ebp
     2ef:	53                   	push   %ebx
     2f0:	51                   	push   %ecx
     2f1:	83 ec 10             	sub    $0x10,%esp
     2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
     2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
     2f9:	7f 15                	jg     310 <main+0x2e>
    ls(".");
     2fb:	83 ec 0c             	sub    $0xc,%esp
     2fe:	68 a8 15 00 00       	push   $0x15a8
     303:	e8 b0 fd ff ff       	call   b8 <ls>
     308:	83 c4 10             	add    $0x10,%esp
    exit();
     30b:	e8 8d 02 00 00       	call   59d <exit>
  }
  for(i=1; i<argc; i++)
     310:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     317:	eb 21                	jmp    33a <main+0x58>
    ls(argv[i]);
     319:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     323:	8b 43 04             	mov    0x4(%ebx),%eax
     326:	01 d0                	add    %edx,%eax
     328:	8b 00                	mov    (%eax),%eax
     32a:	83 ec 0c             	sub    $0xc,%esp
     32d:	50                   	push   %eax
     32e:	e8 85 fd ff ff       	call   b8 <ls>
     333:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
     336:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     33a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33d:	3b 03                	cmp    (%ebx),%eax
     33f:	7c d8                	jl     319 <main+0x37>
    ls(argv[i]);
  exit();
     341:	e8 57 02 00 00       	call   59d <exit>

00000346 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     346:	55                   	push   %ebp
     347:	89 e5                	mov    %esp,%ebp
     349:	57                   	push   %edi
     34a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     34e:	8b 55 10             	mov    0x10(%ebp),%edx
     351:	8b 45 0c             	mov    0xc(%ebp),%eax
     354:	89 cb                	mov    %ecx,%ebx
     356:	89 df                	mov    %ebx,%edi
     358:	89 d1                	mov    %edx,%ecx
     35a:	fc                   	cld    
     35b:	f3 aa                	rep stos %al,%es:(%edi)
     35d:	89 ca                	mov    %ecx,%edx
     35f:	89 fb                	mov    %edi,%ebx
     361:	89 5d 08             	mov    %ebx,0x8(%ebp)
     364:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     367:	90                   	nop
     368:	5b                   	pop    %ebx
     369:	5f                   	pop    %edi
     36a:	5d                   	pop    %ebp
     36b:	c3                   	ret    

0000036c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     36c:	55                   	push   %ebp
     36d:	89 e5                	mov    %esp,%ebp
     36f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     372:	8b 45 08             	mov    0x8(%ebp),%eax
     375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     378:	90                   	nop
     379:	8b 45 08             	mov    0x8(%ebp),%eax
     37c:	8d 50 01             	lea    0x1(%eax),%edx
     37f:	89 55 08             	mov    %edx,0x8(%ebp)
     382:	8b 55 0c             	mov    0xc(%ebp),%edx
     385:	8d 4a 01             	lea    0x1(%edx),%ecx
     388:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     38b:	0f b6 12             	movzbl (%edx),%edx
     38e:	88 10                	mov    %dl,(%eax)
     390:	0f b6 00             	movzbl (%eax),%eax
     393:	84 c0                	test   %al,%al
     395:	75 e2                	jne    379 <strcpy+0xd>
    ;
  return os;
     397:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     39a:	c9                   	leave  
     39b:	c3                   	ret    

0000039c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     39f:	eb 08                	jmp    3a9 <strcmp+0xd>
    p++, q++;
     3a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     3a9:	8b 45 08             	mov    0x8(%ebp),%eax
     3ac:	0f b6 00             	movzbl (%eax),%eax
     3af:	84 c0                	test   %al,%al
     3b1:	74 10                	je     3c3 <strcmp+0x27>
     3b3:	8b 45 08             	mov    0x8(%ebp),%eax
     3b6:	0f b6 10             	movzbl (%eax),%edx
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	0f b6 00             	movzbl (%eax),%eax
     3bf:	38 c2                	cmp    %al,%dl
     3c1:	74 de                	je     3a1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     3c3:	8b 45 08             	mov    0x8(%ebp),%eax
     3c6:	0f b6 00             	movzbl (%eax),%eax
     3c9:	0f b6 d0             	movzbl %al,%edx
     3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cf:	0f b6 00             	movzbl (%eax),%eax
     3d2:	0f b6 c0             	movzbl %al,%eax
     3d5:	29 c2                	sub    %eax,%edx
     3d7:	89 d0                	mov    %edx,%eax
}
     3d9:	5d                   	pop    %ebp
     3da:	c3                   	ret    

000003db <strlen>:

uint
strlen(char *s)
{
     3db:	55                   	push   %ebp
     3dc:	89 e5                	mov    %esp,%ebp
     3de:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3e8:	eb 04                	jmp    3ee <strlen+0x13>
     3ea:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3f1:	8b 45 08             	mov    0x8(%ebp),%eax
     3f4:	01 d0                	add    %edx,%eax
     3f6:	0f b6 00             	movzbl (%eax),%eax
     3f9:	84 c0                	test   %al,%al
     3fb:	75 ed                	jne    3ea <strlen+0xf>
    ;
  return n;
     3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     400:	c9                   	leave  
     401:	c3                   	ret    

00000402 <memset>:

void*
memset(void *dst, int c, uint n)
{
     402:	55                   	push   %ebp
     403:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     405:	8b 45 10             	mov    0x10(%ebp),%eax
     408:	50                   	push   %eax
     409:	ff 75 0c             	pushl  0xc(%ebp)
     40c:	ff 75 08             	pushl  0x8(%ebp)
     40f:	e8 32 ff ff ff       	call   346 <stosb>
     414:	83 c4 0c             	add    $0xc,%esp
  return dst;
     417:	8b 45 08             	mov    0x8(%ebp),%eax
}
     41a:	c9                   	leave  
     41b:	c3                   	ret    

0000041c <strchr>:

char*
strchr(const char *s, char c)
{
     41c:	55                   	push   %ebp
     41d:	89 e5                	mov    %esp,%ebp
     41f:	83 ec 04             	sub    $0x4,%esp
     422:	8b 45 0c             	mov    0xc(%ebp),%eax
     425:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     428:	eb 14                	jmp    43e <strchr+0x22>
    if(*s == c)
     42a:	8b 45 08             	mov    0x8(%ebp),%eax
     42d:	0f b6 00             	movzbl (%eax),%eax
     430:	3a 45 fc             	cmp    -0x4(%ebp),%al
     433:	75 05                	jne    43a <strchr+0x1e>
      return (char*)s;
     435:	8b 45 08             	mov    0x8(%ebp),%eax
     438:	eb 13                	jmp    44d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     43a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     43e:	8b 45 08             	mov    0x8(%ebp),%eax
     441:	0f b6 00             	movzbl (%eax),%eax
     444:	84 c0                	test   %al,%al
     446:	75 e2                	jne    42a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     448:	b8 00 00 00 00       	mov    $0x0,%eax
}
     44d:	c9                   	leave  
     44e:	c3                   	ret    

0000044f <gets>:

char*
gets(char *buf, int max)
{
     44f:	55                   	push   %ebp
     450:	89 e5                	mov    %esp,%ebp
     452:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     45c:	eb 42                	jmp    4a0 <gets+0x51>
    cc = read(0, &c, 1);
     45e:	83 ec 04             	sub    $0x4,%esp
     461:	6a 01                	push   $0x1
     463:	8d 45 ef             	lea    -0x11(%ebp),%eax
     466:	50                   	push   %eax
     467:	6a 00                	push   $0x0
     469:	e8 47 01 00 00       	call   5b5 <read>
     46e:	83 c4 10             	add    $0x10,%esp
     471:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     474:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     478:	7e 33                	jle    4ad <gets+0x5e>
      break;
    buf[i++] = c;
     47a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47d:	8d 50 01             	lea    0x1(%eax),%edx
     480:	89 55 f4             	mov    %edx,-0xc(%ebp)
     483:	89 c2                	mov    %eax,%edx
     485:	8b 45 08             	mov    0x8(%ebp),%eax
     488:	01 c2                	add    %eax,%edx
     48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     48e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     490:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     494:	3c 0a                	cmp    $0xa,%al
     496:	74 16                	je     4ae <gets+0x5f>
     498:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     49c:	3c 0d                	cmp    $0xd,%al
     49e:	74 0e                	je     4ae <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a3:	83 c0 01             	add    $0x1,%eax
     4a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     4a9:	7c b3                	jl     45e <gets+0xf>
     4ab:	eb 01                	jmp    4ae <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     4ad:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     4ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4b1:	8b 45 08             	mov    0x8(%ebp),%eax
     4b4:	01 d0                	add    %edx,%eax
     4b6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4bc:	c9                   	leave  
     4bd:	c3                   	ret    

000004be <stat>:

int
stat(char *n, struct stat *st)
{
     4be:	55                   	push   %ebp
     4bf:	89 e5                	mov    %esp,%ebp
     4c1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	6a 00                	push   $0x0
     4c9:	ff 75 08             	pushl  0x8(%ebp)
     4cc:	e8 0c 01 00 00       	call   5dd <open>
     4d1:	83 c4 10             	add    $0x10,%esp
     4d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     4d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4db:	79 07                	jns    4e4 <stat+0x26>
    return -1;
     4dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4e2:	eb 25                	jmp    509 <stat+0x4b>
  r = fstat(fd, st);
     4e4:	83 ec 08             	sub    $0x8,%esp
     4e7:	ff 75 0c             	pushl  0xc(%ebp)
     4ea:	ff 75 f4             	pushl  -0xc(%ebp)
     4ed:	e8 03 01 00 00       	call   5f5 <fstat>
     4f2:	83 c4 10             	add    $0x10,%esp
     4f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     4f8:	83 ec 0c             	sub    $0xc,%esp
     4fb:	ff 75 f4             	pushl  -0xc(%ebp)
     4fe:	e8 c2 00 00 00       	call   5c5 <close>
     503:	83 c4 10             	add    $0x10,%esp
  return r;
     506:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     509:	c9                   	leave  
     50a:	c3                   	ret    

0000050b <atoi>:

int
atoi(const char *s)
{
     50b:	55                   	push   %ebp
     50c:	89 e5                	mov    %esp,%ebp
     50e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     518:	eb 25                	jmp    53f <atoi+0x34>
    n = n*10 + *s++ - '0';
     51a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     51d:	89 d0                	mov    %edx,%eax
     51f:	c1 e0 02             	shl    $0x2,%eax
     522:	01 d0                	add    %edx,%eax
     524:	01 c0                	add    %eax,%eax
     526:	89 c1                	mov    %eax,%ecx
     528:	8b 45 08             	mov    0x8(%ebp),%eax
     52b:	8d 50 01             	lea    0x1(%eax),%edx
     52e:	89 55 08             	mov    %edx,0x8(%ebp)
     531:	0f b6 00             	movzbl (%eax),%eax
     534:	0f be c0             	movsbl %al,%eax
     537:	01 c8                	add    %ecx,%eax
     539:	83 e8 30             	sub    $0x30,%eax
     53c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     53f:	8b 45 08             	mov    0x8(%ebp),%eax
     542:	0f b6 00             	movzbl (%eax),%eax
     545:	3c 2f                	cmp    $0x2f,%al
     547:	7e 0a                	jle    553 <atoi+0x48>
     549:	8b 45 08             	mov    0x8(%ebp),%eax
     54c:	0f b6 00             	movzbl (%eax),%eax
     54f:	3c 39                	cmp    $0x39,%al
     551:	7e c7                	jle    51a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     553:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     556:	c9                   	leave  
     557:	c3                   	ret    

00000558 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     558:	55                   	push   %ebp
     559:	89 e5                	mov    %esp,%ebp
     55b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     55e:	8b 45 08             	mov    0x8(%ebp),%eax
     561:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     564:	8b 45 0c             	mov    0xc(%ebp),%eax
     567:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     56a:	eb 17                	jmp    583 <memmove+0x2b>
    *dst++ = *src++;
     56c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     56f:	8d 50 01             	lea    0x1(%eax),%edx
     572:	89 55 fc             	mov    %edx,-0x4(%ebp)
     575:	8b 55 f8             	mov    -0x8(%ebp),%edx
     578:	8d 4a 01             	lea    0x1(%edx),%ecx
     57b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     57e:	0f b6 12             	movzbl (%edx),%edx
     581:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     583:	8b 45 10             	mov    0x10(%ebp),%eax
     586:	8d 50 ff             	lea    -0x1(%eax),%edx
     589:	89 55 10             	mov    %edx,0x10(%ebp)
     58c:	85 c0                	test   %eax,%eax
     58e:	7f dc                	jg     56c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     590:	8b 45 08             	mov    0x8(%ebp),%eax
}
     593:	c9                   	leave  
     594:	c3                   	ret    

00000595 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     595:	b8 01 00 00 00       	mov    $0x1,%eax
     59a:	cd 40                	int    $0x40
     59c:	c3                   	ret    

0000059d <exit>:
SYSCALL(exit)
     59d:	b8 02 00 00 00       	mov    $0x2,%eax
     5a2:	cd 40                	int    $0x40
     5a4:	c3                   	ret    

000005a5 <wait>:
SYSCALL(wait)
     5a5:	b8 03 00 00 00       	mov    $0x3,%eax
     5aa:	cd 40                	int    $0x40
     5ac:	c3                   	ret    

000005ad <pipe>:
SYSCALL(pipe)
     5ad:	b8 04 00 00 00       	mov    $0x4,%eax
     5b2:	cd 40                	int    $0x40
     5b4:	c3                   	ret    

000005b5 <read>:
SYSCALL(read)
     5b5:	b8 05 00 00 00       	mov    $0x5,%eax
     5ba:	cd 40                	int    $0x40
     5bc:	c3                   	ret    

000005bd <write>:
SYSCALL(write)
     5bd:	b8 10 00 00 00       	mov    $0x10,%eax
     5c2:	cd 40                	int    $0x40
     5c4:	c3                   	ret    

000005c5 <close>:
SYSCALL(close)
     5c5:	b8 15 00 00 00       	mov    $0x15,%eax
     5ca:	cd 40                	int    $0x40
     5cc:	c3                   	ret    

000005cd <kill>:
SYSCALL(kill)
     5cd:	b8 06 00 00 00       	mov    $0x6,%eax
     5d2:	cd 40                	int    $0x40
     5d4:	c3                   	ret    

000005d5 <exec>:
SYSCALL(exec)
     5d5:	b8 07 00 00 00       	mov    $0x7,%eax
     5da:	cd 40                	int    $0x40
     5dc:	c3                   	ret    

000005dd <open>:
SYSCALL(open)
     5dd:	b8 0f 00 00 00       	mov    $0xf,%eax
     5e2:	cd 40                	int    $0x40
     5e4:	c3                   	ret    

000005e5 <mknod>:
SYSCALL(mknod)
     5e5:	b8 11 00 00 00       	mov    $0x11,%eax
     5ea:	cd 40                	int    $0x40
     5ec:	c3                   	ret    

000005ed <unlink>:
SYSCALL(unlink)
     5ed:	b8 12 00 00 00       	mov    $0x12,%eax
     5f2:	cd 40                	int    $0x40
     5f4:	c3                   	ret    

000005f5 <fstat>:
SYSCALL(fstat)
     5f5:	b8 08 00 00 00       	mov    $0x8,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <link>:
SYSCALL(link)
     5fd:	b8 13 00 00 00       	mov    $0x13,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <mkdir>:
SYSCALL(mkdir)
     605:	b8 14 00 00 00       	mov    $0x14,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <chdir>:
SYSCALL(chdir)
     60d:	b8 09 00 00 00       	mov    $0x9,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <dup>:
SYSCALL(dup)
     615:	b8 0a 00 00 00       	mov    $0xa,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <getpid>:
SYSCALL(getpid)
     61d:	b8 0b 00 00 00       	mov    $0xb,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <sbrk>:
SYSCALL(sbrk)
     625:	b8 0c 00 00 00       	mov    $0xc,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <sleep>:
SYSCALL(sleep)
     62d:	b8 0d 00 00 00       	mov    $0xd,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <uptime>:
SYSCALL(uptime)
     635:	b8 0e 00 00 00       	mov    $0xe,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <setCursorPos>:


//add
SYSCALL(setCursorPos)
     63d:	b8 16 00 00 00       	mov    $0x16,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     645:	b8 17 00 00 00       	mov    $0x17,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <clearScreen>:
SYSCALL(clearScreen)
     64d:	b8 18 00 00 00       	mov    $0x18,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <writeAt>:
SYSCALL(writeAt)
     655:	b8 19 00 00 00       	mov    $0x19,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <setBufferFlag>:
SYSCALL(setBufferFlag)
     65d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     665:	b8 1b 00 00 00       	mov    $0x1b,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <getCursorPos>:
SYSCALL(getCursorPos)
     66d:	b8 1c 00 00 00       	mov    $0x1c,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <saveScreen>:
SYSCALL(saveScreen)
     675:	b8 1d 00 00 00       	mov    $0x1d,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <recorverScreen>:
SYSCALL(recorverScreen)
     67d:	b8 1e 00 00 00       	mov    $0x1e,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <ToScreen>:
SYSCALL(ToScreen)
     685:	b8 1f 00 00 00       	mov    $0x1f,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret    

0000068d <getColor>:
SYSCALL(getColor)
     68d:	b8 20 00 00 00       	mov    $0x20,%eax
     692:	cd 40                	int    $0x40
     694:	c3                   	ret    

00000695 <showC>:
SYSCALL(showC)
     695:	b8 21 00 00 00       	mov    $0x21,%eax
     69a:	cd 40                	int    $0x40
     69c:	c3                   	ret    

0000069d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     69d:	55                   	push   %ebp
     69e:	89 e5                	mov    %esp,%ebp
     6a0:	83 ec 18             	sub    $0x18,%esp
     6a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     6a9:	83 ec 04             	sub    $0x4,%esp
     6ac:	6a 01                	push   $0x1
     6ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6b1:	50                   	push   %eax
     6b2:	ff 75 08             	pushl  0x8(%ebp)
     6b5:	e8 03 ff ff ff       	call   5bd <write>
     6ba:	83 c4 10             	add    $0x10,%esp
}
     6bd:	90                   	nop
     6be:	c9                   	leave  
     6bf:	c3                   	ret    

000006c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	53                   	push   %ebx
     6c4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6ce:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6d2:	74 17                	je     6eb <printint+0x2b>
     6d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6d8:	79 11                	jns    6eb <printint+0x2b>
    neg = 1;
     6da:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     6e4:	f7 d8                	neg    %eax
     6e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6e9:	eb 06                	jmp    6f1 <printint+0x31>
  } else {
    x = xx;
     6eb:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6f8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6fb:	8d 41 01             	lea    0x1(%ecx),%eax
     6fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
     701:	8b 5d 10             	mov    0x10(%ebp),%ebx
     704:	8b 45 ec             	mov    -0x14(%ebp),%eax
     707:	ba 00 00 00 00       	mov    $0x0,%edx
     70c:	f7 f3                	div    %ebx
     70e:	89 d0                	mov    %edx,%eax
     710:	0f b6 80 20 1d 00 00 	movzbl 0x1d20(%eax),%eax
     717:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     71b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     71e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     721:	ba 00 00 00 00       	mov    $0x0,%edx
     726:	f7 f3                	div    %ebx
     728:	89 45 ec             	mov    %eax,-0x14(%ebp)
     72b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     72f:	75 c7                	jne    6f8 <printint+0x38>
  if(neg)
     731:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     735:	74 2d                	je     764 <printint+0xa4>
    buf[i++] = '-';
     737:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73a:	8d 50 01             	lea    0x1(%eax),%edx
     73d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     740:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     745:	eb 1d                	jmp    764 <printint+0xa4>
    putc(fd, buf[i]);
     747:	8d 55 dc             	lea    -0x24(%ebp),%edx
     74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74d:	01 d0                	add    %edx,%eax
     74f:	0f b6 00             	movzbl (%eax),%eax
     752:	0f be c0             	movsbl %al,%eax
     755:	83 ec 08             	sub    $0x8,%esp
     758:	50                   	push   %eax
     759:	ff 75 08             	pushl  0x8(%ebp)
     75c:	e8 3c ff ff ff       	call   69d <putc>
     761:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     764:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     76c:	79 d9                	jns    747 <printint+0x87>
    putc(fd, buf[i]);
}
     76e:	90                   	nop
     76f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     772:	c9                   	leave  
     773:	c3                   	ret    

00000774 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     774:	55                   	push   %ebp
     775:	89 e5                	mov    %esp,%ebp
     777:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     77a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     781:	8d 45 0c             	lea    0xc(%ebp),%eax
     784:	83 c0 04             	add    $0x4,%eax
     787:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     78a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     791:	e9 59 01 00 00       	jmp    8ef <printf+0x17b>
    c = fmt[i] & 0xff;
     796:	8b 55 0c             	mov    0xc(%ebp),%edx
     799:	8b 45 f0             	mov    -0x10(%ebp),%eax
     79c:	01 d0                	add    %edx,%eax
     79e:	0f b6 00             	movzbl (%eax),%eax
     7a1:	0f be c0             	movsbl %al,%eax
     7a4:	25 ff 00 00 00       	and    $0xff,%eax
     7a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     7ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7b0:	75 2c                	jne    7de <printf+0x6a>
      if(c == '%'){
     7b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7b6:	75 0c                	jne    7c4 <printf+0x50>
        state = '%';
     7b8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7bf:	e9 27 01 00 00       	jmp    8eb <printf+0x177>
      } else {
        putc(fd, c);
     7c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7c7:	0f be c0             	movsbl %al,%eax
     7ca:	83 ec 08             	sub    $0x8,%esp
     7cd:	50                   	push   %eax
     7ce:	ff 75 08             	pushl  0x8(%ebp)
     7d1:	e8 c7 fe ff ff       	call   69d <putc>
     7d6:	83 c4 10             	add    $0x10,%esp
     7d9:	e9 0d 01 00 00       	jmp    8eb <printf+0x177>
      }
    } else if(state == '%'){
     7de:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7e2:	0f 85 03 01 00 00    	jne    8eb <printf+0x177>
      if(c == 'd'){
     7e8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7ec:	75 1e                	jne    80c <printf+0x98>
        printint(fd, *ap, 10, 1);
     7ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f1:	8b 00                	mov    (%eax),%eax
     7f3:	6a 01                	push   $0x1
     7f5:	6a 0a                	push   $0xa
     7f7:	50                   	push   %eax
     7f8:	ff 75 08             	pushl  0x8(%ebp)
     7fb:	e8 c0 fe ff ff       	call   6c0 <printint>
     800:	83 c4 10             	add    $0x10,%esp
        ap++;
     803:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     807:	e9 d8 00 00 00       	jmp    8e4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     80c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     810:	74 06                	je     818 <printf+0xa4>
     812:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     816:	75 1e                	jne    836 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     818:	8b 45 e8             	mov    -0x18(%ebp),%eax
     81b:	8b 00                	mov    (%eax),%eax
     81d:	6a 00                	push   $0x0
     81f:	6a 10                	push   $0x10
     821:	50                   	push   %eax
     822:	ff 75 08             	pushl  0x8(%ebp)
     825:	e8 96 fe ff ff       	call   6c0 <printint>
     82a:	83 c4 10             	add    $0x10,%esp
        ap++;
     82d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     831:	e9 ae 00 00 00       	jmp    8e4 <printf+0x170>
      } else if(c == 's'){
     836:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     83a:	75 43                	jne    87f <printf+0x10b>
        s = (char*)*ap;
     83c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     83f:	8b 00                	mov    (%eax),%eax
     841:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     844:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     848:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     84c:	75 25                	jne    873 <printf+0xff>
          s = "(null)";
     84e:	c7 45 f4 aa 15 00 00 	movl   $0x15aa,-0xc(%ebp)
        while(*s != 0){
     855:	eb 1c                	jmp    873 <printf+0xff>
          putc(fd, *s);
     857:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85a:	0f b6 00             	movzbl (%eax),%eax
     85d:	0f be c0             	movsbl %al,%eax
     860:	83 ec 08             	sub    $0x8,%esp
     863:	50                   	push   %eax
     864:	ff 75 08             	pushl  0x8(%ebp)
     867:	e8 31 fe ff ff       	call   69d <putc>
     86c:	83 c4 10             	add    $0x10,%esp
          s++;
     86f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     873:	8b 45 f4             	mov    -0xc(%ebp),%eax
     876:	0f b6 00             	movzbl (%eax),%eax
     879:	84 c0                	test   %al,%al
     87b:	75 da                	jne    857 <printf+0xe3>
     87d:	eb 65                	jmp    8e4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     87f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     883:	75 1d                	jne    8a2 <printf+0x12e>
        putc(fd, *ap);
     885:	8b 45 e8             	mov    -0x18(%ebp),%eax
     888:	8b 00                	mov    (%eax),%eax
     88a:	0f be c0             	movsbl %al,%eax
     88d:	83 ec 08             	sub    $0x8,%esp
     890:	50                   	push   %eax
     891:	ff 75 08             	pushl  0x8(%ebp)
     894:	e8 04 fe ff ff       	call   69d <putc>
     899:	83 c4 10             	add    $0x10,%esp
        ap++;
     89c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8a0:	eb 42                	jmp    8e4 <printf+0x170>
      } else if(c == '%'){
     8a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8a6:	75 17                	jne    8bf <printf+0x14b>
        putc(fd, c);
     8a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ab:	0f be c0             	movsbl %al,%eax
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	50                   	push   %eax
     8b2:	ff 75 08             	pushl  0x8(%ebp)
     8b5:	e8 e3 fd ff ff       	call   69d <putc>
     8ba:	83 c4 10             	add    $0x10,%esp
     8bd:	eb 25                	jmp    8e4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8bf:	83 ec 08             	sub    $0x8,%esp
     8c2:	6a 25                	push   $0x25
     8c4:	ff 75 08             	pushl  0x8(%ebp)
     8c7:	e8 d1 fd ff ff       	call   69d <putc>
     8cc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8d2:	0f be c0             	movsbl %al,%eax
     8d5:	83 ec 08             	sub    $0x8,%esp
     8d8:	50                   	push   %eax
     8d9:	ff 75 08             	pushl  0x8(%ebp)
     8dc:	e8 bc fd ff ff       	call   69d <putc>
     8e1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8ef:	8b 55 0c             	mov    0xc(%ebp),%edx
     8f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8f5:	01 d0                	add    %edx,%eax
     8f7:	0f b6 00             	movzbl (%eax),%eax
     8fa:	84 c0                	test   %al,%al
     8fc:	0f 85 94 fe ff ff    	jne    796 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     902:	90                   	nop
     903:	c9                   	leave  
     904:	c3                   	ret    

00000905 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     905:	55                   	push   %ebp
     906:	89 e5                	mov    %esp,%ebp
     908:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     90b:	8b 45 08             	mov    0x8(%ebp),%eax
     90e:	83 e8 08             	sub    $0x8,%eax
     911:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     914:	a1 58 1d 00 00       	mov    0x1d58,%eax
     919:	89 45 fc             	mov    %eax,-0x4(%ebp)
     91c:	eb 24                	jmp    942 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     91e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     921:	8b 00                	mov    (%eax),%eax
     923:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     926:	77 12                	ja     93a <free+0x35>
     928:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     92e:	77 24                	ja     954 <free+0x4f>
     930:	8b 45 fc             	mov    -0x4(%ebp),%eax
     933:	8b 00                	mov    (%eax),%eax
     935:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     938:	77 1a                	ja     954 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     93a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     93d:	8b 00                	mov    (%eax),%eax
     93f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     942:	8b 45 f8             	mov    -0x8(%ebp),%eax
     945:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     948:	76 d4                	jbe    91e <free+0x19>
     94a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94d:	8b 00                	mov    (%eax),%eax
     94f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     952:	76 ca                	jbe    91e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     954:	8b 45 f8             	mov    -0x8(%ebp),%eax
     957:	8b 40 04             	mov    0x4(%eax),%eax
     95a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     961:	8b 45 f8             	mov    -0x8(%ebp),%eax
     964:	01 c2                	add    %eax,%edx
     966:	8b 45 fc             	mov    -0x4(%ebp),%eax
     969:	8b 00                	mov    (%eax),%eax
     96b:	39 c2                	cmp    %eax,%edx
     96d:	75 24                	jne    993 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     96f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     972:	8b 50 04             	mov    0x4(%eax),%edx
     975:	8b 45 fc             	mov    -0x4(%ebp),%eax
     978:	8b 00                	mov    (%eax),%eax
     97a:	8b 40 04             	mov    0x4(%eax),%eax
     97d:	01 c2                	add    %eax,%edx
     97f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     982:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     985:	8b 45 fc             	mov    -0x4(%ebp),%eax
     988:	8b 00                	mov    (%eax),%eax
     98a:	8b 10                	mov    (%eax),%edx
     98c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     98f:	89 10                	mov    %edx,(%eax)
     991:	eb 0a                	jmp    99d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     993:	8b 45 fc             	mov    -0x4(%ebp),%eax
     996:	8b 10                	mov    (%eax),%edx
     998:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     99d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a0:	8b 40 04             	mov    0x4(%eax),%eax
     9a3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ad:	01 d0                	add    %edx,%eax
     9af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9b2:	75 20                	jne    9d4 <free+0xcf>
    p->s.size += bp->s.size;
     9b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b7:	8b 50 04             	mov    0x4(%eax),%edx
     9ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9bd:	8b 40 04             	mov    0x4(%eax),%eax
     9c0:	01 c2                	add    %eax,%edx
     9c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9cb:	8b 10                	mov    (%eax),%edx
     9cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d0:	89 10                	mov    %edx,(%eax)
     9d2:	eb 08                	jmp    9dc <free+0xd7>
  } else
    p->s.ptr = bp;
     9d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9da:	89 10                	mov    %edx,(%eax)
  freep = p;
     9dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9df:	a3 58 1d 00 00       	mov    %eax,0x1d58
}
     9e4:	90                   	nop
     9e5:	c9                   	leave  
     9e6:	c3                   	ret    

000009e7 <morecore>:

static Header*
morecore(uint nu)
{
     9e7:	55                   	push   %ebp
     9e8:	89 e5                	mov    %esp,%ebp
     9ea:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9ed:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9f4:	77 07                	ja     9fd <morecore+0x16>
    nu = 4096;
     9f6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9fd:	8b 45 08             	mov    0x8(%ebp),%eax
     a00:	c1 e0 03             	shl    $0x3,%eax
     a03:	83 ec 0c             	sub    $0xc,%esp
     a06:	50                   	push   %eax
     a07:	e8 19 fc ff ff       	call   625 <sbrk>
     a0c:	83 c4 10             	add    $0x10,%esp
     a0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a12:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a16:	75 07                	jne    a1f <morecore+0x38>
    return 0;
     a18:	b8 00 00 00 00       	mov    $0x0,%eax
     a1d:	eb 26                	jmp    a45 <morecore+0x5e>
  hp = (Header*)p;
     a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a25:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a28:	8b 55 08             	mov    0x8(%ebp),%edx
     a2b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a31:	83 c0 08             	add    $0x8,%eax
     a34:	83 ec 0c             	sub    $0xc,%esp
     a37:	50                   	push   %eax
     a38:	e8 c8 fe ff ff       	call   905 <free>
     a3d:	83 c4 10             	add    $0x10,%esp
  return freep;
     a40:	a1 58 1d 00 00       	mov    0x1d58,%eax
}
     a45:	c9                   	leave  
     a46:	c3                   	ret    

00000a47 <malloc>:

void*
malloc(uint nbytes)
{
     a47:	55                   	push   %ebp
     a48:	89 e5                	mov    %esp,%ebp
     a4a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a4d:	8b 45 08             	mov    0x8(%ebp),%eax
     a50:	83 c0 07             	add    $0x7,%eax
     a53:	c1 e8 03             	shr    $0x3,%eax
     a56:	83 c0 01             	add    $0x1,%eax
     a59:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a5c:	a1 58 1d 00 00       	mov    0x1d58,%eax
     a61:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a68:	75 23                	jne    a8d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a6a:	c7 45 f0 50 1d 00 00 	movl   $0x1d50,-0x10(%ebp)
     a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a74:	a3 58 1d 00 00       	mov    %eax,0x1d58
     a79:	a1 58 1d 00 00       	mov    0x1d58,%eax
     a7e:	a3 50 1d 00 00       	mov    %eax,0x1d50
    base.s.size = 0;
     a83:	c7 05 54 1d 00 00 00 	movl   $0x0,0x1d54
     a8a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a90:	8b 00                	mov    (%eax),%eax
     a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a98:	8b 40 04             	mov    0x4(%eax),%eax
     a9b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a9e:	72 4d                	jb     aed <malloc+0xa6>
      if(p->s.size == nunits)
     aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa3:	8b 40 04             	mov    0x4(%eax),%eax
     aa6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     aa9:	75 0c                	jne    ab7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aae:	8b 10                	mov    (%eax),%edx
     ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab3:	89 10                	mov    %edx,(%eax)
     ab5:	eb 26                	jmp    add <malloc+0x96>
      else {
        p->s.size -= nunits;
     ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aba:	8b 40 04             	mov    0x4(%eax),%eax
     abd:	2b 45 ec             	sub    -0x14(%ebp),%eax
     ac0:	89 c2                	mov    %eax,%edx
     ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acb:	8b 40 04             	mov    0x4(%eax),%eax
     ace:	c1 e0 03             	shl    $0x3,%eax
     ad1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ada:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     add:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae0:	a3 58 1d 00 00       	mov    %eax,0x1d58
      return (void*)(p + 1);
     ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae8:	83 c0 08             	add    $0x8,%eax
     aeb:	eb 3b                	jmp    b28 <malloc+0xe1>
    }
    if(p == freep)
     aed:	a1 58 1d 00 00       	mov    0x1d58,%eax
     af2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     af5:	75 1e                	jne    b15 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     af7:	83 ec 0c             	sub    $0xc,%esp
     afa:	ff 75 ec             	pushl  -0x14(%ebp)
     afd:	e8 e5 fe ff ff       	call   9e7 <morecore>
     b02:	83 c4 10             	add    $0x10,%esp
     b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b0c:	75 07                	jne    b15 <malloc+0xce>
        return 0;
     b0e:	b8 00 00 00 00       	mov    $0x0,%eax
     b13:	eb 13                	jmp    b28 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1e:	8b 00                	mov    (%eax),%eax
     b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b23:	e9 6d ff ff ff       	jmp    a95 <malloc+0x4e>
}
     b28:	c9                   	leave  
     b29:	c3                   	ret    

00000b2a <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     b2a:	55                   	push   %ebp
     b2b:	89 e5                	mov    %esp,%ebp
     b2d:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     b30:	83 ec 0c             	sub    $0xc,%esp
     b33:	ff 75 08             	pushl  0x8(%ebp)
     b36:	e8 b0 00 00 00       	call   beb <re_compile>
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	83 ec 04             	sub    $0x4,%esp
     b41:	ff 75 10             	pushl  0x10(%ebp)
     b44:	ff 75 0c             	pushl  0xc(%ebp)
     b47:	50                   	push   %eax
     b48:	e8 05 00 00 00       	call   b52 <re_matchp>
     b4d:	83 c4 10             	add    $0x10,%esp
}
     b50:	c9                   	leave  
     b51:	c3                   	ret    

00000b52 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     b52:	55                   	push   %ebp
     b53:	89 e5                	mov    %esp,%ebp
     b55:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     b58:	8b 45 10             	mov    0x10(%ebp),%eax
     b5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     b61:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b65:	74 7d                	je     be4 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     b67:	8b 45 08             	mov    0x8(%ebp),%eax
     b6a:	0f b6 00             	movzbl (%eax),%eax
     b6d:	3c 02                	cmp    $0x2,%al
     b6f:	75 2a                	jne    b9b <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     b71:	8b 45 08             	mov    0x8(%ebp),%eax
     b74:	83 c0 08             	add    $0x8,%eax
     b77:	83 ec 04             	sub    $0x4,%esp
     b7a:	ff 75 10             	pushl  0x10(%ebp)
     b7d:	ff 75 0c             	pushl  0xc(%ebp)
     b80:	50                   	push   %eax
     b81:	e8 b0 08 00 00       	call   1436 <matchpattern>
     b86:	83 c4 10             	add    $0x10,%esp
     b89:	85 c0                	test   %eax,%eax
     b8b:	74 07                	je     b94 <re_matchp+0x42>
     b8d:	b8 00 00 00 00       	mov    $0x0,%eax
     b92:	eb 55                	jmp    be9 <re_matchp+0x97>
     b94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b99:	eb 4e                	jmp    be9 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     b9b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     ba2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     ba6:	83 ec 04             	sub    $0x4,%esp
     ba9:	ff 75 10             	pushl  0x10(%ebp)
     bac:	ff 75 0c             	pushl  0xc(%ebp)
     baf:	ff 75 08             	pushl  0x8(%ebp)
     bb2:	e8 7f 08 00 00       	call   1436 <matchpattern>
     bb7:	83 c4 10             	add    $0x10,%esp
     bba:	85 c0                	test   %eax,%eax
     bbc:	74 16                	je     bd4 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc1:	0f b6 00             	movzbl (%eax),%eax
     bc4:	84 c0                	test   %al,%al
     bc6:	75 07                	jne    bcf <re_matchp+0x7d>
            return -1;
     bc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bcd:	eb 1a                	jmp    be9 <re_matchp+0x97>
        
          return idx;
     bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd2:	eb 15                	jmp    be9 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     bd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd7:	8d 50 01             	lea    0x1(%eax),%edx
     bda:	89 55 0c             	mov    %edx,0xc(%ebp)
     bdd:	0f b6 00             	movzbl (%eax),%eax
     be0:	84 c0                	test   %al,%al
     be2:	75 be                	jne    ba2 <re_matchp+0x50>
    }
  }
  return -1;
     be4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     be9:	c9                   	leave  
     bea:	c3                   	ret    

00000beb <re_compile>:

re_t re_compile(const char* pattern)
{
     beb:	55                   	push   %ebp
     bec:	89 e5                	mov    %esp,%ebp
     bee:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     bf1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     bf8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     bff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     c06:	e9 55 02 00 00       	jmp    e60 <re_compile+0x275>
  {
    c = pattern[i];
     c0b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c0e:	8b 45 08             	mov    0x8(%ebp),%eax
     c11:	01 d0                	add    %edx,%eax
     c13:	0f b6 00             	movzbl (%eax),%eax
     c16:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     c19:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     c1d:	83 e8 24             	sub    $0x24,%eax
     c20:	83 f8 3a             	cmp    $0x3a,%eax
     c23:	0f 87 13 02 00 00    	ja     e3c <re_compile+0x251>
     c29:	8b 04 85 b4 15 00 00 	mov    0x15b4(,%eax,4),%eax
     c30:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c35:	c6 04 c5 60 1d 00 00 	movb   $0x2,0x1d60(,%eax,8)
     c3c:	02 
     c3d:	e9 16 02 00 00       	jmp    e58 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c45:	c6 04 c5 60 1d 00 00 	movb   $0x3,0x1d60(,%eax,8)
     c4c:	03 
     c4d:	e9 06 02 00 00       	jmp    e58 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c55:	c6 04 c5 60 1d 00 00 	movb   $0x1,0x1d60(,%eax,8)
     c5c:	01 
     c5d:	e9 f6 01 00 00       	jmp    e58 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c65:	c6 04 c5 60 1d 00 00 	movb   $0x5,0x1d60(,%eax,8)
     c6c:	05 
     c6d:	e9 e6 01 00 00       	jmp    e58 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c75:	c6 04 c5 60 1d 00 00 	movb   $0x6,0x1d60(,%eax,8)
     c7c:	06 
     c7d:	e9 d6 01 00 00       	jmp    e58 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     c82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c85:	c6 04 c5 60 1d 00 00 	movb   $0x4,0x1d60(,%eax,8)
     c8c:	04 
     c8d:	e9 c6 01 00 00       	jmp    e58 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     c92:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c95:	8d 50 01             	lea    0x1(%eax),%edx
     c98:	8b 45 08             	mov    0x8(%ebp),%eax
     c9b:	01 d0                	add    %edx,%eax
     c9d:	0f b6 00             	movzbl (%eax),%eax
     ca0:	84 c0                	test   %al,%al
     ca2:	0f 84 af 01 00 00    	je     e57 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     ca8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     cac:	8b 55 f8             	mov    -0x8(%ebp),%edx
     caf:	8b 45 08             	mov    0x8(%ebp),%eax
     cb2:	01 d0                	add    %edx,%eax
     cb4:	0f b6 00             	movzbl (%eax),%eax
     cb7:	0f be c0             	movsbl %al,%eax
     cba:	83 e8 44             	sub    $0x44,%eax
     cbd:	83 f8 33             	cmp    $0x33,%eax
     cc0:	77 57                	ja     d19 <re_compile+0x12e>
     cc2:	8b 04 85 a0 16 00 00 	mov    0x16a0(,%eax,4),%eax
     cc9:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     ccb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cce:	c6 04 c5 60 1d 00 00 	movb   $0xa,0x1d60(,%eax,8)
     cd5:	0a 
     cd6:	eb 64                	jmp    d3c <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdb:	c6 04 c5 60 1d 00 00 	movb   $0xb,0x1d60(,%eax,8)
     ce2:	0b 
     ce3:	eb 57                	jmp    d3c <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce8:	c6 04 c5 60 1d 00 00 	movb   $0xc,0x1d60(,%eax,8)
     cef:	0c 
     cf0:	eb 4a                	jmp    d3c <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf5:	c6 04 c5 60 1d 00 00 	movb   $0xd,0x1d60(,%eax,8)
     cfc:	0d 
     cfd:	eb 3d                	jmp    d3c <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     cff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d02:	c6 04 c5 60 1d 00 00 	movb   $0xe,0x1d60(,%eax,8)
     d09:	0e 
     d0a:	eb 30                	jmp    d3c <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0f:	c6 04 c5 60 1d 00 00 	movb   $0xf,0x1d60(,%eax,8)
     d16:	0f 
     d17:	eb 23                	jmp    d3c <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1c:	c6 04 c5 60 1d 00 00 	movb   $0x7,0x1d60(,%eax,8)
     d23:	07 
              re_compiled[j].ch = pattern[i];
     d24:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d27:	8b 45 08             	mov    0x8(%ebp),%eax
     d2a:	01 d0                	add    %edx,%eax
     d2c:	0f b6 00             	movzbl (%eax),%eax
     d2f:	89 c2                	mov    %eax,%edx
     d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d34:	88 14 c5 64 1d 00 00 	mov    %dl,0x1d64(,%eax,8)
            } break;
     d3b:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     d3c:	e9 16 01 00 00       	jmp    e57 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     d41:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d44:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     d47:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d4a:	8d 50 01             	lea    0x1(%eax),%edx
     d4d:	8b 45 08             	mov    0x8(%ebp),%eax
     d50:	01 d0                	add    %edx,%eax
     d52:	0f b6 00             	movzbl (%eax),%eax
     d55:	3c 5e                	cmp    $0x5e,%al
     d57:	75 11                	jne    d6a <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5c:	c6 04 c5 60 1d 00 00 	movb   $0x9,0x1d60(,%eax,8)
     d63:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     d64:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d68:	eb 7a                	jmp    de4 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     d6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6d:	c6 04 c5 60 1d 00 00 	movb   $0x8,0x1d60(,%eax,8)
     d74:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     d75:	eb 6d                	jmp    de4 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     d77:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	01 d0                	add    %edx,%eax
     d7f:	0f b6 00             	movzbl (%eax),%eax
     d82:	3c 5c                	cmp    $0x5c,%al
     d84:	75 34                	jne    dba <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     d86:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     d8a:	7e 0a                	jle    d96 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     d8c:	b8 00 00 00 00       	mov    $0x0,%eax
     d91:	e9 f8 00 00 00       	jmp    e8e <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     d96:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d99:	8d 50 01             	lea    0x1(%eax),%edx
     d9c:	89 55 fc             	mov    %edx,-0x4(%ebp)
     d9f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     da2:	8d 4a 01             	lea    0x1(%edx),%ecx
     da5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     da8:	89 d1                	mov    %edx,%ecx
     daa:	8b 55 08             	mov    0x8(%ebp),%edx
     dad:	01 ca                	add    %ecx,%edx
     daf:	0f b6 12             	movzbl (%edx),%edx
     db2:	88 90 60 1e 00 00    	mov    %dl,0x1e60(%eax)
     db8:	eb 10                	jmp    dca <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     dba:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     dbe:	7e 0a                	jle    dca <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     dc0:	b8 00 00 00 00       	mov    $0x0,%eax
     dc5:	e9 c4 00 00 00       	jmp    e8e <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     dca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dcd:	8d 50 01             	lea    0x1(%eax),%edx
     dd0:	89 55 fc             	mov    %edx,-0x4(%ebp)
     dd3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     dd6:	8b 55 08             	mov    0x8(%ebp),%edx
     dd9:	01 ca                	add    %ecx,%edx
     ddb:	0f b6 12             	movzbl (%edx),%edx
     dde:	88 90 60 1e 00 00    	mov    %dl,0x1e60(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     de4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     de8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     deb:	8b 45 08             	mov    0x8(%ebp),%eax
     dee:	01 d0                	add    %edx,%eax
     df0:	0f b6 00             	movzbl (%eax),%eax
     df3:	3c 5d                	cmp    $0x5d,%al
     df5:	74 13                	je     e0a <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     df7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     dfa:	8b 45 08             	mov    0x8(%ebp),%eax
     dfd:	01 d0                	add    %edx,%eax
     dff:	0f b6 00             	movzbl (%eax),%eax
     e02:	84 c0                	test   %al,%al
     e04:	0f 85 6d ff ff ff    	jne    d77 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     e0a:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     e0e:	7e 07                	jle    e17 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     e10:	b8 00 00 00 00       	mov    $0x0,%eax
     e15:	eb 77                	jmp    e8e <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e1a:	8d 50 01             	lea    0x1(%eax),%edx
     e1d:	89 55 fc             	mov    %edx,-0x4(%ebp)
     e20:	c6 80 60 1e 00 00 00 	movb   $0x0,0x1e60(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     e27:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e2a:	8d 90 60 1e 00 00    	lea    0x1e60(%eax),%edx
     e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e33:	89 14 c5 64 1d 00 00 	mov    %edx,0x1d64(,%eax,8)
      } break;
     e3a:	eb 1c                	jmp    e58 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     e3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3f:	c6 04 c5 60 1d 00 00 	movb   $0x7,0x1d60(,%eax,8)
     e46:	07 
        re_compiled[j].ch = c;
     e47:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4e:	88 14 c5 64 1d 00 00 	mov    %dl,0x1d64(,%eax,8)
      } break;
     e55:	eb 01                	jmp    e58 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     e57:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     e58:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     e5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     e60:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e63:	8b 45 08             	mov    0x8(%ebp),%eax
     e66:	01 d0                	add    %edx,%eax
     e68:	0f b6 00             	movzbl (%eax),%eax
     e6b:	84 c0                	test   %al,%al
     e6d:	74 0f                	je     e7e <re_compile+0x293>
     e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e72:	83 c0 01             	add    $0x1,%eax
     e75:	83 f8 1d             	cmp    $0x1d,%eax
     e78:	0f 8e 8d fd ff ff    	jle    c0b <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e81:	c6 04 c5 60 1d 00 00 	movb   $0x0,0x1d60(,%eax,8)
     e88:	00 

  return (re_t) re_compiled;
     e89:	b8 60 1d 00 00       	mov    $0x1d60,%eax
}
     e8e:	c9                   	leave  
     e8f:	c3                   	ret    

00000e90 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	83 ec 04             	sub    $0x4,%esp
     e96:	8b 45 08             	mov    0x8(%ebp),%eax
     e99:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     e9c:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     ea0:	7e 0d                	jle    eaf <matchdigit+0x1f>
     ea2:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     ea6:	7f 07                	jg     eaf <matchdigit+0x1f>
     ea8:	b8 01 00 00 00       	mov    $0x1,%eax
     ead:	eb 05                	jmp    eb4 <matchdigit+0x24>
     eaf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eb4:	c9                   	leave  
     eb5:	c3                   	ret    

00000eb6 <matchalpha>:
static int matchalpha(char c)
{
     eb6:	55                   	push   %ebp
     eb7:	89 e5                	mov    %esp,%ebp
     eb9:	83 ec 04             	sub    $0x4,%esp
     ebc:	8b 45 08             	mov    0x8(%ebp),%eax
     ebf:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     ec2:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     ec6:	7e 06                	jle    ece <matchalpha+0x18>
     ec8:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     ecc:	7e 0c                	jle    eda <matchalpha+0x24>
     ece:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     ed2:	7e 0d                	jle    ee1 <matchalpha+0x2b>
     ed4:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     ed8:	7f 07                	jg     ee1 <matchalpha+0x2b>
     eda:	b8 01 00 00 00       	mov    $0x1,%eax
     edf:	eb 05                	jmp    ee6 <matchalpha+0x30>
     ee1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ee6:	c9                   	leave  
     ee7:	c3                   	ret    

00000ee8 <matchwhitespace>:
static int matchwhitespace(char c)
{
     ee8:	55                   	push   %ebp
     ee9:	89 e5                	mov    %esp,%ebp
     eeb:	83 ec 04             	sub    $0x4,%esp
     eee:	8b 45 08             	mov    0x8(%ebp),%eax
     ef1:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     ef4:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     ef8:	74 1e                	je     f18 <matchwhitespace+0x30>
     efa:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     efe:	74 18                	je     f18 <matchwhitespace+0x30>
     f00:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     f04:	74 12                	je     f18 <matchwhitespace+0x30>
     f06:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     f0a:	74 0c                	je     f18 <matchwhitespace+0x30>
     f0c:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     f10:	74 06                	je     f18 <matchwhitespace+0x30>
     f12:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     f16:	75 07                	jne    f1f <matchwhitespace+0x37>
     f18:	b8 01 00 00 00       	mov    $0x1,%eax
     f1d:	eb 05                	jmp    f24 <matchwhitespace+0x3c>
     f1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f24:	c9                   	leave  
     f25:	c3                   	ret    

00000f26 <matchalphanum>:
static int matchalphanum(char c)
{
     f26:	55                   	push   %ebp
     f27:	89 e5                	mov    %esp,%ebp
     f29:	83 ec 04             	sub    $0x4,%esp
     f2c:	8b 45 08             	mov    0x8(%ebp),%eax
     f2f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     f32:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     f36:	74 22                	je     f5a <matchalphanum+0x34>
     f38:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f3c:	50                   	push   %eax
     f3d:	e8 74 ff ff ff       	call   eb6 <matchalpha>
     f42:	83 c4 04             	add    $0x4,%esp
     f45:	85 c0                	test   %eax,%eax
     f47:	75 11                	jne    f5a <matchalphanum+0x34>
     f49:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4d:	50                   	push   %eax
     f4e:	e8 3d ff ff ff       	call   e90 <matchdigit>
     f53:	83 c4 04             	add    $0x4,%esp
     f56:	85 c0                	test   %eax,%eax
     f58:	74 07                	je     f61 <matchalphanum+0x3b>
     f5a:	b8 01 00 00 00       	mov    $0x1,%eax
     f5f:	eb 05                	jmp    f66 <matchalphanum+0x40>
     f61:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f66:	c9                   	leave  
     f67:	c3                   	ret    

00000f68 <matchrange>:
static int matchrange(char c, const char* str)
{
     f68:	55                   	push   %ebp
     f69:	89 e5                	mov    %esp,%ebp
     f6b:	83 ec 04             	sub    $0x4,%esp
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     f74:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     f78:	74 5b                	je     fd5 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f7d:	0f b6 00             	movzbl (%eax),%eax
     f80:	84 c0                	test   %al,%al
     f82:	74 51                	je     fd5 <matchrange+0x6d>
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	0f b6 00             	movzbl (%eax),%eax
     f8a:	3c 2d                	cmp    $0x2d,%al
     f8c:	74 47                	je     fd5 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f91:	83 c0 01             	add    $0x1,%eax
     f94:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     f97:	3c 2d                	cmp    $0x2d,%al
     f99:	75 3a                	jne    fd5 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f9e:	83 c0 01             	add    $0x1,%eax
     fa1:	0f b6 00             	movzbl (%eax),%eax
     fa4:	84 c0                	test   %al,%al
     fa6:	74 2d                	je     fd5 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
     fab:	83 c0 02             	add    $0x2,%eax
     fae:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     fb1:	84 c0                	test   %al,%al
     fb3:	74 20                	je     fd5 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb8:	0f b6 00             	movzbl (%eax),%eax
     fbb:	3a 45 fc             	cmp    -0x4(%ebp),%al
     fbe:	7f 15                	jg     fd5 <matchrange+0x6d>
     fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc3:	83 c0 02             	add    $0x2,%eax
     fc6:	0f b6 00             	movzbl (%eax),%eax
     fc9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     fcc:	7c 07                	jl     fd5 <matchrange+0x6d>
     fce:	b8 01 00 00 00       	mov    $0x1,%eax
     fd3:	eb 05                	jmp    fda <matchrange+0x72>
     fd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fda:	c9                   	leave  
     fdb:	c3                   	ret    

00000fdc <ismetachar>:
static int ismetachar(char c)
{
     fdc:	55                   	push   %ebp
     fdd:	89 e5                	mov    %esp,%ebp
     fdf:	83 ec 04             	sub    $0x4,%esp
     fe2:	8b 45 08             	mov    0x8(%ebp),%eax
     fe5:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     fe8:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     fec:	74 1e                	je     100c <ismetachar+0x30>
     fee:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     ff2:	74 18                	je     100c <ismetachar+0x30>
     ff4:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     ff8:	74 12                	je     100c <ismetachar+0x30>
     ffa:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     ffe:	74 0c                	je     100c <ismetachar+0x30>
    1000:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
    1004:	74 06                	je     100c <ismetachar+0x30>
    1006:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
    100a:	75 07                	jne    1013 <ismetachar+0x37>
    100c:	b8 01 00 00 00       	mov    $0x1,%eax
    1011:	eb 05                	jmp    1018 <ismetachar+0x3c>
    1013:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1018:	c9                   	leave  
    1019:	c3                   	ret    

0000101a <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
    101a:	55                   	push   %ebp
    101b:	89 e5                	mov    %esp,%ebp
    101d:	83 ec 04             	sub    $0x4,%esp
    1020:	8b 45 08             	mov    0x8(%ebp),%eax
    1023:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
    1026:	8b 45 0c             	mov    0xc(%ebp),%eax
    1029:	0f b6 00             	movzbl (%eax),%eax
    102c:	0f be c0             	movsbl %al,%eax
    102f:	83 e8 44             	sub    $0x44,%eax
    1032:	83 f8 33             	cmp    $0x33,%eax
    1035:	77 7b                	ja     10b2 <matchmetachar+0x98>
    1037:	8b 04 85 70 17 00 00 	mov    0x1770(,%eax,4),%eax
    103e:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
    1040:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1044:	50                   	push   %eax
    1045:	e8 46 fe ff ff       	call   e90 <matchdigit>
    104a:	83 c4 04             	add    $0x4,%esp
    104d:	eb 72                	jmp    10c1 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
    104f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1053:	50                   	push   %eax
    1054:	e8 37 fe ff ff       	call   e90 <matchdigit>
    1059:	83 c4 04             	add    $0x4,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	0f 94 c0             	sete   %al
    1061:	0f b6 c0             	movzbl %al,%eax
    1064:	eb 5b                	jmp    10c1 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
    1066:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    106a:	50                   	push   %eax
    106b:	e8 b6 fe ff ff       	call   f26 <matchalphanum>
    1070:	83 c4 04             	add    $0x4,%esp
    1073:	eb 4c                	jmp    10c1 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
    1075:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1079:	50                   	push   %eax
    107a:	e8 a7 fe ff ff       	call   f26 <matchalphanum>
    107f:	83 c4 04             	add    $0x4,%esp
    1082:	85 c0                	test   %eax,%eax
    1084:	0f 94 c0             	sete   %al
    1087:	0f b6 c0             	movzbl %al,%eax
    108a:	eb 35                	jmp    10c1 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
    108c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1090:	50                   	push   %eax
    1091:	e8 52 fe ff ff       	call   ee8 <matchwhitespace>
    1096:	83 c4 04             	add    $0x4,%esp
    1099:	eb 26                	jmp    10c1 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
    109b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    109f:	50                   	push   %eax
    10a0:	e8 43 fe ff ff       	call   ee8 <matchwhitespace>
    10a5:	83 c4 04             	add    $0x4,%esp
    10a8:	85 c0                	test   %eax,%eax
    10aa:	0f 94 c0             	sete   %al
    10ad:	0f b6 c0             	movzbl %al,%eax
    10b0:	eb 0f                	jmp    10c1 <matchmetachar+0xa7>
    default:  return (c == str[0]);
    10b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b5:	0f b6 00             	movzbl (%eax),%eax
    10b8:	3a 45 fc             	cmp    -0x4(%ebp),%al
    10bb:	0f 94 c0             	sete   %al
    10be:	0f b6 c0             	movzbl %al,%eax
  }
}
    10c1:	c9                   	leave  
    10c2:	c3                   	ret    

000010c3 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
    10c3:	55                   	push   %ebp
    10c4:	89 e5                	mov    %esp,%ebp
    10c6:	83 ec 04             	sub    $0x4,%esp
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
    10cf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10d3:	ff 75 0c             	pushl  0xc(%ebp)
    10d6:	50                   	push   %eax
    10d7:	e8 8c fe ff ff       	call   f68 <matchrange>
    10dc:	83 c4 08             	add    $0x8,%esp
    10df:	85 c0                	test   %eax,%eax
    10e1:	74 0a                	je     10ed <matchcharclass+0x2a>
    {
      return 1;
    10e3:	b8 01 00 00 00       	mov    $0x1,%eax
    10e8:	e9 a5 00 00 00       	jmp    1192 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
    10ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f0:	0f b6 00             	movzbl (%eax),%eax
    10f3:	3c 5c                	cmp    $0x5c,%al
    10f5:	75 42                	jne    1139 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
    10f7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
    10fb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10ff:	ff 75 0c             	pushl  0xc(%ebp)
    1102:	50                   	push   %eax
    1103:	e8 12 ff ff ff       	call   101a <matchmetachar>
    1108:	83 c4 08             	add    $0x8,%esp
    110b:	85 c0                	test   %eax,%eax
    110d:	74 07                	je     1116 <matchcharclass+0x53>
      {
        return 1;
    110f:	b8 01 00 00 00       	mov    $0x1,%eax
    1114:	eb 7c                	jmp    1192 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
    1116:	8b 45 0c             	mov    0xc(%ebp),%eax
    1119:	0f b6 00             	movzbl (%eax),%eax
    111c:	3a 45 fc             	cmp    -0x4(%ebp),%al
    111f:	75 58                	jne    1179 <matchcharclass+0xb6>
    1121:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1125:	50                   	push   %eax
    1126:	e8 b1 fe ff ff       	call   fdc <ismetachar>
    112b:	83 c4 04             	add    $0x4,%esp
    112e:	85 c0                	test   %eax,%eax
    1130:	75 47                	jne    1179 <matchcharclass+0xb6>
      {
        return 1;
    1132:	b8 01 00 00 00       	mov    $0x1,%eax
    1137:	eb 59                	jmp    1192 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
    1139:	8b 45 0c             	mov    0xc(%ebp),%eax
    113c:	0f b6 00             	movzbl (%eax),%eax
    113f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1142:	75 35                	jne    1179 <matchcharclass+0xb6>
    {
      if (c == '-')
    1144:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    1148:	75 28                	jne    1172 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
    114a:	8b 45 0c             	mov    0xc(%ebp),%eax
    114d:	83 e8 01             	sub    $0x1,%eax
    1150:	0f b6 00             	movzbl (%eax),%eax
    1153:	84 c0                	test   %al,%al
    1155:	74 0d                	je     1164 <matchcharclass+0xa1>
    1157:	8b 45 0c             	mov    0xc(%ebp),%eax
    115a:	83 c0 01             	add    $0x1,%eax
    115d:	0f b6 00             	movzbl (%eax),%eax
    1160:	84 c0                	test   %al,%al
    1162:	75 07                	jne    116b <matchcharclass+0xa8>
    1164:	b8 01 00 00 00       	mov    $0x1,%eax
    1169:	eb 27                	jmp    1192 <matchcharclass+0xcf>
    116b:	b8 00 00 00 00       	mov    $0x0,%eax
    1170:	eb 20                	jmp    1192 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
    1172:	b8 01 00 00 00       	mov    $0x1,%eax
    1177:	eb 19                	jmp    1192 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
    1179:	8b 45 0c             	mov    0xc(%ebp),%eax
    117c:	8d 50 01             	lea    0x1(%eax),%edx
    117f:	89 55 0c             	mov    %edx,0xc(%ebp)
    1182:	0f b6 00             	movzbl (%eax),%eax
    1185:	84 c0                	test   %al,%al
    1187:	0f 85 42 ff ff ff    	jne    10cf <matchcharclass+0xc>

  return 0;
    118d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1192:	c9                   	leave  
    1193:	c3                   	ret    

00001194 <matchone>:

static int matchone(regex_t p, char c)
{
    1194:	55                   	push   %ebp
    1195:	89 e5                	mov    %esp,%ebp
    1197:	83 ec 04             	sub    $0x4,%esp
    119a:	8b 45 10             	mov    0x10(%ebp),%eax
    119d:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
    11a0:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    11a4:	0f b6 c0             	movzbl %al,%eax
    11a7:	83 f8 0f             	cmp    $0xf,%eax
    11aa:	0f 87 b9 00 00 00    	ja     1269 <matchone+0xd5>
    11b0:	8b 04 85 40 18 00 00 	mov    0x1840(,%eax,4),%eax
    11b7:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
    11b9:	b8 01 00 00 00       	mov    $0x1,%eax
    11be:	e9 b9 00 00 00       	jmp    127c <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
    11c3:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11ca:	52                   	push   %edx
    11cb:	50                   	push   %eax
    11cc:	e8 f2 fe ff ff       	call   10c3 <matchcharclass>
    11d1:	83 c4 08             	add    $0x8,%esp
    11d4:	e9 a3 00 00 00       	jmp    127c <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
    11d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    11dc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11e0:	52                   	push   %edx
    11e1:	50                   	push   %eax
    11e2:	e8 dc fe ff ff       	call   10c3 <matchcharclass>
    11e7:	83 c4 08             	add    $0x8,%esp
    11ea:	85 c0                	test   %eax,%eax
    11ec:	0f 94 c0             	sete   %al
    11ef:	0f b6 c0             	movzbl %al,%eax
    11f2:	e9 85 00 00 00       	jmp    127c <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    11f7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11fb:	50                   	push   %eax
    11fc:	e8 8f fc ff ff       	call   e90 <matchdigit>
    1201:	83 c4 04             	add    $0x4,%esp
    1204:	eb 76                	jmp    127c <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    1206:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    120a:	50                   	push   %eax
    120b:	e8 80 fc ff ff       	call   e90 <matchdigit>
    1210:	83 c4 04             	add    $0x4,%esp
    1213:	85 c0                	test   %eax,%eax
    1215:	0f 94 c0             	sete   %al
    1218:	0f b6 c0             	movzbl %al,%eax
    121b:	eb 5f                	jmp    127c <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    121d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1221:	50                   	push   %eax
    1222:	e8 ff fc ff ff       	call   f26 <matchalphanum>
    1227:	83 c4 04             	add    $0x4,%esp
    122a:	eb 50                	jmp    127c <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    122c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1230:	50                   	push   %eax
    1231:	e8 f0 fc ff ff       	call   f26 <matchalphanum>
    1236:	83 c4 04             	add    $0x4,%esp
    1239:	85 c0                	test   %eax,%eax
    123b:	0f 94 c0             	sete   %al
    123e:	0f b6 c0             	movzbl %al,%eax
    1241:	eb 39                	jmp    127c <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    1243:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1247:	50                   	push   %eax
    1248:	e8 9b fc ff ff       	call   ee8 <matchwhitespace>
    124d:	83 c4 04             	add    $0x4,%esp
    1250:	eb 2a                	jmp    127c <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    1252:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1256:	50                   	push   %eax
    1257:	e8 8c fc ff ff       	call   ee8 <matchwhitespace>
    125c:	83 c4 04             	add    $0x4,%esp
    125f:	85 c0                	test   %eax,%eax
    1261:	0f 94 c0             	sete   %al
    1264:	0f b6 c0             	movzbl %al,%eax
    1267:	eb 13                	jmp    127c <matchone+0xe8>
    default:             return  (p.ch == c);
    1269:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    126d:	0f b6 d0             	movzbl %al,%edx
    1270:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1274:	39 c2                	cmp    %eax,%edx
    1276:	0f 94 c0             	sete   %al
    1279:	0f b6 c0             	movzbl %al,%eax
  }
}
    127c:	c9                   	leave  
    127d:	c3                   	ret    

0000127e <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    127e:	55                   	push   %ebp
    127f:	89 e5                	mov    %esp,%ebp
    1281:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    1284:	8b 45 18             	mov    0x18(%ebp),%eax
    1287:	8b 00                	mov    (%eax),%eax
    1289:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    128c:	8b 45 14             	mov    0x14(%ebp),%eax
    128f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1292:	eb 11                	jmp    12a5 <matchstar+0x27>
  {
    text++;
    1294:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1298:	8b 45 18             	mov    0x18(%ebp),%eax
    129b:	8b 00                	mov    (%eax),%eax
    129d:	8d 50 01             	lea    0x1(%eax),%edx
    12a0:	8b 45 18             	mov    0x18(%ebp),%eax
    12a3:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    12a5:	8b 45 14             	mov    0x14(%ebp),%eax
    12a8:	0f b6 00             	movzbl (%eax),%eax
    12ab:	84 c0                	test   %al,%al
    12ad:	74 51                	je     1300 <matchstar+0x82>
    12af:	8b 45 14             	mov    0x14(%ebp),%eax
    12b2:	0f b6 00             	movzbl (%eax),%eax
    12b5:	0f be c0             	movsbl %al,%eax
    12b8:	50                   	push   %eax
    12b9:	ff 75 0c             	pushl  0xc(%ebp)
    12bc:	ff 75 08             	pushl  0x8(%ebp)
    12bf:	e8 d0 fe ff ff       	call   1194 <matchone>
    12c4:	83 c4 0c             	add    $0xc,%esp
    12c7:	85 c0                	test   %eax,%eax
    12c9:	75 c9                	jne    1294 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    12cb:	eb 33                	jmp    1300 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    12cd:	8b 45 14             	mov    0x14(%ebp),%eax
    12d0:	8d 50 ff             	lea    -0x1(%eax),%edx
    12d3:	89 55 14             	mov    %edx,0x14(%ebp)
    12d6:	83 ec 04             	sub    $0x4,%esp
    12d9:	ff 75 18             	pushl  0x18(%ebp)
    12dc:	50                   	push   %eax
    12dd:	ff 75 10             	pushl  0x10(%ebp)
    12e0:	e8 51 01 00 00       	call   1436 <matchpattern>
    12e5:	83 c4 10             	add    $0x10,%esp
    12e8:	85 c0                	test   %eax,%eax
    12ea:	74 07                	je     12f3 <matchstar+0x75>
      return 1;
    12ec:	b8 01 00 00 00       	mov    $0x1,%eax
    12f1:	eb 22                	jmp    1315 <matchstar+0x97>
    (*matchlength)--;
    12f3:	8b 45 18             	mov    0x18(%ebp),%eax
    12f6:	8b 00                	mov    (%eax),%eax
    12f8:	8d 50 ff             	lea    -0x1(%eax),%edx
    12fb:	8b 45 18             	mov    0x18(%ebp),%eax
    12fe:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1300:	8b 45 14             	mov    0x14(%ebp),%eax
    1303:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1306:	73 c5                	jae    12cd <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1308:	8b 45 18             	mov    0x18(%ebp),%eax
    130b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    130e:	89 10                	mov    %edx,(%eax)
  return 0;
    1310:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1315:	c9                   	leave  
    1316:	c3                   	ret    

00001317 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1317:	55                   	push   %ebp
    1318:	89 e5                	mov    %esp,%ebp
    131a:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    131d:	8b 45 14             	mov    0x14(%ebp),%eax
    1320:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1323:	eb 11                	jmp    1336 <matchplus+0x1f>
  {
    text++;
    1325:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1329:	8b 45 18             	mov    0x18(%ebp),%eax
    132c:	8b 00                	mov    (%eax),%eax
    132e:	8d 50 01             	lea    0x1(%eax),%edx
    1331:	8b 45 18             	mov    0x18(%ebp),%eax
    1334:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1336:	8b 45 14             	mov    0x14(%ebp),%eax
    1339:	0f b6 00             	movzbl (%eax),%eax
    133c:	84 c0                	test   %al,%al
    133e:	74 51                	je     1391 <matchplus+0x7a>
    1340:	8b 45 14             	mov    0x14(%ebp),%eax
    1343:	0f b6 00             	movzbl (%eax),%eax
    1346:	0f be c0             	movsbl %al,%eax
    1349:	50                   	push   %eax
    134a:	ff 75 0c             	pushl  0xc(%ebp)
    134d:	ff 75 08             	pushl  0x8(%ebp)
    1350:	e8 3f fe ff ff       	call   1194 <matchone>
    1355:	83 c4 0c             	add    $0xc,%esp
    1358:	85 c0                	test   %eax,%eax
    135a:	75 c9                	jne    1325 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    135c:	eb 33                	jmp    1391 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    135e:	8b 45 14             	mov    0x14(%ebp),%eax
    1361:	8d 50 ff             	lea    -0x1(%eax),%edx
    1364:	89 55 14             	mov    %edx,0x14(%ebp)
    1367:	83 ec 04             	sub    $0x4,%esp
    136a:	ff 75 18             	pushl  0x18(%ebp)
    136d:	50                   	push   %eax
    136e:	ff 75 10             	pushl  0x10(%ebp)
    1371:	e8 c0 00 00 00       	call   1436 <matchpattern>
    1376:	83 c4 10             	add    $0x10,%esp
    1379:	85 c0                	test   %eax,%eax
    137b:	74 07                	je     1384 <matchplus+0x6d>
      return 1;
    137d:	b8 01 00 00 00       	mov    $0x1,%eax
    1382:	eb 1a                	jmp    139e <matchplus+0x87>
    (*matchlength)--;
    1384:	8b 45 18             	mov    0x18(%ebp),%eax
    1387:	8b 00                	mov    (%eax),%eax
    1389:	8d 50 ff             	lea    -0x1(%eax),%edx
    138c:	8b 45 18             	mov    0x18(%ebp),%eax
    138f:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1391:	8b 45 14             	mov    0x14(%ebp),%eax
    1394:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1397:	77 c5                	ja     135e <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    1399:	b8 00 00 00 00       	mov    $0x0,%eax
}
    139e:	c9                   	leave  
    139f:	c3                   	ret    

000013a0 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    13a6:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    13aa:	84 c0                	test   %al,%al
    13ac:	75 07                	jne    13b5 <matchquestion+0x15>
    return 1;
    13ae:	b8 01 00 00 00       	mov    $0x1,%eax
    13b3:	eb 7f                	jmp    1434 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    13b5:	83 ec 04             	sub    $0x4,%esp
    13b8:	ff 75 18             	pushl  0x18(%ebp)
    13bb:	ff 75 14             	pushl  0x14(%ebp)
    13be:	ff 75 10             	pushl  0x10(%ebp)
    13c1:	e8 70 00 00 00       	call   1436 <matchpattern>
    13c6:	83 c4 10             	add    $0x10,%esp
    13c9:	85 c0                	test   %eax,%eax
    13cb:	74 07                	je     13d4 <matchquestion+0x34>
      return 1;
    13cd:	b8 01 00 00 00       	mov    $0x1,%eax
    13d2:	eb 60                	jmp    1434 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    13d4:	8b 45 14             	mov    0x14(%ebp),%eax
    13d7:	0f b6 00             	movzbl (%eax),%eax
    13da:	84 c0                	test   %al,%al
    13dc:	74 51                	je     142f <matchquestion+0x8f>
    13de:	8b 45 14             	mov    0x14(%ebp),%eax
    13e1:	8d 50 01             	lea    0x1(%eax),%edx
    13e4:	89 55 14             	mov    %edx,0x14(%ebp)
    13e7:	0f b6 00             	movzbl (%eax),%eax
    13ea:	0f be c0             	movsbl %al,%eax
    13ed:	83 ec 04             	sub    $0x4,%esp
    13f0:	50                   	push   %eax
    13f1:	ff 75 0c             	pushl  0xc(%ebp)
    13f4:	ff 75 08             	pushl  0x8(%ebp)
    13f7:	e8 98 fd ff ff       	call   1194 <matchone>
    13fc:	83 c4 10             	add    $0x10,%esp
    13ff:	85 c0                	test   %eax,%eax
    1401:	74 2c                	je     142f <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    1403:	83 ec 04             	sub    $0x4,%esp
    1406:	ff 75 18             	pushl  0x18(%ebp)
    1409:	ff 75 14             	pushl  0x14(%ebp)
    140c:	ff 75 10             	pushl  0x10(%ebp)
    140f:	e8 22 00 00 00       	call   1436 <matchpattern>
    1414:	83 c4 10             	add    $0x10,%esp
    1417:	85 c0                	test   %eax,%eax
    1419:	74 14                	je     142f <matchquestion+0x8f>
    {
      (*matchlength)++;
    141b:	8b 45 18             	mov    0x18(%ebp),%eax
    141e:	8b 00                	mov    (%eax),%eax
    1420:	8d 50 01             	lea    0x1(%eax),%edx
    1423:	8b 45 18             	mov    0x18(%ebp),%eax
    1426:	89 10                	mov    %edx,(%eax)
      return 1;
    1428:	b8 01 00 00 00       	mov    $0x1,%eax
    142d:	eb 05                	jmp    1434 <matchquestion+0x94>
    }
  }
  return 0;
    142f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1434:	c9                   	leave  
    1435:	c3                   	ret    

00001436 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1436:	55                   	push   %ebp
    1437:	89 e5                	mov    %esp,%ebp
    1439:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    143c:	8b 45 10             	mov    0x10(%ebp),%eax
    143f:	8b 00                	mov    (%eax),%eax
    1441:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1444:	8b 45 08             	mov    0x8(%ebp),%eax
    1447:	0f b6 00             	movzbl (%eax),%eax
    144a:	84 c0                	test   %al,%al
    144c:	74 0d                	je     145b <matchpattern+0x25>
    144e:	8b 45 08             	mov    0x8(%ebp),%eax
    1451:	83 c0 08             	add    $0x8,%eax
    1454:	0f b6 00             	movzbl (%eax),%eax
    1457:	3c 04                	cmp    $0x4,%al
    1459:	75 25                	jne    1480 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    145b:	8b 45 08             	mov    0x8(%ebp),%eax
    145e:	83 c0 10             	add    $0x10,%eax
    1461:	83 ec 0c             	sub    $0xc,%esp
    1464:	ff 75 10             	pushl  0x10(%ebp)
    1467:	ff 75 0c             	pushl  0xc(%ebp)
    146a:	50                   	push   %eax
    146b:	8b 45 08             	mov    0x8(%ebp),%eax
    146e:	ff 70 04             	pushl  0x4(%eax)
    1471:	ff 30                	pushl  (%eax)
    1473:	e8 28 ff ff ff       	call   13a0 <matchquestion>
    1478:	83 c4 20             	add    $0x20,%esp
    147b:	e9 dd 00 00 00       	jmp    155d <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	83 c0 08             	add    $0x8,%eax
    1486:	0f b6 00             	movzbl (%eax),%eax
    1489:	3c 05                	cmp    $0x5,%al
    148b:	75 25                	jne    14b2 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    148d:	8b 45 08             	mov    0x8(%ebp),%eax
    1490:	83 c0 10             	add    $0x10,%eax
    1493:	83 ec 0c             	sub    $0xc,%esp
    1496:	ff 75 10             	pushl  0x10(%ebp)
    1499:	ff 75 0c             	pushl  0xc(%ebp)
    149c:	50                   	push   %eax
    149d:	8b 45 08             	mov    0x8(%ebp),%eax
    14a0:	ff 70 04             	pushl  0x4(%eax)
    14a3:	ff 30                	pushl  (%eax)
    14a5:	e8 d4 fd ff ff       	call   127e <matchstar>
    14aa:	83 c4 20             	add    $0x20,%esp
    14ad:	e9 ab 00 00 00       	jmp    155d <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    14b2:	8b 45 08             	mov    0x8(%ebp),%eax
    14b5:	83 c0 08             	add    $0x8,%eax
    14b8:	0f b6 00             	movzbl (%eax),%eax
    14bb:	3c 06                	cmp    $0x6,%al
    14bd:	75 22                	jne    14e1 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    14bf:	8b 45 08             	mov    0x8(%ebp),%eax
    14c2:	83 c0 10             	add    $0x10,%eax
    14c5:	83 ec 0c             	sub    $0xc,%esp
    14c8:	ff 75 10             	pushl  0x10(%ebp)
    14cb:	ff 75 0c             	pushl  0xc(%ebp)
    14ce:	50                   	push   %eax
    14cf:	8b 45 08             	mov    0x8(%ebp),%eax
    14d2:	ff 70 04             	pushl  0x4(%eax)
    14d5:	ff 30                	pushl  (%eax)
    14d7:	e8 3b fe ff ff       	call   1317 <matchplus>
    14dc:	83 c4 20             	add    $0x20,%esp
    14df:	eb 7c                	jmp    155d <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    14e1:	8b 45 08             	mov    0x8(%ebp),%eax
    14e4:	0f b6 00             	movzbl (%eax),%eax
    14e7:	3c 03                	cmp    $0x3,%al
    14e9:	75 1d                	jne    1508 <matchpattern+0xd2>
    14eb:	8b 45 08             	mov    0x8(%ebp),%eax
    14ee:	83 c0 08             	add    $0x8,%eax
    14f1:	0f b6 00             	movzbl (%eax),%eax
    14f4:	84 c0                	test   %al,%al
    14f6:	75 10                	jne    1508 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    14f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fb:	0f b6 00             	movzbl (%eax),%eax
    14fe:	84 c0                	test   %al,%al
    1500:	0f 94 c0             	sete   %al
    1503:	0f b6 c0             	movzbl %al,%eax
    1506:	eb 55                	jmp    155d <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1508:	8b 45 10             	mov    0x10(%ebp),%eax
    150b:	8b 00                	mov    (%eax),%eax
    150d:	8d 50 01             	lea    0x1(%eax),%edx
    1510:	8b 45 10             	mov    0x10(%ebp),%eax
    1513:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1515:	8b 45 0c             	mov    0xc(%ebp),%eax
    1518:	0f b6 00             	movzbl (%eax),%eax
    151b:	84 c0                	test   %al,%al
    151d:	74 31                	je     1550 <matchpattern+0x11a>
    151f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1522:	8d 50 01             	lea    0x1(%eax),%edx
    1525:	89 55 0c             	mov    %edx,0xc(%ebp)
    1528:	0f b6 00             	movzbl (%eax),%eax
    152b:	0f be d0             	movsbl %al,%edx
    152e:	8b 45 08             	mov    0x8(%ebp),%eax
    1531:	8d 48 08             	lea    0x8(%eax),%ecx
    1534:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1537:	83 ec 04             	sub    $0x4,%esp
    153a:	52                   	push   %edx
    153b:	ff 70 04             	pushl  0x4(%eax)
    153e:	ff 30                	pushl  (%eax)
    1540:	e8 4f fc ff ff       	call   1194 <matchone>
    1545:	83 c4 10             	add    $0x10,%esp
    1548:	85 c0                	test   %eax,%eax
    154a:	0f 85 f4 fe ff ff    	jne    1444 <matchpattern+0xe>

  *matchlength = pre;
    1550:	8b 45 10             	mov    0x10(%ebp),%eax
    1553:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1556:	89 10                	mov    %edx,(%eax)
  return 0;
    1558:	b8 00 00 00 00       	mov    $0x0,%eax
}
    155d:	c9                   	leave  
    155e:	c3                   	ret    
