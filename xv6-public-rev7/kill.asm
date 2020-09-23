
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 10             	sub    $0x10,%esp
      12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 1){
      14:	83 3b 00             	cmpl   $0x0,(%ebx)
      17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 8c 12 00 00       	push   $0x128c
      21:	6a 02                	push   $0x2
      23:	e8 78 04 00 00       	call   4a0 <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 99 02 00 00       	call   2c9 <exit>
  }
  for(i=1; i<argc; i++)
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 e4 01 00 00       	call   237 <atoi>
      53:	83 c4 10             	add    $0x10,%esp
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	50                   	push   %eax
      5a:	e8 9a 02 00 00       	call   2f9 <kill>
      5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
      62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      66:	8b 45 f4             	mov    -0xc(%ebp),%eax
      69:	3b 03                	cmp    (%ebx),%eax
      6b:	7c cc                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
      6d:	e8 57 02 00 00       	call   2c9 <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      72:	55                   	push   %ebp
      73:	89 e5                	mov    %esp,%ebp
      75:	57                   	push   %edi
      76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      77:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7a:	8b 55 10             	mov    0x10(%ebp),%edx
      7d:	8b 45 0c             	mov    0xc(%ebp),%eax
      80:	89 cb                	mov    %ecx,%ebx
      82:	89 df                	mov    %ebx,%edi
      84:	89 d1                	mov    %edx,%ecx
      86:	fc                   	cld    
      87:	f3 aa                	rep stos %al,%es:(%edi)
      89:	89 ca                	mov    %ecx,%edx
      8b:	89 fb                	mov    %edi,%ebx
      8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
      90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      93:	90                   	nop
      94:	5b                   	pop    %ebx
      95:	5f                   	pop    %edi
      96:	5d                   	pop    %ebp
      97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      98:	55                   	push   %ebp
      99:	89 e5                	mov    %esp,%ebp
      9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      9e:	8b 45 08             	mov    0x8(%ebp),%eax
      a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a4:	90                   	nop
      a5:	8b 45 08             	mov    0x8(%ebp),%eax
      a8:	8d 50 01             	lea    0x1(%eax),%edx
      ab:	89 55 08             	mov    %edx,0x8(%ebp)
      ae:	8b 55 0c             	mov    0xc(%ebp),%edx
      b1:	8d 4a 01             	lea    0x1(%edx),%ecx
      b4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      b7:	0f b6 12             	movzbl (%edx),%edx
      ba:	88 10                	mov    %dl,(%eax)
      bc:	0f b6 00             	movzbl (%eax),%eax
      bf:	84 c0                	test   %al,%al
      c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
      c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c6:	c9                   	leave  
      c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c8:	55                   	push   %ebp
      c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
      cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      d5:	8b 45 08             	mov    0x8(%ebp),%eax
      d8:	0f b6 00             	movzbl (%eax),%eax
      db:	84 c0                	test   %al,%al
      dd:	74 10                	je     ef <strcmp+0x27>
      df:	8b 45 08             	mov    0x8(%ebp),%eax
      e2:	0f b6 10             	movzbl (%eax),%edx
      e5:	8b 45 0c             	mov    0xc(%ebp),%eax
      e8:	0f b6 00             	movzbl (%eax),%eax
      eb:	38 c2                	cmp    %al,%dl
      ed:	74 de                	je     cd <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      ef:	8b 45 08             	mov    0x8(%ebp),%eax
      f2:	0f b6 00             	movzbl (%eax),%eax
      f5:	0f b6 d0             	movzbl %al,%edx
      f8:	8b 45 0c             	mov    0xc(%ebp),%eax
      fb:	0f b6 00             	movzbl (%eax),%eax
      fe:	0f b6 c0             	movzbl %al,%eax
     101:	29 c2                	sub    %eax,%edx
     103:	89 d0                	mov    %edx,%eax
}
     105:	5d                   	pop    %ebp
     106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(char *s)
{
     107:	55                   	push   %ebp
     108:	89 e5                	mov    %esp,%ebp
     10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     114:	eb 04                	jmp    11a <strlen+0x13>
     116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11d:	8b 45 08             	mov    0x8(%ebp),%eax
     120:	01 d0                	add    %edx,%eax
     122:	0f b6 00             	movzbl (%eax),%eax
     125:	84 c0                	test   %al,%al
     127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
     129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12c:	c9                   	leave  
     12d:	c3                   	ret    

0000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
     12e:	55                   	push   %ebp
     12f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     131:	8b 45 10             	mov    0x10(%ebp),%eax
     134:	50                   	push   %eax
     135:	ff 75 0c             	pushl  0xc(%ebp)
     138:	ff 75 08             	pushl  0x8(%ebp)
     13b:	e8 32 ff ff ff       	call   72 <stosb>
     140:	83 c4 0c             	add    $0xc,%esp
  return dst;
     143:	8b 45 08             	mov    0x8(%ebp),%eax
}
     146:	c9                   	leave  
     147:	c3                   	ret    

00000148 <strchr>:

char*
strchr(const char *s, char c)
{
     148:	55                   	push   %ebp
     149:	89 e5                	mov    %esp,%ebp
     14b:	83 ec 04             	sub    $0x4,%esp
     14e:	8b 45 0c             	mov    0xc(%ebp),%eax
     151:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     154:	eb 14                	jmp    16a <strchr+0x22>
    if(*s == c)
     156:	8b 45 08             	mov    0x8(%ebp),%eax
     159:	0f b6 00             	movzbl (%eax),%eax
     15c:	3a 45 fc             	cmp    -0x4(%ebp),%al
     15f:	75 05                	jne    166 <strchr+0x1e>
      return (char*)s;
     161:	8b 45 08             	mov    0x8(%ebp),%eax
     164:	eb 13                	jmp    179 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16a:	8b 45 08             	mov    0x8(%ebp),%eax
     16d:	0f b6 00             	movzbl (%eax),%eax
     170:	84 c0                	test   %al,%al
     172:	75 e2                	jne    156 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     174:	b8 00 00 00 00       	mov    $0x0,%eax
}
     179:	c9                   	leave  
     17a:	c3                   	ret    

0000017b <gets>:

char*
gets(char *buf, int max)
{
     17b:	55                   	push   %ebp
     17c:	89 e5                	mov    %esp,%ebp
     17e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     188:	eb 42                	jmp    1cc <gets+0x51>
    cc = read(0, &c, 1);
     18a:	83 ec 04             	sub    $0x4,%esp
     18d:	6a 01                	push   $0x1
     18f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     192:	50                   	push   %eax
     193:	6a 00                	push   $0x0
     195:	e8 47 01 00 00       	call   2e1 <read>
     19a:	83 c4 10             	add    $0x10,%esp
     19d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1a4:	7e 33                	jle    1d9 <gets+0x5e>
      break;
    buf[i++] = c;
     1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1a9:	8d 50 01             	lea    0x1(%eax),%edx
     1ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1af:	89 c2                	mov    %eax,%edx
     1b1:	8b 45 08             	mov    0x8(%ebp),%eax
     1b4:	01 c2                	add    %eax,%edx
     1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ba:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c0:	3c 0a                	cmp    $0xa,%al
     1c2:	74 16                	je     1da <gets+0x5f>
     1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c8:	3c 0d                	cmp    $0xd,%al
     1ca:	74 0e                	je     1da <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1cf:	83 c0 01             	add    $0x1,%eax
     1d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1d5:	7c b3                	jl     18a <gets+0xf>
     1d7:	eb 01                	jmp    1da <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1d9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1dd:	8b 45 08             	mov    0x8(%ebp),%eax
     1e0:	01 d0                	add    %edx,%eax
     1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1e8:	c9                   	leave  
     1e9:	c3                   	ret    

000001ea <stat>:

int
stat(char *n, struct stat *st)
{
     1ea:	55                   	push   %ebp
     1eb:	89 e5                	mov    %esp,%ebp
     1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1f0:	83 ec 08             	sub    $0x8,%esp
     1f3:	6a 00                	push   $0x0
     1f5:	ff 75 08             	pushl  0x8(%ebp)
     1f8:	e8 0c 01 00 00       	call   309 <open>
     1fd:	83 c4 10             	add    $0x10,%esp
     200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     207:	79 07                	jns    210 <stat+0x26>
    return -1;
     209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
     210:	83 ec 08             	sub    $0x8,%esp
     213:	ff 75 0c             	pushl  0xc(%ebp)
     216:	ff 75 f4             	pushl  -0xc(%ebp)
     219:	e8 03 01 00 00       	call   321 <fstat>
     21e:	83 c4 10             	add    $0x10,%esp
     221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     224:	83 ec 0c             	sub    $0xc,%esp
     227:	ff 75 f4             	pushl  -0xc(%ebp)
     22a:	e8 c2 00 00 00       	call   2f1 <close>
     22f:	83 c4 10             	add    $0x10,%esp
  return r;
     232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     235:	c9                   	leave  
     236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
     237:	55                   	push   %ebp
     238:	89 e5                	mov    %esp,%ebp
     23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
     246:	8b 55 fc             	mov    -0x4(%ebp),%edx
     249:	89 d0                	mov    %edx,%eax
     24b:	c1 e0 02             	shl    $0x2,%eax
     24e:	01 d0                	add    %edx,%eax
     250:	01 c0                	add    %eax,%eax
     252:	89 c1                	mov    %eax,%ecx
     254:	8b 45 08             	mov    0x8(%ebp),%eax
     257:	8d 50 01             	lea    0x1(%eax),%edx
     25a:	89 55 08             	mov    %edx,0x8(%ebp)
     25d:	0f b6 00             	movzbl (%eax),%eax
     260:	0f be c0             	movsbl %al,%eax
     263:	01 c8                	add    %ecx,%eax
     265:	83 e8 30             	sub    $0x30,%eax
     268:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     26b:	8b 45 08             	mov    0x8(%ebp),%eax
     26e:	0f b6 00             	movzbl (%eax),%eax
     271:	3c 2f                	cmp    $0x2f,%al
     273:	7e 0a                	jle    27f <atoi+0x48>
     275:	8b 45 08             	mov    0x8(%ebp),%eax
     278:	0f b6 00             	movzbl (%eax),%eax
     27b:	3c 39                	cmp    $0x39,%al
     27d:	7e c7                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     282:	c9                   	leave  
     283:	c3                   	ret    

00000284 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     284:	55                   	push   %ebp
     285:	89 e5                	mov    %esp,%ebp
     287:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     28a:	8b 45 08             	mov    0x8(%ebp),%eax
     28d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     290:	8b 45 0c             	mov    0xc(%ebp),%eax
     293:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     296:	eb 17                	jmp    2af <memmove+0x2b>
    *dst++ = *src++;
     298:	8b 45 fc             	mov    -0x4(%ebp),%eax
     29b:	8d 50 01             	lea    0x1(%eax),%edx
     29e:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2a4:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a7:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2aa:	0f b6 12             	movzbl (%edx),%edx
     2ad:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2af:	8b 45 10             	mov    0x10(%ebp),%eax
     2b2:	8d 50 ff             	lea    -0x1(%eax),%edx
     2b5:	89 55 10             	mov    %edx,0x10(%ebp)
     2b8:	85 c0                	test   %eax,%eax
     2ba:	7f dc                	jg     298 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2bf:	c9                   	leave  
     2c0:	c3                   	ret    

000002c1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2c1:	b8 01 00 00 00       	mov    $0x1,%eax
     2c6:	cd 40                	int    $0x40
     2c8:	c3                   	ret    

000002c9 <exit>:
SYSCALL(exit)
     2c9:	b8 02 00 00 00       	mov    $0x2,%eax
     2ce:	cd 40                	int    $0x40
     2d0:	c3                   	ret    

000002d1 <wait>:
SYSCALL(wait)
     2d1:	b8 03 00 00 00       	mov    $0x3,%eax
     2d6:	cd 40                	int    $0x40
     2d8:	c3                   	ret    

000002d9 <pipe>:
SYSCALL(pipe)
     2d9:	b8 04 00 00 00       	mov    $0x4,%eax
     2de:	cd 40                	int    $0x40
     2e0:	c3                   	ret    

000002e1 <read>:
SYSCALL(read)
     2e1:	b8 05 00 00 00       	mov    $0x5,%eax
     2e6:	cd 40                	int    $0x40
     2e8:	c3                   	ret    

000002e9 <write>:
SYSCALL(write)
     2e9:	b8 10 00 00 00       	mov    $0x10,%eax
     2ee:	cd 40                	int    $0x40
     2f0:	c3                   	ret    

000002f1 <close>:
SYSCALL(close)
     2f1:	b8 15 00 00 00       	mov    $0x15,%eax
     2f6:	cd 40                	int    $0x40
     2f8:	c3                   	ret    

000002f9 <kill>:
SYSCALL(kill)
     2f9:	b8 06 00 00 00       	mov    $0x6,%eax
     2fe:	cd 40                	int    $0x40
     300:	c3                   	ret    

00000301 <exec>:
SYSCALL(exec)
     301:	b8 07 00 00 00       	mov    $0x7,%eax
     306:	cd 40                	int    $0x40
     308:	c3                   	ret    

00000309 <open>:
SYSCALL(open)
     309:	b8 0f 00 00 00       	mov    $0xf,%eax
     30e:	cd 40                	int    $0x40
     310:	c3                   	ret    

00000311 <mknod>:
SYSCALL(mknod)
     311:	b8 11 00 00 00       	mov    $0x11,%eax
     316:	cd 40                	int    $0x40
     318:	c3                   	ret    

00000319 <unlink>:
SYSCALL(unlink)
     319:	b8 12 00 00 00       	mov    $0x12,%eax
     31e:	cd 40                	int    $0x40
     320:	c3                   	ret    

00000321 <fstat>:
SYSCALL(fstat)
     321:	b8 08 00 00 00       	mov    $0x8,%eax
     326:	cd 40                	int    $0x40
     328:	c3                   	ret    

00000329 <link>:
SYSCALL(link)
     329:	b8 13 00 00 00       	mov    $0x13,%eax
     32e:	cd 40                	int    $0x40
     330:	c3                   	ret    

00000331 <mkdir>:
SYSCALL(mkdir)
     331:	b8 14 00 00 00       	mov    $0x14,%eax
     336:	cd 40                	int    $0x40
     338:	c3                   	ret    

00000339 <chdir>:
SYSCALL(chdir)
     339:	b8 09 00 00 00       	mov    $0x9,%eax
     33e:	cd 40                	int    $0x40
     340:	c3                   	ret    

00000341 <dup>:
SYSCALL(dup)
     341:	b8 0a 00 00 00       	mov    $0xa,%eax
     346:	cd 40                	int    $0x40
     348:	c3                   	ret    

00000349 <getpid>:
SYSCALL(getpid)
     349:	b8 0b 00 00 00       	mov    $0xb,%eax
     34e:	cd 40                	int    $0x40
     350:	c3                   	ret    

00000351 <sbrk>:
SYSCALL(sbrk)
     351:	b8 0c 00 00 00       	mov    $0xc,%eax
     356:	cd 40                	int    $0x40
     358:	c3                   	ret    

00000359 <sleep>:
SYSCALL(sleep)
     359:	b8 0d 00 00 00       	mov    $0xd,%eax
     35e:	cd 40                	int    $0x40
     360:	c3                   	ret    

00000361 <uptime>:
SYSCALL(uptime)
     361:	b8 0e 00 00 00       	mov    $0xe,%eax
     366:	cd 40                	int    $0x40
     368:	c3                   	ret    

00000369 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     369:	b8 16 00 00 00       	mov    $0x16,%eax
     36e:	cd 40                	int    $0x40
     370:	c3                   	ret    

00000371 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     371:	b8 17 00 00 00       	mov    $0x17,%eax
     376:	cd 40                	int    $0x40
     378:	c3                   	ret    

00000379 <clearScreen>:
SYSCALL(clearScreen)
     379:	b8 18 00 00 00       	mov    $0x18,%eax
     37e:	cd 40                	int    $0x40
     380:	c3                   	ret    

00000381 <writeAt>:
SYSCALL(writeAt)
     381:	b8 19 00 00 00       	mov    $0x19,%eax
     386:	cd 40                	int    $0x40
     388:	c3                   	ret    

00000389 <setBufferFlag>:
SYSCALL(setBufferFlag)
     389:	b8 1a 00 00 00       	mov    $0x1a,%eax
     38e:	cd 40                	int    $0x40
     390:	c3                   	ret    

00000391 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     391:	b8 1b 00 00 00       	mov    $0x1b,%eax
     396:	cd 40                	int    $0x40
     398:	c3                   	ret    

00000399 <getCursorPos>:
SYSCALL(getCursorPos)
     399:	b8 1c 00 00 00       	mov    $0x1c,%eax
     39e:	cd 40                	int    $0x40
     3a0:	c3                   	ret    

000003a1 <saveScreen>:
SYSCALL(saveScreen)
     3a1:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <recorverScreen>:
SYSCALL(recorverScreen)
     3a9:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <ToScreen>:
SYSCALL(ToScreen)
     3b1:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3b6:	cd 40                	int    $0x40
     3b8:	c3                   	ret    

000003b9 <getColor>:
SYSCALL(getColor)
     3b9:	b8 20 00 00 00       	mov    $0x20,%eax
     3be:	cd 40                	int    $0x40
     3c0:	c3                   	ret    

000003c1 <showC>:
SYSCALL(showC)
     3c1:	b8 21 00 00 00       	mov    $0x21,%eax
     3c6:	cd 40                	int    $0x40
     3c8:	c3                   	ret    

000003c9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3c9:	55                   	push   %ebp
     3ca:	89 e5                	mov    %esp,%ebp
     3cc:	83 ec 18             	sub    $0x18,%esp
     3cf:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3d5:	83 ec 04             	sub    $0x4,%esp
     3d8:	6a 01                	push   $0x1
     3da:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3dd:	50                   	push   %eax
     3de:	ff 75 08             	pushl  0x8(%ebp)
     3e1:	e8 03 ff ff ff       	call   2e9 <write>
     3e6:	83 c4 10             	add    $0x10,%esp
}
     3e9:	90                   	nop
     3ea:	c9                   	leave  
     3eb:	c3                   	ret    

000003ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3ec:	55                   	push   %ebp
     3ed:	89 e5                	mov    %esp,%ebp
     3ef:	53                   	push   %ebx
     3f0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3fe:	74 17                	je     417 <printint+0x2b>
     400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     404:	79 11                	jns    417 <printint+0x2b>
    neg = 1;
     406:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     40d:	8b 45 0c             	mov    0xc(%ebp),%eax
     410:	f7 d8                	neg    %eax
     412:	89 45 ec             	mov    %eax,-0x14(%ebp)
     415:	eb 06                	jmp    41d <printint+0x31>
  } else {
    x = xx;
     417:	8b 45 0c             	mov    0xc(%ebp),%eax
     41a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     41d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     424:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     427:	8d 41 01             	lea    0x1(%ecx),%eax
     42a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     42d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     430:	8b 45 ec             	mov    -0x14(%ebp),%eax
     433:	ba 00 00 00 00       	mov    $0x0,%edx
     438:	f7 f3                	div    %ebx
     43a:	89 d0                	mov    %edx,%eax
     43c:	0f b6 80 c0 19 00 00 	movzbl 0x19c0(%eax),%eax
     443:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     447:	8b 5d 10             	mov    0x10(%ebp),%ebx
     44a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     44d:	ba 00 00 00 00       	mov    $0x0,%edx
     452:	f7 f3                	div    %ebx
     454:	89 45 ec             	mov    %eax,-0x14(%ebp)
     457:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     45b:	75 c7                	jne    424 <printint+0x38>
  if(neg)
     45d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     461:	74 2d                	je     490 <printint+0xa4>
    buf[i++] = '-';
     463:	8b 45 f4             	mov    -0xc(%ebp),%eax
     466:	8d 50 01             	lea    0x1(%eax),%edx
     469:	89 55 f4             	mov    %edx,-0xc(%ebp)
     46c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     471:	eb 1d                	jmp    490 <printint+0xa4>
    putc(fd, buf[i]);
     473:	8d 55 dc             	lea    -0x24(%ebp),%edx
     476:	8b 45 f4             	mov    -0xc(%ebp),%eax
     479:	01 d0                	add    %edx,%eax
     47b:	0f b6 00             	movzbl (%eax),%eax
     47e:	0f be c0             	movsbl %al,%eax
     481:	83 ec 08             	sub    $0x8,%esp
     484:	50                   	push   %eax
     485:	ff 75 08             	pushl  0x8(%ebp)
     488:	e8 3c ff ff ff       	call   3c9 <putc>
     48d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     490:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     494:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     498:	79 d9                	jns    473 <printint+0x87>
    putc(fd, buf[i]);
}
     49a:	90                   	nop
     49b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     49e:	c9                   	leave  
     49f:	c3                   	ret    

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4ad:	8d 45 0c             	lea    0xc(%ebp),%eax
     4b0:	83 c0 04             	add    $0x4,%eax
     4b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4bd:	e9 59 01 00 00       	jmp    61b <printf+0x17b>
    c = fmt[i] & 0xff;
     4c2:	8b 55 0c             	mov    0xc(%ebp),%edx
     4c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4c8:	01 d0                	add    %edx,%eax
     4ca:	0f b6 00             	movzbl (%eax),%eax
     4cd:	0f be c0             	movsbl %al,%eax
     4d0:	25 ff 00 00 00       	and    $0xff,%eax
     4d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4dc:	75 2c                	jne    50a <printf+0x6a>
      if(c == '%'){
     4de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4e2:	75 0c                	jne    4f0 <printf+0x50>
        state = '%';
     4e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4eb:	e9 27 01 00 00       	jmp    617 <printf+0x177>
      } else {
        putc(fd, c);
     4f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4f3:	0f be c0             	movsbl %al,%eax
     4f6:	83 ec 08             	sub    $0x8,%esp
     4f9:	50                   	push   %eax
     4fa:	ff 75 08             	pushl  0x8(%ebp)
     4fd:	e8 c7 fe ff ff       	call   3c9 <putc>
     502:	83 c4 10             	add    $0x10,%esp
     505:	e9 0d 01 00 00       	jmp    617 <printf+0x177>
      }
    } else if(state == '%'){
     50a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     50e:	0f 85 03 01 00 00    	jne    617 <printf+0x177>
      if(c == 'd'){
     514:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     518:	75 1e                	jne    538 <printf+0x98>
        printint(fd, *ap, 10, 1);
     51a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     51d:	8b 00                	mov    (%eax),%eax
     51f:	6a 01                	push   $0x1
     521:	6a 0a                	push   $0xa
     523:	50                   	push   %eax
     524:	ff 75 08             	pushl  0x8(%ebp)
     527:	e8 c0 fe ff ff       	call   3ec <printint>
     52c:	83 c4 10             	add    $0x10,%esp
        ap++;
     52f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     533:	e9 d8 00 00 00       	jmp    610 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     538:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     53c:	74 06                	je     544 <printf+0xa4>
     53e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     542:	75 1e                	jne    562 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     544:	8b 45 e8             	mov    -0x18(%ebp),%eax
     547:	8b 00                	mov    (%eax),%eax
     549:	6a 00                	push   $0x0
     54b:	6a 10                	push   $0x10
     54d:	50                   	push   %eax
     54e:	ff 75 08             	pushl  0x8(%ebp)
     551:	e8 96 fe ff ff       	call   3ec <printint>
     556:	83 c4 10             	add    $0x10,%esp
        ap++;
     559:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     55d:	e9 ae 00 00 00       	jmp    610 <printf+0x170>
      } else if(c == 's'){
     562:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     566:	75 43                	jne    5ab <printf+0x10b>
        s = (char*)*ap;
     568:	8b 45 e8             	mov    -0x18(%ebp),%eax
     56b:	8b 00                	mov    (%eax),%eax
     56d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     570:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     574:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     578:	75 25                	jne    59f <printf+0xff>
          s = "(null)";
     57a:	c7 45 f4 a0 12 00 00 	movl   $0x12a0,-0xc(%ebp)
        while(*s != 0){
     581:	eb 1c                	jmp    59f <printf+0xff>
          putc(fd, *s);
     583:	8b 45 f4             	mov    -0xc(%ebp),%eax
     586:	0f b6 00             	movzbl (%eax),%eax
     589:	0f be c0             	movsbl %al,%eax
     58c:	83 ec 08             	sub    $0x8,%esp
     58f:	50                   	push   %eax
     590:	ff 75 08             	pushl  0x8(%ebp)
     593:	e8 31 fe ff ff       	call   3c9 <putc>
     598:	83 c4 10             	add    $0x10,%esp
          s++;
     59b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a2:	0f b6 00             	movzbl (%eax),%eax
     5a5:	84 c0                	test   %al,%al
     5a7:	75 da                	jne    583 <printf+0xe3>
     5a9:	eb 65                	jmp    610 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     5ab:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5af:	75 1d                	jne    5ce <printf+0x12e>
        putc(fd, *ap);
     5b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5b4:	8b 00                	mov    (%eax),%eax
     5b6:	0f be c0             	movsbl %al,%eax
     5b9:	83 ec 08             	sub    $0x8,%esp
     5bc:	50                   	push   %eax
     5bd:	ff 75 08             	pushl  0x8(%ebp)
     5c0:	e8 04 fe ff ff       	call   3c9 <putc>
     5c5:	83 c4 10             	add    $0x10,%esp
        ap++;
     5c8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5cc:	eb 42                	jmp    610 <printf+0x170>
      } else if(c == '%'){
     5ce:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5d2:	75 17                	jne    5eb <printf+0x14b>
        putc(fd, c);
     5d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d7:	0f be c0             	movsbl %al,%eax
     5da:	83 ec 08             	sub    $0x8,%esp
     5dd:	50                   	push   %eax
     5de:	ff 75 08             	pushl  0x8(%ebp)
     5e1:	e8 e3 fd ff ff       	call   3c9 <putc>
     5e6:	83 c4 10             	add    $0x10,%esp
     5e9:	eb 25                	jmp    610 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5eb:	83 ec 08             	sub    $0x8,%esp
     5ee:	6a 25                	push   $0x25
     5f0:	ff 75 08             	pushl  0x8(%ebp)
     5f3:	e8 d1 fd ff ff       	call   3c9 <putc>
     5f8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5fe:	0f be c0             	movsbl %al,%eax
     601:	83 ec 08             	sub    $0x8,%esp
     604:	50                   	push   %eax
     605:	ff 75 08             	pushl  0x8(%ebp)
     608:	e8 bc fd ff ff       	call   3c9 <putc>
     60d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     610:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     617:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     61b:	8b 55 0c             	mov    0xc(%ebp),%edx
     61e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     621:	01 d0                	add    %edx,%eax
     623:	0f b6 00             	movzbl (%eax),%eax
     626:	84 c0                	test   %al,%al
     628:	0f 85 94 fe ff ff    	jne    4c2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     62e:	90                   	nop
     62f:	c9                   	leave  
     630:	c3                   	ret    

00000631 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     631:	55                   	push   %ebp
     632:	89 e5                	mov    %esp,%ebp
     634:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     637:	8b 45 08             	mov    0x8(%ebp),%eax
     63a:	83 e8 08             	sub    $0x8,%eax
     63d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     640:	a1 e8 19 00 00       	mov    0x19e8,%eax
     645:	89 45 fc             	mov    %eax,-0x4(%ebp)
     648:	eb 24                	jmp    66e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     64a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64d:	8b 00                	mov    (%eax),%eax
     64f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     652:	77 12                	ja     666 <free+0x35>
     654:	8b 45 f8             	mov    -0x8(%ebp),%eax
     657:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     65a:	77 24                	ja     680 <free+0x4f>
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     664:	77 1a                	ja     680 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     666:	8b 45 fc             	mov    -0x4(%ebp),%eax
     669:	8b 00                	mov    (%eax),%eax
     66b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     671:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     674:	76 d4                	jbe    64a <free+0x19>
     676:	8b 45 fc             	mov    -0x4(%ebp),%eax
     679:	8b 00                	mov    (%eax),%eax
     67b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     67e:	76 ca                	jbe    64a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     680:	8b 45 f8             	mov    -0x8(%ebp),%eax
     683:	8b 40 04             	mov    0x4(%eax),%eax
     686:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     690:	01 c2                	add    %eax,%edx
     692:	8b 45 fc             	mov    -0x4(%ebp),%eax
     695:	8b 00                	mov    (%eax),%eax
     697:	39 c2                	cmp    %eax,%edx
     699:	75 24                	jne    6bf <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69e:	8b 50 04             	mov    0x4(%eax),%edx
     6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a4:	8b 00                	mov    (%eax),%eax
     6a6:	8b 40 04             	mov    0x4(%eax),%eax
     6a9:	01 c2                	add    %eax,%edx
     6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ae:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	8b 00                	mov    (%eax),%eax
     6b6:	8b 10                	mov    (%eax),%edx
     6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bb:	89 10                	mov    %edx,(%eax)
     6bd:	eb 0a                	jmp    6c9 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c2:	8b 10                	mov    (%eax),%edx
     6c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	8b 40 04             	mov    0x4(%eax),%eax
     6cf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d9:	01 d0                	add    %edx,%eax
     6db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6de:	75 20                	jne    700 <free+0xcf>
    p->s.size += bp->s.size;
     6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e3:	8b 50 04             	mov    0x4(%eax),%edx
     6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e9:	8b 40 04             	mov    0x4(%eax),%eax
     6ec:	01 c2                	add    %eax,%edx
     6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f7:	8b 10                	mov    (%eax),%edx
     6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fc:	89 10                	mov    %edx,(%eax)
     6fe:	eb 08                	jmp    708 <free+0xd7>
  } else
    p->s.ptr = bp;
     700:	8b 45 fc             	mov    -0x4(%ebp),%eax
     703:	8b 55 f8             	mov    -0x8(%ebp),%edx
     706:	89 10                	mov    %edx,(%eax)
  freep = p;
     708:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70b:	a3 e8 19 00 00       	mov    %eax,0x19e8
}
     710:	90                   	nop
     711:	c9                   	leave  
     712:	c3                   	ret    

00000713 <morecore>:

static Header*
morecore(uint nu)
{
     713:	55                   	push   %ebp
     714:	89 e5                	mov    %esp,%ebp
     716:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     719:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     720:	77 07                	ja     729 <morecore+0x16>
    nu = 4096;
     722:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     729:	8b 45 08             	mov    0x8(%ebp),%eax
     72c:	c1 e0 03             	shl    $0x3,%eax
     72f:	83 ec 0c             	sub    $0xc,%esp
     732:	50                   	push   %eax
     733:	e8 19 fc ff ff       	call   351 <sbrk>
     738:	83 c4 10             	add    $0x10,%esp
     73b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     73e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     742:	75 07                	jne    74b <morecore+0x38>
    return 0;
     744:	b8 00 00 00 00       	mov    $0x0,%eax
     749:	eb 26                	jmp    771 <morecore+0x5e>
  hp = (Header*)p;
     74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     751:	8b 45 f0             	mov    -0x10(%ebp),%eax
     754:	8b 55 08             	mov    0x8(%ebp),%edx
     757:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75d:	83 c0 08             	add    $0x8,%eax
     760:	83 ec 0c             	sub    $0xc,%esp
     763:	50                   	push   %eax
     764:	e8 c8 fe ff ff       	call   631 <free>
     769:	83 c4 10             	add    $0x10,%esp
  return freep;
     76c:	a1 e8 19 00 00       	mov    0x19e8,%eax
}
     771:	c9                   	leave  
     772:	c3                   	ret    

00000773 <malloc>:

void*
malloc(uint nbytes)
{
     773:	55                   	push   %ebp
     774:	89 e5                	mov    %esp,%ebp
     776:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     779:	8b 45 08             	mov    0x8(%ebp),%eax
     77c:	83 c0 07             	add    $0x7,%eax
     77f:	c1 e8 03             	shr    $0x3,%eax
     782:	83 c0 01             	add    $0x1,%eax
     785:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     788:	a1 e8 19 00 00       	mov    0x19e8,%eax
     78d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     790:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     794:	75 23                	jne    7b9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     796:	c7 45 f0 e0 19 00 00 	movl   $0x19e0,-0x10(%ebp)
     79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a0:	a3 e8 19 00 00       	mov    %eax,0x19e8
     7a5:	a1 e8 19 00 00       	mov    0x19e8,%eax
     7aa:	a3 e0 19 00 00       	mov    %eax,0x19e0
    base.s.size = 0;
     7af:	c7 05 e4 19 00 00 00 	movl   $0x0,0x19e4
     7b6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7bc:	8b 00                	mov    (%eax),%eax
     7be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c4:	8b 40 04             	mov    0x4(%eax),%eax
     7c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7ca:	72 4d                	jb     819 <malloc+0xa6>
      if(p->s.size == nunits)
     7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cf:	8b 40 04             	mov    0x4(%eax),%eax
     7d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7d5:	75 0c                	jne    7e3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7da:	8b 10                	mov    (%eax),%edx
     7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7df:	89 10                	mov    %edx,(%eax)
     7e1:	eb 26                	jmp    809 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e6:	8b 40 04             	mov    0x4(%eax),%eax
     7e9:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7ec:	89 c2                	mov    %eax,%edx
     7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f7:	8b 40 04             	mov    0x4(%eax),%eax
     7fa:	c1 e0 03             	shl    $0x3,%eax
     7fd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     800:	8b 45 f4             	mov    -0xc(%ebp),%eax
     803:	8b 55 ec             	mov    -0x14(%ebp),%edx
     806:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     809:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80c:	a3 e8 19 00 00       	mov    %eax,0x19e8
      return (void*)(p + 1);
     811:	8b 45 f4             	mov    -0xc(%ebp),%eax
     814:	83 c0 08             	add    $0x8,%eax
     817:	eb 3b                	jmp    854 <malloc+0xe1>
    }
    if(p == freep)
     819:	a1 e8 19 00 00       	mov    0x19e8,%eax
     81e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     821:	75 1e                	jne    841 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     823:	83 ec 0c             	sub    $0xc,%esp
     826:	ff 75 ec             	pushl  -0x14(%ebp)
     829:	e8 e5 fe ff ff       	call   713 <morecore>
     82e:	83 c4 10             	add    $0x10,%esp
     831:	89 45 f4             	mov    %eax,-0xc(%ebp)
     834:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     838:	75 07                	jne    841 <malloc+0xce>
        return 0;
     83a:	b8 00 00 00 00       	mov    $0x0,%eax
     83f:	eb 13                	jmp    854 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     841:	8b 45 f4             	mov    -0xc(%ebp),%eax
     844:	89 45 f0             	mov    %eax,-0x10(%ebp)
     847:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84a:	8b 00                	mov    (%eax),%eax
     84c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     84f:	e9 6d ff ff ff       	jmp    7c1 <malloc+0x4e>
}
     854:	c9                   	leave  
     855:	c3                   	ret    

00000856 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     856:	55                   	push   %ebp
     857:	89 e5                	mov    %esp,%ebp
     859:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     85c:	83 ec 0c             	sub    $0xc,%esp
     85f:	ff 75 08             	pushl  0x8(%ebp)
     862:	e8 b0 00 00 00       	call   917 <re_compile>
     867:	83 c4 10             	add    $0x10,%esp
     86a:	83 ec 04             	sub    $0x4,%esp
     86d:	ff 75 10             	pushl  0x10(%ebp)
     870:	ff 75 0c             	pushl  0xc(%ebp)
     873:	50                   	push   %eax
     874:	e8 05 00 00 00       	call   87e <re_matchp>
     879:	83 c4 10             	add    $0x10,%esp
}
     87c:	c9                   	leave  
     87d:	c3                   	ret    

0000087e <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     87e:	55                   	push   %ebp
     87f:	89 e5                	mov    %esp,%ebp
     881:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     884:	8b 45 10             	mov    0x10(%ebp),%eax
     887:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     88d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     891:	74 7d                	je     910 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     893:	8b 45 08             	mov    0x8(%ebp),%eax
     896:	0f b6 00             	movzbl (%eax),%eax
     899:	3c 02                	cmp    $0x2,%al
     89b:	75 2a                	jne    8c7 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     89d:	8b 45 08             	mov    0x8(%ebp),%eax
     8a0:	83 c0 08             	add    $0x8,%eax
     8a3:	83 ec 04             	sub    $0x4,%esp
     8a6:	ff 75 10             	pushl  0x10(%ebp)
     8a9:	ff 75 0c             	pushl  0xc(%ebp)
     8ac:	50                   	push   %eax
     8ad:	e8 b0 08 00 00       	call   1162 <matchpattern>
     8b2:	83 c4 10             	add    $0x10,%esp
     8b5:	85 c0                	test   %eax,%eax
     8b7:	74 07                	je     8c0 <re_matchp+0x42>
     8b9:	b8 00 00 00 00       	mov    $0x0,%eax
     8be:	eb 55                	jmp    915 <re_matchp+0x97>
     8c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8c5:	eb 4e                	jmp    915 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     8c7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     8ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     8d2:	83 ec 04             	sub    $0x4,%esp
     8d5:	ff 75 10             	pushl  0x10(%ebp)
     8d8:	ff 75 0c             	pushl  0xc(%ebp)
     8db:	ff 75 08             	pushl  0x8(%ebp)
     8de:	e8 7f 08 00 00       	call   1162 <matchpattern>
     8e3:	83 c4 10             	add    $0x10,%esp
     8e6:	85 c0                	test   %eax,%eax
     8e8:	74 16                	je     900 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     8ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ed:	0f b6 00             	movzbl (%eax),%eax
     8f0:	84 c0                	test   %al,%al
     8f2:	75 07                	jne    8fb <re_matchp+0x7d>
            return -1;
     8f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8f9:	eb 1a                	jmp    915 <re_matchp+0x97>
        
          return idx;
     8fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fe:	eb 15                	jmp    915 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     900:	8b 45 0c             	mov    0xc(%ebp),%eax
     903:	8d 50 01             	lea    0x1(%eax),%edx
     906:	89 55 0c             	mov    %edx,0xc(%ebp)
     909:	0f b6 00             	movzbl (%eax),%eax
     90c:	84 c0                	test   %al,%al
     90e:	75 be                	jne    8ce <re_matchp+0x50>
    }
  }
  return -1;
     910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     915:	c9                   	leave  
     916:	c3                   	ret    

00000917 <re_compile>:

re_t re_compile(const char* pattern)
{
     917:	55                   	push   %ebp
     918:	89 e5                	mov    %esp,%ebp
     91a:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     91d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     924:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     92b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     932:	e9 55 02 00 00       	jmp    b8c <re_compile+0x275>
  {
    c = pattern[i];
     937:	8b 55 f8             	mov    -0x8(%ebp),%edx
     93a:	8b 45 08             	mov    0x8(%ebp),%eax
     93d:	01 d0                	add    %edx,%eax
     93f:	0f b6 00             	movzbl (%eax),%eax
     942:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     945:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     949:	83 e8 24             	sub    $0x24,%eax
     94c:	83 f8 3a             	cmp    $0x3a,%eax
     94f:	0f 87 13 02 00 00    	ja     b68 <re_compile+0x251>
     955:	8b 04 85 a8 12 00 00 	mov    0x12a8(,%eax,4),%eax
     95c:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     95e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     961:	c6 04 c5 00 1a 00 00 	movb   $0x2,0x1a00(,%eax,8)
     968:	02 
     969:	e9 16 02 00 00       	jmp    b84 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     971:	c6 04 c5 00 1a 00 00 	movb   $0x3,0x1a00(,%eax,8)
     978:	03 
     979:	e9 06 02 00 00       	jmp    b84 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     97e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     981:	c6 04 c5 00 1a 00 00 	movb   $0x1,0x1a00(,%eax,8)
     988:	01 
     989:	e9 f6 01 00 00       	jmp    b84 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     991:	c6 04 c5 00 1a 00 00 	movb   $0x5,0x1a00(,%eax,8)
     998:	05 
     999:	e9 e6 01 00 00       	jmp    b84 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     99e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a1:	c6 04 c5 00 1a 00 00 	movb   $0x6,0x1a00(,%eax,8)
     9a8:	06 
     9a9:	e9 d6 01 00 00       	jmp    b84 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     9ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b1:	c6 04 c5 00 1a 00 00 	movb   $0x4,0x1a00(,%eax,8)
     9b8:	04 
     9b9:	e9 c6 01 00 00       	jmp    b84 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     9be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9c1:	8d 50 01             	lea    0x1(%eax),%edx
     9c4:	8b 45 08             	mov    0x8(%ebp),%eax
     9c7:	01 d0                	add    %edx,%eax
     9c9:	0f b6 00             	movzbl (%eax),%eax
     9cc:	84 c0                	test   %al,%al
     9ce:	0f 84 af 01 00 00    	je     b83 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     9d4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     9d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9db:	8b 45 08             	mov    0x8(%ebp),%eax
     9de:	01 d0                	add    %edx,%eax
     9e0:	0f b6 00             	movzbl (%eax),%eax
     9e3:	0f be c0             	movsbl %al,%eax
     9e6:	83 e8 44             	sub    $0x44,%eax
     9e9:	83 f8 33             	cmp    $0x33,%eax
     9ec:	77 57                	ja     a45 <re_compile+0x12e>
     9ee:	8b 04 85 94 13 00 00 	mov    0x1394(,%eax,4),%eax
     9f5:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     9f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fa:	c6 04 c5 00 1a 00 00 	movb   $0xa,0x1a00(,%eax,8)
     a01:	0a 
     a02:	eb 64                	jmp    a68 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a07:	c6 04 c5 00 1a 00 00 	movb   $0xb,0x1a00(,%eax,8)
     a0e:	0b 
     a0f:	eb 57                	jmp    a68 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a14:	c6 04 c5 00 1a 00 00 	movb   $0xc,0x1a00(,%eax,8)
     a1b:	0c 
     a1c:	eb 4a                	jmp    a68 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a21:	c6 04 c5 00 1a 00 00 	movb   $0xd,0x1a00(,%eax,8)
     a28:	0d 
     a29:	eb 3d                	jmp    a68 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	c6 04 c5 00 1a 00 00 	movb   $0xe,0x1a00(,%eax,8)
     a35:	0e 
     a36:	eb 30                	jmp    a68 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3b:	c6 04 c5 00 1a 00 00 	movb   $0xf,0x1a00(,%eax,8)
     a42:	0f 
     a43:	eb 23                	jmp    a68 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a48:	c6 04 c5 00 1a 00 00 	movb   $0x7,0x1a00(,%eax,8)
     a4f:	07 
              re_compiled[j].ch = pattern[i];
     a50:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a53:	8b 45 08             	mov    0x8(%ebp),%eax
     a56:	01 d0                	add    %edx,%eax
     a58:	0f b6 00             	movzbl (%eax),%eax
     a5b:	89 c2                	mov    %eax,%edx
     a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a60:	88 14 c5 04 1a 00 00 	mov    %dl,0x1a04(,%eax,8)
            } break;
     a67:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a68:	e9 16 01 00 00       	jmp    b83 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a70:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a73:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a76:	8d 50 01             	lea    0x1(%eax),%edx
     a79:	8b 45 08             	mov    0x8(%ebp),%eax
     a7c:	01 d0                	add    %edx,%eax
     a7e:	0f b6 00             	movzbl (%eax),%eax
     a81:	3c 5e                	cmp    $0x5e,%al
     a83:	75 11                	jne    a96 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a88:	c6 04 c5 00 1a 00 00 	movb   $0x9,0x1a00(,%eax,8)
     a8f:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     a90:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     a94:	eb 7a                	jmp    b10 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     a96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a99:	c6 04 c5 00 1a 00 00 	movb   $0x8,0x1a00(,%eax,8)
     aa0:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     aa1:	eb 6d                	jmp    b10 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     aa3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     aa6:	8b 45 08             	mov    0x8(%ebp),%eax
     aa9:	01 d0                	add    %edx,%eax
     aab:	0f b6 00             	movzbl (%eax),%eax
     aae:	3c 5c                	cmp    $0x5c,%al
     ab0:	75 34                	jne    ae6 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     ab2:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     ab6:	7e 0a                	jle    ac2 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     ab8:	b8 00 00 00 00       	mov    $0x0,%eax
     abd:	e9 f8 00 00 00       	jmp    bba <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ac2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ac5:	8d 50 01             	lea    0x1(%eax),%edx
     ac8:	89 55 fc             	mov    %edx,-0x4(%ebp)
     acb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ace:	8d 4a 01             	lea    0x1(%edx),%ecx
     ad1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ad4:	89 d1                	mov    %edx,%ecx
     ad6:	8b 55 08             	mov    0x8(%ebp),%edx
     ad9:	01 ca                	add    %ecx,%edx
     adb:	0f b6 12             	movzbl (%edx),%edx
     ade:	88 90 00 1b 00 00    	mov    %dl,0x1b00(%eax)
     ae4:	eb 10                	jmp    af6 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     ae6:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     aea:	7e 0a                	jle    af6 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aec:	b8 00 00 00 00       	mov    $0x0,%eax
     af1:	e9 c4 00 00 00       	jmp    bba <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     af6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     af9:	8d 50 01             	lea    0x1(%eax),%edx
     afc:	89 55 fc             	mov    %edx,-0x4(%ebp)
     aff:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     b02:	8b 55 08             	mov    0x8(%ebp),%edx
     b05:	01 ca                	add    %ecx,%edx
     b07:	0f b6 12             	movzbl (%edx),%edx
     b0a:	88 90 00 1b 00 00    	mov    %dl,0x1b00(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b10:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b14:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b17:	8b 45 08             	mov    0x8(%ebp),%eax
     b1a:	01 d0                	add    %edx,%eax
     b1c:	0f b6 00             	movzbl (%eax),%eax
     b1f:	3c 5d                	cmp    $0x5d,%al
     b21:	74 13                	je     b36 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     b23:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b26:	8b 45 08             	mov    0x8(%ebp),%eax
     b29:	01 d0                	add    %edx,%eax
     b2b:	0f b6 00             	movzbl (%eax),%eax
     b2e:	84 c0                	test   %al,%al
     b30:	0f 85 6d ff ff ff    	jne    aa3 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b36:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b3a:	7e 07                	jle    b43 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     b3c:	b8 00 00 00 00       	mov    $0x0,%eax
     b41:	eb 77                	jmp    bba <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     b43:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b46:	8d 50 01             	lea    0x1(%eax),%edx
     b49:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b4c:	c6 80 00 1b 00 00 00 	movb   $0x0,0x1b00(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b56:	8d 90 00 1b 00 00    	lea    0x1b00(%eax),%edx
     b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5f:	89 14 c5 04 1a 00 00 	mov    %edx,0x1a04(,%eax,8)
      } break;
     b66:	eb 1c                	jmp    b84 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6b:	c6 04 c5 00 1a 00 00 	movb   $0x7,0x1a00(,%eax,8)
     b72:	07 
        re_compiled[j].ch = c;
     b73:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7a:	88 14 c5 04 1a 00 00 	mov    %dl,0x1a04(,%eax,8)
      } break;
     b81:	eb 01                	jmp    b84 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b83:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     b84:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     b88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     b8c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b8f:	8b 45 08             	mov    0x8(%ebp),%eax
     b92:	01 d0                	add    %edx,%eax
     b94:	0f b6 00             	movzbl (%eax),%eax
     b97:	84 c0                	test   %al,%al
     b99:	74 0f                	je     baa <re_compile+0x293>
     b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9e:	83 c0 01             	add    $0x1,%eax
     ba1:	83 f8 1d             	cmp    $0x1d,%eax
     ba4:	0f 8e 8d fd ff ff    	jle    937 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bad:	c6 04 c5 00 1a 00 00 	movb   $0x0,0x1a00(,%eax,8)
     bb4:	00 

  return (re_t) re_compiled;
     bb5:	b8 00 1a 00 00       	mov    $0x1a00,%eax
}
     bba:	c9                   	leave  
     bbb:	c3                   	ret    

00000bbc <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     bbc:	55                   	push   %ebp
     bbd:	89 e5                	mov    %esp,%ebp
     bbf:	83 ec 04             	sub    $0x4,%esp
     bc2:	8b 45 08             	mov    0x8(%ebp),%eax
     bc5:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     bc8:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     bcc:	7e 0d                	jle    bdb <matchdigit+0x1f>
     bce:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     bd2:	7f 07                	jg     bdb <matchdigit+0x1f>
     bd4:	b8 01 00 00 00       	mov    $0x1,%eax
     bd9:	eb 05                	jmp    be0 <matchdigit+0x24>
     bdb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     be0:	c9                   	leave  
     be1:	c3                   	ret    

00000be2 <matchalpha>:
static int matchalpha(char c)
{
     be2:	55                   	push   %ebp
     be3:	89 e5                	mov    %esp,%ebp
     be5:	83 ec 04             	sub    $0x4,%esp
     be8:	8b 45 08             	mov    0x8(%ebp),%eax
     beb:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     bee:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     bf2:	7e 06                	jle    bfa <matchalpha+0x18>
     bf4:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     bf8:	7e 0c                	jle    c06 <matchalpha+0x24>
     bfa:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     bfe:	7e 0d                	jle    c0d <matchalpha+0x2b>
     c00:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     c04:	7f 07                	jg     c0d <matchalpha+0x2b>
     c06:	b8 01 00 00 00       	mov    $0x1,%eax
     c0b:	eb 05                	jmp    c12 <matchalpha+0x30>
     c0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c12:	c9                   	leave  
     c13:	c3                   	ret    

00000c14 <matchwhitespace>:
static int matchwhitespace(char c)
{
     c14:	55                   	push   %ebp
     c15:	89 e5                	mov    %esp,%ebp
     c17:	83 ec 04             	sub    $0x4,%esp
     c1a:	8b 45 08             	mov    0x8(%ebp),%eax
     c1d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     c20:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     c24:	74 1e                	je     c44 <matchwhitespace+0x30>
     c26:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     c2a:	74 18                	je     c44 <matchwhitespace+0x30>
     c2c:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     c30:	74 12                	je     c44 <matchwhitespace+0x30>
     c32:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     c36:	74 0c                	je     c44 <matchwhitespace+0x30>
     c38:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     c3c:	74 06                	je     c44 <matchwhitespace+0x30>
     c3e:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     c42:	75 07                	jne    c4b <matchwhitespace+0x37>
     c44:	b8 01 00 00 00       	mov    $0x1,%eax
     c49:	eb 05                	jmp    c50 <matchwhitespace+0x3c>
     c4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c50:	c9                   	leave  
     c51:	c3                   	ret    

00000c52 <matchalphanum>:
static int matchalphanum(char c)
{
     c52:	55                   	push   %ebp
     c53:	89 e5                	mov    %esp,%ebp
     c55:	83 ec 04             	sub    $0x4,%esp
     c58:	8b 45 08             	mov    0x8(%ebp),%eax
     c5b:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c5e:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c62:	74 22                	je     c86 <matchalphanum+0x34>
     c64:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c68:	50                   	push   %eax
     c69:	e8 74 ff ff ff       	call   be2 <matchalpha>
     c6e:	83 c4 04             	add    $0x4,%esp
     c71:	85 c0                	test   %eax,%eax
     c73:	75 11                	jne    c86 <matchalphanum+0x34>
     c75:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c79:	50                   	push   %eax
     c7a:	e8 3d ff ff ff       	call   bbc <matchdigit>
     c7f:	83 c4 04             	add    $0x4,%esp
     c82:	85 c0                	test   %eax,%eax
     c84:	74 07                	je     c8d <matchalphanum+0x3b>
     c86:	b8 01 00 00 00       	mov    $0x1,%eax
     c8b:	eb 05                	jmp    c92 <matchalphanum+0x40>
     c8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c92:	c9                   	leave  
     c93:	c3                   	ret    

00000c94 <matchrange>:
static int matchrange(char c, const char* str)
{
     c94:	55                   	push   %ebp
     c95:	89 e5                	mov    %esp,%ebp
     c97:	83 ec 04             	sub    $0x4,%esp
     c9a:	8b 45 08             	mov    0x8(%ebp),%eax
     c9d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     ca0:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     ca4:	74 5b                	je     d01 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca9:	0f b6 00             	movzbl (%eax),%eax
     cac:	84 c0                	test   %al,%al
     cae:	74 51                	je     d01 <matchrange+0x6d>
     cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb3:	0f b6 00             	movzbl (%eax),%eax
     cb6:	3c 2d                	cmp    $0x2d,%al
     cb8:	74 47                	je     d01 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cba:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbd:	83 c0 01             	add    $0x1,%eax
     cc0:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     cc3:	3c 2d                	cmp    $0x2d,%al
     cc5:	75 3a                	jne    d01 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
     cca:	83 c0 01             	add    $0x1,%eax
     ccd:	0f b6 00             	movzbl (%eax),%eax
     cd0:	84 c0                	test   %al,%al
     cd2:	74 2d                	je     d01 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd7:	83 c0 02             	add    $0x2,%eax
     cda:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     cdd:	84 c0                	test   %al,%al
     cdf:	74 20                	je     d01 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     ce1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce4:	0f b6 00             	movzbl (%eax),%eax
     ce7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cea:	7f 15                	jg     d01 <matchrange+0x6d>
     cec:	8b 45 0c             	mov    0xc(%ebp),%eax
     cef:	83 c0 02             	add    $0x2,%eax
     cf2:	0f b6 00             	movzbl (%eax),%eax
     cf5:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cf8:	7c 07                	jl     d01 <matchrange+0x6d>
     cfa:	b8 01 00 00 00       	mov    $0x1,%eax
     cff:	eb 05                	jmp    d06 <matchrange+0x72>
     d01:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d06:	c9                   	leave  
     d07:	c3                   	ret    

00000d08 <ismetachar>:
static int ismetachar(char c)
{
     d08:	55                   	push   %ebp
     d09:	89 e5                	mov    %esp,%ebp
     d0b:	83 ec 04             	sub    $0x4,%esp
     d0e:	8b 45 08             	mov    0x8(%ebp),%eax
     d11:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     d14:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     d18:	74 1e                	je     d38 <ismetachar+0x30>
     d1a:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     d1e:	74 18                	je     d38 <ismetachar+0x30>
     d20:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     d24:	74 12                	je     d38 <ismetachar+0x30>
     d26:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     d2a:	74 0c                	je     d38 <ismetachar+0x30>
     d2c:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     d30:	74 06                	je     d38 <ismetachar+0x30>
     d32:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     d36:	75 07                	jne    d3f <ismetachar+0x37>
     d38:	b8 01 00 00 00       	mov    $0x1,%eax
     d3d:	eb 05                	jmp    d44 <ismetachar+0x3c>
     d3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d44:	c9                   	leave  
     d45:	c3                   	ret    

00000d46 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d46:	55                   	push   %ebp
     d47:	89 e5                	mov    %esp,%ebp
     d49:	83 ec 04             	sub    $0x4,%esp
     d4c:	8b 45 08             	mov    0x8(%ebp),%eax
     d4f:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d52:	8b 45 0c             	mov    0xc(%ebp),%eax
     d55:	0f b6 00             	movzbl (%eax),%eax
     d58:	0f be c0             	movsbl %al,%eax
     d5b:	83 e8 44             	sub    $0x44,%eax
     d5e:	83 f8 33             	cmp    $0x33,%eax
     d61:	77 7b                	ja     dde <matchmetachar+0x98>
     d63:	8b 04 85 64 14 00 00 	mov    0x1464(,%eax,4),%eax
     d6a:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d6c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d70:	50                   	push   %eax
     d71:	e8 46 fe ff ff       	call   bbc <matchdigit>
     d76:	83 c4 04             	add    $0x4,%esp
     d79:	eb 72                	jmp    ded <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d7b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d7f:	50                   	push   %eax
     d80:	e8 37 fe ff ff       	call   bbc <matchdigit>
     d85:	83 c4 04             	add    $0x4,%esp
     d88:	85 c0                	test   %eax,%eax
     d8a:	0f 94 c0             	sete   %al
     d8d:	0f b6 c0             	movzbl %al,%eax
     d90:	eb 5b                	jmp    ded <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     d92:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d96:	50                   	push   %eax
     d97:	e8 b6 fe ff ff       	call   c52 <matchalphanum>
     d9c:	83 c4 04             	add    $0x4,%esp
     d9f:	eb 4c                	jmp    ded <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     da1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     da5:	50                   	push   %eax
     da6:	e8 a7 fe ff ff       	call   c52 <matchalphanum>
     dab:	83 c4 04             	add    $0x4,%esp
     dae:	85 c0                	test   %eax,%eax
     db0:	0f 94 c0             	sete   %al
     db3:	0f b6 c0             	movzbl %al,%eax
     db6:	eb 35                	jmp    ded <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     db8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dbc:	50                   	push   %eax
     dbd:	e8 52 fe ff ff       	call   c14 <matchwhitespace>
     dc2:	83 c4 04             	add    $0x4,%esp
     dc5:	eb 26                	jmp    ded <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     dc7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dcb:	50                   	push   %eax
     dcc:	e8 43 fe ff ff       	call   c14 <matchwhitespace>
     dd1:	83 c4 04             	add    $0x4,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	0f 94 c0             	sete   %al
     dd9:	0f b6 c0             	movzbl %al,%eax
     ddc:	eb 0f                	jmp    ded <matchmetachar+0xa7>
    default:  return (c == str[0]);
     dde:	8b 45 0c             	mov    0xc(%ebp),%eax
     de1:	0f b6 00             	movzbl (%eax),%eax
     de4:	3a 45 fc             	cmp    -0x4(%ebp),%al
     de7:	0f 94 c0             	sete   %al
     dea:	0f b6 c0             	movzbl %al,%eax
  }
}
     ded:	c9                   	leave  
     dee:	c3                   	ret    

00000def <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     def:	55                   	push   %ebp
     df0:	89 e5                	mov    %esp,%ebp
     df2:	83 ec 04             	sub    $0x4,%esp
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
     df8:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     dfb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dff:	ff 75 0c             	pushl  0xc(%ebp)
     e02:	50                   	push   %eax
     e03:	e8 8c fe ff ff       	call   c94 <matchrange>
     e08:	83 c4 08             	add    $0x8,%esp
     e0b:	85 c0                	test   %eax,%eax
     e0d:	74 0a                	je     e19 <matchcharclass+0x2a>
    {
      return 1;
     e0f:	b8 01 00 00 00       	mov    $0x1,%eax
     e14:	e9 a5 00 00 00       	jmp    ebe <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     e19:	8b 45 0c             	mov    0xc(%ebp),%eax
     e1c:	0f b6 00             	movzbl (%eax),%eax
     e1f:	3c 5c                	cmp    $0x5c,%al
     e21:	75 42                	jne    e65 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     e23:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     e27:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e2b:	ff 75 0c             	pushl  0xc(%ebp)
     e2e:	50                   	push   %eax
     e2f:	e8 12 ff ff ff       	call   d46 <matchmetachar>
     e34:	83 c4 08             	add    $0x8,%esp
     e37:	85 c0                	test   %eax,%eax
     e39:	74 07                	je     e42 <matchcharclass+0x53>
      {
        return 1;
     e3b:	b8 01 00 00 00       	mov    $0x1,%eax
     e40:	eb 7c                	jmp    ebe <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     e42:	8b 45 0c             	mov    0xc(%ebp),%eax
     e45:	0f b6 00             	movzbl (%eax),%eax
     e48:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e4b:	75 58                	jne    ea5 <matchcharclass+0xb6>
     e4d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e51:	50                   	push   %eax
     e52:	e8 b1 fe ff ff       	call   d08 <ismetachar>
     e57:	83 c4 04             	add    $0x4,%esp
     e5a:	85 c0                	test   %eax,%eax
     e5c:	75 47                	jne    ea5 <matchcharclass+0xb6>
      {
        return 1;
     e5e:	b8 01 00 00 00       	mov    $0x1,%eax
     e63:	eb 59                	jmp    ebe <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e65:	8b 45 0c             	mov    0xc(%ebp),%eax
     e68:	0f b6 00             	movzbl (%eax),%eax
     e6b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e6e:	75 35                	jne    ea5 <matchcharclass+0xb6>
    {
      if (c == '-')
     e70:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e74:	75 28                	jne    e9e <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e76:	8b 45 0c             	mov    0xc(%ebp),%eax
     e79:	83 e8 01             	sub    $0x1,%eax
     e7c:	0f b6 00             	movzbl (%eax),%eax
     e7f:	84 c0                	test   %al,%al
     e81:	74 0d                	je     e90 <matchcharclass+0xa1>
     e83:	8b 45 0c             	mov    0xc(%ebp),%eax
     e86:	83 c0 01             	add    $0x1,%eax
     e89:	0f b6 00             	movzbl (%eax),%eax
     e8c:	84 c0                	test   %al,%al
     e8e:	75 07                	jne    e97 <matchcharclass+0xa8>
     e90:	b8 01 00 00 00       	mov    $0x1,%eax
     e95:	eb 27                	jmp    ebe <matchcharclass+0xcf>
     e97:	b8 00 00 00 00       	mov    $0x0,%eax
     e9c:	eb 20                	jmp    ebe <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     e9e:	b8 01 00 00 00       	mov    $0x1,%eax
     ea3:	eb 19                	jmp    ebe <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea8:	8d 50 01             	lea    0x1(%eax),%edx
     eab:	89 55 0c             	mov    %edx,0xc(%ebp)
     eae:	0f b6 00             	movzbl (%eax),%eax
     eb1:	84 c0                	test   %al,%al
     eb3:	0f 85 42 ff ff ff    	jne    dfb <matchcharclass+0xc>

  return 0;
     eb9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ebe:	c9                   	leave  
     ebf:	c3                   	ret    

00000ec0 <matchone>:

static int matchone(regex_t p, char c)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	83 ec 04             	sub    $0x4,%esp
     ec6:	8b 45 10             	mov    0x10(%ebp),%eax
     ec9:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     ecc:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     ed0:	0f b6 c0             	movzbl %al,%eax
     ed3:	83 f8 0f             	cmp    $0xf,%eax
     ed6:	0f 87 b9 00 00 00    	ja     f95 <matchone+0xd5>
     edc:	8b 04 85 34 15 00 00 	mov    0x1534(,%eax,4),%eax
     ee3:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     ee5:	b8 01 00 00 00       	mov    $0x1,%eax
     eea:	e9 b9 00 00 00       	jmp    fa8 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     eef:	8b 55 0c             	mov    0xc(%ebp),%edx
     ef2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ef6:	52                   	push   %edx
     ef7:	50                   	push   %eax
     ef8:	e8 f2 fe ff ff       	call   def <matchcharclass>
     efd:	83 c4 08             	add    $0x8,%esp
     f00:	e9 a3 00 00 00       	jmp    fa8 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     f05:	8b 55 0c             	mov    0xc(%ebp),%edx
     f08:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f0c:	52                   	push   %edx
     f0d:	50                   	push   %eax
     f0e:	e8 dc fe ff ff       	call   def <matchcharclass>
     f13:	83 c4 08             	add    $0x8,%esp
     f16:	85 c0                	test   %eax,%eax
     f18:	0f 94 c0             	sete   %al
     f1b:	0f b6 c0             	movzbl %al,%eax
     f1e:	e9 85 00 00 00       	jmp    fa8 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     f23:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f27:	50                   	push   %eax
     f28:	e8 8f fc ff ff       	call   bbc <matchdigit>
     f2d:	83 c4 04             	add    $0x4,%esp
     f30:	eb 76                	jmp    fa8 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     f32:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f36:	50                   	push   %eax
     f37:	e8 80 fc ff ff       	call   bbc <matchdigit>
     f3c:	83 c4 04             	add    $0x4,%esp
     f3f:	85 c0                	test   %eax,%eax
     f41:	0f 94 c0             	sete   %al
     f44:	0f b6 c0             	movzbl %al,%eax
     f47:	eb 5f                	jmp    fa8 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f49:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4d:	50                   	push   %eax
     f4e:	e8 ff fc ff ff       	call   c52 <matchalphanum>
     f53:	83 c4 04             	add    $0x4,%esp
     f56:	eb 50                	jmp    fa8 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f58:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f5c:	50                   	push   %eax
     f5d:	e8 f0 fc ff ff       	call   c52 <matchalphanum>
     f62:	83 c4 04             	add    $0x4,%esp
     f65:	85 c0                	test   %eax,%eax
     f67:	0f 94 c0             	sete   %al
     f6a:	0f b6 c0             	movzbl %al,%eax
     f6d:	eb 39                	jmp    fa8 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f6f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f73:	50                   	push   %eax
     f74:	e8 9b fc ff ff       	call   c14 <matchwhitespace>
     f79:	83 c4 04             	add    $0x4,%esp
     f7c:	eb 2a                	jmp    fa8 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f7e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f82:	50                   	push   %eax
     f83:	e8 8c fc ff ff       	call   c14 <matchwhitespace>
     f88:	83 c4 04             	add    $0x4,%esp
     f8b:	85 c0                	test   %eax,%eax
     f8d:	0f 94 c0             	sete   %al
     f90:	0f b6 c0             	movzbl %al,%eax
     f93:	eb 13                	jmp    fa8 <matchone+0xe8>
    default:             return  (p.ch == c);
     f95:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     f99:	0f b6 d0             	movzbl %al,%edx
     f9c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fa0:	39 c2                	cmp    %eax,%edx
     fa2:	0f 94 c0             	sete   %al
     fa5:	0f b6 c0             	movzbl %al,%eax
  }
}
     fa8:	c9                   	leave  
     fa9:	c3                   	ret    

00000faa <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     faa:	55                   	push   %ebp
     fab:	89 e5                	mov    %esp,%ebp
     fad:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     fb0:	8b 45 18             	mov    0x18(%ebp),%eax
     fb3:	8b 00                	mov    (%eax),%eax
     fb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     fb8:	8b 45 14             	mov    0x14(%ebp),%eax
     fbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     fbe:	eb 11                	jmp    fd1 <matchstar+0x27>
  {
    text++;
     fc0:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     fc4:	8b 45 18             	mov    0x18(%ebp),%eax
     fc7:	8b 00                	mov    (%eax),%eax
     fc9:	8d 50 01             	lea    0x1(%eax),%edx
     fcc:	8b 45 18             	mov    0x18(%ebp),%eax
     fcf:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     fd1:	8b 45 14             	mov    0x14(%ebp),%eax
     fd4:	0f b6 00             	movzbl (%eax),%eax
     fd7:	84 c0                	test   %al,%al
     fd9:	74 51                	je     102c <matchstar+0x82>
     fdb:	8b 45 14             	mov    0x14(%ebp),%eax
     fde:	0f b6 00             	movzbl (%eax),%eax
     fe1:	0f be c0             	movsbl %al,%eax
     fe4:	50                   	push   %eax
     fe5:	ff 75 0c             	pushl  0xc(%ebp)
     fe8:	ff 75 08             	pushl  0x8(%ebp)
     feb:	e8 d0 fe ff ff       	call   ec0 <matchone>
     ff0:	83 c4 0c             	add    $0xc,%esp
     ff3:	85 c0                	test   %eax,%eax
     ff5:	75 c9                	jne    fc0 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     ff7:	eb 33                	jmp    102c <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     ff9:	8b 45 14             	mov    0x14(%ebp),%eax
     ffc:	8d 50 ff             	lea    -0x1(%eax),%edx
     fff:	89 55 14             	mov    %edx,0x14(%ebp)
    1002:	83 ec 04             	sub    $0x4,%esp
    1005:	ff 75 18             	pushl  0x18(%ebp)
    1008:	50                   	push   %eax
    1009:	ff 75 10             	pushl  0x10(%ebp)
    100c:	e8 51 01 00 00       	call   1162 <matchpattern>
    1011:	83 c4 10             	add    $0x10,%esp
    1014:	85 c0                	test   %eax,%eax
    1016:	74 07                	je     101f <matchstar+0x75>
      return 1;
    1018:	b8 01 00 00 00       	mov    $0x1,%eax
    101d:	eb 22                	jmp    1041 <matchstar+0x97>
    (*matchlength)--;
    101f:	8b 45 18             	mov    0x18(%ebp),%eax
    1022:	8b 00                	mov    (%eax),%eax
    1024:	8d 50 ff             	lea    -0x1(%eax),%edx
    1027:	8b 45 18             	mov    0x18(%ebp),%eax
    102a:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    102c:	8b 45 14             	mov    0x14(%ebp),%eax
    102f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1032:	73 c5                	jae    ff9 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1034:	8b 45 18             	mov    0x18(%ebp),%eax
    1037:	8b 55 f4             	mov    -0xc(%ebp),%edx
    103a:	89 10                	mov    %edx,(%eax)
  return 0;
    103c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1041:	c9                   	leave  
    1042:	c3                   	ret    

00001043 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1043:	55                   	push   %ebp
    1044:	89 e5                	mov    %esp,%ebp
    1046:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1049:	8b 45 14             	mov    0x14(%ebp),%eax
    104c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    104f:	eb 11                	jmp    1062 <matchplus+0x1f>
  {
    text++;
    1051:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1055:	8b 45 18             	mov    0x18(%ebp),%eax
    1058:	8b 00                	mov    (%eax),%eax
    105a:	8d 50 01             	lea    0x1(%eax),%edx
    105d:	8b 45 18             	mov    0x18(%ebp),%eax
    1060:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1062:	8b 45 14             	mov    0x14(%ebp),%eax
    1065:	0f b6 00             	movzbl (%eax),%eax
    1068:	84 c0                	test   %al,%al
    106a:	74 51                	je     10bd <matchplus+0x7a>
    106c:	8b 45 14             	mov    0x14(%ebp),%eax
    106f:	0f b6 00             	movzbl (%eax),%eax
    1072:	0f be c0             	movsbl %al,%eax
    1075:	50                   	push   %eax
    1076:	ff 75 0c             	pushl  0xc(%ebp)
    1079:	ff 75 08             	pushl  0x8(%ebp)
    107c:	e8 3f fe ff ff       	call   ec0 <matchone>
    1081:	83 c4 0c             	add    $0xc,%esp
    1084:	85 c0                	test   %eax,%eax
    1086:	75 c9                	jne    1051 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1088:	eb 33                	jmp    10bd <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    108a:	8b 45 14             	mov    0x14(%ebp),%eax
    108d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1090:	89 55 14             	mov    %edx,0x14(%ebp)
    1093:	83 ec 04             	sub    $0x4,%esp
    1096:	ff 75 18             	pushl  0x18(%ebp)
    1099:	50                   	push   %eax
    109a:	ff 75 10             	pushl  0x10(%ebp)
    109d:	e8 c0 00 00 00       	call   1162 <matchpattern>
    10a2:	83 c4 10             	add    $0x10,%esp
    10a5:	85 c0                	test   %eax,%eax
    10a7:	74 07                	je     10b0 <matchplus+0x6d>
      return 1;
    10a9:	b8 01 00 00 00       	mov    $0x1,%eax
    10ae:	eb 1a                	jmp    10ca <matchplus+0x87>
    (*matchlength)--;
    10b0:	8b 45 18             	mov    0x18(%ebp),%eax
    10b3:	8b 00                	mov    (%eax),%eax
    10b5:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b8:	8b 45 18             	mov    0x18(%ebp),%eax
    10bb:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10bd:	8b 45 14             	mov    0x14(%ebp),%eax
    10c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10c3:	77 c5                	ja     108a <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    10c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10ca:	c9                   	leave  
    10cb:	c3                   	ret    

000010cc <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10cc:	55                   	push   %ebp
    10cd:	89 e5                	mov    %esp,%ebp
    10cf:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    10d2:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10d6:	84 c0                	test   %al,%al
    10d8:	75 07                	jne    10e1 <matchquestion+0x15>
    return 1;
    10da:	b8 01 00 00 00       	mov    $0x1,%eax
    10df:	eb 7f                	jmp    1160 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    10e1:	83 ec 04             	sub    $0x4,%esp
    10e4:	ff 75 18             	pushl  0x18(%ebp)
    10e7:	ff 75 14             	pushl  0x14(%ebp)
    10ea:	ff 75 10             	pushl  0x10(%ebp)
    10ed:	e8 70 00 00 00       	call   1162 <matchpattern>
    10f2:	83 c4 10             	add    $0x10,%esp
    10f5:	85 c0                	test   %eax,%eax
    10f7:	74 07                	je     1100 <matchquestion+0x34>
      return 1;
    10f9:	b8 01 00 00 00       	mov    $0x1,%eax
    10fe:	eb 60                	jmp    1160 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    1100:	8b 45 14             	mov    0x14(%ebp),%eax
    1103:	0f b6 00             	movzbl (%eax),%eax
    1106:	84 c0                	test   %al,%al
    1108:	74 51                	je     115b <matchquestion+0x8f>
    110a:	8b 45 14             	mov    0x14(%ebp),%eax
    110d:	8d 50 01             	lea    0x1(%eax),%edx
    1110:	89 55 14             	mov    %edx,0x14(%ebp)
    1113:	0f b6 00             	movzbl (%eax),%eax
    1116:	0f be c0             	movsbl %al,%eax
    1119:	83 ec 04             	sub    $0x4,%esp
    111c:	50                   	push   %eax
    111d:	ff 75 0c             	pushl  0xc(%ebp)
    1120:	ff 75 08             	pushl  0x8(%ebp)
    1123:	e8 98 fd ff ff       	call   ec0 <matchone>
    1128:	83 c4 10             	add    $0x10,%esp
    112b:	85 c0                	test   %eax,%eax
    112d:	74 2c                	je     115b <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    112f:	83 ec 04             	sub    $0x4,%esp
    1132:	ff 75 18             	pushl  0x18(%ebp)
    1135:	ff 75 14             	pushl  0x14(%ebp)
    1138:	ff 75 10             	pushl  0x10(%ebp)
    113b:	e8 22 00 00 00       	call   1162 <matchpattern>
    1140:	83 c4 10             	add    $0x10,%esp
    1143:	85 c0                	test   %eax,%eax
    1145:	74 14                	je     115b <matchquestion+0x8f>
    {
      (*matchlength)++;
    1147:	8b 45 18             	mov    0x18(%ebp),%eax
    114a:	8b 00                	mov    (%eax),%eax
    114c:	8d 50 01             	lea    0x1(%eax),%edx
    114f:	8b 45 18             	mov    0x18(%ebp),%eax
    1152:	89 10                	mov    %edx,(%eax)
      return 1;
    1154:	b8 01 00 00 00       	mov    $0x1,%eax
    1159:	eb 05                	jmp    1160 <matchquestion+0x94>
    }
  }
  return 0;
    115b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1160:	c9                   	leave  
    1161:	c3                   	ret    

00001162 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1162:	55                   	push   %ebp
    1163:	89 e5                	mov    %esp,%ebp
    1165:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1168:	8b 45 10             	mov    0x10(%ebp),%eax
    116b:	8b 00                	mov    (%eax),%eax
    116d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1170:	8b 45 08             	mov    0x8(%ebp),%eax
    1173:	0f b6 00             	movzbl (%eax),%eax
    1176:	84 c0                	test   %al,%al
    1178:	74 0d                	je     1187 <matchpattern+0x25>
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
    117d:	83 c0 08             	add    $0x8,%eax
    1180:	0f b6 00             	movzbl (%eax),%eax
    1183:	3c 04                	cmp    $0x4,%al
    1185:	75 25                	jne    11ac <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1187:	8b 45 08             	mov    0x8(%ebp),%eax
    118a:	83 c0 10             	add    $0x10,%eax
    118d:	83 ec 0c             	sub    $0xc,%esp
    1190:	ff 75 10             	pushl  0x10(%ebp)
    1193:	ff 75 0c             	pushl  0xc(%ebp)
    1196:	50                   	push   %eax
    1197:	8b 45 08             	mov    0x8(%ebp),%eax
    119a:	ff 70 04             	pushl  0x4(%eax)
    119d:	ff 30                	pushl  (%eax)
    119f:	e8 28 ff ff ff       	call   10cc <matchquestion>
    11a4:	83 c4 20             	add    $0x20,%esp
    11a7:	e9 dd 00 00 00       	jmp    1289 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	83 c0 08             	add    $0x8,%eax
    11b2:	0f b6 00             	movzbl (%eax),%eax
    11b5:	3c 05                	cmp    $0x5,%al
    11b7:	75 25                	jne    11de <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    11b9:	8b 45 08             	mov    0x8(%ebp),%eax
    11bc:	83 c0 10             	add    $0x10,%eax
    11bf:	83 ec 0c             	sub    $0xc,%esp
    11c2:	ff 75 10             	pushl  0x10(%ebp)
    11c5:	ff 75 0c             	pushl  0xc(%ebp)
    11c8:	50                   	push   %eax
    11c9:	8b 45 08             	mov    0x8(%ebp),%eax
    11cc:	ff 70 04             	pushl  0x4(%eax)
    11cf:	ff 30                	pushl  (%eax)
    11d1:	e8 d4 fd ff ff       	call   faa <matchstar>
    11d6:	83 c4 20             	add    $0x20,%esp
    11d9:	e9 ab 00 00 00       	jmp    1289 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	83 c0 08             	add    $0x8,%eax
    11e4:	0f b6 00             	movzbl (%eax),%eax
    11e7:	3c 06                	cmp    $0x6,%al
    11e9:	75 22                	jne    120d <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	83 c0 10             	add    $0x10,%eax
    11f1:	83 ec 0c             	sub    $0xc,%esp
    11f4:	ff 75 10             	pushl  0x10(%ebp)
    11f7:	ff 75 0c             	pushl  0xc(%ebp)
    11fa:	50                   	push   %eax
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	ff 70 04             	pushl  0x4(%eax)
    1201:	ff 30                	pushl  (%eax)
    1203:	e8 3b fe ff ff       	call   1043 <matchplus>
    1208:	83 c4 20             	add    $0x20,%esp
    120b:	eb 7c                	jmp    1289 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	0f b6 00             	movzbl (%eax),%eax
    1213:	3c 03                	cmp    $0x3,%al
    1215:	75 1d                	jne    1234 <matchpattern+0xd2>
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	83 c0 08             	add    $0x8,%eax
    121d:	0f b6 00             	movzbl (%eax),%eax
    1220:	84 c0                	test   %al,%al
    1222:	75 10                	jne    1234 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1224:	8b 45 0c             	mov    0xc(%ebp),%eax
    1227:	0f b6 00             	movzbl (%eax),%eax
    122a:	84 c0                	test   %al,%al
    122c:	0f 94 c0             	sete   %al
    122f:	0f b6 c0             	movzbl %al,%eax
    1232:	eb 55                	jmp    1289 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1234:	8b 45 10             	mov    0x10(%ebp),%eax
    1237:	8b 00                	mov    (%eax),%eax
    1239:	8d 50 01             	lea    0x1(%eax),%edx
    123c:	8b 45 10             	mov    0x10(%ebp),%eax
    123f:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1241:	8b 45 0c             	mov    0xc(%ebp),%eax
    1244:	0f b6 00             	movzbl (%eax),%eax
    1247:	84 c0                	test   %al,%al
    1249:	74 31                	je     127c <matchpattern+0x11a>
    124b:	8b 45 0c             	mov    0xc(%ebp),%eax
    124e:	8d 50 01             	lea    0x1(%eax),%edx
    1251:	89 55 0c             	mov    %edx,0xc(%ebp)
    1254:	0f b6 00             	movzbl (%eax),%eax
    1257:	0f be d0             	movsbl %al,%edx
    125a:	8b 45 08             	mov    0x8(%ebp),%eax
    125d:	8d 48 08             	lea    0x8(%eax),%ecx
    1260:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1263:	83 ec 04             	sub    $0x4,%esp
    1266:	52                   	push   %edx
    1267:	ff 70 04             	pushl  0x4(%eax)
    126a:	ff 30                	pushl  (%eax)
    126c:	e8 4f fc ff ff       	call   ec0 <matchone>
    1271:	83 c4 10             	add    $0x10,%esp
    1274:	85 c0                	test   %eax,%eax
    1276:	0f 85 f4 fe ff ff    	jne    1170 <matchpattern+0xe>

  *matchlength = pre;
    127c:	8b 45 10             	mov    0x10(%ebp),%eax
    127f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1282:	89 10                	mov    %edx,(%eax)
  return 0;
    1284:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1289:	c9                   	leave  
    128a:	c3                   	ret    
