
_re_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "re.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(){
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
    int match_length;
	const char *string_to_search="  int  iiint";
      11:	c7 45 f4 80 12 00 00 	movl   $0x1280,-0xc(%ebp)
	re_t pattern = re_compile("\\W\\Dint\\W\\D");
      18:	83 ec 0c             	sub    $0xc,%esp
      1b:	68 8d 12 00 00       	push   $0x128d
      20:	e8 e4 08 00 00       	call   909 <re_compile>
      25:	83 c4 10             	add    $0x10,%esp
      28:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int match_idx = re_matchp(pattern, string_to_search, &match_length);
      2b:	83 ec 04             	sub    $0x4,%esp
      2e:	8d 45 e8             	lea    -0x18(%ebp),%eax
      31:	50                   	push   %eax
      32:	ff 75 f4             	pushl  -0xc(%ebp)
      35:	ff 75 f0             	pushl  -0x10(%ebp)
      38:	e8 33 08 00 00       	call   870 <re_matchp>
      3d:	83 c4 10             	add    $0x10,%esp
      40:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if(match_idx !=-1){
      43:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
      47:	74 16                	je     5f <main+0x5f>
		printf(1,"match at idx %d, %d chars long.\n", match_idx,match_length);
      49:	8b 45 e8             	mov    -0x18(%ebp),%eax
      4c:	50                   	push   %eax
      4d:	ff 75 ec             	pushl  -0x14(%ebp)
      50:	68 9c 12 00 00       	push   $0x129c
      55:	6a 01                	push   $0x1
      57:	e8 36 04 00 00       	call   492 <printf>
      5c:	83 c4 10             	add    $0x10,%esp
	}
	exit();
      5f:	e8 57 02 00 00       	call   2bb <exit>

00000064 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      64:	55                   	push   %ebp
      65:	89 e5                	mov    %esp,%ebp
      67:	57                   	push   %edi
      68:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      69:	8b 4d 08             	mov    0x8(%ebp),%ecx
      6c:	8b 55 10             	mov    0x10(%ebp),%edx
      6f:	8b 45 0c             	mov    0xc(%ebp),%eax
      72:	89 cb                	mov    %ecx,%ebx
      74:	89 df                	mov    %ebx,%edi
      76:	89 d1                	mov    %edx,%ecx
      78:	fc                   	cld    
      79:	f3 aa                	rep stos %al,%es:(%edi)
      7b:	89 ca                	mov    %ecx,%edx
      7d:	89 fb                	mov    %edi,%ebx
      7f:	89 5d 08             	mov    %ebx,0x8(%ebp)
      82:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      85:	90                   	nop
      86:	5b                   	pop    %ebx
      87:	5f                   	pop    %edi
      88:	5d                   	pop    %ebp
      89:	c3                   	ret    

0000008a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      8a:	55                   	push   %ebp
      8b:	89 e5                	mov    %esp,%ebp
      8d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      90:	8b 45 08             	mov    0x8(%ebp),%eax
      93:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      96:	90                   	nop
      97:	8b 45 08             	mov    0x8(%ebp),%eax
      9a:	8d 50 01             	lea    0x1(%eax),%edx
      9d:	89 55 08             	mov    %edx,0x8(%ebp)
      a0:	8b 55 0c             	mov    0xc(%ebp),%edx
      a3:	8d 4a 01             	lea    0x1(%edx),%ecx
      a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      a9:	0f b6 12             	movzbl (%edx),%edx
      ac:	88 10                	mov    %dl,(%eax)
      ae:	0f b6 00             	movzbl (%eax),%eax
      b1:	84 c0                	test   %al,%al
      b3:	75 e2                	jne    97 <strcpy+0xd>
    ;
  return os;
      b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      b8:	c9                   	leave  
      b9:	c3                   	ret    

000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
      ba:	55                   	push   %ebp
      bb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      bd:	eb 08                	jmp    c7 <strcmp+0xd>
    p++, q++;
      bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      c7:	8b 45 08             	mov    0x8(%ebp),%eax
      ca:	0f b6 00             	movzbl (%eax),%eax
      cd:	84 c0                	test   %al,%al
      cf:	74 10                	je     e1 <strcmp+0x27>
      d1:	8b 45 08             	mov    0x8(%ebp),%eax
      d4:	0f b6 10             	movzbl (%eax),%edx
      d7:	8b 45 0c             	mov    0xc(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	38 c2                	cmp    %al,%dl
      df:	74 de                	je     bf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      e1:	8b 45 08             	mov    0x8(%ebp),%eax
      e4:	0f b6 00             	movzbl (%eax),%eax
      e7:	0f b6 d0             	movzbl %al,%edx
      ea:	8b 45 0c             	mov    0xc(%ebp),%eax
      ed:	0f b6 00             	movzbl (%eax),%eax
      f0:	0f b6 c0             	movzbl %al,%eax
      f3:	29 c2                	sub    %eax,%edx
      f5:	89 d0                	mov    %edx,%eax
}
      f7:	5d                   	pop    %ebp
      f8:	c3                   	ret    

000000f9 <strlen>:

uint
strlen(char *s)
{
      f9:	55                   	push   %ebp
      fa:	89 e5                	mov    %esp,%ebp
      fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     106:	eb 04                	jmp    10c <strlen+0x13>
     108:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     10c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     10f:	8b 45 08             	mov    0x8(%ebp),%eax
     112:	01 d0                	add    %edx,%eax
     114:	0f b6 00             	movzbl (%eax),%eax
     117:	84 c0                	test   %al,%al
     119:	75 ed                	jne    108 <strlen+0xf>
    ;
  return n;
     11b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     11e:	c9                   	leave  
     11f:	c3                   	ret    

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     123:	8b 45 10             	mov    0x10(%ebp),%eax
     126:	50                   	push   %eax
     127:	ff 75 0c             	pushl  0xc(%ebp)
     12a:	ff 75 08             	pushl  0x8(%ebp)
     12d:	e8 32 ff ff ff       	call   64 <stosb>
     132:	83 c4 0c             	add    $0xc,%esp
  return dst;
     135:	8b 45 08             	mov    0x8(%ebp),%eax
}
     138:	c9                   	leave  
     139:	c3                   	ret    

0000013a <strchr>:

char*
strchr(const char *s, char c)
{
     13a:	55                   	push   %ebp
     13b:	89 e5                	mov    %esp,%ebp
     13d:	83 ec 04             	sub    $0x4,%esp
     140:	8b 45 0c             	mov    0xc(%ebp),%eax
     143:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     146:	eb 14                	jmp    15c <strchr+0x22>
    if(*s == c)
     148:	8b 45 08             	mov    0x8(%ebp),%eax
     14b:	0f b6 00             	movzbl (%eax),%eax
     14e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     151:	75 05                	jne    158 <strchr+0x1e>
      return (char*)s;
     153:	8b 45 08             	mov    0x8(%ebp),%eax
     156:	eb 13                	jmp    16b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     158:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     15c:	8b 45 08             	mov    0x8(%ebp),%eax
     15f:	0f b6 00             	movzbl (%eax),%eax
     162:	84 c0                	test   %al,%al
     164:	75 e2                	jne    148 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     166:	b8 00 00 00 00       	mov    $0x0,%eax
}
     16b:	c9                   	leave  
     16c:	c3                   	ret    

0000016d <gets>:

char*
gets(char *buf, int max)
{
     16d:	55                   	push   %ebp
     16e:	89 e5                	mov    %esp,%ebp
     170:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     173:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     17a:	eb 42                	jmp    1be <gets+0x51>
    cc = read(0, &c, 1);
     17c:	83 ec 04             	sub    $0x4,%esp
     17f:	6a 01                	push   $0x1
     181:	8d 45 ef             	lea    -0x11(%ebp),%eax
     184:	50                   	push   %eax
     185:	6a 00                	push   $0x0
     187:	e8 47 01 00 00       	call   2d3 <read>
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     192:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     196:	7e 33                	jle    1cb <gets+0x5e>
      break;
    buf[i++] = c;
     198:	8b 45 f4             	mov    -0xc(%ebp),%eax
     19b:	8d 50 01             	lea    0x1(%eax),%edx
     19e:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1a1:	89 c2                	mov    %eax,%edx
     1a3:	8b 45 08             	mov    0x8(%ebp),%eax
     1a6:	01 c2                	add    %eax,%edx
     1a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ac:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1ae:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1b2:	3c 0a                	cmp    $0xa,%al
     1b4:	74 16                	je     1cc <gets+0x5f>
     1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ba:	3c 0d                	cmp    $0xd,%al
     1bc:	74 0e                	je     1cc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c1:	83 c0 01             	add    $0x1,%eax
     1c4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1c7:	7c b3                	jl     17c <gets+0xf>
     1c9:	eb 01                	jmp    1cc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1cb:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
     1d2:	01 d0                	add    %edx,%eax
     1d4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1da:	c9                   	leave  
     1db:	c3                   	ret    

000001dc <stat>:

int
stat(char *n, struct stat *st)
{
     1dc:	55                   	push   %ebp
     1dd:	89 e5                	mov    %esp,%ebp
     1df:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1e2:	83 ec 08             	sub    $0x8,%esp
     1e5:	6a 00                	push   $0x0
     1e7:	ff 75 08             	pushl  0x8(%ebp)
     1ea:	e8 0c 01 00 00       	call   2fb <open>
     1ef:	83 c4 10             	add    $0x10,%esp
     1f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1f9:	79 07                	jns    202 <stat+0x26>
    return -1;
     1fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     200:	eb 25                	jmp    227 <stat+0x4b>
  r = fstat(fd, st);
     202:	83 ec 08             	sub    $0x8,%esp
     205:	ff 75 0c             	pushl  0xc(%ebp)
     208:	ff 75 f4             	pushl  -0xc(%ebp)
     20b:	e8 03 01 00 00       	call   313 <fstat>
     210:	83 c4 10             	add    $0x10,%esp
     213:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     216:	83 ec 0c             	sub    $0xc,%esp
     219:	ff 75 f4             	pushl  -0xc(%ebp)
     21c:	e8 c2 00 00 00       	call   2e3 <close>
     221:	83 c4 10             	add    $0x10,%esp
  return r;
     224:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     227:	c9                   	leave  
     228:	c3                   	ret    

00000229 <atoi>:

int
atoi(const char *s)
{
     229:	55                   	push   %ebp
     22a:	89 e5                	mov    %esp,%ebp
     22c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     22f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     236:	eb 25                	jmp    25d <atoi+0x34>
    n = n*10 + *s++ - '0';
     238:	8b 55 fc             	mov    -0x4(%ebp),%edx
     23b:	89 d0                	mov    %edx,%eax
     23d:	c1 e0 02             	shl    $0x2,%eax
     240:	01 d0                	add    %edx,%eax
     242:	01 c0                	add    %eax,%eax
     244:	89 c1                	mov    %eax,%ecx
     246:	8b 45 08             	mov    0x8(%ebp),%eax
     249:	8d 50 01             	lea    0x1(%eax),%edx
     24c:	89 55 08             	mov    %edx,0x8(%ebp)
     24f:	0f b6 00             	movzbl (%eax),%eax
     252:	0f be c0             	movsbl %al,%eax
     255:	01 c8                	add    %ecx,%eax
     257:	83 e8 30             	sub    $0x30,%eax
     25a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     25d:	8b 45 08             	mov    0x8(%ebp),%eax
     260:	0f b6 00             	movzbl (%eax),%eax
     263:	3c 2f                	cmp    $0x2f,%al
     265:	7e 0a                	jle    271 <atoi+0x48>
     267:	8b 45 08             	mov    0x8(%ebp),%eax
     26a:	0f b6 00             	movzbl (%eax),%eax
     26d:	3c 39                	cmp    $0x39,%al
     26f:	7e c7                	jle    238 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     271:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     274:	c9                   	leave  
     275:	c3                   	ret    

00000276 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     276:	55                   	push   %ebp
     277:	89 e5                	mov    %esp,%ebp
     279:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     27c:	8b 45 08             	mov    0x8(%ebp),%eax
     27f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     282:	8b 45 0c             	mov    0xc(%ebp),%eax
     285:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     288:	eb 17                	jmp    2a1 <memmove+0x2b>
    *dst++ = *src++;
     28a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     28d:	8d 50 01             	lea    0x1(%eax),%edx
     290:	89 55 fc             	mov    %edx,-0x4(%ebp)
     293:	8b 55 f8             	mov    -0x8(%ebp),%edx
     296:	8d 4a 01             	lea    0x1(%edx),%ecx
     299:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     29c:	0f b6 12             	movzbl (%edx),%edx
     29f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2a1:	8b 45 10             	mov    0x10(%ebp),%eax
     2a4:	8d 50 ff             	lea    -0x1(%eax),%edx
     2a7:	89 55 10             	mov    %edx,0x10(%ebp)
     2aa:	85 c0                	test   %eax,%eax
     2ac:	7f dc                	jg     28a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2b1:	c9                   	leave  
     2b2:	c3                   	ret    

000002b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2b3:	b8 01 00 00 00       	mov    $0x1,%eax
     2b8:	cd 40                	int    $0x40
     2ba:	c3                   	ret    

000002bb <exit>:
SYSCALL(exit)
     2bb:	b8 02 00 00 00       	mov    $0x2,%eax
     2c0:	cd 40                	int    $0x40
     2c2:	c3                   	ret    

000002c3 <wait>:
SYSCALL(wait)
     2c3:	b8 03 00 00 00       	mov    $0x3,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <pipe>:
SYSCALL(pipe)
     2cb:	b8 04 00 00 00       	mov    $0x4,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <read>:
SYSCALL(read)
     2d3:	b8 05 00 00 00       	mov    $0x5,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <write>:
SYSCALL(write)
     2db:	b8 10 00 00 00       	mov    $0x10,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <close>:
SYSCALL(close)
     2e3:	b8 15 00 00 00       	mov    $0x15,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <kill>:
SYSCALL(kill)
     2eb:	b8 06 00 00 00       	mov    $0x6,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <exec>:
SYSCALL(exec)
     2f3:	b8 07 00 00 00       	mov    $0x7,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <open>:
SYSCALL(open)
     2fb:	b8 0f 00 00 00       	mov    $0xf,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <mknod>:
SYSCALL(mknod)
     303:	b8 11 00 00 00       	mov    $0x11,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <unlink>:
SYSCALL(unlink)
     30b:	b8 12 00 00 00       	mov    $0x12,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <fstat>:
SYSCALL(fstat)
     313:	b8 08 00 00 00       	mov    $0x8,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <link>:
SYSCALL(link)
     31b:	b8 13 00 00 00       	mov    $0x13,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <mkdir>:
SYSCALL(mkdir)
     323:	b8 14 00 00 00       	mov    $0x14,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <chdir>:
SYSCALL(chdir)
     32b:	b8 09 00 00 00       	mov    $0x9,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <dup>:
SYSCALL(dup)
     333:	b8 0a 00 00 00       	mov    $0xa,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <getpid>:
SYSCALL(getpid)
     33b:	b8 0b 00 00 00       	mov    $0xb,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <sbrk>:
SYSCALL(sbrk)
     343:	b8 0c 00 00 00       	mov    $0xc,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <sleep>:
SYSCALL(sleep)
     34b:	b8 0d 00 00 00       	mov    $0xd,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <uptime>:
SYSCALL(uptime)
     353:	b8 0e 00 00 00       	mov    $0xe,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <setCursorPos>:


//add
SYSCALL(setCursorPos)
     35b:	b8 16 00 00 00       	mov    $0x16,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     363:	b8 17 00 00 00       	mov    $0x17,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <clearScreen>:
SYSCALL(clearScreen)
     36b:	b8 18 00 00 00       	mov    $0x18,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <writeAt>:
SYSCALL(writeAt)
     373:	b8 19 00 00 00       	mov    $0x19,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <setBufferFlag>:
SYSCALL(setBufferFlag)
     37b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     383:	b8 1b 00 00 00       	mov    $0x1b,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <getCursorPos>:
SYSCALL(getCursorPos)
     38b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <saveScreen>:
SYSCALL(saveScreen)
     393:	b8 1d 00 00 00       	mov    $0x1d,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <recorverScreen>:
SYSCALL(recorverScreen)
     39b:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3a0:	cd 40                	int    $0x40
     3a2:	c3                   	ret    

000003a3 <ToScreen>:
SYSCALL(ToScreen)
     3a3:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3a8:	cd 40                	int    $0x40
     3aa:	c3                   	ret    

000003ab <getColor>:
SYSCALL(getColor)
     3ab:	b8 20 00 00 00       	mov    $0x20,%eax
     3b0:	cd 40                	int    $0x40
     3b2:	c3                   	ret    

000003b3 <showC>:
SYSCALL(showC)
     3b3:	b8 21 00 00 00       	mov    $0x21,%eax
     3b8:	cd 40                	int    $0x40
     3ba:	c3                   	ret    

000003bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3bb:	55                   	push   %ebp
     3bc:	89 e5                	mov    %esp,%ebp
     3be:	83 ec 18             	sub    $0x18,%esp
     3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3c7:	83 ec 04             	sub    $0x4,%esp
     3ca:	6a 01                	push   $0x1
     3cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3cf:	50                   	push   %eax
     3d0:	ff 75 08             	pushl  0x8(%ebp)
     3d3:	e8 03 ff ff ff       	call   2db <write>
     3d8:	83 c4 10             	add    $0x10,%esp
}
     3db:	90                   	nop
     3dc:	c9                   	leave  
     3dd:	c3                   	ret    

000003de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3de:	55                   	push   %ebp
     3df:	89 e5                	mov    %esp,%ebp
     3e1:	53                   	push   %ebx
     3e2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3ec:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3f0:	74 17                	je     409 <printint+0x2b>
     3f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3f6:	79 11                	jns    409 <printint+0x2b>
    neg = 1;
     3f8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     402:	f7 d8                	neg    %eax
     404:	89 45 ec             	mov    %eax,-0x14(%ebp)
     407:	eb 06                	jmp    40f <printint+0x31>
  } else {
    x = xx;
     409:	8b 45 0c             	mov    0xc(%ebp),%eax
     40c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     40f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     416:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     419:	8d 41 01             	lea    0x1(%ecx),%eax
     41c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     41f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     422:	8b 45 ec             	mov    -0x14(%ebp),%eax
     425:	ba 00 00 00 00       	mov    $0x0,%edx
     42a:	f7 f3                	div    %ebx
     42c:	89 d0                	mov    %edx,%eax
     42e:	0f b6 80 d8 19 00 00 	movzbl 0x19d8(%eax),%eax
     435:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     439:	8b 5d 10             	mov    0x10(%ebp),%ebx
     43c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     43f:	ba 00 00 00 00       	mov    $0x0,%edx
     444:	f7 f3                	div    %ebx
     446:	89 45 ec             	mov    %eax,-0x14(%ebp)
     449:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     44d:	75 c7                	jne    416 <printint+0x38>
  if(neg)
     44f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     453:	74 2d                	je     482 <printint+0xa4>
    buf[i++] = '-';
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8d 50 01             	lea    0x1(%eax),%edx
     45b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     45e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     463:	eb 1d                	jmp    482 <printint+0xa4>
    putc(fd, buf[i]);
     465:	8d 55 dc             	lea    -0x24(%ebp),%edx
     468:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46b:	01 d0                	add    %edx,%eax
     46d:	0f b6 00             	movzbl (%eax),%eax
     470:	0f be c0             	movsbl %al,%eax
     473:	83 ec 08             	sub    $0x8,%esp
     476:	50                   	push   %eax
     477:	ff 75 08             	pushl  0x8(%ebp)
     47a:	e8 3c ff ff ff       	call   3bb <putc>
     47f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     482:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     486:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     48a:	79 d9                	jns    465 <printint+0x87>
    putc(fd, buf[i]);
}
     48c:	90                   	nop
     48d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     490:	c9                   	leave  
     491:	c3                   	ret    

00000492 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     492:	55                   	push   %ebp
     493:	89 e5                	mov    %esp,%ebp
     495:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     498:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     49f:	8d 45 0c             	lea    0xc(%ebp),%eax
     4a2:	83 c0 04             	add    $0x4,%eax
     4a5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4af:	e9 59 01 00 00       	jmp    60d <printf+0x17b>
    c = fmt[i] & 0xff;
     4b4:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4ba:	01 d0                	add    %edx,%eax
     4bc:	0f b6 00             	movzbl (%eax),%eax
     4bf:	0f be c0             	movsbl %al,%eax
     4c2:	25 ff 00 00 00       	and    $0xff,%eax
     4c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ce:	75 2c                	jne    4fc <printf+0x6a>
      if(c == '%'){
     4d0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d4:	75 0c                	jne    4e2 <printf+0x50>
        state = '%';
     4d6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4dd:	e9 27 01 00 00       	jmp    609 <printf+0x177>
      } else {
        putc(fd, c);
     4e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e5:	0f be c0             	movsbl %al,%eax
     4e8:	83 ec 08             	sub    $0x8,%esp
     4eb:	50                   	push   %eax
     4ec:	ff 75 08             	pushl  0x8(%ebp)
     4ef:	e8 c7 fe ff ff       	call   3bb <putc>
     4f4:	83 c4 10             	add    $0x10,%esp
     4f7:	e9 0d 01 00 00       	jmp    609 <printf+0x177>
      }
    } else if(state == '%'){
     4fc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     500:	0f 85 03 01 00 00    	jne    609 <printf+0x177>
      if(c == 'd'){
     506:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     50a:	75 1e                	jne    52a <printf+0x98>
        printint(fd, *ap, 10, 1);
     50c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50f:	8b 00                	mov    (%eax),%eax
     511:	6a 01                	push   $0x1
     513:	6a 0a                	push   $0xa
     515:	50                   	push   %eax
     516:	ff 75 08             	pushl  0x8(%ebp)
     519:	e8 c0 fe ff ff       	call   3de <printint>
     51e:	83 c4 10             	add    $0x10,%esp
        ap++;
     521:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     525:	e9 d8 00 00 00       	jmp    602 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     52a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     52e:	74 06                	je     536 <printf+0xa4>
     530:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     534:	75 1e                	jne    554 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     536:	8b 45 e8             	mov    -0x18(%ebp),%eax
     539:	8b 00                	mov    (%eax),%eax
     53b:	6a 00                	push   $0x0
     53d:	6a 10                	push   $0x10
     53f:	50                   	push   %eax
     540:	ff 75 08             	pushl  0x8(%ebp)
     543:	e8 96 fe ff ff       	call   3de <printint>
     548:	83 c4 10             	add    $0x10,%esp
        ap++;
     54b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     54f:	e9 ae 00 00 00       	jmp    602 <printf+0x170>
      } else if(c == 's'){
     554:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     558:	75 43                	jne    59d <printf+0x10b>
        s = (char*)*ap;
     55a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     55d:	8b 00                	mov    (%eax),%eax
     55f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     562:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     566:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     56a:	75 25                	jne    591 <printf+0xff>
          s = "(null)";
     56c:	c7 45 f4 bd 12 00 00 	movl   $0x12bd,-0xc(%ebp)
        while(*s != 0){
     573:	eb 1c                	jmp    591 <printf+0xff>
          putc(fd, *s);
     575:	8b 45 f4             	mov    -0xc(%ebp),%eax
     578:	0f b6 00             	movzbl (%eax),%eax
     57b:	0f be c0             	movsbl %al,%eax
     57e:	83 ec 08             	sub    $0x8,%esp
     581:	50                   	push   %eax
     582:	ff 75 08             	pushl  0x8(%ebp)
     585:	e8 31 fe ff ff       	call   3bb <putc>
     58a:	83 c4 10             	add    $0x10,%esp
          s++;
     58d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     591:	8b 45 f4             	mov    -0xc(%ebp),%eax
     594:	0f b6 00             	movzbl (%eax),%eax
     597:	84 c0                	test   %al,%al
     599:	75 da                	jne    575 <printf+0xe3>
     59b:	eb 65                	jmp    602 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     59d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5a1:	75 1d                	jne    5c0 <printf+0x12e>
        putc(fd, *ap);
     5a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a6:	8b 00                	mov    (%eax),%eax
     5a8:	0f be c0             	movsbl %al,%eax
     5ab:	83 ec 08             	sub    $0x8,%esp
     5ae:	50                   	push   %eax
     5af:	ff 75 08             	pushl  0x8(%ebp)
     5b2:	e8 04 fe ff ff       	call   3bb <putc>
     5b7:	83 c4 10             	add    $0x10,%esp
        ap++;
     5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5be:	eb 42                	jmp    602 <printf+0x170>
      } else if(c == '%'){
     5c0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c4:	75 17                	jne    5dd <printf+0x14b>
        putc(fd, c);
     5c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c9:	0f be c0             	movsbl %al,%eax
     5cc:	83 ec 08             	sub    $0x8,%esp
     5cf:	50                   	push   %eax
     5d0:	ff 75 08             	pushl  0x8(%ebp)
     5d3:	e8 e3 fd ff ff       	call   3bb <putc>
     5d8:	83 c4 10             	add    $0x10,%esp
     5db:	eb 25                	jmp    602 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5dd:	83 ec 08             	sub    $0x8,%esp
     5e0:	6a 25                	push   $0x25
     5e2:	ff 75 08             	pushl  0x8(%ebp)
     5e5:	e8 d1 fd ff ff       	call   3bb <putc>
     5ea:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5f0:	0f be c0             	movsbl %al,%eax
     5f3:	83 ec 08             	sub    $0x8,%esp
     5f6:	50                   	push   %eax
     5f7:	ff 75 08             	pushl  0x8(%ebp)
     5fa:	e8 bc fd ff ff       	call   3bb <putc>
     5ff:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     602:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     609:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     60d:	8b 55 0c             	mov    0xc(%ebp),%edx
     610:	8b 45 f0             	mov    -0x10(%ebp),%eax
     613:	01 d0                	add    %edx,%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	84 c0                	test   %al,%al
     61a:	0f 85 94 fe ff ff    	jne    4b4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     620:	90                   	nop
     621:	c9                   	leave  
     622:	c3                   	ret    

00000623 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     623:	55                   	push   %ebp
     624:	89 e5                	mov    %esp,%ebp
     626:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     629:	8b 45 08             	mov    0x8(%ebp),%eax
     62c:	83 e8 08             	sub    $0x8,%eax
     62f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     632:	a1 08 1a 00 00       	mov    0x1a08,%eax
     637:	89 45 fc             	mov    %eax,-0x4(%ebp)
     63a:	eb 24                	jmp    660 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63f:	8b 00                	mov    (%eax),%eax
     641:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     644:	77 12                	ja     658 <free+0x35>
     646:	8b 45 f8             	mov    -0x8(%ebp),%eax
     649:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64c:	77 24                	ja     672 <free+0x4f>
     64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     651:	8b 00                	mov    (%eax),%eax
     653:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     656:	77 1a                	ja     672 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     658:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65b:	8b 00                	mov    (%eax),%eax
     65d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     660:	8b 45 f8             	mov    -0x8(%ebp),%eax
     663:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     666:	76 d4                	jbe    63c <free+0x19>
     668:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66b:	8b 00                	mov    (%eax),%eax
     66d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     670:	76 ca                	jbe    63c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     672:	8b 45 f8             	mov    -0x8(%ebp),%eax
     675:	8b 40 04             	mov    0x4(%eax),%eax
     678:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     682:	01 c2                	add    %eax,%edx
     684:	8b 45 fc             	mov    -0x4(%ebp),%eax
     687:	8b 00                	mov    (%eax),%eax
     689:	39 c2                	cmp    %eax,%edx
     68b:	75 24                	jne    6b1 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     690:	8b 50 04             	mov    0x4(%eax),%edx
     693:	8b 45 fc             	mov    -0x4(%ebp),%eax
     696:	8b 00                	mov    (%eax),%eax
     698:	8b 40 04             	mov    0x4(%eax),%eax
     69b:	01 c2                	add    %eax,%edx
     69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a6:	8b 00                	mov    (%eax),%eax
     6a8:	8b 10                	mov    (%eax),%edx
     6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ad:	89 10                	mov    %edx,(%eax)
     6af:	eb 0a                	jmp    6bb <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	8b 10                	mov    (%eax),%edx
     6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 40 04             	mov    0x4(%eax),%eax
     6c1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cb:	01 d0                	add    %edx,%eax
     6cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d0:	75 20                	jne    6f2 <free+0xcf>
    p->s.size += bp->s.size;
     6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d5:	8b 50 04             	mov    0x4(%eax),%edx
     6d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6db:	8b 40 04             	mov    0x4(%eax),%eax
     6de:	01 c2                	add    %eax,%edx
     6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e9:	8b 10                	mov    (%eax),%edx
     6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ee:	89 10                	mov    %edx,(%eax)
     6f0:	eb 08                	jmp    6fa <free+0xd7>
  } else
    p->s.ptr = bp;
     6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f8:	89 10                	mov    %edx,(%eax)
  freep = p;
     6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fd:	a3 08 1a 00 00       	mov    %eax,0x1a08
}
     702:	90                   	nop
     703:	c9                   	leave  
     704:	c3                   	ret    

00000705 <morecore>:

static Header*
morecore(uint nu)
{
     705:	55                   	push   %ebp
     706:	89 e5                	mov    %esp,%ebp
     708:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     70b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     712:	77 07                	ja     71b <morecore+0x16>
    nu = 4096;
     714:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     71b:	8b 45 08             	mov    0x8(%ebp),%eax
     71e:	c1 e0 03             	shl    $0x3,%eax
     721:	83 ec 0c             	sub    $0xc,%esp
     724:	50                   	push   %eax
     725:	e8 19 fc ff ff       	call   343 <sbrk>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     730:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     734:	75 07                	jne    73d <morecore+0x38>
    return 0;
     736:	b8 00 00 00 00       	mov    $0x0,%eax
     73b:	eb 26                	jmp    763 <morecore+0x5e>
  hp = (Header*)p;
     73d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     740:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     743:	8b 45 f0             	mov    -0x10(%ebp),%eax
     746:	8b 55 08             	mov    0x8(%ebp),%edx
     749:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     74c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     74f:	83 c0 08             	add    $0x8,%eax
     752:	83 ec 0c             	sub    $0xc,%esp
     755:	50                   	push   %eax
     756:	e8 c8 fe ff ff       	call   623 <free>
     75b:	83 c4 10             	add    $0x10,%esp
  return freep;
     75e:	a1 08 1a 00 00       	mov    0x1a08,%eax
}
     763:	c9                   	leave  
     764:	c3                   	ret    

00000765 <malloc>:

void*
malloc(uint nbytes)
{
     765:	55                   	push   %ebp
     766:	89 e5                	mov    %esp,%ebp
     768:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     76b:	8b 45 08             	mov    0x8(%ebp),%eax
     76e:	83 c0 07             	add    $0x7,%eax
     771:	c1 e8 03             	shr    $0x3,%eax
     774:	83 c0 01             	add    $0x1,%eax
     777:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     77a:	a1 08 1a 00 00       	mov    0x1a08,%eax
     77f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     782:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     786:	75 23                	jne    7ab <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     788:	c7 45 f0 00 1a 00 00 	movl   $0x1a00,-0x10(%ebp)
     78f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     792:	a3 08 1a 00 00       	mov    %eax,0x1a08
     797:	a1 08 1a 00 00       	mov    0x1a08,%eax
     79c:	a3 00 1a 00 00       	mov    %eax,0x1a00
    base.s.size = 0;
     7a1:	c7 05 04 1a 00 00 00 	movl   $0x0,0x1a04
     7a8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ae:	8b 00                	mov    (%eax),%eax
     7b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b6:	8b 40 04             	mov    0x4(%eax),%eax
     7b9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7bc:	72 4d                	jb     80b <malloc+0xa6>
      if(p->s.size == nunits)
     7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c1:	8b 40 04             	mov    0x4(%eax),%eax
     7c4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7c7:	75 0c                	jne    7d5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cc:	8b 10                	mov    (%eax),%edx
     7ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d1:	89 10                	mov    %edx,(%eax)
     7d3:	eb 26                	jmp    7fb <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d8:	8b 40 04             	mov    0x4(%eax),%eax
     7db:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7de:	89 c2                	mov    %eax,%edx
     7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e9:	8b 40 04             	mov    0x4(%eax),%eax
     7ec:	c1 e0 03             	shl    $0x3,%eax
     7ef:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fe:	a3 08 1a 00 00       	mov    %eax,0x1a08
      return (void*)(p + 1);
     803:	8b 45 f4             	mov    -0xc(%ebp),%eax
     806:	83 c0 08             	add    $0x8,%eax
     809:	eb 3b                	jmp    846 <malloc+0xe1>
    }
    if(p == freep)
     80b:	a1 08 1a 00 00       	mov    0x1a08,%eax
     810:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     813:	75 1e                	jne    833 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     815:	83 ec 0c             	sub    $0xc,%esp
     818:	ff 75 ec             	pushl  -0x14(%ebp)
     81b:	e8 e5 fe ff ff       	call   705 <morecore>
     820:	83 c4 10             	add    $0x10,%esp
     823:	89 45 f4             	mov    %eax,-0xc(%ebp)
     826:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     82a:	75 07                	jne    833 <malloc+0xce>
        return 0;
     82c:	b8 00 00 00 00       	mov    $0x0,%eax
     831:	eb 13                	jmp    846 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     833:	8b 45 f4             	mov    -0xc(%ebp),%eax
     836:	89 45 f0             	mov    %eax,-0x10(%ebp)
     839:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83c:	8b 00                	mov    (%eax),%eax
     83e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     841:	e9 6d ff ff ff       	jmp    7b3 <malloc+0x4e>
}
     846:	c9                   	leave  
     847:	c3                   	ret    

00000848 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     848:	55                   	push   %ebp
     849:	89 e5                	mov    %esp,%ebp
     84b:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     84e:	83 ec 0c             	sub    $0xc,%esp
     851:	ff 75 08             	pushl  0x8(%ebp)
     854:	e8 b0 00 00 00       	call   909 <re_compile>
     859:	83 c4 10             	add    $0x10,%esp
     85c:	83 ec 04             	sub    $0x4,%esp
     85f:	ff 75 10             	pushl  0x10(%ebp)
     862:	ff 75 0c             	pushl  0xc(%ebp)
     865:	50                   	push   %eax
     866:	e8 05 00 00 00       	call   870 <re_matchp>
     86b:	83 c4 10             	add    $0x10,%esp
}
     86e:	c9                   	leave  
     86f:	c3                   	ret    

00000870 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     876:	8b 45 10             	mov    0x10(%ebp),%eax
     879:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     87f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     883:	74 7d                	je     902 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     885:	8b 45 08             	mov    0x8(%ebp),%eax
     888:	0f b6 00             	movzbl (%eax),%eax
     88b:	3c 02                	cmp    $0x2,%al
     88d:	75 2a                	jne    8b9 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     88f:	8b 45 08             	mov    0x8(%ebp),%eax
     892:	83 c0 08             	add    $0x8,%eax
     895:	83 ec 04             	sub    $0x4,%esp
     898:	ff 75 10             	pushl  0x10(%ebp)
     89b:	ff 75 0c             	pushl  0xc(%ebp)
     89e:	50                   	push   %eax
     89f:	e8 b0 08 00 00       	call   1154 <matchpattern>
     8a4:	83 c4 10             	add    $0x10,%esp
     8a7:	85 c0                	test   %eax,%eax
     8a9:	74 07                	je     8b2 <re_matchp+0x42>
     8ab:	b8 00 00 00 00       	mov    $0x0,%eax
     8b0:	eb 55                	jmp    907 <re_matchp+0x97>
     8b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8b7:	eb 4e                	jmp    907 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     8b9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     8c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     8c4:	83 ec 04             	sub    $0x4,%esp
     8c7:	ff 75 10             	pushl  0x10(%ebp)
     8ca:	ff 75 0c             	pushl  0xc(%ebp)
     8cd:	ff 75 08             	pushl  0x8(%ebp)
     8d0:	e8 7f 08 00 00       	call   1154 <matchpattern>
     8d5:	83 c4 10             	add    $0x10,%esp
     8d8:	85 c0                	test   %eax,%eax
     8da:	74 16                	je     8f2 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     8dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     8df:	0f b6 00             	movzbl (%eax),%eax
     8e2:	84 c0                	test   %al,%al
     8e4:	75 07                	jne    8ed <re_matchp+0x7d>
            return -1;
     8e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8eb:	eb 1a                	jmp    907 <re_matchp+0x97>
        
          return idx;
     8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f0:	eb 15                	jmp    907 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     8f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f5:	8d 50 01             	lea    0x1(%eax),%edx
     8f8:	89 55 0c             	mov    %edx,0xc(%ebp)
     8fb:	0f b6 00             	movzbl (%eax),%eax
     8fe:	84 c0                	test   %al,%al
     900:	75 be                	jne    8c0 <re_matchp+0x50>
    }
  }
  return -1;
     902:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     907:	c9                   	leave  
     908:	c3                   	ret    

00000909 <re_compile>:

re_t re_compile(const char* pattern)
{
     909:	55                   	push   %ebp
     90a:	89 e5                	mov    %esp,%ebp
     90c:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     90f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     916:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     91d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     924:	e9 55 02 00 00       	jmp    b7e <re_compile+0x275>
  {
    c = pattern[i];
     929:	8b 55 f8             	mov    -0x8(%ebp),%edx
     92c:	8b 45 08             	mov    0x8(%ebp),%eax
     92f:	01 d0                	add    %edx,%eax
     931:	0f b6 00             	movzbl (%eax),%eax
     934:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     937:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     93b:	83 e8 24             	sub    $0x24,%eax
     93e:	83 f8 3a             	cmp    $0x3a,%eax
     941:	0f 87 13 02 00 00    	ja     b5a <re_compile+0x251>
     947:	8b 04 85 c4 12 00 00 	mov    0x12c4(,%eax,4),%eax
     94e:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     950:	8b 45 f4             	mov    -0xc(%ebp),%eax
     953:	c6 04 c5 20 1a 00 00 	movb   $0x2,0x1a20(,%eax,8)
     95a:	02 
     95b:	e9 16 02 00 00       	jmp    b76 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     960:	8b 45 f4             	mov    -0xc(%ebp),%eax
     963:	c6 04 c5 20 1a 00 00 	movb   $0x3,0x1a20(,%eax,8)
     96a:	03 
     96b:	e9 06 02 00 00       	jmp    b76 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     970:	8b 45 f4             	mov    -0xc(%ebp),%eax
     973:	c6 04 c5 20 1a 00 00 	movb   $0x1,0x1a20(,%eax,8)
     97a:	01 
     97b:	e9 f6 01 00 00       	jmp    b76 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     980:	8b 45 f4             	mov    -0xc(%ebp),%eax
     983:	c6 04 c5 20 1a 00 00 	movb   $0x5,0x1a20(,%eax,8)
     98a:	05 
     98b:	e9 e6 01 00 00       	jmp    b76 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     990:	8b 45 f4             	mov    -0xc(%ebp),%eax
     993:	c6 04 c5 20 1a 00 00 	movb   $0x6,0x1a20(,%eax,8)
     99a:	06 
     99b:	e9 d6 01 00 00       	jmp    b76 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a3:	c6 04 c5 20 1a 00 00 	movb   $0x4,0x1a20(,%eax,8)
     9aa:	04 
     9ab:	e9 c6 01 00 00       	jmp    b76 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     9b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b3:	8d 50 01             	lea    0x1(%eax),%edx
     9b6:	8b 45 08             	mov    0x8(%ebp),%eax
     9b9:	01 d0                	add    %edx,%eax
     9bb:	0f b6 00             	movzbl (%eax),%eax
     9be:	84 c0                	test   %al,%al
     9c0:	0f 84 af 01 00 00    	je     b75 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     9c6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     9ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9cd:	8b 45 08             	mov    0x8(%ebp),%eax
     9d0:	01 d0                	add    %edx,%eax
     9d2:	0f b6 00             	movzbl (%eax),%eax
     9d5:	0f be c0             	movsbl %al,%eax
     9d8:	83 e8 44             	sub    $0x44,%eax
     9db:	83 f8 33             	cmp    $0x33,%eax
     9de:	77 57                	ja     a37 <re_compile+0x12e>
     9e0:	8b 04 85 b0 13 00 00 	mov    0x13b0(,%eax,4),%eax
     9e7:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ec:	c6 04 c5 20 1a 00 00 	movb   $0xa,0x1a20(,%eax,8)
     9f3:	0a 
     9f4:	eb 64                	jmp    a5a <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     9f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f9:	c6 04 c5 20 1a 00 00 	movb   $0xb,0x1a20(,%eax,8)
     a00:	0b 
     a01:	eb 57                	jmp    a5a <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a06:	c6 04 c5 20 1a 00 00 	movb   $0xc,0x1a20(,%eax,8)
     a0d:	0c 
     a0e:	eb 4a                	jmp    a5a <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a13:	c6 04 c5 20 1a 00 00 	movb   $0xd,0x1a20(,%eax,8)
     a1a:	0d 
     a1b:	eb 3d                	jmp    a5a <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a20:	c6 04 c5 20 1a 00 00 	movb   $0xe,0x1a20(,%eax,8)
     a27:	0e 
     a28:	eb 30                	jmp    a5a <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2d:	c6 04 c5 20 1a 00 00 	movb   $0xf,0x1a20(,%eax,8)
     a34:	0f 
     a35:	eb 23                	jmp    a5a <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3a:	c6 04 c5 20 1a 00 00 	movb   $0x7,0x1a20(,%eax,8)
     a41:	07 
              re_compiled[j].ch = pattern[i];
     a42:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a45:	8b 45 08             	mov    0x8(%ebp),%eax
     a48:	01 d0                	add    %edx,%eax
     a4a:	0f b6 00             	movzbl (%eax),%eax
     a4d:	89 c2                	mov    %eax,%edx
     a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a52:	88 14 c5 24 1a 00 00 	mov    %dl,0x1a24(,%eax,8)
            } break;
     a59:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a5a:	e9 16 01 00 00       	jmp    b75 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a62:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a65:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a68:	8d 50 01             	lea    0x1(%eax),%edx
     a6b:	8b 45 08             	mov    0x8(%ebp),%eax
     a6e:	01 d0                	add    %edx,%eax
     a70:	0f b6 00             	movzbl (%eax),%eax
     a73:	3c 5e                	cmp    $0x5e,%al
     a75:	75 11                	jne    a88 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7a:	c6 04 c5 20 1a 00 00 	movb   $0x9,0x1a20(,%eax,8)
     a81:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     a82:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     a86:	eb 7a                	jmp    b02 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8b:	c6 04 c5 20 1a 00 00 	movb   $0x8,0x1a20(,%eax,8)
     a92:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     a93:	eb 6d                	jmp    b02 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     a95:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a98:	8b 45 08             	mov    0x8(%ebp),%eax
     a9b:	01 d0                	add    %edx,%eax
     a9d:	0f b6 00             	movzbl (%eax),%eax
     aa0:	3c 5c                	cmp    $0x5c,%al
     aa2:	75 34                	jne    ad8 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     aa4:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     aa8:	7e 0a                	jle    ab4 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aaa:	b8 00 00 00 00       	mov    $0x0,%eax
     aaf:	e9 f8 00 00 00       	jmp    bac <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ab7:	8d 50 01             	lea    0x1(%eax),%edx
     aba:	89 55 fc             	mov    %edx,-0x4(%ebp)
     abd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ac0:	8d 4a 01             	lea    0x1(%edx),%ecx
     ac3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ac6:	89 d1                	mov    %edx,%ecx
     ac8:	8b 55 08             	mov    0x8(%ebp),%edx
     acb:	01 ca                	add    %ecx,%edx
     acd:	0f b6 12             	movzbl (%edx),%edx
     ad0:	88 90 20 1b 00 00    	mov    %dl,0x1b20(%eax)
     ad6:	eb 10                	jmp    ae8 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     ad8:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     adc:	7e 0a                	jle    ae8 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     ade:	b8 00 00 00 00       	mov    $0x0,%eax
     ae3:	e9 c4 00 00 00       	jmp    bac <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     ae8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aeb:	8d 50 01             	lea    0x1(%eax),%edx
     aee:	89 55 fc             	mov    %edx,-0x4(%ebp)
     af1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
     af7:	01 ca                	add    %ecx,%edx
     af9:	0f b6 12             	movzbl (%edx),%edx
     afc:	88 90 20 1b 00 00    	mov    %dl,0x1b20(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b02:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b06:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b09:	8b 45 08             	mov    0x8(%ebp),%eax
     b0c:	01 d0                	add    %edx,%eax
     b0e:	0f b6 00             	movzbl (%eax),%eax
     b11:	3c 5d                	cmp    $0x5d,%al
     b13:	74 13                	je     b28 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     b15:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b18:	8b 45 08             	mov    0x8(%ebp),%eax
     b1b:	01 d0                	add    %edx,%eax
     b1d:	0f b6 00             	movzbl (%eax),%eax
     b20:	84 c0                	test   %al,%al
     b22:	0f 85 6d ff ff ff    	jne    a95 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b28:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b2c:	7e 07                	jle    b35 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     b2e:	b8 00 00 00 00       	mov    $0x0,%eax
     b33:	eb 77                	jmp    bac <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b38:	8d 50 01             	lea    0x1(%eax),%edx
     b3b:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b3e:	c6 80 20 1b 00 00 00 	movb   $0x0,0x1b20(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b45:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b48:	8d 90 20 1b 00 00    	lea    0x1b20(%eax),%edx
     b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b51:	89 14 c5 24 1a 00 00 	mov    %edx,0x1a24(,%eax,8)
      } break;
     b58:	eb 1c                	jmp    b76 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5d:	c6 04 c5 20 1a 00 00 	movb   $0x7,0x1a20(,%eax,8)
     b64:	07 
        re_compiled[j].ch = c;
     b65:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6c:	88 14 c5 24 1a 00 00 	mov    %dl,0x1a24(,%eax,8)
      } break;
     b73:	eb 01                	jmp    b76 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b75:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     b76:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     b7a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     b7e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b81:	8b 45 08             	mov    0x8(%ebp),%eax
     b84:	01 d0                	add    %edx,%eax
     b86:	0f b6 00             	movzbl (%eax),%eax
     b89:	84 c0                	test   %al,%al
     b8b:	74 0f                	je     b9c <re_compile+0x293>
     b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b90:	83 c0 01             	add    $0x1,%eax
     b93:	83 f8 1d             	cmp    $0x1d,%eax
     b96:	0f 8e 8d fd ff ff    	jle    929 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9f:	c6 04 c5 20 1a 00 00 	movb   $0x0,0x1a20(,%eax,8)
     ba6:	00 

  return (re_t) re_compiled;
     ba7:	b8 20 1a 00 00       	mov    $0x1a20,%eax
}
     bac:	c9                   	leave  
     bad:	c3                   	ret    

00000bae <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     bae:	55                   	push   %ebp
     baf:	89 e5                	mov    %esp,%ebp
     bb1:	83 ec 04             	sub    $0x4,%esp
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     bba:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     bbe:	7e 0d                	jle    bcd <matchdigit+0x1f>
     bc0:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     bc4:	7f 07                	jg     bcd <matchdigit+0x1f>
     bc6:	b8 01 00 00 00       	mov    $0x1,%eax
     bcb:	eb 05                	jmp    bd2 <matchdigit+0x24>
     bcd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bd2:	c9                   	leave  
     bd3:	c3                   	ret    

00000bd4 <matchalpha>:
static int matchalpha(char c)
{
     bd4:	55                   	push   %ebp
     bd5:	89 e5                	mov    %esp,%ebp
     bd7:	83 ec 04             	sub    $0x4,%esp
     bda:	8b 45 08             	mov    0x8(%ebp),%eax
     bdd:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     be0:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     be4:	7e 06                	jle    bec <matchalpha+0x18>
     be6:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     bea:	7e 0c                	jle    bf8 <matchalpha+0x24>
     bec:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     bf0:	7e 0d                	jle    bff <matchalpha+0x2b>
     bf2:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     bf6:	7f 07                	jg     bff <matchalpha+0x2b>
     bf8:	b8 01 00 00 00       	mov    $0x1,%eax
     bfd:	eb 05                	jmp    c04 <matchalpha+0x30>
     bff:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c04:	c9                   	leave  
     c05:	c3                   	ret    

00000c06 <matchwhitespace>:
static int matchwhitespace(char c)
{
     c06:	55                   	push   %ebp
     c07:	89 e5                	mov    %esp,%ebp
     c09:	83 ec 04             	sub    $0x4,%esp
     c0c:	8b 45 08             	mov    0x8(%ebp),%eax
     c0f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     c12:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     c16:	74 1e                	je     c36 <matchwhitespace+0x30>
     c18:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     c1c:	74 18                	je     c36 <matchwhitespace+0x30>
     c1e:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     c22:	74 12                	je     c36 <matchwhitespace+0x30>
     c24:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     c28:	74 0c                	je     c36 <matchwhitespace+0x30>
     c2a:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     c2e:	74 06                	je     c36 <matchwhitespace+0x30>
     c30:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     c34:	75 07                	jne    c3d <matchwhitespace+0x37>
     c36:	b8 01 00 00 00       	mov    $0x1,%eax
     c3b:	eb 05                	jmp    c42 <matchwhitespace+0x3c>
     c3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c42:	c9                   	leave  
     c43:	c3                   	ret    

00000c44 <matchalphanum>:
static int matchalphanum(char c)
{
     c44:	55                   	push   %ebp
     c45:	89 e5                	mov    %esp,%ebp
     c47:	83 ec 04             	sub    $0x4,%esp
     c4a:	8b 45 08             	mov    0x8(%ebp),%eax
     c4d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c50:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c54:	74 22                	je     c78 <matchalphanum+0x34>
     c56:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c5a:	50                   	push   %eax
     c5b:	e8 74 ff ff ff       	call   bd4 <matchalpha>
     c60:	83 c4 04             	add    $0x4,%esp
     c63:	85 c0                	test   %eax,%eax
     c65:	75 11                	jne    c78 <matchalphanum+0x34>
     c67:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c6b:	50                   	push   %eax
     c6c:	e8 3d ff ff ff       	call   bae <matchdigit>
     c71:	83 c4 04             	add    $0x4,%esp
     c74:	85 c0                	test   %eax,%eax
     c76:	74 07                	je     c7f <matchalphanum+0x3b>
     c78:	b8 01 00 00 00       	mov    $0x1,%eax
     c7d:	eb 05                	jmp    c84 <matchalphanum+0x40>
     c7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c84:	c9                   	leave  
     c85:	c3                   	ret    

00000c86 <matchrange>:
static int matchrange(char c, const char* str)
{
     c86:	55                   	push   %ebp
     c87:	89 e5                	mov    %esp,%ebp
     c89:	83 ec 04             	sub    $0x4,%esp
     c8c:	8b 45 08             	mov    0x8(%ebp),%eax
     c8f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     c92:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     c96:	74 5b                	je     cf3 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     c98:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9b:	0f b6 00             	movzbl (%eax),%eax
     c9e:	84 c0                	test   %al,%al
     ca0:	74 51                	je     cf3 <matchrange+0x6d>
     ca2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca5:	0f b6 00             	movzbl (%eax),%eax
     ca8:	3c 2d                	cmp    $0x2d,%al
     caa:	74 47                	je     cf3 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cac:	8b 45 0c             	mov    0xc(%ebp),%eax
     caf:	83 c0 01             	add    $0x1,%eax
     cb2:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     cb5:	3c 2d                	cmp    $0x2d,%al
     cb7:	75 3a                	jne    cf3 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbc:	83 c0 01             	add    $0x1,%eax
     cbf:	0f b6 00             	movzbl (%eax),%eax
     cc2:	84 c0                	test   %al,%al
     cc4:	74 2d                	je     cf3 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc9:	83 c0 02             	add    $0x2,%eax
     ccc:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     ccf:	84 c0                	test   %al,%al
     cd1:	74 20                	je     cf3 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd6:	0f b6 00             	movzbl (%eax),%eax
     cd9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cdc:	7f 15                	jg     cf3 <matchrange+0x6d>
     cde:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce1:	83 c0 02             	add    $0x2,%eax
     ce4:	0f b6 00             	movzbl (%eax),%eax
     ce7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cea:	7c 07                	jl     cf3 <matchrange+0x6d>
     cec:	b8 01 00 00 00       	mov    $0x1,%eax
     cf1:	eb 05                	jmp    cf8 <matchrange+0x72>
     cf3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cf8:	c9                   	leave  
     cf9:	c3                   	ret    

00000cfa <ismetachar>:
static int ismetachar(char c)
{
     cfa:	55                   	push   %ebp
     cfb:	89 e5                	mov    %esp,%ebp
     cfd:	83 ec 04             	sub    $0x4,%esp
     d00:	8b 45 08             	mov    0x8(%ebp),%eax
     d03:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     d06:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     d0a:	74 1e                	je     d2a <ismetachar+0x30>
     d0c:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     d10:	74 18                	je     d2a <ismetachar+0x30>
     d12:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     d16:	74 12                	je     d2a <ismetachar+0x30>
     d18:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     d1c:	74 0c                	je     d2a <ismetachar+0x30>
     d1e:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     d22:	74 06                	je     d2a <ismetachar+0x30>
     d24:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     d28:	75 07                	jne    d31 <ismetachar+0x37>
     d2a:	b8 01 00 00 00       	mov    $0x1,%eax
     d2f:	eb 05                	jmp    d36 <ismetachar+0x3c>
     d31:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d36:	c9                   	leave  
     d37:	c3                   	ret    

00000d38 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d38:	55                   	push   %ebp
     d39:	89 e5                	mov    %esp,%ebp
     d3b:	83 ec 04             	sub    $0x4,%esp
     d3e:	8b 45 08             	mov    0x8(%ebp),%eax
     d41:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d44:	8b 45 0c             	mov    0xc(%ebp),%eax
     d47:	0f b6 00             	movzbl (%eax),%eax
     d4a:	0f be c0             	movsbl %al,%eax
     d4d:	83 e8 44             	sub    $0x44,%eax
     d50:	83 f8 33             	cmp    $0x33,%eax
     d53:	77 7b                	ja     dd0 <matchmetachar+0x98>
     d55:	8b 04 85 80 14 00 00 	mov    0x1480(,%eax,4),%eax
     d5c:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d5e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d62:	50                   	push   %eax
     d63:	e8 46 fe ff ff       	call   bae <matchdigit>
     d68:	83 c4 04             	add    $0x4,%esp
     d6b:	eb 72                	jmp    ddf <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d6d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d71:	50                   	push   %eax
     d72:	e8 37 fe ff ff       	call   bae <matchdigit>
     d77:	83 c4 04             	add    $0x4,%esp
     d7a:	85 c0                	test   %eax,%eax
     d7c:	0f 94 c0             	sete   %al
     d7f:	0f b6 c0             	movzbl %al,%eax
     d82:	eb 5b                	jmp    ddf <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     d84:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d88:	50                   	push   %eax
     d89:	e8 b6 fe ff ff       	call   c44 <matchalphanum>
     d8e:	83 c4 04             	add    $0x4,%esp
     d91:	eb 4c                	jmp    ddf <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     d93:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d97:	50                   	push   %eax
     d98:	e8 a7 fe ff ff       	call   c44 <matchalphanum>
     d9d:	83 c4 04             	add    $0x4,%esp
     da0:	85 c0                	test   %eax,%eax
     da2:	0f 94 c0             	sete   %al
     da5:	0f b6 c0             	movzbl %al,%eax
     da8:	eb 35                	jmp    ddf <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     daa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dae:	50                   	push   %eax
     daf:	e8 52 fe ff ff       	call   c06 <matchwhitespace>
     db4:	83 c4 04             	add    $0x4,%esp
     db7:	eb 26                	jmp    ddf <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     db9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dbd:	50                   	push   %eax
     dbe:	e8 43 fe ff ff       	call   c06 <matchwhitespace>
     dc3:	83 c4 04             	add    $0x4,%esp
     dc6:	85 c0                	test   %eax,%eax
     dc8:	0f 94 c0             	sete   %al
     dcb:	0f b6 c0             	movzbl %al,%eax
     dce:	eb 0f                	jmp    ddf <matchmetachar+0xa7>
    default:  return (c == str[0]);
     dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd3:	0f b6 00             	movzbl (%eax),%eax
     dd6:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dd9:	0f 94 c0             	sete   %al
     ddc:	0f b6 c0             	movzbl %al,%eax
  }
}
     ddf:	c9                   	leave  
     de0:	c3                   	ret    

00000de1 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     de1:	55                   	push   %ebp
     de2:	89 e5                	mov    %esp,%ebp
     de4:	83 ec 04             	sub    $0x4,%esp
     de7:	8b 45 08             	mov    0x8(%ebp),%eax
     dea:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     ded:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     df1:	ff 75 0c             	pushl  0xc(%ebp)
     df4:	50                   	push   %eax
     df5:	e8 8c fe ff ff       	call   c86 <matchrange>
     dfa:	83 c4 08             	add    $0x8,%esp
     dfd:	85 c0                	test   %eax,%eax
     dff:	74 0a                	je     e0b <matchcharclass+0x2a>
    {
      return 1;
     e01:	b8 01 00 00 00       	mov    $0x1,%eax
     e06:	e9 a5 00 00 00       	jmp    eb0 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0e:	0f b6 00             	movzbl (%eax),%eax
     e11:	3c 5c                	cmp    $0x5c,%al
     e13:	75 42                	jne    e57 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     e15:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     e19:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e1d:	ff 75 0c             	pushl  0xc(%ebp)
     e20:	50                   	push   %eax
     e21:	e8 12 ff ff ff       	call   d38 <matchmetachar>
     e26:	83 c4 08             	add    $0x8,%esp
     e29:	85 c0                	test   %eax,%eax
     e2b:	74 07                	je     e34 <matchcharclass+0x53>
      {
        return 1;
     e2d:	b8 01 00 00 00       	mov    $0x1,%eax
     e32:	eb 7c                	jmp    eb0 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     e34:	8b 45 0c             	mov    0xc(%ebp),%eax
     e37:	0f b6 00             	movzbl (%eax),%eax
     e3a:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e3d:	75 58                	jne    e97 <matchcharclass+0xb6>
     e3f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e43:	50                   	push   %eax
     e44:	e8 b1 fe ff ff       	call   cfa <ismetachar>
     e49:	83 c4 04             	add    $0x4,%esp
     e4c:	85 c0                	test   %eax,%eax
     e4e:	75 47                	jne    e97 <matchcharclass+0xb6>
      {
        return 1;
     e50:	b8 01 00 00 00       	mov    $0x1,%eax
     e55:	eb 59                	jmp    eb0 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e57:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5a:	0f b6 00             	movzbl (%eax),%eax
     e5d:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e60:	75 35                	jne    e97 <matchcharclass+0xb6>
    {
      if (c == '-')
     e62:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e66:	75 28                	jne    e90 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e68:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6b:	83 e8 01             	sub    $0x1,%eax
     e6e:	0f b6 00             	movzbl (%eax),%eax
     e71:	84 c0                	test   %al,%al
     e73:	74 0d                	je     e82 <matchcharclass+0xa1>
     e75:	8b 45 0c             	mov    0xc(%ebp),%eax
     e78:	83 c0 01             	add    $0x1,%eax
     e7b:	0f b6 00             	movzbl (%eax),%eax
     e7e:	84 c0                	test   %al,%al
     e80:	75 07                	jne    e89 <matchcharclass+0xa8>
     e82:	b8 01 00 00 00       	mov    $0x1,%eax
     e87:	eb 27                	jmp    eb0 <matchcharclass+0xcf>
     e89:	b8 00 00 00 00       	mov    $0x0,%eax
     e8e:	eb 20                	jmp    eb0 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     e90:	b8 01 00 00 00       	mov    $0x1,%eax
     e95:	eb 19                	jmp    eb0 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     e97:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9a:	8d 50 01             	lea    0x1(%eax),%edx
     e9d:	89 55 0c             	mov    %edx,0xc(%ebp)
     ea0:	0f b6 00             	movzbl (%eax),%eax
     ea3:	84 c0                	test   %al,%al
     ea5:	0f 85 42 ff ff ff    	jne    ded <matchcharclass+0xc>

  return 0;
     eab:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eb0:	c9                   	leave  
     eb1:	c3                   	ret    

00000eb2 <matchone>:

static int matchone(regex_t p, char c)
{
     eb2:	55                   	push   %ebp
     eb3:	89 e5                	mov    %esp,%ebp
     eb5:	83 ec 04             	sub    $0x4,%esp
     eb8:	8b 45 10             	mov    0x10(%ebp),%eax
     ebb:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     ebe:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     ec2:	0f b6 c0             	movzbl %al,%eax
     ec5:	83 f8 0f             	cmp    $0xf,%eax
     ec8:	0f 87 b9 00 00 00    	ja     f87 <matchone+0xd5>
     ece:	8b 04 85 50 15 00 00 	mov    0x1550(,%eax,4),%eax
     ed5:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     ed7:	b8 01 00 00 00       	mov    $0x1,%eax
     edc:	e9 b9 00 00 00       	jmp    f9a <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     ee1:	8b 55 0c             	mov    0xc(%ebp),%edx
     ee4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ee8:	52                   	push   %edx
     ee9:	50                   	push   %eax
     eea:	e8 f2 fe ff ff       	call   de1 <matchcharclass>
     eef:	83 c4 08             	add    $0x8,%esp
     ef2:	e9 a3 00 00 00       	jmp    f9a <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     ef7:	8b 55 0c             	mov    0xc(%ebp),%edx
     efa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     efe:	52                   	push   %edx
     eff:	50                   	push   %eax
     f00:	e8 dc fe ff ff       	call   de1 <matchcharclass>
     f05:	83 c4 08             	add    $0x8,%esp
     f08:	85 c0                	test   %eax,%eax
     f0a:	0f 94 c0             	sete   %al
     f0d:	0f b6 c0             	movzbl %al,%eax
     f10:	e9 85 00 00 00       	jmp    f9a <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     f15:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f19:	50                   	push   %eax
     f1a:	e8 8f fc ff ff       	call   bae <matchdigit>
     f1f:	83 c4 04             	add    $0x4,%esp
     f22:	eb 76                	jmp    f9a <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     f24:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f28:	50                   	push   %eax
     f29:	e8 80 fc ff ff       	call   bae <matchdigit>
     f2e:	83 c4 04             	add    $0x4,%esp
     f31:	85 c0                	test   %eax,%eax
     f33:	0f 94 c0             	sete   %al
     f36:	0f b6 c0             	movzbl %al,%eax
     f39:	eb 5f                	jmp    f9a <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f3b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f3f:	50                   	push   %eax
     f40:	e8 ff fc ff ff       	call   c44 <matchalphanum>
     f45:	83 c4 04             	add    $0x4,%esp
     f48:	eb 50                	jmp    f9a <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f4a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4e:	50                   	push   %eax
     f4f:	e8 f0 fc ff ff       	call   c44 <matchalphanum>
     f54:	83 c4 04             	add    $0x4,%esp
     f57:	85 c0                	test   %eax,%eax
     f59:	0f 94 c0             	sete   %al
     f5c:	0f b6 c0             	movzbl %al,%eax
     f5f:	eb 39                	jmp    f9a <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f61:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f65:	50                   	push   %eax
     f66:	e8 9b fc ff ff       	call   c06 <matchwhitespace>
     f6b:	83 c4 04             	add    $0x4,%esp
     f6e:	eb 2a                	jmp    f9a <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f70:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f74:	50                   	push   %eax
     f75:	e8 8c fc ff ff       	call   c06 <matchwhitespace>
     f7a:	83 c4 04             	add    $0x4,%esp
     f7d:	85 c0                	test   %eax,%eax
     f7f:	0f 94 c0             	sete   %al
     f82:	0f b6 c0             	movzbl %al,%eax
     f85:	eb 13                	jmp    f9a <matchone+0xe8>
    default:             return  (p.ch == c);
     f87:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     f8b:	0f b6 d0             	movzbl %al,%edx
     f8e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f92:	39 c2                	cmp    %eax,%edx
     f94:	0f 94 c0             	sete   %al
     f97:	0f b6 c0             	movzbl %al,%eax
  }
}
     f9a:	c9                   	leave  
     f9b:	c3                   	ret    

00000f9c <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     f9c:	55                   	push   %ebp
     f9d:	89 e5                	mov    %esp,%ebp
     f9f:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     fa2:	8b 45 18             	mov    0x18(%ebp),%eax
     fa5:	8b 00                	mov    (%eax),%eax
     fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     faa:	8b 45 14             	mov    0x14(%ebp),%eax
     fad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     fb0:	eb 11                	jmp    fc3 <matchstar+0x27>
  {
    text++;
     fb2:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     fb6:	8b 45 18             	mov    0x18(%ebp),%eax
     fb9:	8b 00                	mov    (%eax),%eax
     fbb:	8d 50 01             	lea    0x1(%eax),%edx
     fbe:	8b 45 18             	mov    0x18(%ebp),%eax
     fc1:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     fc3:	8b 45 14             	mov    0x14(%ebp),%eax
     fc6:	0f b6 00             	movzbl (%eax),%eax
     fc9:	84 c0                	test   %al,%al
     fcb:	74 51                	je     101e <matchstar+0x82>
     fcd:	8b 45 14             	mov    0x14(%ebp),%eax
     fd0:	0f b6 00             	movzbl (%eax),%eax
     fd3:	0f be c0             	movsbl %al,%eax
     fd6:	50                   	push   %eax
     fd7:	ff 75 0c             	pushl  0xc(%ebp)
     fda:	ff 75 08             	pushl  0x8(%ebp)
     fdd:	e8 d0 fe ff ff       	call   eb2 <matchone>
     fe2:	83 c4 0c             	add    $0xc,%esp
     fe5:	85 c0                	test   %eax,%eax
     fe7:	75 c9                	jne    fb2 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     fe9:	eb 33                	jmp    101e <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     feb:	8b 45 14             	mov    0x14(%ebp),%eax
     fee:	8d 50 ff             	lea    -0x1(%eax),%edx
     ff1:	89 55 14             	mov    %edx,0x14(%ebp)
     ff4:	83 ec 04             	sub    $0x4,%esp
     ff7:	ff 75 18             	pushl  0x18(%ebp)
     ffa:	50                   	push   %eax
     ffb:	ff 75 10             	pushl  0x10(%ebp)
     ffe:	e8 51 01 00 00       	call   1154 <matchpattern>
    1003:	83 c4 10             	add    $0x10,%esp
    1006:	85 c0                	test   %eax,%eax
    1008:	74 07                	je     1011 <matchstar+0x75>
      return 1;
    100a:	b8 01 00 00 00       	mov    $0x1,%eax
    100f:	eb 22                	jmp    1033 <matchstar+0x97>
    (*matchlength)--;
    1011:	8b 45 18             	mov    0x18(%ebp),%eax
    1014:	8b 00                	mov    (%eax),%eax
    1016:	8d 50 ff             	lea    -0x1(%eax),%edx
    1019:	8b 45 18             	mov    0x18(%ebp),%eax
    101c:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    101e:	8b 45 14             	mov    0x14(%ebp),%eax
    1021:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1024:	73 c5                	jae    feb <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1026:	8b 45 18             	mov    0x18(%ebp),%eax
    1029:	8b 55 f4             	mov    -0xc(%ebp),%edx
    102c:	89 10                	mov    %edx,(%eax)
  return 0;
    102e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1033:	c9                   	leave  
    1034:	c3                   	ret    

00001035 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1035:	55                   	push   %ebp
    1036:	89 e5                	mov    %esp,%ebp
    1038:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    103b:	8b 45 14             	mov    0x14(%ebp),%eax
    103e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1041:	eb 11                	jmp    1054 <matchplus+0x1f>
  {
    text++;
    1043:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1047:	8b 45 18             	mov    0x18(%ebp),%eax
    104a:	8b 00                	mov    (%eax),%eax
    104c:	8d 50 01             	lea    0x1(%eax),%edx
    104f:	8b 45 18             	mov    0x18(%ebp),%eax
    1052:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1054:	8b 45 14             	mov    0x14(%ebp),%eax
    1057:	0f b6 00             	movzbl (%eax),%eax
    105a:	84 c0                	test   %al,%al
    105c:	74 51                	je     10af <matchplus+0x7a>
    105e:	8b 45 14             	mov    0x14(%ebp),%eax
    1061:	0f b6 00             	movzbl (%eax),%eax
    1064:	0f be c0             	movsbl %al,%eax
    1067:	50                   	push   %eax
    1068:	ff 75 0c             	pushl  0xc(%ebp)
    106b:	ff 75 08             	pushl  0x8(%ebp)
    106e:	e8 3f fe ff ff       	call   eb2 <matchone>
    1073:	83 c4 0c             	add    $0xc,%esp
    1076:	85 c0                	test   %eax,%eax
    1078:	75 c9                	jne    1043 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    107a:	eb 33                	jmp    10af <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    107c:	8b 45 14             	mov    0x14(%ebp),%eax
    107f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1082:	89 55 14             	mov    %edx,0x14(%ebp)
    1085:	83 ec 04             	sub    $0x4,%esp
    1088:	ff 75 18             	pushl  0x18(%ebp)
    108b:	50                   	push   %eax
    108c:	ff 75 10             	pushl  0x10(%ebp)
    108f:	e8 c0 00 00 00       	call   1154 <matchpattern>
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	85 c0                	test   %eax,%eax
    1099:	74 07                	je     10a2 <matchplus+0x6d>
      return 1;
    109b:	b8 01 00 00 00       	mov    $0x1,%eax
    10a0:	eb 1a                	jmp    10bc <matchplus+0x87>
    (*matchlength)--;
    10a2:	8b 45 18             	mov    0x18(%ebp),%eax
    10a5:	8b 00                	mov    (%eax),%eax
    10a7:	8d 50 ff             	lea    -0x1(%eax),%edx
    10aa:	8b 45 18             	mov    0x18(%ebp),%eax
    10ad:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10af:	8b 45 14             	mov    0x14(%ebp),%eax
    10b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10b5:	77 c5                	ja     107c <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    10b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10bc:	c9                   	leave  
    10bd:	c3                   	ret    

000010be <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10be:	55                   	push   %ebp
    10bf:	89 e5                	mov    %esp,%ebp
    10c1:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    10c4:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10c8:	84 c0                	test   %al,%al
    10ca:	75 07                	jne    10d3 <matchquestion+0x15>
    return 1;
    10cc:	b8 01 00 00 00       	mov    $0x1,%eax
    10d1:	eb 7f                	jmp    1152 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    10d3:	83 ec 04             	sub    $0x4,%esp
    10d6:	ff 75 18             	pushl  0x18(%ebp)
    10d9:	ff 75 14             	pushl  0x14(%ebp)
    10dc:	ff 75 10             	pushl  0x10(%ebp)
    10df:	e8 70 00 00 00       	call   1154 <matchpattern>
    10e4:	83 c4 10             	add    $0x10,%esp
    10e7:	85 c0                	test   %eax,%eax
    10e9:	74 07                	je     10f2 <matchquestion+0x34>
      return 1;
    10eb:	b8 01 00 00 00       	mov    $0x1,%eax
    10f0:	eb 60                	jmp    1152 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    10f2:	8b 45 14             	mov    0x14(%ebp),%eax
    10f5:	0f b6 00             	movzbl (%eax),%eax
    10f8:	84 c0                	test   %al,%al
    10fa:	74 51                	je     114d <matchquestion+0x8f>
    10fc:	8b 45 14             	mov    0x14(%ebp),%eax
    10ff:	8d 50 01             	lea    0x1(%eax),%edx
    1102:	89 55 14             	mov    %edx,0x14(%ebp)
    1105:	0f b6 00             	movzbl (%eax),%eax
    1108:	0f be c0             	movsbl %al,%eax
    110b:	83 ec 04             	sub    $0x4,%esp
    110e:	50                   	push   %eax
    110f:	ff 75 0c             	pushl  0xc(%ebp)
    1112:	ff 75 08             	pushl  0x8(%ebp)
    1115:	e8 98 fd ff ff       	call   eb2 <matchone>
    111a:	83 c4 10             	add    $0x10,%esp
    111d:	85 c0                	test   %eax,%eax
    111f:	74 2c                	je     114d <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    1121:	83 ec 04             	sub    $0x4,%esp
    1124:	ff 75 18             	pushl  0x18(%ebp)
    1127:	ff 75 14             	pushl  0x14(%ebp)
    112a:	ff 75 10             	pushl  0x10(%ebp)
    112d:	e8 22 00 00 00       	call   1154 <matchpattern>
    1132:	83 c4 10             	add    $0x10,%esp
    1135:	85 c0                	test   %eax,%eax
    1137:	74 14                	je     114d <matchquestion+0x8f>
    {
      (*matchlength)++;
    1139:	8b 45 18             	mov    0x18(%ebp),%eax
    113c:	8b 00                	mov    (%eax),%eax
    113e:	8d 50 01             	lea    0x1(%eax),%edx
    1141:	8b 45 18             	mov    0x18(%ebp),%eax
    1144:	89 10                	mov    %edx,(%eax)
      return 1;
    1146:	b8 01 00 00 00       	mov    $0x1,%eax
    114b:	eb 05                	jmp    1152 <matchquestion+0x94>
    }
  }
  return 0;
    114d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1152:	c9                   	leave  
    1153:	c3                   	ret    

00001154 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1154:	55                   	push   %ebp
    1155:	89 e5                	mov    %esp,%ebp
    1157:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    115a:	8b 45 10             	mov    0x10(%ebp),%eax
    115d:	8b 00                	mov    (%eax),%eax
    115f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	0f b6 00             	movzbl (%eax),%eax
    1168:	84 c0                	test   %al,%al
    116a:	74 0d                	je     1179 <matchpattern+0x25>
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	83 c0 08             	add    $0x8,%eax
    1172:	0f b6 00             	movzbl (%eax),%eax
    1175:	3c 04                	cmp    $0x4,%al
    1177:	75 25                	jne    119e <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
    117c:	83 c0 10             	add    $0x10,%eax
    117f:	83 ec 0c             	sub    $0xc,%esp
    1182:	ff 75 10             	pushl  0x10(%ebp)
    1185:	ff 75 0c             	pushl  0xc(%ebp)
    1188:	50                   	push   %eax
    1189:	8b 45 08             	mov    0x8(%ebp),%eax
    118c:	ff 70 04             	pushl  0x4(%eax)
    118f:	ff 30                	pushl  (%eax)
    1191:	e8 28 ff ff ff       	call   10be <matchquestion>
    1196:	83 c4 20             	add    $0x20,%esp
    1199:	e9 dd 00 00 00       	jmp    127b <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    119e:	8b 45 08             	mov    0x8(%ebp),%eax
    11a1:	83 c0 08             	add    $0x8,%eax
    11a4:	0f b6 00             	movzbl (%eax),%eax
    11a7:	3c 05                	cmp    $0x5,%al
    11a9:	75 25                	jne    11d0 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
    11ae:	83 c0 10             	add    $0x10,%eax
    11b1:	83 ec 0c             	sub    $0xc,%esp
    11b4:	ff 75 10             	pushl  0x10(%ebp)
    11b7:	ff 75 0c             	pushl  0xc(%ebp)
    11ba:	50                   	push   %eax
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	ff 70 04             	pushl  0x4(%eax)
    11c1:	ff 30                	pushl  (%eax)
    11c3:	e8 d4 fd ff ff       	call   f9c <matchstar>
    11c8:	83 c4 20             	add    $0x20,%esp
    11cb:	e9 ab 00 00 00       	jmp    127b <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	83 c0 08             	add    $0x8,%eax
    11d6:	0f b6 00             	movzbl (%eax),%eax
    11d9:	3c 06                	cmp    $0x6,%al
    11db:	75 22                	jne    11ff <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
    11e0:	83 c0 10             	add    $0x10,%eax
    11e3:	83 ec 0c             	sub    $0xc,%esp
    11e6:	ff 75 10             	pushl  0x10(%ebp)
    11e9:	ff 75 0c             	pushl  0xc(%ebp)
    11ec:	50                   	push   %eax
    11ed:	8b 45 08             	mov    0x8(%ebp),%eax
    11f0:	ff 70 04             	pushl  0x4(%eax)
    11f3:	ff 30                	pushl  (%eax)
    11f5:	e8 3b fe ff ff       	call   1035 <matchplus>
    11fa:	83 c4 20             	add    $0x20,%esp
    11fd:	eb 7c                	jmp    127b <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1202:	0f b6 00             	movzbl (%eax),%eax
    1205:	3c 03                	cmp    $0x3,%al
    1207:	75 1d                	jne    1226 <matchpattern+0xd2>
    1209:	8b 45 08             	mov    0x8(%ebp),%eax
    120c:	83 c0 08             	add    $0x8,%eax
    120f:	0f b6 00             	movzbl (%eax),%eax
    1212:	84 c0                	test   %al,%al
    1214:	75 10                	jne    1226 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1216:	8b 45 0c             	mov    0xc(%ebp),%eax
    1219:	0f b6 00             	movzbl (%eax),%eax
    121c:	84 c0                	test   %al,%al
    121e:	0f 94 c0             	sete   %al
    1221:	0f b6 c0             	movzbl %al,%eax
    1224:	eb 55                	jmp    127b <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1226:	8b 45 10             	mov    0x10(%ebp),%eax
    1229:	8b 00                	mov    (%eax),%eax
    122b:	8d 50 01             	lea    0x1(%eax),%edx
    122e:	8b 45 10             	mov    0x10(%ebp),%eax
    1231:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1233:	8b 45 0c             	mov    0xc(%ebp),%eax
    1236:	0f b6 00             	movzbl (%eax),%eax
    1239:	84 c0                	test   %al,%al
    123b:	74 31                	je     126e <matchpattern+0x11a>
    123d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1240:	8d 50 01             	lea    0x1(%eax),%edx
    1243:	89 55 0c             	mov    %edx,0xc(%ebp)
    1246:	0f b6 00             	movzbl (%eax),%eax
    1249:	0f be d0             	movsbl %al,%edx
    124c:	8b 45 08             	mov    0x8(%ebp),%eax
    124f:	8d 48 08             	lea    0x8(%eax),%ecx
    1252:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1255:	83 ec 04             	sub    $0x4,%esp
    1258:	52                   	push   %edx
    1259:	ff 70 04             	pushl  0x4(%eax)
    125c:	ff 30                	pushl  (%eax)
    125e:	e8 4f fc ff ff       	call   eb2 <matchone>
    1263:	83 c4 10             	add    $0x10,%esp
    1266:	85 c0                	test   %eax,%eax
    1268:	0f 85 f4 fe ff ff    	jne    1162 <matchpattern+0xe>

  *matchlength = pre;
    126e:	8b 45 10             	mov    0x10(%ebp),%eax
    1271:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1274:	89 10                	mov    %edx,(%eax)
  return 0;
    1276:	b8 00 00 00 00       	mov    $0x0,%eax
}
    127b:	c9                   	leave  
    127c:	c3                   	ret    
