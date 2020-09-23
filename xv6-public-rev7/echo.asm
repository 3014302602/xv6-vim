
_echo:     file format elf32-i386


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

  for(i = 1; i < argc; i++)
      14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
      1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      20:	83 c0 01             	add    $0x1,%eax
      23:	3b 03                	cmp    (%ebx),%eax
      25:	7d 07                	jge    2e <main+0x2e>
      27:	ba 80 12 00 00       	mov    $0x1280,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 82 12 00 00       	mov    $0x1282,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 84 12 00 00       	push   $0x1284
      4b:	6a 01                	push   $0x1
      4d:	e8 41 04 00 00       	call   493 <printf>
      52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
      55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      59:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5c:	3b 03                	cmp    (%ebx),%eax
      5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
      60:	e8 57 02 00 00       	call   2bc <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      65:	55                   	push   %ebp
      66:	89 e5                	mov    %esp,%ebp
      68:	57                   	push   %edi
      69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      6d:	8b 55 10             	mov    0x10(%ebp),%edx
      70:	8b 45 0c             	mov    0xc(%ebp),%eax
      73:	89 cb                	mov    %ecx,%ebx
      75:	89 df                	mov    %ebx,%edi
      77:	89 d1                	mov    %edx,%ecx
      79:	fc                   	cld    
      7a:	f3 aa                	rep stos %al,%es:(%edi)
      7c:	89 ca                	mov    %ecx,%edx
      7e:	89 fb                	mov    %edi,%ebx
      80:	89 5d 08             	mov    %ebx,0x8(%ebp)
      83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      86:	90                   	nop
      87:	5b                   	pop    %ebx
      88:	5f                   	pop    %edi
      89:	5d                   	pop    %ebp
      8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      8b:	55                   	push   %ebp
      8c:	89 e5                	mov    %esp,%ebp
      8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      91:	8b 45 08             	mov    0x8(%ebp),%eax
      94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      97:	90                   	nop
      98:	8b 45 08             	mov    0x8(%ebp),%eax
      9b:	8d 50 01             	lea    0x1(%eax),%edx
      9e:	89 55 08             	mov    %edx,0x8(%ebp)
      a1:	8b 55 0c             	mov    0xc(%ebp),%edx
      a4:	8d 4a 01             	lea    0x1(%edx),%ecx
      a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      aa:	0f b6 12             	movzbl (%edx),%edx
      ad:	88 10                	mov    %dl,(%eax)
      af:	0f b6 00             	movzbl (%eax),%eax
      b2:	84 c0                	test   %al,%al
      b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
      b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      b9:	c9                   	leave  
      ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
      bb:	55                   	push   %ebp
      bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
      c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      c8:	8b 45 08             	mov    0x8(%ebp),%eax
      cb:	0f b6 00             	movzbl (%eax),%eax
      ce:	84 c0                	test   %al,%al
      d0:	74 10                	je     e2 <strcmp+0x27>
      d2:	8b 45 08             	mov    0x8(%ebp),%eax
      d5:	0f b6 10             	movzbl (%eax),%edx
      d8:	8b 45 0c             	mov    0xc(%ebp),%eax
      db:	0f b6 00             	movzbl (%eax),%eax
      de:	38 c2                	cmp    %al,%dl
      e0:	74 de                	je     c0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      e2:	8b 45 08             	mov    0x8(%ebp),%eax
      e5:	0f b6 00             	movzbl (%eax),%eax
      e8:	0f b6 d0             	movzbl %al,%edx
      eb:	8b 45 0c             	mov    0xc(%ebp),%eax
      ee:	0f b6 00             	movzbl (%eax),%eax
      f1:	0f b6 c0             	movzbl %al,%eax
      f4:	29 c2                	sub    %eax,%edx
      f6:	89 d0                	mov    %edx,%eax
}
      f8:	5d                   	pop    %ebp
      f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(char *s)
{
      fa:	55                   	push   %ebp
      fb:	89 e5                	mov    %esp,%ebp
      fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     107:	eb 04                	jmp    10d <strlen+0x13>
     109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     110:	8b 45 08             	mov    0x8(%ebp),%eax
     113:	01 d0                	add    %edx,%eax
     115:	0f b6 00             	movzbl (%eax),%eax
     118:	84 c0                	test   %al,%al
     11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
     11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     11f:	c9                   	leave  
     120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
     121:	55                   	push   %ebp
     122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     124:	8b 45 10             	mov    0x10(%ebp),%eax
     127:	50                   	push   %eax
     128:	ff 75 0c             	pushl  0xc(%ebp)
     12b:	ff 75 08             	pushl  0x8(%ebp)
     12e:	e8 32 ff ff ff       	call   65 <stosb>
     133:	83 c4 0c             	add    $0xc,%esp
  return dst;
     136:	8b 45 08             	mov    0x8(%ebp),%eax
}
     139:	c9                   	leave  
     13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
     13b:	55                   	push   %ebp
     13c:	89 e5                	mov    %esp,%ebp
     13e:	83 ec 04             	sub    $0x4,%esp
     141:	8b 45 0c             	mov    0xc(%ebp),%eax
     144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     147:	eb 14                	jmp    15d <strchr+0x22>
    if(*s == c)
     149:	8b 45 08             	mov    0x8(%ebp),%eax
     14c:	0f b6 00             	movzbl (%eax),%eax
     14f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     152:	75 05                	jne    159 <strchr+0x1e>
      return (char*)s;
     154:	8b 45 08             	mov    0x8(%ebp),%eax
     157:	eb 13                	jmp    16c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     15d:	8b 45 08             	mov    0x8(%ebp),%eax
     160:	0f b6 00             	movzbl (%eax),%eax
     163:	84 c0                	test   %al,%al
     165:	75 e2                	jne    149 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     167:	b8 00 00 00 00       	mov    $0x0,%eax
}
     16c:	c9                   	leave  
     16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
     16e:	55                   	push   %ebp
     16f:	89 e5                	mov    %esp,%ebp
     171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     17b:	eb 42                	jmp    1bf <gets+0x51>
    cc = read(0, &c, 1);
     17d:	83 ec 04             	sub    $0x4,%esp
     180:	6a 01                	push   $0x1
     182:	8d 45 ef             	lea    -0x11(%ebp),%eax
     185:	50                   	push   %eax
     186:	6a 00                	push   $0x0
     188:	e8 47 01 00 00       	call   2d4 <read>
     18d:	83 c4 10             	add    $0x10,%esp
     190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     197:	7e 33                	jle    1cc <gets+0x5e>
      break;
    buf[i++] = c;
     199:	8b 45 f4             	mov    -0xc(%ebp),%eax
     19c:	8d 50 01             	lea    0x1(%eax),%edx
     19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1a2:	89 c2                	mov    %eax,%edx
     1a4:	8b 45 08             	mov    0x8(%ebp),%eax
     1a7:	01 c2                	add    %eax,%edx
     1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1b3:	3c 0a                	cmp    $0xa,%al
     1b5:	74 16                	je     1cd <gets+0x5f>
     1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1bb:	3c 0d                	cmp    $0xd,%al
     1bd:	74 0e                	je     1cd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c2:	83 c0 01             	add    $0x1,%eax
     1c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1c8:	7c b3                	jl     17d <gets+0xf>
     1ca:	eb 01                	jmp    1cd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1cc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1d0:	8b 45 08             	mov    0x8(%ebp),%eax
     1d3:	01 d0                	add    %edx,%eax
     1d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1db:	c9                   	leave  
     1dc:	c3                   	ret    

000001dd <stat>:

int
stat(char *n, struct stat *st)
{
     1dd:	55                   	push   %ebp
     1de:	89 e5                	mov    %esp,%ebp
     1e0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1e3:	83 ec 08             	sub    $0x8,%esp
     1e6:	6a 00                	push   $0x0
     1e8:	ff 75 08             	pushl  0x8(%ebp)
     1eb:	e8 0c 01 00 00       	call   2fc <open>
     1f0:	83 c4 10             	add    $0x10,%esp
     1f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1fa:	79 07                	jns    203 <stat+0x26>
    return -1;
     1fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     201:	eb 25                	jmp    228 <stat+0x4b>
  r = fstat(fd, st);
     203:	83 ec 08             	sub    $0x8,%esp
     206:	ff 75 0c             	pushl  0xc(%ebp)
     209:	ff 75 f4             	pushl  -0xc(%ebp)
     20c:	e8 03 01 00 00       	call   314 <fstat>
     211:	83 c4 10             	add    $0x10,%esp
     214:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     217:	83 ec 0c             	sub    $0xc,%esp
     21a:	ff 75 f4             	pushl  -0xc(%ebp)
     21d:	e8 c2 00 00 00       	call   2e4 <close>
     222:	83 c4 10             	add    $0x10,%esp
  return r;
     225:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     228:	c9                   	leave  
     229:	c3                   	ret    

0000022a <atoi>:

int
atoi(const char *s)
{
     22a:	55                   	push   %ebp
     22b:	89 e5                	mov    %esp,%ebp
     22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     237:	eb 25                	jmp    25e <atoi+0x34>
    n = n*10 + *s++ - '0';
     239:	8b 55 fc             	mov    -0x4(%ebp),%edx
     23c:	89 d0                	mov    %edx,%eax
     23e:	c1 e0 02             	shl    $0x2,%eax
     241:	01 d0                	add    %edx,%eax
     243:	01 c0                	add    %eax,%eax
     245:	89 c1                	mov    %eax,%ecx
     247:	8b 45 08             	mov    0x8(%ebp),%eax
     24a:	8d 50 01             	lea    0x1(%eax),%edx
     24d:	89 55 08             	mov    %edx,0x8(%ebp)
     250:	0f b6 00             	movzbl (%eax),%eax
     253:	0f be c0             	movsbl %al,%eax
     256:	01 c8                	add    %ecx,%eax
     258:	83 e8 30             	sub    $0x30,%eax
     25b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     25e:	8b 45 08             	mov    0x8(%ebp),%eax
     261:	0f b6 00             	movzbl (%eax),%eax
     264:	3c 2f                	cmp    $0x2f,%al
     266:	7e 0a                	jle    272 <atoi+0x48>
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	0f b6 00             	movzbl (%eax),%eax
     26e:	3c 39                	cmp    $0x39,%al
     270:	7e c7                	jle    239 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     272:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     275:	c9                   	leave  
     276:	c3                   	ret    

00000277 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     277:	55                   	push   %ebp
     278:	89 e5                	mov    %esp,%ebp
     27a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     27d:	8b 45 08             	mov    0x8(%ebp),%eax
     280:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     283:	8b 45 0c             	mov    0xc(%ebp),%eax
     286:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     289:	eb 17                	jmp    2a2 <memmove+0x2b>
    *dst++ = *src++;
     28b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     28e:	8d 50 01             	lea    0x1(%eax),%edx
     291:	89 55 fc             	mov    %edx,-0x4(%ebp)
     294:	8b 55 f8             	mov    -0x8(%ebp),%edx
     297:	8d 4a 01             	lea    0x1(%edx),%ecx
     29a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     29d:	0f b6 12             	movzbl (%edx),%edx
     2a0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2a2:	8b 45 10             	mov    0x10(%ebp),%eax
     2a5:	8d 50 ff             	lea    -0x1(%eax),%edx
     2a8:	89 55 10             	mov    %edx,0x10(%ebp)
     2ab:	85 c0                	test   %eax,%eax
     2ad:	7f dc                	jg     28b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2af:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2b2:	c9                   	leave  
     2b3:	c3                   	ret    

000002b4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2b4:	b8 01 00 00 00       	mov    $0x1,%eax
     2b9:	cd 40                	int    $0x40
     2bb:	c3                   	ret    

000002bc <exit>:
SYSCALL(exit)
     2bc:	b8 02 00 00 00       	mov    $0x2,%eax
     2c1:	cd 40                	int    $0x40
     2c3:	c3                   	ret    

000002c4 <wait>:
SYSCALL(wait)
     2c4:	b8 03 00 00 00       	mov    $0x3,%eax
     2c9:	cd 40                	int    $0x40
     2cb:	c3                   	ret    

000002cc <pipe>:
SYSCALL(pipe)
     2cc:	b8 04 00 00 00       	mov    $0x4,%eax
     2d1:	cd 40                	int    $0x40
     2d3:	c3                   	ret    

000002d4 <read>:
SYSCALL(read)
     2d4:	b8 05 00 00 00       	mov    $0x5,%eax
     2d9:	cd 40                	int    $0x40
     2db:	c3                   	ret    

000002dc <write>:
SYSCALL(write)
     2dc:	b8 10 00 00 00       	mov    $0x10,%eax
     2e1:	cd 40                	int    $0x40
     2e3:	c3                   	ret    

000002e4 <close>:
SYSCALL(close)
     2e4:	b8 15 00 00 00       	mov    $0x15,%eax
     2e9:	cd 40                	int    $0x40
     2eb:	c3                   	ret    

000002ec <kill>:
SYSCALL(kill)
     2ec:	b8 06 00 00 00       	mov    $0x6,%eax
     2f1:	cd 40                	int    $0x40
     2f3:	c3                   	ret    

000002f4 <exec>:
SYSCALL(exec)
     2f4:	b8 07 00 00 00       	mov    $0x7,%eax
     2f9:	cd 40                	int    $0x40
     2fb:	c3                   	ret    

000002fc <open>:
SYSCALL(open)
     2fc:	b8 0f 00 00 00       	mov    $0xf,%eax
     301:	cd 40                	int    $0x40
     303:	c3                   	ret    

00000304 <mknod>:
SYSCALL(mknod)
     304:	b8 11 00 00 00       	mov    $0x11,%eax
     309:	cd 40                	int    $0x40
     30b:	c3                   	ret    

0000030c <unlink>:
SYSCALL(unlink)
     30c:	b8 12 00 00 00       	mov    $0x12,%eax
     311:	cd 40                	int    $0x40
     313:	c3                   	ret    

00000314 <fstat>:
SYSCALL(fstat)
     314:	b8 08 00 00 00       	mov    $0x8,%eax
     319:	cd 40                	int    $0x40
     31b:	c3                   	ret    

0000031c <link>:
SYSCALL(link)
     31c:	b8 13 00 00 00       	mov    $0x13,%eax
     321:	cd 40                	int    $0x40
     323:	c3                   	ret    

00000324 <mkdir>:
SYSCALL(mkdir)
     324:	b8 14 00 00 00       	mov    $0x14,%eax
     329:	cd 40                	int    $0x40
     32b:	c3                   	ret    

0000032c <chdir>:
SYSCALL(chdir)
     32c:	b8 09 00 00 00       	mov    $0x9,%eax
     331:	cd 40                	int    $0x40
     333:	c3                   	ret    

00000334 <dup>:
SYSCALL(dup)
     334:	b8 0a 00 00 00       	mov    $0xa,%eax
     339:	cd 40                	int    $0x40
     33b:	c3                   	ret    

0000033c <getpid>:
SYSCALL(getpid)
     33c:	b8 0b 00 00 00       	mov    $0xb,%eax
     341:	cd 40                	int    $0x40
     343:	c3                   	ret    

00000344 <sbrk>:
SYSCALL(sbrk)
     344:	b8 0c 00 00 00       	mov    $0xc,%eax
     349:	cd 40                	int    $0x40
     34b:	c3                   	ret    

0000034c <sleep>:
SYSCALL(sleep)
     34c:	b8 0d 00 00 00       	mov    $0xd,%eax
     351:	cd 40                	int    $0x40
     353:	c3                   	ret    

00000354 <uptime>:
SYSCALL(uptime)
     354:	b8 0e 00 00 00       	mov    $0xe,%eax
     359:	cd 40                	int    $0x40
     35b:	c3                   	ret    

0000035c <setCursorPos>:


//add
SYSCALL(setCursorPos)
     35c:	b8 16 00 00 00       	mov    $0x16,%eax
     361:	cd 40                	int    $0x40
     363:	c3                   	ret    

00000364 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     364:	b8 17 00 00 00       	mov    $0x17,%eax
     369:	cd 40                	int    $0x40
     36b:	c3                   	ret    

0000036c <clearScreen>:
SYSCALL(clearScreen)
     36c:	b8 18 00 00 00       	mov    $0x18,%eax
     371:	cd 40                	int    $0x40
     373:	c3                   	ret    

00000374 <writeAt>:
SYSCALL(writeAt)
     374:	b8 19 00 00 00       	mov    $0x19,%eax
     379:	cd 40                	int    $0x40
     37b:	c3                   	ret    

0000037c <setBufferFlag>:
SYSCALL(setBufferFlag)
     37c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     381:	cd 40                	int    $0x40
     383:	c3                   	ret    

00000384 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     384:	b8 1b 00 00 00       	mov    $0x1b,%eax
     389:	cd 40                	int    $0x40
     38b:	c3                   	ret    

0000038c <getCursorPos>:
SYSCALL(getCursorPos)
     38c:	b8 1c 00 00 00       	mov    $0x1c,%eax
     391:	cd 40                	int    $0x40
     393:	c3                   	ret    

00000394 <saveScreen>:
SYSCALL(saveScreen)
     394:	b8 1d 00 00 00       	mov    $0x1d,%eax
     399:	cd 40                	int    $0x40
     39b:	c3                   	ret    

0000039c <recorverScreen>:
SYSCALL(recorverScreen)
     39c:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3a1:	cd 40                	int    $0x40
     3a3:	c3                   	ret    

000003a4 <ToScreen>:
SYSCALL(ToScreen)
     3a4:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3a9:	cd 40                	int    $0x40
     3ab:	c3                   	ret    

000003ac <getColor>:
SYSCALL(getColor)
     3ac:	b8 20 00 00 00       	mov    $0x20,%eax
     3b1:	cd 40                	int    $0x40
     3b3:	c3                   	ret    

000003b4 <showC>:
SYSCALL(showC)
     3b4:	b8 21 00 00 00       	mov    $0x21,%eax
     3b9:	cd 40                	int    $0x40
     3bb:	c3                   	ret    

000003bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
     3c2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3c8:	83 ec 04             	sub    $0x4,%esp
     3cb:	6a 01                	push   $0x1
     3cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3d0:	50                   	push   %eax
     3d1:	ff 75 08             	pushl  0x8(%ebp)
     3d4:	e8 03 ff ff ff       	call   2dc <write>
     3d9:	83 c4 10             	add    $0x10,%esp
}
     3dc:	90                   	nop
     3dd:	c9                   	leave  
     3de:	c3                   	ret    

000003df <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3df:	55                   	push   %ebp
     3e0:	89 e5                	mov    %esp,%ebp
     3e2:	53                   	push   %ebx
     3e3:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3ed:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3f1:	74 17                	je     40a <printint+0x2b>
     3f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3f7:	79 11                	jns    40a <printint+0x2b>
    neg = 1;
     3f9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     400:	8b 45 0c             	mov    0xc(%ebp),%eax
     403:	f7 d8                	neg    %eax
     405:	89 45 ec             	mov    %eax,-0x14(%ebp)
     408:	eb 06                	jmp    410 <printint+0x31>
  } else {
    x = xx;
     40a:	8b 45 0c             	mov    0xc(%ebp),%eax
     40d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     410:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     417:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     41a:	8d 41 01             	lea    0x1(%ecx),%eax
     41d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     420:	8b 5d 10             	mov    0x10(%ebp),%ebx
     423:	8b 45 ec             	mov    -0x14(%ebp),%eax
     426:	ba 00 00 00 00       	mov    $0x0,%edx
     42b:	f7 f3                	div    %ebx
     42d:	89 d0                	mov    %edx,%eax
     42f:	0f b6 80 a8 19 00 00 	movzbl 0x19a8(%eax),%eax
     436:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     43a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     43d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     440:	ba 00 00 00 00       	mov    $0x0,%edx
     445:	f7 f3                	div    %ebx
     447:	89 45 ec             	mov    %eax,-0x14(%ebp)
     44a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     44e:	75 c7                	jne    417 <printint+0x38>
  if(neg)
     450:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     454:	74 2d                	je     483 <printint+0xa4>
    buf[i++] = '-';
     456:	8b 45 f4             	mov    -0xc(%ebp),%eax
     459:	8d 50 01             	lea    0x1(%eax),%edx
     45c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     45f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     464:	eb 1d                	jmp    483 <printint+0xa4>
    putc(fd, buf[i]);
     466:	8d 55 dc             	lea    -0x24(%ebp),%edx
     469:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46c:	01 d0                	add    %edx,%eax
     46e:	0f b6 00             	movzbl (%eax),%eax
     471:	0f be c0             	movsbl %al,%eax
     474:	83 ec 08             	sub    $0x8,%esp
     477:	50                   	push   %eax
     478:	ff 75 08             	pushl  0x8(%ebp)
     47b:	e8 3c ff ff ff       	call   3bc <putc>
     480:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     483:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     487:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     48b:	79 d9                	jns    466 <printint+0x87>
    putc(fd, buf[i]);
}
     48d:	90                   	nop
     48e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     491:	c9                   	leave  
     492:	c3                   	ret    

00000493 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     493:	55                   	push   %ebp
     494:	89 e5                	mov    %esp,%ebp
     496:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     499:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4a0:	8d 45 0c             	lea    0xc(%ebp),%eax
     4a3:	83 c0 04             	add    $0x4,%eax
     4a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4b0:	e9 59 01 00 00       	jmp    60e <printf+0x17b>
    c = fmt[i] & 0xff;
     4b5:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4bb:	01 d0                	add    %edx,%eax
     4bd:	0f b6 00             	movzbl (%eax),%eax
     4c0:	0f be c0             	movsbl %al,%eax
     4c3:	25 ff 00 00 00       	and    $0xff,%eax
     4c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4cf:	75 2c                	jne    4fd <printf+0x6a>
      if(c == '%'){
     4d1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d5:	75 0c                	jne    4e3 <printf+0x50>
        state = '%';
     4d7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4de:	e9 27 01 00 00       	jmp    60a <printf+0x177>
      } else {
        putc(fd, c);
     4e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e6:	0f be c0             	movsbl %al,%eax
     4e9:	83 ec 08             	sub    $0x8,%esp
     4ec:	50                   	push   %eax
     4ed:	ff 75 08             	pushl  0x8(%ebp)
     4f0:	e8 c7 fe ff ff       	call   3bc <putc>
     4f5:	83 c4 10             	add    $0x10,%esp
     4f8:	e9 0d 01 00 00       	jmp    60a <printf+0x177>
      }
    } else if(state == '%'){
     4fd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     501:	0f 85 03 01 00 00    	jne    60a <printf+0x177>
      if(c == 'd'){
     507:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     50b:	75 1e                	jne    52b <printf+0x98>
        printint(fd, *ap, 10, 1);
     50d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     510:	8b 00                	mov    (%eax),%eax
     512:	6a 01                	push   $0x1
     514:	6a 0a                	push   $0xa
     516:	50                   	push   %eax
     517:	ff 75 08             	pushl  0x8(%ebp)
     51a:	e8 c0 fe ff ff       	call   3df <printint>
     51f:	83 c4 10             	add    $0x10,%esp
        ap++;
     522:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     526:	e9 d8 00 00 00       	jmp    603 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     52b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     52f:	74 06                	je     537 <printf+0xa4>
     531:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     535:	75 1e                	jne    555 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     537:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53a:	8b 00                	mov    (%eax),%eax
     53c:	6a 00                	push   $0x0
     53e:	6a 10                	push   $0x10
     540:	50                   	push   %eax
     541:	ff 75 08             	pushl  0x8(%ebp)
     544:	e8 96 fe ff ff       	call   3df <printint>
     549:	83 c4 10             	add    $0x10,%esp
        ap++;
     54c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     550:	e9 ae 00 00 00       	jmp    603 <printf+0x170>
      } else if(c == 's'){
     555:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     559:	75 43                	jne    59e <printf+0x10b>
        s = (char*)*ap;
     55b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     55e:	8b 00                	mov    (%eax),%eax
     560:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     567:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     56b:	75 25                	jne    592 <printf+0xff>
          s = "(null)";
     56d:	c7 45 f4 89 12 00 00 	movl   $0x1289,-0xc(%ebp)
        while(*s != 0){
     574:	eb 1c                	jmp    592 <printf+0xff>
          putc(fd, *s);
     576:	8b 45 f4             	mov    -0xc(%ebp),%eax
     579:	0f b6 00             	movzbl (%eax),%eax
     57c:	0f be c0             	movsbl %al,%eax
     57f:	83 ec 08             	sub    $0x8,%esp
     582:	50                   	push   %eax
     583:	ff 75 08             	pushl  0x8(%ebp)
     586:	e8 31 fe ff ff       	call   3bc <putc>
     58b:	83 c4 10             	add    $0x10,%esp
          s++;
     58e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     592:	8b 45 f4             	mov    -0xc(%ebp),%eax
     595:	0f b6 00             	movzbl (%eax),%eax
     598:	84 c0                	test   %al,%al
     59a:	75 da                	jne    576 <printf+0xe3>
     59c:	eb 65                	jmp    603 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     59e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5a2:	75 1d                	jne    5c1 <printf+0x12e>
        putc(fd, *ap);
     5a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a7:	8b 00                	mov    (%eax),%eax
     5a9:	0f be c0             	movsbl %al,%eax
     5ac:	83 ec 08             	sub    $0x8,%esp
     5af:	50                   	push   %eax
     5b0:	ff 75 08             	pushl  0x8(%ebp)
     5b3:	e8 04 fe ff ff       	call   3bc <putc>
     5b8:	83 c4 10             	add    $0x10,%esp
        ap++;
     5bb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5bf:	eb 42                	jmp    603 <printf+0x170>
      } else if(c == '%'){
     5c1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c5:	75 17                	jne    5de <printf+0x14b>
        putc(fd, c);
     5c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ca:	0f be c0             	movsbl %al,%eax
     5cd:	83 ec 08             	sub    $0x8,%esp
     5d0:	50                   	push   %eax
     5d1:	ff 75 08             	pushl  0x8(%ebp)
     5d4:	e8 e3 fd ff ff       	call   3bc <putc>
     5d9:	83 c4 10             	add    $0x10,%esp
     5dc:	eb 25                	jmp    603 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5de:	83 ec 08             	sub    $0x8,%esp
     5e1:	6a 25                	push   $0x25
     5e3:	ff 75 08             	pushl  0x8(%ebp)
     5e6:	e8 d1 fd ff ff       	call   3bc <putc>
     5eb:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5f1:	0f be c0             	movsbl %al,%eax
     5f4:	83 ec 08             	sub    $0x8,%esp
     5f7:	50                   	push   %eax
     5f8:	ff 75 08             	pushl  0x8(%ebp)
     5fb:	e8 bc fd ff ff       	call   3bc <putc>
     600:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     603:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     60a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     60e:	8b 55 0c             	mov    0xc(%ebp),%edx
     611:	8b 45 f0             	mov    -0x10(%ebp),%eax
     614:	01 d0                	add    %edx,%eax
     616:	0f b6 00             	movzbl (%eax),%eax
     619:	84 c0                	test   %al,%al
     61b:	0f 85 94 fe ff ff    	jne    4b5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     621:	90                   	nop
     622:	c9                   	leave  
     623:	c3                   	ret    

00000624 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     624:	55                   	push   %ebp
     625:	89 e5                	mov    %esp,%ebp
     627:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     62a:	8b 45 08             	mov    0x8(%ebp),%eax
     62d:	83 e8 08             	sub    $0x8,%eax
     630:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     633:	a1 c8 19 00 00       	mov    0x19c8,%eax
     638:	89 45 fc             	mov    %eax,-0x4(%ebp)
     63b:	eb 24                	jmp    661 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     640:	8b 00                	mov    (%eax),%eax
     642:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     645:	77 12                	ja     659 <free+0x35>
     647:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64d:	77 24                	ja     673 <free+0x4f>
     64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     652:	8b 00                	mov    (%eax),%eax
     654:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     657:	77 1a                	ja     673 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     659:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65c:	8b 00                	mov    (%eax),%eax
     65e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     661:	8b 45 f8             	mov    -0x8(%ebp),%eax
     664:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     667:	76 d4                	jbe    63d <free+0x19>
     669:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66c:	8b 00                	mov    (%eax),%eax
     66e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     671:	76 ca                	jbe    63d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     673:	8b 45 f8             	mov    -0x8(%ebp),%eax
     676:	8b 40 04             	mov    0x4(%eax),%eax
     679:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     680:	8b 45 f8             	mov    -0x8(%ebp),%eax
     683:	01 c2                	add    %eax,%edx
     685:	8b 45 fc             	mov    -0x4(%ebp),%eax
     688:	8b 00                	mov    (%eax),%eax
     68a:	39 c2                	cmp    %eax,%edx
     68c:	75 24                	jne    6b2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     68e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     691:	8b 50 04             	mov    0x4(%eax),%edx
     694:	8b 45 fc             	mov    -0x4(%ebp),%eax
     697:	8b 00                	mov    (%eax),%eax
     699:	8b 40 04             	mov    0x4(%eax),%eax
     69c:	01 c2                	add    %eax,%edx
     69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a7:	8b 00                	mov    (%eax),%eax
     6a9:	8b 10                	mov    (%eax),%edx
     6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ae:	89 10                	mov    %edx,(%eax)
     6b0:	eb 0a                	jmp    6bc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b5:	8b 10                	mov    (%eax),%edx
     6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ba:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bf:	8b 40 04             	mov    0x4(%eax),%eax
     6c2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	01 d0                	add    %edx,%eax
     6ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d1:	75 20                	jne    6f3 <free+0xcf>
    p->s.size += bp->s.size;
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 50 04             	mov    0x4(%eax),%edx
     6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6dc:	8b 40 04             	mov    0x4(%eax),%eax
     6df:	01 c2                	add    %eax,%edx
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ea:	8b 10                	mov    (%eax),%edx
     6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ef:	89 10                	mov    %edx,(%eax)
     6f1:	eb 08                	jmp    6fb <free+0xd7>
  } else
    p->s.ptr = bp;
     6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f9:	89 10                	mov    %edx,(%eax)
  freep = p;
     6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fe:	a3 c8 19 00 00       	mov    %eax,0x19c8
}
     703:	90                   	nop
     704:	c9                   	leave  
     705:	c3                   	ret    

00000706 <morecore>:

static Header*
morecore(uint nu)
{
     706:	55                   	push   %ebp
     707:	89 e5                	mov    %esp,%ebp
     709:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     70c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     713:	77 07                	ja     71c <morecore+0x16>
    nu = 4096;
     715:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     71c:	8b 45 08             	mov    0x8(%ebp),%eax
     71f:	c1 e0 03             	shl    $0x3,%eax
     722:	83 ec 0c             	sub    $0xc,%esp
     725:	50                   	push   %eax
     726:	e8 19 fc ff ff       	call   344 <sbrk>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     731:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     735:	75 07                	jne    73e <morecore+0x38>
    return 0;
     737:	b8 00 00 00 00       	mov    $0x0,%eax
     73c:	eb 26                	jmp    764 <morecore+0x5e>
  hp = (Header*)p;
     73e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     741:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     744:	8b 45 f0             	mov    -0x10(%ebp),%eax
     747:	8b 55 08             	mov    0x8(%ebp),%edx
     74a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     750:	83 c0 08             	add    $0x8,%eax
     753:	83 ec 0c             	sub    $0xc,%esp
     756:	50                   	push   %eax
     757:	e8 c8 fe ff ff       	call   624 <free>
     75c:	83 c4 10             	add    $0x10,%esp
  return freep;
     75f:	a1 c8 19 00 00       	mov    0x19c8,%eax
}
     764:	c9                   	leave  
     765:	c3                   	ret    

00000766 <malloc>:

void*
malloc(uint nbytes)
{
     766:	55                   	push   %ebp
     767:	89 e5                	mov    %esp,%ebp
     769:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     76c:	8b 45 08             	mov    0x8(%ebp),%eax
     76f:	83 c0 07             	add    $0x7,%eax
     772:	c1 e8 03             	shr    $0x3,%eax
     775:	83 c0 01             	add    $0x1,%eax
     778:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     77b:	a1 c8 19 00 00       	mov    0x19c8,%eax
     780:	89 45 f0             	mov    %eax,-0x10(%ebp)
     783:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     787:	75 23                	jne    7ac <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     789:	c7 45 f0 c0 19 00 00 	movl   $0x19c0,-0x10(%ebp)
     790:	8b 45 f0             	mov    -0x10(%ebp),%eax
     793:	a3 c8 19 00 00       	mov    %eax,0x19c8
     798:	a1 c8 19 00 00       	mov    0x19c8,%eax
     79d:	a3 c0 19 00 00       	mov    %eax,0x19c0
    base.s.size = 0;
     7a2:	c7 05 c4 19 00 00 00 	movl   $0x0,0x19c4
     7a9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7af:	8b 00                	mov    (%eax),%eax
     7b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b7:	8b 40 04             	mov    0x4(%eax),%eax
     7ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7bd:	72 4d                	jb     80c <malloc+0xa6>
      if(p->s.size == nunits)
     7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c2:	8b 40 04             	mov    0x4(%eax),%eax
     7c5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7c8:	75 0c                	jne    7d6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cd:	8b 10                	mov    (%eax),%edx
     7cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d2:	89 10                	mov    %edx,(%eax)
     7d4:	eb 26                	jmp    7fc <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d9:	8b 40 04             	mov    0x4(%eax),%eax
     7dc:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7df:	89 c2                	mov    %eax,%edx
     7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ea:	8b 40 04             	mov    0x4(%eax),%eax
     7ed:	c1 e0 03             	shl    $0x3,%eax
     7f0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ff:	a3 c8 19 00 00       	mov    %eax,0x19c8
      return (void*)(p + 1);
     804:	8b 45 f4             	mov    -0xc(%ebp),%eax
     807:	83 c0 08             	add    $0x8,%eax
     80a:	eb 3b                	jmp    847 <malloc+0xe1>
    }
    if(p == freep)
     80c:	a1 c8 19 00 00       	mov    0x19c8,%eax
     811:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     814:	75 1e                	jne    834 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     816:	83 ec 0c             	sub    $0xc,%esp
     819:	ff 75 ec             	pushl  -0x14(%ebp)
     81c:	e8 e5 fe ff ff       	call   706 <morecore>
     821:	83 c4 10             	add    $0x10,%esp
     824:	89 45 f4             	mov    %eax,-0xc(%ebp)
     827:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     82b:	75 07                	jne    834 <malloc+0xce>
        return 0;
     82d:	b8 00 00 00 00       	mov    $0x0,%eax
     832:	eb 13                	jmp    847 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     834:	8b 45 f4             	mov    -0xc(%ebp),%eax
     837:	89 45 f0             	mov    %eax,-0x10(%ebp)
     83a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83d:	8b 00                	mov    (%eax),%eax
     83f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     842:	e9 6d ff ff ff       	jmp    7b4 <malloc+0x4e>
}
     847:	c9                   	leave  
     848:	c3                   	ret    

00000849 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     849:	55                   	push   %ebp
     84a:	89 e5                	mov    %esp,%ebp
     84c:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     84f:	83 ec 0c             	sub    $0xc,%esp
     852:	ff 75 08             	pushl  0x8(%ebp)
     855:	e8 b0 00 00 00       	call   90a <re_compile>
     85a:	83 c4 10             	add    $0x10,%esp
     85d:	83 ec 04             	sub    $0x4,%esp
     860:	ff 75 10             	pushl  0x10(%ebp)
     863:	ff 75 0c             	pushl  0xc(%ebp)
     866:	50                   	push   %eax
     867:	e8 05 00 00 00       	call   871 <re_matchp>
     86c:	83 c4 10             	add    $0x10,%esp
}
     86f:	c9                   	leave  
     870:	c3                   	ret    

00000871 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     871:	55                   	push   %ebp
     872:	89 e5                	mov    %esp,%ebp
     874:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     877:	8b 45 10             	mov    0x10(%ebp),%eax
     87a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     880:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     884:	74 7d                	je     903 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     886:	8b 45 08             	mov    0x8(%ebp),%eax
     889:	0f b6 00             	movzbl (%eax),%eax
     88c:	3c 02                	cmp    $0x2,%al
     88e:	75 2a                	jne    8ba <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     890:	8b 45 08             	mov    0x8(%ebp),%eax
     893:	83 c0 08             	add    $0x8,%eax
     896:	83 ec 04             	sub    $0x4,%esp
     899:	ff 75 10             	pushl  0x10(%ebp)
     89c:	ff 75 0c             	pushl  0xc(%ebp)
     89f:	50                   	push   %eax
     8a0:	e8 b0 08 00 00       	call   1155 <matchpattern>
     8a5:	83 c4 10             	add    $0x10,%esp
     8a8:	85 c0                	test   %eax,%eax
     8aa:	74 07                	je     8b3 <re_matchp+0x42>
     8ac:	b8 00 00 00 00       	mov    $0x0,%eax
     8b1:	eb 55                	jmp    908 <re_matchp+0x97>
     8b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8b8:	eb 4e                	jmp    908 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     8ba:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     8c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     8c5:	83 ec 04             	sub    $0x4,%esp
     8c8:	ff 75 10             	pushl  0x10(%ebp)
     8cb:	ff 75 0c             	pushl  0xc(%ebp)
     8ce:	ff 75 08             	pushl  0x8(%ebp)
     8d1:	e8 7f 08 00 00       	call   1155 <matchpattern>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	85 c0                	test   %eax,%eax
     8db:	74 16                	je     8f3 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     8dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e0:	0f b6 00             	movzbl (%eax),%eax
     8e3:	84 c0                	test   %al,%al
     8e5:	75 07                	jne    8ee <re_matchp+0x7d>
            return -1;
     8e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8ec:	eb 1a                	jmp    908 <re_matchp+0x97>
        
          return idx;
     8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f1:	eb 15                	jmp    908 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     8f3:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f6:	8d 50 01             	lea    0x1(%eax),%edx
     8f9:	89 55 0c             	mov    %edx,0xc(%ebp)
     8fc:	0f b6 00             	movzbl (%eax),%eax
     8ff:	84 c0                	test   %al,%al
     901:	75 be                	jne    8c1 <re_matchp+0x50>
    }
  }
  return -1;
     903:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     908:	c9                   	leave  
     909:	c3                   	ret    

0000090a <re_compile>:

re_t re_compile(const char* pattern)
{
     90a:	55                   	push   %ebp
     90b:	89 e5                	mov    %esp,%ebp
     90d:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     910:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     917:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     91e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     925:	e9 55 02 00 00       	jmp    b7f <re_compile+0x275>
  {
    c = pattern[i];
     92a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     92d:	8b 45 08             	mov    0x8(%ebp),%eax
     930:	01 d0                	add    %edx,%eax
     932:	0f b6 00             	movzbl (%eax),%eax
     935:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     938:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     93c:	83 e8 24             	sub    $0x24,%eax
     93f:	83 f8 3a             	cmp    $0x3a,%eax
     942:	0f 87 13 02 00 00    	ja     b5b <re_compile+0x251>
     948:	8b 04 85 90 12 00 00 	mov    0x1290(,%eax,4),%eax
     94f:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     951:	8b 45 f4             	mov    -0xc(%ebp),%eax
     954:	c6 04 c5 e0 19 00 00 	movb   $0x2,0x19e0(,%eax,8)
     95b:	02 
     95c:	e9 16 02 00 00       	jmp    b77 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
     964:	c6 04 c5 e0 19 00 00 	movb   $0x3,0x19e0(,%eax,8)
     96b:	03 
     96c:	e9 06 02 00 00       	jmp    b77 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     971:	8b 45 f4             	mov    -0xc(%ebp),%eax
     974:	c6 04 c5 e0 19 00 00 	movb   $0x1,0x19e0(,%eax,8)
     97b:	01 
     97c:	e9 f6 01 00 00       	jmp    b77 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     981:	8b 45 f4             	mov    -0xc(%ebp),%eax
     984:	c6 04 c5 e0 19 00 00 	movb   $0x5,0x19e0(,%eax,8)
     98b:	05 
     98c:	e9 e6 01 00 00       	jmp    b77 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     991:	8b 45 f4             	mov    -0xc(%ebp),%eax
     994:	c6 04 c5 e0 19 00 00 	movb   $0x6,0x19e0(,%eax,8)
     99b:	06 
     99c:	e9 d6 01 00 00       	jmp    b77 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     9a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a4:	c6 04 c5 e0 19 00 00 	movb   $0x4,0x19e0(,%eax,8)
     9ab:	04 
     9ac:	e9 c6 01 00 00       	jmp    b77 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     9b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b4:	8d 50 01             	lea    0x1(%eax),%edx
     9b7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ba:	01 d0                	add    %edx,%eax
     9bc:	0f b6 00             	movzbl (%eax),%eax
     9bf:	84 c0                	test   %al,%al
     9c1:	0f 84 af 01 00 00    	je     b76 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     9c7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     9cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9ce:	8b 45 08             	mov    0x8(%ebp),%eax
     9d1:	01 d0                	add    %edx,%eax
     9d3:	0f b6 00             	movzbl (%eax),%eax
     9d6:	0f be c0             	movsbl %al,%eax
     9d9:	83 e8 44             	sub    $0x44,%eax
     9dc:	83 f8 33             	cmp    $0x33,%eax
     9df:	77 57                	ja     a38 <re_compile+0x12e>
     9e1:	8b 04 85 7c 13 00 00 	mov    0x137c(,%eax,4),%eax
     9e8:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     9ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ed:	c6 04 c5 e0 19 00 00 	movb   $0xa,0x19e0(,%eax,8)
     9f4:	0a 
     9f5:	eb 64                	jmp    a5b <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     9f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fa:	c6 04 c5 e0 19 00 00 	movb   $0xb,0x19e0(,%eax,8)
     a01:	0b 
     a02:	eb 57                	jmp    a5b <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a07:	c6 04 c5 e0 19 00 00 	movb   $0xc,0x19e0(,%eax,8)
     a0e:	0c 
     a0f:	eb 4a                	jmp    a5b <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a14:	c6 04 c5 e0 19 00 00 	movb   $0xd,0x19e0(,%eax,8)
     a1b:	0d 
     a1c:	eb 3d                	jmp    a5b <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a21:	c6 04 c5 e0 19 00 00 	movb   $0xe,0x19e0(,%eax,8)
     a28:	0e 
     a29:	eb 30                	jmp    a5b <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	c6 04 c5 e0 19 00 00 	movb   $0xf,0x19e0(,%eax,8)
     a35:	0f 
     a36:	eb 23                	jmp    a5b <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3b:	c6 04 c5 e0 19 00 00 	movb   $0x7,0x19e0(,%eax,8)
     a42:	07 
              re_compiled[j].ch = pattern[i];
     a43:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a46:	8b 45 08             	mov    0x8(%ebp),%eax
     a49:	01 d0                	add    %edx,%eax
     a4b:	0f b6 00             	movzbl (%eax),%eax
     a4e:	89 c2                	mov    %eax,%edx
     a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a53:	88 14 c5 e4 19 00 00 	mov    %dl,0x19e4(,%eax,8)
            } break;
     a5a:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     a5b:	e9 16 01 00 00       	jmp    b76 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     a60:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a63:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     a66:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a69:	8d 50 01             	lea    0x1(%eax),%edx
     a6c:	8b 45 08             	mov    0x8(%ebp),%eax
     a6f:	01 d0                	add    %edx,%eax
     a71:	0f b6 00             	movzbl (%eax),%eax
     a74:	3c 5e                	cmp    $0x5e,%al
     a76:	75 11                	jne    a89 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	c6 04 c5 e0 19 00 00 	movb   $0x9,0x19e0(,%eax,8)
     a82:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     a83:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     a87:	eb 7a                	jmp    b03 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8c:	c6 04 c5 e0 19 00 00 	movb   $0x8,0x19e0(,%eax,8)
     a93:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     a94:	eb 6d                	jmp    b03 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     a96:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a99:	8b 45 08             	mov    0x8(%ebp),%eax
     a9c:	01 d0                	add    %edx,%eax
     a9e:	0f b6 00             	movzbl (%eax),%eax
     aa1:	3c 5c                	cmp    $0x5c,%al
     aa3:	75 34                	jne    ad9 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     aa5:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     aa9:	7e 0a                	jle    ab5 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     aab:	b8 00 00 00 00       	mov    $0x0,%eax
     ab0:	e9 f8 00 00 00       	jmp    bad <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ab5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ab8:	8d 50 01             	lea    0x1(%eax),%edx
     abb:	89 55 fc             	mov    %edx,-0x4(%ebp)
     abe:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ac1:	8d 4a 01             	lea    0x1(%edx),%ecx
     ac4:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ac7:	89 d1                	mov    %edx,%ecx
     ac9:	8b 55 08             	mov    0x8(%ebp),%edx
     acc:	01 ca                	add    %ecx,%edx
     ace:	0f b6 12             	movzbl (%edx),%edx
     ad1:	88 90 e0 1a 00 00    	mov    %dl,0x1ae0(%eax)
     ad7:	eb 10                	jmp    ae9 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     ad9:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     add:	7e 0a                	jle    ae9 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     adf:	b8 00 00 00 00       	mov    $0x0,%eax
     ae4:	e9 c4 00 00 00       	jmp    bad <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     ae9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aec:	8d 50 01             	lea    0x1(%eax),%edx
     aef:	89 55 fc             	mov    %edx,-0x4(%ebp)
     af2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     af5:	8b 55 08             	mov    0x8(%ebp),%edx
     af8:	01 ca                	add    %ecx,%edx
     afa:	0f b6 12             	movzbl (%edx),%edx
     afd:	88 90 e0 1a 00 00    	mov    %dl,0x1ae0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b03:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b07:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b0a:	8b 45 08             	mov    0x8(%ebp),%eax
     b0d:	01 d0                	add    %edx,%eax
     b0f:	0f b6 00             	movzbl (%eax),%eax
     b12:	3c 5d                	cmp    $0x5d,%al
     b14:	74 13                	je     b29 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     b16:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b19:	8b 45 08             	mov    0x8(%ebp),%eax
     b1c:	01 d0                	add    %edx,%eax
     b1e:	0f b6 00             	movzbl (%eax),%eax
     b21:	84 c0                	test   %al,%al
     b23:	0f 85 6d ff ff ff    	jne    a96 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b29:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b2d:	7e 07                	jle    b36 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     b2f:	b8 00 00 00 00       	mov    $0x0,%eax
     b34:	eb 77                	jmp    bad <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     b36:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b39:	8d 50 01             	lea    0x1(%eax),%edx
     b3c:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b3f:	c6 80 e0 1a 00 00 00 	movb   $0x0,0x1ae0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     b46:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b49:	8d 90 e0 1a 00 00    	lea    0x1ae0(%eax),%edx
     b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b52:	89 14 c5 e4 19 00 00 	mov    %edx,0x19e4(,%eax,8)
      } break;
     b59:	eb 1c                	jmp    b77 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5e:	c6 04 c5 e0 19 00 00 	movb   $0x7,0x19e0(,%eax,8)
     b65:	07 
        re_compiled[j].ch = c;
     b66:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6d:	88 14 c5 e4 19 00 00 	mov    %dl,0x19e4(,%eax,8)
      } break;
     b74:	eb 01                	jmp    b77 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b76:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     b77:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     b7b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     b7f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b82:	8b 45 08             	mov    0x8(%ebp),%eax
     b85:	01 d0                	add    %edx,%eax
     b87:	0f b6 00             	movzbl (%eax),%eax
     b8a:	84 c0                	test   %al,%al
     b8c:	74 0f                	je     b9d <re_compile+0x293>
     b8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b91:	83 c0 01             	add    $0x1,%eax
     b94:	83 f8 1d             	cmp    $0x1d,%eax
     b97:	0f 8e 8d fd ff ff    	jle    92a <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba0:	c6 04 c5 e0 19 00 00 	movb   $0x0,0x19e0(,%eax,8)
     ba7:	00 

  return (re_t) re_compiled;
     ba8:	b8 e0 19 00 00       	mov    $0x19e0,%eax
}
     bad:	c9                   	leave  
     bae:	c3                   	ret    

00000baf <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     baf:	55                   	push   %ebp
     bb0:	89 e5                	mov    %esp,%ebp
     bb2:	83 ec 04             	sub    $0x4,%esp
     bb5:	8b 45 08             	mov    0x8(%ebp),%eax
     bb8:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     bbb:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     bbf:	7e 0d                	jle    bce <matchdigit+0x1f>
     bc1:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     bc5:	7f 07                	jg     bce <matchdigit+0x1f>
     bc7:	b8 01 00 00 00       	mov    $0x1,%eax
     bcc:	eb 05                	jmp    bd3 <matchdigit+0x24>
     bce:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bd3:	c9                   	leave  
     bd4:	c3                   	ret    

00000bd5 <matchalpha>:
static int matchalpha(char c)
{
     bd5:	55                   	push   %ebp
     bd6:	89 e5                	mov    %esp,%ebp
     bd8:	83 ec 04             	sub    $0x4,%esp
     bdb:	8b 45 08             	mov    0x8(%ebp),%eax
     bde:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     be1:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     be5:	7e 06                	jle    bed <matchalpha+0x18>
     be7:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     beb:	7e 0c                	jle    bf9 <matchalpha+0x24>
     bed:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     bf1:	7e 0d                	jle    c00 <matchalpha+0x2b>
     bf3:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     bf7:	7f 07                	jg     c00 <matchalpha+0x2b>
     bf9:	b8 01 00 00 00       	mov    $0x1,%eax
     bfe:	eb 05                	jmp    c05 <matchalpha+0x30>
     c00:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c05:	c9                   	leave  
     c06:	c3                   	ret    

00000c07 <matchwhitespace>:
static int matchwhitespace(char c)
{
     c07:	55                   	push   %ebp
     c08:	89 e5                	mov    %esp,%ebp
     c0a:	83 ec 04             	sub    $0x4,%esp
     c0d:	8b 45 08             	mov    0x8(%ebp),%eax
     c10:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     c13:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     c17:	74 1e                	je     c37 <matchwhitespace+0x30>
     c19:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     c1d:	74 18                	je     c37 <matchwhitespace+0x30>
     c1f:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     c23:	74 12                	je     c37 <matchwhitespace+0x30>
     c25:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     c29:	74 0c                	je     c37 <matchwhitespace+0x30>
     c2b:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     c2f:	74 06                	je     c37 <matchwhitespace+0x30>
     c31:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     c35:	75 07                	jne    c3e <matchwhitespace+0x37>
     c37:	b8 01 00 00 00       	mov    $0x1,%eax
     c3c:	eb 05                	jmp    c43 <matchwhitespace+0x3c>
     c3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c43:	c9                   	leave  
     c44:	c3                   	ret    

00000c45 <matchalphanum>:
static int matchalphanum(char c)
{
     c45:	55                   	push   %ebp
     c46:	89 e5                	mov    %esp,%ebp
     c48:	83 ec 04             	sub    $0x4,%esp
     c4b:	8b 45 08             	mov    0x8(%ebp),%eax
     c4e:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     c51:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     c55:	74 22                	je     c79 <matchalphanum+0x34>
     c57:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c5b:	50                   	push   %eax
     c5c:	e8 74 ff ff ff       	call   bd5 <matchalpha>
     c61:	83 c4 04             	add    $0x4,%esp
     c64:	85 c0                	test   %eax,%eax
     c66:	75 11                	jne    c79 <matchalphanum+0x34>
     c68:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     c6c:	50                   	push   %eax
     c6d:	e8 3d ff ff ff       	call   baf <matchdigit>
     c72:	83 c4 04             	add    $0x4,%esp
     c75:	85 c0                	test   %eax,%eax
     c77:	74 07                	je     c80 <matchalphanum+0x3b>
     c79:	b8 01 00 00 00       	mov    $0x1,%eax
     c7e:	eb 05                	jmp    c85 <matchalphanum+0x40>
     c80:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c85:	c9                   	leave  
     c86:	c3                   	ret    

00000c87 <matchrange>:
static int matchrange(char c, const char* str)
{
     c87:	55                   	push   %ebp
     c88:	89 e5                	mov    %esp,%ebp
     c8a:	83 ec 04             	sub    $0x4,%esp
     c8d:	8b 45 08             	mov    0x8(%ebp),%eax
     c90:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     c93:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     c97:	74 5b                	je     cf4 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     c99:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9c:	0f b6 00             	movzbl (%eax),%eax
     c9f:	84 c0                	test   %al,%al
     ca1:	74 51                	je     cf4 <matchrange+0x6d>
     ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca6:	0f b6 00             	movzbl (%eax),%eax
     ca9:	3c 2d                	cmp    $0x2d,%al
     cab:	74 47                	je     cf4 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cad:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb0:	83 c0 01             	add    $0x1,%eax
     cb3:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     cb6:	3c 2d                	cmp    $0x2d,%al
     cb8:	75 3a                	jne    cf4 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     cba:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbd:	83 c0 01             	add    $0x1,%eax
     cc0:	0f b6 00             	movzbl (%eax),%eax
     cc3:	84 c0                	test   %al,%al
     cc5:	74 2d                	je     cf4 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
     cca:	83 c0 02             	add    $0x2,%eax
     ccd:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     cd0:	84 c0                	test   %al,%al
     cd2:	74 20                	je     cf4 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd7:	0f b6 00             	movzbl (%eax),%eax
     cda:	3a 45 fc             	cmp    -0x4(%ebp),%al
     cdd:	7f 15                	jg     cf4 <matchrange+0x6d>
     cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce2:	83 c0 02             	add    $0x2,%eax
     ce5:	0f b6 00             	movzbl (%eax),%eax
     ce8:	3a 45 fc             	cmp    -0x4(%ebp),%al
     ceb:	7c 07                	jl     cf4 <matchrange+0x6d>
     ced:	b8 01 00 00 00       	mov    $0x1,%eax
     cf2:	eb 05                	jmp    cf9 <matchrange+0x72>
     cf4:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cf9:	c9                   	leave  
     cfa:	c3                   	ret    

00000cfb <ismetachar>:
static int ismetachar(char c)
{
     cfb:	55                   	push   %ebp
     cfc:	89 e5                	mov    %esp,%ebp
     cfe:	83 ec 04             	sub    $0x4,%esp
     d01:	8b 45 08             	mov    0x8(%ebp),%eax
     d04:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     d07:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     d0b:	74 1e                	je     d2b <ismetachar+0x30>
     d0d:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     d11:	74 18                	je     d2b <ismetachar+0x30>
     d13:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     d17:	74 12                	je     d2b <ismetachar+0x30>
     d19:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     d1d:	74 0c                	je     d2b <ismetachar+0x30>
     d1f:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     d23:	74 06                	je     d2b <ismetachar+0x30>
     d25:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     d29:	75 07                	jne    d32 <ismetachar+0x37>
     d2b:	b8 01 00 00 00       	mov    $0x1,%eax
     d30:	eb 05                	jmp    d37 <ismetachar+0x3c>
     d32:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d37:	c9                   	leave  
     d38:	c3                   	ret    

00000d39 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     d39:	55                   	push   %ebp
     d3a:	89 e5                	mov    %esp,%ebp
     d3c:	83 ec 04             	sub    $0x4,%esp
     d3f:	8b 45 08             	mov    0x8(%ebp),%eax
     d42:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     d45:	8b 45 0c             	mov    0xc(%ebp),%eax
     d48:	0f b6 00             	movzbl (%eax),%eax
     d4b:	0f be c0             	movsbl %al,%eax
     d4e:	83 e8 44             	sub    $0x44,%eax
     d51:	83 f8 33             	cmp    $0x33,%eax
     d54:	77 7b                	ja     dd1 <matchmetachar+0x98>
     d56:	8b 04 85 4c 14 00 00 	mov    0x144c(,%eax,4),%eax
     d5d:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     d5f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d63:	50                   	push   %eax
     d64:	e8 46 fe ff ff       	call   baf <matchdigit>
     d69:	83 c4 04             	add    $0x4,%esp
     d6c:	eb 72                	jmp    de0 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     d6e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d72:	50                   	push   %eax
     d73:	e8 37 fe ff ff       	call   baf <matchdigit>
     d78:	83 c4 04             	add    $0x4,%esp
     d7b:	85 c0                	test   %eax,%eax
     d7d:	0f 94 c0             	sete   %al
     d80:	0f b6 c0             	movzbl %al,%eax
     d83:	eb 5b                	jmp    de0 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     d85:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d89:	50                   	push   %eax
     d8a:	e8 b6 fe ff ff       	call   c45 <matchalphanum>
     d8f:	83 c4 04             	add    $0x4,%esp
     d92:	eb 4c                	jmp    de0 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     d94:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d98:	50                   	push   %eax
     d99:	e8 a7 fe ff ff       	call   c45 <matchalphanum>
     d9e:	83 c4 04             	add    $0x4,%esp
     da1:	85 c0                	test   %eax,%eax
     da3:	0f 94 c0             	sete   %al
     da6:	0f b6 c0             	movzbl %al,%eax
     da9:	eb 35                	jmp    de0 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     dab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     daf:	50                   	push   %eax
     db0:	e8 52 fe ff ff       	call   c07 <matchwhitespace>
     db5:	83 c4 04             	add    $0x4,%esp
     db8:	eb 26                	jmp    de0 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     dba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dbe:	50                   	push   %eax
     dbf:	e8 43 fe ff ff       	call   c07 <matchwhitespace>
     dc4:	83 c4 04             	add    $0x4,%esp
     dc7:	85 c0                	test   %eax,%eax
     dc9:	0f 94 c0             	sete   %al
     dcc:	0f b6 c0             	movzbl %al,%eax
     dcf:	eb 0f                	jmp    de0 <matchmetachar+0xa7>
    default:  return (c == str[0]);
     dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd4:	0f b6 00             	movzbl (%eax),%eax
     dd7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dda:	0f 94 c0             	sete   %al
     ddd:	0f b6 c0             	movzbl %al,%eax
  }
}
     de0:	c9                   	leave  
     de1:	c3                   	ret    

00000de2 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     de2:	55                   	push   %ebp
     de3:	89 e5                	mov    %esp,%ebp
     de5:	83 ec 04             	sub    $0x4,%esp
     de8:	8b 45 08             	mov    0x8(%ebp),%eax
     deb:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     dee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     df2:	ff 75 0c             	pushl  0xc(%ebp)
     df5:	50                   	push   %eax
     df6:	e8 8c fe ff ff       	call   c87 <matchrange>
     dfb:	83 c4 08             	add    $0x8,%esp
     dfe:	85 c0                	test   %eax,%eax
     e00:	74 0a                	je     e0c <matchcharclass+0x2a>
    {
      return 1;
     e02:	b8 01 00 00 00       	mov    $0x1,%eax
     e07:	e9 a5 00 00 00       	jmp    eb1 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0f:	0f b6 00             	movzbl (%eax),%eax
     e12:	3c 5c                	cmp    $0x5c,%al
     e14:	75 42                	jne    e58 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     e16:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     e1a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e1e:	ff 75 0c             	pushl  0xc(%ebp)
     e21:	50                   	push   %eax
     e22:	e8 12 ff ff ff       	call   d39 <matchmetachar>
     e27:	83 c4 08             	add    $0x8,%esp
     e2a:	85 c0                	test   %eax,%eax
     e2c:	74 07                	je     e35 <matchcharclass+0x53>
      {
        return 1;
     e2e:	b8 01 00 00 00       	mov    $0x1,%eax
     e33:	eb 7c                	jmp    eb1 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     e35:	8b 45 0c             	mov    0xc(%ebp),%eax
     e38:	0f b6 00             	movzbl (%eax),%eax
     e3b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e3e:	75 58                	jne    e98 <matchcharclass+0xb6>
     e40:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e44:	50                   	push   %eax
     e45:	e8 b1 fe ff ff       	call   cfb <ismetachar>
     e4a:	83 c4 04             	add    $0x4,%esp
     e4d:	85 c0                	test   %eax,%eax
     e4f:	75 47                	jne    e98 <matchcharclass+0xb6>
      {
        return 1;
     e51:	b8 01 00 00 00       	mov    $0x1,%eax
     e56:	eb 59                	jmp    eb1 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     e58:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5b:	0f b6 00             	movzbl (%eax),%eax
     e5e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e61:	75 35                	jne    e98 <matchcharclass+0xb6>
    {
      if (c == '-')
     e63:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     e67:	75 28                	jne    e91 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     e69:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6c:	83 e8 01             	sub    $0x1,%eax
     e6f:	0f b6 00             	movzbl (%eax),%eax
     e72:	84 c0                	test   %al,%al
     e74:	74 0d                	je     e83 <matchcharclass+0xa1>
     e76:	8b 45 0c             	mov    0xc(%ebp),%eax
     e79:	83 c0 01             	add    $0x1,%eax
     e7c:	0f b6 00             	movzbl (%eax),%eax
     e7f:	84 c0                	test   %al,%al
     e81:	75 07                	jne    e8a <matchcharclass+0xa8>
     e83:	b8 01 00 00 00       	mov    $0x1,%eax
     e88:	eb 27                	jmp    eb1 <matchcharclass+0xcf>
     e8a:	b8 00 00 00 00       	mov    $0x0,%eax
     e8f:	eb 20                	jmp    eb1 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     e91:	b8 01 00 00 00       	mov    $0x1,%eax
     e96:	eb 19                	jmp    eb1 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     e98:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9b:	8d 50 01             	lea    0x1(%eax),%edx
     e9e:	89 55 0c             	mov    %edx,0xc(%ebp)
     ea1:	0f b6 00             	movzbl (%eax),%eax
     ea4:	84 c0                	test   %al,%al
     ea6:	0f 85 42 ff ff ff    	jne    dee <matchcharclass+0xc>

  return 0;
     eac:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eb1:	c9                   	leave  
     eb2:	c3                   	ret    

00000eb3 <matchone>:

static int matchone(regex_t p, char c)
{
     eb3:	55                   	push   %ebp
     eb4:	89 e5                	mov    %esp,%ebp
     eb6:	83 ec 04             	sub    $0x4,%esp
     eb9:	8b 45 10             	mov    0x10(%ebp),%eax
     ebc:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     ebf:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     ec3:	0f b6 c0             	movzbl %al,%eax
     ec6:	83 f8 0f             	cmp    $0xf,%eax
     ec9:	0f 87 b9 00 00 00    	ja     f88 <matchone+0xd5>
     ecf:	8b 04 85 1c 15 00 00 	mov    0x151c(,%eax,4),%eax
     ed6:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     ed8:	b8 01 00 00 00       	mov    $0x1,%eax
     edd:	e9 b9 00 00 00       	jmp    f9b <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     ee2:	8b 55 0c             	mov    0xc(%ebp),%edx
     ee5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ee9:	52                   	push   %edx
     eea:	50                   	push   %eax
     eeb:	e8 f2 fe ff ff       	call   de2 <matchcharclass>
     ef0:	83 c4 08             	add    $0x8,%esp
     ef3:	e9 a3 00 00 00       	jmp    f9b <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     ef8:	8b 55 0c             	mov    0xc(%ebp),%edx
     efb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eff:	52                   	push   %edx
     f00:	50                   	push   %eax
     f01:	e8 dc fe ff ff       	call   de2 <matchcharclass>
     f06:	83 c4 08             	add    $0x8,%esp
     f09:	85 c0                	test   %eax,%eax
     f0b:	0f 94 c0             	sete   %al
     f0e:	0f b6 c0             	movzbl %al,%eax
     f11:	e9 85 00 00 00       	jmp    f9b <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     f16:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f1a:	50                   	push   %eax
     f1b:	e8 8f fc ff ff       	call   baf <matchdigit>
     f20:	83 c4 04             	add    $0x4,%esp
     f23:	eb 76                	jmp    f9b <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     f25:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f29:	50                   	push   %eax
     f2a:	e8 80 fc ff ff       	call   baf <matchdigit>
     f2f:	83 c4 04             	add    $0x4,%esp
     f32:	85 c0                	test   %eax,%eax
     f34:	0f 94 c0             	sete   %al
     f37:	0f b6 c0             	movzbl %al,%eax
     f3a:	eb 5f                	jmp    f9b <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     f3c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f40:	50                   	push   %eax
     f41:	e8 ff fc ff ff       	call   c45 <matchalphanum>
     f46:	83 c4 04             	add    $0x4,%esp
     f49:	eb 50                	jmp    f9b <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     f4b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4f:	50                   	push   %eax
     f50:	e8 f0 fc ff ff       	call   c45 <matchalphanum>
     f55:	83 c4 04             	add    $0x4,%esp
     f58:	85 c0                	test   %eax,%eax
     f5a:	0f 94 c0             	sete   %al
     f5d:	0f b6 c0             	movzbl %al,%eax
     f60:	eb 39                	jmp    f9b <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     f62:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f66:	50                   	push   %eax
     f67:	e8 9b fc ff ff       	call   c07 <matchwhitespace>
     f6c:	83 c4 04             	add    $0x4,%esp
     f6f:	eb 2a                	jmp    f9b <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     f71:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f75:	50                   	push   %eax
     f76:	e8 8c fc ff ff       	call   c07 <matchwhitespace>
     f7b:	83 c4 04             	add    $0x4,%esp
     f7e:	85 c0                	test   %eax,%eax
     f80:	0f 94 c0             	sete   %al
     f83:	0f b6 c0             	movzbl %al,%eax
     f86:	eb 13                	jmp    f9b <matchone+0xe8>
    default:             return  (p.ch == c);
     f88:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     f8c:	0f b6 d0             	movzbl %al,%edx
     f8f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f93:	39 c2                	cmp    %eax,%edx
     f95:	0f 94 c0             	sete   %al
     f98:	0f b6 c0             	movzbl %al,%eax
  }
}
     f9b:	c9                   	leave  
     f9c:	c3                   	ret    

00000f9d <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     f9d:	55                   	push   %ebp
     f9e:	89 e5                	mov    %esp,%ebp
     fa0:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     fa3:	8b 45 18             	mov    0x18(%ebp),%eax
     fa6:	8b 00                	mov    (%eax),%eax
     fa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     fab:	8b 45 14             	mov    0x14(%ebp),%eax
     fae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     fb1:	eb 11                	jmp    fc4 <matchstar+0x27>
  {
    text++;
     fb3:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     fb7:	8b 45 18             	mov    0x18(%ebp),%eax
     fba:	8b 00                	mov    (%eax),%eax
     fbc:	8d 50 01             	lea    0x1(%eax),%edx
     fbf:	8b 45 18             	mov    0x18(%ebp),%eax
     fc2:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     fc4:	8b 45 14             	mov    0x14(%ebp),%eax
     fc7:	0f b6 00             	movzbl (%eax),%eax
     fca:	84 c0                	test   %al,%al
     fcc:	74 51                	je     101f <matchstar+0x82>
     fce:	8b 45 14             	mov    0x14(%ebp),%eax
     fd1:	0f b6 00             	movzbl (%eax),%eax
     fd4:	0f be c0             	movsbl %al,%eax
     fd7:	50                   	push   %eax
     fd8:	ff 75 0c             	pushl  0xc(%ebp)
     fdb:	ff 75 08             	pushl  0x8(%ebp)
     fde:	e8 d0 fe ff ff       	call   eb3 <matchone>
     fe3:	83 c4 0c             	add    $0xc,%esp
     fe6:	85 c0                	test   %eax,%eax
     fe8:	75 c9                	jne    fb3 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     fea:	eb 33                	jmp    101f <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     fec:	8b 45 14             	mov    0x14(%ebp),%eax
     fef:	8d 50 ff             	lea    -0x1(%eax),%edx
     ff2:	89 55 14             	mov    %edx,0x14(%ebp)
     ff5:	83 ec 04             	sub    $0x4,%esp
     ff8:	ff 75 18             	pushl  0x18(%ebp)
     ffb:	50                   	push   %eax
     ffc:	ff 75 10             	pushl  0x10(%ebp)
     fff:	e8 51 01 00 00       	call   1155 <matchpattern>
    1004:	83 c4 10             	add    $0x10,%esp
    1007:	85 c0                	test   %eax,%eax
    1009:	74 07                	je     1012 <matchstar+0x75>
      return 1;
    100b:	b8 01 00 00 00       	mov    $0x1,%eax
    1010:	eb 22                	jmp    1034 <matchstar+0x97>
    (*matchlength)--;
    1012:	8b 45 18             	mov    0x18(%ebp),%eax
    1015:	8b 00                	mov    (%eax),%eax
    1017:	8d 50 ff             	lea    -0x1(%eax),%edx
    101a:	8b 45 18             	mov    0x18(%ebp),%eax
    101d:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    101f:	8b 45 14             	mov    0x14(%ebp),%eax
    1022:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1025:	73 c5                	jae    fec <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1027:	8b 45 18             	mov    0x18(%ebp),%eax
    102a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    102d:	89 10                	mov    %edx,(%eax)
  return 0;
    102f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1034:	c9                   	leave  
    1035:	c3                   	ret    

00001036 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1036:	55                   	push   %ebp
    1037:	89 e5                	mov    %esp,%ebp
    1039:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    103c:	8b 45 14             	mov    0x14(%ebp),%eax
    103f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1042:	eb 11                	jmp    1055 <matchplus+0x1f>
  {
    text++;
    1044:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1048:	8b 45 18             	mov    0x18(%ebp),%eax
    104b:	8b 00                	mov    (%eax),%eax
    104d:	8d 50 01             	lea    0x1(%eax),%edx
    1050:	8b 45 18             	mov    0x18(%ebp),%eax
    1053:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1055:	8b 45 14             	mov    0x14(%ebp),%eax
    1058:	0f b6 00             	movzbl (%eax),%eax
    105b:	84 c0                	test   %al,%al
    105d:	74 51                	je     10b0 <matchplus+0x7a>
    105f:	8b 45 14             	mov    0x14(%ebp),%eax
    1062:	0f b6 00             	movzbl (%eax),%eax
    1065:	0f be c0             	movsbl %al,%eax
    1068:	50                   	push   %eax
    1069:	ff 75 0c             	pushl  0xc(%ebp)
    106c:	ff 75 08             	pushl  0x8(%ebp)
    106f:	e8 3f fe ff ff       	call   eb3 <matchone>
    1074:	83 c4 0c             	add    $0xc,%esp
    1077:	85 c0                	test   %eax,%eax
    1079:	75 c9                	jne    1044 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    107b:	eb 33                	jmp    10b0 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    107d:	8b 45 14             	mov    0x14(%ebp),%eax
    1080:	8d 50 ff             	lea    -0x1(%eax),%edx
    1083:	89 55 14             	mov    %edx,0x14(%ebp)
    1086:	83 ec 04             	sub    $0x4,%esp
    1089:	ff 75 18             	pushl  0x18(%ebp)
    108c:	50                   	push   %eax
    108d:	ff 75 10             	pushl  0x10(%ebp)
    1090:	e8 c0 00 00 00       	call   1155 <matchpattern>
    1095:	83 c4 10             	add    $0x10,%esp
    1098:	85 c0                	test   %eax,%eax
    109a:	74 07                	je     10a3 <matchplus+0x6d>
      return 1;
    109c:	b8 01 00 00 00       	mov    $0x1,%eax
    10a1:	eb 1a                	jmp    10bd <matchplus+0x87>
    (*matchlength)--;
    10a3:	8b 45 18             	mov    0x18(%ebp),%eax
    10a6:	8b 00                	mov    (%eax),%eax
    10a8:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ab:	8b 45 18             	mov    0x18(%ebp),%eax
    10ae:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    10b0:	8b 45 14             	mov    0x14(%ebp),%eax
    10b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10b6:	77 c5                	ja     107d <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    10b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10bd:	c9                   	leave  
    10be:	c3                   	ret    

000010bf <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    10c2:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    10c5:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10c9:	84 c0                	test   %al,%al
    10cb:	75 07                	jne    10d4 <matchquestion+0x15>
    return 1;
    10cd:	b8 01 00 00 00       	mov    $0x1,%eax
    10d2:	eb 7f                	jmp    1153 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    10d4:	83 ec 04             	sub    $0x4,%esp
    10d7:	ff 75 18             	pushl  0x18(%ebp)
    10da:	ff 75 14             	pushl  0x14(%ebp)
    10dd:	ff 75 10             	pushl  0x10(%ebp)
    10e0:	e8 70 00 00 00       	call   1155 <matchpattern>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	85 c0                	test   %eax,%eax
    10ea:	74 07                	je     10f3 <matchquestion+0x34>
      return 1;
    10ec:	b8 01 00 00 00       	mov    $0x1,%eax
    10f1:	eb 60                	jmp    1153 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    10f3:	8b 45 14             	mov    0x14(%ebp),%eax
    10f6:	0f b6 00             	movzbl (%eax),%eax
    10f9:	84 c0                	test   %al,%al
    10fb:	74 51                	je     114e <matchquestion+0x8f>
    10fd:	8b 45 14             	mov    0x14(%ebp),%eax
    1100:	8d 50 01             	lea    0x1(%eax),%edx
    1103:	89 55 14             	mov    %edx,0x14(%ebp)
    1106:	0f b6 00             	movzbl (%eax),%eax
    1109:	0f be c0             	movsbl %al,%eax
    110c:	83 ec 04             	sub    $0x4,%esp
    110f:	50                   	push   %eax
    1110:	ff 75 0c             	pushl  0xc(%ebp)
    1113:	ff 75 08             	pushl  0x8(%ebp)
    1116:	e8 98 fd ff ff       	call   eb3 <matchone>
    111b:	83 c4 10             	add    $0x10,%esp
    111e:	85 c0                	test   %eax,%eax
    1120:	74 2c                	je     114e <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    1122:	83 ec 04             	sub    $0x4,%esp
    1125:	ff 75 18             	pushl  0x18(%ebp)
    1128:	ff 75 14             	pushl  0x14(%ebp)
    112b:	ff 75 10             	pushl  0x10(%ebp)
    112e:	e8 22 00 00 00       	call   1155 <matchpattern>
    1133:	83 c4 10             	add    $0x10,%esp
    1136:	85 c0                	test   %eax,%eax
    1138:	74 14                	je     114e <matchquestion+0x8f>
    {
      (*matchlength)++;
    113a:	8b 45 18             	mov    0x18(%ebp),%eax
    113d:	8b 00                	mov    (%eax),%eax
    113f:	8d 50 01             	lea    0x1(%eax),%edx
    1142:	8b 45 18             	mov    0x18(%ebp),%eax
    1145:	89 10                	mov    %edx,(%eax)
      return 1;
    1147:	b8 01 00 00 00       	mov    $0x1,%eax
    114c:	eb 05                	jmp    1153 <matchquestion+0x94>
    }
  }
  return 0;
    114e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1153:	c9                   	leave  
    1154:	c3                   	ret    

00001155 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1155:	55                   	push   %ebp
    1156:	89 e5                	mov    %esp,%ebp
    1158:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    115b:	8b 45 10             	mov    0x10(%ebp),%eax
    115e:	8b 00                	mov    (%eax),%eax
    1160:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1163:	8b 45 08             	mov    0x8(%ebp),%eax
    1166:	0f b6 00             	movzbl (%eax),%eax
    1169:	84 c0                	test   %al,%al
    116b:	74 0d                	je     117a <matchpattern+0x25>
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	83 c0 08             	add    $0x8,%eax
    1173:	0f b6 00             	movzbl (%eax),%eax
    1176:	3c 04                	cmp    $0x4,%al
    1178:	75 25                	jne    119f <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
    117d:	83 c0 10             	add    $0x10,%eax
    1180:	83 ec 0c             	sub    $0xc,%esp
    1183:	ff 75 10             	pushl  0x10(%ebp)
    1186:	ff 75 0c             	pushl  0xc(%ebp)
    1189:	50                   	push   %eax
    118a:	8b 45 08             	mov    0x8(%ebp),%eax
    118d:	ff 70 04             	pushl  0x4(%eax)
    1190:	ff 30                	pushl  (%eax)
    1192:	e8 28 ff ff ff       	call   10bf <matchquestion>
    1197:	83 c4 20             	add    $0x20,%esp
    119a:	e9 dd 00 00 00       	jmp    127c <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
    11a2:	83 c0 08             	add    $0x8,%eax
    11a5:	0f b6 00             	movzbl (%eax),%eax
    11a8:	3c 05                	cmp    $0x5,%al
    11aa:	75 25                	jne    11d1 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	83 c0 10             	add    $0x10,%eax
    11b2:	83 ec 0c             	sub    $0xc,%esp
    11b5:	ff 75 10             	pushl  0x10(%ebp)
    11b8:	ff 75 0c             	pushl  0xc(%ebp)
    11bb:	50                   	push   %eax
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	ff 70 04             	pushl  0x4(%eax)
    11c2:	ff 30                	pushl  (%eax)
    11c4:	e8 d4 fd ff ff       	call   f9d <matchstar>
    11c9:	83 c4 20             	add    $0x20,%esp
    11cc:	e9 ab 00 00 00       	jmp    127c <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    11d1:	8b 45 08             	mov    0x8(%ebp),%eax
    11d4:	83 c0 08             	add    $0x8,%eax
    11d7:	0f b6 00             	movzbl (%eax),%eax
    11da:	3c 06                	cmp    $0x6,%al
    11dc:	75 22                	jne    1200 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	83 c0 10             	add    $0x10,%eax
    11e4:	83 ec 0c             	sub    $0xc,%esp
    11e7:	ff 75 10             	pushl  0x10(%ebp)
    11ea:	ff 75 0c             	pushl  0xc(%ebp)
    11ed:	50                   	push   %eax
    11ee:	8b 45 08             	mov    0x8(%ebp),%eax
    11f1:	ff 70 04             	pushl  0x4(%eax)
    11f4:	ff 30                	pushl  (%eax)
    11f6:	e8 3b fe ff ff       	call   1036 <matchplus>
    11fb:	83 c4 20             	add    $0x20,%esp
    11fe:	eb 7c                	jmp    127c <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    1200:	8b 45 08             	mov    0x8(%ebp),%eax
    1203:	0f b6 00             	movzbl (%eax),%eax
    1206:	3c 03                	cmp    $0x3,%al
    1208:	75 1d                	jne    1227 <matchpattern+0xd2>
    120a:	8b 45 08             	mov    0x8(%ebp),%eax
    120d:	83 c0 08             	add    $0x8,%eax
    1210:	0f b6 00             	movzbl (%eax),%eax
    1213:	84 c0                	test   %al,%al
    1215:	75 10                	jne    1227 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1217:	8b 45 0c             	mov    0xc(%ebp),%eax
    121a:	0f b6 00             	movzbl (%eax),%eax
    121d:	84 c0                	test   %al,%al
    121f:	0f 94 c0             	sete   %al
    1222:	0f b6 c0             	movzbl %al,%eax
    1225:	eb 55                	jmp    127c <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1227:	8b 45 10             	mov    0x10(%ebp),%eax
    122a:	8b 00                	mov    (%eax),%eax
    122c:	8d 50 01             	lea    0x1(%eax),%edx
    122f:	8b 45 10             	mov    0x10(%ebp),%eax
    1232:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1234:	8b 45 0c             	mov    0xc(%ebp),%eax
    1237:	0f b6 00             	movzbl (%eax),%eax
    123a:	84 c0                	test   %al,%al
    123c:	74 31                	je     126f <matchpattern+0x11a>
    123e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1241:	8d 50 01             	lea    0x1(%eax),%edx
    1244:	89 55 0c             	mov    %edx,0xc(%ebp)
    1247:	0f b6 00             	movzbl (%eax),%eax
    124a:	0f be d0             	movsbl %al,%edx
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	8d 48 08             	lea    0x8(%eax),%ecx
    1253:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1256:	83 ec 04             	sub    $0x4,%esp
    1259:	52                   	push   %edx
    125a:	ff 70 04             	pushl  0x4(%eax)
    125d:	ff 30                	pushl  (%eax)
    125f:	e8 4f fc ff ff       	call   eb3 <matchone>
    1264:	83 c4 10             	add    $0x10,%esp
    1267:	85 c0                	test   %eax,%eax
    1269:	0f 85 f4 fe ff ff    	jne    1163 <matchpattern+0xe>

  *matchlength = pre;
    126f:	8b 45 10             	mov    0x10(%ebp),%eax
    1272:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1275:	89 10                	mov    %edx,(%eax)
  return 0;
    1277:	b8 00 00 00 00       	mov    $0x0,%eax
}
    127c:	c9                   	leave  
    127d:	c3                   	ret    
