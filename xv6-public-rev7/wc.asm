
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
       d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      10:	89 45 ec             	mov    %eax,-0x14(%ebp)
      13:	8b 45 ec             	mov    -0x14(%ebp),%eax
      16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
      19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
      22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      29:	eb 58                	jmp    83 <wc+0x83>
      c++;
      2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
      2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      32:	05 e0 1c 00 00       	add    $0x1ce0,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 e0 1c 00 00       	add    $0x1ce0,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 d8 13 00 00       	push   $0x13d8
      59:	e8 35 02 00 00       	call   293 <strchr>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	85 c0                	test   %eax,%eax
      63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
      65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
      6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      72:	75 0b                	jne    7f <wc+0x7f>
        w++;
      74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
      78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      83:	8b 45 f4             	mov    -0xc(%ebp),%eax
      86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
      89:	7c a0                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
      8b:	83 ec 04             	sub    $0x4,%esp
      8e:	68 00 02 00 00       	push   $0x200
      93:	68 e0 1c 00 00       	push   $0x1ce0
      98:	ff 75 08             	pushl  0x8(%ebp)
      9b:	e8 8c 03 00 00       	call   42c <read>
      a0:	83 c4 10             	add    $0x10,%esp
      a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
      b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
      b6:	83 ec 08             	sub    $0x8,%esp
      b9:	68 de 13 00 00       	push   $0x13de
      be:	6a 01                	push   $0x1
      c0:	e8 26 05 00 00       	call   5eb <printf>
      c5:	83 c4 10             	add    $0x10,%esp
    exit();
      c8:	e8 47 03 00 00       	call   414 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      cd:	83 ec 08             	sub    $0x8,%esp
      d0:	ff 75 0c             	pushl  0xc(%ebp)
      d3:	ff 75 e8             	pushl  -0x18(%ebp)
      d6:	ff 75 ec             	pushl  -0x14(%ebp)
      d9:	ff 75 f0             	pushl  -0x10(%ebp)
      dc:	68 ee 13 00 00       	push   $0x13ee
      e1:	6a 01                	push   $0x1
      e3:	e8 03 05 00 00       	call   5eb <printf>
      e8:	83 c4 20             	add    $0x20,%esp
}
      eb:	90                   	nop
      ec:	c9                   	leave  
      ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
      ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      f2:	83 e4 f0             	and    $0xfffffff0,%esp
      f5:	ff 71 fc             	pushl  -0x4(%ecx)
      f8:	55                   	push   %ebp
      f9:	89 e5                	mov    %esp,%ebp
      fb:	53                   	push   %ebx
      fc:	51                   	push   %ecx
      fd:	83 ec 10             	sub    $0x10,%esp
     100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
     102:	83 3b 01             	cmpl   $0x1,(%ebx)
     105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
     107:	83 ec 08             	sub    $0x8,%esp
     10a:	68 fb 13 00 00       	push   $0x13fb
     10f:	6a 00                	push   $0x0
     111:	e8 ea fe ff ff       	call   0 <wc>
     116:	83 c4 10             	add    $0x10,%esp
    exit();
     119:	e8 f6 02 00 00       	call   414 <exit>
  }

  for(i = 1; i < argc; i++){
     11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
     12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     134:	8b 43 04             	mov    0x4(%ebx),%eax
     137:	01 d0                	add    %edx,%eax
     139:	8b 00                	mov    (%eax),%eax
     13b:	83 ec 08             	sub    $0x8,%esp
     13e:	6a 00                	push   $0x0
     140:	50                   	push   %eax
     141:	e8 0e 03 00 00       	call   454 <open>
     146:	83 c4 10             	add    $0x10,%esp
     149:	89 45 f0             	mov    %eax,-0x10(%ebp)
     14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
     152:	8b 45 f4             	mov    -0xc(%ebp),%eax
     155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     15c:	8b 43 04             	mov    0x4(%ebx),%eax
     15f:	01 d0                	add    %edx,%eax
     161:	8b 00                	mov    (%eax),%eax
     163:	83 ec 04             	sub    $0x4,%esp
     166:	50                   	push   %eax
     167:	68 fc 13 00 00       	push   $0x13fc
     16c:	6a 01                	push   $0x1
     16e:	e8 78 04 00 00       	call   5eb <printf>
     173:	83 c4 10             	add    $0x10,%esp
      exit();
     176:	e8 99 02 00 00       	call   414 <exit>
    }
    wc(fd, argv[i]);
     17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     185:	8b 43 04             	mov    0x4(%ebx),%eax
     188:	01 d0                	add    %edx,%eax
     18a:	8b 00                	mov    (%eax),%eax
     18c:	83 ec 08             	sub    $0x8,%esp
     18f:	50                   	push   %eax
     190:	ff 75 f0             	pushl  -0x10(%ebp)
     193:	e8 68 fe ff ff       	call   0 <wc>
     198:	83 c4 10             	add    $0x10,%esp
    close(fd);
     19b:	83 ec 0c             	sub    $0xc,%esp
     19e:	ff 75 f0             	pushl  -0x10(%ebp)
     1a1:	e8 96 02 00 00       	call   43c <close>
     1a6:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
     1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b0:	3b 03                	cmp    (%ebx),%eax
     1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
     1b8:	e8 57 02 00 00       	call   414 <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
     1c0:	57                   	push   %edi
     1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1c5:	8b 55 10             	mov    0x10(%ebp),%edx
     1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1cb:	89 cb                	mov    %ecx,%ebx
     1cd:	89 df                	mov    %ebx,%edi
     1cf:	89 d1                	mov    %edx,%ecx
     1d1:	fc                   	cld    
     1d2:	f3 aa                	rep stos %al,%es:(%edi)
     1d4:	89 ca                	mov    %ecx,%edx
     1d6:	89 fb                	mov    %edi,%ebx
     1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1de:	90                   	nop
     1df:	5b                   	pop    %ebx
     1e0:	5f                   	pop    %edi
     1e1:	5d                   	pop    %ebp
     1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1e3:	55                   	push   %ebp
     1e4:	89 e5                	mov    %esp,%ebp
     1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1ef:	90                   	nop
     1f0:	8b 45 08             	mov    0x8(%ebp),%eax
     1f3:	8d 50 01             	lea    0x1(%eax),%edx
     1f6:	89 55 08             	mov    %edx,0x8(%ebp)
     1f9:	8b 55 0c             	mov    0xc(%ebp),%edx
     1fc:	8d 4a 01             	lea    0x1(%edx),%ecx
     1ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     202:	0f b6 12             	movzbl (%edx),%edx
     205:	88 10                	mov    %dl,(%eax)
     207:	0f b6 00             	movzbl (%eax),%eax
     20a:	84 c0                	test   %al,%al
     20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
     20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     211:	c9                   	leave  
     212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     213:	55                   	push   %ebp
     214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
     218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     220:	8b 45 08             	mov    0x8(%ebp),%eax
     223:	0f b6 00             	movzbl (%eax),%eax
     226:	84 c0                	test   %al,%al
     228:	74 10                	je     23a <strcmp+0x27>
     22a:	8b 45 08             	mov    0x8(%ebp),%eax
     22d:	0f b6 10             	movzbl (%eax),%edx
     230:	8b 45 0c             	mov    0xc(%ebp),%eax
     233:	0f b6 00             	movzbl (%eax),%eax
     236:	38 c2                	cmp    %al,%dl
     238:	74 de                	je     218 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	0f b6 00             	movzbl (%eax),%eax
     240:	0f b6 d0             	movzbl %al,%edx
     243:	8b 45 0c             	mov    0xc(%ebp),%eax
     246:	0f b6 00             	movzbl (%eax),%eax
     249:	0f b6 c0             	movzbl %al,%eax
     24c:	29 c2                	sub    %eax,%edx
     24e:	89 d0                	mov    %edx,%eax
}
     250:	5d                   	pop    %ebp
     251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(char *s)
{
     252:	55                   	push   %ebp
     253:	89 e5                	mov    %esp,%ebp
     255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     25f:	eb 04                	jmp    265 <strlen+0x13>
     261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     265:	8b 55 fc             	mov    -0x4(%ebp),%edx
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	01 d0                	add    %edx,%eax
     26d:	0f b6 00             	movzbl (%eax),%eax
     270:	84 c0                	test   %al,%al
     272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
     274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <memset>:

void*
memset(void *dst, int c, uint n)
{
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     27c:	8b 45 10             	mov    0x10(%ebp),%eax
     27f:	50                   	push   %eax
     280:	ff 75 0c             	pushl  0xc(%ebp)
     283:	ff 75 08             	pushl  0x8(%ebp)
     286:	e8 32 ff ff ff       	call   1bd <stosb>
     28b:	83 c4 0c             	add    $0xc,%esp
  return dst;
     28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     291:	c9                   	leave  
     292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
     293:	55                   	push   %ebp
     294:	89 e5                	mov    %esp,%ebp
     296:	83 ec 04             	sub    $0x4,%esp
     299:	8b 45 0c             	mov    0xc(%ebp),%eax
     29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
     2a1:	8b 45 08             	mov    0x8(%ebp),%eax
     2a4:	0f b6 00             	movzbl (%eax),%eax
     2a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	eb 13                	jmp    2c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	84 c0                	test   %al,%al
     2bd:	75 e2                	jne    2a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2c4:	c9                   	leave  
     2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
     2c6:	55                   	push   %ebp
     2c7:	89 e5                	mov    %esp,%ebp
     2c9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2d3:	eb 42                	jmp    317 <gets+0x51>
    cc = read(0, &c, 1);
     2d5:	83 ec 04             	sub    $0x4,%esp
     2d8:	6a 01                	push   $0x1
     2da:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2dd:	50                   	push   %eax
     2de:	6a 00                	push   $0x0
     2e0:	e8 47 01 00 00       	call   42c <read>
     2e5:	83 c4 10             	add    $0x10,%esp
     2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     2eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2ef:	7e 33                	jle    324 <gets+0x5e>
      break;
    buf[i++] = c;
     2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f4:	8d 50 01             	lea    0x1(%eax),%edx
     2f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     2fa:	89 c2                	mov    %eax,%edx
     2fc:	8b 45 08             	mov    0x8(%ebp),%eax
     2ff:	01 c2                	add    %eax,%edx
     301:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     305:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     30b:	3c 0a                	cmp    $0xa,%al
     30d:	74 16                	je     325 <gets+0x5f>
     30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     313:	3c 0d                	cmp    $0xd,%al
     315:	74 0e                	je     325 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     317:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31a:	83 c0 01             	add    $0x1,%eax
     31d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     320:	7c b3                	jl     2d5 <gets+0xf>
     322:	eb 01                	jmp    325 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     324:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     325:	8b 55 f4             	mov    -0xc(%ebp),%edx
     328:	8b 45 08             	mov    0x8(%ebp),%eax
     32b:	01 d0                	add    %edx,%eax
     32d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     330:	8b 45 08             	mov    0x8(%ebp),%eax
}
     333:	c9                   	leave  
     334:	c3                   	ret    

00000335 <stat>:

int
stat(char *n, struct stat *st)
{
     335:	55                   	push   %ebp
     336:	89 e5                	mov    %esp,%ebp
     338:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     33b:	83 ec 08             	sub    $0x8,%esp
     33e:	6a 00                	push   $0x0
     340:	ff 75 08             	pushl  0x8(%ebp)
     343:	e8 0c 01 00 00       	call   454 <open>
     348:	83 c4 10             	add    $0x10,%esp
     34b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     34e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     352:	79 07                	jns    35b <stat+0x26>
    return -1;
     354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     359:	eb 25                	jmp    380 <stat+0x4b>
  r = fstat(fd, st);
     35b:	83 ec 08             	sub    $0x8,%esp
     35e:	ff 75 0c             	pushl  0xc(%ebp)
     361:	ff 75 f4             	pushl  -0xc(%ebp)
     364:	e8 03 01 00 00       	call   46c <fstat>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     36f:	83 ec 0c             	sub    $0xc,%esp
     372:	ff 75 f4             	pushl  -0xc(%ebp)
     375:	e8 c2 00 00 00       	call   43c <close>
     37a:	83 c4 10             	add    $0x10,%esp
  return r;
     37d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     380:	c9                   	leave  
     381:	c3                   	ret    

00000382 <atoi>:

int
atoi(const char *s)
{
     382:	55                   	push   %ebp
     383:	89 e5                	mov    %esp,%ebp
     385:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     38f:	eb 25                	jmp    3b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
     391:	8b 55 fc             	mov    -0x4(%ebp),%edx
     394:	89 d0                	mov    %edx,%eax
     396:	c1 e0 02             	shl    $0x2,%eax
     399:	01 d0                	add    %edx,%eax
     39b:	01 c0                	add    %eax,%eax
     39d:	89 c1                	mov    %eax,%ecx
     39f:	8b 45 08             	mov    0x8(%ebp),%eax
     3a2:	8d 50 01             	lea    0x1(%eax),%edx
     3a5:	89 55 08             	mov    %edx,0x8(%ebp)
     3a8:	0f b6 00             	movzbl (%eax),%eax
     3ab:	0f be c0             	movsbl %al,%eax
     3ae:	01 c8                	add    %ecx,%eax
     3b0:	83 e8 30             	sub    $0x30,%eax
     3b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     3b6:	8b 45 08             	mov    0x8(%ebp),%eax
     3b9:	0f b6 00             	movzbl (%eax),%eax
     3bc:	3c 2f                	cmp    $0x2f,%al
     3be:	7e 0a                	jle    3ca <atoi+0x48>
     3c0:	8b 45 08             	mov    0x8(%ebp),%eax
     3c3:	0f b6 00             	movzbl (%eax),%eax
     3c6:	3c 39                	cmp    $0x39,%al
     3c8:	7e c7                	jle    391 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     3ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3cd:	c9                   	leave  
     3ce:	c3                   	ret    

000003cf <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3cf:	55                   	push   %ebp
     3d0:	89 e5                	mov    %esp,%ebp
     3d2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     3d5:	8b 45 08             	mov    0x8(%ebp),%eax
     3d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     3db:	8b 45 0c             	mov    0xc(%ebp),%eax
     3de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     3e1:	eb 17                	jmp    3fa <memmove+0x2b>
    *dst++ = *src++;
     3e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     3e6:	8d 50 01             	lea    0x1(%eax),%edx
     3e9:	89 55 fc             	mov    %edx,-0x4(%ebp)
     3ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
     3ef:	8d 4a 01             	lea    0x1(%edx),%ecx
     3f2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     3f5:	0f b6 12             	movzbl (%edx),%edx
     3f8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     3fa:	8b 45 10             	mov    0x10(%ebp),%eax
     3fd:	8d 50 ff             	lea    -0x1(%eax),%edx
     400:	89 55 10             	mov    %edx,0x10(%ebp)
     403:	85 c0                	test   %eax,%eax
     405:	7f dc                	jg     3e3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     407:	8b 45 08             	mov    0x8(%ebp),%eax
}
     40a:	c9                   	leave  
     40b:	c3                   	ret    

0000040c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     40c:	b8 01 00 00 00       	mov    $0x1,%eax
     411:	cd 40                	int    $0x40
     413:	c3                   	ret    

00000414 <exit>:
SYSCALL(exit)
     414:	b8 02 00 00 00       	mov    $0x2,%eax
     419:	cd 40                	int    $0x40
     41b:	c3                   	ret    

0000041c <wait>:
SYSCALL(wait)
     41c:	b8 03 00 00 00       	mov    $0x3,%eax
     421:	cd 40                	int    $0x40
     423:	c3                   	ret    

00000424 <pipe>:
SYSCALL(pipe)
     424:	b8 04 00 00 00       	mov    $0x4,%eax
     429:	cd 40                	int    $0x40
     42b:	c3                   	ret    

0000042c <read>:
SYSCALL(read)
     42c:	b8 05 00 00 00       	mov    $0x5,%eax
     431:	cd 40                	int    $0x40
     433:	c3                   	ret    

00000434 <write>:
SYSCALL(write)
     434:	b8 10 00 00 00       	mov    $0x10,%eax
     439:	cd 40                	int    $0x40
     43b:	c3                   	ret    

0000043c <close>:
SYSCALL(close)
     43c:	b8 15 00 00 00       	mov    $0x15,%eax
     441:	cd 40                	int    $0x40
     443:	c3                   	ret    

00000444 <kill>:
SYSCALL(kill)
     444:	b8 06 00 00 00       	mov    $0x6,%eax
     449:	cd 40                	int    $0x40
     44b:	c3                   	ret    

0000044c <exec>:
SYSCALL(exec)
     44c:	b8 07 00 00 00       	mov    $0x7,%eax
     451:	cd 40                	int    $0x40
     453:	c3                   	ret    

00000454 <open>:
SYSCALL(open)
     454:	b8 0f 00 00 00       	mov    $0xf,%eax
     459:	cd 40                	int    $0x40
     45b:	c3                   	ret    

0000045c <mknod>:
SYSCALL(mknod)
     45c:	b8 11 00 00 00       	mov    $0x11,%eax
     461:	cd 40                	int    $0x40
     463:	c3                   	ret    

00000464 <unlink>:
SYSCALL(unlink)
     464:	b8 12 00 00 00       	mov    $0x12,%eax
     469:	cd 40                	int    $0x40
     46b:	c3                   	ret    

0000046c <fstat>:
SYSCALL(fstat)
     46c:	b8 08 00 00 00       	mov    $0x8,%eax
     471:	cd 40                	int    $0x40
     473:	c3                   	ret    

00000474 <link>:
SYSCALL(link)
     474:	b8 13 00 00 00       	mov    $0x13,%eax
     479:	cd 40                	int    $0x40
     47b:	c3                   	ret    

0000047c <mkdir>:
SYSCALL(mkdir)
     47c:	b8 14 00 00 00       	mov    $0x14,%eax
     481:	cd 40                	int    $0x40
     483:	c3                   	ret    

00000484 <chdir>:
SYSCALL(chdir)
     484:	b8 09 00 00 00       	mov    $0x9,%eax
     489:	cd 40                	int    $0x40
     48b:	c3                   	ret    

0000048c <dup>:
SYSCALL(dup)
     48c:	b8 0a 00 00 00       	mov    $0xa,%eax
     491:	cd 40                	int    $0x40
     493:	c3                   	ret    

00000494 <getpid>:
SYSCALL(getpid)
     494:	b8 0b 00 00 00       	mov    $0xb,%eax
     499:	cd 40                	int    $0x40
     49b:	c3                   	ret    

0000049c <sbrk>:
SYSCALL(sbrk)
     49c:	b8 0c 00 00 00       	mov    $0xc,%eax
     4a1:	cd 40                	int    $0x40
     4a3:	c3                   	ret    

000004a4 <sleep>:
SYSCALL(sleep)
     4a4:	b8 0d 00 00 00       	mov    $0xd,%eax
     4a9:	cd 40                	int    $0x40
     4ab:	c3                   	ret    

000004ac <uptime>:
SYSCALL(uptime)
     4ac:	b8 0e 00 00 00       	mov    $0xe,%eax
     4b1:	cd 40                	int    $0x40
     4b3:	c3                   	ret    

000004b4 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     4b4:	b8 16 00 00 00       	mov    $0x16,%eax
     4b9:	cd 40                	int    $0x40
     4bb:	c3                   	ret    

000004bc <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     4bc:	b8 17 00 00 00       	mov    $0x17,%eax
     4c1:	cd 40                	int    $0x40
     4c3:	c3                   	ret    

000004c4 <clearScreen>:
SYSCALL(clearScreen)
     4c4:	b8 18 00 00 00       	mov    $0x18,%eax
     4c9:	cd 40                	int    $0x40
     4cb:	c3                   	ret    

000004cc <writeAt>:
SYSCALL(writeAt)
     4cc:	b8 19 00 00 00       	mov    $0x19,%eax
     4d1:	cd 40                	int    $0x40
     4d3:	c3                   	ret    

000004d4 <setBufferFlag>:
SYSCALL(setBufferFlag)
     4d4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4d9:	cd 40                	int    $0x40
     4db:	c3                   	ret    

000004dc <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     4dc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     4e1:	cd 40                	int    $0x40
     4e3:	c3                   	ret    

000004e4 <getCursorPos>:
SYSCALL(getCursorPos)
     4e4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     4e9:	cd 40                	int    $0x40
     4eb:	c3                   	ret    

000004ec <saveScreen>:
SYSCALL(saveScreen)
     4ec:	b8 1d 00 00 00       	mov    $0x1d,%eax
     4f1:	cd 40                	int    $0x40
     4f3:	c3                   	ret    

000004f4 <recorverScreen>:
SYSCALL(recorverScreen)
     4f4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     4f9:	cd 40                	int    $0x40
     4fb:	c3                   	ret    

000004fc <ToScreen>:
SYSCALL(ToScreen)
     4fc:	b8 1f 00 00 00       	mov    $0x1f,%eax
     501:	cd 40                	int    $0x40
     503:	c3                   	ret    

00000504 <getColor>:
SYSCALL(getColor)
     504:	b8 20 00 00 00       	mov    $0x20,%eax
     509:	cd 40                	int    $0x40
     50b:	c3                   	ret    

0000050c <showC>:
SYSCALL(showC)
     50c:	b8 21 00 00 00       	mov    $0x21,%eax
     511:	cd 40                	int    $0x40
     513:	c3                   	ret    

00000514 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     514:	55                   	push   %ebp
     515:	89 e5                	mov    %esp,%ebp
     517:	83 ec 18             	sub    $0x18,%esp
     51a:	8b 45 0c             	mov    0xc(%ebp),%eax
     51d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     520:	83 ec 04             	sub    $0x4,%esp
     523:	6a 01                	push   $0x1
     525:	8d 45 f4             	lea    -0xc(%ebp),%eax
     528:	50                   	push   %eax
     529:	ff 75 08             	pushl  0x8(%ebp)
     52c:	e8 03 ff ff ff       	call   434 <write>
     531:	83 c4 10             	add    $0x10,%esp
}
     534:	90                   	nop
     535:	c9                   	leave  
     536:	c3                   	ret    

00000537 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     537:	55                   	push   %ebp
     538:	89 e5                	mov    %esp,%ebp
     53a:	53                   	push   %ebx
     53b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     53e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     545:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     549:	74 17                	je     562 <printint+0x2b>
     54b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     54f:	79 11                	jns    562 <printint+0x2b>
    neg = 1;
     551:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     558:	8b 45 0c             	mov    0xc(%ebp),%eax
     55b:	f7 d8                	neg    %eax
     55d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     560:	eb 06                	jmp    568 <printint+0x31>
  } else {
    x = xx;
     562:	8b 45 0c             	mov    0xc(%ebp),%eax
     565:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     568:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     56f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     572:	8d 41 01             	lea    0x1(%ecx),%eax
     575:	89 45 f4             	mov    %eax,-0xc(%ebp)
     578:	8b 5d 10             	mov    0x10(%ebp),%ebx
     57b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     57e:	ba 00 00 00 00       	mov    $0x0,%edx
     583:	f7 f3                	div    %ebx
     585:	89 d0                	mov    %edx,%eax
     587:	0f b6 80 50 1b 00 00 	movzbl 0x1b50(%eax),%eax
     58e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     592:	8b 5d 10             	mov    0x10(%ebp),%ebx
     595:	8b 45 ec             	mov    -0x14(%ebp),%eax
     598:	ba 00 00 00 00       	mov    $0x0,%edx
     59d:	f7 f3                	div    %ebx
     59f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5a6:	75 c7                	jne    56f <printint+0x38>
  if(neg)
     5a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     5ac:	74 2d                	je     5db <printint+0xa4>
    buf[i++] = '-';
     5ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5b1:	8d 50 01             	lea    0x1(%eax),%edx
     5b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     5b7:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     5bc:	eb 1d                	jmp    5db <printint+0xa4>
    putc(fd, buf[i]);
     5be:	8d 55 dc             	lea    -0x24(%ebp),%edx
     5c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5c4:	01 d0                	add    %edx,%eax
     5c6:	0f b6 00             	movzbl (%eax),%eax
     5c9:	0f be c0             	movsbl %al,%eax
     5cc:	83 ec 08             	sub    $0x8,%esp
     5cf:	50                   	push   %eax
     5d0:	ff 75 08             	pushl  0x8(%ebp)
     5d3:	e8 3c ff ff ff       	call   514 <putc>
     5d8:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5db:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5e3:	79 d9                	jns    5be <printint+0x87>
    putc(fd, buf[i]);
}
     5e5:	90                   	nop
     5e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5e9:	c9                   	leave  
     5ea:	c3                   	ret    

000005eb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5eb:	55                   	push   %ebp
     5ec:	89 e5                	mov    %esp,%ebp
     5ee:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5f8:	8d 45 0c             	lea    0xc(%ebp),%eax
     5fb:	83 c0 04             	add    $0x4,%eax
     5fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     601:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     608:	e9 59 01 00 00       	jmp    766 <printf+0x17b>
    c = fmt[i] & 0xff;
     60d:	8b 55 0c             	mov    0xc(%ebp),%edx
     610:	8b 45 f0             	mov    -0x10(%ebp),%eax
     613:	01 d0                	add    %edx,%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	25 ff 00 00 00       	and    $0xff,%eax
     620:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     623:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     627:	75 2c                	jne    655 <printf+0x6a>
      if(c == '%'){
     629:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     62d:	75 0c                	jne    63b <printf+0x50>
        state = '%';
     62f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     636:	e9 27 01 00 00       	jmp    762 <printf+0x177>
      } else {
        putc(fd, c);
     63b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     63e:	0f be c0             	movsbl %al,%eax
     641:	83 ec 08             	sub    $0x8,%esp
     644:	50                   	push   %eax
     645:	ff 75 08             	pushl  0x8(%ebp)
     648:	e8 c7 fe ff ff       	call   514 <putc>
     64d:	83 c4 10             	add    $0x10,%esp
     650:	e9 0d 01 00 00       	jmp    762 <printf+0x177>
      }
    } else if(state == '%'){
     655:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     659:	0f 85 03 01 00 00    	jne    762 <printf+0x177>
      if(c == 'd'){
     65f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     663:	75 1e                	jne    683 <printf+0x98>
        printint(fd, *ap, 10, 1);
     665:	8b 45 e8             	mov    -0x18(%ebp),%eax
     668:	8b 00                	mov    (%eax),%eax
     66a:	6a 01                	push   $0x1
     66c:	6a 0a                	push   $0xa
     66e:	50                   	push   %eax
     66f:	ff 75 08             	pushl  0x8(%ebp)
     672:	e8 c0 fe ff ff       	call   537 <printint>
     677:	83 c4 10             	add    $0x10,%esp
        ap++;
     67a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     67e:	e9 d8 00 00 00       	jmp    75b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     683:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     687:	74 06                	je     68f <printf+0xa4>
     689:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     68d:	75 1e                	jne    6ad <printf+0xc2>
        printint(fd, *ap, 16, 0);
     68f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     692:	8b 00                	mov    (%eax),%eax
     694:	6a 00                	push   $0x0
     696:	6a 10                	push   $0x10
     698:	50                   	push   %eax
     699:	ff 75 08             	pushl  0x8(%ebp)
     69c:	e8 96 fe ff ff       	call   537 <printint>
     6a1:	83 c4 10             	add    $0x10,%esp
        ap++;
     6a4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6a8:	e9 ae 00 00 00       	jmp    75b <printf+0x170>
      } else if(c == 's'){
     6ad:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     6b1:	75 43                	jne    6f6 <printf+0x10b>
        s = (char*)*ap;
     6b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6b6:	8b 00                	mov    (%eax),%eax
     6b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     6bb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     6bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6c3:	75 25                	jne    6ea <printf+0xff>
          s = "(null)";
     6c5:	c7 45 f4 10 14 00 00 	movl   $0x1410,-0xc(%ebp)
        while(*s != 0){
     6cc:	eb 1c                	jmp    6ea <printf+0xff>
          putc(fd, *s);
     6ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d1:	0f b6 00             	movzbl (%eax),%eax
     6d4:	0f be c0             	movsbl %al,%eax
     6d7:	83 ec 08             	sub    $0x8,%esp
     6da:	50                   	push   %eax
     6db:	ff 75 08             	pushl  0x8(%ebp)
     6de:	e8 31 fe ff ff       	call   514 <putc>
     6e3:	83 c4 10             	add    $0x10,%esp
          s++;
     6e6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ed:	0f b6 00             	movzbl (%eax),%eax
     6f0:	84 c0                	test   %al,%al
     6f2:	75 da                	jne    6ce <printf+0xe3>
     6f4:	eb 65                	jmp    75b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6f6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6fa:	75 1d                	jne    719 <printf+0x12e>
        putc(fd, *ap);
     6fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6ff:	8b 00                	mov    (%eax),%eax
     701:	0f be c0             	movsbl %al,%eax
     704:	83 ec 08             	sub    $0x8,%esp
     707:	50                   	push   %eax
     708:	ff 75 08             	pushl  0x8(%ebp)
     70b:	e8 04 fe ff ff       	call   514 <putc>
     710:	83 c4 10             	add    $0x10,%esp
        ap++;
     713:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     717:	eb 42                	jmp    75b <printf+0x170>
      } else if(c == '%'){
     719:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     71d:	75 17                	jne    736 <printf+0x14b>
        putc(fd, c);
     71f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     722:	0f be c0             	movsbl %al,%eax
     725:	83 ec 08             	sub    $0x8,%esp
     728:	50                   	push   %eax
     729:	ff 75 08             	pushl  0x8(%ebp)
     72c:	e8 e3 fd ff ff       	call   514 <putc>
     731:	83 c4 10             	add    $0x10,%esp
     734:	eb 25                	jmp    75b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     736:	83 ec 08             	sub    $0x8,%esp
     739:	6a 25                	push   $0x25
     73b:	ff 75 08             	pushl  0x8(%ebp)
     73e:	e8 d1 fd ff ff       	call   514 <putc>
     743:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     749:	0f be c0             	movsbl %al,%eax
     74c:	83 ec 08             	sub    $0x8,%esp
     74f:	50                   	push   %eax
     750:	ff 75 08             	pushl  0x8(%ebp)
     753:	e8 bc fd ff ff       	call   514 <putc>
     758:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     75b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     762:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     766:	8b 55 0c             	mov    0xc(%ebp),%edx
     769:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76c:	01 d0                	add    %edx,%eax
     76e:	0f b6 00             	movzbl (%eax),%eax
     771:	84 c0                	test   %al,%al
     773:	0f 85 94 fe ff ff    	jne    60d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     779:	90                   	nop
     77a:	c9                   	leave  
     77b:	c3                   	ret    

0000077c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     77c:	55                   	push   %ebp
     77d:	89 e5                	mov    %esp,%ebp
     77f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     782:	8b 45 08             	mov    0x8(%ebp),%eax
     785:	83 e8 08             	sub    $0x8,%eax
     788:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     78b:	a1 88 1b 00 00       	mov    0x1b88,%eax
     790:	89 45 fc             	mov    %eax,-0x4(%ebp)
     793:	eb 24                	jmp    7b9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     795:	8b 45 fc             	mov    -0x4(%ebp),%eax
     798:	8b 00                	mov    (%eax),%eax
     79a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     79d:	77 12                	ja     7b1 <free+0x35>
     79f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7a5:	77 24                	ja     7cb <free+0x4f>
     7a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7aa:	8b 00                	mov    (%eax),%eax
     7ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7af:	77 1a                	ja     7cb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b4:	8b 00                	mov    (%eax),%eax
     7b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7bf:	76 d4                	jbe    795 <free+0x19>
     7c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c4:	8b 00                	mov    (%eax),%eax
     7c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7c9:	76 ca                	jbe    795 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     7cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ce:	8b 40 04             	mov    0x4(%eax),%eax
     7d1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7db:	01 c2                	add    %eax,%edx
     7dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e0:	8b 00                	mov    (%eax),%eax
     7e2:	39 c2                	cmp    %eax,%edx
     7e4:	75 24                	jne    80a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7e9:	8b 50 04             	mov    0x4(%eax),%edx
     7ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ef:	8b 00                	mov    (%eax),%eax
     7f1:	8b 40 04             	mov    0x4(%eax),%eax
     7f4:	01 c2                	add    %eax,%edx
     7f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7f9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ff:	8b 00                	mov    (%eax),%eax
     801:	8b 10                	mov    (%eax),%edx
     803:	8b 45 f8             	mov    -0x8(%ebp),%eax
     806:	89 10                	mov    %edx,(%eax)
     808:	eb 0a                	jmp    814 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     80a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80d:	8b 10                	mov    (%eax),%edx
     80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     812:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     814:	8b 45 fc             	mov    -0x4(%ebp),%eax
     817:	8b 40 04             	mov    0x4(%eax),%eax
     81a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     821:	8b 45 fc             	mov    -0x4(%ebp),%eax
     824:	01 d0                	add    %edx,%eax
     826:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     829:	75 20                	jne    84b <free+0xcf>
    p->s.size += bp->s.size;
     82b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     82e:	8b 50 04             	mov    0x4(%eax),%edx
     831:	8b 45 f8             	mov    -0x8(%ebp),%eax
     834:	8b 40 04             	mov    0x4(%eax),%eax
     837:	01 c2                	add    %eax,%edx
     839:	8b 45 fc             	mov    -0x4(%ebp),%eax
     83c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     83f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     842:	8b 10                	mov    (%eax),%edx
     844:	8b 45 fc             	mov    -0x4(%ebp),%eax
     847:	89 10                	mov    %edx,(%eax)
     849:	eb 08                	jmp    853 <free+0xd7>
  } else
    p->s.ptr = bp;
     84b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     84e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     851:	89 10                	mov    %edx,(%eax)
  freep = p;
     853:	8b 45 fc             	mov    -0x4(%ebp),%eax
     856:	a3 88 1b 00 00       	mov    %eax,0x1b88
}
     85b:	90                   	nop
     85c:	c9                   	leave  
     85d:	c3                   	ret    

0000085e <morecore>:

static Header*
morecore(uint nu)
{
     85e:	55                   	push   %ebp
     85f:	89 e5                	mov    %esp,%ebp
     861:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     864:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     86b:	77 07                	ja     874 <morecore+0x16>
    nu = 4096;
     86d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     874:	8b 45 08             	mov    0x8(%ebp),%eax
     877:	c1 e0 03             	shl    $0x3,%eax
     87a:	83 ec 0c             	sub    $0xc,%esp
     87d:	50                   	push   %eax
     87e:	e8 19 fc ff ff       	call   49c <sbrk>
     883:	83 c4 10             	add    $0x10,%esp
     886:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     889:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     88d:	75 07                	jne    896 <morecore+0x38>
    return 0;
     88f:	b8 00 00 00 00       	mov    $0x0,%eax
     894:	eb 26                	jmp    8bc <morecore+0x5e>
  hp = (Header*)p;
     896:	8b 45 f4             	mov    -0xc(%ebp),%eax
     899:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89f:	8b 55 08             	mov    0x8(%ebp),%edx
     8a2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     8a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a8:	83 c0 08             	add    $0x8,%eax
     8ab:	83 ec 0c             	sub    $0xc,%esp
     8ae:	50                   	push   %eax
     8af:	e8 c8 fe ff ff       	call   77c <free>
     8b4:	83 c4 10             	add    $0x10,%esp
  return freep;
     8b7:	a1 88 1b 00 00       	mov    0x1b88,%eax
}
     8bc:	c9                   	leave  
     8bd:	c3                   	ret    

000008be <malloc>:

void*
malloc(uint nbytes)
{
     8be:	55                   	push   %ebp
     8bf:	89 e5                	mov    %esp,%ebp
     8c1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8c4:	8b 45 08             	mov    0x8(%ebp),%eax
     8c7:	83 c0 07             	add    $0x7,%eax
     8ca:	c1 e8 03             	shr    $0x3,%eax
     8cd:	83 c0 01             	add    $0x1,%eax
     8d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8d3:	a1 88 1b 00 00       	mov    0x1b88,%eax
     8d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8df:	75 23                	jne    904 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8e1:	c7 45 f0 80 1b 00 00 	movl   $0x1b80,-0x10(%ebp)
     8e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8eb:	a3 88 1b 00 00       	mov    %eax,0x1b88
     8f0:	a1 88 1b 00 00       	mov    0x1b88,%eax
     8f5:	a3 80 1b 00 00       	mov    %eax,0x1b80
    base.s.size = 0;
     8fa:	c7 05 84 1b 00 00 00 	movl   $0x0,0x1b84
     901:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     904:	8b 45 f0             	mov    -0x10(%ebp),%eax
     907:	8b 00                	mov    (%eax),%eax
     909:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     90c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90f:	8b 40 04             	mov    0x4(%eax),%eax
     912:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     915:	72 4d                	jb     964 <malloc+0xa6>
      if(p->s.size == nunits)
     917:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91a:	8b 40 04             	mov    0x4(%eax),%eax
     91d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     920:	75 0c                	jne    92e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     922:	8b 45 f4             	mov    -0xc(%ebp),%eax
     925:	8b 10                	mov    (%eax),%edx
     927:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92a:	89 10                	mov    %edx,(%eax)
     92c:	eb 26                	jmp    954 <malloc+0x96>
      else {
        p->s.size -= nunits;
     92e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     931:	8b 40 04             	mov    0x4(%eax),%eax
     934:	2b 45 ec             	sub    -0x14(%ebp),%eax
     937:	89 c2                	mov    %eax,%edx
     939:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     93f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     942:	8b 40 04             	mov    0x4(%eax),%eax
     945:	c1 e0 03             	shl    $0x3,%eax
     948:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     951:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     954:	8b 45 f0             	mov    -0x10(%ebp),%eax
     957:	a3 88 1b 00 00       	mov    %eax,0x1b88
      return (void*)(p + 1);
     95c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95f:	83 c0 08             	add    $0x8,%eax
     962:	eb 3b                	jmp    99f <malloc+0xe1>
    }
    if(p == freep)
     964:	a1 88 1b 00 00       	mov    0x1b88,%eax
     969:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     96c:	75 1e                	jne    98c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     96e:	83 ec 0c             	sub    $0xc,%esp
     971:	ff 75 ec             	pushl  -0x14(%ebp)
     974:	e8 e5 fe ff ff       	call   85e <morecore>
     979:	83 c4 10             	add    $0x10,%esp
     97c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     97f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     983:	75 07                	jne    98c <malloc+0xce>
        return 0;
     985:	b8 00 00 00 00       	mov    $0x0,%eax
     98a:	eb 13                	jmp    99f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     98c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     992:	8b 45 f4             	mov    -0xc(%ebp),%eax
     995:	8b 00                	mov    (%eax),%eax
     997:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     99a:	e9 6d ff ff ff       	jmp    90c <malloc+0x4e>
}
     99f:	c9                   	leave  
     9a0:	c3                   	ret    

000009a1 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     9a1:	55                   	push   %ebp
     9a2:	89 e5                	mov    %esp,%ebp
     9a4:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     9a7:	83 ec 0c             	sub    $0xc,%esp
     9aa:	ff 75 08             	pushl  0x8(%ebp)
     9ad:	e8 b0 00 00 00       	call   a62 <re_compile>
     9b2:	83 c4 10             	add    $0x10,%esp
     9b5:	83 ec 04             	sub    $0x4,%esp
     9b8:	ff 75 10             	pushl  0x10(%ebp)
     9bb:	ff 75 0c             	pushl  0xc(%ebp)
     9be:	50                   	push   %eax
     9bf:	e8 05 00 00 00       	call   9c9 <re_matchp>
     9c4:	83 c4 10             	add    $0x10,%esp
}
     9c7:	c9                   	leave  
     9c8:	c3                   	ret    

000009c9 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     9c9:	55                   	push   %ebp
     9ca:	89 e5                	mov    %esp,%ebp
     9cc:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     9cf:	8b 45 10             	mov    0x10(%ebp),%eax
     9d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     9d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     9dc:	74 7d                	je     a5b <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     9de:	8b 45 08             	mov    0x8(%ebp),%eax
     9e1:	0f b6 00             	movzbl (%eax),%eax
     9e4:	3c 02                	cmp    $0x2,%al
     9e6:	75 2a                	jne    a12 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     9e8:	8b 45 08             	mov    0x8(%ebp),%eax
     9eb:	83 c0 08             	add    $0x8,%eax
     9ee:	83 ec 04             	sub    $0x4,%esp
     9f1:	ff 75 10             	pushl  0x10(%ebp)
     9f4:	ff 75 0c             	pushl  0xc(%ebp)
     9f7:	50                   	push   %eax
     9f8:	e8 b0 08 00 00       	call   12ad <matchpattern>
     9fd:	83 c4 10             	add    $0x10,%esp
     a00:	85 c0                	test   %eax,%eax
     a02:	74 07                	je     a0b <re_matchp+0x42>
     a04:	b8 00 00 00 00       	mov    $0x0,%eax
     a09:	eb 55                	jmp    a60 <re_matchp+0x97>
     a0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a10:	eb 4e                	jmp    a60 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     a12:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     a19:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     a1d:	83 ec 04             	sub    $0x4,%esp
     a20:	ff 75 10             	pushl  0x10(%ebp)
     a23:	ff 75 0c             	pushl  0xc(%ebp)
     a26:	ff 75 08             	pushl  0x8(%ebp)
     a29:	e8 7f 08 00 00       	call   12ad <matchpattern>
     a2e:	83 c4 10             	add    $0x10,%esp
     a31:	85 c0                	test   %eax,%eax
     a33:	74 16                	je     a4b <re_matchp+0x82>
        {
          if (text[0] == '\0')
     a35:	8b 45 0c             	mov    0xc(%ebp),%eax
     a38:	0f b6 00             	movzbl (%eax),%eax
     a3b:	84 c0                	test   %al,%al
     a3d:	75 07                	jne    a46 <re_matchp+0x7d>
            return -1;
     a3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a44:	eb 1a                	jmp    a60 <re_matchp+0x97>
        
          return idx;
     a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a49:	eb 15                	jmp    a60 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
     a4e:	8d 50 01             	lea    0x1(%eax),%edx
     a51:	89 55 0c             	mov    %edx,0xc(%ebp)
     a54:	0f b6 00             	movzbl (%eax),%eax
     a57:	84 c0                	test   %al,%al
     a59:	75 be                	jne    a19 <re_matchp+0x50>
    }
  }
  return -1;
     a5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     a60:	c9                   	leave  
     a61:	c3                   	ret    

00000a62 <re_compile>:

re_t re_compile(const char* pattern)
{
     a62:	55                   	push   %ebp
     a63:	89 e5                	mov    %esp,%ebp
     a65:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     a68:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     a6f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     a76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     a7d:	e9 55 02 00 00       	jmp    cd7 <re_compile+0x275>
  {
    c = pattern[i];
     a82:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a85:	8b 45 08             	mov    0x8(%ebp),%eax
     a88:	01 d0                	add    %edx,%eax
     a8a:	0f b6 00             	movzbl (%eax),%eax
     a8d:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     a90:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     a94:	83 e8 24             	sub    $0x24,%eax
     a97:	83 f8 3a             	cmp    $0x3a,%eax
     a9a:	0f 87 13 02 00 00    	ja     cb3 <re_compile+0x251>
     aa0:	8b 04 85 18 14 00 00 	mov    0x1418(,%eax,4),%eax
     aa7:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aac:	c6 04 c5 a0 1b 00 00 	movb   $0x2,0x1ba0(,%eax,8)
     ab3:	02 
     ab4:	e9 16 02 00 00       	jmp    ccf <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abc:	c6 04 c5 a0 1b 00 00 	movb   $0x3,0x1ba0(,%eax,8)
     ac3:	03 
     ac4:	e9 06 02 00 00       	jmp    ccf <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acc:	c6 04 c5 a0 1b 00 00 	movb   $0x1,0x1ba0(,%eax,8)
     ad3:	01 
     ad4:	e9 f6 01 00 00       	jmp    ccf <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adc:	c6 04 c5 a0 1b 00 00 	movb   $0x5,0x1ba0(,%eax,8)
     ae3:	05 
     ae4:	e9 e6 01 00 00       	jmp    ccf <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aec:	c6 04 c5 a0 1b 00 00 	movb   $0x6,0x1ba0(,%eax,8)
     af3:	06 
     af4:	e9 d6 01 00 00       	jmp    ccf <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afc:	c6 04 c5 a0 1b 00 00 	movb   $0x4,0x1ba0(,%eax,8)
     b03:	04 
     b04:	e9 c6 01 00 00       	jmp    ccf <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     b09:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b0c:	8d 50 01             	lea    0x1(%eax),%edx
     b0f:	8b 45 08             	mov    0x8(%ebp),%eax
     b12:	01 d0                	add    %edx,%eax
     b14:	0f b6 00             	movzbl (%eax),%eax
     b17:	84 c0                	test   %al,%al
     b19:	0f 84 af 01 00 00    	je     cce <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     b1f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     b23:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b26:	8b 45 08             	mov    0x8(%ebp),%eax
     b29:	01 d0                	add    %edx,%eax
     b2b:	0f b6 00             	movzbl (%eax),%eax
     b2e:	0f be c0             	movsbl %al,%eax
     b31:	83 e8 44             	sub    $0x44,%eax
     b34:	83 f8 33             	cmp    $0x33,%eax
     b37:	77 57                	ja     b90 <re_compile+0x12e>
     b39:	8b 04 85 04 15 00 00 	mov    0x1504(,%eax,4),%eax
     b40:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b45:	c6 04 c5 a0 1b 00 00 	movb   $0xa,0x1ba0(,%eax,8)
     b4c:	0a 
     b4d:	eb 64                	jmp    bb3 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b52:	c6 04 c5 a0 1b 00 00 	movb   $0xb,0x1ba0(,%eax,8)
     b59:	0b 
     b5a:	eb 57                	jmp    bb3 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5f:	c6 04 c5 a0 1b 00 00 	movb   $0xc,0x1ba0(,%eax,8)
     b66:	0c 
     b67:	eb 4a                	jmp    bb3 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6c:	c6 04 c5 a0 1b 00 00 	movb   $0xd,0x1ba0(,%eax,8)
     b73:	0d 
     b74:	eb 3d                	jmp    bb3 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b79:	c6 04 c5 a0 1b 00 00 	movb   $0xe,0x1ba0(,%eax,8)
     b80:	0e 
     b81:	eb 30                	jmp    bb3 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b86:	c6 04 c5 a0 1b 00 00 	movb   $0xf,0x1ba0(,%eax,8)
     b8d:	0f 
     b8e:	eb 23                	jmp    bb3 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b93:	c6 04 c5 a0 1b 00 00 	movb   $0x7,0x1ba0(,%eax,8)
     b9a:	07 
              re_compiled[j].ch = pattern[i];
     b9b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ba1:	01 d0                	add    %edx,%eax
     ba3:	0f b6 00             	movzbl (%eax),%eax
     ba6:	89 c2                	mov    %eax,%edx
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	88 14 c5 a4 1b 00 00 	mov    %dl,0x1ba4(,%eax,8)
            } break;
     bb2:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     bb3:	e9 16 01 00 00       	jmp    cce <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     bb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bbb:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     bbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bc1:	8d 50 01             	lea    0x1(%eax),%edx
     bc4:	8b 45 08             	mov    0x8(%ebp),%eax
     bc7:	01 d0                	add    %edx,%eax
     bc9:	0f b6 00             	movzbl (%eax),%eax
     bcc:	3c 5e                	cmp    $0x5e,%al
     bce:	75 11                	jne    be1 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd3:	c6 04 c5 a0 1b 00 00 	movb   $0x9,0x1ba0(,%eax,8)
     bda:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     bdb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     bdf:	eb 7a                	jmp    c5b <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be4:	c6 04 c5 a0 1b 00 00 	movb   $0x8,0x1ba0(,%eax,8)
     beb:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     bec:	eb 6d                	jmp    c5b <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     bee:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	01 d0                	add    %edx,%eax
     bf6:	0f b6 00             	movzbl (%eax),%eax
     bf9:	3c 5c                	cmp    $0x5c,%al
     bfb:	75 34                	jne    c31 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     bfd:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     c01:	7e 0a                	jle    c0d <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     c03:	b8 00 00 00 00       	mov    $0x0,%eax
     c08:	e9 f8 00 00 00       	jmp    d05 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     c0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c10:	8d 50 01             	lea    0x1(%eax),%edx
     c13:	89 55 fc             	mov    %edx,-0x4(%ebp)
     c16:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c19:	8d 4a 01             	lea    0x1(%edx),%ecx
     c1c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     c1f:	89 d1                	mov    %edx,%ecx
     c21:	8b 55 08             	mov    0x8(%ebp),%edx
     c24:	01 ca                	add    %ecx,%edx
     c26:	0f b6 12             	movzbl (%edx),%edx
     c29:	88 90 a0 1c 00 00    	mov    %dl,0x1ca0(%eax)
     c2f:	eb 10                	jmp    c41 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     c31:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     c35:	7e 0a                	jle    c41 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     c37:	b8 00 00 00 00       	mov    $0x0,%eax
     c3c:	e9 c4 00 00 00       	jmp    d05 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     c41:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c44:	8d 50 01             	lea    0x1(%eax),%edx
     c47:	89 55 fc             	mov    %edx,-0x4(%ebp)
     c4a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     c4d:	8b 55 08             	mov    0x8(%ebp),%edx
     c50:	01 ca                	add    %ecx,%edx
     c52:	0f b6 12             	movzbl (%edx),%edx
     c55:	88 90 a0 1c 00 00    	mov    %dl,0x1ca0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     c5b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     c5f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c62:	8b 45 08             	mov    0x8(%ebp),%eax
     c65:	01 d0                	add    %edx,%eax
     c67:	0f b6 00             	movzbl (%eax),%eax
     c6a:	3c 5d                	cmp    $0x5d,%al
     c6c:	74 13                	je     c81 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     c6e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c71:	8b 45 08             	mov    0x8(%ebp),%eax
     c74:	01 d0                	add    %edx,%eax
     c76:	0f b6 00             	movzbl (%eax),%eax
     c79:	84 c0                	test   %al,%al
     c7b:	0f 85 6d ff ff ff    	jne    bee <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     c81:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     c85:	7e 07                	jle    c8e <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     c87:	b8 00 00 00 00       	mov    $0x0,%eax
     c8c:	eb 77                	jmp    d05 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     c8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c91:	8d 50 01             	lea    0x1(%eax),%edx
     c94:	89 55 fc             	mov    %edx,-0x4(%ebp)
     c97:	c6 80 a0 1c 00 00 00 	movb   $0x0,0x1ca0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca1:	8d 90 a0 1c 00 00    	lea    0x1ca0(%eax),%edx
     ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     caa:	89 14 c5 a4 1b 00 00 	mov    %edx,0x1ba4(,%eax,8)
      } break;
     cb1:	eb 1c                	jmp    ccf <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb6:	c6 04 c5 a0 1b 00 00 	movb   $0x7,0x1ba0(,%eax,8)
     cbd:	07 
        re_compiled[j].ch = c;
     cbe:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc5:	88 14 c5 a4 1b 00 00 	mov    %dl,0x1ba4(,%eax,8)
      } break;
     ccc:	eb 01                	jmp    ccf <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     cce:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     ccf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     cd3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     cd7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     cda:	8b 45 08             	mov    0x8(%ebp),%eax
     cdd:	01 d0                	add    %edx,%eax
     cdf:	0f b6 00             	movzbl (%eax),%eax
     ce2:	84 c0                	test   %al,%al
     ce4:	74 0f                	je     cf5 <re_compile+0x293>
     ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce9:	83 c0 01             	add    $0x1,%eax
     cec:	83 f8 1d             	cmp    $0x1d,%eax
     cef:	0f 8e 8d fd ff ff    	jle    a82 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     cf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf8:	c6 04 c5 a0 1b 00 00 	movb   $0x0,0x1ba0(,%eax,8)
     cff:	00 

  return (re_t) re_compiled;
     d00:	b8 a0 1b 00 00       	mov    $0x1ba0,%eax
}
     d05:	c9                   	leave  
     d06:	c3                   	ret    

00000d07 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     d07:	55                   	push   %ebp
     d08:	89 e5                	mov    %esp,%ebp
     d0a:	83 ec 04             	sub    $0x4,%esp
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     d13:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     d17:	7e 0d                	jle    d26 <matchdigit+0x1f>
     d19:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     d1d:	7f 07                	jg     d26 <matchdigit+0x1f>
     d1f:	b8 01 00 00 00       	mov    $0x1,%eax
     d24:	eb 05                	jmp    d2b <matchdigit+0x24>
     d26:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d2b:	c9                   	leave  
     d2c:	c3                   	ret    

00000d2d <matchalpha>:
static int matchalpha(char c)
{
     d2d:	55                   	push   %ebp
     d2e:	89 e5                	mov    %esp,%ebp
     d30:	83 ec 04             	sub    $0x4,%esp
     d33:	8b 45 08             	mov    0x8(%ebp),%eax
     d36:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     d39:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     d3d:	7e 06                	jle    d45 <matchalpha+0x18>
     d3f:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     d43:	7e 0c                	jle    d51 <matchalpha+0x24>
     d45:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     d49:	7e 0d                	jle    d58 <matchalpha+0x2b>
     d4b:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     d4f:	7f 07                	jg     d58 <matchalpha+0x2b>
     d51:	b8 01 00 00 00       	mov    $0x1,%eax
     d56:	eb 05                	jmp    d5d <matchalpha+0x30>
     d58:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d5d:	c9                   	leave  
     d5e:	c3                   	ret    

00000d5f <matchwhitespace>:
static int matchwhitespace(char c)
{
     d5f:	55                   	push   %ebp
     d60:	89 e5                	mov    %esp,%ebp
     d62:	83 ec 04             	sub    $0x4,%esp
     d65:	8b 45 08             	mov    0x8(%ebp),%eax
     d68:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     d6b:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     d6f:	74 1e                	je     d8f <matchwhitespace+0x30>
     d71:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     d75:	74 18                	je     d8f <matchwhitespace+0x30>
     d77:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     d7b:	74 12                	je     d8f <matchwhitespace+0x30>
     d7d:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     d81:	74 0c                	je     d8f <matchwhitespace+0x30>
     d83:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     d87:	74 06                	je     d8f <matchwhitespace+0x30>
     d89:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     d8d:	75 07                	jne    d96 <matchwhitespace+0x37>
     d8f:	b8 01 00 00 00       	mov    $0x1,%eax
     d94:	eb 05                	jmp    d9b <matchwhitespace+0x3c>
     d96:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d9b:	c9                   	leave  
     d9c:	c3                   	ret    

00000d9d <matchalphanum>:
static int matchalphanum(char c)
{
     d9d:	55                   	push   %ebp
     d9e:	89 e5                	mov    %esp,%ebp
     da0:	83 ec 04             	sub    $0x4,%esp
     da3:	8b 45 08             	mov    0x8(%ebp),%eax
     da6:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     da9:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     dad:	74 22                	je     dd1 <matchalphanum+0x34>
     daf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     db3:	50                   	push   %eax
     db4:	e8 74 ff ff ff       	call   d2d <matchalpha>
     db9:	83 c4 04             	add    $0x4,%esp
     dbc:	85 c0                	test   %eax,%eax
     dbe:	75 11                	jne    dd1 <matchalphanum+0x34>
     dc0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dc4:	50                   	push   %eax
     dc5:	e8 3d ff ff ff       	call   d07 <matchdigit>
     dca:	83 c4 04             	add    $0x4,%esp
     dcd:	85 c0                	test   %eax,%eax
     dcf:	74 07                	je     dd8 <matchalphanum+0x3b>
     dd1:	b8 01 00 00 00       	mov    $0x1,%eax
     dd6:	eb 05                	jmp    ddd <matchalphanum+0x40>
     dd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ddd:	c9                   	leave  
     dde:	c3                   	ret    

00000ddf <matchrange>:
static int matchrange(char c, const char* str)
{
     ddf:	55                   	push   %ebp
     de0:	89 e5                	mov    %esp,%ebp
     de2:	83 ec 04             	sub    $0x4,%esp
     de5:	8b 45 08             	mov    0x8(%ebp),%eax
     de8:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     deb:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     def:	74 5b                	je     e4c <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     df1:	8b 45 0c             	mov    0xc(%ebp),%eax
     df4:	0f b6 00             	movzbl (%eax),%eax
     df7:	84 c0                	test   %al,%al
     df9:	74 51                	je     e4c <matchrange+0x6d>
     dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dfe:	0f b6 00             	movzbl (%eax),%eax
     e01:	3c 2d                	cmp    $0x2d,%al
     e03:	74 47                	je     e4c <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     e05:	8b 45 0c             	mov    0xc(%ebp),%eax
     e08:	83 c0 01             	add    $0x1,%eax
     e0b:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     e0e:	3c 2d                	cmp    $0x2d,%al
     e10:	75 3a                	jne    e4c <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     e12:	8b 45 0c             	mov    0xc(%ebp),%eax
     e15:	83 c0 01             	add    $0x1,%eax
     e18:	0f b6 00             	movzbl (%eax),%eax
     e1b:	84 c0                	test   %al,%al
     e1d:	74 2d                	je     e4c <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e22:	83 c0 02             	add    $0x2,%eax
     e25:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     e28:	84 c0                	test   %al,%al
     e2a:	74 20                	je     e4c <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2f:	0f b6 00             	movzbl (%eax),%eax
     e32:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e35:	7f 15                	jg     e4c <matchrange+0x6d>
     e37:	8b 45 0c             	mov    0xc(%ebp),%eax
     e3a:	83 c0 02             	add    $0x2,%eax
     e3d:	0f b6 00             	movzbl (%eax),%eax
     e40:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e43:	7c 07                	jl     e4c <matchrange+0x6d>
     e45:	b8 01 00 00 00       	mov    $0x1,%eax
     e4a:	eb 05                	jmp    e51 <matchrange+0x72>
     e4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e51:	c9                   	leave  
     e52:	c3                   	ret    

00000e53 <ismetachar>:
static int ismetachar(char c)
{
     e53:	55                   	push   %ebp
     e54:	89 e5                	mov    %esp,%ebp
     e56:	83 ec 04             	sub    $0x4,%esp
     e59:	8b 45 08             	mov    0x8(%ebp),%eax
     e5c:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     e5f:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     e63:	74 1e                	je     e83 <ismetachar+0x30>
     e65:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     e69:	74 18                	je     e83 <ismetachar+0x30>
     e6b:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     e6f:	74 12                	je     e83 <ismetachar+0x30>
     e71:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     e75:	74 0c                	je     e83 <ismetachar+0x30>
     e77:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     e7b:	74 06                	je     e83 <ismetachar+0x30>
     e7d:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     e81:	75 07                	jne    e8a <ismetachar+0x37>
     e83:	b8 01 00 00 00       	mov    $0x1,%eax
     e88:	eb 05                	jmp    e8f <ismetachar+0x3c>
     e8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e8f:	c9                   	leave  
     e90:	c3                   	ret    

00000e91 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     e91:	55                   	push   %ebp
     e92:	89 e5                	mov    %esp,%ebp
     e94:	83 ec 04             	sub    $0x4,%esp
     e97:	8b 45 08             	mov    0x8(%ebp),%eax
     e9a:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea0:	0f b6 00             	movzbl (%eax),%eax
     ea3:	0f be c0             	movsbl %al,%eax
     ea6:	83 e8 44             	sub    $0x44,%eax
     ea9:	83 f8 33             	cmp    $0x33,%eax
     eac:	77 7b                	ja     f29 <matchmetachar+0x98>
     eae:	8b 04 85 d4 15 00 00 	mov    0x15d4(,%eax,4),%eax
     eb5:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     eb7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ebb:	50                   	push   %eax
     ebc:	e8 46 fe ff ff       	call   d07 <matchdigit>
     ec1:	83 c4 04             	add    $0x4,%esp
     ec4:	eb 72                	jmp    f38 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     ec6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eca:	50                   	push   %eax
     ecb:	e8 37 fe ff ff       	call   d07 <matchdigit>
     ed0:	83 c4 04             	add    $0x4,%esp
     ed3:	85 c0                	test   %eax,%eax
     ed5:	0f 94 c0             	sete   %al
     ed8:	0f b6 c0             	movzbl %al,%eax
     edb:	eb 5b                	jmp    f38 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     edd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ee1:	50                   	push   %eax
     ee2:	e8 b6 fe ff ff       	call   d9d <matchalphanum>
     ee7:	83 c4 04             	add    $0x4,%esp
     eea:	eb 4c                	jmp    f38 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     eec:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ef0:	50                   	push   %eax
     ef1:	e8 a7 fe ff ff       	call   d9d <matchalphanum>
     ef6:	83 c4 04             	add    $0x4,%esp
     ef9:	85 c0                	test   %eax,%eax
     efb:	0f 94 c0             	sete   %al
     efe:	0f b6 c0             	movzbl %al,%eax
     f01:	eb 35                	jmp    f38 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     f03:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f07:	50                   	push   %eax
     f08:	e8 52 fe ff ff       	call   d5f <matchwhitespace>
     f0d:	83 c4 04             	add    $0x4,%esp
     f10:	eb 26                	jmp    f38 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     f12:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f16:	50                   	push   %eax
     f17:	e8 43 fe ff ff       	call   d5f <matchwhitespace>
     f1c:	83 c4 04             	add    $0x4,%esp
     f1f:	85 c0                	test   %eax,%eax
     f21:	0f 94 c0             	sete   %al
     f24:	0f b6 c0             	movzbl %al,%eax
     f27:	eb 0f                	jmp    f38 <matchmetachar+0xa7>
    default:  return (c == str[0]);
     f29:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2c:	0f b6 00             	movzbl (%eax),%eax
     f2f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f32:	0f 94 c0             	sete   %al
     f35:	0f b6 c0             	movzbl %al,%eax
  }
}
     f38:	c9                   	leave  
     f39:	c3                   	ret    

00000f3a <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     f3a:	55                   	push   %ebp
     f3b:	89 e5                	mov    %esp,%ebp
     f3d:	83 ec 04             	sub    $0x4,%esp
     f40:	8b 45 08             	mov    0x8(%ebp),%eax
     f43:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     f46:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f4a:	ff 75 0c             	pushl  0xc(%ebp)
     f4d:	50                   	push   %eax
     f4e:	e8 8c fe ff ff       	call   ddf <matchrange>
     f53:	83 c4 08             	add    $0x8,%esp
     f56:	85 c0                	test   %eax,%eax
     f58:	74 0a                	je     f64 <matchcharclass+0x2a>
    {
      return 1;
     f5a:	b8 01 00 00 00       	mov    $0x1,%eax
     f5f:	e9 a5 00 00 00       	jmp    1009 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     f64:	8b 45 0c             	mov    0xc(%ebp),%eax
     f67:	0f b6 00             	movzbl (%eax),%eax
     f6a:	3c 5c                	cmp    $0x5c,%al
     f6c:	75 42                	jne    fb0 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     f6e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     f72:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f76:	ff 75 0c             	pushl  0xc(%ebp)
     f79:	50                   	push   %eax
     f7a:	e8 12 ff ff ff       	call   e91 <matchmetachar>
     f7f:	83 c4 08             	add    $0x8,%esp
     f82:	85 c0                	test   %eax,%eax
     f84:	74 07                	je     f8d <matchcharclass+0x53>
      {
        return 1;
     f86:	b8 01 00 00 00       	mov    $0x1,%eax
     f8b:	eb 7c                	jmp    1009 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     f8d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f90:	0f b6 00             	movzbl (%eax),%eax
     f93:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f96:	75 58                	jne    ff0 <matchcharclass+0xb6>
     f98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f9c:	50                   	push   %eax
     f9d:	e8 b1 fe ff ff       	call   e53 <ismetachar>
     fa2:	83 c4 04             	add    $0x4,%esp
     fa5:	85 c0                	test   %eax,%eax
     fa7:	75 47                	jne    ff0 <matchcharclass+0xb6>
      {
        return 1;
     fa9:	b8 01 00 00 00       	mov    $0x1,%eax
     fae:	eb 59                	jmp    1009 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     fb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb3:	0f b6 00             	movzbl (%eax),%eax
     fb6:	3a 45 fc             	cmp    -0x4(%ebp),%al
     fb9:	75 35                	jne    ff0 <matchcharclass+0xb6>
    {
      if (c == '-')
     fbb:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     fbf:	75 28                	jne    fe9 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc4:	83 e8 01             	sub    $0x1,%eax
     fc7:	0f b6 00             	movzbl (%eax),%eax
     fca:	84 c0                	test   %al,%al
     fcc:	74 0d                	je     fdb <matchcharclass+0xa1>
     fce:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd1:	83 c0 01             	add    $0x1,%eax
     fd4:	0f b6 00             	movzbl (%eax),%eax
     fd7:	84 c0                	test   %al,%al
     fd9:	75 07                	jne    fe2 <matchcharclass+0xa8>
     fdb:	b8 01 00 00 00       	mov    $0x1,%eax
     fe0:	eb 27                	jmp    1009 <matchcharclass+0xcf>
     fe2:	b8 00 00 00 00       	mov    $0x0,%eax
     fe7:	eb 20                	jmp    1009 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     fe9:	b8 01 00 00 00       	mov    $0x1,%eax
     fee:	eb 19                	jmp    1009 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff3:	8d 50 01             	lea    0x1(%eax),%edx
     ff6:	89 55 0c             	mov    %edx,0xc(%ebp)
     ff9:	0f b6 00             	movzbl (%eax),%eax
     ffc:	84 c0                	test   %al,%al
     ffe:	0f 85 42 ff ff ff    	jne    f46 <matchcharclass+0xc>

  return 0;
    1004:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1009:	c9                   	leave  
    100a:	c3                   	ret    

0000100b <matchone>:

static int matchone(regex_t p, char c)
{
    100b:	55                   	push   %ebp
    100c:	89 e5                	mov    %esp,%ebp
    100e:	83 ec 04             	sub    $0x4,%esp
    1011:	8b 45 10             	mov    0x10(%ebp),%eax
    1014:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
    1017:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    101b:	0f b6 c0             	movzbl %al,%eax
    101e:	83 f8 0f             	cmp    $0xf,%eax
    1021:	0f 87 b9 00 00 00    	ja     10e0 <matchone+0xd5>
    1027:	8b 04 85 a4 16 00 00 	mov    0x16a4(,%eax,4),%eax
    102e:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
    1030:	b8 01 00 00 00       	mov    $0x1,%eax
    1035:	e9 b9 00 00 00       	jmp    10f3 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
    103a:	8b 55 0c             	mov    0xc(%ebp),%edx
    103d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1041:	52                   	push   %edx
    1042:	50                   	push   %eax
    1043:	e8 f2 fe ff ff       	call   f3a <matchcharclass>
    1048:	83 c4 08             	add    $0x8,%esp
    104b:	e9 a3 00 00 00       	jmp    10f3 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
    1050:	8b 55 0c             	mov    0xc(%ebp),%edx
    1053:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1057:	52                   	push   %edx
    1058:	50                   	push   %eax
    1059:	e8 dc fe ff ff       	call   f3a <matchcharclass>
    105e:	83 c4 08             	add    $0x8,%esp
    1061:	85 c0                	test   %eax,%eax
    1063:	0f 94 c0             	sete   %al
    1066:	0f b6 c0             	movzbl %al,%eax
    1069:	e9 85 00 00 00       	jmp    10f3 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    106e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1072:	50                   	push   %eax
    1073:	e8 8f fc ff ff       	call   d07 <matchdigit>
    1078:	83 c4 04             	add    $0x4,%esp
    107b:	eb 76                	jmp    10f3 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    107d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1081:	50                   	push   %eax
    1082:	e8 80 fc ff ff       	call   d07 <matchdigit>
    1087:	83 c4 04             	add    $0x4,%esp
    108a:	85 c0                	test   %eax,%eax
    108c:	0f 94 c0             	sete   %al
    108f:	0f b6 c0             	movzbl %al,%eax
    1092:	eb 5f                	jmp    10f3 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    1094:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1098:	50                   	push   %eax
    1099:	e8 ff fc ff ff       	call   d9d <matchalphanum>
    109e:	83 c4 04             	add    $0x4,%esp
    10a1:	eb 50                	jmp    10f3 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    10a3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10a7:	50                   	push   %eax
    10a8:	e8 f0 fc ff ff       	call   d9d <matchalphanum>
    10ad:	83 c4 04             	add    $0x4,%esp
    10b0:	85 c0                	test   %eax,%eax
    10b2:	0f 94 c0             	sete   %al
    10b5:	0f b6 c0             	movzbl %al,%eax
    10b8:	eb 39                	jmp    10f3 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    10ba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10be:	50                   	push   %eax
    10bf:	e8 9b fc ff ff       	call   d5f <matchwhitespace>
    10c4:	83 c4 04             	add    $0x4,%esp
    10c7:	eb 2a                	jmp    10f3 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    10c9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10cd:	50                   	push   %eax
    10ce:	e8 8c fc ff ff       	call   d5f <matchwhitespace>
    10d3:	83 c4 04             	add    $0x4,%esp
    10d6:	85 c0                	test   %eax,%eax
    10d8:	0f 94 c0             	sete   %al
    10db:	0f b6 c0             	movzbl %al,%eax
    10de:	eb 13                	jmp    10f3 <matchone+0xe8>
    default:             return  (p.ch == c);
    10e0:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    10e4:	0f b6 d0             	movzbl %al,%edx
    10e7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10eb:	39 c2                	cmp    %eax,%edx
    10ed:	0f 94 c0             	sete   %al
    10f0:	0f b6 c0             	movzbl %al,%eax
  }
}
    10f3:	c9                   	leave  
    10f4:	c3                   	ret    

000010f5 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10f5:	55                   	push   %ebp
    10f6:	89 e5                	mov    %esp,%ebp
    10f8:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    10fb:	8b 45 18             	mov    0x18(%ebp),%eax
    10fe:	8b 00                	mov    (%eax),%eax
    1100:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1103:	8b 45 14             	mov    0x14(%ebp),%eax
    1106:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1109:	eb 11                	jmp    111c <matchstar+0x27>
  {
    text++;
    110b:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    110f:	8b 45 18             	mov    0x18(%ebp),%eax
    1112:	8b 00                	mov    (%eax),%eax
    1114:	8d 50 01             	lea    0x1(%eax),%edx
    1117:	8b 45 18             	mov    0x18(%ebp),%eax
    111a:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    111c:	8b 45 14             	mov    0x14(%ebp),%eax
    111f:	0f b6 00             	movzbl (%eax),%eax
    1122:	84 c0                	test   %al,%al
    1124:	74 51                	je     1177 <matchstar+0x82>
    1126:	8b 45 14             	mov    0x14(%ebp),%eax
    1129:	0f b6 00             	movzbl (%eax),%eax
    112c:	0f be c0             	movsbl %al,%eax
    112f:	50                   	push   %eax
    1130:	ff 75 0c             	pushl  0xc(%ebp)
    1133:	ff 75 08             	pushl  0x8(%ebp)
    1136:	e8 d0 fe ff ff       	call   100b <matchone>
    113b:	83 c4 0c             	add    $0xc,%esp
    113e:	85 c0                	test   %eax,%eax
    1140:	75 c9                	jne    110b <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1142:	eb 33                	jmp    1177 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    1144:	8b 45 14             	mov    0x14(%ebp),%eax
    1147:	8d 50 ff             	lea    -0x1(%eax),%edx
    114a:	89 55 14             	mov    %edx,0x14(%ebp)
    114d:	83 ec 04             	sub    $0x4,%esp
    1150:	ff 75 18             	pushl  0x18(%ebp)
    1153:	50                   	push   %eax
    1154:	ff 75 10             	pushl  0x10(%ebp)
    1157:	e8 51 01 00 00       	call   12ad <matchpattern>
    115c:	83 c4 10             	add    $0x10,%esp
    115f:	85 c0                	test   %eax,%eax
    1161:	74 07                	je     116a <matchstar+0x75>
      return 1;
    1163:	b8 01 00 00 00       	mov    $0x1,%eax
    1168:	eb 22                	jmp    118c <matchstar+0x97>
    (*matchlength)--;
    116a:	8b 45 18             	mov    0x18(%ebp),%eax
    116d:	8b 00                	mov    (%eax),%eax
    116f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1172:	8b 45 18             	mov    0x18(%ebp),%eax
    1175:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1177:	8b 45 14             	mov    0x14(%ebp),%eax
    117a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    117d:	73 c5                	jae    1144 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    117f:	8b 45 18             	mov    0x18(%ebp),%eax
    1182:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1185:	89 10                	mov    %edx,(%eax)
  return 0;
    1187:	b8 00 00 00 00       	mov    $0x0,%eax
}
    118c:	c9                   	leave  
    118d:	c3                   	ret    

0000118e <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    118e:	55                   	push   %ebp
    118f:	89 e5                	mov    %esp,%ebp
    1191:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1194:	8b 45 14             	mov    0x14(%ebp),%eax
    1197:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    119a:	eb 11                	jmp    11ad <matchplus+0x1f>
  {
    text++;
    119c:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    11a0:	8b 45 18             	mov    0x18(%ebp),%eax
    11a3:	8b 00                	mov    (%eax),%eax
    11a5:	8d 50 01             	lea    0x1(%eax),%edx
    11a8:	8b 45 18             	mov    0x18(%ebp),%eax
    11ab:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    11ad:	8b 45 14             	mov    0x14(%ebp),%eax
    11b0:	0f b6 00             	movzbl (%eax),%eax
    11b3:	84 c0                	test   %al,%al
    11b5:	74 51                	je     1208 <matchplus+0x7a>
    11b7:	8b 45 14             	mov    0x14(%ebp),%eax
    11ba:	0f b6 00             	movzbl (%eax),%eax
    11bd:	0f be c0             	movsbl %al,%eax
    11c0:	50                   	push   %eax
    11c1:	ff 75 0c             	pushl  0xc(%ebp)
    11c4:	ff 75 08             	pushl  0x8(%ebp)
    11c7:	e8 3f fe ff ff       	call   100b <matchone>
    11cc:	83 c4 0c             	add    $0xc,%esp
    11cf:	85 c0                	test   %eax,%eax
    11d1:	75 c9                	jne    119c <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    11d3:	eb 33                	jmp    1208 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    11d5:	8b 45 14             	mov    0x14(%ebp),%eax
    11d8:	8d 50 ff             	lea    -0x1(%eax),%edx
    11db:	89 55 14             	mov    %edx,0x14(%ebp)
    11de:	83 ec 04             	sub    $0x4,%esp
    11e1:	ff 75 18             	pushl  0x18(%ebp)
    11e4:	50                   	push   %eax
    11e5:	ff 75 10             	pushl  0x10(%ebp)
    11e8:	e8 c0 00 00 00       	call   12ad <matchpattern>
    11ed:	83 c4 10             	add    $0x10,%esp
    11f0:	85 c0                	test   %eax,%eax
    11f2:	74 07                	je     11fb <matchplus+0x6d>
      return 1;
    11f4:	b8 01 00 00 00       	mov    $0x1,%eax
    11f9:	eb 1a                	jmp    1215 <matchplus+0x87>
    (*matchlength)--;
    11fb:	8b 45 18             	mov    0x18(%ebp),%eax
    11fe:	8b 00                	mov    (%eax),%eax
    1200:	8d 50 ff             	lea    -0x1(%eax),%edx
    1203:	8b 45 18             	mov    0x18(%ebp),%eax
    1206:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1208:	8b 45 14             	mov    0x14(%ebp),%eax
    120b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    120e:	77 c5                	ja     11d5 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    1210:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1215:	c9                   	leave  
    1216:	c3                   	ret    

00001217 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1217:	55                   	push   %ebp
    1218:	89 e5                	mov    %esp,%ebp
    121a:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    121d:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1221:	84 c0                	test   %al,%al
    1223:	75 07                	jne    122c <matchquestion+0x15>
    return 1;
    1225:	b8 01 00 00 00       	mov    $0x1,%eax
    122a:	eb 7f                	jmp    12ab <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    122c:	83 ec 04             	sub    $0x4,%esp
    122f:	ff 75 18             	pushl  0x18(%ebp)
    1232:	ff 75 14             	pushl  0x14(%ebp)
    1235:	ff 75 10             	pushl  0x10(%ebp)
    1238:	e8 70 00 00 00       	call   12ad <matchpattern>
    123d:	83 c4 10             	add    $0x10,%esp
    1240:	85 c0                	test   %eax,%eax
    1242:	74 07                	je     124b <matchquestion+0x34>
      return 1;
    1244:	b8 01 00 00 00       	mov    $0x1,%eax
    1249:	eb 60                	jmp    12ab <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    124b:	8b 45 14             	mov    0x14(%ebp),%eax
    124e:	0f b6 00             	movzbl (%eax),%eax
    1251:	84 c0                	test   %al,%al
    1253:	74 51                	je     12a6 <matchquestion+0x8f>
    1255:	8b 45 14             	mov    0x14(%ebp),%eax
    1258:	8d 50 01             	lea    0x1(%eax),%edx
    125b:	89 55 14             	mov    %edx,0x14(%ebp)
    125e:	0f b6 00             	movzbl (%eax),%eax
    1261:	0f be c0             	movsbl %al,%eax
    1264:	83 ec 04             	sub    $0x4,%esp
    1267:	50                   	push   %eax
    1268:	ff 75 0c             	pushl  0xc(%ebp)
    126b:	ff 75 08             	pushl  0x8(%ebp)
    126e:	e8 98 fd ff ff       	call   100b <matchone>
    1273:	83 c4 10             	add    $0x10,%esp
    1276:	85 c0                	test   %eax,%eax
    1278:	74 2c                	je     12a6 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    127a:	83 ec 04             	sub    $0x4,%esp
    127d:	ff 75 18             	pushl  0x18(%ebp)
    1280:	ff 75 14             	pushl  0x14(%ebp)
    1283:	ff 75 10             	pushl  0x10(%ebp)
    1286:	e8 22 00 00 00       	call   12ad <matchpattern>
    128b:	83 c4 10             	add    $0x10,%esp
    128e:	85 c0                	test   %eax,%eax
    1290:	74 14                	je     12a6 <matchquestion+0x8f>
    {
      (*matchlength)++;
    1292:	8b 45 18             	mov    0x18(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	8d 50 01             	lea    0x1(%eax),%edx
    129a:	8b 45 18             	mov    0x18(%ebp),%eax
    129d:	89 10                	mov    %edx,(%eax)
      return 1;
    129f:	b8 01 00 00 00       	mov    $0x1,%eax
    12a4:	eb 05                	jmp    12ab <matchquestion+0x94>
    }
  }
  return 0;
    12a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12ab:	c9                   	leave  
    12ac:	c3                   	ret    

000012ad <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    12ad:	55                   	push   %ebp
    12ae:	89 e5                	mov    %esp,%ebp
    12b0:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    12b3:	8b 45 10             	mov    0x10(%ebp),%eax
    12b6:	8b 00                	mov    (%eax),%eax
    12b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    12bb:	8b 45 08             	mov    0x8(%ebp),%eax
    12be:	0f b6 00             	movzbl (%eax),%eax
    12c1:	84 c0                	test   %al,%al
    12c3:	74 0d                	je     12d2 <matchpattern+0x25>
    12c5:	8b 45 08             	mov    0x8(%ebp),%eax
    12c8:	83 c0 08             	add    $0x8,%eax
    12cb:	0f b6 00             	movzbl (%eax),%eax
    12ce:	3c 04                	cmp    $0x4,%al
    12d0:	75 25                	jne    12f7 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    12d2:	8b 45 08             	mov    0x8(%ebp),%eax
    12d5:	83 c0 10             	add    $0x10,%eax
    12d8:	83 ec 0c             	sub    $0xc,%esp
    12db:	ff 75 10             	pushl  0x10(%ebp)
    12de:	ff 75 0c             	pushl  0xc(%ebp)
    12e1:	50                   	push   %eax
    12e2:	8b 45 08             	mov    0x8(%ebp),%eax
    12e5:	ff 70 04             	pushl  0x4(%eax)
    12e8:	ff 30                	pushl  (%eax)
    12ea:	e8 28 ff ff ff       	call   1217 <matchquestion>
    12ef:	83 c4 20             	add    $0x20,%esp
    12f2:	e9 dd 00 00 00       	jmp    13d4 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	83 c0 08             	add    $0x8,%eax
    12fd:	0f b6 00             	movzbl (%eax),%eax
    1300:	3c 05                	cmp    $0x5,%al
    1302:	75 25                	jne    1329 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1304:	8b 45 08             	mov    0x8(%ebp),%eax
    1307:	83 c0 10             	add    $0x10,%eax
    130a:	83 ec 0c             	sub    $0xc,%esp
    130d:	ff 75 10             	pushl  0x10(%ebp)
    1310:	ff 75 0c             	pushl  0xc(%ebp)
    1313:	50                   	push   %eax
    1314:	8b 45 08             	mov    0x8(%ebp),%eax
    1317:	ff 70 04             	pushl  0x4(%eax)
    131a:	ff 30                	pushl  (%eax)
    131c:	e8 d4 fd ff ff       	call   10f5 <matchstar>
    1321:	83 c4 20             	add    $0x20,%esp
    1324:	e9 ab 00 00 00       	jmp    13d4 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    1329:	8b 45 08             	mov    0x8(%ebp),%eax
    132c:	83 c0 08             	add    $0x8,%eax
    132f:	0f b6 00             	movzbl (%eax),%eax
    1332:	3c 06                	cmp    $0x6,%al
    1334:	75 22                	jne    1358 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    1336:	8b 45 08             	mov    0x8(%ebp),%eax
    1339:	83 c0 10             	add    $0x10,%eax
    133c:	83 ec 0c             	sub    $0xc,%esp
    133f:	ff 75 10             	pushl  0x10(%ebp)
    1342:	ff 75 0c             	pushl  0xc(%ebp)
    1345:	50                   	push   %eax
    1346:	8b 45 08             	mov    0x8(%ebp),%eax
    1349:	ff 70 04             	pushl  0x4(%eax)
    134c:	ff 30                	pushl  (%eax)
    134e:	e8 3b fe ff ff       	call   118e <matchplus>
    1353:	83 c4 20             	add    $0x20,%esp
    1356:	eb 7c                	jmp    13d4 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    1358:	8b 45 08             	mov    0x8(%ebp),%eax
    135b:	0f b6 00             	movzbl (%eax),%eax
    135e:	3c 03                	cmp    $0x3,%al
    1360:	75 1d                	jne    137f <matchpattern+0xd2>
    1362:	8b 45 08             	mov    0x8(%ebp),%eax
    1365:	83 c0 08             	add    $0x8,%eax
    1368:	0f b6 00             	movzbl (%eax),%eax
    136b:	84 c0                	test   %al,%al
    136d:	75 10                	jne    137f <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    136f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1372:	0f b6 00             	movzbl (%eax),%eax
    1375:	84 c0                	test   %al,%al
    1377:	0f 94 c0             	sete   %al
    137a:	0f b6 c0             	movzbl %al,%eax
    137d:	eb 55                	jmp    13d4 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    137f:	8b 45 10             	mov    0x10(%ebp),%eax
    1382:	8b 00                	mov    (%eax),%eax
    1384:	8d 50 01             	lea    0x1(%eax),%edx
    1387:	8b 45 10             	mov    0x10(%ebp),%eax
    138a:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    138c:	8b 45 0c             	mov    0xc(%ebp),%eax
    138f:	0f b6 00             	movzbl (%eax),%eax
    1392:	84 c0                	test   %al,%al
    1394:	74 31                	je     13c7 <matchpattern+0x11a>
    1396:	8b 45 0c             	mov    0xc(%ebp),%eax
    1399:	8d 50 01             	lea    0x1(%eax),%edx
    139c:	89 55 0c             	mov    %edx,0xc(%ebp)
    139f:	0f b6 00             	movzbl (%eax),%eax
    13a2:	0f be d0             	movsbl %al,%edx
    13a5:	8b 45 08             	mov    0x8(%ebp),%eax
    13a8:	8d 48 08             	lea    0x8(%eax),%ecx
    13ab:	89 4d 08             	mov    %ecx,0x8(%ebp)
    13ae:	83 ec 04             	sub    $0x4,%esp
    13b1:	52                   	push   %edx
    13b2:	ff 70 04             	pushl  0x4(%eax)
    13b5:	ff 30                	pushl  (%eax)
    13b7:	e8 4f fc ff ff       	call   100b <matchone>
    13bc:	83 c4 10             	add    $0x10,%esp
    13bf:	85 c0                	test   %eax,%eax
    13c1:	0f 85 f4 fe ff ff    	jne    12bb <matchpattern+0xe>

  *matchlength = pre;
    13c7:	8b 45 10             	mov    0x10(%ebp),%eax
    13ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13cd:	89 10                	mov    %edx,(%eax)
  return 0;
    13cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13d4:	c9                   	leave  
    13d5:	c3                   	ret    
