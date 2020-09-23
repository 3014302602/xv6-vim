
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
      11:	83 3b 03             	cmpl   $0x3,(%ebx)
      14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
      16:	83 ec 08             	sub    $0x8,%esp
      19:	68 90 12 00 00       	push   $0x1290
      1e:	6a 02                	push   $0x2
      20:	e8 7d 04 00 00       	call   4a2 <printf>
      25:	83 c4 10             	add    $0x10,%esp
    exit();
      28:	e8 9e 02 00 00       	call   2cb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
      2d:	8b 43 04             	mov    0x4(%ebx),%eax
      30:	83 c0 08             	add    $0x8,%eax
      33:	8b 10                	mov    (%eax),%edx
      35:	8b 43 04             	mov    0x4(%ebx),%eax
      38:	83 c0 04             	add    $0x4,%eax
      3b:	8b 00                	mov    (%eax),%eax
      3d:	83 ec 08             	sub    $0x8,%esp
      40:	52                   	push   %edx
      41:	50                   	push   %eax
      42:	e8 e4 02 00 00       	call   32b <link>
      47:	83 c4 10             	add    $0x10,%esp
      4a:	85 c0                	test   %eax,%eax
      4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
      4e:	8b 43 04             	mov    0x4(%ebx),%eax
      51:	83 c0 08             	add    $0x8,%eax
      54:	8b 10                	mov    (%eax),%edx
      56:	8b 43 04             	mov    0x4(%ebx),%eax
      59:	83 c0 04             	add    $0x4,%eax
      5c:	8b 00                	mov    (%eax),%eax
      5e:	52                   	push   %edx
      5f:	50                   	push   %eax
      60:	68 a3 12 00 00       	push   $0x12a3
      65:	6a 02                	push   $0x2
      67:	e8 36 04 00 00       	call   4a2 <printf>
      6c:	83 c4 10             	add    $0x10,%esp
  exit();
      6f:	e8 57 02 00 00       	call   2cb <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	57                   	push   %edi
      78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      79:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7c:	8b 55 10             	mov    0x10(%ebp),%edx
      7f:	8b 45 0c             	mov    0xc(%ebp),%eax
      82:	89 cb                	mov    %ecx,%ebx
      84:	89 df                	mov    %ebx,%edi
      86:	89 d1                	mov    %edx,%ecx
      88:	fc                   	cld    
      89:	f3 aa                	rep stos %al,%es:(%edi)
      8b:	89 ca                	mov    %ecx,%edx
      8d:	89 fb                	mov    %edi,%ebx
      8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
      92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      95:	90                   	nop
      96:	5b                   	pop    %ebx
      97:	5f                   	pop    %edi
      98:	5d                   	pop    %ebp
      99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      9a:	55                   	push   %ebp
      9b:	89 e5                	mov    %esp,%ebp
      9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a0:	8b 45 08             	mov    0x8(%ebp),%eax
      a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a6:	90                   	nop
      a7:	8b 45 08             	mov    0x8(%ebp),%eax
      aa:	8d 50 01             	lea    0x1(%eax),%edx
      ad:	89 55 08             	mov    %edx,0x8(%ebp)
      b0:	8b 55 0c             	mov    0xc(%ebp),%edx
      b3:	8d 4a 01             	lea    0x1(%edx),%ecx
      b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      b9:	0f b6 12             	movzbl (%edx),%edx
      bc:	88 10                	mov    %dl,(%eax)
      be:	0f b6 00             	movzbl (%eax),%eax
      c1:	84 c0                	test   %al,%al
      c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
      c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c8:	c9                   	leave  
      c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
      ca:	55                   	push   %ebp
      cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
      cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	74 10                	je     f1 <strcmp+0x27>
      e1:	8b 45 08             	mov    0x8(%ebp),%eax
      e4:	0f b6 10             	movzbl (%eax),%edx
      e7:	8b 45 0c             	mov    0xc(%ebp),%eax
      ea:	0f b6 00             	movzbl (%eax),%eax
      ed:	38 c2                	cmp    %al,%dl
      ef:	74 de                	je     cf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      f1:	8b 45 08             	mov    0x8(%ebp),%eax
      f4:	0f b6 00             	movzbl (%eax),%eax
      f7:	0f b6 d0             	movzbl %al,%edx
      fa:	8b 45 0c             	mov    0xc(%ebp),%eax
      fd:	0f b6 00             	movzbl (%eax),%eax
     100:	0f b6 c0             	movzbl %al,%eax
     103:	29 c2                	sub    %eax,%edx
     105:	89 d0                	mov    %edx,%eax
}
     107:	5d                   	pop    %ebp
     108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
     109:	55                   	push   %ebp
     10a:	89 e5                	mov    %esp,%ebp
     10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     116:	eb 04                	jmp    11c <strlen+0x13>
     118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11f:	8b 45 08             	mov    0x8(%ebp),%eax
     122:	01 d0                	add    %edx,%eax
     124:	0f b6 00             	movzbl (%eax),%eax
     127:	84 c0                	test   %al,%al
     129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
     12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12e:	c9                   	leave  
     12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     133:	8b 45 10             	mov    0x10(%ebp),%eax
     136:	50                   	push   %eax
     137:	ff 75 0c             	pushl  0xc(%ebp)
     13a:	ff 75 08             	pushl  0x8(%ebp)
     13d:	e8 32 ff ff ff       	call   74 <stosb>
     142:	83 c4 0c             	add    $0xc,%esp
  return dst;
     145:	8b 45 08             	mov    0x8(%ebp),%eax
}
     148:	c9                   	leave  
     149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
     14a:	55                   	push   %ebp
     14b:	89 e5                	mov    %esp,%ebp
     14d:	83 ec 04             	sub    $0x4,%esp
     150:	8b 45 0c             	mov    0xc(%ebp),%eax
     153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
     158:	8b 45 08             	mov    0x8(%ebp),%eax
     15b:	0f b6 00             	movzbl (%eax),%eax
     15e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
     163:	8b 45 08             	mov    0x8(%ebp),%eax
     166:	eb 13                	jmp    17b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16c:	8b 45 08             	mov    0x8(%ebp),%eax
     16f:	0f b6 00             	movzbl (%eax),%eax
     172:	84 c0                	test   %al,%al
     174:	75 e2                	jne    158 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     176:	b8 00 00 00 00       	mov    $0x0,%eax
}
     17b:	c9                   	leave  
     17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
     17d:	55                   	push   %ebp
     17e:	89 e5                	mov    %esp,%ebp
     180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
     18c:	83 ec 04             	sub    $0x4,%esp
     18f:	6a 01                	push   $0x1
     191:	8d 45 ef             	lea    -0x11(%ebp),%eax
     194:	50                   	push   %eax
     195:	6a 00                	push   $0x0
     197:	e8 47 01 00 00       	call   2e3 <read>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
     1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ab:	8d 50 01             	lea    0x1(%eax),%edx
     1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1b1:	89 c2                	mov    %eax,%edx
     1b3:	8b 45 08             	mov    0x8(%ebp),%eax
     1b6:	01 c2                	add    %eax,%edx
     1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1c2:	3c 0a                	cmp    $0xa,%al
     1c4:	74 16                	je     1dc <gets+0x5f>
     1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ca:	3c 0d                	cmp    $0xd,%al
     1cc:	74 0e                	je     1dc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d1:	83 c0 01             	add    $0x1,%eax
     1d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1d7:	7c b3                	jl     18c <gets+0xf>
     1d9:	eb 01                	jmp    1dc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1db:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	01 d0                	add    %edx,%eax
     1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1ea:	c9                   	leave  
     1eb:	c3                   	ret    

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
     1ec:	55                   	push   %ebp
     1ed:	89 e5                	mov    %esp,%ebp
     1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1f2:	83 ec 08             	sub    $0x8,%esp
     1f5:	6a 00                	push   $0x0
     1f7:	ff 75 08             	pushl  0x8(%ebp)
     1fa:	e8 0c 01 00 00       	call   30b <open>
     1ff:	83 c4 10             	add    $0x10,%esp
     202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     209:	79 07                	jns    212 <stat+0x26>
    return -1;
     20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
     212:	83 ec 08             	sub    $0x8,%esp
     215:	ff 75 0c             	pushl  0xc(%ebp)
     218:	ff 75 f4             	pushl  -0xc(%ebp)
     21b:	e8 03 01 00 00       	call   323 <fstat>
     220:	83 c4 10             	add    $0x10,%esp
     223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     226:	83 ec 0c             	sub    $0xc,%esp
     229:	ff 75 f4             	pushl  -0xc(%ebp)
     22c:	e8 c2 00 00 00       	call   2f3 <close>
     231:	83 c4 10             	add    $0x10,%esp
  return r;
     234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     237:	c9                   	leave  
     238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
     239:	55                   	push   %ebp
     23a:	89 e5                	mov    %esp,%ebp
     23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
     248:	8b 55 fc             	mov    -0x4(%ebp),%edx
     24b:	89 d0                	mov    %edx,%eax
     24d:	c1 e0 02             	shl    $0x2,%eax
     250:	01 d0                	add    %edx,%eax
     252:	01 c0                	add    %eax,%eax
     254:	89 c1                	mov    %eax,%ecx
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	8d 50 01             	lea    0x1(%eax),%edx
     25c:	89 55 08             	mov    %edx,0x8(%ebp)
     25f:	0f b6 00             	movzbl (%eax),%eax
     262:	0f be c0             	movsbl %al,%eax
     265:	01 c8                	add    %ecx,%eax
     267:	83 e8 30             	sub    $0x30,%eax
     26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     26d:	8b 45 08             	mov    0x8(%ebp),%eax
     270:	0f b6 00             	movzbl (%eax),%eax
     273:	3c 2f                	cmp    $0x2f,%al
     275:	7e 0a                	jle    281 <atoi+0x48>
     277:	8b 45 08             	mov    0x8(%ebp),%eax
     27a:	0f b6 00             	movzbl (%eax),%eax
     27d:	3c 39                	cmp    $0x39,%al
     27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     284:	c9                   	leave  
     285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     286:	55                   	push   %ebp
     287:	89 e5                	mov    %esp,%ebp
     289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     292:	8b 45 0c             	mov    0xc(%ebp),%eax
     295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
     29a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     29d:	8d 50 01             	lea    0x1(%eax),%edx
     2a0:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2a6:	8d 4a 01             	lea    0x1(%edx),%ecx
     2a9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2ac:	0f b6 12             	movzbl (%edx),%edx
     2af:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2b1:	8b 45 10             	mov    0x10(%ebp),%eax
     2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
     2b7:	89 55 10             	mov    %edx,0x10(%ebp)
     2ba:	85 c0                	test   %eax,%eax
     2bc:	7f dc                	jg     29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c1:	c9                   	leave  
     2c2:	c3                   	ret    

000002c3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2c3:	b8 01 00 00 00       	mov    $0x1,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <exit>:
SYSCALL(exit)
     2cb:	b8 02 00 00 00       	mov    $0x2,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <wait>:
SYSCALL(wait)
     2d3:	b8 03 00 00 00       	mov    $0x3,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <pipe>:
SYSCALL(pipe)
     2db:	b8 04 00 00 00       	mov    $0x4,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <read>:
SYSCALL(read)
     2e3:	b8 05 00 00 00       	mov    $0x5,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <write>:
SYSCALL(write)
     2eb:	b8 10 00 00 00       	mov    $0x10,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <close>:
SYSCALL(close)
     2f3:	b8 15 00 00 00       	mov    $0x15,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <kill>:
SYSCALL(kill)
     2fb:	b8 06 00 00 00       	mov    $0x6,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <exec>:
SYSCALL(exec)
     303:	b8 07 00 00 00       	mov    $0x7,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <open>:
SYSCALL(open)
     30b:	b8 0f 00 00 00       	mov    $0xf,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <mknod>:
SYSCALL(mknod)
     313:	b8 11 00 00 00       	mov    $0x11,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <unlink>:
SYSCALL(unlink)
     31b:	b8 12 00 00 00       	mov    $0x12,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <fstat>:
SYSCALL(fstat)
     323:	b8 08 00 00 00       	mov    $0x8,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <link>:
SYSCALL(link)
     32b:	b8 13 00 00 00       	mov    $0x13,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <mkdir>:
SYSCALL(mkdir)
     333:	b8 14 00 00 00       	mov    $0x14,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <chdir>:
SYSCALL(chdir)
     33b:	b8 09 00 00 00       	mov    $0x9,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <dup>:
SYSCALL(dup)
     343:	b8 0a 00 00 00       	mov    $0xa,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <getpid>:
SYSCALL(getpid)
     34b:	b8 0b 00 00 00       	mov    $0xb,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <sbrk>:
SYSCALL(sbrk)
     353:	b8 0c 00 00 00       	mov    $0xc,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <sleep>:
SYSCALL(sleep)
     35b:	b8 0d 00 00 00       	mov    $0xd,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <uptime>:
SYSCALL(uptime)
     363:	b8 0e 00 00 00       	mov    $0xe,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <setCursorPos>:


//add
SYSCALL(setCursorPos)
     36b:	b8 16 00 00 00       	mov    $0x16,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     373:	b8 17 00 00 00       	mov    $0x17,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <clearScreen>:
SYSCALL(clearScreen)
     37b:	b8 18 00 00 00       	mov    $0x18,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <writeAt>:
SYSCALL(writeAt)
     383:	b8 19 00 00 00       	mov    $0x19,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <setBufferFlag>:
SYSCALL(setBufferFlag)
     38b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     393:	b8 1b 00 00 00       	mov    $0x1b,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <getCursorPos>:
SYSCALL(getCursorPos)
     39b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3a0:	cd 40                	int    $0x40
     3a2:	c3                   	ret    

000003a3 <saveScreen>:
SYSCALL(saveScreen)
     3a3:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3a8:	cd 40                	int    $0x40
     3aa:	c3                   	ret    

000003ab <recorverScreen>:
SYSCALL(recorverScreen)
     3ab:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3b0:	cd 40                	int    $0x40
     3b2:	c3                   	ret    

000003b3 <ToScreen>:
SYSCALL(ToScreen)
     3b3:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3b8:	cd 40                	int    $0x40
     3ba:	c3                   	ret    

000003bb <getColor>:
SYSCALL(getColor)
     3bb:	b8 20 00 00 00       	mov    $0x20,%eax
     3c0:	cd 40                	int    $0x40
     3c2:	c3                   	ret    

000003c3 <showC>:
SYSCALL(showC)
     3c3:	b8 21 00 00 00       	mov    $0x21,%eax
     3c8:	cd 40                	int    $0x40
     3ca:	c3                   	ret    

000003cb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3cb:	55                   	push   %ebp
     3cc:	89 e5                	mov    %esp,%ebp
     3ce:	83 ec 18             	sub    $0x18,%esp
     3d1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3d7:	83 ec 04             	sub    $0x4,%esp
     3da:	6a 01                	push   $0x1
     3dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3df:	50                   	push   %eax
     3e0:	ff 75 08             	pushl  0x8(%ebp)
     3e3:	e8 03 ff ff ff       	call   2eb <write>
     3e8:	83 c4 10             	add    $0x10,%esp
}
     3eb:	90                   	nop
     3ec:	c9                   	leave  
     3ed:	c3                   	ret    

000003ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3ee:	55                   	push   %ebp
     3ef:	89 e5                	mov    %esp,%ebp
     3f1:	53                   	push   %ebx
     3f2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3fc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     400:	74 17                	je     419 <printint+0x2b>
     402:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     406:	79 11                	jns    419 <printint+0x2b>
    neg = 1;
     408:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     40f:	8b 45 0c             	mov    0xc(%ebp),%eax
     412:	f7 d8                	neg    %eax
     414:	89 45 ec             	mov    %eax,-0x14(%ebp)
     417:	eb 06                	jmp    41f <printint+0x31>
  } else {
    x = xx;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     41f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     426:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     429:	8d 41 01             	lea    0x1(%ecx),%eax
     42c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     42f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     432:	8b 45 ec             	mov    -0x14(%ebp),%eax
     435:	ba 00 00 00 00       	mov    $0x0,%edx
     43a:	f7 f3                	div    %ebx
     43c:	89 d0                	mov    %edx,%eax
     43e:	0f b6 80 d8 19 00 00 	movzbl 0x19d8(%eax),%eax
     445:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     449:	8b 5d 10             	mov    0x10(%ebp),%ebx
     44c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     44f:	ba 00 00 00 00       	mov    $0x0,%edx
     454:	f7 f3                	div    %ebx
     456:	89 45 ec             	mov    %eax,-0x14(%ebp)
     459:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     45d:	75 c7                	jne    426 <printint+0x38>
  if(neg)
     45f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     463:	74 2d                	je     492 <printint+0xa4>
    buf[i++] = '-';
     465:	8b 45 f4             	mov    -0xc(%ebp),%eax
     468:	8d 50 01             	lea    0x1(%eax),%edx
     46b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     46e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     473:	eb 1d                	jmp    492 <printint+0xa4>
    putc(fd, buf[i]);
     475:	8d 55 dc             	lea    -0x24(%ebp),%edx
     478:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47b:	01 d0                	add    %edx,%eax
     47d:	0f b6 00             	movzbl (%eax),%eax
     480:	0f be c0             	movsbl %al,%eax
     483:	83 ec 08             	sub    $0x8,%esp
     486:	50                   	push   %eax
     487:	ff 75 08             	pushl  0x8(%ebp)
     48a:	e8 3c ff ff ff       	call   3cb <putc>
     48f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     492:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     496:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     49a:	79 d9                	jns    475 <printint+0x87>
    putc(fd, buf[i]);
}
     49c:	90                   	nop
     49d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4a0:	c9                   	leave  
     4a1:	c3                   	ret    

000004a2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4a2:	55                   	push   %ebp
     4a3:	89 e5                	mov    %esp,%ebp
     4a5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4af:	8d 45 0c             	lea    0xc(%ebp),%eax
     4b2:	83 c0 04             	add    $0x4,%eax
     4b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4bf:	e9 59 01 00 00       	jmp    61d <printf+0x17b>
    c = fmt[i] & 0xff;
     4c4:	8b 55 0c             	mov    0xc(%ebp),%edx
     4c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4ca:	01 d0                	add    %edx,%eax
     4cc:	0f b6 00             	movzbl (%eax),%eax
     4cf:	0f be c0             	movsbl %al,%eax
     4d2:	25 ff 00 00 00       	and    $0xff,%eax
     4d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4da:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4de:	75 2c                	jne    50c <printf+0x6a>
      if(c == '%'){
     4e0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4e4:	75 0c                	jne    4f2 <printf+0x50>
        state = '%';
     4e6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4ed:	e9 27 01 00 00       	jmp    619 <printf+0x177>
      } else {
        putc(fd, c);
     4f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4f5:	0f be c0             	movsbl %al,%eax
     4f8:	83 ec 08             	sub    $0x8,%esp
     4fb:	50                   	push   %eax
     4fc:	ff 75 08             	pushl  0x8(%ebp)
     4ff:	e8 c7 fe ff ff       	call   3cb <putc>
     504:	83 c4 10             	add    $0x10,%esp
     507:	e9 0d 01 00 00       	jmp    619 <printf+0x177>
      }
    } else if(state == '%'){
     50c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     510:	0f 85 03 01 00 00    	jne    619 <printf+0x177>
      if(c == 'd'){
     516:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     51a:	75 1e                	jne    53a <printf+0x98>
        printint(fd, *ap, 10, 1);
     51c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     51f:	8b 00                	mov    (%eax),%eax
     521:	6a 01                	push   $0x1
     523:	6a 0a                	push   $0xa
     525:	50                   	push   %eax
     526:	ff 75 08             	pushl  0x8(%ebp)
     529:	e8 c0 fe ff ff       	call   3ee <printint>
     52e:	83 c4 10             	add    $0x10,%esp
        ap++;
     531:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     535:	e9 d8 00 00 00       	jmp    612 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     53a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     53e:	74 06                	je     546 <printf+0xa4>
     540:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     544:	75 1e                	jne    564 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     546:	8b 45 e8             	mov    -0x18(%ebp),%eax
     549:	8b 00                	mov    (%eax),%eax
     54b:	6a 00                	push   $0x0
     54d:	6a 10                	push   $0x10
     54f:	50                   	push   %eax
     550:	ff 75 08             	pushl  0x8(%ebp)
     553:	e8 96 fe ff ff       	call   3ee <printint>
     558:	83 c4 10             	add    $0x10,%esp
        ap++;
     55b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     55f:	e9 ae 00 00 00       	jmp    612 <printf+0x170>
      } else if(c == 's'){
     564:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     568:	75 43                	jne    5ad <printf+0x10b>
        s = (char*)*ap;
     56a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     56d:	8b 00                	mov    (%eax),%eax
     56f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     572:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     576:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     57a:	75 25                	jne    5a1 <printf+0xff>
          s = "(null)";
     57c:	c7 45 f4 b7 12 00 00 	movl   $0x12b7,-0xc(%ebp)
        while(*s != 0){
     583:	eb 1c                	jmp    5a1 <printf+0xff>
          putc(fd, *s);
     585:	8b 45 f4             	mov    -0xc(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	0f be c0             	movsbl %al,%eax
     58e:	83 ec 08             	sub    $0x8,%esp
     591:	50                   	push   %eax
     592:	ff 75 08             	pushl  0x8(%ebp)
     595:	e8 31 fe ff ff       	call   3cb <putc>
     59a:	83 c4 10             	add    $0x10,%esp
          s++;
     59d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	84 c0                	test   %al,%al
     5a9:	75 da                	jne    585 <printf+0xe3>
     5ab:	eb 65                	jmp    612 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     5ad:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5b1:	75 1d                	jne    5d0 <printf+0x12e>
        putc(fd, *ap);
     5b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5b6:	8b 00                	mov    (%eax),%eax
     5b8:	0f be c0             	movsbl %al,%eax
     5bb:	83 ec 08             	sub    $0x8,%esp
     5be:	50                   	push   %eax
     5bf:	ff 75 08             	pushl  0x8(%ebp)
     5c2:	e8 04 fe ff ff       	call   3cb <putc>
     5c7:	83 c4 10             	add    $0x10,%esp
        ap++;
     5ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ce:	eb 42                	jmp    612 <printf+0x170>
      } else if(c == '%'){
     5d0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5d4:	75 17                	jne    5ed <printf+0x14b>
        putc(fd, c);
     5d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d9:	0f be c0             	movsbl %al,%eax
     5dc:	83 ec 08             	sub    $0x8,%esp
     5df:	50                   	push   %eax
     5e0:	ff 75 08             	pushl  0x8(%ebp)
     5e3:	e8 e3 fd ff ff       	call   3cb <putc>
     5e8:	83 c4 10             	add    $0x10,%esp
     5eb:	eb 25                	jmp    612 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5ed:	83 ec 08             	sub    $0x8,%esp
     5f0:	6a 25                	push   $0x25
     5f2:	ff 75 08             	pushl  0x8(%ebp)
     5f5:	e8 d1 fd ff ff       	call   3cb <putc>
     5fa:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     600:	0f be c0             	movsbl %al,%eax
     603:	83 ec 08             	sub    $0x8,%esp
     606:	50                   	push   %eax
     607:	ff 75 08             	pushl  0x8(%ebp)
     60a:	e8 bc fd ff ff       	call   3cb <putc>
     60f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     612:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     619:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     61d:	8b 55 0c             	mov    0xc(%ebp),%edx
     620:	8b 45 f0             	mov    -0x10(%ebp),%eax
     623:	01 d0                	add    %edx,%eax
     625:	0f b6 00             	movzbl (%eax),%eax
     628:	84 c0                	test   %al,%al
     62a:	0f 85 94 fe ff ff    	jne    4c4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     630:	90                   	nop
     631:	c9                   	leave  
     632:	c3                   	ret    

00000633 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     633:	55                   	push   %ebp
     634:	89 e5                	mov    %esp,%ebp
     636:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     639:	8b 45 08             	mov    0x8(%ebp),%eax
     63c:	83 e8 08             	sub    $0x8,%eax
     63f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     642:	a1 08 1a 00 00       	mov    0x1a08,%eax
     647:	89 45 fc             	mov    %eax,-0x4(%ebp)
     64a:	eb 24                	jmp    670 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64f:	8b 00                	mov    (%eax),%eax
     651:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     654:	77 12                	ja     668 <free+0x35>
     656:	8b 45 f8             	mov    -0x8(%ebp),%eax
     659:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     65c:	77 24                	ja     682 <free+0x4f>
     65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     661:	8b 00                	mov    (%eax),%eax
     663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     666:	77 1a                	ja     682 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     668:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66b:	8b 00                	mov    (%eax),%eax
     66d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     670:	8b 45 f8             	mov    -0x8(%ebp),%eax
     673:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     676:	76 d4                	jbe    64c <free+0x19>
     678:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67b:	8b 00                	mov    (%eax),%eax
     67d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     680:	76 ca                	jbe    64c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     682:	8b 45 f8             	mov    -0x8(%ebp),%eax
     685:	8b 40 04             	mov    0x4(%eax),%eax
     688:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     692:	01 c2                	add    %eax,%edx
     694:	8b 45 fc             	mov    -0x4(%ebp),%eax
     697:	8b 00                	mov    (%eax),%eax
     699:	39 c2                	cmp    %eax,%edx
     69b:	75 24                	jne    6c1 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a0:	8b 50 04             	mov    0x4(%eax),%edx
     6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a6:	8b 00                	mov    (%eax),%eax
     6a8:	8b 40 04             	mov    0x4(%eax),%eax
     6ab:	01 c2                	add    %eax,%edx
     6ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	8b 00                	mov    (%eax),%eax
     6b8:	8b 10                	mov    (%eax),%edx
     6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bd:	89 10                	mov    %edx,(%eax)
     6bf:	eb 0a                	jmp    6cb <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c4:	8b 10                	mov    (%eax),%edx
     6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ce:	8b 40 04             	mov    0x4(%eax),%eax
     6d1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6db:	01 d0                	add    %edx,%eax
     6dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6e0:	75 20                	jne    702 <free+0xcf>
    p->s.size += bp->s.size;
     6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e5:	8b 50 04             	mov    0x4(%eax),%edx
     6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6eb:	8b 40 04             	mov    0x4(%eax),%eax
     6ee:	01 c2                	add    %eax,%edx
     6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f9:	8b 10                	mov    (%eax),%edx
     6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fe:	89 10                	mov    %edx,(%eax)
     700:	eb 08                	jmp    70a <free+0xd7>
  } else
    p->s.ptr = bp;
     702:	8b 45 fc             	mov    -0x4(%ebp),%eax
     705:	8b 55 f8             	mov    -0x8(%ebp),%edx
     708:	89 10                	mov    %edx,(%eax)
  freep = p;
     70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70d:	a3 08 1a 00 00       	mov    %eax,0x1a08
}
     712:	90                   	nop
     713:	c9                   	leave  
     714:	c3                   	ret    

00000715 <morecore>:

static Header*
morecore(uint nu)
{
     715:	55                   	push   %ebp
     716:	89 e5                	mov    %esp,%ebp
     718:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     71b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     722:	77 07                	ja     72b <morecore+0x16>
    nu = 4096;
     724:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     72b:	8b 45 08             	mov    0x8(%ebp),%eax
     72e:	c1 e0 03             	shl    $0x3,%eax
     731:	83 ec 0c             	sub    $0xc,%esp
     734:	50                   	push   %eax
     735:	e8 19 fc ff ff       	call   353 <sbrk>
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     740:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     744:	75 07                	jne    74d <morecore+0x38>
    return 0;
     746:	b8 00 00 00 00       	mov    $0x0,%eax
     74b:	eb 26                	jmp    773 <morecore+0x5e>
  hp = (Header*)p;
     74d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     750:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     753:	8b 45 f0             	mov    -0x10(%ebp),%eax
     756:	8b 55 08             	mov    0x8(%ebp),%edx
     759:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     75c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75f:	83 c0 08             	add    $0x8,%eax
     762:	83 ec 0c             	sub    $0xc,%esp
     765:	50                   	push   %eax
     766:	e8 c8 fe ff ff       	call   633 <free>
     76b:	83 c4 10             	add    $0x10,%esp
  return freep;
     76e:	a1 08 1a 00 00       	mov    0x1a08,%eax
}
     773:	c9                   	leave  
     774:	c3                   	ret    

00000775 <malloc>:

void*
malloc(uint nbytes)
{
     775:	55                   	push   %ebp
     776:	89 e5                	mov    %esp,%ebp
     778:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     77b:	8b 45 08             	mov    0x8(%ebp),%eax
     77e:	83 c0 07             	add    $0x7,%eax
     781:	c1 e8 03             	shr    $0x3,%eax
     784:	83 c0 01             	add    $0x1,%eax
     787:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     78a:	a1 08 1a 00 00       	mov    0x1a08,%eax
     78f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     792:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     796:	75 23                	jne    7bb <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     798:	c7 45 f0 00 1a 00 00 	movl   $0x1a00,-0x10(%ebp)
     79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a2:	a3 08 1a 00 00       	mov    %eax,0x1a08
     7a7:	a1 08 1a 00 00       	mov    0x1a08,%eax
     7ac:	a3 00 1a 00 00       	mov    %eax,0x1a00
    base.s.size = 0;
     7b1:	c7 05 04 1a 00 00 00 	movl   $0x0,0x1a04
     7b8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7be:	8b 00                	mov    (%eax),%eax
     7c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c6:	8b 40 04             	mov    0x4(%eax),%eax
     7c9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7cc:	72 4d                	jb     81b <malloc+0xa6>
      if(p->s.size == nunits)
     7ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d1:	8b 40 04             	mov    0x4(%eax),%eax
     7d4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7d7:	75 0c                	jne    7e5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	8b 10                	mov    (%eax),%edx
     7de:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e1:	89 10                	mov    %edx,(%eax)
     7e3:	eb 26                	jmp    80b <malloc+0x96>
      else {
        p->s.size -= nunits;
     7e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e8:	8b 40 04             	mov    0x4(%eax),%eax
     7eb:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7ee:	89 c2                	mov    %eax,%edx
     7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f9:	8b 40 04             	mov    0x4(%eax),%eax
     7fc:	c1 e0 03             	shl    $0x3,%eax
     7ff:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     802:	8b 45 f4             	mov    -0xc(%ebp),%eax
     805:	8b 55 ec             	mov    -0x14(%ebp),%edx
     808:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     80b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80e:	a3 08 1a 00 00       	mov    %eax,0x1a08
      return (void*)(p + 1);
     813:	8b 45 f4             	mov    -0xc(%ebp),%eax
     816:	83 c0 08             	add    $0x8,%eax
     819:	eb 3b                	jmp    856 <malloc+0xe1>
    }
    if(p == freep)
     81b:	a1 08 1a 00 00       	mov    0x1a08,%eax
     820:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     823:	75 1e                	jne    843 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     825:	83 ec 0c             	sub    $0xc,%esp
     828:	ff 75 ec             	pushl  -0x14(%ebp)
     82b:	e8 e5 fe ff ff       	call   715 <morecore>
     830:	83 c4 10             	add    $0x10,%esp
     833:	89 45 f4             	mov    %eax,-0xc(%ebp)
     836:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     83a:	75 07                	jne    843 <malloc+0xce>
        return 0;
     83c:	b8 00 00 00 00       	mov    $0x0,%eax
     841:	eb 13                	jmp    856 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     843:	8b 45 f4             	mov    -0xc(%ebp),%eax
     846:	89 45 f0             	mov    %eax,-0x10(%ebp)
     849:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84c:	8b 00                	mov    (%eax),%eax
     84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     851:	e9 6d ff ff ff       	jmp    7c3 <malloc+0x4e>
}
     856:	c9                   	leave  
     857:	c3                   	ret    

00000858 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     858:	55                   	push   %ebp
     859:	89 e5                	mov    %esp,%ebp
     85b:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     85e:	83 ec 0c             	sub    $0xc,%esp
     861:	ff 75 08             	pushl  0x8(%ebp)
     864:	e8 b0 00 00 00       	call   919 <re_compile>
     869:	83 c4 10             	add    $0x10,%esp
     86c:	83 ec 04             	sub    $0x4,%esp
     86f:	ff 75 10             	pushl  0x10(%ebp)
     872:	ff 75 0c             	pushl  0xc(%ebp)
     875:	50                   	push   %eax
     876:	e8 05 00 00 00       	call   880 <re_matchp>
     87b:	83 c4 10             	add    $0x10,%esp
}
     87e:	c9                   	leave  
     87f:	c3                   	ret    

00000880 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     886:	8b 45 10             	mov    0x10(%ebp),%eax
     889:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     88f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     893:	74 7d                	je     912 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     895:	8b 45 08             	mov    0x8(%ebp),%eax
     898:	0f b6 00             	movzbl (%eax),%eax
     89b:	3c 02                	cmp    $0x2,%al
     89d:	75 2a                	jne    8c9 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     89f:	8b 45 08             	mov    0x8(%ebp),%eax
     8a2:	83 c0 08             	add    $0x8,%eax
     8a5:	83 ec 04             	sub    $0x4,%esp
     8a8:	ff 75 10             	pushl  0x10(%ebp)
     8ab:	ff 75 0c             	pushl  0xc(%ebp)
     8ae:	50                   	push   %eax
     8af:	e8 b0 08 00 00       	call   1164 <matchpattern>
     8b4:	83 c4 10             	add    $0x10,%esp
     8b7:	85 c0                	test   %eax,%eax
     8b9:	74 07                	je     8c2 <re_matchp+0x42>
     8bb:	b8 00 00 00 00       	mov    $0x0,%eax
     8c0:	eb 55                	jmp    917 <re_matchp+0x97>
     8c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8c7:	eb 4e                	jmp    917 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     8c9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     8d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     8d4:	83 ec 04             	sub    $0x4,%esp
     8d7:	ff 75 10             	pushl  0x10(%ebp)
     8da:	ff 75 0c             	pushl  0xc(%ebp)
     8dd:	ff 75 08             	pushl  0x8(%ebp)
     8e0:	e8 7f 08 00 00       	call   1164 <matchpattern>
     8e5:	83 c4 10             	add    $0x10,%esp
     8e8:	85 c0                	test   %eax,%eax
     8ea:	74 16                	je     902 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     8ec:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ef:	0f b6 00             	movzbl (%eax),%eax
     8f2:	84 c0                	test   %al,%al
     8f4:	75 07                	jne    8fd <re_matchp+0x7d>
            return -1;
     8f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8fb:	eb 1a                	jmp    917 <re_matchp+0x97>
        
          return idx;
     8fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     900:	eb 15                	jmp    917 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     902:	8b 45 0c             	mov    0xc(%ebp),%eax
     905:	8d 50 01             	lea    0x1(%eax),%edx
     908:	89 55 0c             	mov    %edx,0xc(%ebp)
     90b:	0f b6 00             	movzbl (%eax),%eax
     90e:	84 c0                	test   %al,%al
     910:	75 be                	jne    8d0 <re_matchp+0x50>
    }
  }
  return -1;
     912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     917:	c9                   	leave  
     918:	c3                   	ret    

00000919 <re_compile>:

re_t re_compile(const char* pattern)
{
     919:	55                   	push   %ebp
     91a:	89 e5                	mov    %esp,%ebp
     91c:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     91f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     926:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     92d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     934:	e9 55 02 00 00       	jmp    b8e <re_compile+0x275>
  {
    c = pattern[i];
     939:	8b 55 f8             	mov    -0x8(%ebp),%edx
     93c:	8b 45 08             	mov    0x8(%ebp),%eax
     93f:	01 d0                	add    %edx,%eax
     941:	0f b6 00             	movzbl (%eax),%eax
     944:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     947:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     94b:	83 e8 24             	sub    $0x24,%eax
     94e:	83 f8 3a             	cmp    $0x3a,%eax
     951:	0f 87 13 02 00 00    	ja     b6a <re_compile+0x251>
     957:	8b 04 85 c0 12 00 00 	mov    0x12c0(,%eax,4),%eax
     95e:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     960:	8b 45 f4             	mov    -0xc(%ebp),%eax
     963:	c6 04 c5 20 1a 00 00 	movb   $0x2,0x1a20(,%eax,8)
     96a:	02 
     96b:	e9 16 02 00 00       	jmp    b86 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     970:	8b 45 f4             	mov    -0xc(%ebp),%eax
     973:	c6 04 c5 20 1a 00 00 	movb   $0x3,0x1a20(,%eax,8)
     97a:	03 
     97b:	e9 06 02 00 00       	jmp    b86 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     980:	8b 45 f4             	mov    -0xc(%ebp),%eax
     983:	c6 04 c5 20 1a 00 00 	movb   $0x1,0x1a20(,%eax,8)
     98a:	01 
     98b:	e9 f6 01 00 00       	jmp    b86 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     990:	8b 45 f4             	mov    -0xc(%ebp),%eax
     993:	c6 04 c5 20 1a 00 00 	movb   $0x5,0x1a20(,%eax,8)
     99a:	05 
     99b:	e9 e6 01 00 00       	jmp    b86 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a3:	c6 04 c5 20 1a 00 00 	movb   $0x6,0x1a20(,%eax,8)
     9aa:	06 
     9ab:	e9 d6 01 00 00       	jmp    b86 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     9b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b3:	c6 04 c5 20 1a 00 00 	movb   $0x4,0x1a20(,%eax,8)
     9ba:	04 
     9bb:	e9 c6 01 00 00       	jmp    b86 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     9c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9c3:	8d 50 01             	lea    0x1(%eax),%edx
     9c6:	8b 45 08             	mov    0x8(%ebp),%eax
     9c9:	01 d0                	add    %edx,%eax
     9cb:	0f b6 00             	movzbl (%eax),%eax
     9ce:	84 c0                	test   %al,%al
     9d0:	0f 84 af 01 00 00    	je     b85 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     9d6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     9da:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9dd:	8b 45 08             	mov    0x8(%ebp),%eax
     9e0:	01 d0                	add    %edx,%eax
     9e2:	0f b6 00             	movzbl (%eax),%eax
     9e5:	0f be c0             	movsbl %al,%eax
     9e8:	83 e8 44             	sub    $0x44,%eax
     9eb:	83 f8 33             	cmp    $0x33,%eax
     9ee:	77 57                	ja     a47 <re_compile+0x12e>
     9f0:	8b 04 85 ac 13 00 00 	mov    0x13ac(,%eax,4),%eax
     9f7:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fc:	c6 04 c5 20 1a 00 00 	movb   $0xa,0x1a20(,%eax,8)
     a03:	0a 
     a04:	eb 64                	jmp    a6a <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a09:	c6 04 c5 20 1a 00 00 	movb   $0xb,0x1a20(,%eax,8)
     a10:	0b 
     a11:	eb 57                	jmp    a6a <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a16:	c6 04 c5 20 1a 00 00 	movb   $0xc,0x1a20(,%eax,8)
     a1d:	0c 
     a1e:	eb 4a                	jmp    a6a <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a23:	c6 04 c5 20 1a 00 00 	movb   $0xd,0x1a20(,%eax,8)
     a2a:	0d 
     a2b:	eb 3d                	jmp    a6a <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a30:	c6 04 c5 20 1a 00 00 	movb   $0xe,0x1a20(,%eax,8)
     a37:	0e 
     a38:	eb 30                	jmp    a6a <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3d:	c6 04 c5 20 1a 00 00 	movb   $0xf,0x1a20(,%eax,8)
     a44:	0f 
     a45:	eb 23                	jmp    a6a <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4a:	c6 04 c5 20 1a 00 00 	movb   $0x7,0x1a20(,%eax,8)
     a51:	07 
              re_compiled[j].ch = pattern[i];
     a52:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a55:	8b 45 08             	mov    0x8(%ebp),%eax
     a58:	01 d0                	add    %edx,%eax
     a5a:	0f b6 00             	movzbl (%eax),%eax
     a5d:	89 c2                	mov    %eax,%edx
     a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a62:	88 14 c5 24 1a 00 00 	mov    %dl,0x1a24(,%eax,8)
            } break;
     a69:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a6a:	e9 16 01 00 00       	jmp    b85 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a72:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a75:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a78:	8d 50 01             	lea    0x1(%eax),%edx
     a7b:	8b 45 08             	mov    0x8(%ebp),%eax
     a7e:	01 d0                	add    %edx,%eax
     a80:	0f b6 00             	movzbl (%eax),%eax
     a83:	3c 5e                	cmp    $0x5e,%al
     a85:	75 11                	jne    a98 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8a:	c6 04 c5 20 1a 00 00 	movb   $0x9,0x1a20(,%eax,8)
     a91:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     a92:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     a96:	eb 7a                	jmp    b12 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9b:	c6 04 c5 20 1a 00 00 	movb   $0x8,0x1a20(,%eax,8)
     aa2:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     aa3:	eb 6d                	jmp    b12 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     aa5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     aa8:	8b 45 08             	mov    0x8(%ebp),%eax
     aab:	01 d0                	add    %edx,%eax
     aad:	0f b6 00             	movzbl (%eax),%eax
     ab0:	3c 5c                	cmp    $0x5c,%al
     ab2:	75 34                	jne    ae8 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     ab4:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     ab8:	7e 0a                	jle    ac4 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aba:	b8 00 00 00 00       	mov    $0x0,%eax
     abf:	e9 f8 00 00 00       	jmp    bbc <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ac4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ac7:	8d 50 01             	lea    0x1(%eax),%edx
     aca:	89 55 fc             	mov    %edx,-0x4(%ebp)
     acd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ad0:	8d 4a 01             	lea    0x1(%edx),%ecx
     ad3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ad6:	89 d1                	mov    %edx,%ecx
     ad8:	8b 55 08             	mov    0x8(%ebp),%edx
     adb:	01 ca                	add    %ecx,%edx
     add:	0f b6 12             	movzbl (%edx),%edx
     ae0:	88 90 20 1b 00 00    	mov    %dl,0x1b20(%eax)
     ae6:	eb 10                	jmp    af8 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     ae8:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     aec:	7e 0a                	jle    af8 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aee:	b8 00 00 00 00       	mov    $0x0,%eax
     af3:	e9 c4 00 00 00       	jmp    bbc <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     af8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     afb:	8d 50 01             	lea    0x1(%eax),%edx
     afe:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b01:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     b04:	8b 55 08             	mov    0x8(%ebp),%edx
     b07:	01 ca                	add    %ecx,%edx
     b09:	0f b6 12             	movzbl (%edx),%edx
     b0c:	88 90 20 1b 00 00    	mov    %dl,0x1b20(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b12:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b16:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b19:	8b 45 08             	mov    0x8(%ebp),%eax
     b1c:	01 d0                	add    %edx,%eax
     b1e:	0f b6 00             	movzbl (%eax),%eax
     b21:	3c 5d                	cmp    $0x5d,%al
     b23:	74 13                	je     b38 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     b25:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b28:	8b 45 08             	mov    0x8(%ebp),%eax
     b2b:	01 d0                	add    %edx,%eax
     b2d:	0f b6 00             	movzbl (%eax),%eax
     b30:	84 c0                	test   %al,%al
     b32:	0f 85 6d ff ff ff    	jne    aa5 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b38:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b3c:	7e 07                	jle    b45 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     b3e:	b8 00 00 00 00       	mov    $0x0,%eax
     b43:	eb 77                	jmp    bbc <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     b45:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b48:	8d 50 01             	lea    0x1(%eax),%edx
     b4b:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b4e:	c6 80 20 1b 00 00 00 	movb   $0x0,0x1b20(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b55:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b58:	8d 90 20 1b 00 00    	lea    0x1b20(%eax),%edx
     b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b61:	89 14 c5 24 1a 00 00 	mov    %edx,0x1a24(,%eax,8)
      } break;
     b68:	eb 1c                	jmp    b86 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6d:	c6 04 c5 20 1a 00 00 	movb   $0x7,0x1a20(,%eax,8)
     b74:	07 
        re_compiled[j].ch = c;
     b75:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7c:	88 14 c5 24 1a 00 00 	mov    %dl,0x1a24(,%eax,8)
      } break;
     b83:	eb 01                	jmp    b86 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b85:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     b86:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     b8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     b8e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b91:	8b 45 08             	mov    0x8(%ebp),%eax
     b94:	01 d0                	add    %edx,%eax
     b96:	0f b6 00             	movzbl (%eax),%eax
     b99:	84 c0                	test   %al,%al
     b9b:	74 0f                	je     bac <re_compile+0x293>
     b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba0:	83 c0 01             	add    $0x1,%eax
     ba3:	83 f8 1d             	cmp    $0x1d,%eax
     ba6:	0f 8e 8d fd ff ff    	jle    939 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     baf:	c6 04 c5 20 1a 00 00 	movb   $0x0,0x1a20(,%eax,8)
     bb6:	00 

  return (re_t) re_compiled;
     bb7:	b8 20 1a 00 00       	mov    $0x1a20,%eax
}
     bbc:	c9                   	leave  
     bbd:	c3                   	ret    

00000bbe <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     bbe:	55                   	push   %ebp
     bbf:	89 e5                	mov    %esp,%ebp
     bc1:	83 ec 04             	sub    $0x4,%esp
     bc4:	8b 45 08             	mov    0x8(%ebp),%eax
     bc7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     bca:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     bce:	7e 0d                	jle    bdd <matchdigit+0x1f>
     bd0:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     bd4:	7f 07                	jg     bdd <matchdigit+0x1f>
     bd6:	b8 01 00 00 00       	mov    $0x1,%eax
     bdb:	eb 05                	jmp    be2 <matchdigit+0x24>
     bdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     be2:	c9                   	leave  
     be3:	c3                   	ret    

00000be4 <matchalpha>:
static int matchalpha(char c)
{
     be4:	55                   	push   %ebp
     be5:	89 e5                	mov    %esp,%ebp
     be7:	83 ec 04             	sub    $0x4,%esp
     bea:	8b 45 08             	mov    0x8(%ebp),%eax
     bed:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     bf0:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     bf4:	7e 06                	jle    bfc <matchalpha+0x18>
     bf6:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     bfa:	7e 0c                	jle    c08 <matchalpha+0x24>
     bfc:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     c00:	7e 0d                	jle    c0f <matchalpha+0x2b>
     c02:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     c06:	7f 07                	jg     c0f <matchalpha+0x2b>
     c08:	b8 01 00 00 00       	mov    $0x1,%eax
     c0d:	eb 05                	jmp    c14 <matchalpha+0x30>
     c0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c14:	c9                   	leave  
     c15:	c3                   	ret    

00000c16 <matchwhitespace>:
static int matchwhitespace(char c)
{
     c16:	55                   	push   %ebp
     c17:	89 e5                	mov    %esp,%ebp
     c19:	83 ec 04             	sub    $0x4,%esp
     c1c:	8b 45 08             	mov    0x8(%ebp),%eax
     c1f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     c22:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     c26:	74 1e                	je     c46 <matchwhitespace+0x30>
     c28:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     c2c:	74 18                	je     c46 <matchwhitespace+0x30>
     c2e:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     c32:	74 12                	je     c46 <matchwhitespace+0x30>
     c34:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     c38:	74 0c                	je     c46 <matchwhitespace+0x30>
     c3a:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     c3e:	74 06                	je     c46 <matchwhitespace+0x30>
     c40:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     c44:	75 07                	jne    c4d <matchwhitespace+0x37>
     c46:	b8 01 00 00 00       	mov    $0x1,%eax
     c4b:	eb 05                	jmp    c52 <matchwhitespace+0x3c>
     c4d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c52:	c9                   	leave  
     c53:	c3                   	ret    

00000c54 <matchalphanum>:
static int matchalphanum(char c)
{
     c54:	55                   	push   %ebp
     c55:	89 e5                	mov    %esp,%ebp
     c57:	83 ec 04             	sub    $0x4,%esp
     c5a:	8b 45 08             	mov    0x8(%ebp),%eax
     c5d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c60:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c64:	74 22                	je     c88 <matchalphanum+0x34>
     c66:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c6a:	50                   	push   %eax
     c6b:	e8 74 ff ff ff       	call   be4 <matchalpha>
     c70:	83 c4 04             	add    $0x4,%esp
     c73:	85 c0                	test   %eax,%eax
     c75:	75 11                	jne    c88 <matchalphanum+0x34>
     c77:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c7b:	50                   	push   %eax
     c7c:	e8 3d ff ff ff       	call   bbe <matchdigit>
     c81:	83 c4 04             	add    $0x4,%esp
     c84:	85 c0                	test   %eax,%eax
     c86:	74 07                	je     c8f <matchalphanum+0x3b>
     c88:	b8 01 00 00 00       	mov    $0x1,%eax
     c8d:	eb 05                	jmp    c94 <matchalphanum+0x40>
     c8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c94:	c9                   	leave  
     c95:	c3                   	ret    

00000c96 <matchrange>:
static int matchrange(char c, const char* str)
{
     c96:	55                   	push   %ebp
     c97:	89 e5                	mov    %esp,%ebp
     c99:	83 ec 04             	sub    $0x4,%esp
     c9c:	8b 45 08             	mov    0x8(%ebp),%eax
     c9f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     ca2:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     ca6:	74 5b                	je     d03 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
     cab:	0f b6 00             	movzbl (%eax),%eax
     cae:	84 c0                	test   %al,%al
     cb0:	74 51                	je     d03 <matchrange+0x6d>
     cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb5:	0f b6 00             	movzbl (%eax),%eax
     cb8:	3c 2d                	cmp    $0x2d,%al
     cba:	74 47                	je     d03 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbf:	83 c0 01             	add    $0x1,%eax
     cc2:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     cc5:	3c 2d                	cmp    $0x2d,%al
     cc7:	75 3a                	jne    d03 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
     ccc:	83 c0 01             	add    $0x1,%eax
     ccf:	0f b6 00             	movzbl (%eax),%eax
     cd2:	84 c0                	test   %al,%al
     cd4:	74 2d                	je     d03 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cd6:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd9:	83 c0 02             	add    $0x2,%eax
     cdc:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     cdf:	84 c0                	test   %al,%al
     ce1:	74 20                	je     d03 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce6:	0f b6 00             	movzbl (%eax),%eax
     ce9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cec:	7f 15                	jg     d03 <matchrange+0x6d>
     cee:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf1:	83 c0 02             	add    $0x2,%eax
     cf4:	0f b6 00             	movzbl (%eax),%eax
     cf7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cfa:	7c 07                	jl     d03 <matchrange+0x6d>
     cfc:	b8 01 00 00 00       	mov    $0x1,%eax
     d01:	eb 05                	jmp    d08 <matchrange+0x72>
     d03:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d08:	c9                   	leave  
     d09:	c3                   	ret    

00000d0a <ismetachar>:
static int ismetachar(char c)
{
     d0a:	55                   	push   %ebp
     d0b:	89 e5                	mov    %esp,%ebp
     d0d:	83 ec 04             	sub    $0x4,%esp
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     d16:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     d1a:	74 1e                	je     d3a <ismetachar+0x30>
     d1c:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     d20:	74 18                	je     d3a <ismetachar+0x30>
     d22:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     d26:	74 12                	je     d3a <ismetachar+0x30>
     d28:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     d2c:	74 0c                	je     d3a <ismetachar+0x30>
     d2e:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     d32:	74 06                	je     d3a <ismetachar+0x30>
     d34:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     d38:	75 07                	jne    d41 <ismetachar+0x37>
     d3a:	b8 01 00 00 00       	mov    $0x1,%eax
     d3f:	eb 05                	jmp    d46 <ismetachar+0x3c>
     d41:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d46:	c9                   	leave  
     d47:	c3                   	ret    

00000d48 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d48:	55                   	push   %ebp
     d49:	89 e5                	mov    %esp,%ebp
     d4b:	83 ec 04             	sub    $0x4,%esp
     d4e:	8b 45 08             	mov    0x8(%ebp),%eax
     d51:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d54:	8b 45 0c             	mov    0xc(%ebp),%eax
     d57:	0f b6 00             	movzbl (%eax),%eax
     d5a:	0f be c0             	movsbl %al,%eax
     d5d:	83 e8 44             	sub    $0x44,%eax
     d60:	83 f8 33             	cmp    $0x33,%eax
     d63:	77 7b                	ja     de0 <matchmetachar+0x98>
     d65:	8b 04 85 7c 14 00 00 	mov    0x147c(,%eax,4),%eax
     d6c:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d6e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d72:	50                   	push   %eax
     d73:	e8 46 fe ff ff       	call   bbe <matchdigit>
     d78:	83 c4 04             	add    $0x4,%esp
     d7b:	eb 72                	jmp    def <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d7d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d81:	50                   	push   %eax
     d82:	e8 37 fe ff ff       	call   bbe <matchdigit>
     d87:	83 c4 04             	add    $0x4,%esp
     d8a:	85 c0                	test   %eax,%eax
     d8c:	0f 94 c0             	sete   %al
     d8f:	0f b6 c0             	movzbl %al,%eax
     d92:	eb 5b                	jmp    def <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     d94:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d98:	50                   	push   %eax
     d99:	e8 b6 fe ff ff       	call   c54 <matchalphanum>
     d9e:	83 c4 04             	add    $0x4,%esp
     da1:	eb 4c                	jmp    def <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     da3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     da7:	50                   	push   %eax
     da8:	e8 a7 fe ff ff       	call   c54 <matchalphanum>
     dad:	83 c4 04             	add    $0x4,%esp
     db0:	85 c0                	test   %eax,%eax
     db2:	0f 94 c0             	sete   %al
     db5:	0f b6 c0             	movzbl %al,%eax
     db8:	eb 35                	jmp    def <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     dba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dbe:	50                   	push   %eax
     dbf:	e8 52 fe ff ff       	call   c16 <matchwhitespace>
     dc4:	83 c4 04             	add    $0x4,%esp
     dc7:	eb 26                	jmp    def <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     dc9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dcd:	50                   	push   %eax
     dce:	e8 43 fe ff ff       	call   c16 <matchwhitespace>
     dd3:	83 c4 04             	add    $0x4,%esp
     dd6:	85 c0                	test   %eax,%eax
     dd8:	0f 94 c0             	sete   %al
     ddb:	0f b6 c0             	movzbl %al,%eax
     dde:	eb 0f                	jmp    def <matchmetachar+0xa7>
    default:  return (c == str[0]);
     de0:	8b 45 0c             	mov    0xc(%ebp),%eax
     de3:	0f b6 00             	movzbl (%eax),%eax
     de6:	3a 45 fc             	cmp    -0x4(%ebp),%al
     de9:	0f 94 c0             	sete   %al
     dec:	0f b6 c0             	movzbl %al,%eax
  }
}
     def:	c9                   	leave  
     df0:	c3                   	ret    

00000df1 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     df1:	55                   	push   %ebp
     df2:	89 e5                	mov    %esp,%ebp
     df4:	83 ec 04             	sub    $0x4,%esp
     df7:	8b 45 08             	mov    0x8(%ebp),%eax
     dfa:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     dfd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e01:	ff 75 0c             	pushl  0xc(%ebp)
     e04:	50                   	push   %eax
     e05:	e8 8c fe ff ff       	call   c96 <matchrange>
     e0a:	83 c4 08             	add    $0x8,%esp
     e0d:	85 c0                	test   %eax,%eax
     e0f:	74 0a                	je     e1b <matchcharclass+0x2a>
    {
      return 1;
     e11:	b8 01 00 00 00       	mov    $0x1,%eax
     e16:	e9 a5 00 00 00       	jmp    ec0 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     e1b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e1e:	0f b6 00             	movzbl (%eax),%eax
     e21:	3c 5c                	cmp    $0x5c,%al
     e23:	75 42                	jne    e67 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     e25:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     e29:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e2d:	ff 75 0c             	pushl  0xc(%ebp)
     e30:	50                   	push   %eax
     e31:	e8 12 ff ff ff       	call   d48 <matchmetachar>
     e36:	83 c4 08             	add    $0x8,%esp
     e39:	85 c0                	test   %eax,%eax
     e3b:	74 07                	je     e44 <matchcharclass+0x53>
      {
        return 1;
     e3d:	b8 01 00 00 00       	mov    $0x1,%eax
     e42:	eb 7c                	jmp    ec0 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     e44:	8b 45 0c             	mov    0xc(%ebp),%eax
     e47:	0f b6 00             	movzbl (%eax),%eax
     e4a:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e4d:	75 58                	jne    ea7 <matchcharclass+0xb6>
     e4f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e53:	50                   	push   %eax
     e54:	e8 b1 fe ff ff       	call   d0a <ismetachar>
     e59:	83 c4 04             	add    $0x4,%esp
     e5c:	85 c0                	test   %eax,%eax
     e5e:	75 47                	jne    ea7 <matchcharclass+0xb6>
      {
        return 1;
     e60:	b8 01 00 00 00       	mov    $0x1,%eax
     e65:	eb 59                	jmp    ec0 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e67:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6a:	0f b6 00             	movzbl (%eax),%eax
     e6d:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e70:	75 35                	jne    ea7 <matchcharclass+0xb6>
    {
      if (c == '-')
     e72:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e76:	75 28                	jne    ea0 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e78:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7b:	83 e8 01             	sub    $0x1,%eax
     e7e:	0f b6 00             	movzbl (%eax),%eax
     e81:	84 c0                	test   %al,%al
     e83:	74 0d                	je     e92 <matchcharclass+0xa1>
     e85:	8b 45 0c             	mov    0xc(%ebp),%eax
     e88:	83 c0 01             	add    $0x1,%eax
     e8b:	0f b6 00             	movzbl (%eax),%eax
     e8e:	84 c0                	test   %al,%al
     e90:	75 07                	jne    e99 <matchcharclass+0xa8>
     e92:	b8 01 00 00 00       	mov    $0x1,%eax
     e97:	eb 27                	jmp    ec0 <matchcharclass+0xcf>
     e99:	b8 00 00 00 00       	mov    $0x0,%eax
     e9e:	eb 20                	jmp    ec0 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     ea0:	b8 01 00 00 00       	mov    $0x1,%eax
     ea5:	eb 19                	jmp    ec0 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaa:	8d 50 01             	lea    0x1(%eax),%edx
     ead:	89 55 0c             	mov    %edx,0xc(%ebp)
     eb0:	0f b6 00             	movzbl (%eax),%eax
     eb3:	84 c0                	test   %al,%al
     eb5:	0f 85 42 ff ff ff    	jne    dfd <matchcharclass+0xc>

  return 0;
     ebb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ec0:	c9                   	leave  
     ec1:	c3                   	ret    

00000ec2 <matchone>:

static int matchone(regex_t p, char c)
{
     ec2:	55                   	push   %ebp
     ec3:	89 e5                	mov    %esp,%ebp
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	8b 45 10             	mov    0x10(%ebp),%eax
     ecb:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     ece:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     ed2:	0f b6 c0             	movzbl %al,%eax
     ed5:	83 f8 0f             	cmp    $0xf,%eax
     ed8:	0f 87 b9 00 00 00    	ja     f97 <matchone+0xd5>
     ede:	8b 04 85 4c 15 00 00 	mov    0x154c(,%eax,4),%eax
     ee5:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     ee7:	b8 01 00 00 00       	mov    $0x1,%eax
     eec:	e9 b9 00 00 00       	jmp    faa <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
     ef4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ef8:	52                   	push   %edx
     ef9:	50                   	push   %eax
     efa:	e8 f2 fe ff ff       	call   df1 <matchcharclass>
     eff:	83 c4 08             	add    $0x8,%esp
     f02:	e9 a3 00 00 00       	jmp    faa <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     f07:	8b 55 0c             	mov    0xc(%ebp),%edx
     f0a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f0e:	52                   	push   %edx
     f0f:	50                   	push   %eax
     f10:	e8 dc fe ff ff       	call   df1 <matchcharclass>
     f15:	83 c4 08             	add    $0x8,%esp
     f18:	85 c0                	test   %eax,%eax
     f1a:	0f 94 c0             	sete   %al
     f1d:	0f b6 c0             	movzbl %al,%eax
     f20:	e9 85 00 00 00       	jmp    faa <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     f25:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f29:	50                   	push   %eax
     f2a:	e8 8f fc ff ff       	call   bbe <matchdigit>
     f2f:	83 c4 04             	add    $0x4,%esp
     f32:	eb 76                	jmp    faa <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     f34:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f38:	50                   	push   %eax
     f39:	e8 80 fc ff ff       	call   bbe <matchdigit>
     f3e:	83 c4 04             	add    $0x4,%esp
     f41:	85 c0                	test   %eax,%eax
     f43:	0f 94 c0             	sete   %al
     f46:	0f b6 c0             	movzbl %al,%eax
     f49:	eb 5f                	jmp    faa <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f4b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4f:	50                   	push   %eax
     f50:	e8 ff fc ff ff       	call   c54 <matchalphanum>
     f55:	83 c4 04             	add    $0x4,%esp
     f58:	eb 50                	jmp    faa <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f5a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f5e:	50                   	push   %eax
     f5f:	e8 f0 fc ff ff       	call   c54 <matchalphanum>
     f64:	83 c4 04             	add    $0x4,%esp
     f67:	85 c0                	test   %eax,%eax
     f69:	0f 94 c0             	sete   %al
     f6c:	0f b6 c0             	movzbl %al,%eax
     f6f:	eb 39                	jmp    faa <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f71:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f75:	50                   	push   %eax
     f76:	e8 9b fc ff ff       	call   c16 <matchwhitespace>
     f7b:	83 c4 04             	add    $0x4,%esp
     f7e:	eb 2a                	jmp    faa <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f80:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f84:	50                   	push   %eax
     f85:	e8 8c fc ff ff       	call   c16 <matchwhitespace>
     f8a:	83 c4 04             	add    $0x4,%esp
     f8d:	85 c0                	test   %eax,%eax
     f8f:	0f 94 c0             	sete   %al
     f92:	0f b6 c0             	movzbl %al,%eax
     f95:	eb 13                	jmp    faa <matchone+0xe8>
    default:             return  (p.ch == c);
     f97:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     f9b:	0f b6 d0             	movzbl %al,%edx
     f9e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fa2:	39 c2                	cmp    %eax,%edx
     fa4:	0f 94 c0             	sete   %al
     fa7:	0f b6 c0             	movzbl %al,%eax
  }
}
     faa:	c9                   	leave  
     fab:	c3                   	ret    

00000fac <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     fac:	55                   	push   %ebp
     fad:	89 e5                	mov    %esp,%ebp
     faf:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     fb2:	8b 45 18             	mov    0x18(%ebp),%eax
     fb5:	8b 00                	mov    (%eax),%eax
     fb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     fba:	8b 45 14             	mov    0x14(%ebp),%eax
     fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     fc0:	eb 11                	jmp    fd3 <matchstar+0x27>
  {
    text++;
     fc2:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     fc6:	8b 45 18             	mov    0x18(%ebp),%eax
     fc9:	8b 00                	mov    (%eax),%eax
     fcb:	8d 50 01             	lea    0x1(%eax),%edx
     fce:	8b 45 18             	mov    0x18(%ebp),%eax
     fd1:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     fd3:	8b 45 14             	mov    0x14(%ebp),%eax
     fd6:	0f b6 00             	movzbl (%eax),%eax
     fd9:	84 c0                	test   %al,%al
     fdb:	74 51                	je     102e <matchstar+0x82>
     fdd:	8b 45 14             	mov    0x14(%ebp),%eax
     fe0:	0f b6 00             	movzbl (%eax),%eax
     fe3:	0f be c0             	movsbl %al,%eax
     fe6:	50                   	push   %eax
     fe7:	ff 75 0c             	pushl  0xc(%ebp)
     fea:	ff 75 08             	pushl  0x8(%ebp)
     fed:	e8 d0 fe ff ff       	call   ec2 <matchone>
     ff2:	83 c4 0c             	add    $0xc,%esp
     ff5:	85 c0                	test   %eax,%eax
     ff7:	75 c9                	jne    fc2 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     ff9:	eb 33                	jmp    102e <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     ffb:	8b 45 14             	mov    0x14(%ebp),%eax
     ffe:	8d 50 ff             	lea    -0x1(%eax),%edx
    1001:	89 55 14             	mov    %edx,0x14(%ebp)
    1004:	83 ec 04             	sub    $0x4,%esp
    1007:	ff 75 18             	pushl  0x18(%ebp)
    100a:	50                   	push   %eax
    100b:	ff 75 10             	pushl  0x10(%ebp)
    100e:	e8 51 01 00 00       	call   1164 <matchpattern>
    1013:	83 c4 10             	add    $0x10,%esp
    1016:	85 c0                	test   %eax,%eax
    1018:	74 07                	je     1021 <matchstar+0x75>
      return 1;
    101a:	b8 01 00 00 00       	mov    $0x1,%eax
    101f:	eb 22                	jmp    1043 <matchstar+0x97>
    (*matchlength)--;
    1021:	8b 45 18             	mov    0x18(%ebp),%eax
    1024:	8b 00                	mov    (%eax),%eax
    1026:	8d 50 ff             	lea    -0x1(%eax),%edx
    1029:	8b 45 18             	mov    0x18(%ebp),%eax
    102c:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    102e:	8b 45 14             	mov    0x14(%ebp),%eax
    1031:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1034:	73 c5                	jae    ffb <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1036:	8b 45 18             	mov    0x18(%ebp),%eax
    1039:	8b 55 f4             	mov    -0xc(%ebp),%edx
    103c:	89 10                	mov    %edx,(%eax)
  return 0;
    103e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1043:	c9                   	leave  
    1044:	c3                   	ret    

00001045 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1045:	55                   	push   %ebp
    1046:	89 e5                	mov    %esp,%ebp
    1048:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    104b:	8b 45 14             	mov    0x14(%ebp),%eax
    104e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1051:	eb 11                	jmp    1064 <matchplus+0x1f>
  {
    text++;
    1053:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1057:	8b 45 18             	mov    0x18(%ebp),%eax
    105a:	8b 00                	mov    (%eax),%eax
    105c:	8d 50 01             	lea    0x1(%eax),%edx
    105f:	8b 45 18             	mov    0x18(%ebp),%eax
    1062:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1064:	8b 45 14             	mov    0x14(%ebp),%eax
    1067:	0f b6 00             	movzbl (%eax),%eax
    106a:	84 c0                	test   %al,%al
    106c:	74 51                	je     10bf <matchplus+0x7a>
    106e:	8b 45 14             	mov    0x14(%ebp),%eax
    1071:	0f b6 00             	movzbl (%eax),%eax
    1074:	0f be c0             	movsbl %al,%eax
    1077:	50                   	push   %eax
    1078:	ff 75 0c             	pushl  0xc(%ebp)
    107b:	ff 75 08             	pushl  0x8(%ebp)
    107e:	e8 3f fe ff ff       	call   ec2 <matchone>
    1083:	83 c4 0c             	add    $0xc,%esp
    1086:	85 c0                	test   %eax,%eax
    1088:	75 c9                	jne    1053 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    108a:	eb 33                	jmp    10bf <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    108c:	8b 45 14             	mov    0x14(%ebp),%eax
    108f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1092:	89 55 14             	mov    %edx,0x14(%ebp)
    1095:	83 ec 04             	sub    $0x4,%esp
    1098:	ff 75 18             	pushl  0x18(%ebp)
    109b:	50                   	push   %eax
    109c:	ff 75 10             	pushl  0x10(%ebp)
    109f:	e8 c0 00 00 00       	call   1164 <matchpattern>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	85 c0                	test   %eax,%eax
    10a9:	74 07                	je     10b2 <matchplus+0x6d>
      return 1;
    10ab:	b8 01 00 00 00       	mov    $0x1,%eax
    10b0:	eb 1a                	jmp    10cc <matchplus+0x87>
    (*matchlength)--;
    10b2:	8b 45 18             	mov    0x18(%ebp),%eax
    10b5:	8b 00                	mov    (%eax),%eax
    10b7:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ba:	8b 45 18             	mov    0x18(%ebp),%eax
    10bd:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10bf:	8b 45 14             	mov    0x14(%ebp),%eax
    10c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10c5:	77 c5                	ja     108c <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    10c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10cc:	c9                   	leave  
    10cd:	c3                   	ret    

000010ce <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10ce:	55                   	push   %ebp
    10cf:	89 e5                	mov    %esp,%ebp
    10d1:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    10d4:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10d8:	84 c0                	test   %al,%al
    10da:	75 07                	jne    10e3 <matchquestion+0x15>
    return 1;
    10dc:	b8 01 00 00 00       	mov    $0x1,%eax
    10e1:	eb 7f                	jmp    1162 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    10e3:	83 ec 04             	sub    $0x4,%esp
    10e6:	ff 75 18             	pushl  0x18(%ebp)
    10e9:	ff 75 14             	pushl  0x14(%ebp)
    10ec:	ff 75 10             	pushl  0x10(%ebp)
    10ef:	e8 70 00 00 00       	call   1164 <matchpattern>
    10f4:	83 c4 10             	add    $0x10,%esp
    10f7:	85 c0                	test   %eax,%eax
    10f9:	74 07                	je     1102 <matchquestion+0x34>
      return 1;
    10fb:	b8 01 00 00 00       	mov    $0x1,%eax
    1100:	eb 60                	jmp    1162 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    1102:	8b 45 14             	mov    0x14(%ebp),%eax
    1105:	0f b6 00             	movzbl (%eax),%eax
    1108:	84 c0                	test   %al,%al
    110a:	74 51                	je     115d <matchquestion+0x8f>
    110c:	8b 45 14             	mov    0x14(%ebp),%eax
    110f:	8d 50 01             	lea    0x1(%eax),%edx
    1112:	89 55 14             	mov    %edx,0x14(%ebp)
    1115:	0f b6 00             	movzbl (%eax),%eax
    1118:	0f be c0             	movsbl %al,%eax
    111b:	83 ec 04             	sub    $0x4,%esp
    111e:	50                   	push   %eax
    111f:	ff 75 0c             	pushl  0xc(%ebp)
    1122:	ff 75 08             	pushl  0x8(%ebp)
    1125:	e8 98 fd ff ff       	call   ec2 <matchone>
    112a:	83 c4 10             	add    $0x10,%esp
    112d:	85 c0                	test   %eax,%eax
    112f:	74 2c                	je     115d <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    1131:	83 ec 04             	sub    $0x4,%esp
    1134:	ff 75 18             	pushl  0x18(%ebp)
    1137:	ff 75 14             	pushl  0x14(%ebp)
    113a:	ff 75 10             	pushl  0x10(%ebp)
    113d:	e8 22 00 00 00       	call   1164 <matchpattern>
    1142:	83 c4 10             	add    $0x10,%esp
    1145:	85 c0                	test   %eax,%eax
    1147:	74 14                	je     115d <matchquestion+0x8f>
    {
      (*matchlength)++;
    1149:	8b 45 18             	mov    0x18(%ebp),%eax
    114c:	8b 00                	mov    (%eax),%eax
    114e:	8d 50 01             	lea    0x1(%eax),%edx
    1151:	8b 45 18             	mov    0x18(%ebp),%eax
    1154:	89 10                	mov    %edx,(%eax)
      return 1;
    1156:	b8 01 00 00 00       	mov    $0x1,%eax
    115b:	eb 05                	jmp    1162 <matchquestion+0x94>
    }
  }
  return 0;
    115d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1162:	c9                   	leave  
    1163:	c3                   	ret    

00001164 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1164:	55                   	push   %ebp
    1165:	89 e5                	mov    %esp,%ebp
    1167:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    116a:	8b 45 10             	mov    0x10(%ebp),%eax
    116d:	8b 00                	mov    (%eax),%eax
    116f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1172:	8b 45 08             	mov    0x8(%ebp),%eax
    1175:	0f b6 00             	movzbl (%eax),%eax
    1178:	84 c0                	test   %al,%al
    117a:	74 0d                	je     1189 <matchpattern+0x25>
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	83 c0 08             	add    $0x8,%eax
    1182:	0f b6 00             	movzbl (%eax),%eax
    1185:	3c 04                	cmp    $0x4,%al
    1187:	75 25                	jne    11ae <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1189:	8b 45 08             	mov    0x8(%ebp),%eax
    118c:	83 c0 10             	add    $0x10,%eax
    118f:	83 ec 0c             	sub    $0xc,%esp
    1192:	ff 75 10             	pushl  0x10(%ebp)
    1195:	ff 75 0c             	pushl  0xc(%ebp)
    1198:	50                   	push   %eax
    1199:	8b 45 08             	mov    0x8(%ebp),%eax
    119c:	ff 70 04             	pushl  0x4(%eax)
    119f:	ff 30                	pushl  (%eax)
    11a1:	e8 28 ff ff ff       	call   10ce <matchquestion>
    11a6:	83 c4 20             	add    $0x20,%esp
    11a9:	e9 dd 00 00 00       	jmp    128b <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    11ae:	8b 45 08             	mov    0x8(%ebp),%eax
    11b1:	83 c0 08             	add    $0x8,%eax
    11b4:	0f b6 00             	movzbl (%eax),%eax
    11b7:	3c 05                	cmp    $0x5,%al
    11b9:	75 25                	jne    11e0 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	83 c0 10             	add    $0x10,%eax
    11c1:	83 ec 0c             	sub    $0xc,%esp
    11c4:	ff 75 10             	pushl  0x10(%ebp)
    11c7:	ff 75 0c             	pushl  0xc(%ebp)
    11ca:	50                   	push   %eax
    11cb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ce:	ff 70 04             	pushl  0x4(%eax)
    11d1:	ff 30                	pushl  (%eax)
    11d3:	e8 d4 fd ff ff       	call   fac <matchstar>
    11d8:	83 c4 20             	add    $0x20,%esp
    11db:	e9 ab 00 00 00       	jmp    128b <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    11e0:	8b 45 08             	mov    0x8(%ebp),%eax
    11e3:	83 c0 08             	add    $0x8,%eax
    11e6:	0f b6 00             	movzbl (%eax),%eax
    11e9:	3c 06                	cmp    $0x6,%al
    11eb:	75 22                	jne    120f <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    11ed:	8b 45 08             	mov    0x8(%ebp),%eax
    11f0:	83 c0 10             	add    $0x10,%eax
    11f3:	83 ec 0c             	sub    $0xc,%esp
    11f6:	ff 75 10             	pushl  0x10(%ebp)
    11f9:	ff 75 0c             	pushl  0xc(%ebp)
    11fc:	50                   	push   %eax
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	ff 70 04             	pushl  0x4(%eax)
    1203:	ff 30                	pushl  (%eax)
    1205:	e8 3b fe ff ff       	call   1045 <matchplus>
    120a:	83 c4 20             	add    $0x20,%esp
    120d:	eb 7c                	jmp    128b <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    120f:	8b 45 08             	mov    0x8(%ebp),%eax
    1212:	0f b6 00             	movzbl (%eax),%eax
    1215:	3c 03                	cmp    $0x3,%al
    1217:	75 1d                	jne    1236 <matchpattern+0xd2>
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	83 c0 08             	add    $0x8,%eax
    121f:	0f b6 00             	movzbl (%eax),%eax
    1222:	84 c0                	test   %al,%al
    1224:	75 10                	jne    1236 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1226:	8b 45 0c             	mov    0xc(%ebp),%eax
    1229:	0f b6 00             	movzbl (%eax),%eax
    122c:	84 c0                	test   %al,%al
    122e:	0f 94 c0             	sete   %al
    1231:	0f b6 c0             	movzbl %al,%eax
    1234:	eb 55                	jmp    128b <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1236:	8b 45 10             	mov    0x10(%ebp),%eax
    1239:	8b 00                	mov    (%eax),%eax
    123b:	8d 50 01             	lea    0x1(%eax),%edx
    123e:	8b 45 10             	mov    0x10(%ebp),%eax
    1241:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1243:	8b 45 0c             	mov    0xc(%ebp),%eax
    1246:	0f b6 00             	movzbl (%eax),%eax
    1249:	84 c0                	test   %al,%al
    124b:	74 31                	je     127e <matchpattern+0x11a>
    124d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1250:	8d 50 01             	lea    0x1(%eax),%edx
    1253:	89 55 0c             	mov    %edx,0xc(%ebp)
    1256:	0f b6 00             	movzbl (%eax),%eax
    1259:	0f be d0             	movsbl %al,%edx
    125c:	8b 45 08             	mov    0x8(%ebp),%eax
    125f:	8d 48 08             	lea    0x8(%eax),%ecx
    1262:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1265:	83 ec 04             	sub    $0x4,%esp
    1268:	52                   	push   %edx
    1269:	ff 70 04             	pushl  0x4(%eax)
    126c:	ff 30                	pushl  (%eax)
    126e:	e8 4f fc ff ff       	call   ec2 <matchone>
    1273:	83 c4 10             	add    $0x10,%esp
    1276:	85 c0                	test   %eax,%eax
    1278:	0f 85 f4 fe ff ff    	jne    1172 <matchpattern+0xe>

  *matchlength = pre;
    127e:	8b 45 10             	mov    0x10(%ebp),%eax
    1281:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1284:	89 10                	mov    %edx,(%eax)
  return 0;
    1286:	b8 00 00 00 00       	mov    $0x0,%eax
}
    128b:	c9                   	leave  
    128c:	c3                   	ret    
