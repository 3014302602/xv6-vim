
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
      11:	e8 65 02 00 00       	call   27b <fork>
      16:	85 c0                	test   %eax,%eax
      18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
      1a:	83 ec 0c             	sub    $0xc,%esp
      1d:	6a 05                	push   $0x5
      1f:	e8 ef 02 00 00       	call   313 <sleep>
      24:	83 c4 10             	add    $0x10,%esp
  exit();
      27:	e8 57 02 00 00       	call   283 <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      2c:	55                   	push   %ebp
      2d:	89 e5                	mov    %esp,%ebp
      2f:	57                   	push   %edi
      30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      31:	8b 4d 08             	mov    0x8(%ebp),%ecx
      34:	8b 55 10             	mov    0x10(%ebp),%edx
      37:	8b 45 0c             	mov    0xc(%ebp),%eax
      3a:	89 cb                	mov    %ecx,%ebx
      3c:	89 df                	mov    %ebx,%edi
      3e:	89 d1                	mov    %edx,%ecx
      40:	fc                   	cld    
      41:	f3 aa                	rep stos %al,%es:(%edi)
      43:	89 ca                	mov    %ecx,%edx
      45:	89 fb                	mov    %edi,%ebx
      47:	89 5d 08             	mov    %ebx,0x8(%ebp)
      4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      4d:	90                   	nop
      4e:	5b                   	pop    %ebx
      4f:	5f                   	pop    %edi
      50:	5d                   	pop    %ebp
      51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      52:	55                   	push   %ebp
      53:	89 e5                	mov    %esp,%ebp
      55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      58:	8b 45 08             	mov    0x8(%ebp),%eax
      5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      5e:	90                   	nop
      5f:	8b 45 08             	mov    0x8(%ebp),%eax
      62:	8d 50 01             	lea    0x1(%eax),%edx
      65:	89 55 08             	mov    %edx,0x8(%ebp)
      68:	8b 55 0c             	mov    0xc(%ebp),%edx
      6b:	8d 4a 01             	lea    0x1(%edx),%ecx
      6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      71:	0f b6 12             	movzbl (%edx),%edx
      74:	88 10                	mov    %dl,(%eax)
      76:	0f b6 00             	movzbl (%eax),%eax
      79:	84 c0                	test   %al,%al
      7b:	75 e2                	jne    5f <strcpy+0xd>
    ;
  return os;
      7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      80:	c9                   	leave  
      81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      82:	55                   	push   %ebp
      83:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      85:	eb 08                	jmp    8f <strcmp+0xd>
    p++, q++;
      87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      8b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      8f:	8b 45 08             	mov    0x8(%ebp),%eax
      92:	0f b6 00             	movzbl (%eax),%eax
      95:	84 c0                	test   %al,%al
      97:	74 10                	je     a9 <strcmp+0x27>
      99:	8b 45 08             	mov    0x8(%ebp),%eax
      9c:	0f b6 10             	movzbl (%eax),%edx
      9f:	8b 45 0c             	mov    0xc(%ebp),%eax
      a2:	0f b6 00             	movzbl (%eax),%eax
      a5:	38 c2                	cmp    %al,%dl
      a7:	74 de                	je     87 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      a9:	8b 45 08             	mov    0x8(%ebp),%eax
      ac:	0f b6 00             	movzbl (%eax),%eax
      af:	0f b6 d0             	movzbl %al,%edx
      b2:	8b 45 0c             	mov    0xc(%ebp),%eax
      b5:	0f b6 00             	movzbl (%eax),%eax
      b8:	0f b6 c0             	movzbl %al,%eax
      bb:	29 c2                	sub    %eax,%edx
      bd:	89 d0                	mov    %edx,%eax
}
      bf:	5d                   	pop    %ebp
      c0:	c3                   	ret    

000000c1 <strlen>:

uint
strlen(char *s)
{
      c1:	55                   	push   %ebp
      c2:	89 e5                	mov    %esp,%ebp
      c4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      ce:	eb 04                	jmp    d4 <strlen+0x13>
      d0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
      d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	01 d0                	add    %edx,%eax
      dc:	0f b6 00             	movzbl (%eax),%eax
      df:	84 c0                	test   %al,%al
      e1:	75 ed                	jne    d0 <strlen+0xf>
    ;
  return n;
      e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e6:	c9                   	leave  
      e7:	c3                   	ret    

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
      e8:	55                   	push   %ebp
      e9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
      eb:	8b 45 10             	mov    0x10(%ebp),%eax
      ee:	50                   	push   %eax
      ef:	ff 75 0c             	pushl  0xc(%ebp)
      f2:	ff 75 08             	pushl  0x8(%ebp)
      f5:	e8 32 ff ff ff       	call   2c <stosb>
      fa:	83 c4 0c             	add    $0xc,%esp
  return dst;
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
     100:	c9                   	leave  
     101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
     102:	55                   	push   %ebp
     103:	89 e5                	mov    %esp,%ebp
     105:	83 ec 04             	sub    $0x4,%esp
     108:	8b 45 0c             	mov    0xc(%ebp),%eax
     10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
     110:	8b 45 08             	mov    0x8(%ebp),%eax
     113:	0f b6 00             	movzbl (%eax),%eax
     116:	3a 45 fc             	cmp    -0x4(%ebp),%al
     119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
     11b:	8b 45 08             	mov    0x8(%ebp),%eax
     11e:	eb 13                	jmp    133 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     124:	8b 45 08             	mov    0x8(%ebp),%eax
     127:	0f b6 00             	movzbl (%eax),%eax
     12a:	84 c0                	test   %al,%al
     12c:	75 e2                	jne    110 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     133:	c9                   	leave  
     134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     142:	eb 42                	jmp    186 <gets+0x51>
    cc = read(0, &c, 1);
     144:	83 ec 04             	sub    $0x4,%esp
     147:	6a 01                	push   $0x1
     149:	8d 45 ef             	lea    -0x11(%ebp),%eax
     14c:	50                   	push   %eax
     14d:	6a 00                	push   $0x0
     14f:	e8 47 01 00 00       	call   29b <read>
     154:	83 c4 10             	add    $0x10,%esp
     157:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     15a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     15e:	7e 33                	jle    193 <gets+0x5e>
      break;
    buf[i++] = c;
     160:	8b 45 f4             	mov    -0xc(%ebp),%eax
     163:	8d 50 01             	lea    0x1(%eax),%edx
     166:	89 55 f4             	mov    %edx,-0xc(%ebp)
     169:	89 c2                	mov    %eax,%edx
     16b:	8b 45 08             	mov    0x8(%ebp),%eax
     16e:	01 c2                	add    %eax,%edx
     170:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     174:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     176:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     17a:	3c 0a                	cmp    $0xa,%al
     17c:	74 16                	je     194 <gets+0x5f>
     17e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     182:	3c 0d                	cmp    $0xd,%al
     184:	74 0e                	je     194 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     186:	8b 45 f4             	mov    -0xc(%ebp),%eax
     189:	83 c0 01             	add    $0x1,%eax
     18c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     18f:	7c b3                	jl     144 <gets+0xf>
     191:	eb 01                	jmp    194 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     193:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     194:	8b 55 f4             	mov    -0xc(%ebp),%edx
     197:	8b 45 08             	mov    0x8(%ebp),%eax
     19a:	01 d0                	add    %edx,%eax
     19c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     19f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1a2:	c9                   	leave  
     1a3:	c3                   	ret    

000001a4 <stat>:

int
stat(char *n, struct stat *st)
{
     1a4:	55                   	push   %ebp
     1a5:	89 e5                	mov    %esp,%ebp
     1a7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1aa:	83 ec 08             	sub    $0x8,%esp
     1ad:	6a 00                	push   $0x0
     1af:	ff 75 08             	pushl  0x8(%ebp)
     1b2:	e8 0c 01 00 00       	call   2c3 <open>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1c1:	79 07                	jns    1ca <stat+0x26>
    return -1;
     1c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     1c8:	eb 25                	jmp    1ef <stat+0x4b>
  r = fstat(fd, st);
     1ca:	83 ec 08             	sub    $0x8,%esp
     1cd:	ff 75 0c             	pushl  0xc(%ebp)
     1d0:	ff 75 f4             	pushl  -0xc(%ebp)
     1d3:	e8 03 01 00 00       	call   2db <fstat>
     1d8:	83 c4 10             	add    $0x10,%esp
     1db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     1de:	83 ec 0c             	sub    $0xc,%esp
     1e1:	ff 75 f4             	pushl  -0xc(%ebp)
     1e4:	e8 c2 00 00 00       	call   2ab <close>
     1e9:	83 c4 10             	add    $0x10,%esp
  return r;
     1ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     1ef:	c9                   	leave  
     1f0:	c3                   	ret    

000001f1 <atoi>:

int
atoi(const char *s)
{
     1f1:	55                   	push   %ebp
     1f2:	89 e5                	mov    %esp,%ebp
     1f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     1f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     1fe:	eb 25                	jmp    225 <atoi+0x34>
    n = n*10 + *s++ - '0';
     200:	8b 55 fc             	mov    -0x4(%ebp),%edx
     203:	89 d0                	mov    %edx,%eax
     205:	c1 e0 02             	shl    $0x2,%eax
     208:	01 d0                	add    %edx,%eax
     20a:	01 c0                	add    %eax,%eax
     20c:	89 c1                	mov    %eax,%ecx
     20e:	8b 45 08             	mov    0x8(%ebp),%eax
     211:	8d 50 01             	lea    0x1(%eax),%edx
     214:	89 55 08             	mov    %edx,0x8(%ebp)
     217:	0f b6 00             	movzbl (%eax),%eax
     21a:	0f be c0             	movsbl %al,%eax
     21d:	01 c8                	add    %ecx,%eax
     21f:	83 e8 30             	sub    $0x30,%eax
     222:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     225:	8b 45 08             	mov    0x8(%ebp),%eax
     228:	0f b6 00             	movzbl (%eax),%eax
     22b:	3c 2f                	cmp    $0x2f,%al
     22d:	7e 0a                	jle    239 <atoi+0x48>
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	0f b6 00             	movzbl (%eax),%eax
     235:	3c 39                	cmp    $0x39,%al
     237:	7e c7                	jle    200 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     239:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     23c:	c9                   	leave  
     23d:	c3                   	ret    

0000023e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     23e:	55                   	push   %ebp
     23f:	89 e5                	mov    %esp,%ebp
     241:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     244:	8b 45 08             	mov    0x8(%ebp),%eax
     247:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     24a:	8b 45 0c             	mov    0xc(%ebp),%eax
     24d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     250:	eb 17                	jmp    269 <memmove+0x2b>
    *dst++ = *src++;
     252:	8b 45 fc             	mov    -0x4(%ebp),%eax
     255:	8d 50 01             	lea    0x1(%eax),%edx
     258:	89 55 fc             	mov    %edx,-0x4(%ebp)
     25b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     25e:	8d 4a 01             	lea    0x1(%edx),%ecx
     261:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     264:	0f b6 12             	movzbl (%edx),%edx
     267:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     269:	8b 45 10             	mov    0x10(%ebp),%eax
     26c:	8d 50 ff             	lea    -0x1(%eax),%edx
     26f:	89 55 10             	mov    %edx,0x10(%ebp)
     272:	85 c0                	test   %eax,%eax
     274:	7f dc                	jg     252 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     276:	8b 45 08             	mov    0x8(%ebp),%eax
}
     279:	c9                   	leave  
     27a:	c3                   	ret    

0000027b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     27b:	b8 01 00 00 00       	mov    $0x1,%eax
     280:	cd 40                	int    $0x40
     282:	c3                   	ret    

00000283 <exit>:
SYSCALL(exit)
     283:	b8 02 00 00 00       	mov    $0x2,%eax
     288:	cd 40                	int    $0x40
     28a:	c3                   	ret    

0000028b <wait>:
SYSCALL(wait)
     28b:	b8 03 00 00 00       	mov    $0x3,%eax
     290:	cd 40                	int    $0x40
     292:	c3                   	ret    

00000293 <pipe>:
SYSCALL(pipe)
     293:	b8 04 00 00 00       	mov    $0x4,%eax
     298:	cd 40                	int    $0x40
     29a:	c3                   	ret    

0000029b <read>:
SYSCALL(read)
     29b:	b8 05 00 00 00       	mov    $0x5,%eax
     2a0:	cd 40                	int    $0x40
     2a2:	c3                   	ret    

000002a3 <write>:
SYSCALL(write)
     2a3:	b8 10 00 00 00       	mov    $0x10,%eax
     2a8:	cd 40                	int    $0x40
     2aa:	c3                   	ret    

000002ab <close>:
SYSCALL(close)
     2ab:	b8 15 00 00 00       	mov    $0x15,%eax
     2b0:	cd 40                	int    $0x40
     2b2:	c3                   	ret    

000002b3 <kill>:
SYSCALL(kill)
     2b3:	b8 06 00 00 00       	mov    $0x6,%eax
     2b8:	cd 40                	int    $0x40
     2ba:	c3                   	ret    

000002bb <exec>:
SYSCALL(exec)
     2bb:	b8 07 00 00 00       	mov    $0x7,%eax
     2c0:	cd 40                	int    $0x40
     2c2:	c3                   	ret    

000002c3 <open>:
SYSCALL(open)
     2c3:	b8 0f 00 00 00       	mov    $0xf,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <mknod>:
SYSCALL(mknod)
     2cb:	b8 11 00 00 00       	mov    $0x11,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <unlink>:
SYSCALL(unlink)
     2d3:	b8 12 00 00 00       	mov    $0x12,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <fstat>:
SYSCALL(fstat)
     2db:	b8 08 00 00 00       	mov    $0x8,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <link>:
SYSCALL(link)
     2e3:	b8 13 00 00 00       	mov    $0x13,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <mkdir>:
SYSCALL(mkdir)
     2eb:	b8 14 00 00 00       	mov    $0x14,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <chdir>:
SYSCALL(chdir)
     2f3:	b8 09 00 00 00       	mov    $0x9,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <dup>:
SYSCALL(dup)
     2fb:	b8 0a 00 00 00       	mov    $0xa,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <getpid>:
SYSCALL(getpid)
     303:	b8 0b 00 00 00       	mov    $0xb,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <sbrk>:
SYSCALL(sbrk)
     30b:	b8 0c 00 00 00       	mov    $0xc,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <sleep>:
SYSCALL(sleep)
     313:	b8 0d 00 00 00       	mov    $0xd,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <uptime>:
SYSCALL(uptime)
     31b:	b8 0e 00 00 00       	mov    $0xe,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     323:	b8 16 00 00 00       	mov    $0x16,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     32b:	b8 17 00 00 00       	mov    $0x17,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <clearScreen>:
SYSCALL(clearScreen)
     333:	b8 18 00 00 00       	mov    $0x18,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <writeAt>:
SYSCALL(writeAt)
     33b:	b8 19 00 00 00       	mov    $0x19,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <setBufferFlag>:
SYSCALL(setBufferFlag)
     343:	b8 1a 00 00 00       	mov    $0x1a,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     34b:	b8 1b 00 00 00       	mov    $0x1b,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <getCursorPos>:
SYSCALL(getCursorPos)
     353:	b8 1c 00 00 00       	mov    $0x1c,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <saveScreen>:
SYSCALL(saveScreen)
     35b:	b8 1d 00 00 00       	mov    $0x1d,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <recorverScreen>:
SYSCALL(recorverScreen)
     363:	b8 1e 00 00 00       	mov    $0x1e,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <ToScreen>:
SYSCALL(ToScreen)
     36b:	b8 1f 00 00 00       	mov    $0x1f,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <getColor>:
SYSCALL(getColor)
     373:	b8 20 00 00 00       	mov    $0x20,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <showC>:
SYSCALL(showC)
     37b:	b8 21 00 00 00       	mov    $0x21,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     383:	55                   	push   %ebp
     384:	89 e5                	mov    %esp,%ebp
     386:	83 ec 18             	sub    $0x18,%esp
     389:	8b 45 0c             	mov    0xc(%ebp),%eax
     38c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     38f:	83 ec 04             	sub    $0x4,%esp
     392:	6a 01                	push   $0x1
     394:	8d 45 f4             	lea    -0xc(%ebp),%eax
     397:	50                   	push   %eax
     398:	ff 75 08             	pushl  0x8(%ebp)
     39b:	e8 03 ff ff ff       	call   2a3 <write>
     3a0:	83 c4 10             	add    $0x10,%esp
}
     3a3:	90                   	nop
     3a4:	c9                   	leave  
     3a5:	c3                   	ret    

000003a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3a6:	55                   	push   %ebp
     3a7:	89 e5                	mov    %esp,%ebp
     3a9:	53                   	push   %ebx
     3aa:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3b4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3b8:	74 17                	je     3d1 <printint+0x2b>
     3ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3be:	79 11                	jns    3d1 <printint+0x2b>
    neg = 1;
     3c0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3c7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ca:	f7 d8                	neg    %eax
     3cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3cf:	eb 06                	jmp    3d7 <printint+0x31>
  } else {
    x = xx;
     3d1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3de:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3e1:	8d 41 01             	lea    0x1(%ecx),%eax
     3e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3e7:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3ed:	ba 00 00 00 00       	mov    $0x0,%edx
     3f2:	f7 f3                	div    %ebx
     3f4:	89 d0                	mov    %edx,%eax
     3f6:	0f b6 80 64 19 00 00 	movzbl 0x1964(%eax),%eax
     3fd:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     401:	8b 5d 10             	mov    0x10(%ebp),%ebx
     404:	8b 45 ec             	mov    -0x14(%ebp),%eax
     407:	ba 00 00 00 00       	mov    $0x0,%edx
     40c:	f7 f3                	div    %ebx
     40e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     411:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     415:	75 c7                	jne    3de <printint+0x38>
  if(neg)
     417:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     41b:	74 2d                	je     44a <printint+0xa4>
    buf[i++] = '-';
     41d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     420:	8d 50 01             	lea    0x1(%eax),%edx
     423:	89 55 f4             	mov    %edx,-0xc(%ebp)
     426:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     42b:	eb 1d                	jmp    44a <printint+0xa4>
    putc(fd, buf[i]);
     42d:	8d 55 dc             	lea    -0x24(%ebp),%edx
     430:	8b 45 f4             	mov    -0xc(%ebp),%eax
     433:	01 d0                	add    %edx,%eax
     435:	0f b6 00             	movzbl (%eax),%eax
     438:	0f be c0             	movsbl %al,%eax
     43b:	83 ec 08             	sub    $0x8,%esp
     43e:	50                   	push   %eax
     43f:	ff 75 08             	pushl  0x8(%ebp)
     442:	e8 3c ff ff ff       	call   383 <putc>
     447:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     44a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     44e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     452:	79 d9                	jns    42d <printint+0x87>
    putc(fd, buf[i]);
}
     454:	90                   	nop
     455:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     458:	c9                   	leave  
     459:	c3                   	ret    

0000045a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     45a:	55                   	push   %ebp
     45b:	89 e5                	mov    %esp,%ebp
     45d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     460:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     467:	8d 45 0c             	lea    0xc(%ebp),%eax
     46a:	83 c0 04             	add    $0x4,%eax
     46d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     477:	e9 59 01 00 00       	jmp    5d5 <printf+0x17b>
    c = fmt[i] & 0xff;
     47c:	8b 55 0c             	mov    0xc(%ebp),%edx
     47f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     482:	01 d0                	add    %edx,%eax
     484:	0f b6 00             	movzbl (%eax),%eax
     487:	0f be c0             	movsbl %al,%eax
     48a:	25 ff 00 00 00       	and    $0xff,%eax
     48f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     492:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     496:	75 2c                	jne    4c4 <printf+0x6a>
      if(c == '%'){
     498:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     49c:	75 0c                	jne    4aa <printf+0x50>
        state = '%';
     49e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4a5:	e9 27 01 00 00       	jmp    5d1 <printf+0x177>
      } else {
        putc(fd, c);
     4aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4ad:	0f be c0             	movsbl %al,%eax
     4b0:	83 ec 08             	sub    $0x8,%esp
     4b3:	50                   	push   %eax
     4b4:	ff 75 08             	pushl  0x8(%ebp)
     4b7:	e8 c7 fe ff ff       	call   383 <putc>
     4bc:	83 c4 10             	add    $0x10,%esp
     4bf:	e9 0d 01 00 00       	jmp    5d1 <printf+0x177>
      }
    } else if(state == '%'){
     4c4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4c8:	0f 85 03 01 00 00    	jne    5d1 <printf+0x177>
      if(c == 'd'){
     4ce:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4d2:	75 1e                	jne    4f2 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4d7:	8b 00                	mov    (%eax),%eax
     4d9:	6a 01                	push   $0x1
     4db:	6a 0a                	push   $0xa
     4dd:	50                   	push   %eax
     4de:	ff 75 08             	pushl  0x8(%ebp)
     4e1:	e8 c0 fe ff ff       	call   3a6 <printint>
     4e6:	83 c4 10             	add    $0x10,%esp
        ap++;
     4e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4ed:	e9 d8 00 00 00       	jmp    5ca <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4f2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4f6:	74 06                	je     4fe <printf+0xa4>
     4f8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4fc:	75 1e                	jne    51c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     501:	8b 00                	mov    (%eax),%eax
     503:	6a 00                	push   $0x0
     505:	6a 10                	push   $0x10
     507:	50                   	push   %eax
     508:	ff 75 08             	pushl  0x8(%ebp)
     50b:	e8 96 fe ff ff       	call   3a6 <printint>
     510:	83 c4 10             	add    $0x10,%esp
        ap++;
     513:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     517:	e9 ae 00 00 00       	jmp    5ca <printf+0x170>
      } else if(c == 's'){
     51c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     520:	75 43                	jne    565 <printf+0x10b>
        s = (char*)*ap;
     522:	8b 45 e8             	mov    -0x18(%ebp),%eax
     525:	8b 00                	mov    (%eax),%eax
     527:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     52a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     52e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     532:	75 25                	jne    559 <printf+0xff>
          s = "(null)";
     534:	c7 45 f4 48 12 00 00 	movl   $0x1248,-0xc(%ebp)
        while(*s != 0){
     53b:	eb 1c                	jmp    559 <printf+0xff>
          putc(fd, *s);
     53d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     540:	0f b6 00             	movzbl (%eax),%eax
     543:	0f be c0             	movsbl %al,%eax
     546:	83 ec 08             	sub    $0x8,%esp
     549:	50                   	push   %eax
     54a:	ff 75 08             	pushl  0x8(%ebp)
     54d:	e8 31 fe ff ff       	call   383 <putc>
     552:	83 c4 10             	add    $0x10,%esp
          s++;
     555:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     559:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55c:	0f b6 00             	movzbl (%eax),%eax
     55f:	84 c0                	test   %al,%al
     561:	75 da                	jne    53d <printf+0xe3>
     563:	eb 65                	jmp    5ca <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     565:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     569:	75 1d                	jne    588 <printf+0x12e>
        putc(fd, *ap);
     56b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     56e:	8b 00                	mov    (%eax),%eax
     570:	0f be c0             	movsbl %al,%eax
     573:	83 ec 08             	sub    $0x8,%esp
     576:	50                   	push   %eax
     577:	ff 75 08             	pushl  0x8(%ebp)
     57a:	e8 04 fe ff ff       	call   383 <putc>
     57f:	83 c4 10             	add    $0x10,%esp
        ap++;
     582:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     586:	eb 42                	jmp    5ca <printf+0x170>
      } else if(c == '%'){
     588:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     58c:	75 17                	jne    5a5 <printf+0x14b>
        putc(fd, c);
     58e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     591:	0f be c0             	movsbl %al,%eax
     594:	83 ec 08             	sub    $0x8,%esp
     597:	50                   	push   %eax
     598:	ff 75 08             	pushl  0x8(%ebp)
     59b:	e8 e3 fd ff ff       	call   383 <putc>
     5a0:	83 c4 10             	add    $0x10,%esp
     5a3:	eb 25                	jmp    5ca <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5a5:	83 ec 08             	sub    $0x8,%esp
     5a8:	6a 25                	push   $0x25
     5aa:	ff 75 08             	pushl  0x8(%ebp)
     5ad:	e8 d1 fd ff ff       	call   383 <putc>
     5b2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b8:	0f be c0             	movsbl %al,%eax
     5bb:	83 ec 08             	sub    $0x8,%esp
     5be:	50                   	push   %eax
     5bf:	ff 75 08             	pushl  0x8(%ebp)
     5c2:	e8 bc fd ff ff       	call   383 <putc>
     5c7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5d1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5d5:	8b 55 0c             	mov    0xc(%ebp),%edx
     5d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5db:	01 d0                	add    %edx,%eax
     5dd:	0f b6 00             	movzbl (%eax),%eax
     5e0:	84 c0                	test   %al,%al
     5e2:	0f 85 94 fe ff ff    	jne    47c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5e8:	90                   	nop
     5e9:	c9                   	leave  
     5ea:	c3                   	ret    

000005eb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5eb:	55                   	push   %ebp
     5ec:	89 e5                	mov    %esp,%ebp
     5ee:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5f1:	8b 45 08             	mov    0x8(%ebp),%eax
     5f4:	83 e8 08             	sub    $0x8,%eax
     5f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5fa:	a1 88 19 00 00       	mov    0x1988,%eax
     5ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
     602:	eb 24                	jmp    628 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     604:	8b 45 fc             	mov    -0x4(%ebp),%eax
     607:	8b 00                	mov    (%eax),%eax
     609:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     60c:	77 12                	ja     620 <free+0x35>
     60e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     611:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     614:	77 24                	ja     63a <free+0x4f>
     616:	8b 45 fc             	mov    -0x4(%ebp),%eax
     619:	8b 00                	mov    (%eax),%eax
     61b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     61e:	77 1a                	ja     63a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     620:	8b 45 fc             	mov    -0x4(%ebp),%eax
     623:	8b 00                	mov    (%eax),%eax
     625:	89 45 fc             	mov    %eax,-0x4(%ebp)
     628:	8b 45 f8             	mov    -0x8(%ebp),%eax
     62b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62e:	76 d4                	jbe    604 <free+0x19>
     630:	8b 45 fc             	mov    -0x4(%ebp),%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     638:	76 ca                	jbe    604 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63d:	8b 40 04             	mov    0x4(%eax),%eax
     640:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     647:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64a:	01 c2                	add    %eax,%edx
     64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64f:	8b 00                	mov    (%eax),%eax
     651:	39 c2                	cmp    %eax,%edx
     653:	75 24                	jne    679 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     655:	8b 45 f8             	mov    -0x8(%ebp),%eax
     658:	8b 50 04             	mov    0x4(%eax),%edx
     65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65e:	8b 00                	mov    (%eax),%eax
     660:	8b 40 04             	mov    0x4(%eax),%eax
     663:	01 c2                	add    %eax,%edx
     665:	8b 45 f8             	mov    -0x8(%ebp),%eax
     668:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66e:	8b 00                	mov    (%eax),%eax
     670:	8b 10                	mov    (%eax),%edx
     672:	8b 45 f8             	mov    -0x8(%ebp),%eax
     675:	89 10                	mov    %edx,(%eax)
     677:	eb 0a                	jmp    683 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     679:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67c:	8b 10                	mov    (%eax),%edx
     67e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     681:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     683:	8b 45 fc             	mov    -0x4(%ebp),%eax
     686:	8b 40 04             	mov    0x4(%eax),%eax
     689:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     690:	8b 45 fc             	mov    -0x4(%ebp),%eax
     693:	01 d0                	add    %edx,%eax
     695:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     698:	75 20                	jne    6ba <free+0xcf>
    p->s.size += bp->s.size;
     69a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69d:	8b 50 04             	mov    0x4(%eax),%edx
     6a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a3:	8b 40 04             	mov    0x4(%eax),%eax
     6a6:	01 c2                	add    %eax,%edx
     6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ab:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b1:	8b 10                	mov    (%eax),%edx
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	89 10                	mov    %edx,(%eax)
     6b8:	eb 08                	jmp    6c2 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6c0:	89 10                	mov    %edx,(%eax)
  freep = p;
     6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c5:	a3 88 19 00 00       	mov    %eax,0x1988
}
     6ca:	90                   	nop
     6cb:	c9                   	leave  
     6cc:	c3                   	ret    

000006cd <morecore>:

static Header*
morecore(uint nu)
{
     6cd:	55                   	push   %ebp
     6ce:	89 e5                	mov    %esp,%ebp
     6d0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6d3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6da:	77 07                	ja     6e3 <morecore+0x16>
    nu = 4096;
     6dc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6e3:	8b 45 08             	mov    0x8(%ebp),%eax
     6e6:	c1 e0 03             	shl    $0x3,%eax
     6e9:	83 ec 0c             	sub    $0xc,%esp
     6ec:	50                   	push   %eax
     6ed:	e8 19 fc ff ff       	call   30b <sbrk>
     6f2:	83 c4 10             	add    $0x10,%esp
     6f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6f8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6fc:	75 07                	jne    705 <morecore+0x38>
    return 0;
     6fe:	b8 00 00 00 00       	mov    $0x0,%eax
     703:	eb 26                	jmp    72b <morecore+0x5e>
  hp = (Header*)p;
     705:	8b 45 f4             	mov    -0xc(%ebp),%eax
     708:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     70b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     70e:	8b 55 08             	mov    0x8(%ebp),%edx
     711:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     714:	8b 45 f0             	mov    -0x10(%ebp),%eax
     717:	83 c0 08             	add    $0x8,%eax
     71a:	83 ec 0c             	sub    $0xc,%esp
     71d:	50                   	push   %eax
     71e:	e8 c8 fe ff ff       	call   5eb <free>
     723:	83 c4 10             	add    $0x10,%esp
  return freep;
     726:	a1 88 19 00 00       	mov    0x1988,%eax
}
     72b:	c9                   	leave  
     72c:	c3                   	ret    

0000072d <malloc>:

void*
malloc(uint nbytes)
{
     72d:	55                   	push   %ebp
     72e:	89 e5                	mov    %esp,%ebp
     730:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     733:	8b 45 08             	mov    0x8(%ebp),%eax
     736:	83 c0 07             	add    $0x7,%eax
     739:	c1 e8 03             	shr    $0x3,%eax
     73c:	83 c0 01             	add    $0x1,%eax
     73f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     742:	a1 88 19 00 00       	mov    0x1988,%eax
     747:	89 45 f0             	mov    %eax,-0x10(%ebp)
     74a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     74e:	75 23                	jne    773 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     750:	c7 45 f0 80 19 00 00 	movl   $0x1980,-0x10(%ebp)
     757:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75a:	a3 88 19 00 00       	mov    %eax,0x1988
     75f:	a1 88 19 00 00       	mov    0x1988,%eax
     764:	a3 80 19 00 00       	mov    %eax,0x1980
    base.s.size = 0;
     769:	c7 05 84 19 00 00 00 	movl   $0x0,0x1984
     770:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     773:	8b 45 f0             	mov    -0x10(%ebp),%eax
     776:	8b 00                	mov    (%eax),%eax
     778:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77e:	8b 40 04             	mov    0x4(%eax),%eax
     781:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     784:	72 4d                	jb     7d3 <malloc+0xa6>
      if(p->s.size == nunits)
     786:	8b 45 f4             	mov    -0xc(%ebp),%eax
     789:	8b 40 04             	mov    0x4(%eax),%eax
     78c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     78f:	75 0c                	jne    79d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     791:	8b 45 f4             	mov    -0xc(%ebp),%eax
     794:	8b 10                	mov    (%eax),%edx
     796:	8b 45 f0             	mov    -0x10(%ebp),%eax
     799:	89 10                	mov    %edx,(%eax)
     79b:	eb 26                	jmp    7c3 <malloc+0x96>
      else {
        p->s.size -= nunits;
     79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a0:	8b 40 04             	mov    0x4(%eax),%eax
     7a3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7a6:	89 c2                	mov    %eax,%edx
     7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ab:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b1:	8b 40 04             	mov    0x4(%eax),%eax
     7b4:	c1 e0 03             	shl    $0x3,%eax
     7b7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bd:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7c0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c6:	a3 88 19 00 00       	mov    %eax,0x1988
      return (void*)(p + 1);
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	83 c0 08             	add    $0x8,%eax
     7d1:	eb 3b                	jmp    80e <malloc+0xe1>
    }
    if(p == freep)
     7d3:	a1 88 19 00 00       	mov    0x1988,%eax
     7d8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7db:	75 1e                	jne    7fb <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7dd:	83 ec 0c             	sub    $0xc,%esp
     7e0:	ff 75 ec             	pushl  -0x14(%ebp)
     7e3:	e8 e5 fe ff ff       	call   6cd <morecore>
     7e8:	83 c4 10             	add    $0x10,%esp
     7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7f2:	75 07                	jne    7fb <malloc+0xce>
        return 0;
     7f4:	b8 00 00 00 00       	mov    $0x0,%eax
     7f9:	eb 13                	jmp    80e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
     801:	8b 45 f4             	mov    -0xc(%ebp),%eax
     804:	8b 00                	mov    (%eax),%eax
     806:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     809:	e9 6d ff ff ff       	jmp    77b <malloc+0x4e>
}
     80e:	c9                   	leave  
     80f:	c3                   	ret    

00000810 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     816:	83 ec 0c             	sub    $0xc,%esp
     819:	ff 75 08             	pushl  0x8(%ebp)
     81c:	e8 b0 00 00 00       	call   8d1 <re_compile>
     821:	83 c4 10             	add    $0x10,%esp
     824:	83 ec 04             	sub    $0x4,%esp
     827:	ff 75 10             	pushl  0x10(%ebp)
     82a:	ff 75 0c             	pushl  0xc(%ebp)
     82d:	50                   	push   %eax
     82e:	e8 05 00 00 00       	call   838 <re_matchp>
     833:	83 c4 10             	add    $0x10,%esp
}
     836:	c9                   	leave  
     837:	c3                   	ret    

00000838 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     838:	55                   	push   %ebp
     839:	89 e5                	mov    %esp,%ebp
     83b:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     83e:	8b 45 10             	mov    0x10(%ebp),%eax
     841:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     847:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     84b:	74 7d                	je     8ca <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     84d:	8b 45 08             	mov    0x8(%ebp),%eax
     850:	0f b6 00             	movzbl (%eax),%eax
     853:	3c 02                	cmp    $0x2,%al
     855:	75 2a                	jne    881 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     857:	8b 45 08             	mov    0x8(%ebp),%eax
     85a:	83 c0 08             	add    $0x8,%eax
     85d:	83 ec 04             	sub    $0x4,%esp
     860:	ff 75 10             	pushl  0x10(%ebp)
     863:	ff 75 0c             	pushl  0xc(%ebp)
     866:	50                   	push   %eax
     867:	e8 b0 08 00 00       	call   111c <matchpattern>
     86c:	83 c4 10             	add    $0x10,%esp
     86f:	85 c0                	test   %eax,%eax
     871:	74 07                	je     87a <re_matchp+0x42>
     873:	b8 00 00 00 00       	mov    $0x0,%eax
     878:	eb 55                	jmp    8cf <re_matchp+0x97>
     87a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     87f:	eb 4e                	jmp    8cf <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     881:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     888:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     88c:	83 ec 04             	sub    $0x4,%esp
     88f:	ff 75 10             	pushl  0x10(%ebp)
     892:	ff 75 0c             	pushl  0xc(%ebp)
     895:	ff 75 08             	pushl  0x8(%ebp)
     898:	e8 7f 08 00 00       	call   111c <matchpattern>
     89d:	83 c4 10             	add    $0x10,%esp
     8a0:	85 c0                	test   %eax,%eax
     8a2:	74 16                	je     8ba <re_matchp+0x82>
        {
          if (text[0] == '\0')
     8a4:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a7:	0f b6 00             	movzbl (%eax),%eax
     8aa:	84 c0                	test   %al,%al
     8ac:	75 07                	jne    8b5 <re_matchp+0x7d>
            return -1;
     8ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8b3:	eb 1a                	jmp    8cf <re_matchp+0x97>
        
          return idx;
     8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b8:	eb 15                	jmp    8cf <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     8ba:	8b 45 0c             	mov    0xc(%ebp),%eax
     8bd:	8d 50 01             	lea    0x1(%eax),%edx
     8c0:	89 55 0c             	mov    %edx,0xc(%ebp)
     8c3:	0f b6 00             	movzbl (%eax),%eax
     8c6:	84 c0                	test   %al,%al
     8c8:	75 be                	jne    888 <re_matchp+0x50>
    }
  }
  return -1;
     8ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     8cf:	c9                   	leave  
     8d0:	c3                   	ret    

000008d1 <re_compile>:

re_t re_compile(const char* pattern)
{
     8d1:	55                   	push   %ebp
     8d2:	89 e5                	mov    %esp,%ebp
     8d4:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     8d7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     8de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     8e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     8ec:	e9 55 02 00 00       	jmp    b46 <re_compile+0x275>
  {
    c = pattern[i];
     8f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     8f4:	8b 45 08             	mov    0x8(%ebp),%eax
     8f7:	01 d0                	add    %edx,%eax
     8f9:	0f b6 00             	movzbl (%eax),%eax
     8fc:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     8ff:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     903:	83 e8 24             	sub    $0x24,%eax
     906:	83 f8 3a             	cmp    $0x3a,%eax
     909:	0f 87 13 02 00 00    	ja     b22 <re_compile+0x251>
     90f:	8b 04 85 50 12 00 00 	mov    0x1250(,%eax,4),%eax
     916:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     918:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91b:	c6 04 c5 a0 19 00 00 	movb   $0x2,0x19a0(,%eax,8)
     922:	02 
     923:	e9 16 02 00 00       	jmp    b3e <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     928:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92b:	c6 04 c5 a0 19 00 00 	movb   $0x3,0x19a0(,%eax,8)
     932:	03 
     933:	e9 06 02 00 00       	jmp    b3e <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     938:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93b:	c6 04 c5 a0 19 00 00 	movb   $0x1,0x19a0(,%eax,8)
     942:	01 
     943:	e9 f6 01 00 00       	jmp    b3e <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     948:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94b:	c6 04 c5 a0 19 00 00 	movb   $0x5,0x19a0(,%eax,8)
     952:	05 
     953:	e9 e6 01 00 00       	jmp    b3e <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     958:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95b:	c6 04 c5 a0 19 00 00 	movb   $0x6,0x19a0(,%eax,8)
     962:	06 
     963:	e9 d6 01 00 00       	jmp    b3e <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     968:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96b:	c6 04 c5 a0 19 00 00 	movb   $0x4,0x19a0(,%eax,8)
     972:	04 
     973:	e9 c6 01 00 00       	jmp    b3e <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     978:	8b 45 f8             	mov    -0x8(%ebp),%eax
     97b:	8d 50 01             	lea    0x1(%eax),%edx
     97e:	8b 45 08             	mov    0x8(%ebp),%eax
     981:	01 d0                	add    %edx,%eax
     983:	0f b6 00             	movzbl (%eax),%eax
     986:	84 c0                	test   %al,%al
     988:	0f 84 af 01 00 00    	je     b3d <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     98e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     992:	8b 55 f8             	mov    -0x8(%ebp),%edx
     995:	8b 45 08             	mov    0x8(%ebp),%eax
     998:	01 d0                	add    %edx,%eax
     99a:	0f b6 00             	movzbl (%eax),%eax
     99d:	0f be c0             	movsbl %al,%eax
     9a0:	83 e8 44             	sub    $0x44,%eax
     9a3:	83 f8 33             	cmp    $0x33,%eax
     9a6:	77 57                	ja     9ff <re_compile+0x12e>
     9a8:	8b 04 85 3c 13 00 00 	mov    0x133c(,%eax,4),%eax
     9af:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     9b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b4:	c6 04 c5 a0 19 00 00 	movb   $0xa,0x19a0(,%eax,8)
     9bb:	0a 
     9bc:	eb 64                	jmp    a22 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     9be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c1:	c6 04 c5 a0 19 00 00 	movb   $0xb,0x19a0(,%eax,8)
     9c8:	0b 
     9c9:	eb 57                	jmp    a22 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     9cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ce:	c6 04 c5 a0 19 00 00 	movb   $0xc,0x19a0(,%eax,8)
     9d5:	0c 
     9d6:	eb 4a                	jmp    a22 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9db:	c6 04 c5 a0 19 00 00 	movb   $0xd,0x19a0(,%eax,8)
     9e2:	0d 
     9e3:	eb 3d                	jmp    a22 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e8:	c6 04 c5 a0 19 00 00 	movb   $0xe,0x19a0(,%eax,8)
     9ef:	0e 
     9f0:	eb 30                	jmp    a22 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     9f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f5:	c6 04 c5 a0 19 00 00 	movb   $0xf,0x19a0(,%eax,8)
     9fc:	0f 
     9fd:	eb 23                	jmp    a22 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a02:	c6 04 c5 a0 19 00 00 	movb   $0x7,0x19a0(,%eax,8)
     a09:	07 
              re_compiled[j].ch = pattern[i];
     a0a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a0d:	8b 45 08             	mov    0x8(%ebp),%eax
     a10:	01 d0                	add    %edx,%eax
     a12:	0f b6 00             	movzbl (%eax),%eax
     a15:	89 c2                	mov    %eax,%edx
     a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1a:	88 14 c5 a4 19 00 00 	mov    %dl,0x19a4(,%eax,8)
            } break;
     a21:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a22:	e9 16 01 00 00       	jmp    b3d <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a27:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a2a:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a30:	8d 50 01             	lea    0x1(%eax),%edx
     a33:	8b 45 08             	mov    0x8(%ebp),%eax
     a36:	01 d0                	add    %edx,%eax
     a38:	0f b6 00             	movzbl (%eax),%eax
     a3b:	3c 5e                	cmp    $0x5e,%al
     a3d:	75 11                	jne    a50 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a42:	c6 04 c5 a0 19 00 00 	movb   $0x9,0x19a0(,%eax,8)
     a49:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     a4a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     a4e:	eb 7a                	jmp    aca <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a53:	c6 04 c5 a0 19 00 00 	movb   $0x8,0x19a0(,%eax,8)
     a5a:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     a5b:	eb 6d                	jmp    aca <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     a5d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a60:	8b 45 08             	mov    0x8(%ebp),%eax
     a63:	01 d0                	add    %edx,%eax
     a65:	0f b6 00             	movzbl (%eax),%eax
     a68:	3c 5c                	cmp    $0x5c,%al
     a6a:	75 34                	jne    aa0 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     a6c:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     a70:	7e 0a                	jle    a7c <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     a72:	b8 00 00 00 00       	mov    $0x0,%eax
     a77:	e9 f8 00 00 00       	jmp    b74 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     a7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a7f:	8d 50 01             	lea    0x1(%eax),%edx
     a82:	89 55 fc             	mov    %edx,-0x4(%ebp)
     a85:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a88:	8d 4a 01             	lea    0x1(%edx),%ecx
     a8b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     a8e:	89 d1                	mov    %edx,%ecx
     a90:	8b 55 08             	mov    0x8(%ebp),%edx
     a93:	01 ca                	add    %ecx,%edx
     a95:	0f b6 12             	movzbl (%edx),%edx
     a98:	88 90 a0 1a 00 00    	mov    %dl,0x1aa0(%eax)
     a9e:	eb 10                	jmp    ab0 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     aa0:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     aa4:	7e 0a                	jle    ab0 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aa6:	b8 00 00 00 00       	mov    $0x0,%eax
     aab:	e9 c4 00 00 00       	jmp    b74 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     ab0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ab3:	8d 50 01             	lea    0x1(%eax),%edx
     ab6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ab9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     abc:	8b 55 08             	mov    0x8(%ebp),%edx
     abf:	01 ca                	add    %ecx,%edx
     ac1:	0f b6 12             	movzbl (%edx),%edx
     ac4:	88 90 a0 1a 00 00    	mov    %dl,0x1aa0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     aca:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ace:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ad1:	8b 45 08             	mov    0x8(%ebp),%eax
     ad4:	01 d0                	add    %edx,%eax
     ad6:	0f b6 00             	movzbl (%eax),%eax
     ad9:	3c 5d                	cmp    $0x5d,%al
     adb:	74 13                	je     af0 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     add:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ae0:	8b 45 08             	mov    0x8(%ebp),%eax
     ae3:	01 d0                	add    %edx,%eax
     ae5:	0f b6 00             	movzbl (%eax),%eax
     ae8:	84 c0                	test   %al,%al
     aea:	0f 85 6d ff ff ff    	jne    a5d <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     af0:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     af4:	7e 07                	jle    afd <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     af6:	b8 00 00 00 00       	mov    $0x0,%eax
     afb:	eb 77                	jmp    b74 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b00:	8d 50 01             	lea    0x1(%eax),%edx
     b03:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b06:	c6 80 a0 1a 00 00 00 	movb   $0x0,0x1aa0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b10:	8d 90 a0 1a 00 00    	lea    0x1aa0(%eax),%edx
     b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b19:	89 14 c5 a4 19 00 00 	mov    %edx,0x19a4(,%eax,8)
      } break;
     b20:	eb 1c                	jmp    b3e <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b25:	c6 04 c5 a0 19 00 00 	movb   $0x7,0x19a0(,%eax,8)
     b2c:	07 
        re_compiled[j].ch = c;
     b2d:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b34:	88 14 c5 a4 19 00 00 	mov    %dl,0x19a4(,%eax,8)
      } break;
     b3b:	eb 01                	jmp    b3e <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b3d:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     b3e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     b42:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     b46:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b49:	8b 45 08             	mov    0x8(%ebp),%eax
     b4c:	01 d0                	add    %edx,%eax
     b4e:	0f b6 00             	movzbl (%eax),%eax
     b51:	84 c0                	test   %al,%al
     b53:	74 0f                	je     b64 <re_compile+0x293>
     b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b58:	83 c0 01             	add    $0x1,%eax
     b5b:	83 f8 1d             	cmp    $0x1d,%eax
     b5e:	0f 8e 8d fd ff ff    	jle    8f1 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b67:	c6 04 c5 a0 19 00 00 	movb   $0x0,0x19a0(,%eax,8)
     b6e:	00 

  return (re_t) re_compiled;
     b6f:	b8 a0 19 00 00       	mov    $0x19a0,%eax
}
     b74:	c9                   	leave  
     b75:	c3                   	ret    

00000b76 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     b76:	55                   	push   %ebp
     b77:	89 e5                	mov    %esp,%ebp
     b79:	83 ec 04             	sub    $0x4,%esp
     b7c:	8b 45 08             	mov    0x8(%ebp),%eax
     b7f:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     b82:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     b86:	7e 0d                	jle    b95 <matchdigit+0x1f>
     b88:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     b8c:	7f 07                	jg     b95 <matchdigit+0x1f>
     b8e:	b8 01 00 00 00       	mov    $0x1,%eax
     b93:	eb 05                	jmp    b9a <matchdigit+0x24>
     b95:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b9a:	c9                   	leave  
     b9b:	c3                   	ret    

00000b9c <matchalpha>:
static int matchalpha(char c)
{
     b9c:	55                   	push   %ebp
     b9d:	89 e5                	mov    %esp,%ebp
     b9f:	83 ec 04             	sub    $0x4,%esp
     ba2:	8b 45 08             	mov    0x8(%ebp),%eax
     ba5:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     ba8:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     bac:	7e 06                	jle    bb4 <matchalpha+0x18>
     bae:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     bb2:	7e 0c                	jle    bc0 <matchalpha+0x24>
     bb4:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     bb8:	7e 0d                	jle    bc7 <matchalpha+0x2b>
     bba:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     bbe:	7f 07                	jg     bc7 <matchalpha+0x2b>
     bc0:	b8 01 00 00 00       	mov    $0x1,%eax
     bc5:	eb 05                	jmp    bcc <matchalpha+0x30>
     bc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bcc:	c9                   	leave  
     bcd:	c3                   	ret    

00000bce <matchwhitespace>:
static int matchwhitespace(char c)
{
     bce:	55                   	push   %ebp
     bcf:	89 e5                	mov    %esp,%ebp
     bd1:	83 ec 04             	sub    $0x4,%esp
     bd4:	8b 45 08             	mov    0x8(%ebp),%eax
     bd7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     bda:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     bde:	74 1e                	je     bfe <matchwhitespace+0x30>
     be0:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     be4:	74 18                	je     bfe <matchwhitespace+0x30>
     be6:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     bea:	74 12                	je     bfe <matchwhitespace+0x30>
     bec:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     bf0:	74 0c                	je     bfe <matchwhitespace+0x30>
     bf2:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     bf6:	74 06                	je     bfe <matchwhitespace+0x30>
     bf8:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     bfc:	75 07                	jne    c05 <matchwhitespace+0x37>
     bfe:	b8 01 00 00 00       	mov    $0x1,%eax
     c03:	eb 05                	jmp    c0a <matchwhitespace+0x3c>
     c05:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c0a:	c9                   	leave  
     c0b:	c3                   	ret    

00000c0c <matchalphanum>:
static int matchalphanum(char c)
{
     c0c:	55                   	push   %ebp
     c0d:	89 e5                	mov    %esp,%ebp
     c0f:	83 ec 04             	sub    $0x4,%esp
     c12:	8b 45 08             	mov    0x8(%ebp),%eax
     c15:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c18:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c1c:	74 22                	je     c40 <matchalphanum+0x34>
     c1e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c22:	50                   	push   %eax
     c23:	e8 74 ff ff ff       	call   b9c <matchalpha>
     c28:	83 c4 04             	add    $0x4,%esp
     c2b:	85 c0                	test   %eax,%eax
     c2d:	75 11                	jne    c40 <matchalphanum+0x34>
     c2f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c33:	50                   	push   %eax
     c34:	e8 3d ff ff ff       	call   b76 <matchdigit>
     c39:	83 c4 04             	add    $0x4,%esp
     c3c:	85 c0                	test   %eax,%eax
     c3e:	74 07                	je     c47 <matchalphanum+0x3b>
     c40:	b8 01 00 00 00       	mov    $0x1,%eax
     c45:	eb 05                	jmp    c4c <matchalphanum+0x40>
     c47:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c4c:	c9                   	leave  
     c4d:	c3                   	ret    

00000c4e <matchrange>:
static int matchrange(char c, const char* str)
{
     c4e:	55                   	push   %ebp
     c4f:	89 e5                	mov    %esp,%ebp
     c51:	83 ec 04             	sub    $0x4,%esp
     c54:	8b 45 08             	mov    0x8(%ebp),%eax
     c57:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     c5a:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     c5e:	74 5b                	je     cbb <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     c60:	8b 45 0c             	mov    0xc(%ebp),%eax
     c63:	0f b6 00             	movzbl (%eax),%eax
     c66:	84 c0                	test   %al,%al
     c68:	74 51                	je     cbb <matchrange+0x6d>
     c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6d:	0f b6 00             	movzbl (%eax),%eax
     c70:	3c 2d                	cmp    $0x2d,%al
     c72:	74 47                	je     cbb <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     c74:	8b 45 0c             	mov    0xc(%ebp),%eax
     c77:	83 c0 01             	add    $0x1,%eax
     c7a:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     c7d:	3c 2d                	cmp    $0x2d,%al
     c7f:	75 3a                	jne    cbb <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     c81:	8b 45 0c             	mov    0xc(%ebp),%eax
     c84:	83 c0 01             	add    $0x1,%eax
     c87:	0f b6 00             	movzbl (%eax),%eax
     c8a:	84 c0                	test   %al,%al
     c8c:	74 2d                	je     cbb <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c91:	83 c0 02             	add    $0x2,%eax
     c94:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     c97:	84 c0                	test   %al,%al
     c99:	74 20                	je     cbb <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9e:	0f b6 00             	movzbl (%eax),%eax
     ca1:	3a 45 fc             	cmp    -0x4(%ebp),%al
     ca4:	7f 15                	jg     cbb <matchrange+0x6d>
     ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca9:	83 c0 02             	add    $0x2,%eax
     cac:	0f b6 00             	movzbl (%eax),%eax
     caf:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cb2:	7c 07                	jl     cbb <matchrange+0x6d>
     cb4:	b8 01 00 00 00       	mov    $0x1,%eax
     cb9:	eb 05                	jmp    cc0 <matchrange+0x72>
     cbb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cc0:	c9                   	leave  
     cc1:	c3                   	ret    

00000cc2 <ismetachar>:
static int ismetachar(char c)
{
     cc2:	55                   	push   %ebp
     cc3:	89 e5                	mov    %esp,%ebp
     cc5:	83 ec 04             	sub    $0x4,%esp
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     cce:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     cd2:	74 1e                	je     cf2 <ismetachar+0x30>
     cd4:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     cd8:	74 18                	je     cf2 <ismetachar+0x30>
     cda:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     cde:	74 12                	je     cf2 <ismetachar+0x30>
     ce0:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     ce4:	74 0c                	je     cf2 <ismetachar+0x30>
     ce6:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     cea:	74 06                	je     cf2 <ismetachar+0x30>
     cec:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     cf0:	75 07                	jne    cf9 <ismetachar+0x37>
     cf2:	b8 01 00 00 00       	mov    $0x1,%eax
     cf7:	eb 05                	jmp    cfe <ismetachar+0x3c>
     cf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cfe:	c9                   	leave  
     cff:	c3                   	ret    

00000d00 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	83 ec 04             	sub    $0x4,%esp
     d06:	8b 45 08             	mov    0x8(%ebp),%eax
     d09:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d0f:	0f b6 00             	movzbl (%eax),%eax
     d12:	0f be c0             	movsbl %al,%eax
     d15:	83 e8 44             	sub    $0x44,%eax
     d18:	83 f8 33             	cmp    $0x33,%eax
     d1b:	77 7b                	ja     d98 <matchmetachar+0x98>
     d1d:	8b 04 85 0c 14 00 00 	mov    0x140c(,%eax,4),%eax
     d24:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d26:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d2a:	50                   	push   %eax
     d2b:	e8 46 fe ff ff       	call   b76 <matchdigit>
     d30:	83 c4 04             	add    $0x4,%esp
     d33:	eb 72                	jmp    da7 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d35:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d39:	50                   	push   %eax
     d3a:	e8 37 fe ff ff       	call   b76 <matchdigit>
     d3f:	83 c4 04             	add    $0x4,%esp
     d42:	85 c0                	test   %eax,%eax
     d44:	0f 94 c0             	sete   %al
     d47:	0f b6 c0             	movzbl %al,%eax
     d4a:	eb 5b                	jmp    da7 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     d4c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d50:	50                   	push   %eax
     d51:	e8 b6 fe ff ff       	call   c0c <matchalphanum>
     d56:	83 c4 04             	add    $0x4,%esp
     d59:	eb 4c                	jmp    da7 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     d5b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d5f:	50                   	push   %eax
     d60:	e8 a7 fe ff ff       	call   c0c <matchalphanum>
     d65:	83 c4 04             	add    $0x4,%esp
     d68:	85 c0                	test   %eax,%eax
     d6a:	0f 94 c0             	sete   %al
     d6d:	0f b6 c0             	movzbl %al,%eax
     d70:	eb 35                	jmp    da7 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     d72:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d76:	50                   	push   %eax
     d77:	e8 52 fe ff ff       	call   bce <matchwhitespace>
     d7c:	83 c4 04             	add    $0x4,%esp
     d7f:	eb 26                	jmp    da7 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     d81:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d85:	50                   	push   %eax
     d86:	e8 43 fe ff ff       	call   bce <matchwhitespace>
     d8b:	83 c4 04             	add    $0x4,%esp
     d8e:	85 c0                	test   %eax,%eax
     d90:	0f 94 c0             	sete   %al
     d93:	0f b6 c0             	movzbl %al,%eax
     d96:	eb 0f                	jmp    da7 <matchmetachar+0xa7>
    default:  return (c == str[0]);
     d98:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9b:	0f b6 00             	movzbl (%eax),%eax
     d9e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     da1:	0f 94 c0             	sete   %al
     da4:	0f b6 c0             	movzbl %al,%eax
  }
}
     da7:	c9                   	leave  
     da8:	c3                   	ret    

00000da9 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     da9:	55                   	push   %ebp
     daa:	89 e5                	mov    %esp,%ebp
     dac:	83 ec 04             	sub    $0x4,%esp
     daf:	8b 45 08             	mov    0x8(%ebp),%eax
     db2:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     db5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     db9:	ff 75 0c             	pushl  0xc(%ebp)
     dbc:	50                   	push   %eax
     dbd:	e8 8c fe ff ff       	call   c4e <matchrange>
     dc2:	83 c4 08             	add    $0x8,%esp
     dc5:	85 c0                	test   %eax,%eax
     dc7:	74 0a                	je     dd3 <matchcharclass+0x2a>
    {
      return 1;
     dc9:	b8 01 00 00 00       	mov    $0x1,%eax
     dce:	e9 a5 00 00 00       	jmp    e78 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd6:	0f b6 00             	movzbl (%eax),%eax
     dd9:	3c 5c                	cmp    $0x5c,%al
     ddb:	75 42                	jne    e1f <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     ddd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     de1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     de5:	ff 75 0c             	pushl  0xc(%ebp)
     de8:	50                   	push   %eax
     de9:	e8 12 ff ff ff       	call   d00 <matchmetachar>
     dee:	83 c4 08             	add    $0x8,%esp
     df1:	85 c0                	test   %eax,%eax
     df3:	74 07                	je     dfc <matchcharclass+0x53>
      {
        return 1;
     df5:	b8 01 00 00 00       	mov    $0x1,%eax
     dfa:	eb 7c                	jmp    e78 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dff:	0f b6 00             	movzbl (%eax),%eax
     e02:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e05:	75 58                	jne    e5f <matchcharclass+0xb6>
     e07:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e0b:	50                   	push   %eax
     e0c:	e8 b1 fe ff ff       	call   cc2 <ismetachar>
     e11:	83 c4 04             	add    $0x4,%esp
     e14:	85 c0                	test   %eax,%eax
     e16:	75 47                	jne    e5f <matchcharclass+0xb6>
      {
        return 1;
     e18:	b8 01 00 00 00       	mov    $0x1,%eax
     e1d:	eb 59                	jmp    e78 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e22:	0f b6 00             	movzbl (%eax),%eax
     e25:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e28:	75 35                	jne    e5f <matchcharclass+0xb6>
    {
      if (c == '-')
     e2a:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e2e:	75 28                	jne    e58 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e30:	8b 45 0c             	mov    0xc(%ebp),%eax
     e33:	83 e8 01             	sub    $0x1,%eax
     e36:	0f b6 00             	movzbl (%eax),%eax
     e39:	84 c0                	test   %al,%al
     e3b:	74 0d                	je     e4a <matchcharclass+0xa1>
     e3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e40:	83 c0 01             	add    $0x1,%eax
     e43:	0f b6 00             	movzbl (%eax),%eax
     e46:	84 c0                	test   %al,%al
     e48:	75 07                	jne    e51 <matchcharclass+0xa8>
     e4a:	b8 01 00 00 00       	mov    $0x1,%eax
     e4f:	eb 27                	jmp    e78 <matchcharclass+0xcf>
     e51:	b8 00 00 00 00       	mov    $0x0,%eax
     e56:	eb 20                	jmp    e78 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     e58:	b8 01 00 00 00       	mov    $0x1,%eax
     e5d:	eb 19                	jmp    e78 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e62:	8d 50 01             	lea    0x1(%eax),%edx
     e65:	89 55 0c             	mov    %edx,0xc(%ebp)
     e68:	0f b6 00             	movzbl (%eax),%eax
     e6b:	84 c0                	test   %al,%al
     e6d:	0f 85 42 ff ff ff    	jne    db5 <matchcharclass+0xc>

  return 0;
     e73:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e78:	c9                   	leave  
     e79:	c3                   	ret    

00000e7a <matchone>:

static int matchone(regex_t p, char c)
{
     e7a:	55                   	push   %ebp
     e7b:	89 e5                	mov    %esp,%ebp
     e7d:	83 ec 04             	sub    $0x4,%esp
     e80:	8b 45 10             	mov    0x10(%ebp),%eax
     e83:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     e86:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     e8a:	0f b6 c0             	movzbl %al,%eax
     e8d:	83 f8 0f             	cmp    $0xf,%eax
     e90:	0f 87 b9 00 00 00    	ja     f4f <matchone+0xd5>
     e96:	8b 04 85 dc 14 00 00 	mov    0x14dc(,%eax,4),%eax
     e9d:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     e9f:	b8 01 00 00 00       	mov    $0x1,%eax
     ea4:	e9 b9 00 00 00       	jmp    f62 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     ea9:	8b 55 0c             	mov    0xc(%ebp),%edx
     eac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eb0:	52                   	push   %edx
     eb1:	50                   	push   %eax
     eb2:	e8 f2 fe ff ff       	call   da9 <matchcharclass>
     eb7:	83 c4 08             	add    $0x8,%esp
     eba:	e9 a3 00 00 00       	jmp    f62 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     ebf:	8b 55 0c             	mov    0xc(%ebp),%edx
     ec2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ec6:	52                   	push   %edx
     ec7:	50                   	push   %eax
     ec8:	e8 dc fe ff ff       	call   da9 <matchcharclass>
     ecd:	83 c4 08             	add    $0x8,%esp
     ed0:	85 c0                	test   %eax,%eax
     ed2:	0f 94 c0             	sete   %al
     ed5:	0f b6 c0             	movzbl %al,%eax
     ed8:	e9 85 00 00 00       	jmp    f62 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     edd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ee1:	50                   	push   %eax
     ee2:	e8 8f fc ff ff       	call   b76 <matchdigit>
     ee7:	83 c4 04             	add    $0x4,%esp
     eea:	eb 76                	jmp    f62 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     eec:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ef0:	50                   	push   %eax
     ef1:	e8 80 fc ff ff       	call   b76 <matchdigit>
     ef6:	83 c4 04             	add    $0x4,%esp
     ef9:	85 c0                	test   %eax,%eax
     efb:	0f 94 c0             	sete   %al
     efe:	0f b6 c0             	movzbl %al,%eax
     f01:	eb 5f                	jmp    f62 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f03:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f07:	50                   	push   %eax
     f08:	e8 ff fc ff ff       	call   c0c <matchalphanum>
     f0d:	83 c4 04             	add    $0x4,%esp
     f10:	eb 50                	jmp    f62 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f12:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f16:	50                   	push   %eax
     f17:	e8 f0 fc ff ff       	call   c0c <matchalphanum>
     f1c:	83 c4 04             	add    $0x4,%esp
     f1f:	85 c0                	test   %eax,%eax
     f21:	0f 94 c0             	sete   %al
     f24:	0f b6 c0             	movzbl %al,%eax
     f27:	eb 39                	jmp    f62 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f29:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f2d:	50                   	push   %eax
     f2e:	e8 9b fc ff ff       	call   bce <matchwhitespace>
     f33:	83 c4 04             	add    $0x4,%esp
     f36:	eb 2a                	jmp    f62 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f38:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f3c:	50                   	push   %eax
     f3d:	e8 8c fc ff ff       	call   bce <matchwhitespace>
     f42:	83 c4 04             	add    $0x4,%esp
     f45:	85 c0                	test   %eax,%eax
     f47:	0f 94 c0             	sete   %al
     f4a:	0f b6 c0             	movzbl %al,%eax
     f4d:	eb 13                	jmp    f62 <matchone+0xe8>
    default:             return  (p.ch == c);
     f4f:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     f53:	0f b6 d0             	movzbl %al,%edx
     f56:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f5a:	39 c2                	cmp    %eax,%edx
     f5c:	0f 94 c0             	sete   %al
     f5f:	0f b6 c0             	movzbl %al,%eax
  }
}
     f62:	c9                   	leave  
     f63:	c3                   	ret    

00000f64 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     f64:	55                   	push   %ebp
     f65:	89 e5                	mov    %esp,%ebp
     f67:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     f6a:	8b 45 18             	mov    0x18(%ebp),%eax
     f6d:	8b 00                	mov    (%eax),%eax
     f6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     f72:	8b 45 14             	mov    0x14(%ebp),%eax
     f75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     f78:	eb 11                	jmp    f8b <matchstar+0x27>
  {
    text++;
     f7a:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     f7e:	8b 45 18             	mov    0x18(%ebp),%eax
     f81:	8b 00                	mov    (%eax),%eax
     f83:	8d 50 01             	lea    0x1(%eax),%edx
     f86:	8b 45 18             	mov    0x18(%ebp),%eax
     f89:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     f8b:	8b 45 14             	mov    0x14(%ebp),%eax
     f8e:	0f b6 00             	movzbl (%eax),%eax
     f91:	84 c0                	test   %al,%al
     f93:	74 51                	je     fe6 <matchstar+0x82>
     f95:	8b 45 14             	mov    0x14(%ebp),%eax
     f98:	0f b6 00             	movzbl (%eax),%eax
     f9b:	0f be c0             	movsbl %al,%eax
     f9e:	50                   	push   %eax
     f9f:	ff 75 0c             	pushl  0xc(%ebp)
     fa2:	ff 75 08             	pushl  0x8(%ebp)
     fa5:	e8 d0 fe ff ff       	call   e7a <matchone>
     faa:	83 c4 0c             	add    $0xc,%esp
     fad:	85 c0                	test   %eax,%eax
     faf:	75 c9                	jne    f7a <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     fb1:	eb 33                	jmp    fe6 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     fb3:	8b 45 14             	mov    0x14(%ebp),%eax
     fb6:	8d 50 ff             	lea    -0x1(%eax),%edx
     fb9:	89 55 14             	mov    %edx,0x14(%ebp)
     fbc:	83 ec 04             	sub    $0x4,%esp
     fbf:	ff 75 18             	pushl  0x18(%ebp)
     fc2:	50                   	push   %eax
     fc3:	ff 75 10             	pushl  0x10(%ebp)
     fc6:	e8 51 01 00 00       	call   111c <matchpattern>
     fcb:	83 c4 10             	add    $0x10,%esp
     fce:	85 c0                	test   %eax,%eax
     fd0:	74 07                	je     fd9 <matchstar+0x75>
      return 1;
     fd2:	b8 01 00 00 00       	mov    $0x1,%eax
     fd7:	eb 22                	jmp    ffb <matchstar+0x97>
    (*matchlength)--;
     fd9:	8b 45 18             	mov    0x18(%ebp),%eax
     fdc:	8b 00                	mov    (%eax),%eax
     fde:	8d 50 ff             	lea    -0x1(%eax),%edx
     fe1:	8b 45 18             	mov    0x18(%ebp),%eax
     fe4:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     fe6:	8b 45 14             	mov    0x14(%ebp),%eax
     fe9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fec:	73 c5                	jae    fb3 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
     fee:	8b 45 18             	mov    0x18(%ebp),%eax
     ff1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ff4:	89 10                	mov    %edx,(%eax)
  return 0;
     ff6:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ffb:	c9                   	leave  
     ffc:	c3                   	ret    

00000ffd <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     ffd:	55                   	push   %ebp
     ffe:	89 e5                	mov    %esp,%ebp
    1000:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1003:	8b 45 14             	mov    0x14(%ebp),%eax
    1006:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1009:	eb 11                	jmp    101c <matchplus+0x1f>
  {
    text++;
    100b:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    100f:	8b 45 18             	mov    0x18(%ebp),%eax
    1012:	8b 00                	mov    (%eax),%eax
    1014:	8d 50 01             	lea    0x1(%eax),%edx
    1017:	8b 45 18             	mov    0x18(%ebp),%eax
    101a:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    101c:	8b 45 14             	mov    0x14(%ebp),%eax
    101f:	0f b6 00             	movzbl (%eax),%eax
    1022:	84 c0                	test   %al,%al
    1024:	74 51                	je     1077 <matchplus+0x7a>
    1026:	8b 45 14             	mov    0x14(%ebp),%eax
    1029:	0f b6 00             	movzbl (%eax),%eax
    102c:	0f be c0             	movsbl %al,%eax
    102f:	50                   	push   %eax
    1030:	ff 75 0c             	pushl  0xc(%ebp)
    1033:	ff 75 08             	pushl  0x8(%ebp)
    1036:	e8 3f fe ff ff       	call   e7a <matchone>
    103b:	83 c4 0c             	add    $0xc,%esp
    103e:	85 c0                	test   %eax,%eax
    1040:	75 c9                	jne    100b <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1042:	eb 33                	jmp    1077 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    1044:	8b 45 14             	mov    0x14(%ebp),%eax
    1047:	8d 50 ff             	lea    -0x1(%eax),%edx
    104a:	89 55 14             	mov    %edx,0x14(%ebp)
    104d:	83 ec 04             	sub    $0x4,%esp
    1050:	ff 75 18             	pushl  0x18(%ebp)
    1053:	50                   	push   %eax
    1054:	ff 75 10             	pushl  0x10(%ebp)
    1057:	e8 c0 00 00 00       	call   111c <matchpattern>
    105c:	83 c4 10             	add    $0x10,%esp
    105f:	85 c0                	test   %eax,%eax
    1061:	74 07                	je     106a <matchplus+0x6d>
      return 1;
    1063:	b8 01 00 00 00       	mov    $0x1,%eax
    1068:	eb 1a                	jmp    1084 <matchplus+0x87>
    (*matchlength)--;
    106a:	8b 45 18             	mov    0x18(%ebp),%eax
    106d:	8b 00                	mov    (%eax),%eax
    106f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1072:	8b 45 18             	mov    0x18(%ebp),%eax
    1075:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1077:	8b 45 14             	mov    0x14(%ebp),%eax
    107a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    107d:	77 c5                	ja     1044 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    107f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1084:	c9                   	leave  
    1085:	c3                   	ret    

00001086 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1086:	55                   	push   %ebp
    1087:	89 e5                	mov    %esp,%ebp
    1089:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    108c:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1090:	84 c0                	test   %al,%al
    1092:	75 07                	jne    109b <matchquestion+0x15>
    return 1;
    1094:	b8 01 00 00 00       	mov    $0x1,%eax
    1099:	eb 7f                	jmp    111a <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    109b:	83 ec 04             	sub    $0x4,%esp
    109e:	ff 75 18             	pushl  0x18(%ebp)
    10a1:	ff 75 14             	pushl  0x14(%ebp)
    10a4:	ff 75 10             	pushl  0x10(%ebp)
    10a7:	e8 70 00 00 00       	call   111c <matchpattern>
    10ac:	83 c4 10             	add    $0x10,%esp
    10af:	85 c0                	test   %eax,%eax
    10b1:	74 07                	je     10ba <matchquestion+0x34>
      return 1;
    10b3:	b8 01 00 00 00       	mov    $0x1,%eax
    10b8:	eb 60                	jmp    111a <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    10ba:	8b 45 14             	mov    0x14(%ebp),%eax
    10bd:	0f b6 00             	movzbl (%eax),%eax
    10c0:	84 c0                	test   %al,%al
    10c2:	74 51                	je     1115 <matchquestion+0x8f>
    10c4:	8b 45 14             	mov    0x14(%ebp),%eax
    10c7:	8d 50 01             	lea    0x1(%eax),%edx
    10ca:	89 55 14             	mov    %edx,0x14(%ebp)
    10cd:	0f b6 00             	movzbl (%eax),%eax
    10d0:	0f be c0             	movsbl %al,%eax
    10d3:	83 ec 04             	sub    $0x4,%esp
    10d6:	50                   	push   %eax
    10d7:	ff 75 0c             	pushl  0xc(%ebp)
    10da:	ff 75 08             	pushl  0x8(%ebp)
    10dd:	e8 98 fd ff ff       	call   e7a <matchone>
    10e2:	83 c4 10             	add    $0x10,%esp
    10e5:	85 c0                	test   %eax,%eax
    10e7:	74 2c                	je     1115 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    10e9:	83 ec 04             	sub    $0x4,%esp
    10ec:	ff 75 18             	pushl  0x18(%ebp)
    10ef:	ff 75 14             	pushl  0x14(%ebp)
    10f2:	ff 75 10             	pushl  0x10(%ebp)
    10f5:	e8 22 00 00 00       	call   111c <matchpattern>
    10fa:	83 c4 10             	add    $0x10,%esp
    10fd:	85 c0                	test   %eax,%eax
    10ff:	74 14                	je     1115 <matchquestion+0x8f>
    {
      (*matchlength)++;
    1101:	8b 45 18             	mov    0x18(%ebp),%eax
    1104:	8b 00                	mov    (%eax),%eax
    1106:	8d 50 01             	lea    0x1(%eax),%edx
    1109:	8b 45 18             	mov    0x18(%ebp),%eax
    110c:	89 10                	mov    %edx,(%eax)
      return 1;
    110e:	b8 01 00 00 00       	mov    $0x1,%eax
    1113:	eb 05                	jmp    111a <matchquestion+0x94>
    }
  }
  return 0;
    1115:	b8 00 00 00 00       	mov    $0x0,%eax
}
    111a:	c9                   	leave  
    111b:	c3                   	ret    

0000111c <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    111c:	55                   	push   %ebp
    111d:	89 e5                	mov    %esp,%ebp
    111f:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1122:	8b 45 10             	mov    0x10(%ebp),%eax
    1125:	8b 00                	mov    (%eax),%eax
    1127:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    112a:	8b 45 08             	mov    0x8(%ebp),%eax
    112d:	0f b6 00             	movzbl (%eax),%eax
    1130:	84 c0                	test   %al,%al
    1132:	74 0d                	je     1141 <matchpattern+0x25>
    1134:	8b 45 08             	mov    0x8(%ebp),%eax
    1137:	83 c0 08             	add    $0x8,%eax
    113a:	0f b6 00             	movzbl (%eax),%eax
    113d:	3c 04                	cmp    $0x4,%al
    113f:	75 25                	jne    1166 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1141:	8b 45 08             	mov    0x8(%ebp),%eax
    1144:	83 c0 10             	add    $0x10,%eax
    1147:	83 ec 0c             	sub    $0xc,%esp
    114a:	ff 75 10             	pushl  0x10(%ebp)
    114d:	ff 75 0c             	pushl  0xc(%ebp)
    1150:	50                   	push   %eax
    1151:	8b 45 08             	mov    0x8(%ebp),%eax
    1154:	ff 70 04             	pushl  0x4(%eax)
    1157:	ff 30                	pushl  (%eax)
    1159:	e8 28 ff ff ff       	call   1086 <matchquestion>
    115e:	83 c4 20             	add    $0x20,%esp
    1161:	e9 dd 00 00 00       	jmp    1243 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	83 c0 08             	add    $0x8,%eax
    116c:	0f b6 00             	movzbl (%eax),%eax
    116f:	3c 05                	cmp    $0x5,%al
    1171:	75 25                	jne    1198 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	83 c0 10             	add    $0x10,%eax
    1179:	83 ec 0c             	sub    $0xc,%esp
    117c:	ff 75 10             	pushl  0x10(%ebp)
    117f:	ff 75 0c             	pushl  0xc(%ebp)
    1182:	50                   	push   %eax
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	ff 70 04             	pushl  0x4(%eax)
    1189:	ff 30                	pushl  (%eax)
    118b:	e8 d4 fd ff ff       	call   f64 <matchstar>
    1190:	83 c4 20             	add    $0x20,%esp
    1193:	e9 ab 00 00 00       	jmp    1243 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    1198:	8b 45 08             	mov    0x8(%ebp),%eax
    119b:	83 c0 08             	add    $0x8,%eax
    119e:	0f b6 00             	movzbl (%eax),%eax
    11a1:	3c 06                	cmp    $0x6,%al
    11a3:	75 22                	jne    11c7 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	83 c0 10             	add    $0x10,%eax
    11ab:	83 ec 0c             	sub    $0xc,%esp
    11ae:	ff 75 10             	pushl  0x10(%ebp)
    11b1:	ff 75 0c             	pushl  0xc(%ebp)
    11b4:	50                   	push   %eax
    11b5:	8b 45 08             	mov    0x8(%ebp),%eax
    11b8:	ff 70 04             	pushl  0x4(%eax)
    11bb:	ff 30                	pushl  (%eax)
    11bd:	e8 3b fe ff ff       	call   ffd <matchplus>
    11c2:	83 c4 20             	add    $0x20,%esp
    11c5:	eb 7c                	jmp    1243 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    11c7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ca:	0f b6 00             	movzbl (%eax),%eax
    11cd:	3c 03                	cmp    $0x3,%al
    11cf:	75 1d                	jne    11ee <matchpattern+0xd2>
    11d1:	8b 45 08             	mov    0x8(%ebp),%eax
    11d4:	83 c0 08             	add    $0x8,%eax
    11d7:	0f b6 00             	movzbl (%eax),%eax
    11da:	84 c0                	test   %al,%al
    11dc:	75 10                	jne    11ee <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    11de:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e1:	0f b6 00             	movzbl (%eax),%eax
    11e4:	84 c0                	test   %al,%al
    11e6:	0f 94 c0             	sete   %al
    11e9:	0f b6 c0             	movzbl %al,%eax
    11ec:	eb 55                	jmp    1243 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    11ee:	8b 45 10             	mov    0x10(%ebp),%eax
    11f1:	8b 00                	mov    (%eax),%eax
    11f3:	8d 50 01             	lea    0x1(%eax),%edx
    11f6:	8b 45 10             	mov    0x10(%ebp),%eax
    11f9:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    11fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fe:	0f b6 00             	movzbl (%eax),%eax
    1201:	84 c0                	test   %al,%al
    1203:	74 31                	je     1236 <matchpattern+0x11a>
    1205:	8b 45 0c             	mov    0xc(%ebp),%eax
    1208:	8d 50 01             	lea    0x1(%eax),%edx
    120b:	89 55 0c             	mov    %edx,0xc(%ebp)
    120e:	0f b6 00             	movzbl (%eax),%eax
    1211:	0f be d0             	movsbl %al,%edx
    1214:	8b 45 08             	mov    0x8(%ebp),%eax
    1217:	8d 48 08             	lea    0x8(%eax),%ecx
    121a:	89 4d 08             	mov    %ecx,0x8(%ebp)
    121d:	83 ec 04             	sub    $0x4,%esp
    1220:	52                   	push   %edx
    1221:	ff 70 04             	pushl  0x4(%eax)
    1224:	ff 30                	pushl  (%eax)
    1226:	e8 4f fc ff ff       	call   e7a <matchone>
    122b:	83 c4 10             	add    $0x10,%esp
    122e:	85 c0                	test   %eax,%eax
    1230:	0f 85 f4 fe ff ff    	jne    112a <matchpattern+0xe>

  *matchlength = pre;
    1236:	8b 45 10             	mov    0x10(%ebp),%eax
    1239:	8b 55 f4             	mov    -0xc(%ebp),%edx
    123c:	89 10                	mov    %edx,(%eax)
  return 0;
    123e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1243:	c9                   	leave  
    1244:	c3                   	ret    
