
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
      14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
      1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
      22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
      28:	83 ec 08             	sub    $0x8,%esp
      2b:	68 6c 13 00 00       	push   $0x136c
      30:	6a 01                	push   $0x1
      32:	e8 49 05 00 00       	call   580 <printf>
      37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
      3a:	83 ec 04             	sub    $0x4,%esp
      3d:	68 00 02 00 00       	push   $0x200
      42:	6a 61                	push   $0x61
      44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      4a:	50                   	push   %eax
      4b:	e8 be 01 00 00       	call   20e <memset>
      50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
      53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      5a:	eb 0d                	jmp    69 <main+0x69>
    if(fork() > 0)
      5c:	e8 40 03 00 00       	call   3a1 <fork>
      61:	85 c0                	test   %eax,%eax
      63:	7f 0c                	jg     71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
      65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      69:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
      6d:	7e ed                	jle    5c <main+0x5c>
      6f:	eb 01                	jmp    72 <main+0x72>
    if(fork() > 0)
      break;
      71:	90                   	nop

  printf(1, "write %d\n", i);
      72:	83 ec 04             	sub    $0x4,%esp
      75:	ff 75 f4             	pushl  -0xc(%ebp)
      78:	68 7f 13 00 00       	push   $0x137f
      7d:	6a 01                	push   $0x1
      7f:	e8 fc 04 00 00       	call   580 <printf>
      84:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
      87:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
      8b:	89 c2                	mov    %eax,%edx
      8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      90:	01 d0                	add    %edx,%eax
      92:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
      95:	83 ec 08             	sub    $0x8,%esp
      98:	68 02 02 00 00       	push   $0x202
      9d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
      a0:	50                   	push   %eax
      a1:	e8 43 03 00 00       	call   3e9 <open>
      a6:	83 c4 10             	add    $0x10,%esp
      a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
      ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      b3:	eb 1e                	jmp    d3 <main+0xd3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
      b5:	83 ec 04             	sub    $0x4,%esp
      b8:	68 00 02 00 00       	push   $0x200
      bd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      c3:	50                   	push   %eax
      c4:	ff 75 f0             	pushl  -0x10(%ebp)
      c7:	e8 fd 02 00 00       	call   3c9 <write>
      cc:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
      cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      d3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
      d7:	7e dc                	jle    b5 <main+0xb5>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	ff 75 f0             	pushl  -0x10(%ebp)
      df:	e8 ed 02 00 00       	call   3d1 <close>
      e4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
      e7:	83 ec 08             	sub    $0x8,%esp
      ea:	68 89 13 00 00       	push   $0x1389
      ef:	6a 01                	push   $0x1
      f1:	e8 8a 04 00 00       	call   580 <printf>
      f6:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
      f9:	83 ec 08             	sub    $0x8,%esp
      fc:	6a 00                	push   $0x0
      fe:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     101:	50                   	push   %eax
     102:	e8 e2 02 00 00       	call   3e9 <open>
     107:	83 c4 10             	add    $0x10,%esp
     10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
     10d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     114:	eb 1e                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
     116:	83 ec 04             	sub    $0x4,%esp
     119:	68 00 02 00 00       	push   $0x200
     11e:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
     124:	50                   	push   %eax
     125:	ff 75 f0             	pushl  -0x10(%ebp)
     128:	e8 94 02 00 00       	call   3c1 <read>
     12d:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
     130:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     134:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
     138:	7e dc                	jle    116 <main+0x116>
    read(fd, data, sizeof(data));
  close(fd);
     13a:	83 ec 0c             	sub    $0xc,%esp
     13d:	ff 75 f0             	pushl  -0x10(%ebp)
     140:	e8 8c 02 00 00       	call   3d1 <close>
     145:	83 c4 10             	add    $0x10,%esp

  wait();
     148:	e8 64 02 00 00       	call   3b1 <wait>
  
  exit();
     14d:	e8 57 02 00 00       	call   3a9 <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     152:	55                   	push   %ebp
     153:	89 e5                	mov    %esp,%ebp
     155:	57                   	push   %edi
     156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     157:	8b 4d 08             	mov    0x8(%ebp),%ecx
     15a:	8b 55 10             	mov    0x10(%ebp),%edx
     15d:	8b 45 0c             	mov    0xc(%ebp),%eax
     160:	89 cb                	mov    %ecx,%ebx
     162:	89 df                	mov    %ebx,%edi
     164:	89 d1                	mov    %edx,%ecx
     166:	fc                   	cld    
     167:	f3 aa                	rep stos %al,%es:(%edi)
     169:	89 ca                	mov    %ecx,%edx
     16b:	89 fb                	mov    %edi,%ebx
     16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
     170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     173:	90                   	nop
     174:	5b                   	pop    %ebx
     175:	5f                   	pop    %edi
     176:	5d                   	pop    %ebp
     177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     178:	55                   	push   %ebp
     179:	89 e5                	mov    %esp,%ebp
     17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     184:	90                   	nop
     185:	8b 45 08             	mov    0x8(%ebp),%eax
     188:	8d 50 01             	lea    0x1(%eax),%edx
     18b:	89 55 08             	mov    %edx,0x8(%ebp)
     18e:	8b 55 0c             	mov    0xc(%ebp),%edx
     191:	8d 4a 01             	lea    0x1(%edx),%ecx
     194:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     197:	0f b6 12             	movzbl (%edx),%edx
     19a:	88 10                	mov    %dl,(%eax)
     19c:	0f b6 00             	movzbl (%eax),%eax
     19f:	84 c0                	test   %al,%al
     1a1:	75 e2                	jne    185 <strcpy+0xd>
    ;
  return os;
     1a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1a6:	c9                   	leave  
     1a7:	c3                   	ret    

000001a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1a8:	55                   	push   %ebp
     1a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1ab:	eb 08                	jmp    1b5 <strcmp+0xd>
    p++, q++;
     1ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     1b5:	8b 45 08             	mov    0x8(%ebp),%eax
     1b8:	0f b6 00             	movzbl (%eax),%eax
     1bb:	84 c0                	test   %al,%al
     1bd:	74 10                	je     1cf <strcmp+0x27>
     1bf:	8b 45 08             	mov    0x8(%ebp),%eax
     1c2:	0f b6 10             	movzbl (%eax),%edx
     1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
     1c8:	0f b6 00             	movzbl (%eax),%eax
     1cb:	38 c2                	cmp    %al,%dl
     1cd:	74 de                	je     1ad <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
     1d2:	0f b6 00             	movzbl (%eax),%eax
     1d5:	0f b6 d0             	movzbl %al,%edx
     1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1db:	0f b6 00             	movzbl (%eax),%eax
     1de:	0f b6 c0             	movzbl %al,%eax
     1e1:	29 c2                	sub    %eax,%edx
     1e3:	89 d0                	mov    %edx,%eax
}
     1e5:	5d                   	pop    %ebp
     1e6:	c3                   	ret    

000001e7 <strlen>:

uint
strlen(char *s)
{
     1e7:	55                   	push   %ebp
     1e8:	89 e5                	mov    %esp,%ebp
     1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1f4:	eb 04                	jmp    1fa <strlen+0x13>
     1f6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1fd:	8b 45 08             	mov    0x8(%ebp),%eax
     200:	01 d0                	add    %edx,%eax
     202:	0f b6 00             	movzbl (%eax),%eax
     205:	84 c0                	test   %al,%al
     207:	75 ed                	jne    1f6 <strlen+0xf>
    ;
  return n;
     209:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     20c:	c9                   	leave  
     20d:	c3                   	ret    

0000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
     20e:	55                   	push   %ebp
     20f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     211:	8b 45 10             	mov    0x10(%ebp),%eax
     214:	50                   	push   %eax
     215:	ff 75 0c             	pushl  0xc(%ebp)
     218:	ff 75 08             	pushl  0x8(%ebp)
     21b:	e8 32 ff ff ff       	call   152 <stosb>
     220:	83 c4 0c             	add    $0xc,%esp
  return dst;
     223:	8b 45 08             	mov    0x8(%ebp),%eax
}
     226:	c9                   	leave  
     227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
     228:	55                   	push   %ebp
     229:	89 e5                	mov    %esp,%ebp
     22b:	83 ec 04             	sub    $0x4,%esp
     22e:	8b 45 0c             	mov    0xc(%ebp),%eax
     231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
     236:	8b 45 08             	mov    0x8(%ebp),%eax
     239:	0f b6 00             	movzbl (%eax),%eax
     23c:	3a 45 fc             	cmp    -0x4(%ebp),%al
     23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
     241:	8b 45 08             	mov    0x8(%ebp),%eax
     244:	eb 13                	jmp    259 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     24a:	8b 45 08             	mov    0x8(%ebp),%eax
     24d:	0f b6 00             	movzbl (%eax),%eax
     250:	84 c0                	test   %al,%al
     252:	75 e2                	jne    236 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     254:	b8 00 00 00 00       	mov    $0x0,%eax
}
     259:	c9                   	leave  
     25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
     25b:	55                   	push   %ebp
     25c:	89 e5                	mov    %esp,%ebp
     25e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     268:	eb 42                	jmp    2ac <gets+0x51>
    cc = read(0, &c, 1);
     26a:	83 ec 04             	sub    $0x4,%esp
     26d:	6a 01                	push   $0x1
     26f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     272:	50                   	push   %eax
     273:	6a 00                	push   $0x0
     275:	e8 47 01 00 00       	call   3c1 <read>
     27a:	83 c4 10             	add    $0x10,%esp
     27d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     284:	7e 33                	jle    2b9 <gets+0x5e>
      break;
    buf[i++] = c;
     286:	8b 45 f4             	mov    -0xc(%ebp),%eax
     289:	8d 50 01             	lea    0x1(%eax),%edx
     28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     28f:	89 c2                	mov    %eax,%edx
     291:	8b 45 08             	mov    0x8(%ebp),%eax
     294:	01 c2                	add    %eax,%edx
     296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2a0:	3c 0a                	cmp    $0xa,%al
     2a2:	74 16                	je     2ba <gets+0x5f>
     2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2a8:	3c 0d                	cmp    $0xd,%al
     2aa:	74 0e                	je     2ba <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2af:	83 c0 01             	add    $0x1,%eax
     2b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     2b5:	7c b3                	jl     26a <gets+0xf>
     2b7:	eb 01                	jmp    2ba <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     2b9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     2ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	01 d0                	add    %edx,%eax
     2c2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c8:	c9                   	leave  
     2c9:	c3                   	ret    

000002ca <stat>:

int
stat(char *n, struct stat *st)
{
     2ca:	55                   	push   %ebp
     2cb:	89 e5                	mov    %esp,%ebp
     2cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2d0:	83 ec 08             	sub    $0x8,%esp
     2d3:	6a 00                	push   $0x0
     2d5:	ff 75 08             	pushl  0x8(%ebp)
     2d8:	e8 0c 01 00 00       	call   3e9 <open>
     2dd:	83 c4 10             	add    $0x10,%esp
     2e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e7:	79 07                	jns    2f0 <stat+0x26>
    return -1;
     2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2ee:	eb 25                	jmp    315 <stat+0x4b>
  r = fstat(fd, st);
     2f0:	83 ec 08             	sub    $0x8,%esp
     2f3:	ff 75 0c             	pushl  0xc(%ebp)
     2f6:	ff 75 f4             	pushl  -0xc(%ebp)
     2f9:	e8 03 01 00 00       	call   401 <fstat>
     2fe:	83 c4 10             	add    $0x10,%esp
     301:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     304:	83 ec 0c             	sub    $0xc,%esp
     307:	ff 75 f4             	pushl  -0xc(%ebp)
     30a:	e8 c2 00 00 00       	call   3d1 <close>
     30f:	83 c4 10             	add    $0x10,%esp
  return r;
     312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     315:	c9                   	leave  
     316:	c3                   	ret    

00000317 <atoi>:

int
atoi(const char *s)
{
     317:	55                   	push   %ebp
     318:	89 e5                	mov    %esp,%ebp
     31a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     31d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     324:	eb 25                	jmp    34b <atoi+0x34>
    n = n*10 + *s++ - '0';
     326:	8b 55 fc             	mov    -0x4(%ebp),%edx
     329:	89 d0                	mov    %edx,%eax
     32b:	c1 e0 02             	shl    $0x2,%eax
     32e:	01 d0                	add    %edx,%eax
     330:	01 c0                	add    %eax,%eax
     332:	89 c1                	mov    %eax,%ecx
     334:	8b 45 08             	mov    0x8(%ebp),%eax
     337:	8d 50 01             	lea    0x1(%eax),%edx
     33a:	89 55 08             	mov    %edx,0x8(%ebp)
     33d:	0f b6 00             	movzbl (%eax),%eax
     340:	0f be c0             	movsbl %al,%eax
     343:	01 c8                	add    %ecx,%eax
     345:	83 e8 30             	sub    $0x30,%eax
     348:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
     34e:	0f b6 00             	movzbl (%eax),%eax
     351:	3c 2f                	cmp    $0x2f,%al
     353:	7e 0a                	jle    35f <atoi+0x48>
     355:	8b 45 08             	mov    0x8(%ebp),%eax
     358:	0f b6 00             	movzbl (%eax),%eax
     35b:	3c 39                	cmp    $0x39,%al
     35d:	7e c7                	jle    326 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     362:	c9                   	leave  
     363:	c3                   	ret    

00000364 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     364:	55                   	push   %ebp
     365:	89 e5                	mov    %esp,%ebp
     367:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     36a:	8b 45 08             	mov    0x8(%ebp),%eax
     36d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     370:	8b 45 0c             	mov    0xc(%ebp),%eax
     373:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     376:	eb 17                	jmp    38f <memmove+0x2b>
    *dst++ = *src++;
     378:	8b 45 fc             	mov    -0x4(%ebp),%eax
     37b:	8d 50 01             	lea    0x1(%eax),%edx
     37e:	89 55 fc             	mov    %edx,-0x4(%ebp)
     381:	8b 55 f8             	mov    -0x8(%ebp),%edx
     384:	8d 4a 01             	lea    0x1(%edx),%ecx
     387:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     38a:	0f b6 12             	movzbl (%edx),%edx
     38d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     38f:	8b 45 10             	mov    0x10(%ebp),%eax
     392:	8d 50 ff             	lea    -0x1(%eax),%edx
     395:	89 55 10             	mov    %edx,0x10(%ebp)
     398:	85 c0                	test   %eax,%eax
     39a:	7f dc                	jg     378 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     39f:	c9                   	leave  
     3a0:	c3                   	ret    

000003a1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     3a1:	b8 01 00 00 00       	mov    $0x1,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <exit>:
SYSCALL(exit)
     3a9:	b8 02 00 00 00       	mov    $0x2,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <wait>:
SYSCALL(wait)
     3b1:	b8 03 00 00 00       	mov    $0x3,%eax
     3b6:	cd 40                	int    $0x40
     3b8:	c3                   	ret    

000003b9 <pipe>:
SYSCALL(pipe)
     3b9:	b8 04 00 00 00       	mov    $0x4,%eax
     3be:	cd 40                	int    $0x40
     3c0:	c3                   	ret    

000003c1 <read>:
SYSCALL(read)
     3c1:	b8 05 00 00 00       	mov    $0x5,%eax
     3c6:	cd 40                	int    $0x40
     3c8:	c3                   	ret    

000003c9 <write>:
SYSCALL(write)
     3c9:	b8 10 00 00 00       	mov    $0x10,%eax
     3ce:	cd 40                	int    $0x40
     3d0:	c3                   	ret    

000003d1 <close>:
SYSCALL(close)
     3d1:	b8 15 00 00 00       	mov    $0x15,%eax
     3d6:	cd 40                	int    $0x40
     3d8:	c3                   	ret    

000003d9 <kill>:
SYSCALL(kill)
     3d9:	b8 06 00 00 00       	mov    $0x6,%eax
     3de:	cd 40                	int    $0x40
     3e0:	c3                   	ret    

000003e1 <exec>:
SYSCALL(exec)
     3e1:	b8 07 00 00 00       	mov    $0x7,%eax
     3e6:	cd 40                	int    $0x40
     3e8:	c3                   	ret    

000003e9 <open>:
SYSCALL(open)
     3e9:	b8 0f 00 00 00       	mov    $0xf,%eax
     3ee:	cd 40                	int    $0x40
     3f0:	c3                   	ret    

000003f1 <mknod>:
SYSCALL(mknod)
     3f1:	b8 11 00 00 00       	mov    $0x11,%eax
     3f6:	cd 40                	int    $0x40
     3f8:	c3                   	ret    

000003f9 <unlink>:
SYSCALL(unlink)
     3f9:	b8 12 00 00 00       	mov    $0x12,%eax
     3fe:	cd 40                	int    $0x40
     400:	c3                   	ret    

00000401 <fstat>:
SYSCALL(fstat)
     401:	b8 08 00 00 00       	mov    $0x8,%eax
     406:	cd 40                	int    $0x40
     408:	c3                   	ret    

00000409 <link>:
SYSCALL(link)
     409:	b8 13 00 00 00       	mov    $0x13,%eax
     40e:	cd 40                	int    $0x40
     410:	c3                   	ret    

00000411 <mkdir>:
SYSCALL(mkdir)
     411:	b8 14 00 00 00       	mov    $0x14,%eax
     416:	cd 40                	int    $0x40
     418:	c3                   	ret    

00000419 <chdir>:
SYSCALL(chdir)
     419:	b8 09 00 00 00       	mov    $0x9,%eax
     41e:	cd 40                	int    $0x40
     420:	c3                   	ret    

00000421 <dup>:
SYSCALL(dup)
     421:	b8 0a 00 00 00       	mov    $0xa,%eax
     426:	cd 40                	int    $0x40
     428:	c3                   	ret    

00000429 <getpid>:
SYSCALL(getpid)
     429:	b8 0b 00 00 00       	mov    $0xb,%eax
     42e:	cd 40                	int    $0x40
     430:	c3                   	ret    

00000431 <sbrk>:
SYSCALL(sbrk)
     431:	b8 0c 00 00 00       	mov    $0xc,%eax
     436:	cd 40                	int    $0x40
     438:	c3                   	ret    

00000439 <sleep>:
SYSCALL(sleep)
     439:	b8 0d 00 00 00       	mov    $0xd,%eax
     43e:	cd 40                	int    $0x40
     440:	c3                   	ret    

00000441 <uptime>:
SYSCALL(uptime)
     441:	b8 0e 00 00 00       	mov    $0xe,%eax
     446:	cd 40                	int    $0x40
     448:	c3                   	ret    

00000449 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     449:	b8 16 00 00 00       	mov    $0x16,%eax
     44e:	cd 40                	int    $0x40
     450:	c3                   	ret    

00000451 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     451:	b8 17 00 00 00       	mov    $0x17,%eax
     456:	cd 40                	int    $0x40
     458:	c3                   	ret    

00000459 <clearScreen>:
SYSCALL(clearScreen)
     459:	b8 18 00 00 00       	mov    $0x18,%eax
     45e:	cd 40                	int    $0x40
     460:	c3                   	ret    

00000461 <writeAt>:
SYSCALL(writeAt)
     461:	b8 19 00 00 00       	mov    $0x19,%eax
     466:	cd 40                	int    $0x40
     468:	c3                   	ret    

00000469 <setBufferFlag>:
SYSCALL(setBufferFlag)
     469:	b8 1a 00 00 00       	mov    $0x1a,%eax
     46e:	cd 40                	int    $0x40
     470:	c3                   	ret    

00000471 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     471:	b8 1b 00 00 00       	mov    $0x1b,%eax
     476:	cd 40                	int    $0x40
     478:	c3                   	ret    

00000479 <getCursorPos>:
SYSCALL(getCursorPos)
     479:	b8 1c 00 00 00       	mov    $0x1c,%eax
     47e:	cd 40                	int    $0x40
     480:	c3                   	ret    

00000481 <saveScreen>:
SYSCALL(saveScreen)
     481:	b8 1d 00 00 00       	mov    $0x1d,%eax
     486:	cd 40                	int    $0x40
     488:	c3                   	ret    

00000489 <recorverScreen>:
SYSCALL(recorverScreen)
     489:	b8 1e 00 00 00       	mov    $0x1e,%eax
     48e:	cd 40                	int    $0x40
     490:	c3                   	ret    

00000491 <ToScreen>:
SYSCALL(ToScreen)
     491:	b8 1f 00 00 00       	mov    $0x1f,%eax
     496:	cd 40                	int    $0x40
     498:	c3                   	ret    

00000499 <getColor>:
SYSCALL(getColor)
     499:	b8 20 00 00 00       	mov    $0x20,%eax
     49e:	cd 40                	int    $0x40
     4a0:	c3                   	ret    

000004a1 <showC>:
SYSCALL(showC)
     4a1:	b8 21 00 00 00       	mov    $0x21,%eax
     4a6:	cd 40                	int    $0x40
     4a8:	c3                   	ret    

000004a9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4a9:	55                   	push   %ebp
     4aa:	89 e5                	mov    %esp,%ebp
     4ac:	83 ec 18             	sub    $0x18,%esp
     4af:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     4b5:	83 ec 04             	sub    $0x4,%esp
     4b8:	6a 01                	push   $0x1
     4ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
     4bd:	50                   	push   %eax
     4be:	ff 75 08             	pushl  0x8(%ebp)
     4c1:	e8 03 ff ff ff       	call   3c9 <write>
     4c6:	83 c4 10             	add    $0x10,%esp
}
     4c9:	90                   	nop
     4ca:	c9                   	leave  
     4cb:	c3                   	ret    

000004cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4cc:	55                   	push   %ebp
     4cd:	89 e5                	mov    %esp,%ebp
     4cf:	53                   	push   %ebx
     4d0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4da:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4de:	74 17                	je     4f7 <printint+0x2b>
     4e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4e4:	79 11                	jns    4f7 <printint+0x2b>
    neg = 1;
     4e6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     4f0:	f7 d8                	neg    %eax
     4f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4f5:	eb 06                	jmp    4fd <printint+0x31>
  } else {
    x = xx;
     4f7:	8b 45 0c             	mov    0xc(%ebp),%eax
     4fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     504:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     507:	8d 41 01             	lea    0x1(%ecx),%eax
     50a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     50d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     510:	8b 45 ec             	mov    -0x14(%ebp),%eax
     513:	ba 00 00 00 00       	mov    $0x0,%edx
     518:	f7 f3                	div    %ebx
     51a:	89 d0                	mov    %edx,%eax
     51c:	0f b6 80 ac 1a 00 00 	movzbl 0x1aac(%eax),%eax
     523:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     527:	8b 5d 10             	mov    0x10(%ebp),%ebx
     52a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     52d:	ba 00 00 00 00       	mov    $0x0,%edx
     532:	f7 f3                	div    %ebx
     534:	89 45 ec             	mov    %eax,-0x14(%ebp)
     537:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     53b:	75 c7                	jne    504 <printint+0x38>
  if(neg)
     53d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     541:	74 2d                	je     570 <printint+0xa4>
    buf[i++] = '-';
     543:	8b 45 f4             	mov    -0xc(%ebp),%eax
     546:	8d 50 01             	lea    0x1(%eax),%edx
     549:	89 55 f4             	mov    %edx,-0xc(%ebp)
     54c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     551:	eb 1d                	jmp    570 <printint+0xa4>
    putc(fd, buf[i]);
     553:	8d 55 dc             	lea    -0x24(%ebp),%edx
     556:	8b 45 f4             	mov    -0xc(%ebp),%eax
     559:	01 d0                	add    %edx,%eax
     55b:	0f b6 00             	movzbl (%eax),%eax
     55e:	0f be c0             	movsbl %al,%eax
     561:	83 ec 08             	sub    $0x8,%esp
     564:	50                   	push   %eax
     565:	ff 75 08             	pushl  0x8(%ebp)
     568:	e8 3c ff ff ff       	call   4a9 <putc>
     56d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     570:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     574:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     578:	79 d9                	jns    553 <printint+0x87>
    putc(fd, buf[i]);
}
     57a:	90                   	nop
     57b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     57e:	c9                   	leave  
     57f:	c3                   	ret    

00000580 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     586:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     58d:	8d 45 0c             	lea    0xc(%ebp),%eax
     590:	83 c0 04             	add    $0x4,%eax
     593:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     596:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     59d:	e9 59 01 00 00       	jmp    6fb <printf+0x17b>
    c = fmt[i] & 0xff;
     5a2:	8b 55 0c             	mov    0xc(%ebp),%edx
     5a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5a8:	01 d0                	add    %edx,%eax
     5aa:	0f b6 00             	movzbl (%eax),%eax
     5ad:	0f be c0             	movsbl %al,%eax
     5b0:	25 ff 00 00 00       	and    $0xff,%eax
     5b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5bc:	75 2c                	jne    5ea <printf+0x6a>
      if(c == '%'){
     5be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c2:	75 0c                	jne    5d0 <printf+0x50>
        state = '%';
     5c4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     5cb:	e9 27 01 00 00       	jmp    6f7 <printf+0x177>
      } else {
        putc(fd, c);
     5d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d3:	0f be c0             	movsbl %al,%eax
     5d6:	83 ec 08             	sub    $0x8,%esp
     5d9:	50                   	push   %eax
     5da:	ff 75 08             	pushl  0x8(%ebp)
     5dd:	e8 c7 fe ff ff       	call   4a9 <putc>
     5e2:	83 c4 10             	add    $0x10,%esp
     5e5:	e9 0d 01 00 00       	jmp    6f7 <printf+0x177>
      }
    } else if(state == '%'){
     5ea:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5ee:	0f 85 03 01 00 00    	jne    6f7 <printf+0x177>
      if(c == 'd'){
     5f4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5f8:	75 1e                	jne    618 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5fd:	8b 00                	mov    (%eax),%eax
     5ff:	6a 01                	push   $0x1
     601:	6a 0a                	push   $0xa
     603:	50                   	push   %eax
     604:	ff 75 08             	pushl  0x8(%ebp)
     607:	e8 c0 fe ff ff       	call   4cc <printint>
     60c:	83 c4 10             	add    $0x10,%esp
        ap++;
     60f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     613:	e9 d8 00 00 00       	jmp    6f0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     618:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     61c:	74 06                	je     624 <printf+0xa4>
     61e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     622:	75 1e                	jne    642 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     624:	8b 45 e8             	mov    -0x18(%ebp),%eax
     627:	8b 00                	mov    (%eax),%eax
     629:	6a 00                	push   $0x0
     62b:	6a 10                	push   $0x10
     62d:	50                   	push   %eax
     62e:	ff 75 08             	pushl  0x8(%ebp)
     631:	e8 96 fe ff ff       	call   4cc <printint>
     636:	83 c4 10             	add    $0x10,%esp
        ap++;
     639:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     63d:	e9 ae 00 00 00       	jmp    6f0 <printf+0x170>
      } else if(c == 's'){
     642:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     646:	75 43                	jne    68b <printf+0x10b>
        s = (char*)*ap;
     648:	8b 45 e8             	mov    -0x18(%ebp),%eax
     64b:	8b 00                	mov    (%eax),%eax
     64d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     650:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     654:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     658:	75 25                	jne    67f <printf+0xff>
          s = "(null)";
     65a:	c7 45 f4 8f 13 00 00 	movl   $0x138f,-0xc(%ebp)
        while(*s != 0){
     661:	eb 1c                	jmp    67f <printf+0xff>
          putc(fd, *s);
     663:	8b 45 f4             	mov    -0xc(%ebp),%eax
     666:	0f b6 00             	movzbl (%eax),%eax
     669:	0f be c0             	movsbl %al,%eax
     66c:	83 ec 08             	sub    $0x8,%esp
     66f:	50                   	push   %eax
     670:	ff 75 08             	pushl  0x8(%ebp)
     673:	e8 31 fe ff ff       	call   4a9 <putc>
     678:	83 c4 10             	add    $0x10,%esp
          s++;
     67b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     67f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     682:	0f b6 00             	movzbl (%eax),%eax
     685:	84 c0                	test   %al,%al
     687:	75 da                	jne    663 <printf+0xe3>
     689:	eb 65                	jmp    6f0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     68b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     68f:	75 1d                	jne    6ae <printf+0x12e>
        putc(fd, *ap);
     691:	8b 45 e8             	mov    -0x18(%ebp),%eax
     694:	8b 00                	mov    (%eax),%eax
     696:	0f be c0             	movsbl %al,%eax
     699:	83 ec 08             	sub    $0x8,%esp
     69c:	50                   	push   %eax
     69d:	ff 75 08             	pushl  0x8(%ebp)
     6a0:	e8 04 fe ff ff       	call   4a9 <putc>
     6a5:	83 c4 10             	add    $0x10,%esp
        ap++;
     6a8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6ac:	eb 42                	jmp    6f0 <printf+0x170>
      } else if(c == '%'){
     6ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6b2:	75 17                	jne    6cb <printf+0x14b>
        putc(fd, c);
     6b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6b7:	0f be c0             	movsbl %al,%eax
     6ba:	83 ec 08             	sub    $0x8,%esp
     6bd:	50                   	push   %eax
     6be:	ff 75 08             	pushl  0x8(%ebp)
     6c1:	e8 e3 fd ff ff       	call   4a9 <putc>
     6c6:	83 c4 10             	add    $0x10,%esp
     6c9:	eb 25                	jmp    6f0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     6cb:	83 ec 08             	sub    $0x8,%esp
     6ce:	6a 25                	push   $0x25
     6d0:	ff 75 08             	pushl  0x8(%ebp)
     6d3:	e8 d1 fd ff ff       	call   4a9 <putc>
     6d8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     6db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6de:	0f be c0             	movsbl %al,%eax
     6e1:	83 ec 08             	sub    $0x8,%esp
     6e4:	50                   	push   %eax
     6e5:	ff 75 08             	pushl  0x8(%ebp)
     6e8:	e8 bc fd ff ff       	call   4a9 <putc>
     6ed:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6f7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6fb:	8b 55 0c             	mov    0xc(%ebp),%edx
     6fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     701:	01 d0                	add    %edx,%eax
     703:	0f b6 00             	movzbl (%eax),%eax
     706:	84 c0                	test   %al,%al
     708:	0f 85 94 fe ff ff    	jne    5a2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     70e:	90                   	nop
     70f:	c9                   	leave  
     710:	c3                   	ret    

00000711 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     711:	55                   	push   %ebp
     712:	89 e5                	mov    %esp,%ebp
     714:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     717:	8b 45 08             	mov    0x8(%ebp),%eax
     71a:	83 e8 08             	sub    $0x8,%eax
     71d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     720:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     725:	89 45 fc             	mov    %eax,-0x4(%ebp)
     728:	eb 24                	jmp    74e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72d:	8b 00                	mov    (%eax),%eax
     72f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     732:	77 12                	ja     746 <free+0x35>
     734:	8b 45 f8             	mov    -0x8(%ebp),%eax
     737:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     73a:	77 24                	ja     760 <free+0x4f>
     73c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73f:	8b 00                	mov    (%eax),%eax
     741:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     744:	77 1a                	ja     760 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     746:	8b 45 fc             	mov    -0x4(%ebp),%eax
     749:	8b 00                	mov    (%eax),%eax
     74b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     751:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     754:	76 d4                	jbe    72a <free+0x19>
     756:	8b 45 fc             	mov    -0x4(%ebp),%eax
     759:	8b 00                	mov    (%eax),%eax
     75b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     75e:	76 ca                	jbe    72a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     760:	8b 45 f8             	mov    -0x8(%ebp),%eax
     763:	8b 40 04             	mov    0x4(%eax),%eax
     766:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     76d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     770:	01 c2                	add    %eax,%edx
     772:	8b 45 fc             	mov    -0x4(%ebp),%eax
     775:	8b 00                	mov    (%eax),%eax
     777:	39 c2                	cmp    %eax,%edx
     779:	75 24                	jne    79f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     77b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     77e:	8b 50 04             	mov    0x4(%eax),%edx
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 00                	mov    (%eax),%eax
     786:	8b 40 04             	mov    0x4(%eax),%eax
     789:	01 c2                	add    %eax,%edx
     78b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     791:	8b 45 fc             	mov    -0x4(%ebp),%eax
     794:	8b 00                	mov    (%eax),%eax
     796:	8b 10                	mov    (%eax),%edx
     798:	8b 45 f8             	mov    -0x8(%ebp),%eax
     79b:	89 10                	mov    %edx,(%eax)
     79d:	eb 0a                	jmp    7a9 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     79f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a2:	8b 10                	mov    (%eax),%edx
     7a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ac:	8b 40 04             	mov    0x4(%eax),%eax
     7af:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b9:	01 d0                	add    %edx,%eax
     7bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7be:	75 20                	jne    7e0 <free+0xcf>
    p->s.size += bp->s.size;
     7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c3:	8b 50 04             	mov    0x4(%eax),%edx
     7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c9:	8b 40 04             	mov    0x4(%eax),%eax
     7cc:	01 c2                	add    %eax,%edx
     7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     7d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d7:	8b 10                	mov    (%eax),%edx
     7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7dc:	89 10                	mov    %edx,(%eax)
     7de:	eb 08                	jmp    7e8 <free+0xd7>
  } else
    p->s.ptr = bp;
     7e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7e6:	89 10                	mov    %edx,(%eax)
  freep = p;
     7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7eb:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
}
     7f0:	90                   	nop
     7f1:	c9                   	leave  
     7f2:	c3                   	ret    

000007f3 <morecore>:

static Header*
morecore(uint nu)
{
     7f3:	55                   	push   %ebp
     7f4:	89 e5                	mov    %esp,%ebp
     7f6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7f9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     800:	77 07                	ja     809 <morecore+0x16>
    nu = 4096;
     802:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     809:	8b 45 08             	mov    0x8(%ebp),%eax
     80c:	c1 e0 03             	shl    $0x3,%eax
     80f:	83 ec 0c             	sub    $0xc,%esp
     812:	50                   	push   %eax
     813:	e8 19 fc ff ff       	call   431 <sbrk>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     81e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     822:	75 07                	jne    82b <morecore+0x38>
    return 0;
     824:	b8 00 00 00 00       	mov    $0x0,%eax
     829:	eb 26                	jmp    851 <morecore+0x5e>
  hp = (Header*)p;
     82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     831:	8b 45 f0             	mov    -0x10(%ebp),%eax
     834:	8b 55 08             	mov    0x8(%ebp),%edx
     837:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     83a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     83d:	83 c0 08             	add    $0x8,%eax
     840:	83 ec 0c             	sub    $0xc,%esp
     843:	50                   	push   %eax
     844:	e8 c8 fe ff ff       	call   711 <free>
     849:	83 c4 10             	add    $0x10,%esp
  return freep;
     84c:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
}
     851:	c9                   	leave  
     852:	c3                   	ret    

00000853 <malloc>:

void*
malloc(uint nbytes)
{
     853:	55                   	push   %ebp
     854:	89 e5                	mov    %esp,%ebp
     856:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     859:	8b 45 08             	mov    0x8(%ebp),%eax
     85c:	83 c0 07             	add    $0x7,%eax
     85f:	c1 e8 03             	shr    $0x3,%eax
     862:	83 c0 01             	add    $0x1,%eax
     865:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     868:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     86d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     870:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     874:	75 23                	jne    899 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     876:	c7 45 f0 c0 1a 00 00 	movl   $0x1ac0,-0x10(%ebp)
     87d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     880:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
     885:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     88a:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
    base.s.size = 0;
     88f:	c7 05 c4 1a 00 00 00 	movl   $0x0,0x1ac4
     896:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     899:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89c:	8b 00                	mov    (%eax),%eax
     89e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a4:	8b 40 04             	mov    0x4(%eax),%eax
     8a7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8aa:	72 4d                	jb     8f9 <malloc+0xa6>
      if(p->s.size == nunits)
     8ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8af:	8b 40 04             	mov    0x4(%eax),%eax
     8b2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8b5:	75 0c                	jne    8c3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ba:	8b 10                	mov    (%eax),%edx
     8bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bf:	89 10                	mov    %edx,(%eax)
     8c1:	eb 26                	jmp    8e9 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c6:	8b 40 04             	mov    0x4(%eax),%eax
     8c9:	2b 45 ec             	sub    -0x14(%ebp),%eax
     8cc:	89 c2                	mov    %eax,%edx
     8ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d7:	8b 40 04             	mov    0x4(%eax),%eax
     8da:	c1 e0 03             	shl    $0x3,%eax
     8dd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     8e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8e6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8ec:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
      return (void*)(p + 1);
     8f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f4:	83 c0 08             	add    $0x8,%eax
     8f7:	eb 3b                	jmp    934 <malloc+0xe1>
    }
    if(p == freep)
     8f9:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     8fe:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     901:	75 1e                	jne    921 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	ff 75 ec             	pushl  -0x14(%ebp)
     909:	e8 e5 fe ff ff       	call   7f3 <morecore>
     90e:	83 c4 10             	add    $0x10,%esp
     911:	89 45 f4             	mov    %eax,-0xc(%ebp)
     914:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     918:	75 07                	jne    921 <malloc+0xce>
        return 0;
     91a:	b8 00 00 00 00       	mov    $0x0,%eax
     91f:	eb 13                	jmp    934 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     921:	8b 45 f4             	mov    -0xc(%ebp),%eax
     924:	89 45 f0             	mov    %eax,-0x10(%ebp)
     927:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92a:	8b 00                	mov    (%eax),%eax
     92c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     92f:	e9 6d ff ff ff       	jmp    8a1 <malloc+0x4e>
}
     934:	c9                   	leave  
     935:	c3                   	ret    

00000936 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     936:	55                   	push   %ebp
     937:	89 e5                	mov    %esp,%ebp
     939:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     93c:	83 ec 0c             	sub    $0xc,%esp
     93f:	ff 75 08             	pushl  0x8(%ebp)
     942:	e8 b0 00 00 00       	call   9f7 <re_compile>
     947:	83 c4 10             	add    $0x10,%esp
     94a:	83 ec 04             	sub    $0x4,%esp
     94d:	ff 75 10             	pushl  0x10(%ebp)
     950:	ff 75 0c             	pushl  0xc(%ebp)
     953:	50                   	push   %eax
     954:	e8 05 00 00 00       	call   95e <re_matchp>
     959:	83 c4 10             	add    $0x10,%esp
}
     95c:	c9                   	leave  
     95d:	c3                   	ret    

0000095e <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     95e:	55                   	push   %ebp
     95f:	89 e5                	mov    %esp,%ebp
     961:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     964:	8b 45 10             	mov    0x10(%ebp),%eax
     967:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     96d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     971:	74 7d                	je     9f0 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     973:	8b 45 08             	mov    0x8(%ebp),%eax
     976:	0f b6 00             	movzbl (%eax),%eax
     979:	3c 02                	cmp    $0x2,%al
     97b:	75 2a                	jne    9a7 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     97d:	8b 45 08             	mov    0x8(%ebp),%eax
     980:	83 c0 08             	add    $0x8,%eax
     983:	83 ec 04             	sub    $0x4,%esp
     986:	ff 75 10             	pushl  0x10(%ebp)
     989:	ff 75 0c             	pushl  0xc(%ebp)
     98c:	50                   	push   %eax
     98d:	e8 b0 08 00 00       	call   1242 <matchpattern>
     992:	83 c4 10             	add    $0x10,%esp
     995:	85 c0                	test   %eax,%eax
     997:	74 07                	je     9a0 <re_matchp+0x42>
     999:	b8 00 00 00 00       	mov    $0x0,%eax
     99e:	eb 55                	jmp    9f5 <re_matchp+0x97>
     9a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     9a5:	eb 4e                	jmp    9f5 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     9a7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     9ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     9b2:	83 ec 04             	sub    $0x4,%esp
     9b5:	ff 75 10             	pushl  0x10(%ebp)
     9b8:	ff 75 0c             	pushl  0xc(%ebp)
     9bb:	ff 75 08             	pushl  0x8(%ebp)
     9be:	e8 7f 08 00 00       	call   1242 <matchpattern>
     9c3:	83 c4 10             	add    $0x10,%esp
     9c6:	85 c0                	test   %eax,%eax
     9c8:	74 16                	je     9e0 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     9cd:	0f b6 00             	movzbl (%eax),%eax
     9d0:	84 c0                	test   %al,%al
     9d2:	75 07                	jne    9db <re_matchp+0x7d>
            return -1;
     9d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     9d9:	eb 1a                	jmp    9f5 <re_matchp+0x97>
        
          return idx;
     9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9de:	eb 15                	jmp    9f5 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     9e0:	8b 45 0c             	mov    0xc(%ebp),%eax
     9e3:	8d 50 01             	lea    0x1(%eax),%edx
     9e6:	89 55 0c             	mov    %edx,0xc(%ebp)
     9e9:	0f b6 00             	movzbl (%eax),%eax
     9ec:	84 c0                	test   %al,%al
     9ee:	75 be                	jne    9ae <re_matchp+0x50>
    }
  }
  return -1;
     9f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9f5:	c9                   	leave  
     9f6:	c3                   	ret    

000009f7 <re_compile>:

re_t re_compile(const char* pattern)
{
     9f7:	55                   	push   %ebp
     9f8:	89 e5                	mov    %esp,%ebp
     9fa:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     9fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     a04:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     a0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     a12:	e9 55 02 00 00       	jmp    c6c <re_compile+0x275>
  {
    c = pattern[i];
     a17:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a1a:	8b 45 08             	mov    0x8(%ebp),%eax
     a1d:	01 d0                	add    %edx,%eax
     a1f:	0f b6 00             	movzbl (%eax),%eax
     a22:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     a25:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     a29:	83 e8 24             	sub    $0x24,%eax
     a2c:	83 f8 3a             	cmp    $0x3a,%eax
     a2f:	0f 87 13 02 00 00    	ja     c48 <re_compile+0x251>
     a35:	8b 04 85 98 13 00 00 	mov    0x1398(,%eax,4),%eax
     a3c:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a41:	c6 04 c5 e0 1a 00 00 	movb   $0x2,0x1ae0(,%eax,8)
     a48:	02 
     a49:	e9 16 02 00 00       	jmp    c64 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a51:	c6 04 c5 e0 1a 00 00 	movb   $0x3,0x1ae0(,%eax,8)
     a58:	03 
     a59:	e9 06 02 00 00       	jmp    c64 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a61:	c6 04 c5 e0 1a 00 00 	movb   $0x1,0x1ae0(,%eax,8)
     a68:	01 
     a69:	e9 f6 01 00 00       	jmp    c64 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a71:	c6 04 c5 e0 1a 00 00 	movb   $0x5,0x1ae0(,%eax,8)
     a78:	05 
     a79:	e9 e6 01 00 00       	jmp    c64 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a81:	c6 04 c5 e0 1a 00 00 	movb   $0x6,0x1ae0(,%eax,8)
     a88:	06 
     a89:	e9 d6 01 00 00       	jmp    c64 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a91:	c6 04 c5 e0 1a 00 00 	movb   $0x4,0x1ae0(,%eax,8)
     a98:	04 
     a99:	e9 c6 01 00 00       	jmp    c64 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     a9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aa1:	8d 50 01             	lea    0x1(%eax),%edx
     aa4:	8b 45 08             	mov    0x8(%ebp),%eax
     aa7:	01 d0                	add    %edx,%eax
     aa9:	0f b6 00             	movzbl (%eax),%eax
     aac:	84 c0                	test   %al,%al
     aae:	0f 84 af 01 00 00    	je     c63 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     ab4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     ab8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     abb:	8b 45 08             	mov    0x8(%ebp),%eax
     abe:	01 d0                	add    %edx,%eax
     ac0:	0f b6 00             	movzbl (%eax),%eax
     ac3:	0f be c0             	movsbl %al,%eax
     ac6:	83 e8 44             	sub    $0x44,%eax
     ac9:	83 f8 33             	cmp    $0x33,%eax
     acc:	77 57                	ja     b25 <re_compile+0x12e>
     ace:	8b 04 85 84 14 00 00 	mov    0x1484(,%eax,4),%eax
     ad5:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ada:	c6 04 c5 e0 1a 00 00 	movb   $0xa,0x1ae0(,%eax,8)
     ae1:	0a 
     ae2:	eb 64                	jmp    b48 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae7:	c6 04 c5 e0 1a 00 00 	movb   $0xb,0x1ae0(,%eax,8)
     aee:	0b 
     aef:	eb 57                	jmp    b48 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af4:	c6 04 c5 e0 1a 00 00 	movb   $0xc,0x1ae0(,%eax,8)
     afb:	0c 
     afc:	eb 4a                	jmp    b48 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     afe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b01:	c6 04 c5 e0 1a 00 00 	movb   $0xd,0x1ae0(,%eax,8)
     b08:	0d 
     b09:	eb 3d                	jmp    b48 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0e:	c6 04 c5 e0 1a 00 00 	movb   $0xe,0x1ae0(,%eax,8)
     b15:	0e 
     b16:	eb 30                	jmp    b48 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1b:	c6 04 c5 e0 1a 00 00 	movb   $0xf,0x1ae0(,%eax,8)
     b22:	0f 
     b23:	eb 23                	jmp    b48 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b28:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     b2f:	07 
              re_compiled[j].ch = pattern[i];
     b30:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b33:	8b 45 08             	mov    0x8(%ebp),%eax
     b36:	01 d0                	add    %edx,%eax
     b38:	0f b6 00             	movzbl (%eax),%eax
     b3b:	89 c2                	mov    %eax,%edx
     b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b40:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
            } break;
     b47:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     b48:	e9 16 01 00 00       	jmp    c63 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     b4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b50:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     b53:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b56:	8d 50 01             	lea    0x1(%eax),%edx
     b59:	8b 45 08             	mov    0x8(%ebp),%eax
     b5c:	01 d0                	add    %edx,%eax
     b5e:	0f b6 00             	movzbl (%eax),%eax
     b61:	3c 5e                	cmp    $0x5e,%al
     b63:	75 11                	jne    b76 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b68:	c6 04 c5 e0 1a 00 00 	movb   $0x9,0x1ae0(,%eax,8)
     b6f:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     b70:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b74:	eb 7a                	jmp    bf0 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b79:	c6 04 c5 e0 1a 00 00 	movb   $0x8,0x1ae0(,%eax,8)
     b80:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b81:	eb 6d                	jmp    bf0 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     b83:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b86:	8b 45 08             	mov    0x8(%ebp),%eax
     b89:	01 d0                	add    %edx,%eax
     b8b:	0f b6 00             	movzbl (%eax),%eax
     b8e:	3c 5c                	cmp    $0x5c,%al
     b90:	75 34                	jne    bc6 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     b92:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     b96:	7e 0a                	jle    ba2 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b98:	b8 00 00 00 00       	mov    $0x0,%eax
     b9d:	e9 f8 00 00 00       	jmp    c9a <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ba5:	8d 50 01             	lea    0x1(%eax),%edx
     ba8:	89 55 fc             	mov    %edx,-0x4(%ebp)
     bab:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bae:	8d 4a 01             	lea    0x1(%edx),%ecx
     bb1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     bb4:	89 d1                	mov    %edx,%ecx
     bb6:	8b 55 08             	mov    0x8(%ebp),%edx
     bb9:	01 ca                	add    %ecx,%edx
     bbb:	0f b6 12             	movzbl (%edx),%edx
     bbe:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
     bc4:	eb 10                	jmp    bd6 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     bc6:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     bca:	7e 0a                	jle    bd6 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     bcc:	b8 00 00 00 00       	mov    $0x0,%eax
     bd1:	e9 c4 00 00 00       	jmp    c9a <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     bd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bd9:	8d 50 01             	lea    0x1(%eax),%edx
     bdc:	89 55 fc             	mov    %edx,-0x4(%ebp)
     bdf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     be2:	8b 55 08             	mov    0x8(%ebp),%edx
     be5:	01 ca                	add    %ecx,%edx
     be7:	0f b6 12             	movzbl (%edx),%edx
     bea:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     bf0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     bf4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf7:	8b 45 08             	mov    0x8(%ebp),%eax
     bfa:	01 d0                	add    %edx,%eax
     bfc:	0f b6 00             	movzbl (%eax),%eax
     bff:	3c 5d                	cmp    $0x5d,%al
     c01:	74 13                	je     c16 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     c03:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c06:	8b 45 08             	mov    0x8(%ebp),%eax
     c09:	01 d0                	add    %edx,%eax
     c0b:	0f b6 00             	movzbl (%eax),%eax
     c0e:	84 c0                	test   %al,%al
     c10:	0f 85 6d ff ff ff    	jne    b83 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     c16:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     c1a:	7e 07                	jle    c23 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     c1c:	b8 00 00 00 00       	mov    $0x0,%eax
     c21:	eb 77                	jmp    c9a <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     c23:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c26:	8d 50 01             	lea    0x1(%eax),%edx
     c29:	89 55 fc             	mov    %edx,-0x4(%ebp)
     c2c:	c6 80 e0 1b 00 00 00 	movb   $0x0,0x1be0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     c33:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c36:	8d 90 e0 1b 00 00    	lea    0x1be0(%eax),%edx
     c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3f:	89 14 c5 e4 1a 00 00 	mov    %edx,0x1ae4(,%eax,8)
      } break;
     c46:	eb 1c                	jmp    c64 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4b:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     c52:	07 
        re_compiled[j].ch = c;
     c53:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5a:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
      } break;
     c61:	eb 01                	jmp    c64 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     c63:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     c64:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     c68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     c6c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c6f:	8b 45 08             	mov    0x8(%ebp),%eax
     c72:	01 d0                	add    %edx,%eax
     c74:	0f b6 00             	movzbl (%eax),%eax
     c77:	84 c0                	test   %al,%al
     c79:	74 0f                	je     c8a <re_compile+0x293>
     c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c7e:	83 c0 01             	add    $0x1,%eax
     c81:	83 f8 1d             	cmp    $0x1d,%eax
     c84:	0f 8e 8d fd ff ff    	jle    a17 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8d:	c6 04 c5 e0 1a 00 00 	movb   $0x0,0x1ae0(,%eax,8)
     c94:	00 

  return (re_t) re_compiled;
     c95:	b8 e0 1a 00 00       	mov    $0x1ae0,%eax
}
     c9a:	c9                   	leave  
     c9b:	c3                   	ret    

00000c9c <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     c9c:	55                   	push   %ebp
     c9d:	89 e5                	mov    %esp,%ebp
     c9f:	83 ec 04             	sub    $0x4,%esp
     ca2:	8b 45 08             	mov    0x8(%ebp),%eax
     ca5:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     ca8:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     cac:	7e 0d                	jle    cbb <matchdigit+0x1f>
     cae:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     cb2:	7f 07                	jg     cbb <matchdigit+0x1f>
     cb4:	b8 01 00 00 00       	mov    $0x1,%eax
     cb9:	eb 05                	jmp    cc0 <matchdigit+0x24>
     cbb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cc0:	c9                   	leave  
     cc1:	c3                   	ret    

00000cc2 <matchalpha>:
static int matchalpha(char c)
{
     cc2:	55                   	push   %ebp
     cc3:	89 e5                	mov    %esp,%ebp
     cc5:	83 ec 04             	sub    $0x4,%esp
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     cce:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     cd2:	7e 06                	jle    cda <matchalpha+0x18>
     cd4:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     cd8:	7e 0c                	jle    ce6 <matchalpha+0x24>
     cda:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     cde:	7e 0d                	jle    ced <matchalpha+0x2b>
     ce0:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     ce4:	7f 07                	jg     ced <matchalpha+0x2b>
     ce6:	b8 01 00 00 00       	mov    $0x1,%eax
     ceb:	eb 05                	jmp    cf2 <matchalpha+0x30>
     ced:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cf2:	c9                   	leave  
     cf3:	c3                   	ret    

00000cf4 <matchwhitespace>:
static int matchwhitespace(char c)
{
     cf4:	55                   	push   %ebp
     cf5:	89 e5                	mov    %esp,%ebp
     cf7:	83 ec 04             	sub    $0x4,%esp
     cfa:	8b 45 08             	mov    0x8(%ebp),%eax
     cfd:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     d00:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     d04:	74 1e                	je     d24 <matchwhitespace+0x30>
     d06:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     d0a:	74 18                	je     d24 <matchwhitespace+0x30>
     d0c:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     d10:	74 12                	je     d24 <matchwhitespace+0x30>
     d12:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     d16:	74 0c                	je     d24 <matchwhitespace+0x30>
     d18:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     d1c:	74 06                	je     d24 <matchwhitespace+0x30>
     d1e:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     d22:	75 07                	jne    d2b <matchwhitespace+0x37>
     d24:	b8 01 00 00 00       	mov    $0x1,%eax
     d29:	eb 05                	jmp    d30 <matchwhitespace+0x3c>
     d2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d30:	c9                   	leave  
     d31:	c3                   	ret    

00000d32 <matchalphanum>:
static int matchalphanum(char c)
{
     d32:	55                   	push   %ebp
     d33:	89 e5                	mov    %esp,%ebp
     d35:	83 ec 04             	sub    $0x4,%esp
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     d3e:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     d42:	74 22                	je     d66 <matchalphanum+0x34>
     d44:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d48:	50                   	push   %eax
     d49:	e8 74 ff ff ff       	call   cc2 <matchalpha>
     d4e:	83 c4 04             	add    $0x4,%esp
     d51:	85 c0                	test   %eax,%eax
     d53:	75 11                	jne    d66 <matchalphanum+0x34>
     d55:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d59:	50                   	push   %eax
     d5a:	e8 3d ff ff ff       	call   c9c <matchdigit>
     d5f:	83 c4 04             	add    $0x4,%esp
     d62:	85 c0                	test   %eax,%eax
     d64:	74 07                	je     d6d <matchalphanum+0x3b>
     d66:	b8 01 00 00 00       	mov    $0x1,%eax
     d6b:	eb 05                	jmp    d72 <matchalphanum+0x40>
     d6d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d72:	c9                   	leave  
     d73:	c3                   	ret    

00000d74 <matchrange>:
static int matchrange(char c, const char* str)
{
     d74:	55                   	push   %ebp
     d75:	89 e5                	mov    %esp,%ebp
     d77:	83 ec 04             	sub    $0x4,%esp
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d80:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     d84:	74 5b                	je     de1 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     d86:	8b 45 0c             	mov    0xc(%ebp),%eax
     d89:	0f b6 00             	movzbl (%eax),%eax
     d8c:	84 c0                	test   %al,%al
     d8e:	74 51                	je     de1 <matchrange+0x6d>
     d90:	8b 45 0c             	mov    0xc(%ebp),%eax
     d93:	0f b6 00             	movzbl (%eax),%eax
     d96:	3c 2d                	cmp    $0x2d,%al
     d98:	74 47                	je     de1 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9d:	83 c0 01             	add    $0x1,%eax
     da0:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     da3:	3c 2d                	cmp    $0x2d,%al
     da5:	75 3a                	jne    de1 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     da7:	8b 45 0c             	mov    0xc(%ebp),%eax
     daa:	83 c0 01             	add    $0x1,%eax
     dad:	0f b6 00             	movzbl (%eax),%eax
     db0:	84 c0                	test   %al,%al
     db2:	74 2d                	je     de1 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     db4:	8b 45 0c             	mov    0xc(%ebp),%eax
     db7:	83 c0 02             	add    $0x2,%eax
     dba:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     dbd:	84 c0                	test   %al,%al
     dbf:	74 20                	je     de1 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc4:	0f b6 00             	movzbl (%eax),%eax
     dc7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dca:	7f 15                	jg     de1 <matchrange+0x6d>
     dcc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcf:	83 c0 02             	add    $0x2,%eax
     dd2:	0f b6 00             	movzbl (%eax),%eax
     dd5:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dd8:	7c 07                	jl     de1 <matchrange+0x6d>
     dda:	b8 01 00 00 00       	mov    $0x1,%eax
     ddf:	eb 05                	jmp    de6 <matchrange+0x72>
     de1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     de6:	c9                   	leave  
     de7:	c3                   	ret    

00000de8 <ismetachar>:
static int ismetachar(char c)
{
     de8:	55                   	push   %ebp
     de9:	89 e5                	mov    %esp,%ebp
     deb:	83 ec 04             	sub    $0x4,%esp
     dee:	8b 45 08             	mov    0x8(%ebp),%eax
     df1:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     df4:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     df8:	74 1e                	je     e18 <ismetachar+0x30>
     dfa:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     dfe:	74 18                	je     e18 <ismetachar+0x30>
     e00:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     e04:	74 12                	je     e18 <ismetachar+0x30>
     e06:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     e0a:	74 0c                	je     e18 <ismetachar+0x30>
     e0c:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     e10:	74 06                	je     e18 <ismetachar+0x30>
     e12:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     e16:	75 07                	jne    e1f <ismetachar+0x37>
     e18:	b8 01 00 00 00       	mov    $0x1,%eax
     e1d:	eb 05                	jmp    e24 <ismetachar+0x3c>
     e1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e24:	c9                   	leave  
     e25:	c3                   	ret    

00000e26 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     e26:	55                   	push   %ebp
     e27:	89 e5                	mov    %esp,%ebp
     e29:	83 ec 04             	sub    $0x4,%esp
     e2c:	8b 45 08             	mov    0x8(%ebp),%eax
     e2f:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     e32:	8b 45 0c             	mov    0xc(%ebp),%eax
     e35:	0f b6 00             	movzbl (%eax),%eax
     e38:	0f be c0             	movsbl %al,%eax
     e3b:	83 e8 44             	sub    $0x44,%eax
     e3e:	83 f8 33             	cmp    $0x33,%eax
     e41:	77 7b                	ja     ebe <matchmetachar+0x98>
     e43:	8b 04 85 54 15 00 00 	mov    0x1554(,%eax,4),%eax
     e4a:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     e4c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e50:	50                   	push   %eax
     e51:	e8 46 fe ff ff       	call   c9c <matchdigit>
     e56:	83 c4 04             	add    $0x4,%esp
     e59:	eb 72                	jmp    ecd <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     e5b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e5f:	50                   	push   %eax
     e60:	e8 37 fe ff ff       	call   c9c <matchdigit>
     e65:	83 c4 04             	add    $0x4,%esp
     e68:	85 c0                	test   %eax,%eax
     e6a:	0f 94 c0             	sete   %al
     e6d:	0f b6 c0             	movzbl %al,%eax
     e70:	eb 5b                	jmp    ecd <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     e72:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e76:	50                   	push   %eax
     e77:	e8 b6 fe ff ff       	call   d32 <matchalphanum>
     e7c:	83 c4 04             	add    $0x4,%esp
     e7f:	eb 4c                	jmp    ecd <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     e81:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e85:	50                   	push   %eax
     e86:	e8 a7 fe ff ff       	call   d32 <matchalphanum>
     e8b:	83 c4 04             	add    $0x4,%esp
     e8e:	85 c0                	test   %eax,%eax
     e90:	0f 94 c0             	sete   %al
     e93:	0f b6 c0             	movzbl %al,%eax
     e96:	eb 35                	jmp    ecd <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     e98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e9c:	50                   	push   %eax
     e9d:	e8 52 fe ff ff       	call   cf4 <matchwhitespace>
     ea2:	83 c4 04             	add    $0x4,%esp
     ea5:	eb 26                	jmp    ecd <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     ea7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eab:	50                   	push   %eax
     eac:	e8 43 fe ff ff       	call   cf4 <matchwhitespace>
     eb1:	83 c4 04             	add    $0x4,%esp
     eb4:	85 c0                	test   %eax,%eax
     eb6:	0f 94 c0             	sete   %al
     eb9:	0f b6 c0             	movzbl %al,%eax
     ebc:	eb 0f                	jmp    ecd <matchmetachar+0xa7>
    default:  return (c == str[0]);
     ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec1:	0f b6 00             	movzbl (%eax),%eax
     ec4:	3a 45 fc             	cmp    -0x4(%ebp),%al
     ec7:	0f 94 c0             	sete   %al
     eca:	0f b6 c0             	movzbl %al,%eax
  }
}
     ecd:	c9                   	leave  
     ece:	c3                   	ret    

00000ecf <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     ecf:	55                   	push   %ebp
     ed0:	89 e5                	mov    %esp,%ebp
     ed2:	83 ec 04             	sub    $0x4,%esp
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     edb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     edf:	ff 75 0c             	pushl  0xc(%ebp)
     ee2:	50                   	push   %eax
     ee3:	e8 8c fe ff ff       	call   d74 <matchrange>
     ee8:	83 c4 08             	add    $0x8,%esp
     eeb:	85 c0                	test   %eax,%eax
     eed:	74 0a                	je     ef9 <matchcharclass+0x2a>
    {
      return 1;
     eef:	b8 01 00 00 00       	mov    $0x1,%eax
     ef4:	e9 a5 00 00 00       	jmp    f9e <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
     efc:	0f b6 00             	movzbl (%eax),%eax
     eff:	3c 5c                	cmp    $0x5c,%al
     f01:	75 42                	jne    f45 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     f03:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     f07:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f0b:	ff 75 0c             	pushl  0xc(%ebp)
     f0e:	50                   	push   %eax
     f0f:	e8 12 ff ff ff       	call   e26 <matchmetachar>
     f14:	83 c4 08             	add    $0x8,%esp
     f17:	85 c0                	test   %eax,%eax
     f19:	74 07                	je     f22 <matchcharclass+0x53>
      {
        return 1;
     f1b:	b8 01 00 00 00       	mov    $0x1,%eax
     f20:	eb 7c                	jmp    f9e <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	0f b6 00             	movzbl (%eax),%eax
     f28:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f2b:	75 58                	jne    f85 <matchcharclass+0xb6>
     f2d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f31:	50                   	push   %eax
     f32:	e8 b1 fe ff ff       	call   de8 <ismetachar>
     f37:	83 c4 04             	add    $0x4,%esp
     f3a:	85 c0                	test   %eax,%eax
     f3c:	75 47                	jne    f85 <matchcharclass+0xb6>
      {
        return 1;
     f3e:	b8 01 00 00 00       	mov    $0x1,%eax
     f43:	eb 59                	jmp    f9e <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     f45:	8b 45 0c             	mov    0xc(%ebp),%eax
     f48:	0f b6 00             	movzbl (%eax),%eax
     f4b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f4e:	75 35                	jne    f85 <matchcharclass+0xb6>
    {
      if (c == '-')
     f50:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     f54:	75 28                	jne    f7e <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     f56:	8b 45 0c             	mov    0xc(%ebp),%eax
     f59:	83 e8 01             	sub    $0x1,%eax
     f5c:	0f b6 00             	movzbl (%eax),%eax
     f5f:	84 c0                	test   %al,%al
     f61:	74 0d                	je     f70 <matchcharclass+0xa1>
     f63:	8b 45 0c             	mov    0xc(%ebp),%eax
     f66:	83 c0 01             	add    $0x1,%eax
     f69:	0f b6 00             	movzbl (%eax),%eax
     f6c:	84 c0                	test   %al,%al
     f6e:	75 07                	jne    f77 <matchcharclass+0xa8>
     f70:	b8 01 00 00 00       	mov    $0x1,%eax
     f75:	eb 27                	jmp    f9e <matchcharclass+0xcf>
     f77:	b8 00 00 00 00       	mov    $0x0,%eax
     f7c:	eb 20                	jmp    f9e <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     f7e:	b8 01 00 00 00       	mov    $0x1,%eax
     f83:	eb 19                	jmp    f9e <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     f85:	8b 45 0c             	mov    0xc(%ebp),%eax
     f88:	8d 50 01             	lea    0x1(%eax),%edx
     f8b:	89 55 0c             	mov    %edx,0xc(%ebp)
     f8e:	0f b6 00             	movzbl (%eax),%eax
     f91:	84 c0                	test   %al,%al
     f93:	0f 85 42 ff ff ff    	jne    edb <matchcharclass+0xc>

  return 0;
     f99:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f9e:	c9                   	leave  
     f9f:	c3                   	ret    

00000fa0 <matchone>:

static int matchone(regex_t p, char c)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	83 ec 04             	sub    $0x4,%esp
     fa6:	8b 45 10             	mov    0x10(%ebp),%eax
     fa9:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     fac:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     fb0:	0f b6 c0             	movzbl %al,%eax
     fb3:	83 f8 0f             	cmp    $0xf,%eax
     fb6:	0f 87 b9 00 00 00    	ja     1075 <matchone+0xd5>
     fbc:	8b 04 85 24 16 00 00 	mov    0x1624(,%eax,4),%eax
     fc3:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     fc5:	b8 01 00 00 00       	mov    $0x1,%eax
     fca:	e9 b9 00 00 00       	jmp    1088 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     fcf:	8b 55 0c             	mov    0xc(%ebp),%edx
     fd2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fd6:	52                   	push   %edx
     fd7:	50                   	push   %eax
     fd8:	e8 f2 fe ff ff       	call   ecf <matchcharclass>
     fdd:	83 c4 08             	add    $0x8,%esp
     fe0:	e9 a3 00 00 00       	jmp    1088 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     fe5:	8b 55 0c             	mov    0xc(%ebp),%edx
     fe8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fec:	52                   	push   %edx
     fed:	50                   	push   %eax
     fee:	e8 dc fe ff ff       	call   ecf <matchcharclass>
     ff3:	83 c4 08             	add    $0x8,%esp
     ff6:	85 c0                	test   %eax,%eax
     ff8:	0f 94 c0             	sete   %al
     ffb:	0f b6 c0             	movzbl %al,%eax
     ffe:	e9 85 00 00 00       	jmp    1088 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    1003:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1007:	50                   	push   %eax
    1008:	e8 8f fc ff ff       	call   c9c <matchdigit>
    100d:	83 c4 04             	add    $0x4,%esp
    1010:	eb 76                	jmp    1088 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    1012:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1016:	50                   	push   %eax
    1017:	e8 80 fc ff ff       	call   c9c <matchdigit>
    101c:	83 c4 04             	add    $0x4,%esp
    101f:	85 c0                	test   %eax,%eax
    1021:	0f 94 c0             	sete   %al
    1024:	0f b6 c0             	movzbl %al,%eax
    1027:	eb 5f                	jmp    1088 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    1029:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    102d:	50                   	push   %eax
    102e:	e8 ff fc ff ff       	call   d32 <matchalphanum>
    1033:	83 c4 04             	add    $0x4,%esp
    1036:	eb 50                	jmp    1088 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    1038:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    103c:	50                   	push   %eax
    103d:	e8 f0 fc ff ff       	call   d32 <matchalphanum>
    1042:	83 c4 04             	add    $0x4,%esp
    1045:	85 c0                	test   %eax,%eax
    1047:	0f 94 c0             	sete   %al
    104a:	0f b6 c0             	movzbl %al,%eax
    104d:	eb 39                	jmp    1088 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    104f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1053:	50                   	push   %eax
    1054:	e8 9b fc ff ff       	call   cf4 <matchwhitespace>
    1059:	83 c4 04             	add    $0x4,%esp
    105c:	eb 2a                	jmp    1088 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    105e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1062:	50                   	push   %eax
    1063:	e8 8c fc ff ff       	call   cf4 <matchwhitespace>
    1068:	83 c4 04             	add    $0x4,%esp
    106b:	85 c0                	test   %eax,%eax
    106d:	0f 94 c0             	sete   %al
    1070:	0f b6 c0             	movzbl %al,%eax
    1073:	eb 13                	jmp    1088 <matchone+0xe8>
    default:             return  (p.ch == c);
    1075:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    1079:	0f b6 d0             	movzbl %al,%edx
    107c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1080:	39 c2                	cmp    %eax,%edx
    1082:	0f 94 c0             	sete   %al
    1085:	0f b6 c0             	movzbl %al,%eax
  }
}
    1088:	c9                   	leave  
    1089:	c3                   	ret    

0000108a <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    108a:	55                   	push   %ebp
    108b:	89 e5                	mov    %esp,%ebp
    108d:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    1090:	8b 45 18             	mov    0x18(%ebp),%eax
    1093:	8b 00                	mov    (%eax),%eax
    1095:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1098:	8b 45 14             	mov    0x14(%ebp),%eax
    109b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    109e:	eb 11                	jmp    10b1 <matchstar+0x27>
  {
    text++;
    10a0:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    10a4:	8b 45 18             	mov    0x18(%ebp),%eax
    10a7:	8b 00                	mov    (%eax),%eax
    10a9:	8d 50 01             	lea    0x1(%eax),%edx
    10ac:	8b 45 18             	mov    0x18(%ebp),%eax
    10af:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    10b1:	8b 45 14             	mov    0x14(%ebp),%eax
    10b4:	0f b6 00             	movzbl (%eax),%eax
    10b7:	84 c0                	test   %al,%al
    10b9:	74 51                	je     110c <matchstar+0x82>
    10bb:	8b 45 14             	mov    0x14(%ebp),%eax
    10be:	0f b6 00             	movzbl (%eax),%eax
    10c1:	0f be c0             	movsbl %al,%eax
    10c4:	50                   	push   %eax
    10c5:	ff 75 0c             	pushl  0xc(%ebp)
    10c8:	ff 75 08             	pushl  0x8(%ebp)
    10cb:	e8 d0 fe ff ff       	call   fa0 <matchone>
    10d0:	83 c4 0c             	add    $0xc,%esp
    10d3:	85 c0                	test   %eax,%eax
    10d5:	75 c9                	jne    10a0 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    10d7:	eb 33                	jmp    110c <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    10d9:	8b 45 14             	mov    0x14(%ebp),%eax
    10dc:	8d 50 ff             	lea    -0x1(%eax),%edx
    10df:	89 55 14             	mov    %edx,0x14(%ebp)
    10e2:	83 ec 04             	sub    $0x4,%esp
    10e5:	ff 75 18             	pushl  0x18(%ebp)
    10e8:	50                   	push   %eax
    10e9:	ff 75 10             	pushl  0x10(%ebp)
    10ec:	e8 51 01 00 00       	call   1242 <matchpattern>
    10f1:	83 c4 10             	add    $0x10,%esp
    10f4:	85 c0                	test   %eax,%eax
    10f6:	74 07                	je     10ff <matchstar+0x75>
      return 1;
    10f8:	b8 01 00 00 00       	mov    $0x1,%eax
    10fd:	eb 22                	jmp    1121 <matchstar+0x97>
    (*matchlength)--;
    10ff:	8b 45 18             	mov    0x18(%ebp),%eax
    1102:	8b 00                	mov    (%eax),%eax
    1104:	8d 50 ff             	lea    -0x1(%eax),%edx
    1107:	8b 45 18             	mov    0x18(%ebp),%eax
    110a:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    110c:	8b 45 14             	mov    0x14(%ebp),%eax
    110f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1112:	73 c5                	jae    10d9 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1114:	8b 45 18             	mov    0x18(%ebp),%eax
    1117:	8b 55 f4             	mov    -0xc(%ebp),%edx
    111a:	89 10                	mov    %edx,(%eax)
  return 0;
    111c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1121:	c9                   	leave  
    1122:	c3                   	ret    

00001123 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1123:	55                   	push   %ebp
    1124:	89 e5                	mov    %esp,%ebp
    1126:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1129:	8b 45 14             	mov    0x14(%ebp),%eax
    112c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    112f:	eb 11                	jmp    1142 <matchplus+0x1f>
  {
    text++;
    1131:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1135:	8b 45 18             	mov    0x18(%ebp),%eax
    1138:	8b 00                	mov    (%eax),%eax
    113a:	8d 50 01             	lea    0x1(%eax),%edx
    113d:	8b 45 18             	mov    0x18(%ebp),%eax
    1140:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1142:	8b 45 14             	mov    0x14(%ebp),%eax
    1145:	0f b6 00             	movzbl (%eax),%eax
    1148:	84 c0                	test   %al,%al
    114a:	74 51                	je     119d <matchplus+0x7a>
    114c:	8b 45 14             	mov    0x14(%ebp),%eax
    114f:	0f b6 00             	movzbl (%eax),%eax
    1152:	0f be c0             	movsbl %al,%eax
    1155:	50                   	push   %eax
    1156:	ff 75 0c             	pushl  0xc(%ebp)
    1159:	ff 75 08             	pushl  0x8(%ebp)
    115c:	e8 3f fe ff ff       	call   fa0 <matchone>
    1161:	83 c4 0c             	add    $0xc,%esp
    1164:	85 c0                	test   %eax,%eax
    1166:	75 c9                	jne    1131 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1168:	eb 33                	jmp    119d <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    116a:	8b 45 14             	mov    0x14(%ebp),%eax
    116d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1170:	89 55 14             	mov    %edx,0x14(%ebp)
    1173:	83 ec 04             	sub    $0x4,%esp
    1176:	ff 75 18             	pushl  0x18(%ebp)
    1179:	50                   	push   %eax
    117a:	ff 75 10             	pushl  0x10(%ebp)
    117d:	e8 c0 00 00 00       	call   1242 <matchpattern>
    1182:	83 c4 10             	add    $0x10,%esp
    1185:	85 c0                	test   %eax,%eax
    1187:	74 07                	je     1190 <matchplus+0x6d>
      return 1;
    1189:	b8 01 00 00 00       	mov    $0x1,%eax
    118e:	eb 1a                	jmp    11aa <matchplus+0x87>
    (*matchlength)--;
    1190:	8b 45 18             	mov    0x18(%ebp),%eax
    1193:	8b 00                	mov    (%eax),%eax
    1195:	8d 50 ff             	lea    -0x1(%eax),%edx
    1198:	8b 45 18             	mov    0x18(%ebp),%eax
    119b:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    119d:	8b 45 14             	mov    0x14(%ebp),%eax
    11a0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a3:	77 c5                	ja     116a <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    11a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11aa:	c9                   	leave  
    11ab:	c3                   	ret    

000011ac <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    11ac:	55                   	push   %ebp
    11ad:	89 e5                	mov    %esp,%ebp
    11af:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    11b2:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    11b6:	84 c0                	test   %al,%al
    11b8:	75 07                	jne    11c1 <matchquestion+0x15>
    return 1;
    11ba:	b8 01 00 00 00       	mov    $0x1,%eax
    11bf:	eb 7f                	jmp    1240 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    11c1:	83 ec 04             	sub    $0x4,%esp
    11c4:	ff 75 18             	pushl  0x18(%ebp)
    11c7:	ff 75 14             	pushl  0x14(%ebp)
    11ca:	ff 75 10             	pushl  0x10(%ebp)
    11cd:	e8 70 00 00 00       	call   1242 <matchpattern>
    11d2:	83 c4 10             	add    $0x10,%esp
    11d5:	85 c0                	test   %eax,%eax
    11d7:	74 07                	je     11e0 <matchquestion+0x34>
      return 1;
    11d9:	b8 01 00 00 00       	mov    $0x1,%eax
    11de:	eb 60                	jmp    1240 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    11e0:	8b 45 14             	mov    0x14(%ebp),%eax
    11e3:	0f b6 00             	movzbl (%eax),%eax
    11e6:	84 c0                	test   %al,%al
    11e8:	74 51                	je     123b <matchquestion+0x8f>
    11ea:	8b 45 14             	mov    0x14(%ebp),%eax
    11ed:	8d 50 01             	lea    0x1(%eax),%edx
    11f0:	89 55 14             	mov    %edx,0x14(%ebp)
    11f3:	0f b6 00             	movzbl (%eax),%eax
    11f6:	0f be c0             	movsbl %al,%eax
    11f9:	83 ec 04             	sub    $0x4,%esp
    11fc:	50                   	push   %eax
    11fd:	ff 75 0c             	pushl  0xc(%ebp)
    1200:	ff 75 08             	pushl  0x8(%ebp)
    1203:	e8 98 fd ff ff       	call   fa0 <matchone>
    1208:	83 c4 10             	add    $0x10,%esp
    120b:	85 c0                	test   %eax,%eax
    120d:	74 2c                	je     123b <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    120f:	83 ec 04             	sub    $0x4,%esp
    1212:	ff 75 18             	pushl  0x18(%ebp)
    1215:	ff 75 14             	pushl  0x14(%ebp)
    1218:	ff 75 10             	pushl  0x10(%ebp)
    121b:	e8 22 00 00 00       	call   1242 <matchpattern>
    1220:	83 c4 10             	add    $0x10,%esp
    1223:	85 c0                	test   %eax,%eax
    1225:	74 14                	je     123b <matchquestion+0x8f>
    {
      (*matchlength)++;
    1227:	8b 45 18             	mov    0x18(%ebp),%eax
    122a:	8b 00                	mov    (%eax),%eax
    122c:	8d 50 01             	lea    0x1(%eax),%edx
    122f:	8b 45 18             	mov    0x18(%ebp),%eax
    1232:	89 10                	mov    %edx,(%eax)
      return 1;
    1234:	b8 01 00 00 00       	mov    $0x1,%eax
    1239:	eb 05                	jmp    1240 <matchquestion+0x94>
    }
  }
  return 0;
    123b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1240:	c9                   	leave  
    1241:	c3                   	ret    

00001242 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1242:	55                   	push   %ebp
    1243:	89 e5                	mov    %esp,%ebp
    1245:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1248:	8b 45 10             	mov    0x10(%ebp),%eax
    124b:	8b 00                	mov    (%eax),%eax
    124d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	0f b6 00             	movzbl (%eax),%eax
    1256:	84 c0                	test   %al,%al
    1258:	74 0d                	je     1267 <matchpattern+0x25>
    125a:	8b 45 08             	mov    0x8(%ebp),%eax
    125d:	83 c0 08             	add    $0x8,%eax
    1260:	0f b6 00             	movzbl (%eax),%eax
    1263:	3c 04                	cmp    $0x4,%al
    1265:	75 25                	jne    128c <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1267:	8b 45 08             	mov    0x8(%ebp),%eax
    126a:	83 c0 10             	add    $0x10,%eax
    126d:	83 ec 0c             	sub    $0xc,%esp
    1270:	ff 75 10             	pushl  0x10(%ebp)
    1273:	ff 75 0c             	pushl  0xc(%ebp)
    1276:	50                   	push   %eax
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	ff 70 04             	pushl  0x4(%eax)
    127d:	ff 30                	pushl  (%eax)
    127f:	e8 28 ff ff ff       	call   11ac <matchquestion>
    1284:	83 c4 20             	add    $0x20,%esp
    1287:	e9 dd 00 00 00       	jmp    1369 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    128c:	8b 45 08             	mov    0x8(%ebp),%eax
    128f:	83 c0 08             	add    $0x8,%eax
    1292:	0f b6 00             	movzbl (%eax),%eax
    1295:	3c 05                	cmp    $0x5,%al
    1297:	75 25                	jne    12be <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1299:	8b 45 08             	mov    0x8(%ebp),%eax
    129c:	83 c0 10             	add    $0x10,%eax
    129f:	83 ec 0c             	sub    $0xc,%esp
    12a2:	ff 75 10             	pushl  0x10(%ebp)
    12a5:	ff 75 0c             	pushl  0xc(%ebp)
    12a8:	50                   	push   %eax
    12a9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ac:	ff 70 04             	pushl  0x4(%eax)
    12af:	ff 30                	pushl  (%eax)
    12b1:	e8 d4 fd ff ff       	call   108a <matchstar>
    12b6:	83 c4 20             	add    $0x20,%esp
    12b9:	e9 ab 00 00 00       	jmp    1369 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	83 c0 08             	add    $0x8,%eax
    12c4:	0f b6 00             	movzbl (%eax),%eax
    12c7:	3c 06                	cmp    $0x6,%al
    12c9:	75 22                	jne    12ed <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    12cb:	8b 45 08             	mov    0x8(%ebp),%eax
    12ce:	83 c0 10             	add    $0x10,%eax
    12d1:	83 ec 0c             	sub    $0xc,%esp
    12d4:	ff 75 10             	pushl  0x10(%ebp)
    12d7:	ff 75 0c             	pushl  0xc(%ebp)
    12da:	50                   	push   %eax
    12db:	8b 45 08             	mov    0x8(%ebp),%eax
    12de:	ff 70 04             	pushl  0x4(%eax)
    12e1:	ff 30                	pushl  (%eax)
    12e3:	e8 3b fe ff ff       	call   1123 <matchplus>
    12e8:	83 c4 20             	add    $0x20,%esp
    12eb:	eb 7c                	jmp    1369 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	0f b6 00             	movzbl (%eax),%eax
    12f3:	3c 03                	cmp    $0x3,%al
    12f5:	75 1d                	jne    1314 <matchpattern+0xd2>
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	83 c0 08             	add    $0x8,%eax
    12fd:	0f b6 00             	movzbl (%eax),%eax
    1300:	84 c0                	test   %al,%al
    1302:	75 10                	jne    1314 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1304:	8b 45 0c             	mov    0xc(%ebp),%eax
    1307:	0f b6 00             	movzbl (%eax),%eax
    130a:	84 c0                	test   %al,%al
    130c:	0f 94 c0             	sete   %al
    130f:	0f b6 c0             	movzbl %al,%eax
    1312:	eb 55                	jmp    1369 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1314:	8b 45 10             	mov    0x10(%ebp),%eax
    1317:	8b 00                	mov    (%eax),%eax
    1319:	8d 50 01             	lea    0x1(%eax),%edx
    131c:	8b 45 10             	mov    0x10(%ebp),%eax
    131f:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1321:	8b 45 0c             	mov    0xc(%ebp),%eax
    1324:	0f b6 00             	movzbl (%eax),%eax
    1327:	84 c0                	test   %al,%al
    1329:	74 31                	je     135c <matchpattern+0x11a>
    132b:	8b 45 0c             	mov    0xc(%ebp),%eax
    132e:	8d 50 01             	lea    0x1(%eax),%edx
    1331:	89 55 0c             	mov    %edx,0xc(%ebp)
    1334:	0f b6 00             	movzbl (%eax),%eax
    1337:	0f be d0             	movsbl %al,%edx
    133a:	8b 45 08             	mov    0x8(%ebp),%eax
    133d:	8d 48 08             	lea    0x8(%eax),%ecx
    1340:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1343:	83 ec 04             	sub    $0x4,%esp
    1346:	52                   	push   %edx
    1347:	ff 70 04             	pushl  0x4(%eax)
    134a:	ff 30                	pushl  (%eax)
    134c:	e8 4f fc ff ff       	call   fa0 <matchone>
    1351:	83 c4 10             	add    $0x10,%esp
    1354:	85 c0                	test   %eax,%eax
    1356:	0f 85 f4 fe ff ff    	jne    1250 <matchpattern+0xe>

  *matchlength = pre;
    135c:	8b 45 10             	mov    0x10(%ebp),%eax
    135f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1362:	89 10                	mov    %edx,(%eax)
  return 0;
    1364:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1369:	c9                   	leave  
    136a:	c3                   	ret    
