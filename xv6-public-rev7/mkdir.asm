
_mkdir:     file format elf32-i386


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
       f:	83 ec 10             	sub    $0x10,%esp
      12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
      14:	83 3b 01             	cmpl   $0x1,(%ebx)
      17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 ac 12 00 00       	push   $0x12ac
      21:	6a 02                	push   $0x2
      23:	e8 96 04 00 00       	call   4be <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 b7 02 00 00       	call   2e7 <exit>
  }

  for(i = 1; i < argc; i++){
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 4b                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 fc 02 00 00       	call   34f <mkdir>
      53:	83 c4 10             	add    $0x10,%esp
      56:	85 c0                	test   %eax,%eax
      58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      64:	8b 43 04             	mov    0x4(%ebx),%eax
      67:	01 d0                	add    %edx,%eax
      69:	8b 00                	mov    (%eax),%eax
      6b:	83 ec 04             	sub    $0x4,%esp
      6e:	50                   	push   %eax
      6f:	68 c3 12 00 00       	push   $0x12c3
      74:	6a 02                	push   $0x2
      76:	e8 43 04 00 00       	call   4be <printf>
      7b:	83 c4 10             	add    $0x10,%esp
      break;
      7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
      80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      84:	8b 45 f4             	mov    -0xc(%ebp),%eax
      87:	3b 03                	cmp    (%ebx),%eax
      89:	7c ae                	jl     39 <main+0x39>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
      8b:	e8 57 02 00 00       	call   2e7 <exit>

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	57                   	push   %edi
      94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      95:	8b 4d 08             	mov    0x8(%ebp),%ecx
      98:	8b 55 10             	mov    0x10(%ebp),%edx
      9b:	8b 45 0c             	mov    0xc(%ebp),%eax
      9e:	89 cb                	mov    %ecx,%ebx
      a0:	89 df                	mov    %ebx,%edi
      a2:	89 d1                	mov    %edx,%ecx
      a4:	fc                   	cld    
      a5:	f3 aa                	rep stos %al,%es:(%edi)
      a7:	89 ca                	mov    %ecx,%edx
      a9:	89 fb                	mov    %edi,%ebx
      ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
      ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      b1:	90                   	nop
      b2:	5b                   	pop    %ebx
      b3:	5f                   	pop    %edi
      b4:	5d                   	pop    %ebp
      b5:	c3                   	ret    

000000b6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      b6:	55                   	push   %ebp
      b7:	89 e5                	mov    %esp,%ebp
      b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      bc:	8b 45 08             	mov    0x8(%ebp),%eax
      bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      c2:	90                   	nop
      c3:	8b 45 08             	mov    0x8(%ebp),%eax
      c6:	8d 50 01             	lea    0x1(%eax),%edx
      c9:	89 55 08             	mov    %edx,0x8(%ebp)
      cc:	8b 55 0c             	mov    0xc(%ebp),%edx
      cf:	8d 4a 01             	lea    0x1(%edx),%ecx
      d2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      d5:	0f b6 12             	movzbl (%edx),%edx
      d8:	88 10                	mov    %dl,(%eax)
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	75 e2                	jne    c3 <strcpy+0xd>
    ;
  return os;
      e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e4:	c9                   	leave  
      e5:	c3                   	ret    

000000e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      e6:	55                   	push   %ebp
      e7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      e9:	eb 08                	jmp    f3 <strcmp+0xd>
    p++, q++;
      eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      f3:	8b 45 08             	mov    0x8(%ebp),%eax
      f6:	0f b6 00             	movzbl (%eax),%eax
      f9:	84 c0                	test   %al,%al
      fb:	74 10                	je     10d <strcmp+0x27>
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
     100:	0f b6 10             	movzbl (%eax),%edx
     103:	8b 45 0c             	mov    0xc(%ebp),%eax
     106:	0f b6 00             	movzbl (%eax),%eax
     109:	38 c2                	cmp    %al,%dl
     10b:	74 de                	je     eb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     10d:	8b 45 08             	mov    0x8(%ebp),%eax
     110:	0f b6 00             	movzbl (%eax),%eax
     113:	0f b6 d0             	movzbl %al,%edx
     116:	8b 45 0c             	mov    0xc(%ebp),%eax
     119:	0f b6 00             	movzbl (%eax),%eax
     11c:	0f b6 c0             	movzbl %al,%eax
     11f:	29 c2                	sub    %eax,%edx
     121:	89 d0                	mov    %edx,%eax
}
     123:	5d                   	pop    %ebp
     124:	c3                   	ret    

00000125 <strlen>:

uint
strlen(char *s)
{
     125:	55                   	push   %ebp
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     132:	eb 04                	jmp    138 <strlen+0x13>
     134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     138:	8b 55 fc             	mov    -0x4(%ebp),%edx
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	01 d0                	add    %edx,%eax
     140:	0f b6 00             	movzbl (%eax),%eax
     143:	84 c0                	test   %al,%al
     145:	75 ed                	jne    134 <strlen+0xf>
    ;
  return n;
     147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     14a:	c9                   	leave  
     14b:	c3                   	ret    

0000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
     14c:	55                   	push   %ebp
     14d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     14f:	8b 45 10             	mov    0x10(%ebp),%eax
     152:	50                   	push   %eax
     153:	ff 75 0c             	pushl  0xc(%ebp)
     156:	ff 75 08             	pushl  0x8(%ebp)
     159:	e8 32 ff ff ff       	call   90 <stosb>
     15e:	83 c4 0c             	add    $0xc,%esp
  return dst;
     161:	8b 45 08             	mov    0x8(%ebp),%eax
}
     164:	c9                   	leave  
     165:	c3                   	ret    

00000166 <strchr>:

char*
strchr(const char *s, char c)
{
     166:	55                   	push   %ebp
     167:	89 e5                	mov    %esp,%ebp
     169:	83 ec 04             	sub    $0x4,%esp
     16c:	8b 45 0c             	mov    0xc(%ebp),%eax
     16f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     172:	eb 14                	jmp    188 <strchr+0x22>
    if(*s == c)
     174:	8b 45 08             	mov    0x8(%ebp),%eax
     177:	0f b6 00             	movzbl (%eax),%eax
     17a:	3a 45 fc             	cmp    -0x4(%ebp),%al
     17d:	75 05                	jne    184 <strchr+0x1e>
      return (char*)s;
     17f:	8b 45 08             	mov    0x8(%ebp),%eax
     182:	eb 13                	jmp    197 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     188:	8b 45 08             	mov    0x8(%ebp),%eax
     18b:	0f b6 00             	movzbl (%eax),%eax
     18e:	84 c0                	test   %al,%al
     190:	75 e2                	jne    174 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     192:	b8 00 00 00 00       	mov    $0x0,%eax
}
     197:	c9                   	leave  
     198:	c3                   	ret    

00000199 <gets>:

char*
gets(char *buf, int max)
{
     199:	55                   	push   %ebp
     19a:	89 e5                	mov    %esp,%ebp
     19c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1a6:	eb 42                	jmp    1ea <gets+0x51>
    cc = read(0, &c, 1);
     1a8:	83 ec 04             	sub    $0x4,%esp
     1ab:	6a 01                	push   $0x1
     1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1b0:	50                   	push   %eax
     1b1:	6a 00                	push   $0x0
     1b3:	e8 47 01 00 00       	call   2ff <read>
     1b8:	83 c4 10             	add    $0x10,%esp
     1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1c2:	7e 33                	jle    1f7 <gets+0x5e>
      break;
    buf[i++] = c;
     1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c7:	8d 50 01             	lea    0x1(%eax),%edx
     1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1cd:	89 c2                	mov    %eax,%edx
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
     1d2:	01 c2                	add    %eax,%edx
     1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1de:	3c 0a                	cmp    $0xa,%al
     1e0:	74 16                	je     1f8 <gets+0x5f>
     1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1e6:	3c 0d                	cmp    $0xd,%al
     1e8:	74 0e                	je     1f8 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ed:	83 c0 01             	add    $0x1,%eax
     1f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1f3:	7c b3                	jl     1a8 <gets+0xf>
     1f5:	eb 01                	jmp    1f8 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1f7:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1fb:	8b 45 08             	mov    0x8(%ebp),%eax
     1fe:	01 d0                	add    %edx,%eax
     200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     203:	8b 45 08             	mov    0x8(%ebp),%eax
}
     206:	c9                   	leave  
     207:	c3                   	ret    

00000208 <stat>:

int
stat(char *n, struct stat *st)
{
     208:	55                   	push   %ebp
     209:	89 e5                	mov    %esp,%ebp
     20b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     20e:	83 ec 08             	sub    $0x8,%esp
     211:	6a 00                	push   $0x0
     213:	ff 75 08             	pushl  0x8(%ebp)
     216:	e8 0c 01 00 00       	call   327 <open>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     225:	79 07                	jns    22e <stat+0x26>
    return -1;
     227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     22c:	eb 25                	jmp    253 <stat+0x4b>
  r = fstat(fd, st);
     22e:	83 ec 08             	sub    $0x8,%esp
     231:	ff 75 0c             	pushl  0xc(%ebp)
     234:	ff 75 f4             	pushl  -0xc(%ebp)
     237:	e8 03 01 00 00       	call   33f <fstat>
     23c:	83 c4 10             	add    $0x10,%esp
     23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     242:	83 ec 0c             	sub    $0xc,%esp
     245:	ff 75 f4             	pushl  -0xc(%ebp)
     248:	e8 c2 00 00 00       	call   30f <close>
     24d:	83 c4 10             	add    $0x10,%esp
  return r;
     250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     253:	c9                   	leave  
     254:	c3                   	ret    

00000255 <atoi>:

int
atoi(const char *s)
{
     255:	55                   	push   %ebp
     256:	89 e5                	mov    %esp,%ebp
     258:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     262:	eb 25                	jmp    289 <atoi+0x34>
    n = n*10 + *s++ - '0';
     264:	8b 55 fc             	mov    -0x4(%ebp),%edx
     267:	89 d0                	mov    %edx,%eax
     269:	c1 e0 02             	shl    $0x2,%eax
     26c:	01 d0                	add    %edx,%eax
     26e:	01 c0                	add    %eax,%eax
     270:	89 c1                	mov    %eax,%ecx
     272:	8b 45 08             	mov    0x8(%ebp),%eax
     275:	8d 50 01             	lea    0x1(%eax),%edx
     278:	89 55 08             	mov    %edx,0x8(%ebp)
     27b:	0f b6 00             	movzbl (%eax),%eax
     27e:	0f be c0             	movsbl %al,%eax
     281:	01 c8                	add    %ecx,%eax
     283:	83 e8 30             	sub    $0x30,%eax
     286:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     289:	8b 45 08             	mov    0x8(%ebp),%eax
     28c:	0f b6 00             	movzbl (%eax),%eax
     28f:	3c 2f                	cmp    $0x2f,%al
     291:	7e 0a                	jle    29d <atoi+0x48>
     293:	8b 45 08             	mov    0x8(%ebp),%eax
     296:	0f b6 00             	movzbl (%eax),%eax
     299:	3c 39                	cmp    $0x39,%al
     29b:	7e c7                	jle    264 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2a0:	c9                   	leave  
     2a1:	c3                   	ret    

000002a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2a2:	55                   	push   %ebp
     2a3:	89 e5                	mov    %esp,%ebp
     2a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     2a8:	8b 45 08             	mov    0x8(%ebp),%eax
     2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2b4:	eb 17                	jmp    2cd <memmove+0x2b>
    *dst++ = *src++;
     2b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2b9:	8d 50 01             	lea    0x1(%eax),%edx
     2bc:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2c2:	8d 4a 01             	lea    0x1(%edx),%ecx
     2c5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     2c8:	0f b6 12             	movzbl (%edx),%edx
     2cb:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2cd:	8b 45 10             	mov    0x10(%ebp),%eax
     2d0:	8d 50 ff             	lea    -0x1(%eax),%edx
     2d3:	89 55 10             	mov    %edx,0x10(%ebp)
     2d6:	85 c0                	test   %eax,%eax
     2d8:	7f dc                	jg     2b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2da:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2dd:	c9                   	leave  
     2de:	c3                   	ret    

000002df <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2df:	b8 01 00 00 00       	mov    $0x1,%eax
     2e4:	cd 40                	int    $0x40
     2e6:	c3                   	ret    

000002e7 <exit>:
SYSCALL(exit)
     2e7:	b8 02 00 00 00       	mov    $0x2,%eax
     2ec:	cd 40                	int    $0x40
     2ee:	c3                   	ret    

000002ef <wait>:
SYSCALL(wait)
     2ef:	b8 03 00 00 00       	mov    $0x3,%eax
     2f4:	cd 40                	int    $0x40
     2f6:	c3                   	ret    

000002f7 <pipe>:
SYSCALL(pipe)
     2f7:	b8 04 00 00 00       	mov    $0x4,%eax
     2fc:	cd 40                	int    $0x40
     2fe:	c3                   	ret    

000002ff <read>:
SYSCALL(read)
     2ff:	b8 05 00 00 00       	mov    $0x5,%eax
     304:	cd 40                	int    $0x40
     306:	c3                   	ret    

00000307 <write>:
SYSCALL(write)
     307:	b8 10 00 00 00       	mov    $0x10,%eax
     30c:	cd 40                	int    $0x40
     30e:	c3                   	ret    

0000030f <close>:
SYSCALL(close)
     30f:	b8 15 00 00 00       	mov    $0x15,%eax
     314:	cd 40                	int    $0x40
     316:	c3                   	ret    

00000317 <kill>:
SYSCALL(kill)
     317:	b8 06 00 00 00       	mov    $0x6,%eax
     31c:	cd 40                	int    $0x40
     31e:	c3                   	ret    

0000031f <exec>:
SYSCALL(exec)
     31f:	b8 07 00 00 00       	mov    $0x7,%eax
     324:	cd 40                	int    $0x40
     326:	c3                   	ret    

00000327 <open>:
SYSCALL(open)
     327:	b8 0f 00 00 00       	mov    $0xf,%eax
     32c:	cd 40                	int    $0x40
     32e:	c3                   	ret    

0000032f <mknod>:
SYSCALL(mknod)
     32f:	b8 11 00 00 00       	mov    $0x11,%eax
     334:	cd 40                	int    $0x40
     336:	c3                   	ret    

00000337 <unlink>:
SYSCALL(unlink)
     337:	b8 12 00 00 00       	mov    $0x12,%eax
     33c:	cd 40                	int    $0x40
     33e:	c3                   	ret    

0000033f <fstat>:
SYSCALL(fstat)
     33f:	b8 08 00 00 00       	mov    $0x8,%eax
     344:	cd 40                	int    $0x40
     346:	c3                   	ret    

00000347 <link>:
SYSCALL(link)
     347:	b8 13 00 00 00       	mov    $0x13,%eax
     34c:	cd 40                	int    $0x40
     34e:	c3                   	ret    

0000034f <mkdir>:
SYSCALL(mkdir)
     34f:	b8 14 00 00 00       	mov    $0x14,%eax
     354:	cd 40                	int    $0x40
     356:	c3                   	ret    

00000357 <chdir>:
SYSCALL(chdir)
     357:	b8 09 00 00 00       	mov    $0x9,%eax
     35c:	cd 40                	int    $0x40
     35e:	c3                   	ret    

0000035f <dup>:
SYSCALL(dup)
     35f:	b8 0a 00 00 00       	mov    $0xa,%eax
     364:	cd 40                	int    $0x40
     366:	c3                   	ret    

00000367 <getpid>:
SYSCALL(getpid)
     367:	b8 0b 00 00 00       	mov    $0xb,%eax
     36c:	cd 40                	int    $0x40
     36e:	c3                   	ret    

0000036f <sbrk>:
SYSCALL(sbrk)
     36f:	b8 0c 00 00 00       	mov    $0xc,%eax
     374:	cd 40                	int    $0x40
     376:	c3                   	ret    

00000377 <sleep>:
SYSCALL(sleep)
     377:	b8 0d 00 00 00       	mov    $0xd,%eax
     37c:	cd 40                	int    $0x40
     37e:	c3                   	ret    

0000037f <uptime>:
SYSCALL(uptime)
     37f:	b8 0e 00 00 00       	mov    $0xe,%eax
     384:	cd 40                	int    $0x40
     386:	c3                   	ret    

00000387 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     387:	b8 16 00 00 00       	mov    $0x16,%eax
     38c:	cd 40                	int    $0x40
     38e:	c3                   	ret    

0000038f <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     38f:	b8 17 00 00 00       	mov    $0x17,%eax
     394:	cd 40                	int    $0x40
     396:	c3                   	ret    

00000397 <clearScreen>:
SYSCALL(clearScreen)
     397:	b8 18 00 00 00       	mov    $0x18,%eax
     39c:	cd 40                	int    $0x40
     39e:	c3                   	ret    

0000039f <writeAt>:
SYSCALL(writeAt)
     39f:	b8 19 00 00 00       	mov    $0x19,%eax
     3a4:	cd 40                	int    $0x40
     3a6:	c3                   	ret    

000003a7 <setBufferFlag>:
SYSCALL(setBufferFlag)
     3a7:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3ac:	cd 40                	int    $0x40
     3ae:	c3                   	ret    

000003af <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     3af:	b8 1b 00 00 00       	mov    $0x1b,%eax
     3b4:	cd 40                	int    $0x40
     3b6:	c3                   	ret    

000003b7 <getCursorPos>:
SYSCALL(getCursorPos)
     3b7:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3bc:	cd 40                	int    $0x40
     3be:	c3                   	ret    

000003bf <saveScreen>:
SYSCALL(saveScreen)
     3bf:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3c4:	cd 40                	int    $0x40
     3c6:	c3                   	ret    

000003c7 <recorverScreen>:
SYSCALL(recorverScreen)
     3c7:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3cc:	cd 40                	int    $0x40
     3ce:	c3                   	ret    

000003cf <ToScreen>:
SYSCALL(ToScreen)
     3cf:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3d4:	cd 40                	int    $0x40
     3d6:	c3                   	ret    

000003d7 <getColor>:
SYSCALL(getColor)
     3d7:	b8 20 00 00 00       	mov    $0x20,%eax
     3dc:	cd 40                	int    $0x40
     3de:	c3                   	ret    

000003df <showC>:
SYSCALL(showC)
     3df:	b8 21 00 00 00       	mov    $0x21,%eax
     3e4:	cd 40                	int    $0x40
     3e6:	c3                   	ret    

000003e7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3e7:	55                   	push   %ebp
     3e8:	89 e5                	mov    %esp,%ebp
     3ea:	83 ec 18             	sub    $0x18,%esp
     3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3f3:	83 ec 04             	sub    $0x4,%esp
     3f6:	6a 01                	push   $0x1
     3f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3fb:	50                   	push   %eax
     3fc:	ff 75 08             	pushl  0x8(%ebp)
     3ff:	e8 03 ff ff ff       	call   307 <write>
     404:	83 c4 10             	add    $0x10,%esp
}
     407:	90                   	nop
     408:	c9                   	leave  
     409:	c3                   	ret    

0000040a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     40a:	55                   	push   %ebp
     40b:	89 e5                	mov    %esp,%ebp
     40d:	53                   	push   %ebx
     40e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     411:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     418:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     41c:	74 17                	je     435 <printint+0x2b>
     41e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     422:	79 11                	jns    435 <printint+0x2b>
    neg = 1;
     424:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     42b:	8b 45 0c             	mov    0xc(%ebp),%eax
     42e:	f7 d8                	neg    %eax
     430:	89 45 ec             	mov    %eax,-0x14(%ebp)
     433:	eb 06                	jmp    43b <printint+0x31>
  } else {
    x = xx;
     435:	8b 45 0c             	mov    0xc(%ebp),%eax
     438:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     43b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     442:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     445:	8d 41 01             	lea    0x1(%ecx),%eax
     448:	89 45 f4             	mov    %eax,-0xc(%ebp)
     44b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     44e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     451:	ba 00 00 00 00       	mov    $0x0,%edx
     456:	f7 f3                	div    %ebx
     458:	89 d0                	mov    %edx,%eax
     45a:	0f b6 80 00 1a 00 00 	movzbl 0x1a00(%eax),%eax
     461:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     465:	8b 5d 10             	mov    0x10(%ebp),%ebx
     468:	8b 45 ec             	mov    -0x14(%ebp),%eax
     46b:	ba 00 00 00 00       	mov    $0x0,%edx
     470:	f7 f3                	div    %ebx
     472:	89 45 ec             	mov    %eax,-0x14(%ebp)
     475:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     479:	75 c7                	jne    442 <printint+0x38>
  if(neg)
     47b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     47f:	74 2d                	je     4ae <printint+0xa4>
    buf[i++] = '-';
     481:	8b 45 f4             	mov    -0xc(%ebp),%eax
     484:	8d 50 01             	lea    0x1(%eax),%edx
     487:	89 55 f4             	mov    %edx,-0xc(%ebp)
     48a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     48f:	eb 1d                	jmp    4ae <printint+0xa4>
    putc(fd, buf[i]);
     491:	8d 55 dc             	lea    -0x24(%ebp),%edx
     494:	8b 45 f4             	mov    -0xc(%ebp),%eax
     497:	01 d0                	add    %edx,%eax
     499:	0f b6 00             	movzbl (%eax),%eax
     49c:	0f be c0             	movsbl %al,%eax
     49f:	83 ec 08             	sub    $0x8,%esp
     4a2:	50                   	push   %eax
     4a3:	ff 75 08             	pushl  0x8(%ebp)
     4a6:	e8 3c ff ff ff       	call   3e7 <putc>
     4ab:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4ae:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4b6:	79 d9                	jns    491 <printint+0x87>
    putc(fd, buf[i]);
}
     4b8:	90                   	nop
     4b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4bc:	c9                   	leave  
     4bd:	c3                   	ret    

000004be <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4be:	55                   	push   %ebp
     4bf:	89 e5                	mov    %esp,%ebp
     4c1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4c4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4cb:	8d 45 0c             	lea    0xc(%ebp),%eax
     4ce:	83 c0 04             	add    $0x4,%eax
     4d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4db:	e9 59 01 00 00       	jmp    639 <printf+0x17b>
    c = fmt[i] & 0xff;
     4e0:	8b 55 0c             	mov    0xc(%ebp),%edx
     4e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4e6:	01 d0                	add    %edx,%eax
     4e8:	0f b6 00             	movzbl (%eax),%eax
     4eb:	0f be c0             	movsbl %al,%eax
     4ee:	25 ff 00 00 00       	and    $0xff,%eax
     4f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4fa:	75 2c                	jne    528 <printf+0x6a>
      if(c == '%'){
     4fc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     500:	75 0c                	jne    50e <printf+0x50>
        state = '%';
     502:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     509:	e9 27 01 00 00       	jmp    635 <printf+0x177>
      } else {
        putc(fd, c);
     50e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     511:	0f be c0             	movsbl %al,%eax
     514:	83 ec 08             	sub    $0x8,%esp
     517:	50                   	push   %eax
     518:	ff 75 08             	pushl  0x8(%ebp)
     51b:	e8 c7 fe ff ff       	call   3e7 <putc>
     520:	83 c4 10             	add    $0x10,%esp
     523:	e9 0d 01 00 00       	jmp    635 <printf+0x177>
      }
    } else if(state == '%'){
     528:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     52c:	0f 85 03 01 00 00    	jne    635 <printf+0x177>
      if(c == 'd'){
     532:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     536:	75 1e                	jne    556 <printf+0x98>
        printint(fd, *ap, 10, 1);
     538:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53b:	8b 00                	mov    (%eax),%eax
     53d:	6a 01                	push   $0x1
     53f:	6a 0a                	push   $0xa
     541:	50                   	push   %eax
     542:	ff 75 08             	pushl  0x8(%ebp)
     545:	e8 c0 fe ff ff       	call   40a <printint>
     54a:	83 c4 10             	add    $0x10,%esp
        ap++;
     54d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     551:	e9 d8 00 00 00       	jmp    62e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     556:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     55a:	74 06                	je     562 <printf+0xa4>
     55c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     560:	75 1e                	jne    580 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     562:	8b 45 e8             	mov    -0x18(%ebp),%eax
     565:	8b 00                	mov    (%eax),%eax
     567:	6a 00                	push   $0x0
     569:	6a 10                	push   $0x10
     56b:	50                   	push   %eax
     56c:	ff 75 08             	pushl  0x8(%ebp)
     56f:	e8 96 fe ff ff       	call   40a <printint>
     574:	83 c4 10             	add    $0x10,%esp
        ap++;
     577:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     57b:	e9 ae 00 00 00       	jmp    62e <printf+0x170>
      } else if(c == 's'){
     580:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     584:	75 43                	jne    5c9 <printf+0x10b>
        s = (char*)*ap;
     586:	8b 45 e8             	mov    -0x18(%ebp),%eax
     589:	8b 00                	mov    (%eax),%eax
     58b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     58e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     592:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     596:	75 25                	jne    5bd <printf+0xff>
          s = "(null)";
     598:	c7 45 f4 df 12 00 00 	movl   $0x12df,-0xc(%ebp)
        while(*s != 0){
     59f:	eb 1c                	jmp    5bd <printf+0xff>
          putc(fd, *s);
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 ec 08             	sub    $0x8,%esp
     5ad:	50                   	push   %eax
     5ae:	ff 75 08             	pushl  0x8(%ebp)
     5b1:	e8 31 fe ff ff       	call   3e7 <putc>
     5b6:	83 c4 10             	add    $0x10,%esp
          s++;
     5b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     5bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5c0:	0f b6 00             	movzbl (%eax),%eax
     5c3:	84 c0                	test   %al,%al
     5c5:	75 da                	jne    5a1 <printf+0xe3>
     5c7:	eb 65                	jmp    62e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     5c9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5cd:	75 1d                	jne    5ec <printf+0x12e>
        putc(fd, *ap);
     5cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d2:	8b 00                	mov    (%eax),%eax
     5d4:	0f be c0             	movsbl %al,%eax
     5d7:	83 ec 08             	sub    $0x8,%esp
     5da:	50                   	push   %eax
     5db:	ff 75 08             	pushl  0x8(%ebp)
     5de:	e8 04 fe ff ff       	call   3e7 <putc>
     5e3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5e6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ea:	eb 42                	jmp    62e <printf+0x170>
      } else if(c == '%'){
     5ec:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5f0:	75 17                	jne    609 <printf+0x14b>
        putc(fd, c);
     5f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5f5:	0f be c0             	movsbl %al,%eax
     5f8:	83 ec 08             	sub    $0x8,%esp
     5fb:	50                   	push   %eax
     5fc:	ff 75 08             	pushl  0x8(%ebp)
     5ff:	e8 e3 fd ff ff       	call   3e7 <putc>
     604:	83 c4 10             	add    $0x10,%esp
     607:	eb 25                	jmp    62e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     609:	83 ec 08             	sub    $0x8,%esp
     60c:	6a 25                	push   $0x25
     60e:	ff 75 08             	pushl  0x8(%ebp)
     611:	e8 d1 fd ff ff       	call   3e7 <putc>
     616:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     619:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     61c:	0f be c0             	movsbl %al,%eax
     61f:	83 ec 08             	sub    $0x8,%esp
     622:	50                   	push   %eax
     623:	ff 75 08             	pushl  0x8(%ebp)
     626:	e8 bc fd ff ff       	call   3e7 <putc>
     62b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     62e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     635:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     639:	8b 55 0c             	mov    0xc(%ebp),%edx
     63c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     63f:	01 d0                	add    %edx,%eax
     641:	0f b6 00             	movzbl (%eax),%eax
     644:	84 c0                	test   %al,%al
     646:	0f 85 94 fe ff ff    	jne    4e0 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     64c:	90                   	nop
     64d:	c9                   	leave  
     64e:	c3                   	ret    

0000064f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     64f:	55                   	push   %ebp
     650:	89 e5                	mov    %esp,%ebp
     652:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     655:	8b 45 08             	mov    0x8(%ebp),%eax
     658:	83 e8 08             	sub    $0x8,%eax
     65b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     65e:	a1 28 1a 00 00       	mov    0x1a28,%eax
     663:	89 45 fc             	mov    %eax,-0x4(%ebp)
     666:	eb 24                	jmp    68c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     668:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66b:	8b 00                	mov    (%eax),%eax
     66d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     670:	77 12                	ja     684 <free+0x35>
     672:	8b 45 f8             	mov    -0x8(%ebp),%eax
     675:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     678:	77 24                	ja     69e <free+0x4f>
     67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67d:	8b 00                	mov    (%eax),%eax
     67f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     682:	77 1a                	ja     69e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     684:	8b 45 fc             	mov    -0x4(%ebp),%eax
     687:	8b 00                	mov    (%eax),%eax
     689:	89 45 fc             	mov    %eax,-0x4(%ebp)
     68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     692:	76 d4                	jbe    668 <free+0x19>
     694:	8b 45 fc             	mov    -0x4(%ebp),%eax
     697:	8b 00                	mov    (%eax),%eax
     699:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     69c:	76 ca                	jbe    668 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a1:	8b 40 04             	mov    0x4(%eax),%eax
     6a4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ae:	01 c2                	add    %eax,%edx
     6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b3:	8b 00                	mov    (%eax),%eax
     6b5:	39 c2                	cmp    %eax,%edx
     6b7:	75 24                	jne    6dd <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bc:	8b 50 04             	mov    0x4(%eax),%edx
     6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c2:	8b 00                	mov    (%eax),%eax
     6c4:	8b 40 04             	mov    0x4(%eax),%eax
     6c7:	01 c2                	add    %eax,%edx
     6c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6cc:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d2:	8b 00                	mov    (%eax),%eax
     6d4:	8b 10                	mov    (%eax),%edx
     6d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d9:	89 10                	mov    %edx,(%eax)
     6db:	eb 0a                	jmp    6e7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e0:	8b 10                	mov    (%eax),%edx
     6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ea:	8b 40 04             	mov    0x4(%eax),%eax
     6ed:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f7:	01 d0                	add    %edx,%eax
     6f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6fc:	75 20                	jne    71e <free+0xcf>
    p->s.size += bp->s.size;
     6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
     701:	8b 50 04             	mov    0x4(%eax),%edx
     704:	8b 45 f8             	mov    -0x8(%ebp),%eax
     707:	8b 40 04             	mov    0x4(%eax),%eax
     70a:	01 c2                	add    %eax,%edx
     70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     712:	8b 45 f8             	mov    -0x8(%ebp),%eax
     715:	8b 10                	mov    (%eax),%edx
     717:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71a:	89 10                	mov    %edx,(%eax)
     71c:	eb 08                	jmp    726 <free+0xd7>
  } else
    p->s.ptr = bp;
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	8b 55 f8             	mov    -0x8(%ebp),%edx
     724:	89 10                	mov    %edx,(%eax)
  freep = p;
     726:	8b 45 fc             	mov    -0x4(%ebp),%eax
     729:	a3 28 1a 00 00       	mov    %eax,0x1a28
}
     72e:	90                   	nop
     72f:	c9                   	leave  
     730:	c3                   	ret    

00000731 <morecore>:

static Header*
morecore(uint nu)
{
     731:	55                   	push   %ebp
     732:	89 e5                	mov    %esp,%ebp
     734:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     737:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     73e:	77 07                	ja     747 <morecore+0x16>
    nu = 4096;
     740:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     747:	8b 45 08             	mov    0x8(%ebp),%eax
     74a:	c1 e0 03             	shl    $0x3,%eax
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	50                   	push   %eax
     751:	e8 19 fc ff ff       	call   36f <sbrk>
     756:	83 c4 10             	add    $0x10,%esp
     759:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     75c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     760:	75 07                	jne    769 <morecore+0x38>
    return 0;
     762:	b8 00 00 00 00       	mov    $0x0,%eax
     767:	eb 26                	jmp    78f <morecore+0x5e>
  hp = (Header*)p;
     769:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     772:	8b 55 08             	mov    0x8(%ebp),%edx
     775:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     778:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77b:	83 c0 08             	add    $0x8,%eax
     77e:	83 ec 0c             	sub    $0xc,%esp
     781:	50                   	push   %eax
     782:	e8 c8 fe ff ff       	call   64f <free>
     787:	83 c4 10             	add    $0x10,%esp
  return freep;
     78a:	a1 28 1a 00 00       	mov    0x1a28,%eax
}
     78f:	c9                   	leave  
     790:	c3                   	ret    

00000791 <malloc>:

void*
malloc(uint nbytes)
{
     791:	55                   	push   %ebp
     792:	89 e5                	mov    %esp,%ebp
     794:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     797:	8b 45 08             	mov    0x8(%ebp),%eax
     79a:	83 c0 07             	add    $0x7,%eax
     79d:	c1 e8 03             	shr    $0x3,%eax
     7a0:	83 c0 01             	add    $0x1,%eax
     7a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7a6:	a1 28 1a 00 00       	mov    0x1a28,%eax
     7ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7b2:	75 23                	jne    7d7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7b4:	c7 45 f0 20 1a 00 00 	movl   $0x1a20,-0x10(%ebp)
     7bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7be:	a3 28 1a 00 00       	mov    %eax,0x1a28
     7c3:	a1 28 1a 00 00       	mov    0x1a28,%eax
     7c8:	a3 20 1a 00 00       	mov    %eax,0x1a20
    base.s.size = 0;
     7cd:	c7 05 24 1a 00 00 00 	movl   $0x0,0x1a24
     7d4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7da:	8b 00                	mov    (%eax),%eax
     7dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e2:	8b 40 04             	mov    0x4(%eax),%eax
     7e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7e8:	72 4d                	jb     837 <malloc+0xa6>
      if(p->s.size == nunits)
     7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ed:	8b 40 04             	mov    0x4(%eax),%eax
     7f0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7f3:	75 0c                	jne    801 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f8:	8b 10                	mov    (%eax),%edx
     7fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fd:	89 10                	mov    %edx,(%eax)
     7ff:	eb 26                	jmp    827 <malloc+0x96>
      else {
        p->s.size -= nunits;
     801:	8b 45 f4             	mov    -0xc(%ebp),%eax
     804:	8b 40 04             	mov    0x4(%eax),%eax
     807:	2b 45 ec             	sub    -0x14(%ebp),%eax
     80a:	89 c2                	mov    %eax,%edx
     80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     812:	8b 45 f4             	mov    -0xc(%ebp),%eax
     815:	8b 40 04             	mov    0x4(%eax),%eax
     818:	c1 e0 03             	shl    $0x3,%eax
     81b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     821:	8b 55 ec             	mov    -0x14(%ebp),%edx
     824:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     827:	8b 45 f0             	mov    -0x10(%ebp),%eax
     82a:	a3 28 1a 00 00       	mov    %eax,0x1a28
      return (void*)(p + 1);
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     832:	83 c0 08             	add    $0x8,%eax
     835:	eb 3b                	jmp    872 <malloc+0xe1>
    }
    if(p == freep)
     837:	a1 28 1a 00 00       	mov    0x1a28,%eax
     83c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     83f:	75 1e                	jne    85f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     841:	83 ec 0c             	sub    $0xc,%esp
     844:	ff 75 ec             	pushl  -0x14(%ebp)
     847:	e8 e5 fe ff ff       	call   731 <morecore>
     84c:	83 c4 10             	add    $0x10,%esp
     84f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     852:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     856:	75 07                	jne    85f <malloc+0xce>
        return 0;
     858:	b8 00 00 00 00       	mov    $0x0,%eax
     85d:	eb 13                	jmp    872 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     85f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     862:	89 45 f0             	mov    %eax,-0x10(%ebp)
     865:	8b 45 f4             	mov    -0xc(%ebp),%eax
     868:	8b 00                	mov    (%eax),%eax
     86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     86d:	e9 6d ff ff ff       	jmp    7df <malloc+0x4e>
}
     872:	c9                   	leave  
     873:	c3                   	ret    

00000874 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     874:	55                   	push   %ebp
     875:	89 e5                	mov    %esp,%ebp
     877:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     87a:	83 ec 0c             	sub    $0xc,%esp
     87d:	ff 75 08             	pushl  0x8(%ebp)
     880:	e8 b0 00 00 00       	call   935 <re_compile>
     885:	83 c4 10             	add    $0x10,%esp
     888:	83 ec 04             	sub    $0x4,%esp
     88b:	ff 75 10             	pushl  0x10(%ebp)
     88e:	ff 75 0c             	pushl  0xc(%ebp)
     891:	50                   	push   %eax
     892:	e8 05 00 00 00       	call   89c <re_matchp>
     897:	83 c4 10             	add    $0x10,%esp
}
     89a:	c9                   	leave  
     89b:	c3                   	ret    

0000089c <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     89c:	55                   	push   %ebp
     89d:	89 e5                	mov    %esp,%ebp
     89f:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     8a2:	8b 45 10             	mov    0x10(%ebp),%eax
     8a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     8ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     8af:	74 7d                	je     92e <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	0f b6 00             	movzbl (%eax),%eax
     8b7:	3c 02                	cmp    $0x2,%al
     8b9:	75 2a                	jne    8e5 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     8bb:	8b 45 08             	mov    0x8(%ebp),%eax
     8be:	83 c0 08             	add    $0x8,%eax
     8c1:	83 ec 04             	sub    $0x4,%esp
     8c4:	ff 75 10             	pushl  0x10(%ebp)
     8c7:	ff 75 0c             	pushl  0xc(%ebp)
     8ca:	50                   	push   %eax
     8cb:	e8 b0 08 00 00       	call   1180 <matchpattern>
     8d0:	83 c4 10             	add    $0x10,%esp
     8d3:	85 c0                	test   %eax,%eax
     8d5:	74 07                	je     8de <re_matchp+0x42>
     8d7:	b8 00 00 00 00       	mov    $0x0,%eax
     8dc:	eb 55                	jmp    933 <re_matchp+0x97>
     8de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8e3:	eb 4e                	jmp    933 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     8e5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     8ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     8f0:	83 ec 04             	sub    $0x4,%esp
     8f3:	ff 75 10             	pushl  0x10(%ebp)
     8f6:	ff 75 0c             	pushl  0xc(%ebp)
     8f9:	ff 75 08             	pushl  0x8(%ebp)
     8fc:	e8 7f 08 00 00       	call   1180 <matchpattern>
     901:	83 c4 10             	add    $0x10,%esp
     904:	85 c0                	test   %eax,%eax
     906:	74 16                	je     91e <re_matchp+0x82>
        {
          if (text[0] == '\0')
     908:	8b 45 0c             	mov    0xc(%ebp),%eax
     90b:	0f b6 00             	movzbl (%eax),%eax
     90e:	84 c0                	test   %al,%al
     910:	75 07                	jne    919 <re_matchp+0x7d>
            return -1;
     912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     917:	eb 1a                	jmp    933 <re_matchp+0x97>
        
          return idx;
     919:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91c:	eb 15                	jmp    933 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     91e:	8b 45 0c             	mov    0xc(%ebp),%eax
     921:	8d 50 01             	lea    0x1(%eax),%edx
     924:	89 55 0c             	mov    %edx,0xc(%ebp)
     927:	0f b6 00             	movzbl (%eax),%eax
     92a:	84 c0                	test   %al,%al
     92c:	75 be                	jne    8ec <re_matchp+0x50>
    }
  }
  return -1;
     92e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     933:	c9                   	leave  
     934:	c3                   	ret    

00000935 <re_compile>:

re_t re_compile(const char* pattern)
{
     935:	55                   	push   %ebp
     936:	89 e5                	mov    %esp,%ebp
     938:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     93b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     942:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     949:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     950:	e9 55 02 00 00       	jmp    baa <re_compile+0x275>
  {
    c = pattern[i];
     955:	8b 55 f8             	mov    -0x8(%ebp),%edx
     958:	8b 45 08             	mov    0x8(%ebp),%eax
     95b:	01 d0                	add    %edx,%eax
     95d:	0f b6 00             	movzbl (%eax),%eax
     960:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     963:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     967:	83 e8 24             	sub    $0x24,%eax
     96a:	83 f8 3a             	cmp    $0x3a,%eax
     96d:	0f 87 13 02 00 00    	ja     b86 <re_compile+0x251>
     973:	8b 04 85 e8 12 00 00 	mov    0x12e8(,%eax,4),%eax
     97a:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     97c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97f:	c6 04 c5 40 1a 00 00 	movb   $0x2,0x1a40(,%eax,8)
     986:	02 
     987:	e9 16 02 00 00       	jmp    ba2 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     98c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98f:	c6 04 c5 40 1a 00 00 	movb   $0x3,0x1a40(,%eax,8)
     996:	03 
     997:	e9 06 02 00 00       	jmp    ba2 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     99c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99f:	c6 04 c5 40 1a 00 00 	movb   $0x1,0x1a40(,%eax,8)
     9a6:	01 
     9a7:	e9 f6 01 00 00       	jmp    ba2 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     9ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9af:	c6 04 c5 40 1a 00 00 	movb   $0x5,0x1a40(,%eax,8)
     9b6:	05 
     9b7:	e9 e6 01 00 00       	jmp    ba2 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     9bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9bf:	c6 04 c5 40 1a 00 00 	movb   $0x6,0x1a40(,%eax,8)
     9c6:	06 
     9c7:	e9 d6 01 00 00       	jmp    ba2 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     9cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9cf:	c6 04 c5 40 1a 00 00 	movb   $0x4,0x1a40(,%eax,8)
     9d6:	04 
     9d7:	e9 c6 01 00 00       	jmp    ba2 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     9dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9df:	8d 50 01             	lea    0x1(%eax),%edx
     9e2:	8b 45 08             	mov    0x8(%ebp),%eax
     9e5:	01 d0                	add    %edx,%eax
     9e7:	0f b6 00             	movzbl (%eax),%eax
     9ea:	84 c0                	test   %al,%al
     9ec:	0f 84 af 01 00 00    	je     ba1 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     9f2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     9f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9f9:	8b 45 08             	mov    0x8(%ebp),%eax
     9fc:	01 d0                	add    %edx,%eax
     9fe:	0f b6 00             	movzbl (%eax),%eax
     a01:	0f be c0             	movsbl %al,%eax
     a04:	83 e8 44             	sub    $0x44,%eax
     a07:	83 f8 33             	cmp    $0x33,%eax
     a0a:	77 57                	ja     a63 <re_compile+0x12e>
     a0c:	8b 04 85 d4 13 00 00 	mov    0x13d4(,%eax,4),%eax
     a13:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a18:	c6 04 c5 40 1a 00 00 	movb   $0xa,0x1a40(,%eax,8)
     a1f:	0a 
     a20:	eb 64                	jmp    a86 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a25:	c6 04 c5 40 1a 00 00 	movb   $0xb,0x1a40(,%eax,8)
     a2c:	0b 
     a2d:	eb 57                	jmp    a86 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a32:	c6 04 c5 40 1a 00 00 	movb   $0xc,0x1a40(,%eax,8)
     a39:	0c 
     a3a:	eb 4a                	jmp    a86 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3f:	c6 04 c5 40 1a 00 00 	movb   $0xd,0x1a40(,%eax,8)
     a46:	0d 
     a47:	eb 3d                	jmp    a86 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4c:	c6 04 c5 40 1a 00 00 	movb   $0xe,0x1a40(,%eax,8)
     a53:	0e 
     a54:	eb 30                	jmp    a86 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a59:	c6 04 c5 40 1a 00 00 	movb   $0xf,0x1a40(,%eax,8)
     a60:	0f 
     a61:	eb 23                	jmp    a86 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a66:	c6 04 c5 40 1a 00 00 	movb   $0x7,0x1a40(,%eax,8)
     a6d:	07 
              re_compiled[j].ch = pattern[i];
     a6e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a71:	8b 45 08             	mov    0x8(%ebp),%eax
     a74:	01 d0                	add    %edx,%eax
     a76:	0f b6 00             	movzbl (%eax),%eax
     a79:	89 c2                	mov    %eax,%edx
     a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7e:	88 14 c5 44 1a 00 00 	mov    %dl,0x1a44(,%eax,8)
            } break;
     a85:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a86:	e9 16 01 00 00       	jmp    ba1 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a8e:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a91:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a94:	8d 50 01             	lea    0x1(%eax),%edx
     a97:	8b 45 08             	mov    0x8(%ebp),%eax
     a9a:	01 d0                	add    %edx,%eax
     a9c:	0f b6 00             	movzbl (%eax),%eax
     a9f:	3c 5e                	cmp    $0x5e,%al
     aa1:	75 11                	jne    ab4 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa6:	c6 04 c5 40 1a 00 00 	movb   $0x9,0x1a40(,%eax,8)
     aad:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     aae:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ab2:	eb 7a                	jmp    b2e <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab7:	c6 04 c5 40 1a 00 00 	movb   $0x8,0x1a40(,%eax,8)
     abe:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     abf:	eb 6d                	jmp    b2e <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     ac1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	01 d0                	add    %edx,%eax
     ac9:	0f b6 00             	movzbl (%eax),%eax
     acc:	3c 5c                	cmp    $0x5c,%al
     ace:	75 34                	jne    b04 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     ad0:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     ad4:	7e 0a                	jle    ae0 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     ad6:	b8 00 00 00 00       	mov    $0x0,%eax
     adb:	e9 f8 00 00 00       	jmp    bd8 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ae0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ae3:	8d 50 01             	lea    0x1(%eax),%edx
     ae6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ae9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     aec:	8d 4a 01             	lea    0x1(%edx),%ecx
     aef:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     af2:	89 d1                	mov    %edx,%ecx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
     af7:	01 ca                	add    %ecx,%edx
     af9:	0f b6 12             	movzbl (%edx),%edx
     afc:	88 90 40 1b 00 00    	mov    %dl,0x1b40(%eax)
     b02:	eb 10                	jmp    b14 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b04:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b08:	7e 0a                	jle    b14 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b0a:	b8 00 00 00 00       	mov    $0x0,%eax
     b0f:	e9 c4 00 00 00       	jmp    bd8 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     b14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b17:	8d 50 01             	lea    0x1(%eax),%edx
     b1a:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b1d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     b20:	8b 55 08             	mov    0x8(%ebp),%edx
     b23:	01 ca                	add    %ecx,%edx
     b25:	0f b6 12             	movzbl (%edx),%edx
     b28:	88 90 40 1b 00 00    	mov    %dl,0x1b40(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b2e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b32:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b35:	8b 45 08             	mov    0x8(%ebp),%eax
     b38:	01 d0                	add    %edx,%eax
     b3a:	0f b6 00             	movzbl (%eax),%eax
     b3d:	3c 5d                	cmp    $0x5d,%al
     b3f:	74 13                	je     b54 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     b41:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b44:	8b 45 08             	mov    0x8(%ebp),%eax
     b47:	01 d0                	add    %edx,%eax
     b49:	0f b6 00             	movzbl (%eax),%eax
     b4c:	84 c0                	test   %al,%al
     b4e:	0f 85 6d ff ff ff    	jne    ac1 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b54:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b58:	7e 07                	jle    b61 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     b5a:	b8 00 00 00 00       	mov    $0x0,%eax
     b5f:	eb 77                	jmp    bd8 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b64:	8d 50 01             	lea    0x1(%eax),%edx
     b67:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b6a:	c6 80 40 1b 00 00 00 	movb   $0x0,0x1b40(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b71:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b74:	8d 90 40 1b 00 00    	lea    0x1b40(%eax),%edx
     b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7d:	89 14 c5 44 1a 00 00 	mov    %edx,0x1a44(,%eax,8)
      } break;
     b84:	eb 1c                	jmp    ba2 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b89:	c6 04 c5 40 1a 00 00 	movb   $0x7,0x1a40(,%eax,8)
     b90:	07 
        re_compiled[j].ch = c;
     b91:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b98:	88 14 c5 44 1a 00 00 	mov    %dl,0x1a44(,%eax,8)
      } break;
     b9f:	eb 01                	jmp    ba2 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     ba1:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     ba2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     ba6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     baa:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bad:	8b 45 08             	mov    0x8(%ebp),%eax
     bb0:	01 d0                	add    %edx,%eax
     bb2:	0f b6 00             	movzbl (%eax),%eax
     bb5:	84 c0                	test   %al,%al
     bb7:	74 0f                	je     bc8 <re_compile+0x293>
     bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbc:	83 c0 01             	add    $0x1,%eax
     bbf:	83 f8 1d             	cmp    $0x1d,%eax
     bc2:	0f 8e 8d fd ff ff    	jle    955 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcb:	c6 04 c5 40 1a 00 00 	movb   $0x0,0x1a40(,%eax,8)
     bd2:	00 

  return (re_t) re_compiled;
     bd3:	b8 40 1a 00 00       	mov    $0x1a40,%eax
}
     bd8:	c9                   	leave  
     bd9:	c3                   	ret    

00000bda <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     bda:	55                   	push   %ebp
     bdb:	89 e5                	mov    %esp,%ebp
     bdd:	83 ec 04             	sub    $0x4,%esp
     be0:	8b 45 08             	mov    0x8(%ebp),%eax
     be3:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     be6:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     bea:	7e 0d                	jle    bf9 <matchdigit+0x1f>
     bec:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     bf0:	7f 07                	jg     bf9 <matchdigit+0x1f>
     bf2:	b8 01 00 00 00       	mov    $0x1,%eax
     bf7:	eb 05                	jmp    bfe <matchdigit+0x24>
     bf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bfe:	c9                   	leave  
     bff:	c3                   	ret    

00000c00 <matchalpha>:
static int matchalpha(char c)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 04             	sub    $0x4,%esp
     c06:	8b 45 08             	mov    0x8(%ebp),%eax
     c09:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     c0c:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     c10:	7e 06                	jle    c18 <matchalpha+0x18>
     c12:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     c16:	7e 0c                	jle    c24 <matchalpha+0x24>
     c18:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     c1c:	7e 0d                	jle    c2b <matchalpha+0x2b>
     c1e:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     c22:	7f 07                	jg     c2b <matchalpha+0x2b>
     c24:	b8 01 00 00 00       	mov    $0x1,%eax
     c29:	eb 05                	jmp    c30 <matchalpha+0x30>
     c2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c30:	c9                   	leave  
     c31:	c3                   	ret    

00000c32 <matchwhitespace>:
static int matchwhitespace(char c)
{
     c32:	55                   	push   %ebp
     c33:	89 e5                	mov    %esp,%ebp
     c35:	83 ec 04             	sub    $0x4,%esp
     c38:	8b 45 08             	mov    0x8(%ebp),%eax
     c3b:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     c3e:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     c42:	74 1e                	je     c62 <matchwhitespace+0x30>
     c44:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     c48:	74 18                	je     c62 <matchwhitespace+0x30>
     c4a:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     c4e:	74 12                	je     c62 <matchwhitespace+0x30>
     c50:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     c54:	74 0c                	je     c62 <matchwhitespace+0x30>
     c56:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     c5a:	74 06                	je     c62 <matchwhitespace+0x30>
     c5c:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     c60:	75 07                	jne    c69 <matchwhitespace+0x37>
     c62:	b8 01 00 00 00       	mov    $0x1,%eax
     c67:	eb 05                	jmp    c6e <matchwhitespace+0x3c>
     c69:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c6e:	c9                   	leave  
     c6f:	c3                   	ret    

00000c70 <matchalphanum>:
static int matchalphanum(char c)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	83 ec 04             	sub    $0x4,%esp
     c76:	8b 45 08             	mov    0x8(%ebp),%eax
     c79:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c7c:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c80:	74 22                	je     ca4 <matchalphanum+0x34>
     c82:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c86:	50                   	push   %eax
     c87:	e8 74 ff ff ff       	call   c00 <matchalpha>
     c8c:	83 c4 04             	add    $0x4,%esp
     c8f:	85 c0                	test   %eax,%eax
     c91:	75 11                	jne    ca4 <matchalphanum+0x34>
     c93:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c97:	50                   	push   %eax
     c98:	e8 3d ff ff ff       	call   bda <matchdigit>
     c9d:	83 c4 04             	add    $0x4,%esp
     ca0:	85 c0                	test   %eax,%eax
     ca2:	74 07                	je     cab <matchalphanum+0x3b>
     ca4:	b8 01 00 00 00       	mov    $0x1,%eax
     ca9:	eb 05                	jmp    cb0 <matchalphanum+0x40>
     cab:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cb0:	c9                   	leave  
     cb1:	c3                   	ret    

00000cb2 <matchrange>:
static int matchrange(char c, const char* str)
{
     cb2:	55                   	push   %ebp
     cb3:	89 e5                	mov    %esp,%ebp
     cb5:	83 ec 04             	sub    $0x4,%esp
     cb8:	8b 45 08             	mov    0x8(%ebp),%eax
     cbb:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cbe:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     cc2:	74 5b                	je     d1f <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc7:	0f b6 00             	movzbl (%eax),%eax
     cca:	84 c0                	test   %al,%al
     ccc:	74 51                	je     d1f <matchrange+0x6d>
     cce:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd1:	0f b6 00             	movzbl (%eax),%eax
     cd4:	3c 2d                	cmp    $0x2d,%al
     cd6:	74 47                	je     d1f <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cd8:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdb:	83 c0 01             	add    $0x1,%eax
     cde:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     ce1:	3c 2d                	cmp    $0x2d,%al
     ce3:	75 3a                	jne    d1f <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce8:	83 c0 01             	add    $0x1,%eax
     ceb:	0f b6 00             	movzbl (%eax),%eax
     cee:	84 c0                	test   %al,%al
     cf0:	74 2d                	je     d1f <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf5:	83 c0 02             	add    $0x2,%eax
     cf8:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     cfb:	84 c0                	test   %al,%al
     cfd:	74 20                	je     d1f <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cff:	8b 45 0c             	mov    0xc(%ebp),%eax
     d02:	0f b6 00             	movzbl (%eax),%eax
     d05:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d08:	7f 15                	jg     d1f <matchrange+0x6d>
     d0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0d:	83 c0 02             	add    $0x2,%eax
     d10:	0f b6 00             	movzbl (%eax),%eax
     d13:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d16:	7c 07                	jl     d1f <matchrange+0x6d>
     d18:	b8 01 00 00 00       	mov    $0x1,%eax
     d1d:	eb 05                	jmp    d24 <matchrange+0x72>
     d1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d24:	c9                   	leave  
     d25:	c3                   	ret    

00000d26 <ismetachar>:
static int ismetachar(char c)
{
     d26:	55                   	push   %ebp
     d27:	89 e5                	mov    %esp,%ebp
     d29:	83 ec 04             	sub    $0x4,%esp
     d2c:	8b 45 08             	mov    0x8(%ebp),%eax
     d2f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     d32:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     d36:	74 1e                	je     d56 <ismetachar+0x30>
     d38:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     d3c:	74 18                	je     d56 <ismetachar+0x30>
     d3e:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     d42:	74 12                	je     d56 <ismetachar+0x30>
     d44:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     d48:	74 0c                	je     d56 <ismetachar+0x30>
     d4a:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     d4e:	74 06                	je     d56 <ismetachar+0x30>
     d50:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     d54:	75 07                	jne    d5d <ismetachar+0x37>
     d56:	b8 01 00 00 00       	mov    $0x1,%eax
     d5b:	eb 05                	jmp    d62 <ismetachar+0x3c>
     d5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d62:	c9                   	leave  
     d63:	c3                   	ret    

00000d64 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	83 ec 04             	sub    $0x4,%esp
     d6a:	8b 45 08             	mov    0x8(%ebp),%eax
     d6d:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d70:	8b 45 0c             	mov    0xc(%ebp),%eax
     d73:	0f b6 00             	movzbl (%eax),%eax
     d76:	0f be c0             	movsbl %al,%eax
     d79:	83 e8 44             	sub    $0x44,%eax
     d7c:	83 f8 33             	cmp    $0x33,%eax
     d7f:	77 7b                	ja     dfc <matchmetachar+0x98>
     d81:	8b 04 85 a4 14 00 00 	mov    0x14a4(,%eax,4),%eax
     d88:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d8a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d8e:	50                   	push   %eax
     d8f:	e8 46 fe ff ff       	call   bda <matchdigit>
     d94:	83 c4 04             	add    $0x4,%esp
     d97:	eb 72                	jmp    e0b <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d99:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d9d:	50                   	push   %eax
     d9e:	e8 37 fe ff ff       	call   bda <matchdigit>
     da3:	83 c4 04             	add    $0x4,%esp
     da6:	85 c0                	test   %eax,%eax
     da8:	0f 94 c0             	sete   %al
     dab:	0f b6 c0             	movzbl %al,%eax
     dae:	eb 5b                	jmp    e0b <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     db0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     db4:	50                   	push   %eax
     db5:	e8 b6 fe ff ff       	call   c70 <matchalphanum>
     dba:	83 c4 04             	add    $0x4,%esp
     dbd:	eb 4c                	jmp    e0b <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     dbf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dc3:	50                   	push   %eax
     dc4:	e8 a7 fe ff ff       	call   c70 <matchalphanum>
     dc9:	83 c4 04             	add    $0x4,%esp
     dcc:	85 c0                	test   %eax,%eax
     dce:	0f 94 c0             	sete   %al
     dd1:	0f b6 c0             	movzbl %al,%eax
     dd4:	eb 35                	jmp    e0b <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     dd6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dda:	50                   	push   %eax
     ddb:	e8 52 fe ff ff       	call   c32 <matchwhitespace>
     de0:	83 c4 04             	add    $0x4,%esp
     de3:	eb 26                	jmp    e0b <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     de5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     de9:	50                   	push   %eax
     dea:	e8 43 fe ff ff       	call   c32 <matchwhitespace>
     def:	83 c4 04             	add    $0x4,%esp
     df2:	85 c0                	test   %eax,%eax
     df4:	0f 94 c0             	sete   %al
     df7:	0f b6 c0             	movzbl %al,%eax
     dfa:	eb 0f                	jmp    e0b <matchmetachar+0xa7>
    default:  return (c == str[0]);
     dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dff:	0f b6 00             	movzbl (%eax),%eax
     e02:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e05:	0f 94 c0             	sete   %al
     e08:	0f b6 c0             	movzbl %al,%eax
  }
}
     e0b:	c9                   	leave  
     e0c:	c3                   	ret    

00000e0d <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     e0d:	55                   	push   %ebp
     e0e:	89 e5                	mov    %esp,%ebp
     e10:	83 ec 04             	sub    $0x4,%esp
     e13:	8b 45 08             	mov    0x8(%ebp),%eax
     e16:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     e19:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e1d:	ff 75 0c             	pushl  0xc(%ebp)
     e20:	50                   	push   %eax
     e21:	e8 8c fe ff ff       	call   cb2 <matchrange>
     e26:	83 c4 08             	add    $0x8,%esp
     e29:	85 c0                	test   %eax,%eax
     e2b:	74 0a                	je     e37 <matchcharclass+0x2a>
    {
      return 1;
     e2d:	b8 01 00 00 00       	mov    $0x1,%eax
     e32:	e9 a5 00 00 00       	jmp    edc <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     e37:	8b 45 0c             	mov    0xc(%ebp),%eax
     e3a:	0f b6 00             	movzbl (%eax),%eax
     e3d:	3c 5c                	cmp    $0x5c,%al
     e3f:	75 42                	jne    e83 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     e41:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     e45:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e49:	ff 75 0c             	pushl  0xc(%ebp)
     e4c:	50                   	push   %eax
     e4d:	e8 12 ff ff ff       	call   d64 <matchmetachar>
     e52:	83 c4 08             	add    $0x8,%esp
     e55:	85 c0                	test   %eax,%eax
     e57:	74 07                	je     e60 <matchcharclass+0x53>
      {
        return 1;
     e59:	b8 01 00 00 00       	mov    $0x1,%eax
     e5e:	eb 7c                	jmp    edc <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     e60:	8b 45 0c             	mov    0xc(%ebp),%eax
     e63:	0f b6 00             	movzbl (%eax),%eax
     e66:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e69:	75 58                	jne    ec3 <matchcharclass+0xb6>
     e6b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e6f:	50                   	push   %eax
     e70:	e8 b1 fe ff ff       	call   d26 <ismetachar>
     e75:	83 c4 04             	add    $0x4,%esp
     e78:	85 c0                	test   %eax,%eax
     e7a:	75 47                	jne    ec3 <matchcharclass+0xb6>
      {
        return 1;
     e7c:	b8 01 00 00 00       	mov    $0x1,%eax
     e81:	eb 59                	jmp    edc <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e83:	8b 45 0c             	mov    0xc(%ebp),%eax
     e86:	0f b6 00             	movzbl (%eax),%eax
     e89:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e8c:	75 35                	jne    ec3 <matchcharclass+0xb6>
    {
      if (c == '-')
     e8e:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e92:	75 28                	jne    ebc <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e94:	8b 45 0c             	mov    0xc(%ebp),%eax
     e97:	83 e8 01             	sub    $0x1,%eax
     e9a:	0f b6 00             	movzbl (%eax),%eax
     e9d:	84 c0                	test   %al,%al
     e9f:	74 0d                	je     eae <matchcharclass+0xa1>
     ea1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea4:	83 c0 01             	add    $0x1,%eax
     ea7:	0f b6 00             	movzbl (%eax),%eax
     eaa:	84 c0                	test   %al,%al
     eac:	75 07                	jne    eb5 <matchcharclass+0xa8>
     eae:	b8 01 00 00 00       	mov    $0x1,%eax
     eb3:	eb 27                	jmp    edc <matchcharclass+0xcf>
     eb5:	b8 00 00 00 00       	mov    $0x0,%eax
     eba:	eb 20                	jmp    edc <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     ebc:	b8 01 00 00 00       	mov    $0x1,%eax
     ec1:	eb 19                	jmp    edc <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec6:	8d 50 01             	lea    0x1(%eax),%edx
     ec9:	89 55 0c             	mov    %edx,0xc(%ebp)
     ecc:	0f b6 00             	movzbl (%eax),%eax
     ecf:	84 c0                	test   %al,%al
     ed1:	0f 85 42 ff ff ff    	jne    e19 <matchcharclass+0xc>

  return 0;
     ed7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     edc:	c9                   	leave  
     edd:	c3                   	ret    

00000ede <matchone>:

static int matchone(regex_t p, char c)
{
     ede:	55                   	push   %ebp
     edf:	89 e5                	mov    %esp,%ebp
     ee1:	83 ec 04             	sub    $0x4,%esp
     ee4:	8b 45 10             	mov    0x10(%ebp),%eax
     ee7:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     eea:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     eee:	0f b6 c0             	movzbl %al,%eax
     ef1:	83 f8 0f             	cmp    $0xf,%eax
     ef4:	0f 87 b9 00 00 00    	ja     fb3 <matchone+0xd5>
     efa:	8b 04 85 74 15 00 00 	mov    0x1574(,%eax,4),%eax
     f01:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     f03:	b8 01 00 00 00       	mov    $0x1,%eax
     f08:	e9 b9 00 00 00       	jmp    fc6 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     f0d:	8b 55 0c             	mov    0xc(%ebp),%edx
     f10:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f14:	52                   	push   %edx
     f15:	50                   	push   %eax
     f16:	e8 f2 fe ff ff       	call   e0d <matchcharclass>
     f1b:	83 c4 08             	add    $0x8,%esp
     f1e:	e9 a3 00 00 00       	jmp    fc6 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     f23:	8b 55 0c             	mov    0xc(%ebp),%edx
     f26:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f2a:	52                   	push   %edx
     f2b:	50                   	push   %eax
     f2c:	e8 dc fe ff ff       	call   e0d <matchcharclass>
     f31:	83 c4 08             	add    $0x8,%esp
     f34:	85 c0                	test   %eax,%eax
     f36:	0f 94 c0             	sete   %al
     f39:	0f b6 c0             	movzbl %al,%eax
     f3c:	e9 85 00 00 00       	jmp    fc6 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     f41:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f45:	50                   	push   %eax
     f46:	e8 8f fc ff ff       	call   bda <matchdigit>
     f4b:	83 c4 04             	add    $0x4,%esp
     f4e:	eb 76                	jmp    fc6 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     f50:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f54:	50                   	push   %eax
     f55:	e8 80 fc ff ff       	call   bda <matchdigit>
     f5a:	83 c4 04             	add    $0x4,%esp
     f5d:	85 c0                	test   %eax,%eax
     f5f:	0f 94 c0             	sete   %al
     f62:	0f b6 c0             	movzbl %al,%eax
     f65:	eb 5f                	jmp    fc6 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f67:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f6b:	50                   	push   %eax
     f6c:	e8 ff fc ff ff       	call   c70 <matchalphanum>
     f71:	83 c4 04             	add    $0x4,%esp
     f74:	eb 50                	jmp    fc6 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f76:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f7a:	50                   	push   %eax
     f7b:	e8 f0 fc ff ff       	call   c70 <matchalphanum>
     f80:	83 c4 04             	add    $0x4,%esp
     f83:	85 c0                	test   %eax,%eax
     f85:	0f 94 c0             	sete   %al
     f88:	0f b6 c0             	movzbl %al,%eax
     f8b:	eb 39                	jmp    fc6 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f8d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f91:	50                   	push   %eax
     f92:	e8 9b fc ff ff       	call   c32 <matchwhitespace>
     f97:	83 c4 04             	add    $0x4,%esp
     f9a:	eb 2a                	jmp    fc6 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f9c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fa0:	50                   	push   %eax
     fa1:	e8 8c fc ff ff       	call   c32 <matchwhitespace>
     fa6:	83 c4 04             	add    $0x4,%esp
     fa9:	85 c0                	test   %eax,%eax
     fab:	0f 94 c0             	sete   %al
     fae:	0f b6 c0             	movzbl %al,%eax
     fb1:	eb 13                	jmp    fc6 <matchone+0xe8>
    default:             return  (p.ch == c);
     fb3:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     fb7:	0f b6 d0             	movzbl %al,%edx
     fba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fbe:	39 c2                	cmp    %eax,%edx
     fc0:	0f 94 c0             	sete   %al
     fc3:	0f b6 c0             	movzbl %al,%eax
  }
}
     fc6:	c9                   	leave  
     fc7:	c3                   	ret    

00000fc8 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     fc8:	55                   	push   %ebp
     fc9:	89 e5                	mov    %esp,%ebp
     fcb:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     fce:	8b 45 18             	mov    0x18(%ebp),%eax
     fd1:	8b 00                	mov    (%eax),%eax
     fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     fd6:	8b 45 14             	mov    0x14(%ebp),%eax
     fd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     fdc:	eb 11                	jmp    fef <matchstar+0x27>
  {
    text++;
     fde:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     fe2:	8b 45 18             	mov    0x18(%ebp),%eax
     fe5:	8b 00                	mov    (%eax),%eax
     fe7:	8d 50 01             	lea    0x1(%eax),%edx
     fea:	8b 45 18             	mov    0x18(%ebp),%eax
     fed:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     fef:	8b 45 14             	mov    0x14(%ebp),%eax
     ff2:	0f b6 00             	movzbl (%eax),%eax
     ff5:	84 c0                	test   %al,%al
     ff7:	74 51                	je     104a <matchstar+0x82>
     ff9:	8b 45 14             	mov    0x14(%ebp),%eax
     ffc:	0f b6 00             	movzbl (%eax),%eax
     fff:	0f be c0             	movsbl %al,%eax
    1002:	50                   	push   %eax
    1003:	ff 75 0c             	pushl  0xc(%ebp)
    1006:	ff 75 08             	pushl  0x8(%ebp)
    1009:	e8 d0 fe ff ff       	call   ede <matchone>
    100e:	83 c4 0c             	add    $0xc,%esp
    1011:	85 c0                	test   %eax,%eax
    1013:	75 c9                	jne    fde <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1015:	eb 33                	jmp    104a <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    1017:	8b 45 14             	mov    0x14(%ebp),%eax
    101a:	8d 50 ff             	lea    -0x1(%eax),%edx
    101d:	89 55 14             	mov    %edx,0x14(%ebp)
    1020:	83 ec 04             	sub    $0x4,%esp
    1023:	ff 75 18             	pushl  0x18(%ebp)
    1026:	50                   	push   %eax
    1027:	ff 75 10             	pushl  0x10(%ebp)
    102a:	e8 51 01 00 00       	call   1180 <matchpattern>
    102f:	83 c4 10             	add    $0x10,%esp
    1032:	85 c0                	test   %eax,%eax
    1034:	74 07                	je     103d <matchstar+0x75>
      return 1;
    1036:	b8 01 00 00 00       	mov    $0x1,%eax
    103b:	eb 22                	jmp    105f <matchstar+0x97>
    (*matchlength)--;
    103d:	8b 45 18             	mov    0x18(%ebp),%eax
    1040:	8b 00                	mov    (%eax),%eax
    1042:	8d 50 ff             	lea    -0x1(%eax),%edx
    1045:	8b 45 18             	mov    0x18(%ebp),%eax
    1048:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    104a:	8b 45 14             	mov    0x14(%ebp),%eax
    104d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1050:	73 c5                	jae    1017 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1052:	8b 45 18             	mov    0x18(%ebp),%eax
    1055:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1058:	89 10                	mov    %edx,(%eax)
  return 0;
    105a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    105f:	c9                   	leave  
    1060:	c3                   	ret    

00001061 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1061:	55                   	push   %ebp
    1062:	89 e5                	mov    %esp,%ebp
    1064:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1067:	8b 45 14             	mov    0x14(%ebp),%eax
    106a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    106d:	eb 11                	jmp    1080 <matchplus+0x1f>
  {
    text++;
    106f:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1073:	8b 45 18             	mov    0x18(%ebp),%eax
    1076:	8b 00                	mov    (%eax),%eax
    1078:	8d 50 01             	lea    0x1(%eax),%edx
    107b:	8b 45 18             	mov    0x18(%ebp),%eax
    107e:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1080:	8b 45 14             	mov    0x14(%ebp),%eax
    1083:	0f b6 00             	movzbl (%eax),%eax
    1086:	84 c0                	test   %al,%al
    1088:	74 51                	je     10db <matchplus+0x7a>
    108a:	8b 45 14             	mov    0x14(%ebp),%eax
    108d:	0f b6 00             	movzbl (%eax),%eax
    1090:	0f be c0             	movsbl %al,%eax
    1093:	50                   	push   %eax
    1094:	ff 75 0c             	pushl  0xc(%ebp)
    1097:	ff 75 08             	pushl  0x8(%ebp)
    109a:	e8 3f fe ff ff       	call   ede <matchone>
    109f:	83 c4 0c             	add    $0xc,%esp
    10a2:	85 c0                	test   %eax,%eax
    10a4:	75 c9                	jne    106f <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10a6:	eb 33                	jmp    10db <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    10a8:	8b 45 14             	mov    0x14(%ebp),%eax
    10ab:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ae:	89 55 14             	mov    %edx,0x14(%ebp)
    10b1:	83 ec 04             	sub    $0x4,%esp
    10b4:	ff 75 18             	pushl  0x18(%ebp)
    10b7:	50                   	push   %eax
    10b8:	ff 75 10             	pushl  0x10(%ebp)
    10bb:	e8 c0 00 00 00       	call   1180 <matchpattern>
    10c0:	83 c4 10             	add    $0x10,%esp
    10c3:	85 c0                	test   %eax,%eax
    10c5:	74 07                	je     10ce <matchplus+0x6d>
      return 1;
    10c7:	b8 01 00 00 00       	mov    $0x1,%eax
    10cc:	eb 1a                	jmp    10e8 <matchplus+0x87>
    (*matchlength)--;
    10ce:	8b 45 18             	mov    0x18(%ebp),%eax
    10d1:	8b 00                	mov    (%eax),%eax
    10d3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10d6:	8b 45 18             	mov    0x18(%ebp),%eax
    10d9:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10db:	8b 45 14             	mov    0x14(%ebp),%eax
    10de:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10e1:	77 c5                	ja     10a8 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    10e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10e8:	c9                   	leave  
    10e9:	c3                   	ret    

000010ea <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10ea:	55                   	push   %ebp
    10eb:	89 e5                	mov    %esp,%ebp
    10ed:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    10f0:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10f4:	84 c0                	test   %al,%al
    10f6:	75 07                	jne    10ff <matchquestion+0x15>
    return 1;
    10f8:	b8 01 00 00 00       	mov    $0x1,%eax
    10fd:	eb 7f                	jmp    117e <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    10ff:	83 ec 04             	sub    $0x4,%esp
    1102:	ff 75 18             	pushl  0x18(%ebp)
    1105:	ff 75 14             	pushl  0x14(%ebp)
    1108:	ff 75 10             	pushl  0x10(%ebp)
    110b:	e8 70 00 00 00       	call   1180 <matchpattern>
    1110:	83 c4 10             	add    $0x10,%esp
    1113:	85 c0                	test   %eax,%eax
    1115:	74 07                	je     111e <matchquestion+0x34>
      return 1;
    1117:	b8 01 00 00 00       	mov    $0x1,%eax
    111c:	eb 60                	jmp    117e <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    111e:	8b 45 14             	mov    0x14(%ebp),%eax
    1121:	0f b6 00             	movzbl (%eax),%eax
    1124:	84 c0                	test   %al,%al
    1126:	74 51                	je     1179 <matchquestion+0x8f>
    1128:	8b 45 14             	mov    0x14(%ebp),%eax
    112b:	8d 50 01             	lea    0x1(%eax),%edx
    112e:	89 55 14             	mov    %edx,0x14(%ebp)
    1131:	0f b6 00             	movzbl (%eax),%eax
    1134:	0f be c0             	movsbl %al,%eax
    1137:	83 ec 04             	sub    $0x4,%esp
    113a:	50                   	push   %eax
    113b:	ff 75 0c             	pushl  0xc(%ebp)
    113e:	ff 75 08             	pushl  0x8(%ebp)
    1141:	e8 98 fd ff ff       	call   ede <matchone>
    1146:	83 c4 10             	add    $0x10,%esp
    1149:	85 c0                	test   %eax,%eax
    114b:	74 2c                	je     1179 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    114d:	83 ec 04             	sub    $0x4,%esp
    1150:	ff 75 18             	pushl  0x18(%ebp)
    1153:	ff 75 14             	pushl  0x14(%ebp)
    1156:	ff 75 10             	pushl  0x10(%ebp)
    1159:	e8 22 00 00 00       	call   1180 <matchpattern>
    115e:	83 c4 10             	add    $0x10,%esp
    1161:	85 c0                	test   %eax,%eax
    1163:	74 14                	je     1179 <matchquestion+0x8f>
    {
      (*matchlength)++;
    1165:	8b 45 18             	mov    0x18(%ebp),%eax
    1168:	8b 00                	mov    (%eax),%eax
    116a:	8d 50 01             	lea    0x1(%eax),%edx
    116d:	8b 45 18             	mov    0x18(%ebp),%eax
    1170:	89 10                	mov    %edx,(%eax)
      return 1;
    1172:	b8 01 00 00 00       	mov    $0x1,%eax
    1177:	eb 05                	jmp    117e <matchquestion+0x94>
    }
  }
  return 0;
    1179:	b8 00 00 00 00       	mov    $0x0,%eax
}
    117e:	c9                   	leave  
    117f:	c3                   	ret    

00001180 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1186:	8b 45 10             	mov    0x10(%ebp),%eax
    1189:	8b 00                	mov    (%eax),%eax
    118b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    118e:	8b 45 08             	mov    0x8(%ebp),%eax
    1191:	0f b6 00             	movzbl (%eax),%eax
    1194:	84 c0                	test   %al,%al
    1196:	74 0d                	je     11a5 <matchpattern+0x25>
    1198:	8b 45 08             	mov    0x8(%ebp),%eax
    119b:	83 c0 08             	add    $0x8,%eax
    119e:	0f b6 00             	movzbl (%eax),%eax
    11a1:	3c 04                	cmp    $0x4,%al
    11a3:	75 25                	jne    11ca <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	83 c0 10             	add    $0x10,%eax
    11ab:	83 ec 0c             	sub    $0xc,%esp
    11ae:	ff 75 10             	pushl  0x10(%ebp)
    11b1:	ff 75 0c             	pushl  0xc(%ebp)
    11b4:	50                   	push   %eax
    11b5:	8b 45 08             	mov    0x8(%ebp),%eax
    11b8:	ff 70 04             	pushl  0x4(%eax)
    11bb:	ff 30                	pushl  (%eax)
    11bd:	e8 28 ff ff ff       	call   10ea <matchquestion>
    11c2:	83 c4 20             	add    $0x20,%esp
    11c5:	e9 dd 00 00 00       	jmp    12a7 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	83 c0 08             	add    $0x8,%eax
    11d0:	0f b6 00             	movzbl (%eax),%eax
    11d3:	3c 05                	cmp    $0x5,%al
    11d5:	75 25                	jne    11fc <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    11d7:	8b 45 08             	mov    0x8(%ebp),%eax
    11da:	83 c0 10             	add    $0x10,%eax
    11dd:	83 ec 0c             	sub    $0xc,%esp
    11e0:	ff 75 10             	pushl  0x10(%ebp)
    11e3:	ff 75 0c             	pushl  0xc(%ebp)
    11e6:	50                   	push   %eax
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	ff 70 04             	pushl  0x4(%eax)
    11ed:	ff 30                	pushl  (%eax)
    11ef:	e8 d4 fd ff ff       	call   fc8 <matchstar>
    11f4:	83 c4 20             	add    $0x20,%esp
    11f7:	e9 ab 00 00 00       	jmp    12a7 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    11fc:	8b 45 08             	mov    0x8(%ebp),%eax
    11ff:	83 c0 08             	add    $0x8,%eax
    1202:	0f b6 00             	movzbl (%eax),%eax
    1205:	3c 06                	cmp    $0x6,%al
    1207:	75 22                	jne    122b <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    1209:	8b 45 08             	mov    0x8(%ebp),%eax
    120c:	83 c0 10             	add    $0x10,%eax
    120f:	83 ec 0c             	sub    $0xc,%esp
    1212:	ff 75 10             	pushl  0x10(%ebp)
    1215:	ff 75 0c             	pushl  0xc(%ebp)
    1218:	50                   	push   %eax
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	ff 70 04             	pushl  0x4(%eax)
    121f:	ff 30                	pushl  (%eax)
    1221:	e8 3b fe ff ff       	call   1061 <matchplus>
    1226:	83 c4 20             	add    $0x20,%esp
    1229:	eb 7c                	jmp    12a7 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    122b:	8b 45 08             	mov    0x8(%ebp),%eax
    122e:	0f b6 00             	movzbl (%eax),%eax
    1231:	3c 03                	cmp    $0x3,%al
    1233:	75 1d                	jne    1252 <matchpattern+0xd2>
    1235:	8b 45 08             	mov    0x8(%ebp),%eax
    1238:	83 c0 08             	add    $0x8,%eax
    123b:	0f b6 00             	movzbl (%eax),%eax
    123e:	84 c0                	test   %al,%al
    1240:	75 10                	jne    1252 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1242:	8b 45 0c             	mov    0xc(%ebp),%eax
    1245:	0f b6 00             	movzbl (%eax),%eax
    1248:	84 c0                	test   %al,%al
    124a:	0f 94 c0             	sete   %al
    124d:	0f b6 c0             	movzbl %al,%eax
    1250:	eb 55                	jmp    12a7 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1252:	8b 45 10             	mov    0x10(%ebp),%eax
    1255:	8b 00                	mov    (%eax),%eax
    1257:	8d 50 01             	lea    0x1(%eax),%edx
    125a:	8b 45 10             	mov    0x10(%ebp),%eax
    125d:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    125f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1262:	0f b6 00             	movzbl (%eax),%eax
    1265:	84 c0                	test   %al,%al
    1267:	74 31                	je     129a <matchpattern+0x11a>
    1269:	8b 45 0c             	mov    0xc(%ebp),%eax
    126c:	8d 50 01             	lea    0x1(%eax),%edx
    126f:	89 55 0c             	mov    %edx,0xc(%ebp)
    1272:	0f b6 00             	movzbl (%eax),%eax
    1275:	0f be d0             	movsbl %al,%edx
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8d 48 08             	lea    0x8(%eax),%ecx
    127e:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1281:	83 ec 04             	sub    $0x4,%esp
    1284:	52                   	push   %edx
    1285:	ff 70 04             	pushl  0x4(%eax)
    1288:	ff 30                	pushl  (%eax)
    128a:	e8 4f fc ff ff       	call   ede <matchone>
    128f:	83 c4 10             	add    $0x10,%esp
    1292:	85 c0                	test   %eax,%eax
    1294:	0f 85 f4 fe ff ff    	jne    118e <matchpattern+0xe>

  *matchlength = pre;
    129a:	8b 45 10             	mov    0x10(%ebp),%eax
    129d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12a0:	89 10                	mov    %edx,(%eax)
  return 0;
    12a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12a7:	c9                   	leave  
    12a8:	c3                   	ret    
