
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
       6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
       8:	83 ec 04             	sub    $0x4,%esp
       b:	ff 75 f4             	pushl  -0xc(%ebp)
       e:	68 20 1c 00 00       	push   $0x1c20
      13:	6a 01                	push   $0x1
      15:	e8 6c 03 00 00       	call   386 <write>
      1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
      1d:	83 ec 04             	sub    $0x4,%esp
      20:	68 00 02 00 00       	push   $0x200
      25:	68 20 1c 00 00       	push   $0x1c20
      2a:	ff 75 08             	pushl  0x8(%ebp)
      2d:	e8 4c 03 00 00       	call   37e <read>
      32:	83 c4 10             	add    $0x10,%esp
      35:	89 45 f4             	mov    %eax,-0xc(%ebp)
      38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
      3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
      44:	83 ec 08             	sub    $0x8,%esp
      47:	68 28 13 00 00       	push   $0x1328
      4c:	6a 01                	push   $0x1
      4e:	e8 ea 04 00 00       	call   53d <printf>
      53:	83 c4 10             	add    $0x10,%esp
    exit();
      56:	e8 0b 03 00 00       	call   366 <exit>
  }
}
      5b:	90                   	nop
      5c:	c9                   	leave  
      5d:	c3                   	ret    

0000005e <main>:

int
main(int argc, char *argv[])
{
      5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      62:	83 e4 f0             	and    $0xfffffff0,%esp
      65:	ff 71 fc             	pushl  -0x4(%ecx)
      68:	55                   	push   %ebp
      69:	89 e5                	mov    %esp,%ebp
      6b:	53                   	push   %ebx
      6c:	51                   	push   %ecx
      6d:	83 ec 10             	sub    $0x10,%esp
      70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
      72:	83 3b 01             	cmpl   $0x1,(%ebx)
      75:	7f 12                	jg     89 <main+0x2b>
    cat(0);
      77:	83 ec 0c             	sub    $0xc,%esp
      7a:	6a 00                	push   $0x0
      7c:	e8 7f ff ff ff       	call   0 <cat>
      81:	83 c4 10             	add    $0x10,%esp
    exit();
      84:	e8 dd 02 00 00       	call   366 <exit>
  }

  for(i = 1; i < argc; i++){
      89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      90:	eb 71                	jmp    103 <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
      92:	8b 45 f4             	mov    -0xc(%ebp),%eax
      95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      9c:	8b 43 04             	mov    0x4(%ebx),%eax
      9f:	01 d0                	add    %edx,%eax
      a1:	8b 00                	mov    (%eax),%eax
      a3:	83 ec 08             	sub    $0x8,%esp
      a6:	6a 00                	push   $0x0
      a8:	50                   	push   %eax
      a9:	e8 f8 02 00 00       	call   3a6 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      b8:	79 29                	jns    e3 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
      ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
      bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      c4:	8b 43 04             	mov    0x4(%ebx),%eax
      c7:	01 d0                	add    %edx,%eax
      c9:	8b 00                	mov    (%eax),%eax
      cb:	83 ec 04             	sub    $0x4,%esp
      ce:	50                   	push   %eax
      cf:	68 39 13 00 00       	push   $0x1339
      d4:	6a 01                	push   $0x1
      d6:	e8 62 04 00 00       	call   53d <printf>
      db:	83 c4 10             	add    $0x10,%esp
      exit();
      de:	e8 83 02 00 00       	call   366 <exit>
    }
    cat(fd);
      e3:	83 ec 0c             	sub    $0xc,%esp
      e6:	ff 75 f0             	pushl  -0x10(%ebp)
      e9:	e8 12 ff ff ff       	call   0 <cat>
      ee:	83 c4 10             	add    $0x10,%esp
    close(fd);
      f1:	83 ec 0c             	sub    $0xc,%esp
      f4:	ff 75 f0             	pushl  -0x10(%ebp)
      f7:	e8 92 02 00 00       	call   38e <close>
      fc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
      ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     103:	8b 45 f4             	mov    -0xc(%ebp),%eax
     106:	3b 03                	cmp    (%ebx),%eax
     108:	7c 88                	jl     92 <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
     10a:	e8 57 02 00 00       	call   366 <exit>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     10f:	55                   	push   %ebp
     110:	89 e5                	mov    %esp,%ebp
     112:	57                   	push   %edi
     113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     114:	8b 4d 08             	mov    0x8(%ebp),%ecx
     117:	8b 55 10             	mov    0x10(%ebp),%edx
     11a:	8b 45 0c             	mov    0xc(%ebp),%eax
     11d:	89 cb                	mov    %ecx,%ebx
     11f:	89 df                	mov    %ebx,%edi
     121:	89 d1                	mov    %edx,%ecx
     123:	fc                   	cld    
     124:	f3 aa                	rep stos %al,%es:(%edi)
     126:	89 ca                	mov    %ecx,%edx
     128:	89 fb                	mov    %edi,%ebx
     12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
     12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     130:	90                   	nop
     131:	5b                   	pop    %ebx
     132:	5f                   	pop    %edi
     133:	5d                   	pop    %ebp
     134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     141:	90                   	nop
     142:	8b 45 08             	mov    0x8(%ebp),%eax
     145:	8d 50 01             	lea    0x1(%eax),%edx
     148:	89 55 08             	mov    %edx,0x8(%ebp)
     14b:	8b 55 0c             	mov    0xc(%ebp),%edx
     14e:	8d 4a 01             	lea    0x1(%edx),%ecx
     151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     154:	0f b6 12             	movzbl (%edx),%edx
     157:	88 10                	mov    %dl,(%eax)
     159:	0f b6 00             	movzbl (%eax),%eax
     15c:	84 c0                	test   %al,%al
     15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
     160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     163:	c9                   	leave  
     164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     165:	55                   	push   %ebp
     166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
     16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     172:	8b 45 08             	mov    0x8(%ebp),%eax
     175:	0f b6 00             	movzbl (%eax),%eax
     178:	84 c0                	test   %al,%al
     17a:	74 10                	je     18c <strcmp+0x27>
     17c:	8b 45 08             	mov    0x8(%ebp),%eax
     17f:	0f b6 10             	movzbl (%eax),%edx
     182:	8b 45 0c             	mov    0xc(%ebp),%eax
     185:	0f b6 00             	movzbl (%eax),%eax
     188:	38 c2                	cmp    %al,%dl
     18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     18c:	8b 45 08             	mov    0x8(%ebp),%eax
     18f:	0f b6 00             	movzbl (%eax),%eax
     192:	0f b6 d0             	movzbl %al,%edx
     195:	8b 45 0c             	mov    0xc(%ebp),%eax
     198:	0f b6 00             	movzbl (%eax),%eax
     19b:	0f b6 c0             	movzbl %al,%eax
     19e:	29 c2                	sub    %eax,%edx
     1a0:	89 d0                	mov    %edx,%eax
}
     1a2:	5d                   	pop    %ebp
     1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
     1a4:	55                   	push   %ebp
     1a5:	89 e5                	mov    %esp,%ebp
     1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1b1:	eb 04                	jmp    1b7 <strlen+0x13>
     1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ba:	8b 45 08             	mov    0x8(%ebp),%eax
     1bd:	01 d0                	add    %edx,%eax
     1bf:	0f b6 00             	movzbl (%eax),%eax
     1c2:	84 c0                	test   %al,%al
     1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
     1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
     1cb:	55                   	push   %ebp
     1cc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1ce:	8b 45 10             	mov    0x10(%ebp),%eax
     1d1:	50                   	push   %eax
     1d2:	ff 75 0c             	pushl  0xc(%ebp)
     1d5:	ff 75 08             	pushl  0x8(%ebp)
     1d8:	e8 32 ff ff ff       	call   10f <stosb>
     1dd:	83 c4 0c             	add    $0xc,%esp
  return dst;
     1e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1e3:	c9                   	leave  
     1e4:	c3                   	ret    

000001e5 <strchr>:

char*
strchr(const char *s, char c)
{
     1e5:	55                   	push   %ebp
     1e6:	89 e5                	mov    %esp,%ebp
     1e8:	83 ec 04             	sub    $0x4,%esp
     1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
     1ee:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1f1:	eb 14                	jmp    207 <strchr+0x22>
    if(*s == c)
     1f3:	8b 45 08             	mov    0x8(%ebp),%eax
     1f6:	0f b6 00             	movzbl (%eax),%eax
     1f9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     1fc:	75 05                	jne    203 <strchr+0x1e>
      return (char*)s;
     1fe:	8b 45 08             	mov    0x8(%ebp),%eax
     201:	eb 13                	jmp    216 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     203:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     207:	8b 45 08             	mov    0x8(%ebp),%eax
     20a:	0f b6 00             	movzbl (%eax),%eax
     20d:	84 c0                	test   %al,%al
     20f:	75 e2                	jne    1f3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     211:	b8 00 00 00 00       	mov    $0x0,%eax
}
     216:	c9                   	leave  
     217:	c3                   	ret    

00000218 <gets>:

char*
gets(char *buf, int max)
{
     218:	55                   	push   %ebp
     219:	89 e5                	mov    %esp,%ebp
     21b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     21e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     225:	eb 42                	jmp    269 <gets+0x51>
    cc = read(0, &c, 1);
     227:	83 ec 04             	sub    $0x4,%esp
     22a:	6a 01                	push   $0x1
     22c:	8d 45 ef             	lea    -0x11(%ebp),%eax
     22f:	50                   	push   %eax
     230:	6a 00                	push   $0x0
     232:	e8 47 01 00 00       	call   37e <read>
     237:	83 c4 10             	add    $0x10,%esp
     23a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     23d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     241:	7e 33                	jle    276 <gets+0x5e>
      break;
    buf[i++] = c;
     243:	8b 45 f4             	mov    -0xc(%ebp),%eax
     246:	8d 50 01             	lea    0x1(%eax),%edx
     249:	89 55 f4             	mov    %edx,-0xc(%ebp)
     24c:	89 c2                	mov    %eax,%edx
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	01 c2                	add    %eax,%edx
     253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     257:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     25d:	3c 0a                	cmp    $0xa,%al
     25f:	74 16                	je     277 <gets+0x5f>
     261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     265:	3c 0d                	cmp    $0xd,%al
     267:	74 0e                	je     277 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     269:	8b 45 f4             	mov    -0xc(%ebp),%eax
     26c:	83 c0 01             	add    $0x1,%eax
     26f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     272:	7c b3                	jl     227 <gets+0xf>
     274:	eb 01                	jmp    277 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     276:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     277:	8b 55 f4             	mov    -0xc(%ebp),%edx
     27a:	8b 45 08             	mov    0x8(%ebp),%eax
     27d:	01 d0                	add    %edx,%eax
     27f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     282:	8b 45 08             	mov    0x8(%ebp),%eax
}
     285:	c9                   	leave  
     286:	c3                   	ret    

00000287 <stat>:

int
stat(char *n, struct stat *st)
{
     287:	55                   	push   %ebp
     288:	89 e5                	mov    %esp,%ebp
     28a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     28d:	83 ec 08             	sub    $0x8,%esp
     290:	6a 00                	push   $0x0
     292:	ff 75 08             	pushl  0x8(%ebp)
     295:	e8 0c 01 00 00       	call   3a6 <open>
     29a:	83 c4 10             	add    $0x10,%esp
     29d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2a4:	79 07                	jns    2ad <stat+0x26>
    return -1;
     2a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2ab:	eb 25                	jmp    2d2 <stat+0x4b>
  r = fstat(fd, st);
     2ad:	83 ec 08             	sub    $0x8,%esp
     2b0:	ff 75 0c             	pushl  0xc(%ebp)
     2b3:	ff 75 f4             	pushl  -0xc(%ebp)
     2b6:	e8 03 01 00 00       	call   3be <fstat>
     2bb:	83 c4 10             	add    $0x10,%esp
     2be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2c1:	83 ec 0c             	sub    $0xc,%esp
     2c4:	ff 75 f4             	pushl  -0xc(%ebp)
     2c7:	e8 c2 00 00 00       	call   38e <close>
     2cc:	83 c4 10             	add    $0x10,%esp
  return r;
     2cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2d2:	c9                   	leave  
     2d3:	c3                   	ret    

000002d4 <atoi>:

int
atoi(const char *s)
{
     2d4:	55                   	push   %ebp
     2d5:	89 e5                	mov    %esp,%ebp
     2d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2e1:	eb 25                	jmp    308 <atoi+0x34>
    n = n*10 + *s++ - '0';
     2e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2e6:	89 d0                	mov    %edx,%eax
     2e8:	c1 e0 02             	shl    $0x2,%eax
     2eb:	01 d0                	add    %edx,%eax
     2ed:	01 c0                	add    %eax,%eax
     2ef:	89 c1                	mov    %eax,%ecx
     2f1:	8b 45 08             	mov    0x8(%ebp),%eax
     2f4:	8d 50 01             	lea    0x1(%eax),%edx
     2f7:	89 55 08             	mov    %edx,0x8(%ebp)
     2fa:	0f b6 00             	movzbl (%eax),%eax
     2fd:	0f be c0             	movsbl %al,%eax
     300:	01 c8                	add    %ecx,%eax
     302:	83 e8 30             	sub    $0x30,%eax
     305:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     308:	8b 45 08             	mov    0x8(%ebp),%eax
     30b:	0f b6 00             	movzbl (%eax),%eax
     30e:	3c 2f                	cmp    $0x2f,%al
     310:	7e 0a                	jle    31c <atoi+0x48>
     312:	8b 45 08             	mov    0x8(%ebp),%eax
     315:	0f b6 00             	movzbl (%eax),%eax
     318:	3c 39                	cmp    $0x39,%al
     31a:	7e c7                	jle    2e3 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     31c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     31f:	c9                   	leave  
     320:	c3                   	ret    

00000321 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     321:	55                   	push   %ebp
     322:	89 e5                	mov    %esp,%ebp
     324:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     327:	8b 45 08             	mov    0x8(%ebp),%eax
     32a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     32d:	8b 45 0c             	mov    0xc(%ebp),%eax
     330:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     333:	eb 17                	jmp    34c <memmove+0x2b>
    *dst++ = *src++;
     335:	8b 45 fc             	mov    -0x4(%ebp),%eax
     338:	8d 50 01             	lea    0x1(%eax),%edx
     33b:	89 55 fc             	mov    %edx,-0x4(%ebp)
     33e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     341:	8d 4a 01             	lea    0x1(%edx),%ecx
     344:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     347:	0f b6 12             	movzbl (%edx),%edx
     34a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     34c:	8b 45 10             	mov    0x10(%ebp),%eax
     34f:	8d 50 ff             	lea    -0x1(%eax),%edx
     352:	89 55 10             	mov    %edx,0x10(%ebp)
     355:	85 c0                	test   %eax,%eax
     357:	7f dc                	jg     335 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     359:	8b 45 08             	mov    0x8(%ebp),%eax
}
     35c:	c9                   	leave  
     35d:	c3                   	ret    

0000035e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     35e:	b8 01 00 00 00       	mov    $0x1,%eax
     363:	cd 40                	int    $0x40
     365:	c3                   	ret    

00000366 <exit>:
SYSCALL(exit)
     366:	b8 02 00 00 00       	mov    $0x2,%eax
     36b:	cd 40                	int    $0x40
     36d:	c3                   	ret    

0000036e <wait>:
SYSCALL(wait)
     36e:	b8 03 00 00 00       	mov    $0x3,%eax
     373:	cd 40                	int    $0x40
     375:	c3                   	ret    

00000376 <pipe>:
SYSCALL(pipe)
     376:	b8 04 00 00 00       	mov    $0x4,%eax
     37b:	cd 40                	int    $0x40
     37d:	c3                   	ret    

0000037e <read>:
SYSCALL(read)
     37e:	b8 05 00 00 00       	mov    $0x5,%eax
     383:	cd 40                	int    $0x40
     385:	c3                   	ret    

00000386 <write>:
SYSCALL(write)
     386:	b8 10 00 00 00       	mov    $0x10,%eax
     38b:	cd 40                	int    $0x40
     38d:	c3                   	ret    

0000038e <close>:
SYSCALL(close)
     38e:	b8 15 00 00 00       	mov    $0x15,%eax
     393:	cd 40                	int    $0x40
     395:	c3                   	ret    

00000396 <kill>:
SYSCALL(kill)
     396:	b8 06 00 00 00       	mov    $0x6,%eax
     39b:	cd 40                	int    $0x40
     39d:	c3                   	ret    

0000039e <exec>:
SYSCALL(exec)
     39e:	b8 07 00 00 00       	mov    $0x7,%eax
     3a3:	cd 40                	int    $0x40
     3a5:	c3                   	ret    

000003a6 <open>:
SYSCALL(open)
     3a6:	b8 0f 00 00 00       	mov    $0xf,%eax
     3ab:	cd 40                	int    $0x40
     3ad:	c3                   	ret    

000003ae <mknod>:
SYSCALL(mknod)
     3ae:	b8 11 00 00 00       	mov    $0x11,%eax
     3b3:	cd 40                	int    $0x40
     3b5:	c3                   	ret    

000003b6 <unlink>:
SYSCALL(unlink)
     3b6:	b8 12 00 00 00       	mov    $0x12,%eax
     3bb:	cd 40                	int    $0x40
     3bd:	c3                   	ret    

000003be <fstat>:
SYSCALL(fstat)
     3be:	b8 08 00 00 00       	mov    $0x8,%eax
     3c3:	cd 40                	int    $0x40
     3c5:	c3                   	ret    

000003c6 <link>:
SYSCALL(link)
     3c6:	b8 13 00 00 00       	mov    $0x13,%eax
     3cb:	cd 40                	int    $0x40
     3cd:	c3                   	ret    

000003ce <mkdir>:
SYSCALL(mkdir)
     3ce:	b8 14 00 00 00       	mov    $0x14,%eax
     3d3:	cd 40                	int    $0x40
     3d5:	c3                   	ret    

000003d6 <chdir>:
SYSCALL(chdir)
     3d6:	b8 09 00 00 00       	mov    $0x9,%eax
     3db:	cd 40                	int    $0x40
     3dd:	c3                   	ret    

000003de <dup>:
SYSCALL(dup)
     3de:	b8 0a 00 00 00       	mov    $0xa,%eax
     3e3:	cd 40                	int    $0x40
     3e5:	c3                   	ret    

000003e6 <getpid>:
SYSCALL(getpid)
     3e6:	b8 0b 00 00 00       	mov    $0xb,%eax
     3eb:	cd 40                	int    $0x40
     3ed:	c3                   	ret    

000003ee <sbrk>:
SYSCALL(sbrk)
     3ee:	b8 0c 00 00 00       	mov    $0xc,%eax
     3f3:	cd 40                	int    $0x40
     3f5:	c3                   	ret    

000003f6 <sleep>:
SYSCALL(sleep)
     3f6:	b8 0d 00 00 00       	mov    $0xd,%eax
     3fb:	cd 40                	int    $0x40
     3fd:	c3                   	ret    

000003fe <uptime>:
SYSCALL(uptime)
     3fe:	b8 0e 00 00 00       	mov    $0xe,%eax
     403:	cd 40                	int    $0x40
     405:	c3                   	ret    

00000406 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     406:	b8 16 00 00 00       	mov    $0x16,%eax
     40b:	cd 40                	int    $0x40
     40d:	c3                   	ret    

0000040e <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     40e:	b8 17 00 00 00       	mov    $0x17,%eax
     413:	cd 40                	int    $0x40
     415:	c3                   	ret    

00000416 <clearScreen>:
SYSCALL(clearScreen)
     416:	b8 18 00 00 00       	mov    $0x18,%eax
     41b:	cd 40                	int    $0x40
     41d:	c3                   	ret    

0000041e <writeAt>:
SYSCALL(writeAt)
     41e:	b8 19 00 00 00       	mov    $0x19,%eax
     423:	cd 40                	int    $0x40
     425:	c3                   	ret    

00000426 <setBufferFlag>:
SYSCALL(setBufferFlag)
     426:	b8 1a 00 00 00       	mov    $0x1a,%eax
     42b:	cd 40                	int    $0x40
     42d:	c3                   	ret    

0000042e <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     42e:	b8 1b 00 00 00       	mov    $0x1b,%eax
     433:	cd 40                	int    $0x40
     435:	c3                   	ret    

00000436 <getCursorPos>:
SYSCALL(getCursorPos)
     436:	b8 1c 00 00 00       	mov    $0x1c,%eax
     43b:	cd 40                	int    $0x40
     43d:	c3                   	ret    

0000043e <saveScreen>:
SYSCALL(saveScreen)
     43e:	b8 1d 00 00 00       	mov    $0x1d,%eax
     443:	cd 40                	int    $0x40
     445:	c3                   	ret    

00000446 <recorverScreen>:
SYSCALL(recorverScreen)
     446:	b8 1e 00 00 00       	mov    $0x1e,%eax
     44b:	cd 40                	int    $0x40
     44d:	c3                   	ret    

0000044e <ToScreen>:
SYSCALL(ToScreen)
     44e:	b8 1f 00 00 00       	mov    $0x1f,%eax
     453:	cd 40                	int    $0x40
     455:	c3                   	ret    

00000456 <getColor>:
SYSCALL(getColor)
     456:	b8 20 00 00 00       	mov    $0x20,%eax
     45b:	cd 40                	int    $0x40
     45d:	c3                   	ret    

0000045e <showC>:
SYSCALL(showC)
     45e:	b8 21 00 00 00       	mov    $0x21,%eax
     463:	cd 40                	int    $0x40
     465:	c3                   	ret    

00000466 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     466:	55                   	push   %ebp
     467:	89 e5                	mov    %esp,%ebp
     469:	83 ec 18             	sub    $0x18,%esp
     46c:	8b 45 0c             	mov    0xc(%ebp),%eax
     46f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     472:	83 ec 04             	sub    $0x4,%esp
     475:	6a 01                	push   $0x1
     477:	8d 45 f4             	lea    -0xc(%ebp),%eax
     47a:	50                   	push   %eax
     47b:	ff 75 08             	pushl  0x8(%ebp)
     47e:	e8 03 ff ff ff       	call   386 <write>
     483:	83 c4 10             	add    $0x10,%esp
}
     486:	90                   	nop
     487:	c9                   	leave  
     488:	c3                   	ret    

00000489 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     489:	55                   	push   %ebp
     48a:	89 e5                	mov    %esp,%ebp
     48c:	53                   	push   %ebx
     48d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     490:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     497:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     49b:	74 17                	je     4b4 <printint+0x2b>
     49d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4a1:	79 11                	jns    4b4 <printint+0x2b>
    neg = 1;
     4a3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4aa:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ad:	f7 d8                	neg    %eax
     4af:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4b2:	eb 06                	jmp    4ba <printint+0x31>
  } else {
    x = xx;
     4b4:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4c4:	8d 41 01             	lea    0x1(%ecx),%eax
     4c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4d0:	ba 00 00 00 00       	mov    $0x0,%edx
     4d5:	f7 f3                	div    %ebx
     4d7:	89 d0                	mov    %edx,%eax
     4d9:	0f b6 80 90 1a 00 00 	movzbl 0x1a90(%eax),%eax
     4e0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4e4:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4ea:	ba 00 00 00 00       	mov    $0x0,%edx
     4ef:	f7 f3                	div    %ebx
     4f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4f8:	75 c7                	jne    4c1 <printint+0x38>
  if(neg)
     4fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4fe:	74 2d                	je     52d <printint+0xa4>
    buf[i++] = '-';
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8d 50 01             	lea    0x1(%eax),%edx
     506:	89 55 f4             	mov    %edx,-0xc(%ebp)
     509:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     50e:	eb 1d                	jmp    52d <printint+0xa4>
    putc(fd, buf[i]);
     510:	8d 55 dc             	lea    -0x24(%ebp),%edx
     513:	8b 45 f4             	mov    -0xc(%ebp),%eax
     516:	01 d0                	add    %edx,%eax
     518:	0f b6 00             	movzbl (%eax),%eax
     51b:	0f be c0             	movsbl %al,%eax
     51e:	83 ec 08             	sub    $0x8,%esp
     521:	50                   	push   %eax
     522:	ff 75 08             	pushl  0x8(%ebp)
     525:	e8 3c ff ff ff       	call   466 <putc>
     52a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     52d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     531:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     535:	79 d9                	jns    510 <printint+0x87>
    putc(fd, buf[i]);
}
     537:	90                   	nop
     538:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     53b:	c9                   	leave  
     53c:	c3                   	ret    

0000053d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     53d:	55                   	push   %ebp
     53e:	89 e5                	mov    %esp,%ebp
     540:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     543:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     54a:	8d 45 0c             	lea    0xc(%ebp),%eax
     54d:	83 c0 04             	add    $0x4,%eax
     550:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     553:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     55a:	e9 59 01 00 00       	jmp    6b8 <printf+0x17b>
    c = fmt[i] & 0xff;
     55f:	8b 55 0c             	mov    0xc(%ebp),%edx
     562:	8b 45 f0             	mov    -0x10(%ebp),%eax
     565:	01 d0                	add    %edx,%eax
     567:	0f b6 00             	movzbl (%eax),%eax
     56a:	0f be c0             	movsbl %al,%eax
     56d:	25 ff 00 00 00       	and    $0xff,%eax
     572:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     575:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     579:	75 2c                	jne    5a7 <printf+0x6a>
      if(c == '%'){
     57b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     57f:	75 0c                	jne    58d <printf+0x50>
        state = '%';
     581:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     588:	e9 27 01 00 00       	jmp    6b4 <printf+0x177>
      } else {
        putc(fd, c);
     58d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     590:	0f be c0             	movsbl %al,%eax
     593:	83 ec 08             	sub    $0x8,%esp
     596:	50                   	push   %eax
     597:	ff 75 08             	pushl  0x8(%ebp)
     59a:	e8 c7 fe ff ff       	call   466 <putc>
     59f:	83 c4 10             	add    $0x10,%esp
     5a2:	e9 0d 01 00 00       	jmp    6b4 <printf+0x177>
      }
    } else if(state == '%'){
     5a7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5ab:	0f 85 03 01 00 00    	jne    6b4 <printf+0x177>
      if(c == 'd'){
     5b1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5b5:	75 1e                	jne    5d5 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ba:	8b 00                	mov    (%eax),%eax
     5bc:	6a 01                	push   $0x1
     5be:	6a 0a                	push   $0xa
     5c0:	50                   	push   %eax
     5c1:	ff 75 08             	pushl  0x8(%ebp)
     5c4:	e8 c0 fe ff ff       	call   489 <printint>
     5c9:	83 c4 10             	add    $0x10,%esp
        ap++;
     5cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d0:	e9 d8 00 00 00       	jmp    6ad <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5d5:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5d9:	74 06                	je     5e1 <printf+0xa4>
     5db:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5df:	75 1e                	jne    5ff <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e4:	8b 00                	mov    (%eax),%eax
     5e6:	6a 00                	push   $0x0
     5e8:	6a 10                	push   $0x10
     5ea:	50                   	push   %eax
     5eb:	ff 75 08             	pushl  0x8(%ebp)
     5ee:	e8 96 fe ff ff       	call   489 <printint>
     5f3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5f6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5fa:	e9 ae 00 00 00       	jmp    6ad <printf+0x170>
      } else if(c == 's'){
     5ff:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     603:	75 43                	jne    648 <printf+0x10b>
        s = (char*)*ap;
     605:	8b 45 e8             	mov    -0x18(%ebp),%eax
     608:	8b 00                	mov    (%eax),%eax
     60a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     60d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     611:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     615:	75 25                	jne    63c <printf+0xff>
          s = "(null)";
     617:	c7 45 f4 4e 13 00 00 	movl   $0x134e,-0xc(%ebp)
        while(*s != 0){
     61e:	eb 1c                	jmp    63c <printf+0xff>
          putc(fd, *s);
     620:	8b 45 f4             	mov    -0xc(%ebp),%eax
     623:	0f b6 00             	movzbl (%eax),%eax
     626:	0f be c0             	movsbl %al,%eax
     629:	83 ec 08             	sub    $0x8,%esp
     62c:	50                   	push   %eax
     62d:	ff 75 08             	pushl  0x8(%ebp)
     630:	e8 31 fe ff ff       	call   466 <putc>
     635:	83 c4 10             	add    $0x10,%esp
          s++;
     638:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     63c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63f:	0f b6 00             	movzbl (%eax),%eax
     642:	84 c0                	test   %al,%al
     644:	75 da                	jne    620 <printf+0xe3>
     646:	eb 65                	jmp    6ad <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     648:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     64c:	75 1d                	jne    66b <printf+0x12e>
        putc(fd, *ap);
     64e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     651:	8b 00                	mov    (%eax),%eax
     653:	0f be c0             	movsbl %al,%eax
     656:	83 ec 08             	sub    $0x8,%esp
     659:	50                   	push   %eax
     65a:	ff 75 08             	pushl  0x8(%ebp)
     65d:	e8 04 fe ff ff       	call   466 <putc>
     662:	83 c4 10             	add    $0x10,%esp
        ap++;
     665:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     669:	eb 42                	jmp    6ad <printf+0x170>
      } else if(c == '%'){
     66b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     66f:	75 17                	jne    688 <printf+0x14b>
        putc(fd, c);
     671:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     674:	0f be c0             	movsbl %al,%eax
     677:	83 ec 08             	sub    $0x8,%esp
     67a:	50                   	push   %eax
     67b:	ff 75 08             	pushl  0x8(%ebp)
     67e:	e8 e3 fd ff ff       	call   466 <putc>
     683:	83 c4 10             	add    $0x10,%esp
     686:	eb 25                	jmp    6ad <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     688:	83 ec 08             	sub    $0x8,%esp
     68b:	6a 25                	push   $0x25
     68d:	ff 75 08             	pushl  0x8(%ebp)
     690:	e8 d1 fd ff ff       	call   466 <putc>
     695:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     698:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     69b:	0f be c0             	movsbl %al,%eax
     69e:	83 ec 08             	sub    $0x8,%esp
     6a1:	50                   	push   %eax
     6a2:	ff 75 08             	pushl  0x8(%ebp)
     6a5:	e8 bc fd ff ff       	call   466 <putc>
     6aa:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6b4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6b8:	8b 55 0c             	mov    0xc(%ebp),%edx
     6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6be:	01 d0                	add    %edx,%eax
     6c0:	0f b6 00             	movzbl (%eax),%eax
     6c3:	84 c0                	test   %al,%al
     6c5:	0f 85 94 fe ff ff    	jne    55f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6cb:	90                   	nop
     6cc:	c9                   	leave  
     6cd:	c3                   	ret    

000006ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6ce:	55                   	push   %ebp
     6cf:	89 e5                	mov    %esp,%ebp
     6d1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6d4:	8b 45 08             	mov    0x8(%ebp),%eax
     6d7:	83 e8 08             	sub    $0x8,%eax
     6da:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6dd:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     6e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6e5:	eb 24                	jmp    70b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ea:	8b 00                	mov    (%eax),%eax
     6ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6ef:	77 12                	ja     703 <free+0x35>
     6f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6f7:	77 24                	ja     71d <free+0x4f>
     6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fc:	8b 00                	mov    (%eax),%eax
     6fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     701:	77 1a                	ja     71d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     703:	8b 45 fc             	mov    -0x4(%ebp),%eax
     706:	8b 00                	mov    (%eax),%eax
     708:	89 45 fc             	mov    %eax,-0x4(%ebp)
     70b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     711:	76 d4                	jbe    6e7 <free+0x19>
     713:	8b 45 fc             	mov    -0x4(%ebp),%eax
     716:	8b 00                	mov    (%eax),%eax
     718:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     71b:	76 ca                	jbe    6e7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     720:	8b 40 04             	mov    0x4(%eax),%eax
     723:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72d:	01 c2                	add    %eax,%edx
     72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     732:	8b 00                	mov    (%eax),%eax
     734:	39 c2                	cmp    %eax,%edx
     736:	75 24                	jne    75c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     738:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73b:	8b 50 04             	mov    0x4(%eax),%edx
     73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     741:	8b 00                	mov    (%eax),%eax
     743:	8b 40 04             	mov    0x4(%eax),%eax
     746:	01 c2                	add    %eax,%edx
     748:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     74e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     751:	8b 00                	mov    (%eax),%eax
     753:	8b 10                	mov    (%eax),%edx
     755:	8b 45 f8             	mov    -0x8(%ebp),%eax
     758:	89 10                	mov    %edx,(%eax)
     75a:	eb 0a                	jmp    766 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     75c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75f:	8b 10                	mov    (%eax),%edx
     761:	8b 45 f8             	mov    -0x8(%ebp),%eax
     764:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     766:	8b 45 fc             	mov    -0x4(%ebp),%eax
     769:	8b 40 04             	mov    0x4(%eax),%eax
     76c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     773:	8b 45 fc             	mov    -0x4(%ebp),%eax
     776:	01 d0                	add    %edx,%eax
     778:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     77b:	75 20                	jne    79d <free+0xcf>
    p->s.size += bp->s.size;
     77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     780:	8b 50 04             	mov    0x4(%eax),%edx
     783:	8b 45 f8             	mov    -0x8(%ebp),%eax
     786:	8b 40 04             	mov    0x4(%eax),%eax
     789:	01 c2                	add    %eax,%edx
     78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     791:	8b 45 f8             	mov    -0x8(%ebp),%eax
     794:	8b 10                	mov    (%eax),%edx
     796:	8b 45 fc             	mov    -0x4(%ebp),%eax
     799:	89 10                	mov    %edx,(%eax)
     79b:	eb 08                	jmp    7a5 <free+0xd7>
  } else
    p->s.ptr = bp;
     79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7a3:	89 10                	mov    %edx,(%eax)
  freep = p;
     7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a8:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
}
     7ad:	90                   	nop
     7ae:	c9                   	leave  
     7af:	c3                   	ret    

000007b0 <morecore>:

static Header*
morecore(uint nu)
{
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7b6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7bd:	77 07                	ja     7c6 <morecore+0x16>
    nu = 4096;
     7bf:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7c6:	8b 45 08             	mov    0x8(%ebp),%eax
     7c9:	c1 e0 03             	shl    $0x3,%eax
     7cc:	83 ec 0c             	sub    $0xc,%esp
     7cf:	50                   	push   %eax
     7d0:	e8 19 fc ff ff       	call   3ee <sbrk>
     7d5:	83 c4 10             	add    $0x10,%esp
     7d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7db:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7df:	75 07                	jne    7e8 <morecore+0x38>
    return 0;
     7e1:	b8 00 00 00 00       	mov    $0x0,%eax
     7e6:	eb 26                	jmp    80e <morecore+0x5e>
  hp = (Header*)p;
     7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f1:	8b 55 08             	mov    0x8(%ebp),%edx
     7f4:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fa:	83 c0 08             	add    $0x8,%eax
     7fd:	83 ec 0c             	sub    $0xc,%esp
     800:	50                   	push   %eax
     801:	e8 c8 fe ff ff       	call   6ce <free>
     806:	83 c4 10             	add    $0x10,%esp
  return freep;
     809:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
}
     80e:	c9                   	leave  
     80f:	c3                   	ret    

00000810 <malloc>:

void*
malloc(uint nbytes)
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     816:	8b 45 08             	mov    0x8(%ebp),%eax
     819:	83 c0 07             	add    $0x7,%eax
     81c:	c1 e8 03             	shr    $0x3,%eax
     81f:	83 c0 01             	add    $0x1,%eax
     822:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     825:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     82a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     82d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     831:	75 23                	jne    856 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     833:	c7 45 f0 c0 1a 00 00 	movl   $0x1ac0,-0x10(%ebp)
     83a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     83d:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
     842:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     847:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
    base.s.size = 0;
     84c:	c7 05 c4 1a 00 00 00 	movl   $0x0,0x1ac4
     853:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     856:	8b 45 f0             	mov    -0x10(%ebp),%eax
     859:	8b 00                	mov    (%eax),%eax
     85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     861:	8b 40 04             	mov    0x4(%eax),%eax
     864:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     867:	72 4d                	jb     8b6 <malloc+0xa6>
      if(p->s.size == nunits)
     869:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86c:	8b 40 04             	mov    0x4(%eax),%eax
     86f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     872:	75 0c                	jne    880 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     874:	8b 45 f4             	mov    -0xc(%ebp),%eax
     877:	8b 10                	mov    (%eax),%edx
     879:	8b 45 f0             	mov    -0x10(%ebp),%eax
     87c:	89 10                	mov    %edx,(%eax)
     87e:	eb 26                	jmp    8a6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     880:	8b 45 f4             	mov    -0xc(%ebp),%eax
     883:	8b 40 04             	mov    0x4(%eax),%eax
     886:	2b 45 ec             	sub    -0x14(%ebp),%eax
     889:	89 c2                	mov    %eax,%edx
     88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     891:	8b 45 f4             	mov    -0xc(%ebp),%eax
     894:	8b 40 04             	mov    0x4(%eax),%eax
     897:	c1 e0 03             	shl    $0x3,%eax
     89a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8a3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a9:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
      return (void*)(p + 1);
     8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b1:	83 c0 08             	add    $0x8,%eax
     8b4:	eb 3b                	jmp    8f1 <malloc+0xe1>
    }
    if(p == freep)
     8b6:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     8bb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8be:	75 1e                	jne    8de <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8c0:	83 ec 0c             	sub    $0xc,%esp
     8c3:	ff 75 ec             	pushl  -0x14(%ebp)
     8c6:	e8 e5 fe ff ff       	call   7b0 <morecore>
     8cb:	83 c4 10             	add    $0x10,%esp
     8ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8d5:	75 07                	jne    8de <malloc+0xce>
        return 0;
     8d7:	b8 00 00 00 00       	mov    $0x0,%eax
     8dc:	eb 13                	jmp    8f1 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e7:	8b 00                	mov    (%eax),%eax
     8e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8ec:	e9 6d ff ff ff       	jmp    85e <malloc+0x4e>
}
     8f1:	c9                   	leave  
     8f2:	c3                   	ret    

000008f3 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     8f3:	55                   	push   %ebp
     8f4:	89 e5                	mov    %esp,%ebp
     8f6:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     8f9:	83 ec 0c             	sub    $0xc,%esp
     8fc:	ff 75 08             	pushl  0x8(%ebp)
     8ff:	e8 b0 00 00 00       	call   9b4 <re_compile>
     904:	83 c4 10             	add    $0x10,%esp
     907:	83 ec 04             	sub    $0x4,%esp
     90a:	ff 75 10             	pushl  0x10(%ebp)
     90d:	ff 75 0c             	pushl  0xc(%ebp)
     910:	50                   	push   %eax
     911:	e8 05 00 00 00       	call   91b <re_matchp>
     916:	83 c4 10             	add    $0x10,%esp
}
     919:	c9                   	leave  
     91a:	c3                   	ret    

0000091b <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     91b:	55                   	push   %ebp
     91c:	89 e5                	mov    %esp,%ebp
     91e:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     921:	8b 45 10             	mov    0x10(%ebp),%eax
     924:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     92a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     92e:	74 7d                	je     9ad <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     930:	8b 45 08             	mov    0x8(%ebp),%eax
     933:	0f b6 00             	movzbl (%eax),%eax
     936:	3c 02                	cmp    $0x2,%al
     938:	75 2a                	jne    964 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     93a:	8b 45 08             	mov    0x8(%ebp),%eax
     93d:	83 c0 08             	add    $0x8,%eax
     940:	83 ec 04             	sub    $0x4,%esp
     943:	ff 75 10             	pushl  0x10(%ebp)
     946:	ff 75 0c             	pushl  0xc(%ebp)
     949:	50                   	push   %eax
     94a:	e8 b0 08 00 00       	call   11ff <matchpattern>
     94f:	83 c4 10             	add    $0x10,%esp
     952:	85 c0                	test   %eax,%eax
     954:	74 07                	je     95d <re_matchp+0x42>
     956:	b8 00 00 00 00       	mov    $0x0,%eax
     95b:	eb 55                	jmp    9b2 <re_matchp+0x97>
     95d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     962:	eb 4e                	jmp    9b2 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     964:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     96b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     96f:	83 ec 04             	sub    $0x4,%esp
     972:	ff 75 10             	pushl  0x10(%ebp)
     975:	ff 75 0c             	pushl  0xc(%ebp)
     978:	ff 75 08             	pushl  0x8(%ebp)
     97b:	e8 7f 08 00 00       	call   11ff <matchpattern>
     980:	83 c4 10             	add    $0x10,%esp
     983:	85 c0                	test   %eax,%eax
     985:	74 16                	je     99d <re_matchp+0x82>
        {
          if (text[0] == '\0')
     987:	8b 45 0c             	mov    0xc(%ebp),%eax
     98a:	0f b6 00             	movzbl (%eax),%eax
     98d:	84 c0                	test   %al,%al
     98f:	75 07                	jne    998 <re_matchp+0x7d>
            return -1;
     991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     996:	eb 1a                	jmp    9b2 <re_matchp+0x97>
        
          return idx;
     998:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99b:	eb 15                	jmp    9b2 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     99d:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a0:	8d 50 01             	lea    0x1(%eax),%edx
     9a3:	89 55 0c             	mov    %edx,0xc(%ebp)
     9a6:	0f b6 00             	movzbl (%eax),%eax
     9a9:	84 c0                	test   %al,%al
     9ab:	75 be                	jne    96b <re_matchp+0x50>
    }
  }
  return -1;
     9ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9b2:	c9                   	leave  
     9b3:	c3                   	ret    

000009b4 <re_compile>:

re_t re_compile(const char* pattern)
{
     9b4:	55                   	push   %ebp
     9b5:	89 e5                	mov    %esp,%ebp
     9b7:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     9ba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     9c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     9c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     9cf:	e9 55 02 00 00       	jmp    c29 <re_compile+0x275>
  {
    c = pattern[i];
     9d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9d7:	8b 45 08             	mov    0x8(%ebp),%eax
     9da:	01 d0                	add    %edx,%eax
     9dc:	0f b6 00             	movzbl (%eax),%eax
     9df:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     9e2:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     9e6:	83 e8 24             	sub    $0x24,%eax
     9e9:	83 f8 3a             	cmp    $0x3a,%eax
     9ec:	0f 87 13 02 00 00    	ja     c05 <re_compile+0x251>
     9f2:	8b 04 85 58 13 00 00 	mov    0x1358(,%eax,4),%eax
     9f9:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     9fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fe:	c6 04 c5 e0 1a 00 00 	movb   $0x2,0x1ae0(,%eax,8)
     a05:	02 
     a06:	e9 16 02 00 00       	jmp    c21 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     a0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0e:	c6 04 c5 e0 1a 00 00 	movb   $0x3,0x1ae0(,%eax,8)
     a15:	03 
     a16:	e9 06 02 00 00       	jmp    c21 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1e:	c6 04 c5 e0 1a 00 00 	movb   $0x1,0x1ae0(,%eax,8)
     a25:	01 
     a26:	e9 f6 01 00 00       	jmp    c21 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	c6 04 c5 e0 1a 00 00 	movb   $0x5,0x1ae0(,%eax,8)
     a35:	05 
     a36:	e9 e6 01 00 00       	jmp    c21 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3e:	c6 04 c5 e0 1a 00 00 	movb   $0x6,0x1ae0(,%eax,8)
     a45:	06 
     a46:	e9 d6 01 00 00       	jmp    c21 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4e:	c6 04 c5 e0 1a 00 00 	movb   $0x4,0x1ae0(,%eax,8)
     a55:	04 
     a56:	e9 c6 01 00 00       	jmp    c21 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     a5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a5e:	8d 50 01             	lea    0x1(%eax),%edx
     a61:	8b 45 08             	mov    0x8(%ebp),%eax
     a64:	01 d0                	add    %edx,%eax
     a66:	0f b6 00             	movzbl (%eax),%eax
     a69:	84 c0                	test   %al,%al
     a6b:	0f 84 af 01 00 00    	je     c20 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     a71:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     a75:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a78:	8b 45 08             	mov    0x8(%ebp),%eax
     a7b:	01 d0                	add    %edx,%eax
     a7d:	0f b6 00             	movzbl (%eax),%eax
     a80:	0f be c0             	movsbl %al,%eax
     a83:	83 e8 44             	sub    $0x44,%eax
     a86:	83 f8 33             	cmp    $0x33,%eax
     a89:	77 57                	ja     ae2 <re_compile+0x12e>
     a8b:	8b 04 85 44 14 00 00 	mov    0x1444(,%eax,4),%eax
     a92:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a97:	c6 04 c5 e0 1a 00 00 	movb   $0xa,0x1ae0(,%eax,8)
     a9e:	0a 
     a9f:	eb 64                	jmp    b05 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa4:	c6 04 c5 e0 1a 00 00 	movb   $0xb,0x1ae0(,%eax,8)
     aab:	0b 
     aac:	eb 57                	jmp    b05 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab1:	c6 04 c5 e0 1a 00 00 	movb   $0xc,0x1ae0(,%eax,8)
     ab8:	0c 
     ab9:	eb 4a                	jmp    b05 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abe:	c6 04 c5 e0 1a 00 00 	movb   $0xd,0x1ae0(,%eax,8)
     ac5:	0d 
     ac6:	eb 3d                	jmp    b05 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acb:	c6 04 c5 e0 1a 00 00 	movb   $0xe,0x1ae0(,%eax,8)
     ad2:	0e 
     ad3:	eb 30                	jmp    b05 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad8:	c6 04 c5 e0 1a 00 00 	movb   $0xf,0x1ae0(,%eax,8)
     adf:	0f 
     ae0:	eb 23                	jmp    b05 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae5:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     aec:	07 
              re_compiled[j].ch = pattern[i];
     aed:	8b 55 f8             	mov    -0x8(%ebp),%edx
     af0:	8b 45 08             	mov    0x8(%ebp),%eax
     af3:	01 d0                	add    %edx,%eax
     af5:	0f b6 00             	movzbl (%eax),%eax
     af8:	89 c2                	mov    %eax,%edx
     afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afd:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
            } break;
     b04:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b05:	e9 16 01 00 00       	jmp    c20 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     b0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b0d:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     b10:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b13:	8d 50 01             	lea    0x1(%eax),%edx
     b16:	8b 45 08             	mov    0x8(%ebp),%eax
     b19:	01 d0                	add    %edx,%eax
     b1b:	0f b6 00             	movzbl (%eax),%eax
     b1e:	3c 5e                	cmp    $0x5e,%al
     b20:	75 11                	jne    b33 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b25:	c6 04 c5 e0 1a 00 00 	movb   $0x9,0x1ae0(,%eax,8)
     b2c:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     b2d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b31:	eb 7a                	jmp    bad <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b36:	c6 04 c5 e0 1a 00 00 	movb   $0x8,0x1ae0(,%eax,8)
     b3d:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b3e:	eb 6d                	jmp    bad <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     b40:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	01 d0                	add    %edx,%eax
     b48:	0f b6 00             	movzbl (%eax),%eax
     b4b:	3c 5c                	cmp    $0x5c,%al
     b4d:	75 34                	jne    b83 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     b4f:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     b53:	7e 0a                	jle    b5f <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b55:	b8 00 00 00 00       	mov    $0x0,%eax
     b5a:	e9 f8 00 00 00       	jmp    c57 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     b5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b62:	8d 50 01             	lea    0x1(%eax),%edx
     b65:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b68:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b6b:	8d 4a 01             	lea    0x1(%edx),%ecx
     b6e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     b71:	89 d1                	mov    %edx,%ecx
     b73:	8b 55 08             	mov    0x8(%ebp),%edx
     b76:	01 ca                	add    %ecx,%edx
     b78:	0f b6 12             	movzbl (%edx),%edx
     b7b:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
     b81:	eb 10                	jmp    b93 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b83:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b87:	7e 0a                	jle    b93 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b89:	b8 00 00 00 00       	mov    $0x0,%eax
     b8e:	e9 c4 00 00 00       	jmp    c57 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     b93:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b96:	8d 50 01             	lea    0x1(%eax),%edx
     b99:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b9c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     b9f:	8b 55 08             	mov    0x8(%ebp),%edx
     ba2:	01 ca                	add    %ecx,%edx
     ba4:	0f b6 12             	movzbl (%edx),%edx
     ba7:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     bad:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     bb1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	01 d0                	add    %edx,%eax
     bb9:	0f b6 00             	movzbl (%eax),%eax
     bbc:	3c 5d                	cmp    $0x5d,%al
     bbe:	74 13                	je     bd3 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     bc0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bc3:	8b 45 08             	mov    0x8(%ebp),%eax
     bc6:	01 d0                	add    %edx,%eax
     bc8:	0f b6 00             	movzbl (%eax),%eax
     bcb:	84 c0                	test   %al,%al
     bcd:	0f 85 6d ff ff ff    	jne    b40 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     bd3:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     bd7:	7e 07                	jle    be0 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     bd9:	b8 00 00 00 00       	mov    $0x0,%eax
     bde:	eb 77                	jmp    c57 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     be0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     be3:	8d 50 01             	lea    0x1(%eax),%edx
     be6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     be9:	c6 80 e0 1b 00 00 00 	movb   $0x0,0x1be0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     bf0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bf3:	8d 90 e0 1b 00 00    	lea    0x1be0(%eax),%edx
     bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bfc:	89 14 c5 e4 1a 00 00 	mov    %edx,0x1ae4(,%eax,8)
      } break;
     c03:	eb 1c                	jmp    c21 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c08:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     c0f:	07 
        re_compiled[j].ch = c;
     c10:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c17:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
      } break;
     c1e:	eb 01                	jmp    c21 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     c20:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     c21:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     c25:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     c29:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	01 d0                	add    %edx,%eax
     c31:	0f b6 00             	movzbl (%eax),%eax
     c34:	84 c0                	test   %al,%al
     c36:	74 0f                	je     c47 <re_compile+0x293>
     c38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3b:	83 c0 01             	add    $0x1,%eax
     c3e:	83 f8 1d             	cmp    $0x1d,%eax
     c41:	0f 8e 8d fd ff ff    	jle    9d4 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4a:	c6 04 c5 e0 1a 00 00 	movb   $0x0,0x1ae0(,%eax,8)
     c51:	00 

  return (re_t) re_compiled;
     c52:	b8 e0 1a 00 00       	mov    $0x1ae0,%eax
}
     c57:	c9                   	leave  
     c58:	c3                   	ret    

00000c59 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     c59:	55                   	push   %ebp
     c5a:	89 e5                	mov    %esp,%ebp
     c5c:	83 ec 04             	sub    $0x4,%esp
     c5f:	8b 45 08             	mov    0x8(%ebp),%eax
     c62:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     c65:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     c69:	7e 0d                	jle    c78 <matchdigit+0x1f>
     c6b:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     c6f:	7f 07                	jg     c78 <matchdigit+0x1f>
     c71:	b8 01 00 00 00       	mov    $0x1,%eax
     c76:	eb 05                	jmp    c7d <matchdigit+0x24>
     c78:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c7d:	c9                   	leave  
     c7e:	c3                   	ret    

00000c7f <matchalpha>:
static int matchalpha(char c)
{
     c7f:	55                   	push   %ebp
     c80:	89 e5                	mov    %esp,%ebp
     c82:	83 ec 04             	sub    $0x4,%esp
     c85:	8b 45 08             	mov    0x8(%ebp),%eax
     c88:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     c8b:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     c8f:	7e 06                	jle    c97 <matchalpha+0x18>
     c91:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     c95:	7e 0c                	jle    ca3 <matchalpha+0x24>
     c97:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     c9b:	7e 0d                	jle    caa <matchalpha+0x2b>
     c9d:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     ca1:	7f 07                	jg     caa <matchalpha+0x2b>
     ca3:	b8 01 00 00 00       	mov    $0x1,%eax
     ca8:	eb 05                	jmp    caf <matchalpha+0x30>
     caa:	b8 00 00 00 00       	mov    $0x0,%eax
}
     caf:	c9                   	leave  
     cb0:	c3                   	ret    

00000cb1 <matchwhitespace>:
static int matchwhitespace(char c)
{
     cb1:	55                   	push   %ebp
     cb2:	89 e5                	mov    %esp,%ebp
     cb4:	83 ec 04             	sub    $0x4,%esp
     cb7:	8b 45 08             	mov    0x8(%ebp),%eax
     cba:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     cbd:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     cc1:	74 1e                	je     ce1 <matchwhitespace+0x30>
     cc3:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     cc7:	74 18                	je     ce1 <matchwhitespace+0x30>
     cc9:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     ccd:	74 12                	je     ce1 <matchwhitespace+0x30>
     ccf:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     cd3:	74 0c                	je     ce1 <matchwhitespace+0x30>
     cd5:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     cd9:	74 06                	je     ce1 <matchwhitespace+0x30>
     cdb:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     cdf:	75 07                	jne    ce8 <matchwhitespace+0x37>
     ce1:	b8 01 00 00 00       	mov    $0x1,%eax
     ce6:	eb 05                	jmp    ced <matchwhitespace+0x3c>
     ce8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ced:	c9                   	leave  
     cee:	c3                   	ret    

00000cef <matchalphanum>:
static int matchalphanum(char c)
{
     cef:	55                   	push   %ebp
     cf0:	89 e5                	mov    %esp,%ebp
     cf2:	83 ec 04             	sub    $0x4,%esp
     cf5:	8b 45 08             	mov    0x8(%ebp),%eax
     cf8:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     cfb:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     cff:	74 22                	je     d23 <matchalphanum+0x34>
     d01:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d05:	50                   	push   %eax
     d06:	e8 74 ff ff ff       	call   c7f <matchalpha>
     d0b:	83 c4 04             	add    $0x4,%esp
     d0e:	85 c0                	test   %eax,%eax
     d10:	75 11                	jne    d23 <matchalphanum+0x34>
     d12:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d16:	50                   	push   %eax
     d17:	e8 3d ff ff ff       	call   c59 <matchdigit>
     d1c:	83 c4 04             	add    $0x4,%esp
     d1f:	85 c0                	test   %eax,%eax
     d21:	74 07                	je     d2a <matchalphanum+0x3b>
     d23:	b8 01 00 00 00       	mov    $0x1,%eax
     d28:	eb 05                	jmp    d2f <matchalphanum+0x40>
     d2a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d2f:	c9                   	leave  
     d30:	c3                   	ret    

00000d31 <matchrange>:
static int matchrange(char c, const char* str)
{
     d31:	55                   	push   %ebp
     d32:	89 e5                	mov    %esp,%ebp
     d34:	83 ec 04             	sub    $0x4,%esp
     d37:	8b 45 08             	mov    0x8(%ebp),%eax
     d3a:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d3d:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     d41:	74 5b                	je     d9e <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     d43:	8b 45 0c             	mov    0xc(%ebp),%eax
     d46:	0f b6 00             	movzbl (%eax),%eax
     d49:	84 c0                	test   %al,%al
     d4b:	74 51                	je     d9e <matchrange+0x6d>
     d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d50:	0f b6 00             	movzbl (%eax),%eax
     d53:	3c 2d                	cmp    $0x2d,%al
     d55:	74 47                	je     d9e <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     d57:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5a:	83 c0 01             	add    $0x1,%eax
     d5d:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     d60:	3c 2d                	cmp    $0x2d,%al
     d62:	75 3a                	jne    d9e <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     d64:	8b 45 0c             	mov    0xc(%ebp),%eax
     d67:	83 c0 01             	add    $0x1,%eax
     d6a:	0f b6 00             	movzbl (%eax),%eax
     d6d:	84 c0                	test   %al,%al
     d6f:	74 2d                	je     d9e <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d71:	8b 45 0c             	mov    0xc(%ebp),%eax
     d74:	83 c0 02             	add    $0x2,%eax
     d77:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     d7a:	84 c0                	test   %al,%al
     d7c:	74 20                	je     d9e <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d7e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d87:	7f 15                	jg     d9e <matchrange+0x6d>
     d89:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8c:	83 c0 02             	add    $0x2,%eax
     d8f:	0f b6 00             	movzbl (%eax),%eax
     d92:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d95:	7c 07                	jl     d9e <matchrange+0x6d>
     d97:	b8 01 00 00 00       	mov    $0x1,%eax
     d9c:	eb 05                	jmp    da3 <matchrange+0x72>
     d9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     da3:	c9                   	leave  
     da4:	c3                   	ret    

00000da5 <ismetachar>:
static int ismetachar(char c)
{
     da5:	55                   	push   %ebp
     da6:	89 e5                	mov    %esp,%ebp
     da8:	83 ec 04             	sub    $0x4,%esp
     dab:	8b 45 08             	mov    0x8(%ebp),%eax
     dae:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     db1:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     db5:	74 1e                	je     dd5 <ismetachar+0x30>
     db7:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     dbb:	74 18                	je     dd5 <ismetachar+0x30>
     dbd:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     dc1:	74 12                	je     dd5 <ismetachar+0x30>
     dc3:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     dc7:	74 0c                	je     dd5 <ismetachar+0x30>
     dc9:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     dcd:	74 06                	je     dd5 <ismetachar+0x30>
     dcf:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     dd3:	75 07                	jne    ddc <ismetachar+0x37>
     dd5:	b8 01 00 00 00       	mov    $0x1,%eax
     dda:	eb 05                	jmp    de1 <ismetachar+0x3c>
     ddc:	b8 00 00 00 00       	mov    $0x0,%eax
}
     de1:	c9                   	leave  
     de2:	c3                   	ret    

00000de3 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     de3:	55                   	push   %ebp
     de4:	89 e5                	mov    %esp,%ebp
     de6:	83 ec 04             	sub    $0x4,%esp
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     def:	8b 45 0c             	mov    0xc(%ebp),%eax
     df2:	0f b6 00             	movzbl (%eax),%eax
     df5:	0f be c0             	movsbl %al,%eax
     df8:	83 e8 44             	sub    $0x44,%eax
     dfb:	83 f8 33             	cmp    $0x33,%eax
     dfe:	77 7b                	ja     e7b <matchmetachar+0x98>
     e00:	8b 04 85 14 15 00 00 	mov    0x1514(,%eax,4),%eax
     e07:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     e09:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e0d:	50                   	push   %eax
     e0e:	e8 46 fe ff ff       	call   c59 <matchdigit>
     e13:	83 c4 04             	add    $0x4,%esp
     e16:	eb 72                	jmp    e8a <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     e18:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e1c:	50                   	push   %eax
     e1d:	e8 37 fe ff ff       	call   c59 <matchdigit>
     e22:	83 c4 04             	add    $0x4,%esp
     e25:	85 c0                	test   %eax,%eax
     e27:	0f 94 c0             	sete   %al
     e2a:	0f b6 c0             	movzbl %al,%eax
     e2d:	eb 5b                	jmp    e8a <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     e2f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e33:	50                   	push   %eax
     e34:	e8 b6 fe ff ff       	call   cef <matchalphanum>
     e39:	83 c4 04             	add    $0x4,%esp
     e3c:	eb 4c                	jmp    e8a <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     e3e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e42:	50                   	push   %eax
     e43:	e8 a7 fe ff ff       	call   cef <matchalphanum>
     e48:	83 c4 04             	add    $0x4,%esp
     e4b:	85 c0                	test   %eax,%eax
     e4d:	0f 94 c0             	sete   %al
     e50:	0f b6 c0             	movzbl %al,%eax
     e53:	eb 35                	jmp    e8a <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     e55:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e59:	50                   	push   %eax
     e5a:	e8 52 fe ff ff       	call   cb1 <matchwhitespace>
     e5f:	83 c4 04             	add    $0x4,%esp
     e62:	eb 26                	jmp    e8a <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     e64:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e68:	50                   	push   %eax
     e69:	e8 43 fe ff ff       	call   cb1 <matchwhitespace>
     e6e:	83 c4 04             	add    $0x4,%esp
     e71:	85 c0                	test   %eax,%eax
     e73:	0f 94 c0             	sete   %al
     e76:	0f b6 c0             	movzbl %al,%eax
     e79:	eb 0f                	jmp    e8a <matchmetachar+0xa7>
    default:  return (c == str[0]);
     e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7e:	0f b6 00             	movzbl (%eax),%eax
     e81:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e84:	0f 94 c0             	sete   %al
     e87:	0f b6 c0             	movzbl %al,%eax
  }
}
     e8a:	c9                   	leave  
     e8b:	c3                   	ret    

00000e8c <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     e8c:	55                   	push   %ebp
     e8d:	89 e5                	mov    %esp,%ebp
     e8f:	83 ec 04             	sub    $0x4,%esp
     e92:	8b 45 08             	mov    0x8(%ebp),%eax
     e95:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     e98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e9c:	ff 75 0c             	pushl  0xc(%ebp)
     e9f:	50                   	push   %eax
     ea0:	e8 8c fe ff ff       	call   d31 <matchrange>
     ea5:	83 c4 08             	add    $0x8,%esp
     ea8:	85 c0                	test   %eax,%eax
     eaa:	74 0a                	je     eb6 <matchcharclass+0x2a>
    {
      return 1;
     eac:	b8 01 00 00 00       	mov    $0x1,%eax
     eb1:	e9 a5 00 00 00       	jmp    f5b <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb9:	0f b6 00             	movzbl (%eax),%eax
     ebc:	3c 5c                	cmp    $0x5c,%al
     ebe:	75 42                	jne    f02 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     ec0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     ec4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ec8:	ff 75 0c             	pushl  0xc(%ebp)
     ecb:	50                   	push   %eax
     ecc:	e8 12 ff ff ff       	call   de3 <matchmetachar>
     ed1:	83 c4 08             	add    $0x8,%esp
     ed4:	85 c0                	test   %eax,%eax
     ed6:	74 07                	je     edf <matchcharclass+0x53>
      {
        return 1;
     ed8:	b8 01 00 00 00       	mov    $0x1,%eax
     edd:	eb 7c                	jmp    f5b <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     edf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee2:	0f b6 00             	movzbl (%eax),%eax
     ee5:	3a 45 fc             	cmp    -0x4(%ebp),%al
     ee8:	75 58                	jne    f42 <matchcharclass+0xb6>
     eea:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eee:	50                   	push   %eax
     eef:	e8 b1 fe ff ff       	call   da5 <ismetachar>
     ef4:	83 c4 04             	add    $0x4,%esp
     ef7:	85 c0                	test   %eax,%eax
     ef9:	75 47                	jne    f42 <matchcharclass+0xb6>
      {
        return 1;
     efb:	b8 01 00 00 00       	mov    $0x1,%eax
     f00:	eb 59                	jmp    f5b <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     f02:	8b 45 0c             	mov    0xc(%ebp),%eax
     f05:	0f b6 00             	movzbl (%eax),%eax
     f08:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f0b:	75 35                	jne    f42 <matchcharclass+0xb6>
    {
      if (c == '-')
     f0d:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     f11:	75 28                	jne    f3b <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     f13:	8b 45 0c             	mov    0xc(%ebp),%eax
     f16:	83 e8 01             	sub    $0x1,%eax
     f19:	0f b6 00             	movzbl (%eax),%eax
     f1c:	84 c0                	test   %al,%al
     f1e:	74 0d                	je     f2d <matchcharclass+0xa1>
     f20:	8b 45 0c             	mov    0xc(%ebp),%eax
     f23:	83 c0 01             	add    $0x1,%eax
     f26:	0f b6 00             	movzbl (%eax),%eax
     f29:	84 c0                	test   %al,%al
     f2b:	75 07                	jne    f34 <matchcharclass+0xa8>
     f2d:	b8 01 00 00 00       	mov    $0x1,%eax
     f32:	eb 27                	jmp    f5b <matchcharclass+0xcf>
     f34:	b8 00 00 00 00       	mov    $0x0,%eax
     f39:	eb 20                	jmp    f5b <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     f3b:	b8 01 00 00 00       	mov    $0x1,%eax
     f40:	eb 19                	jmp    f5b <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     f42:	8b 45 0c             	mov    0xc(%ebp),%eax
     f45:	8d 50 01             	lea    0x1(%eax),%edx
     f48:	89 55 0c             	mov    %edx,0xc(%ebp)
     f4b:	0f b6 00             	movzbl (%eax),%eax
     f4e:	84 c0                	test   %al,%al
     f50:	0f 85 42 ff ff ff    	jne    e98 <matchcharclass+0xc>

  return 0;
     f56:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f5b:	c9                   	leave  
     f5c:	c3                   	ret    

00000f5d <matchone>:

static int matchone(regex_t p, char c)
{
     f5d:	55                   	push   %ebp
     f5e:	89 e5                	mov    %esp,%ebp
     f60:	83 ec 04             	sub    $0x4,%esp
     f63:	8b 45 10             	mov    0x10(%ebp),%eax
     f66:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     f69:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     f6d:	0f b6 c0             	movzbl %al,%eax
     f70:	83 f8 0f             	cmp    $0xf,%eax
     f73:	0f 87 b9 00 00 00    	ja     1032 <matchone+0xd5>
     f79:	8b 04 85 e4 15 00 00 	mov    0x15e4(,%eax,4),%eax
     f80:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     f82:	b8 01 00 00 00       	mov    $0x1,%eax
     f87:	e9 b9 00 00 00       	jmp    1045 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     f8c:	8b 55 0c             	mov    0xc(%ebp),%edx
     f8f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f93:	52                   	push   %edx
     f94:	50                   	push   %eax
     f95:	e8 f2 fe ff ff       	call   e8c <matchcharclass>
     f9a:	83 c4 08             	add    $0x8,%esp
     f9d:	e9 a3 00 00 00       	jmp    1045 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     fa2:	8b 55 0c             	mov    0xc(%ebp),%edx
     fa5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fa9:	52                   	push   %edx
     faa:	50                   	push   %eax
     fab:	e8 dc fe ff ff       	call   e8c <matchcharclass>
     fb0:	83 c4 08             	add    $0x8,%esp
     fb3:	85 c0                	test   %eax,%eax
     fb5:	0f 94 c0             	sete   %al
     fb8:	0f b6 c0             	movzbl %al,%eax
     fbb:	e9 85 00 00 00       	jmp    1045 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     fc0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fc4:	50                   	push   %eax
     fc5:	e8 8f fc ff ff       	call   c59 <matchdigit>
     fca:	83 c4 04             	add    $0x4,%esp
     fcd:	eb 76                	jmp    1045 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     fcf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fd3:	50                   	push   %eax
     fd4:	e8 80 fc ff ff       	call   c59 <matchdigit>
     fd9:	83 c4 04             	add    $0x4,%esp
     fdc:	85 c0                	test   %eax,%eax
     fde:	0f 94 c0             	sete   %al
     fe1:	0f b6 c0             	movzbl %al,%eax
     fe4:	eb 5f                	jmp    1045 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     fe6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fea:	50                   	push   %eax
     feb:	e8 ff fc ff ff       	call   cef <matchalphanum>
     ff0:	83 c4 04             	add    $0x4,%esp
     ff3:	eb 50                	jmp    1045 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     ff5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ff9:	50                   	push   %eax
     ffa:	e8 f0 fc ff ff       	call   cef <matchalphanum>
     fff:	83 c4 04             	add    $0x4,%esp
    1002:	85 c0                	test   %eax,%eax
    1004:	0f 94 c0             	sete   %al
    1007:	0f b6 c0             	movzbl %al,%eax
    100a:	eb 39                	jmp    1045 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    100c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1010:	50                   	push   %eax
    1011:	e8 9b fc ff ff       	call   cb1 <matchwhitespace>
    1016:	83 c4 04             	add    $0x4,%esp
    1019:	eb 2a                	jmp    1045 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    101b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    101f:	50                   	push   %eax
    1020:	e8 8c fc ff ff       	call   cb1 <matchwhitespace>
    1025:	83 c4 04             	add    $0x4,%esp
    1028:	85 c0                	test   %eax,%eax
    102a:	0f 94 c0             	sete   %al
    102d:	0f b6 c0             	movzbl %al,%eax
    1030:	eb 13                	jmp    1045 <matchone+0xe8>
    default:             return  (p.ch == c);
    1032:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    1036:	0f b6 d0             	movzbl %al,%edx
    1039:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    103d:	39 c2                	cmp    %eax,%edx
    103f:	0f 94 c0             	sete   %al
    1042:	0f b6 c0             	movzbl %al,%eax
  }
}
    1045:	c9                   	leave  
    1046:	c3                   	ret    

00001047 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1047:	55                   	push   %ebp
    1048:	89 e5                	mov    %esp,%ebp
    104a:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    104d:	8b 45 18             	mov    0x18(%ebp),%eax
    1050:	8b 00                	mov    (%eax),%eax
    1052:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1055:	8b 45 14             	mov    0x14(%ebp),%eax
    1058:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    105b:	eb 11                	jmp    106e <matchstar+0x27>
  {
    text++;
    105d:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1061:	8b 45 18             	mov    0x18(%ebp),%eax
    1064:	8b 00                	mov    (%eax),%eax
    1066:	8d 50 01             	lea    0x1(%eax),%edx
    1069:	8b 45 18             	mov    0x18(%ebp),%eax
    106c:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    106e:	8b 45 14             	mov    0x14(%ebp),%eax
    1071:	0f b6 00             	movzbl (%eax),%eax
    1074:	84 c0                	test   %al,%al
    1076:	74 51                	je     10c9 <matchstar+0x82>
    1078:	8b 45 14             	mov    0x14(%ebp),%eax
    107b:	0f b6 00             	movzbl (%eax),%eax
    107e:	0f be c0             	movsbl %al,%eax
    1081:	50                   	push   %eax
    1082:	ff 75 0c             	pushl  0xc(%ebp)
    1085:	ff 75 08             	pushl  0x8(%ebp)
    1088:	e8 d0 fe ff ff       	call   f5d <matchone>
    108d:	83 c4 0c             	add    $0xc,%esp
    1090:	85 c0                	test   %eax,%eax
    1092:	75 c9                	jne    105d <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1094:	eb 33                	jmp    10c9 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    1096:	8b 45 14             	mov    0x14(%ebp),%eax
    1099:	8d 50 ff             	lea    -0x1(%eax),%edx
    109c:	89 55 14             	mov    %edx,0x14(%ebp)
    109f:	83 ec 04             	sub    $0x4,%esp
    10a2:	ff 75 18             	pushl  0x18(%ebp)
    10a5:	50                   	push   %eax
    10a6:	ff 75 10             	pushl  0x10(%ebp)
    10a9:	e8 51 01 00 00       	call   11ff <matchpattern>
    10ae:	83 c4 10             	add    $0x10,%esp
    10b1:	85 c0                	test   %eax,%eax
    10b3:	74 07                	je     10bc <matchstar+0x75>
      return 1;
    10b5:	b8 01 00 00 00       	mov    $0x1,%eax
    10ba:	eb 22                	jmp    10de <matchstar+0x97>
    (*matchlength)--;
    10bc:	8b 45 18             	mov    0x18(%ebp),%eax
    10bf:	8b 00                	mov    (%eax),%eax
    10c1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c4:	8b 45 18             	mov    0x18(%ebp),%eax
    10c7:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    10c9:	8b 45 14             	mov    0x14(%ebp),%eax
    10cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    10cf:	73 c5                	jae    1096 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    10d1:	8b 45 18             	mov    0x18(%ebp),%eax
    10d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10d7:	89 10                	mov    %edx,(%eax)
  return 0;
    10d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10de:	c9                   	leave  
    10df:	c3                   	ret    

000010e0 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    10e6:	8b 45 14             	mov    0x14(%ebp),%eax
    10e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    10ec:	eb 11                	jmp    10ff <matchplus+0x1f>
  {
    text++;
    10ee:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    10f2:	8b 45 18             	mov    0x18(%ebp),%eax
    10f5:	8b 00                	mov    (%eax),%eax
    10f7:	8d 50 01             	lea    0x1(%eax),%edx
    10fa:	8b 45 18             	mov    0x18(%ebp),%eax
    10fd:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    10ff:	8b 45 14             	mov    0x14(%ebp),%eax
    1102:	0f b6 00             	movzbl (%eax),%eax
    1105:	84 c0                	test   %al,%al
    1107:	74 51                	je     115a <matchplus+0x7a>
    1109:	8b 45 14             	mov    0x14(%ebp),%eax
    110c:	0f b6 00             	movzbl (%eax),%eax
    110f:	0f be c0             	movsbl %al,%eax
    1112:	50                   	push   %eax
    1113:	ff 75 0c             	pushl  0xc(%ebp)
    1116:	ff 75 08             	pushl  0x8(%ebp)
    1119:	e8 3f fe ff ff       	call   f5d <matchone>
    111e:	83 c4 0c             	add    $0xc,%esp
    1121:	85 c0                	test   %eax,%eax
    1123:	75 c9                	jne    10ee <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1125:	eb 33                	jmp    115a <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    1127:	8b 45 14             	mov    0x14(%ebp),%eax
    112a:	8d 50 ff             	lea    -0x1(%eax),%edx
    112d:	89 55 14             	mov    %edx,0x14(%ebp)
    1130:	83 ec 04             	sub    $0x4,%esp
    1133:	ff 75 18             	pushl  0x18(%ebp)
    1136:	50                   	push   %eax
    1137:	ff 75 10             	pushl  0x10(%ebp)
    113a:	e8 c0 00 00 00       	call   11ff <matchpattern>
    113f:	83 c4 10             	add    $0x10,%esp
    1142:	85 c0                	test   %eax,%eax
    1144:	74 07                	je     114d <matchplus+0x6d>
      return 1;
    1146:	b8 01 00 00 00       	mov    $0x1,%eax
    114b:	eb 1a                	jmp    1167 <matchplus+0x87>
    (*matchlength)--;
    114d:	8b 45 18             	mov    0x18(%ebp),%eax
    1150:	8b 00                	mov    (%eax),%eax
    1152:	8d 50 ff             	lea    -0x1(%eax),%edx
    1155:	8b 45 18             	mov    0x18(%ebp),%eax
    1158:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    115a:	8b 45 14             	mov    0x14(%ebp),%eax
    115d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1160:	77 c5                	ja     1127 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    1162:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1167:	c9                   	leave  
    1168:	c3                   	ret    

00001169 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1169:	55                   	push   %ebp
    116a:	89 e5                	mov    %esp,%ebp
    116c:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    116f:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1173:	84 c0                	test   %al,%al
    1175:	75 07                	jne    117e <matchquestion+0x15>
    return 1;
    1177:	b8 01 00 00 00       	mov    $0x1,%eax
    117c:	eb 7f                	jmp    11fd <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    117e:	83 ec 04             	sub    $0x4,%esp
    1181:	ff 75 18             	pushl  0x18(%ebp)
    1184:	ff 75 14             	pushl  0x14(%ebp)
    1187:	ff 75 10             	pushl  0x10(%ebp)
    118a:	e8 70 00 00 00       	call   11ff <matchpattern>
    118f:	83 c4 10             	add    $0x10,%esp
    1192:	85 c0                	test   %eax,%eax
    1194:	74 07                	je     119d <matchquestion+0x34>
      return 1;
    1196:	b8 01 00 00 00       	mov    $0x1,%eax
    119b:	eb 60                	jmp    11fd <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    119d:	8b 45 14             	mov    0x14(%ebp),%eax
    11a0:	0f b6 00             	movzbl (%eax),%eax
    11a3:	84 c0                	test   %al,%al
    11a5:	74 51                	je     11f8 <matchquestion+0x8f>
    11a7:	8b 45 14             	mov    0x14(%ebp),%eax
    11aa:	8d 50 01             	lea    0x1(%eax),%edx
    11ad:	89 55 14             	mov    %edx,0x14(%ebp)
    11b0:	0f b6 00             	movzbl (%eax),%eax
    11b3:	0f be c0             	movsbl %al,%eax
    11b6:	83 ec 04             	sub    $0x4,%esp
    11b9:	50                   	push   %eax
    11ba:	ff 75 0c             	pushl  0xc(%ebp)
    11bd:	ff 75 08             	pushl  0x8(%ebp)
    11c0:	e8 98 fd ff ff       	call   f5d <matchone>
    11c5:	83 c4 10             	add    $0x10,%esp
    11c8:	85 c0                	test   %eax,%eax
    11ca:	74 2c                	je     11f8 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    11cc:	83 ec 04             	sub    $0x4,%esp
    11cf:	ff 75 18             	pushl  0x18(%ebp)
    11d2:	ff 75 14             	pushl  0x14(%ebp)
    11d5:	ff 75 10             	pushl  0x10(%ebp)
    11d8:	e8 22 00 00 00       	call   11ff <matchpattern>
    11dd:	83 c4 10             	add    $0x10,%esp
    11e0:	85 c0                	test   %eax,%eax
    11e2:	74 14                	je     11f8 <matchquestion+0x8f>
    {
      (*matchlength)++;
    11e4:	8b 45 18             	mov    0x18(%ebp),%eax
    11e7:	8b 00                	mov    (%eax),%eax
    11e9:	8d 50 01             	lea    0x1(%eax),%edx
    11ec:	8b 45 18             	mov    0x18(%ebp),%eax
    11ef:	89 10                	mov    %edx,(%eax)
      return 1;
    11f1:	b8 01 00 00 00       	mov    $0x1,%eax
    11f6:	eb 05                	jmp    11fd <matchquestion+0x94>
    }
  }
  return 0;
    11f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11fd:	c9                   	leave  
    11fe:	c3                   	ret    

000011ff <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    11ff:	55                   	push   %ebp
    1200:	89 e5                	mov    %esp,%ebp
    1202:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1205:	8b 45 10             	mov    0x10(%ebp),%eax
    1208:	8b 00                	mov    (%eax),%eax
    120a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	0f b6 00             	movzbl (%eax),%eax
    1213:	84 c0                	test   %al,%al
    1215:	74 0d                	je     1224 <matchpattern+0x25>
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	83 c0 08             	add    $0x8,%eax
    121d:	0f b6 00             	movzbl (%eax),%eax
    1220:	3c 04                	cmp    $0x4,%al
    1222:	75 25                	jne    1249 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1224:	8b 45 08             	mov    0x8(%ebp),%eax
    1227:	83 c0 10             	add    $0x10,%eax
    122a:	83 ec 0c             	sub    $0xc,%esp
    122d:	ff 75 10             	pushl  0x10(%ebp)
    1230:	ff 75 0c             	pushl  0xc(%ebp)
    1233:	50                   	push   %eax
    1234:	8b 45 08             	mov    0x8(%ebp),%eax
    1237:	ff 70 04             	pushl  0x4(%eax)
    123a:	ff 30                	pushl  (%eax)
    123c:	e8 28 ff ff ff       	call   1169 <matchquestion>
    1241:	83 c4 20             	add    $0x20,%esp
    1244:	e9 dd 00 00 00       	jmp    1326 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	83 c0 08             	add    $0x8,%eax
    124f:	0f b6 00             	movzbl (%eax),%eax
    1252:	3c 05                	cmp    $0x5,%al
    1254:	75 25                	jne    127b <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	83 c0 10             	add    $0x10,%eax
    125c:	83 ec 0c             	sub    $0xc,%esp
    125f:	ff 75 10             	pushl  0x10(%ebp)
    1262:	ff 75 0c             	pushl  0xc(%ebp)
    1265:	50                   	push   %eax
    1266:	8b 45 08             	mov    0x8(%ebp),%eax
    1269:	ff 70 04             	pushl  0x4(%eax)
    126c:	ff 30                	pushl  (%eax)
    126e:	e8 d4 fd ff ff       	call   1047 <matchstar>
    1273:	83 c4 20             	add    $0x20,%esp
    1276:	e9 ab 00 00 00       	jmp    1326 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    127b:	8b 45 08             	mov    0x8(%ebp),%eax
    127e:	83 c0 08             	add    $0x8,%eax
    1281:	0f b6 00             	movzbl (%eax),%eax
    1284:	3c 06                	cmp    $0x6,%al
    1286:	75 22                	jne    12aa <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	83 c0 10             	add    $0x10,%eax
    128e:	83 ec 0c             	sub    $0xc,%esp
    1291:	ff 75 10             	pushl  0x10(%ebp)
    1294:	ff 75 0c             	pushl  0xc(%ebp)
    1297:	50                   	push   %eax
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	ff 70 04             	pushl  0x4(%eax)
    129e:	ff 30                	pushl  (%eax)
    12a0:	e8 3b fe ff ff       	call   10e0 <matchplus>
    12a5:	83 c4 20             	add    $0x20,%esp
    12a8:	eb 7c                	jmp    1326 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    12aa:	8b 45 08             	mov    0x8(%ebp),%eax
    12ad:	0f b6 00             	movzbl (%eax),%eax
    12b0:	3c 03                	cmp    $0x3,%al
    12b2:	75 1d                	jne    12d1 <matchpattern+0xd2>
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	83 c0 08             	add    $0x8,%eax
    12ba:	0f b6 00             	movzbl (%eax),%eax
    12bd:	84 c0                	test   %al,%al
    12bf:	75 10                	jne    12d1 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    12c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c4:	0f b6 00             	movzbl (%eax),%eax
    12c7:	84 c0                	test   %al,%al
    12c9:	0f 94 c0             	sete   %al
    12cc:	0f b6 c0             	movzbl %al,%eax
    12cf:	eb 55                	jmp    1326 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    12d1:	8b 45 10             	mov    0x10(%ebp),%eax
    12d4:	8b 00                	mov    (%eax),%eax
    12d6:	8d 50 01             	lea    0x1(%eax),%edx
    12d9:	8b 45 10             	mov    0x10(%ebp),%eax
    12dc:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    12de:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e1:	0f b6 00             	movzbl (%eax),%eax
    12e4:	84 c0                	test   %al,%al
    12e6:	74 31                	je     1319 <matchpattern+0x11a>
    12e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12eb:	8d 50 01             	lea    0x1(%eax),%edx
    12ee:	89 55 0c             	mov    %edx,0xc(%ebp)
    12f1:	0f b6 00             	movzbl (%eax),%eax
    12f4:	0f be d0             	movsbl %al,%edx
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	8d 48 08             	lea    0x8(%eax),%ecx
    12fd:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1300:	83 ec 04             	sub    $0x4,%esp
    1303:	52                   	push   %edx
    1304:	ff 70 04             	pushl  0x4(%eax)
    1307:	ff 30                	pushl  (%eax)
    1309:	e8 4f fc ff ff       	call   f5d <matchone>
    130e:	83 c4 10             	add    $0x10,%esp
    1311:	85 c0                	test   %eax,%eax
    1313:	0f 85 f4 fe ff ff    	jne    120d <matchpattern+0xe>

  *matchlength = pre;
    1319:	8b 45 10             	mov    0x10(%ebp),%eax
    131c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    131f:	89 10                	mov    %edx,(%eax)
  return 0;
    1321:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1326:	c9                   	leave  
    1327:	c3                   	ret    
