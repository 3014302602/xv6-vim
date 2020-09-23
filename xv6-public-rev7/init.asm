
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
      11:	83 ec 08             	sub    $0x8,%esp
      14:	6a 02                	push   $0x2
      16:	68 1f 13 00 00       	push   $0x131f
      1b:	e8 78 03 00 00       	call   398 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 1f 13 00 00       	push   $0x131f
      33:	e8 68 03 00 00       	call   3a0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 1f 13 00 00       	push   $0x131f
      45:	e8 4e 03 00 00       	call   398 <open>
      4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
      4d:	83 ec 0c             	sub    $0xc,%esp
      50:	6a 00                	push   $0x0
      52:	e8 79 03 00 00       	call   3d0 <dup>
      57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
      5a:	83 ec 0c             	sub    $0xc,%esp
      5d:	6a 00                	push   $0x0
      5f:	e8 6c 03 00 00       	call   3d0 <dup>
      64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 27 13 00 00       	push   $0x1327
      6f:	6a 01                	push   $0x1
      71:	e8 b9 04 00 00       	call   52f <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 d2 02 00 00       	call   350 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 3a 13 00 00       	push   $0x133a
      8f:	6a 01                	push   $0x1
      91:	e8 99 04 00 00       	call   52f <printf>
      96:	83 c4 10             	add    $0x10,%esp
      exit();
      99:	e8 ba 02 00 00       	call   358 <exit>
    }
    if(pid == 0){
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 88 1a 00 00       	push   $0x1a88
      ac:	68 1c 13 00 00       	push   $0x131c
      b1:	e8 da 02 00 00       	call   390 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 4d 13 00 00       	push   $0x134d
      c1:	6a 01                	push   $0x1
      c3:	e8 67 04 00 00       	call   52f <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 88 02 00 00       	call   358 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 63 13 00 00       	push   $0x1363
      d8:	6a 01                	push   $0x1
      da:	e8 50 04 00 00       	call   52f <printf>
      df:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      e2:	e8 79 02 00 00       	call   360 <wait>
      e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
      ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
      f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      fa:	75 d4                	jne    d0 <main+0xd0>
      printf(1, "zombie!\n");
  }
      fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     101:	55                   	push   %ebp
     102:	89 e5                	mov    %esp,%ebp
     104:	57                   	push   %edi
     105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     106:	8b 4d 08             	mov    0x8(%ebp),%ecx
     109:	8b 55 10             	mov    0x10(%ebp),%edx
     10c:	8b 45 0c             	mov    0xc(%ebp),%eax
     10f:	89 cb                	mov    %ecx,%ebx
     111:	89 df                	mov    %ebx,%edi
     113:	89 d1                	mov    %edx,%ecx
     115:	fc                   	cld    
     116:	f3 aa                	rep stos %al,%es:(%edi)
     118:	89 ca                	mov    %ecx,%edx
     11a:	89 fb                	mov    %edi,%ebx
     11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     122:	90                   	nop
     123:	5b                   	pop    %ebx
     124:	5f                   	pop    %edi
     125:	5d                   	pop    %ebp
     126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     127:	55                   	push   %ebp
     128:	89 e5                	mov    %esp,%ebp
     12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     12d:	8b 45 08             	mov    0x8(%ebp),%eax
     130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     133:	90                   	nop
     134:	8b 45 08             	mov    0x8(%ebp),%eax
     137:	8d 50 01             	lea    0x1(%eax),%edx
     13a:	89 55 08             	mov    %edx,0x8(%ebp)
     13d:	8b 55 0c             	mov    0xc(%ebp),%edx
     140:	8d 4a 01             	lea    0x1(%edx),%ecx
     143:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     146:	0f b6 12             	movzbl (%edx),%edx
     149:	88 10                	mov    %dl,(%eax)
     14b:	0f b6 00             	movzbl (%eax),%eax
     14e:	84 c0                	test   %al,%al
     150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
     152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     155:	c9                   	leave  
     156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     157:	55                   	push   %ebp
     158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
     15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     164:	8b 45 08             	mov    0x8(%ebp),%eax
     167:	0f b6 00             	movzbl (%eax),%eax
     16a:	84 c0                	test   %al,%al
     16c:	74 10                	je     17e <strcmp+0x27>
     16e:	8b 45 08             	mov    0x8(%ebp),%eax
     171:	0f b6 10             	movzbl (%eax),%edx
     174:	8b 45 0c             	mov    0xc(%ebp),%eax
     177:	0f b6 00             	movzbl (%eax),%eax
     17a:	38 c2                	cmp    %al,%dl
     17c:	74 de                	je     15c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	0f b6 00             	movzbl (%eax),%eax
     184:	0f b6 d0             	movzbl %al,%edx
     187:	8b 45 0c             	mov    0xc(%ebp),%eax
     18a:	0f b6 00             	movzbl (%eax),%eax
     18d:	0f b6 c0             	movzbl %al,%eax
     190:	29 c2                	sub    %eax,%edx
     192:	89 d0                	mov    %edx,%eax
}
     194:	5d                   	pop    %ebp
     195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
     196:	55                   	push   %ebp
     197:	89 e5                	mov    %esp,%ebp
     199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1a3:	eb 04                	jmp    1a9 <strlen+0x13>
     1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ac:	8b 45 08             	mov    0x8(%ebp),%eax
     1af:	01 d0                	add    %edx,%eax
     1b1:	0f b6 00             	movzbl (%eax),%eax
     1b4:	84 c0                	test   %al,%al
     1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
     1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1bb:	c9                   	leave  
     1bc:	c3                   	ret    

000001bd <memset>:

void*
memset(void *dst, int c, uint n)
{
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1c0:	8b 45 10             	mov    0x10(%ebp),%eax
     1c3:	50                   	push   %eax
     1c4:	ff 75 0c             	pushl  0xc(%ebp)
     1c7:	ff 75 08             	pushl  0x8(%ebp)
     1ca:	e8 32 ff ff ff       	call   101 <stosb>
     1cf:	83 c4 0c             	add    $0xc,%esp
  return dst;
     1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1d5:	c9                   	leave  
     1d6:	c3                   	ret    

000001d7 <strchr>:

char*
strchr(const char *s, char c)
{
     1d7:	55                   	push   %ebp
     1d8:	89 e5                	mov    %esp,%ebp
     1da:	83 ec 04             	sub    $0x4,%esp
     1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1e3:	eb 14                	jmp    1f9 <strchr+0x22>
    if(*s == c)
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
     1e8:	0f b6 00             	movzbl (%eax),%eax
     1eb:	3a 45 fc             	cmp    -0x4(%ebp),%al
     1ee:	75 05                	jne    1f5 <strchr+0x1e>
      return (char*)s;
     1f0:	8b 45 08             	mov    0x8(%ebp),%eax
     1f3:	eb 13                	jmp    208 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     1f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1f9:	8b 45 08             	mov    0x8(%ebp),%eax
     1fc:	0f b6 00             	movzbl (%eax),%eax
     1ff:	84 c0                	test   %al,%al
     201:	75 e2                	jne    1e5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     203:	b8 00 00 00 00       	mov    $0x0,%eax
}
     208:	c9                   	leave  
     209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
     20a:	55                   	push   %ebp
     20b:	89 e5                	mov    %esp,%ebp
     20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     217:	eb 42                	jmp    25b <gets+0x51>
    cc = read(0, &c, 1);
     219:	83 ec 04             	sub    $0x4,%esp
     21c:	6a 01                	push   $0x1
     21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     221:	50                   	push   %eax
     222:	6a 00                	push   $0x0
     224:	e8 47 01 00 00       	call   370 <read>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     233:	7e 33                	jle    268 <gets+0x5e>
      break;
    buf[i++] = c;
     235:	8b 45 f4             	mov    -0xc(%ebp),%eax
     238:	8d 50 01             	lea    0x1(%eax),%edx
     23b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     23e:	89 c2                	mov    %eax,%edx
     240:	8b 45 08             	mov    0x8(%ebp),%eax
     243:	01 c2                	add    %eax,%edx
     245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     249:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     24b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     24f:	3c 0a                	cmp    $0xa,%al
     251:	74 16                	je     269 <gets+0x5f>
     253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     257:	3c 0d                	cmp    $0xd,%al
     259:	74 0e                	je     269 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     25e:	83 c0 01             	add    $0x1,%eax
     261:	3b 45 0c             	cmp    0xc(%ebp),%eax
     264:	7c b3                	jl     219 <gets+0xf>
     266:	eb 01                	jmp    269 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     268:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     269:	8b 55 f4             	mov    -0xc(%ebp),%edx
     26c:	8b 45 08             	mov    0x8(%ebp),%eax
     26f:	01 d0                	add    %edx,%eax
     271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     274:	8b 45 08             	mov    0x8(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <stat>:

int
stat(char *n, struct stat *st)
{
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
     27c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     27f:	83 ec 08             	sub    $0x8,%esp
     282:	6a 00                	push   $0x0
     284:	ff 75 08             	pushl  0x8(%ebp)
     287:	e8 0c 01 00 00       	call   398 <open>
     28c:	83 c4 10             	add    $0x10,%esp
     28f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     292:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     296:	79 07                	jns    29f <stat+0x26>
    return -1;
     298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     29d:	eb 25                	jmp    2c4 <stat+0x4b>
  r = fstat(fd, st);
     29f:	83 ec 08             	sub    $0x8,%esp
     2a2:	ff 75 0c             	pushl  0xc(%ebp)
     2a5:	ff 75 f4             	pushl  -0xc(%ebp)
     2a8:	e8 03 01 00 00       	call   3b0 <fstat>
     2ad:	83 c4 10             	add    $0x10,%esp
     2b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2b3:	83 ec 0c             	sub    $0xc,%esp
     2b6:	ff 75 f4             	pushl  -0xc(%ebp)
     2b9:	e8 c2 00 00 00       	call   380 <close>
     2be:	83 c4 10             	add    $0x10,%esp
  return r;
     2c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2c4:	c9                   	leave  
     2c5:	c3                   	ret    

000002c6 <atoi>:

int
atoi(const char *s)
{
     2c6:	55                   	push   %ebp
     2c7:	89 e5                	mov    %esp,%ebp
     2c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2d3:	eb 25                	jmp    2fa <atoi+0x34>
    n = n*10 + *s++ - '0';
     2d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2d8:	89 d0                	mov    %edx,%eax
     2da:	c1 e0 02             	shl    $0x2,%eax
     2dd:	01 d0                	add    %edx,%eax
     2df:	01 c0                	add    %eax,%eax
     2e1:	89 c1                	mov    %eax,%ecx
     2e3:	8b 45 08             	mov    0x8(%ebp),%eax
     2e6:	8d 50 01             	lea    0x1(%eax),%edx
     2e9:	89 55 08             	mov    %edx,0x8(%ebp)
     2ec:	0f b6 00             	movzbl (%eax),%eax
     2ef:	0f be c0             	movsbl %al,%eax
     2f2:	01 c8                	add    %ecx,%eax
     2f4:	83 e8 30             	sub    $0x30,%eax
     2f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     2fa:	8b 45 08             	mov    0x8(%ebp),%eax
     2fd:	0f b6 00             	movzbl (%eax),%eax
     300:	3c 2f                	cmp    $0x2f,%al
     302:	7e 0a                	jle    30e <atoi+0x48>
     304:	8b 45 08             	mov    0x8(%ebp),%eax
     307:	0f b6 00             	movzbl (%eax),%eax
     30a:	3c 39                	cmp    $0x39,%al
     30c:	7e c7                	jle    2d5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     30e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     311:	c9                   	leave  
     312:	c3                   	ret    

00000313 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     313:	55                   	push   %ebp
     314:	89 e5                	mov    %esp,%ebp
     316:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     319:	8b 45 08             	mov    0x8(%ebp),%eax
     31c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     31f:	8b 45 0c             	mov    0xc(%ebp),%eax
     322:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     325:	eb 17                	jmp    33e <memmove+0x2b>
    *dst++ = *src++;
     327:	8b 45 fc             	mov    -0x4(%ebp),%eax
     32a:	8d 50 01             	lea    0x1(%eax),%edx
     32d:	89 55 fc             	mov    %edx,-0x4(%ebp)
     330:	8b 55 f8             	mov    -0x8(%ebp),%edx
     333:	8d 4a 01             	lea    0x1(%edx),%ecx
     336:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     339:	0f b6 12             	movzbl (%edx),%edx
     33c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     33e:	8b 45 10             	mov    0x10(%ebp),%eax
     341:	8d 50 ff             	lea    -0x1(%eax),%edx
     344:	89 55 10             	mov    %edx,0x10(%ebp)
     347:	85 c0                	test   %eax,%eax
     349:	7f dc                	jg     327 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     34e:	c9                   	leave  
     34f:	c3                   	ret    

00000350 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     350:	b8 01 00 00 00       	mov    $0x1,%eax
     355:	cd 40                	int    $0x40
     357:	c3                   	ret    

00000358 <exit>:
SYSCALL(exit)
     358:	b8 02 00 00 00       	mov    $0x2,%eax
     35d:	cd 40                	int    $0x40
     35f:	c3                   	ret    

00000360 <wait>:
SYSCALL(wait)
     360:	b8 03 00 00 00       	mov    $0x3,%eax
     365:	cd 40                	int    $0x40
     367:	c3                   	ret    

00000368 <pipe>:
SYSCALL(pipe)
     368:	b8 04 00 00 00       	mov    $0x4,%eax
     36d:	cd 40                	int    $0x40
     36f:	c3                   	ret    

00000370 <read>:
SYSCALL(read)
     370:	b8 05 00 00 00       	mov    $0x5,%eax
     375:	cd 40                	int    $0x40
     377:	c3                   	ret    

00000378 <write>:
SYSCALL(write)
     378:	b8 10 00 00 00       	mov    $0x10,%eax
     37d:	cd 40                	int    $0x40
     37f:	c3                   	ret    

00000380 <close>:
SYSCALL(close)
     380:	b8 15 00 00 00       	mov    $0x15,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <kill>:
SYSCALL(kill)
     388:	b8 06 00 00 00       	mov    $0x6,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <exec>:
SYSCALL(exec)
     390:	b8 07 00 00 00       	mov    $0x7,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <open>:
SYSCALL(open)
     398:	b8 0f 00 00 00       	mov    $0xf,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <mknod>:
SYSCALL(mknod)
     3a0:	b8 11 00 00 00       	mov    $0x11,%eax
     3a5:	cd 40                	int    $0x40
     3a7:	c3                   	ret    

000003a8 <unlink>:
SYSCALL(unlink)
     3a8:	b8 12 00 00 00       	mov    $0x12,%eax
     3ad:	cd 40                	int    $0x40
     3af:	c3                   	ret    

000003b0 <fstat>:
SYSCALL(fstat)
     3b0:	b8 08 00 00 00       	mov    $0x8,%eax
     3b5:	cd 40                	int    $0x40
     3b7:	c3                   	ret    

000003b8 <link>:
SYSCALL(link)
     3b8:	b8 13 00 00 00       	mov    $0x13,%eax
     3bd:	cd 40                	int    $0x40
     3bf:	c3                   	ret    

000003c0 <mkdir>:
SYSCALL(mkdir)
     3c0:	b8 14 00 00 00       	mov    $0x14,%eax
     3c5:	cd 40                	int    $0x40
     3c7:	c3                   	ret    

000003c8 <chdir>:
SYSCALL(chdir)
     3c8:	b8 09 00 00 00       	mov    $0x9,%eax
     3cd:	cd 40                	int    $0x40
     3cf:	c3                   	ret    

000003d0 <dup>:
SYSCALL(dup)
     3d0:	b8 0a 00 00 00       	mov    $0xa,%eax
     3d5:	cd 40                	int    $0x40
     3d7:	c3                   	ret    

000003d8 <getpid>:
SYSCALL(getpid)
     3d8:	b8 0b 00 00 00       	mov    $0xb,%eax
     3dd:	cd 40                	int    $0x40
     3df:	c3                   	ret    

000003e0 <sbrk>:
SYSCALL(sbrk)
     3e0:	b8 0c 00 00 00       	mov    $0xc,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <sleep>:
SYSCALL(sleep)
     3e8:	b8 0d 00 00 00       	mov    $0xd,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <uptime>:
SYSCALL(uptime)
     3f0:	b8 0e 00 00 00       	mov    $0xe,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     3f8:	b8 16 00 00 00       	mov    $0x16,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     400:	b8 17 00 00 00       	mov    $0x17,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <clearScreen>:
SYSCALL(clearScreen)
     408:	b8 18 00 00 00       	mov    $0x18,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <writeAt>:
SYSCALL(writeAt)
     410:	b8 19 00 00 00       	mov    $0x19,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <setBufferFlag>:
SYSCALL(setBufferFlag)
     418:	b8 1a 00 00 00       	mov    $0x1a,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     420:	b8 1b 00 00 00       	mov    $0x1b,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <getCursorPos>:
SYSCALL(getCursorPos)
     428:	b8 1c 00 00 00       	mov    $0x1c,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <saveScreen>:
SYSCALL(saveScreen)
     430:	b8 1d 00 00 00       	mov    $0x1d,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <recorverScreen>:
SYSCALL(recorverScreen)
     438:	b8 1e 00 00 00       	mov    $0x1e,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <ToScreen>:
SYSCALL(ToScreen)
     440:	b8 1f 00 00 00       	mov    $0x1f,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <getColor>:
SYSCALL(getColor)
     448:	b8 20 00 00 00       	mov    $0x20,%eax
     44d:	cd 40                	int    $0x40
     44f:	c3                   	ret    

00000450 <showC>:
SYSCALL(showC)
     450:	b8 21 00 00 00       	mov    $0x21,%eax
     455:	cd 40                	int    $0x40
     457:	c3                   	ret    

00000458 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     458:	55                   	push   %ebp
     459:	89 e5                	mov    %esp,%ebp
     45b:	83 ec 18             	sub    $0x18,%esp
     45e:	8b 45 0c             	mov    0xc(%ebp),%eax
     461:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     464:	83 ec 04             	sub    $0x4,%esp
     467:	6a 01                	push   $0x1
     469:	8d 45 f4             	lea    -0xc(%ebp),%eax
     46c:	50                   	push   %eax
     46d:	ff 75 08             	pushl  0x8(%ebp)
     470:	e8 03 ff ff ff       	call   378 <write>
     475:	83 c4 10             	add    $0x10,%esp
}
     478:	90                   	nop
     479:	c9                   	leave  
     47a:	c3                   	ret    

0000047b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     47b:	55                   	push   %ebp
     47c:	89 e5                	mov    %esp,%ebp
     47e:	53                   	push   %ebx
     47f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     482:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     489:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     48d:	74 17                	je     4a6 <printint+0x2b>
     48f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     493:	79 11                	jns    4a6 <printint+0x2b>
    neg = 1;
     495:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     49c:	8b 45 0c             	mov    0xc(%ebp),%eax
     49f:	f7 d8                	neg    %eax
     4a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4a4:	eb 06                	jmp    4ac <printint+0x31>
  } else {
    x = xx;
     4a6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4b3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4b6:	8d 41 01             	lea    0x1(%ecx),%eax
     4b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4c2:	ba 00 00 00 00       	mov    $0x0,%edx
     4c7:	f7 f3                	div    %ebx
     4c9:	89 d0                	mov    %edx,%eax
     4cb:	0f b6 80 90 1a 00 00 	movzbl 0x1a90(%eax),%eax
     4d2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4dc:	ba 00 00 00 00       	mov    $0x0,%edx
     4e1:	f7 f3                	div    %ebx
     4e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ea:	75 c7                	jne    4b3 <printint+0x38>
  if(neg)
     4ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4f0:	74 2d                	je     51f <printint+0xa4>
    buf[i++] = '-';
     4f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f5:	8d 50 01             	lea    0x1(%eax),%edx
     4f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4fb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     500:	eb 1d                	jmp    51f <printint+0xa4>
    putc(fd, buf[i]);
     502:	8d 55 dc             	lea    -0x24(%ebp),%edx
     505:	8b 45 f4             	mov    -0xc(%ebp),%eax
     508:	01 d0                	add    %edx,%eax
     50a:	0f b6 00             	movzbl (%eax),%eax
     50d:	0f be c0             	movsbl %al,%eax
     510:	83 ec 08             	sub    $0x8,%esp
     513:	50                   	push   %eax
     514:	ff 75 08             	pushl  0x8(%ebp)
     517:	e8 3c ff ff ff       	call   458 <putc>
     51c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     51f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     523:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     527:	79 d9                	jns    502 <printint+0x87>
    putc(fd, buf[i]);
}
     529:	90                   	nop
     52a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     52d:	c9                   	leave  
     52e:	c3                   	ret    

0000052f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     52f:	55                   	push   %ebp
     530:	89 e5                	mov    %esp,%ebp
     532:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     535:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     53c:	8d 45 0c             	lea    0xc(%ebp),%eax
     53f:	83 c0 04             	add    $0x4,%eax
     542:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     545:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     54c:	e9 59 01 00 00       	jmp    6aa <printf+0x17b>
    c = fmt[i] & 0xff;
     551:	8b 55 0c             	mov    0xc(%ebp),%edx
     554:	8b 45 f0             	mov    -0x10(%ebp),%eax
     557:	01 d0                	add    %edx,%eax
     559:	0f b6 00             	movzbl (%eax),%eax
     55c:	0f be c0             	movsbl %al,%eax
     55f:	25 ff 00 00 00       	and    $0xff,%eax
     564:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     567:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     56b:	75 2c                	jne    599 <printf+0x6a>
      if(c == '%'){
     56d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     571:	75 0c                	jne    57f <printf+0x50>
        state = '%';
     573:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     57a:	e9 27 01 00 00       	jmp    6a6 <printf+0x177>
      } else {
        putc(fd, c);
     57f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     582:	0f be c0             	movsbl %al,%eax
     585:	83 ec 08             	sub    $0x8,%esp
     588:	50                   	push   %eax
     589:	ff 75 08             	pushl  0x8(%ebp)
     58c:	e8 c7 fe ff ff       	call   458 <putc>
     591:	83 c4 10             	add    $0x10,%esp
     594:	e9 0d 01 00 00       	jmp    6a6 <printf+0x177>
      }
    } else if(state == '%'){
     599:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     59d:	0f 85 03 01 00 00    	jne    6a6 <printf+0x177>
      if(c == 'd'){
     5a3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5a7:	75 1e                	jne    5c7 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ac:	8b 00                	mov    (%eax),%eax
     5ae:	6a 01                	push   $0x1
     5b0:	6a 0a                	push   $0xa
     5b2:	50                   	push   %eax
     5b3:	ff 75 08             	pushl  0x8(%ebp)
     5b6:	e8 c0 fe ff ff       	call   47b <printint>
     5bb:	83 c4 10             	add    $0x10,%esp
        ap++;
     5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c2:	e9 d8 00 00 00       	jmp    69f <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5c7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5cb:	74 06                	je     5d3 <printf+0xa4>
     5cd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5d1:	75 1e                	jne    5f1 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d6:	8b 00                	mov    (%eax),%eax
     5d8:	6a 00                	push   $0x0
     5da:	6a 10                	push   $0x10
     5dc:	50                   	push   %eax
     5dd:	ff 75 08             	pushl  0x8(%ebp)
     5e0:	e8 96 fe ff ff       	call   47b <printint>
     5e5:	83 c4 10             	add    $0x10,%esp
        ap++;
     5e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ec:	e9 ae 00 00 00       	jmp    69f <printf+0x170>
      } else if(c == 's'){
     5f1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5f5:	75 43                	jne    63a <printf+0x10b>
        s = (char*)*ap;
     5f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5fa:	8b 00                	mov    (%eax),%eax
     5fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     603:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     607:	75 25                	jne    62e <printf+0xff>
          s = "(null)";
     609:	c7 45 f4 6c 13 00 00 	movl   $0x136c,-0xc(%ebp)
        while(*s != 0){
     610:	eb 1c                	jmp    62e <printf+0xff>
          putc(fd, *s);
     612:	8b 45 f4             	mov    -0xc(%ebp),%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	ff 75 08             	pushl  0x8(%ebp)
     622:	e8 31 fe ff ff       	call   458 <putc>
     627:	83 c4 10             	add    $0x10,%esp
          s++;
     62a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     62e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     631:	0f b6 00             	movzbl (%eax),%eax
     634:	84 c0                	test   %al,%al
     636:	75 da                	jne    612 <printf+0xe3>
     638:	eb 65                	jmp    69f <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     63a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     63e:	75 1d                	jne    65d <printf+0x12e>
        putc(fd, *ap);
     640:	8b 45 e8             	mov    -0x18(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	0f be c0             	movsbl %al,%eax
     648:	83 ec 08             	sub    $0x8,%esp
     64b:	50                   	push   %eax
     64c:	ff 75 08             	pushl  0x8(%ebp)
     64f:	e8 04 fe ff ff       	call   458 <putc>
     654:	83 c4 10             	add    $0x10,%esp
        ap++;
     657:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     65b:	eb 42                	jmp    69f <printf+0x170>
      } else if(c == '%'){
     65d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     661:	75 17                	jne    67a <printf+0x14b>
        putc(fd, c);
     663:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     666:	0f be c0             	movsbl %al,%eax
     669:	83 ec 08             	sub    $0x8,%esp
     66c:	50                   	push   %eax
     66d:	ff 75 08             	pushl  0x8(%ebp)
     670:	e8 e3 fd ff ff       	call   458 <putc>
     675:	83 c4 10             	add    $0x10,%esp
     678:	eb 25                	jmp    69f <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     67a:	83 ec 08             	sub    $0x8,%esp
     67d:	6a 25                	push   $0x25
     67f:	ff 75 08             	pushl  0x8(%ebp)
     682:	e8 d1 fd ff ff       	call   458 <putc>
     687:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     68a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     68d:	0f be c0             	movsbl %al,%eax
     690:	83 ec 08             	sub    $0x8,%esp
     693:	50                   	push   %eax
     694:	ff 75 08             	pushl  0x8(%ebp)
     697:	e8 bc fd ff ff       	call   458 <putc>
     69c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     69f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6aa:	8b 55 0c             	mov    0xc(%ebp),%edx
     6ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6b0:	01 d0                	add    %edx,%eax
     6b2:	0f b6 00             	movzbl (%eax),%eax
     6b5:	84 c0                	test   %al,%al
     6b7:	0f 85 94 fe ff ff    	jne    551 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6bd:	90                   	nop
     6be:	c9                   	leave  
     6bf:	c3                   	ret    

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6c6:	8b 45 08             	mov    0x8(%ebp),%eax
     6c9:	83 e8 08             	sub    $0x8,%eax
     6cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6cf:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     6d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6d7:	eb 24                	jmp    6fd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6dc:	8b 00                	mov    (%eax),%eax
     6de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6e1:	77 12                	ja     6f5 <free+0x35>
     6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6e9:	77 24                	ja     70f <free+0x4f>
     6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ee:	8b 00                	mov    (%eax),%eax
     6f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6f3:	77 1a                	ja     70f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f8:	8b 00                	mov    (%eax),%eax
     6fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     700:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     703:	76 d4                	jbe    6d9 <free+0x19>
     705:	8b 45 fc             	mov    -0x4(%ebp),%eax
     708:	8b 00                	mov    (%eax),%eax
     70a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     70d:	76 ca                	jbe    6d9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     712:	8b 40 04             	mov    0x4(%eax),%eax
     715:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71f:	01 c2                	add    %eax,%edx
     721:	8b 45 fc             	mov    -0x4(%ebp),%eax
     724:	8b 00                	mov    (%eax),%eax
     726:	39 c2                	cmp    %eax,%edx
     728:	75 24                	jne    74e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72d:	8b 50 04             	mov    0x4(%eax),%edx
     730:	8b 45 fc             	mov    -0x4(%ebp),%eax
     733:	8b 00                	mov    (%eax),%eax
     735:	8b 40 04             	mov    0x4(%eax),%eax
     738:	01 c2                	add    %eax,%edx
     73a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     740:	8b 45 fc             	mov    -0x4(%ebp),%eax
     743:	8b 00                	mov    (%eax),%eax
     745:	8b 10                	mov    (%eax),%edx
     747:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74a:	89 10                	mov    %edx,(%eax)
     74c:	eb 0a                	jmp    758 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     74e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     751:	8b 10                	mov    (%eax),%edx
     753:	8b 45 f8             	mov    -0x8(%ebp),%eax
     756:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     758:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75b:	8b 40 04             	mov    0x4(%eax),%eax
     75e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	01 d0                	add    %edx,%eax
     76a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     76d:	75 20                	jne    78f <free+0xcf>
    p->s.size += bp->s.size;
     76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     772:	8b 50 04             	mov    0x4(%eax),%edx
     775:	8b 45 f8             	mov    -0x8(%ebp),%eax
     778:	8b 40 04             	mov    0x4(%eax),%eax
     77b:	01 c2                	add    %eax,%edx
     77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     780:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     783:	8b 45 f8             	mov    -0x8(%ebp),%eax
     786:	8b 10                	mov    (%eax),%edx
     788:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78b:	89 10                	mov    %edx,(%eax)
     78d:	eb 08                	jmp    797 <free+0xd7>
  } else
    p->s.ptr = bp;
     78f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     792:	8b 55 f8             	mov    -0x8(%ebp),%edx
     795:	89 10                	mov    %edx,(%eax)
  freep = p;
     797:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79a:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
}
     79f:	90                   	nop
     7a0:	c9                   	leave  
     7a1:	c3                   	ret    

000007a2 <morecore>:

static Header*
morecore(uint nu)
{
     7a2:	55                   	push   %ebp
     7a3:	89 e5                	mov    %esp,%ebp
     7a5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7a8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7af:	77 07                	ja     7b8 <morecore+0x16>
    nu = 4096;
     7b1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7b8:	8b 45 08             	mov    0x8(%ebp),%eax
     7bb:	c1 e0 03             	shl    $0x3,%eax
     7be:	83 ec 0c             	sub    $0xc,%esp
     7c1:	50                   	push   %eax
     7c2:	e8 19 fc ff ff       	call   3e0 <sbrk>
     7c7:	83 c4 10             	add    $0x10,%esp
     7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7cd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7d1:	75 07                	jne    7da <morecore+0x38>
    return 0;
     7d3:	b8 00 00 00 00       	mov    $0x0,%eax
     7d8:	eb 26                	jmp    800 <morecore+0x5e>
  hp = (Header*)p;
     7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e3:	8b 55 08             	mov    0x8(%ebp),%edx
     7e6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ec:	83 c0 08             	add    $0x8,%eax
     7ef:	83 ec 0c             	sub    $0xc,%esp
     7f2:	50                   	push   %eax
     7f3:	e8 c8 fe ff ff       	call   6c0 <free>
     7f8:	83 c4 10             	add    $0x10,%esp
  return freep;
     7fb:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
}
     800:	c9                   	leave  
     801:	c3                   	ret    

00000802 <malloc>:

void*
malloc(uint nbytes)
{
     802:	55                   	push   %ebp
     803:	89 e5                	mov    %esp,%ebp
     805:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     808:	8b 45 08             	mov    0x8(%ebp),%eax
     80b:	83 c0 07             	add    $0x7,%eax
     80e:	c1 e8 03             	shr    $0x3,%eax
     811:	83 c0 01             	add    $0x1,%eax
     814:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     817:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     81c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     81f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     823:	75 23                	jne    848 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     825:	c7 45 f0 c0 1a 00 00 	movl   $0x1ac0,-0x10(%ebp)
     82c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     82f:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
     834:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     839:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
    base.s.size = 0;
     83e:	c7 05 c4 1a 00 00 00 	movl   $0x0,0x1ac4
     845:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     848:	8b 45 f0             	mov    -0x10(%ebp),%eax
     84b:	8b 00                	mov    (%eax),%eax
     84d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     850:	8b 45 f4             	mov    -0xc(%ebp),%eax
     853:	8b 40 04             	mov    0x4(%eax),%eax
     856:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     859:	72 4d                	jb     8a8 <malloc+0xa6>
      if(p->s.size == nunits)
     85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85e:	8b 40 04             	mov    0x4(%eax),%eax
     861:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     864:	75 0c                	jne    872 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     866:	8b 45 f4             	mov    -0xc(%ebp),%eax
     869:	8b 10                	mov    (%eax),%edx
     86b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86e:	89 10                	mov    %edx,(%eax)
     870:	eb 26                	jmp    898 <malloc+0x96>
      else {
        p->s.size -= nunits;
     872:	8b 45 f4             	mov    -0xc(%ebp),%eax
     875:	8b 40 04             	mov    0x4(%eax),%eax
     878:	2b 45 ec             	sub    -0x14(%ebp),%eax
     87b:	89 c2                	mov    %eax,%edx
     87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     880:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     883:	8b 45 f4             	mov    -0xc(%ebp),%eax
     886:	8b 40 04             	mov    0x4(%eax),%eax
     889:	c1 e0 03             	shl    $0x3,%eax
     88c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     892:	8b 55 ec             	mov    -0x14(%ebp),%edx
     895:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     898:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89b:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
      return (void*)(p + 1);
     8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a3:	83 c0 08             	add    $0x8,%eax
     8a6:	eb 3b                	jmp    8e3 <malloc+0xe1>
    }
    if(p == freep)
     8a8:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     8ad:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8b0:	75 1e                	jne    8d0 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8b2:	83 ec 0c             	sub    $0xc,%esp
     8b5:	ff 75 ec             	pushl  -0x14(%ebp)
     8b8:	e8 e5 fe ff ff       	call   7a2 <morecore>
     8bd:	83 c4 10             	add    $0x10,%esp
     8c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8c7:	75 07                	jne    8d0 <malloc+0xce>
        return 0;
     8c9:	b8 00 00 00 00       	mov    $0x0,%eax
     8ce:	eb 13                	jmp    8e3 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d9:	8b 00                	mov    (%eax),%eax
     8db:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8de:	e9 6d ff ff ff       	jmp    850 <malloc+0x4e>
}
     8e3:	c9                   	leave  
     8e4:	c3                   	ret    

000008e5 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     8e5:	55                   	push   %ebp
     8e6:	89 e5                	mov    %esp,%ebp
     8e8:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     8eb:	83 ec 0c             	sub    $0xc,%esp
     8ee:	ff 75 08             	pushl  0x8(%ebp)
     8f1:	e8 b0 00 00 00       	call   9a6 <re_compile>
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	83 ec 04             	sub    $0x4,%esp
     8fc:	ff 75 10             	pushl  0x10(%ebp)
     8ff:	ff 75 0c             	pushl  0xc(%ebp)
     902:	50                   	push   %eax
     903:	e8 05 00 00 00       	call   90d <re_matchp>
     908:	83 c4 10             	add    $0x10,%esp
}
     90b:	c9                   	leave  
     90c:	c3                   	ret    

0000090d <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     90d:	55                   	push   %ebp
     90e:	89 e5                	mov    %esp,%ebp
     910:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     913:	8b 45 10             	mov    0x10(%ebp),%eax
     916:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     91c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     920:	74 7d                	je     99f <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     922:	8b 45 08             	mov    0x8(%ebp),%eax
     925:	0f b6 00             	movzbl (%eax),%eax
     928:	3c 02                	cmp    $0x2,%al
     92a:	75 2a                	jne    956 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     92c:	8b 45 08             	mov    0x8(%ebp),%eax
     92f:	83 c0 08             	add    $0x8,%eax
     932:	83 ec 04             	sub    $0x4,%esp
     935:	ff 75 10             	pushl  0x10(%ebp)
     938:	ff 75 0c             	pushl  0xc(%ebp)
     93b:	50                   	push   %eax
     93c:	e8 b0 08 00 00       	call   11f1 <matchpattern>
     941:	83 c4 10             	add    $0x10,%esp
     944:	85 c0                	test   %eax,%eax
     946:	74 07                	je     94f <re_matchp+0x42>
     948:	b8 00 00 00 00       	mov    $0x0,%eax
     94d:	eb 55                	jmp    9a4 <re_matchp+0x97>
     94f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     954:	eb 4e                	jmp    9a4 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     956:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     95d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     961:	83 ec 04             	sub    $0x4,%esp
     964:	ff 75 10             	pushl  0x10(%ebp)
     967:	ff 75 0c             	pushl  0xc(%ebp)
     96a:	ff 75 08             	pushl  0x8(%ebp)
     96d:	e8 7f 08 00 00       	call   11f1 <matchpattern>
     972:	83 c4 10             	add    $0x10,%esp
     975:	85 c0                	test   %eax,%eax
     977:	74 16                	je     98f <re_matchp+0x82>
        {
          if (text[0] == '\0')
     979:	8b 45 0c             	mov    0xc(%ebp),%eax
     97c:	0f b6 00             	movzbl (%eax),%eax
     97f:	84 c0                	test   %al,%al
     981:	75 07                	jne    98a <re_matchp+0x7d>
            return -1;
     983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     988:	eb 1a                	jmp    9a4 <re_matchp+0x97>
        
          return idx;
     98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98d:	eb 15                	jmp    9a4 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     98f:	8b 45 0c             	mov    0xc(%ebp),%eax
     992:	8d 50 01             	lea    0x1(%eax),%edx
     995:	89 55 0c             	mov    %edx,0xc(%ebp)
     998:	0f b6 00             	movzbl (%eax),%eax
     99b:	84 c0                	test   %al,%al
     99d:	75 be                	jne    95d <re_matchp+0x50>
    }
  }
  return -1;
     99f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9a4:	c9                   	leave  
     9a5:	c3                   	ret    

000009a6 <re_compile>:

re_t re_compile(const char* pattern)
{
     9a6:	55                   	push   %ebp
     9a7:	89 e5                	mov    %esp,%ebp
     9a9:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     9ac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     9b3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     9ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     9c1:	e9 55 02 00 00       	jmp    c1b <re_compile+0x275>
  {
    c = pattern[i];
     9c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9c9:	8b 45 08             	mov    0x8(%ebp),%eax
     9cc:	01 d0                	add    %edx,%eax
     9ce:	0f b6 00             	movzbl (%eax),%eax
     9d1:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     9d4:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     9d8:	83 e8 24             	sub    $0x24,%eax
     9db:	83 f8 3a             	cmp    $0x3a,%eax
     9de:	0f 87 13 02 00 00    	ja     bf7 <re_compile+0x251>
     9e4:	8b 04 85 74 13 00 00 	mov    0x1374(,%eax,4),%eax
     9eb:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     9ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f0:	c6 04 c5 e0 1a 00 00 	movb   $0x2,0x1ae0(,%eax,8)
     9f7:	02 
     9f8:	e9 16 02 00 00       	jmp    c13 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a00:	c6 04 c5 e0 1a 00 00 	movb   $0x3,0x1ae0(,%eax,8)
     a07:	03 
     a08:	e9 06 02 00 00       	jmp    c13 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a10:	c6 04 c5 e0 1a 00 00 	movb   $0x1,0x1ae0(,%eax,8)
     a17:	01 
     a18:	e9 f6 01 00 00       	jmp    c13 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a20:	c6 04 c5 e0 1a 00 00 	movb   $0x5,0x1ae0(,%eax,8)
     a27:	05 
     a28:	e9 e6 01 00 00       	jmp    c13 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a30:	c6 04 c5 e0 1a 00 00 	movb   $0x6,0x1ae0(,%eax,8)
     a37:	06 
     a38:	e9 d6 01 00 00       	jmp    c13 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a40:	c6 04 c5 e0 1a 00 00 	movb   $0x4,0x1ae0(,%eax,8)
     a47:	04 
     a48:	e9 c6 01 00 00       	jmp    c13 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     a4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a50:	8d 50 01             	lea    0x1(%eax),%edx
     a53:	8b 45 08             	mov    0x8(%ebp),%eax
     a56:	01 d0                	add    %edx,%eax
     a58:	0f b6 00             	movzbl (%eax),%eax
     a5b:	84 c0                	test   %al,%al
     a5d:	0f 84 af 01 00 00    	je     c12 <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     a63:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     a67:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a6a:	8b 45 08             	mov    0x8(%ebp),%eax
     a6d:	01 d0                	add    %edx,%eax
     a6f:	0f b6 00             	movzbl (%eax),%eax
     a72:	0f be c0             	movsbl %al,%eax
     a75:	83 e8 44             	sub    $0x44,%eax
     a78:	83 f8 33             	cmp    $0x33,%eax
     a7b:	77 57                	ja     ad4 <re_compile+0x12e>
     a7d:	8b 04 85 60 14 00 00 	mov    0x1460(,%eax,4),%eax
     a84:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a89:	c6 04 c5 e0 1a 00 00 	movb   $0xa,0x1ae0(,%eax,8)
     a90:	0a 
     a91:	eb 64                	jmp    af7 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a96:	c6 04 c5 e0 1a 00 00 	movb   $0xb,0x1ae0(,%eax,8)
     a9d:	0b 
     a9e:	eb 57                	jmp    af7 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa3:	c6 04 c5 e0 1a 00 00 	movb   $0xc,0x1ae0(,%eax,8)
     aaa:	0c 
     aab:	eb 4a                	jmp    af7 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	c6 04 c5 e0 1a 00 00 	movb   $0xd,0x1ae0(,%eax,8)
     ab7:	0d 
     ab8:	eb 3d                	jmp    af7 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abd:	c6 04 c5 e0 1a 00 00 	movb   $0xe,0x1ae0(,%eax,8)
     ac4:	0e 
     ac5:	eb 30                	jmp    af7 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aca:	c6 04 c5 e0 1a 00 00 	movb   $0xf,0x1ae0(,%eax,8)
     ad1:	0f 
     ad2:	eb 23                	jmp    af7 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad7:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     ade:	07 
              re_compiled[j].ch = pattern[i];
     adf:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ae2:	8b 45 08             	mov    0x8(%ebp),%eax
     ae5:	01 d0                	add    %edx,%eax
     ae7:	0f b6 00             	movzbl (%eax),%eax
     aea:	89 c2                	mov    %eax,%edx
     aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aef:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
            } break;
     af6:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     af7:	e9 16 01 00 00       	jmp    c12 <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     afc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aff:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b05:	8d 50 01             	lea    0x1(%eax),%edx
     b08:	8b 45 08             	mov    0x8(%ebp),%eax
     b0b:	01 d0                	add    %edx,%eax
     b0d:	0f b6 00             	movzbl (%eax),%eax
     b10:	3c 5e                	cmp    $0x5e,%al
     b12:	75 11                	jne    b25 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b17:	c6 04 c5 e0 1a 00 00 	movb   $0x9,0x1ae0(,%eax,8)
     b1e:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     b1f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b23:	eb 7a                	jmp    b9f <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b28:	c6 04 c5 e0 1a 00 00 	movb   $0x8,0x1ae0(,%eax,8)
     b2f:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b30:	eb 6d                	jmp    b9f <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     b32:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b35:	8b 45 08             	mov    0x8(%ebp),%eax
     b38:	01 d0                	add    %edx,%eax
     b3a:	0f b6 00             	movzbl (%eax),%eax
     b3d:	3c 5c                	cmp    $0x5c,%al
     b3f:	75 34                	jne    b75 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     b41:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     b45:	7e 0a                	jle    b51 <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b47:	b8 00 00 00 00       	mov    $0x0,%eax
     b4c:	e9 f8 00 00 00       	jmp    c49 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     b51:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b54:	8d 50 01             	lea    0x1(%eax),%edx
     b57:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b5a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b5d:	8d 4a 01             	lea    0x1(%edx),%ecx
     b60:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     b63:	89 d1                	mov    %edx,%ecx
     b65:	8b 55 08             	mov    0x8(%ebp),%edx
     b68:	01 ca                	add    %ecx,%edx
     b6a:	0f b6 12             	movzbl (%edx),%edx
     b6d:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
     b73:	eb 10                	jmp    b85 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     b75:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     b79:	7e 0a                	jle    b85 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     b7b:	b8 00 00 00 00       	mov    $0x0,%eax
     b80:	e9 c4 00 00 00       	jmp    c49 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     b85:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b88:	8d 50 01             	lea    0x1(%eax),%edx
     b8b:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b8e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     b91:	8b 55 08             	mov    0x8(%ebp),%edx
     b94:	01 ca                	add    %ecx,%edx
     b96:	0f b6 12             	movzbl (%edx),%edx
     b99:	88 90 e0 1b 00 00    	mov    %dl,0x1be0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     b9f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ba3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ba6:	8b 45 08             	mov    0x8(%ebp),%eax
     ba9:	01 d0                	add    %edx,%eax
     bab:	0f b6 00             	movzbl (%eax),%eax
     bae:	3c 5d                	cmp    $0x5d,%al
     bb0:	74 13                	je     bc5 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     bb2:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bb5:	8b 45 08             	mov    0x8(%ebp),%eax
     bb8:	01 d0                	add    %edx,%eax
     bba:	0f b6 00             	movzbl (%eax),%eax
     bbd:	84 c0                	test   %al,%al
     bbf:	0f 85 6d ff ff ff    	jne    b32 <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     bc5:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     bc9:	7e 07                	jle    bd2 <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     bcb:	b8 00 00 00 00       	mov    $0x0,%eax
     bd0:	eb 77                	jmp    c49 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     bd2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bd5:	8d 50 01             	lea    0x1(%eax),%edx
     bd8:	89 55 fc             	mov    %edx,-0x4(%ebp)
     bdb:	c6 80 e0 1b 00 00 00 	movb   $0x0,0x1be0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     be2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     be5:	8d 90 e0 1b 00 00    	lea    0x1be0(%eax),%edx
     beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bee:	89 14 c5 e4 1a 00 00 	mov    %edx,0x1ae4(,%eax,8)
      } break;
     bf5:	eb 1c                	jmp    c13 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bfa:	c6 04 c5 e0 1a 00 00 	movb   $0x7,0x1ae0(,%eax,8)
     c01:	07 
        re_compiled[j].ch = c;
     c02:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c09:	88 14 c5 e4 1a 00 00 	mov    %dl,0x1ae4(,%eax,8)
      } break;
     c10:	eb 01                	jmp    c13 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     c12:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     c13:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     c17:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     c1b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c1e:	8b 45 08             	mov    0x8(%ebp),%eax
     c21:	01 d0                	add    %edx,%eax
     c23:	0f b6 00             	movzbl (%eax),%eax
     c26:	84 c0                	test   %al,%al
     c28:	74 0f                	je     c39 <re_compile+0x293>
     c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2d:	83 c0 01             	add    $0x1,%eax
     c30:	83 f8 1d             	cmp    $0x1d,%eax
     c33:	0f 8e 8d fd ff ff    	jle    9c6 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3c:	c6 04 c5 e0 1a 00 00 	movb   $0x0,0x1ae0(,%eax,8)
     c43:	00 

  return (re_t) re_compiled;
     c44:	b8 e0 1a 00 00       	mov    $0x1ae0,%eax
}
     c49:	c9                   	leave  
     c4a:	c3                   	ret    

00000c4b <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     c4b:	55                   	push   %ebp
     c4c:	89 e5                	mov    %esp,%ebp
     c4e:	83 ec 04             	sub    $0x4,%esp
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     c57:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     c5b:	7e 0d                	jle    c6a <matchdigit+0x1f>
     c5d:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     c61:	7f 07                	jg     c6a <matchdigit+0x1f>
     c63:	b8 01 00 00 00       	mov    $0x1,%eax
     c68:	eb 05                	jmp    c6f <matchdigit+0x24>
     c6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c6f:	c9                   	leave  
     c70:	c3                   	ret    

00000c71 <matchalpha>:
static int matchalpha(char c)
{
     c71:	55                   	push   %ebp
     c72:	89 e5                	mov    %esp,%ebp
     c74:	83 ec 04             	sub    $0x4,%esp
     c77:	8b 45 08             	mov    0x8(%ebp),%eax
     c7a:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     c7d:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     c81:	7e 06                	jle    c89 <matchalpha+0x18>
     c83:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     c87:	7e 0c                	jle    c95 <matchalpha+0x24>
     c89:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     c8d:	7e 0d                	jle    c9c <matchalpha+0x2b>
     c8f:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     c93:	7f 07                	jg     c9c <matchalpha+0x2b>
     c95:	b8 01 00 00 00       	mov    $0x1,%eax
     c9a:	eb 05                	jmp    ca1 <matchalpha+0x30>
     c9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ca1:	c9                   	leave  
     ca2:	c3                   	ret    

00000ca3 <matchwhitespace>:
static int matchwhitespace(char c)
{
     ca3:	55                   	push   %ebp
     ca4:	89 e5                	mov    %esp,%ebp
     ca6:	83 ec 04             	sub    $0x4,%esp
     ca9:	8b 45 08             	mov    0x8(%ebp),%eax
     cac:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     caf:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     cb3:	74 1e                	je     cd3 <matchwhitespace+0x30>
     cb5:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     cb9:	74 18                	je     cd3 <matchwhitespace+0x30>
     cbb:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     cbf:	74 12                	je     cd3 <matchwhitespace+0x30>
     cc1:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     cc5:	74 0c                	je     cd3 <matchwhitespace+0x30>
     cc7:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     ccb:	74 06                	je     cd3 <matchwhitespace+0x30>
     ccd:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     cd1:	75 07                	jne    cda <matchwhitespace+0x37>
     cd3:	b8 01 00 00 00       	mov    $0x1,%eax
     cd8:	eb 05                	jmp    cdf <matchwhitespace+0x3c>
     cda:	b8 00 00 00 00       	mov    $0x0,%eax
}
     cdf:	c9                   	leave  
     ce0:	c3                   	ret    

00000ce1 <matchalphanum>:
static int matchalphanum(char c)
{
     ce1:	55                   	push   %ebp
     ce2:	89 e5                	mov    %esp,%ebp
     ce4:	83 ec 04             	sub    $0x4,%esp
     ce7:	8b 45 08             	mov    0x8(%ebp),%eax
     cea:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     ced:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     cf1:	74 22                	je     d15 <matchalphanum+0x34>
     cf3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     cf7:	50                   	push   %eax
     cf8:	e8 74 ff ff ff       	call   c71 <matchalpha>
     cfd:	83 c4 04             	add    $0x4,%esp
     d00:	85 c0                	test   %eax,%eax
     d02:	75 11                	jne    d15 <matchalphanum+0x34>
     d04:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     d08:	50                   	push   %eax
     d09:	e8 3d ff ff ff       	call   c4b <matchdigit>
     d0e:	83 c4 04             	add    $0x4,%esp
     d11:	85 c0                	test   %eax,%eax
     d13:	74 07                	je     d1c <matchalphanum+0x3b>
     d15:	b8 01 00 00 00       	mov    $0x1,%eax
     d1a:	eb 05                	jmp    d21 <matchalphanum+0x40>
     d1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d21:	c9                   	leave  
     d22:	c3                   	ret    

00000d23 <matchrange>:
static int matchrange(char c, const char* str)
{
     d23:	55                   	push   %ebp
     d24:	89 e5                	mov    %esp,%ebp
     d26:	83 ec 04             	sub    $0x4,%esp
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d2f:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     d33:	74 5b                	je     d90 <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     d35:	8b 45 0c             	mov    0xc(%ebp),%eax
     d38:	0f b6 00             	movzbl (%eax),%eax
     d3b:	84 c0                	test   %al,%al
     d3d:	74 51                	je     d90 <matchrange+0x6d>
     d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
     d42:	0f b6 00             	movzbl (%eax),%eax
     d45:	3c 2d                	cmp    $0x2d,%al
     d47:	74 47                	je     d90 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     d49:	8b 45 0c             	mov    0xc(%ebp),%eax
     d4c:	83 c0 01             	add    $0x1,%eax
     d4f:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     d52:	3c 2d                	cmp    $0x2d,%al
     d54:	75 3a                	jne    d90 <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     d56:	8b 45 0c             	mov    0xc(%ebp),%eax
     d59:	83 c0 01             	add    $0x1,%eax
     d5c:	0f b6 00             	movzbl (%eax),%eax
     d5f:	84 c0                	test   %al,%al
     d61:	74 2d                	je     d90 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d63:	8b 45 0c             	mov    0xc(%ebp),%eax
     d66:	83 c0 02             	add    $0x2,%eax
     d69:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     d6c:	84 c0                	test   %al,%al
     d6e:	74 20                	je     d90 <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     d70:	8b 45 0c             	mov    0xc(%ebp),%eax
     d73:	0f b6 00             	movzbl (%eax),%eax
     d76:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d79:	7f 15                	jg     d90 <matchrange+0x6d>
     d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7e:	83 c0 02             	add    $0x2,%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d87:	7c 07                	jl     d90 <matchrange+0x6d>
     d89:	b8 01 00 00 00       	mov    $0x1,%eax
     d8e:	eb 05                	jmp    d95 <matchrange+0x72>
     d90:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d95:	c9                   	leave  
     d96:	c3                   	ret    

00000d97 <ismetachar>:
static int ismetachar(char c)
{
     d97:	55                   	push   %ebp
     d98:	89 e5                	mov    %esp,%ebp
     d9a:	83 ec 04             	sub    $0x4,%esp
     d9d:	8b 45 08             	mov    0x8(%ebp),%eax
     da0:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     da3:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     da7:	74 1e                	je     dc7 <ismetachar+0x30>
     da9:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     dad:	74 18                	je     dc7 <ismetachar+0x30>
     daf:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     db3:	74 12                	je     dc7 <ismetachar+0x30>
     db5:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     db9:	74 0c                	je     dc7 <ismetachar+0x30>
     dbb:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     dbf:	74 06                	je     dc7 <ismetachar+0x30>
     dc1:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     dc5:	75 07                	jne    dce <ismetachar+0x37>
     dc7:	b8 01 00 00 00       	mov    $0x1,%eax
     dcc:	eb 05                	jmp    dd3 <ismetachar+0x3c>
     dce:	b8 00 00 00 00       	mov    $0x0,%eax
}
     dd3:	c9                   	leave  
     dd4:	c3                   	ret    

00000dd5 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     dd5:	55                   	push   %ebp
     dd6:	89 e5                	mov    %esp,%ebp
     dd8:	83 ec 04             	sub    $0x4,%esp
     ddb:	8b 45 08             	mov    0x8(%ebp),%eax
     dde:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     de1:	8b 45 0c             	mov    0xc(%ebp),%eax
     de4:	0f b6 00             	movzbl (%eax),%eax
     de7:	0f be c0             	movsbl %al,%eax
     dea:	83 e8 44             	sub    $0x44,%eax
     ded:	83 f8 33             	cmp    $0x33,%eax
     df0:	77 7b                	ja     e6d <matchmetachar+0x98>
     df2:	8b 04 85 30 15 00 00 	mov    0x1530(,%eax,4),%eax
     df9:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     dfb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     dff:	50                   	push   %eax
     e00:	e8 46 fe ff ff       	call   c4b <matchdigit>
     e05:	83 c4 04             	add    $0x4,%esp
     e08:	eb 72                	jmp    e7c <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     e0a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e0e:	50                   	push   %eax
     e0f:	e8 37 fe ff ff       	call   c4b <matchdigit>
     e14:	83 c4 04             	add    $0x4,%esp
     e17:	85 c0                	test   %eax,%eax
     e19:	0f 94 c0             	sete   %al
     e1c:	0f b6 c0             	movzbl %al,%eax
     e1f:	eb 5b                	jmp    e7c <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     e21:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e25:	50                   	push   %eax
     e26:	e8 b6 fe ff ff       	call   ce1 <matchalphanum>
     e2b:	83 c4 04             	add    $0x4,%esp
     e2e:	eb 4c                	jmp    e7c <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     e30:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e34:	50                   	push   %eax
     e35:	e8 a7 fe ff ff       	call   ce1 <matchalphanum>
     e3a:	83 c4 04             	add    $0x4,%esp
     e3d:	85 c0                	test   %eax,%eax
     e3f:	0f 94 c0             	sete   %al
     e42:	0f b6 c0             	movzbl %al,%eax
     e45:	eb 35                	jmp    e7c <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     e47:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e4b:	50                   	push   %eax
     e4c:	e8 52 fe ff ff       	call   ca3 <matchwhitespace>
     e51:	83 c4 04             	add    $0x4,%esp
     e54:	eb 26                	jmp    e7c <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     e56:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e5a:	50                   	push   %eax
     e5b:	e8 43 fe ff ff       	call   ca3 <matchwhitespace>
     e60:	83 c4 04             	add    $0x4,%esp
     e63:	85 c0                	test   %eax,%eax
     e65:	0f 94 c0             	sete   %al
     e68:	0f b6 c0             	movzbl %al,%eax
     e6b:	eb 0f                	jmp    e7c <matchmetachar+0xa7>
    default:  return (c == str[0]);
     e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e70:	0f b6 00             	movzbl (%eax),%eax
     e73:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e76:	0f 94 c0             	sete   %al
     e79:	0f b6 c0             	movzbl %al,%eax
  }
}
     e7c:	c9                   	leave  
     e7d:	c3                   	ret    

00000e7e <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     e7e:	55                   	push   %ebp
     e7f:	89 e5                	mov    %esp,%ebp
     e81:	83 ec 04             	sub    $0x4,%esp
     e84:	8b 45 08             	mov    0x8(%ebp),%eax
     e87:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     e8a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     e8e:	ff 75 0c             	pushl  0xc(%ebp)
     e91:	50                   	push   %eax
     e92:	e8 8c fe ff ff       	call   d23 <matchrange>
     e97:	83 c4 08             	add    $0x8,%esp
     e9a:	85 c0                	test   %eax,%eax
     e9c:	74 0a                	je     ea8 <matchcharclass+0x2a>
    {
      return 1;
     e9e:	b8 01 00 00 00       	mov    $0x1,%eax
     ea3:	e9 a5 00 00 00       	jmp    f4d <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
     eab:	0f b6 00             	movzbl (%eax),%eax
     eae:	3c 5c                	cmp    $0x5c,%al
     eb0:	75 42                	jne    ef4 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     eb2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     eb6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     eba:	ff 75 0c             	pushl  0xc(%ebp)
     ebd:	50                   	push   %eax
     ebe:	e8 12 ff ff ff       	call   dd5 <matchmetachar>
     ec3:	83 c4 08             	add    $0x8,%esp
     ec6:	85 c0                	test   %eax,%eax
     ec8:	74 07                	je     ed1 <matchcharclass+0x53>
      {
        return 1;
     eca:	b8 01 00 00 00       	mov    $0x1,%eax
     ecf:	eb 7c                	jmp    f4d <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed4:	0f b6 00             	movzbl (%eax),%eax
     ed7:	3a 45 fc             	cmp    -0x4(%ebp),%al
     eda:	75 58                	jne    f34 <matchcharclass+0xb6>
     edc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     ee0:	50                   	push   %eax
     ee1:	e8 b1 fe ff ff       	call   d97 <ismetachar>
     ee6:	83 c4 04             	add    $0x4,%esp
     ee9:	85 c0                	test   %eax,%eax
     eeb:	75 47                	jne    f34 <matchcharclass+0xb6>
      {
        return 1;
     eed:	b8 01 00 00 00       	mov    $0x1,%eax
     ef2:	eb 59                	jmp    f4d <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef7:	0f b6 00             	movzbl (%eax),%eax
     efa:	3a 45 fc             	cmp    -0x4(%ebp),%al
     efd:	75 35                	jne    f34 <matchcharclass+0xb6>
    {
      if (c == '-')
     eff:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     f03:	75 28                	jne    f2d <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     f05:	8b 45 0c             	mov    0xc(%ebp),%eax
     f08:	83 e8 01             	sub    $0x1,%eax
     f0b:	0f b6 00             	movzbl (%eax),%eax
     f0e:	84 c0                	test   %al,%al
     f10:	74 0d                	je     f1f <matchcharclass+0xa1>
     f12:	8b 45 0c             	mov    0xc(%ebp),%eax
     f15:	83 c0 01             	add    $0x1,%eax
     f18:	0f b6 00             	movzbl (%eax),%eax
     f1b:	84 c0                	test   %al,%al
     f1d:	75 07                	jne    f26 <matchcharclass+0xa8>
     f1f:	b8 01 00 00 00       	mov    $0x1,%eax
     f24:	eb 27                	jmp    f4d <matchcharclass+0xcf>
     f26:	b8 00 00 00 00       	mov    $0x0,%eax
     f2b:	eb 20                	jmp    f4d <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     f2d:	b8 01 00 00 00       	mov    $0x1,%eax
     f32:	eb 19                	jmp    f4d <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     f34:	8b 45 0c             	mov    0xc(%ebp),%eax
     f37:	8d 50 01             	lea    0x1(%eax),%edx
     f3a:	89 55 0c             	mov    %edx,0xc(%ebp)
     f3d:	0f b6 00             	movzbl (%eax),%eax
     f40:	84 c0                	test   %al,%al
     f42:	0f 85 42 ff ff ff    	jne    e8a <matchcharclass+0xc>

  return 0;
     f48:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f4d:	c9                   	leave  
     f4e:	c3                   	ret    

00000f4f <matchone>:

static int matchone(regex_t p, char c)
{
     f4f:	55                   	push   %ebp
     f50:	89 e5                	mov    %esp,%ebp
     f52:	83 ec 04             	sub    $0x4,%esp
     f55:	8b 45 10             	mov    0x10(%ebp),%eax
     f58:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     f5b:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     f5f:	0f b6 c0             	movzbl %al,%eax
     f62:	83 f8 0f             	cmp    $0xf,%eax
     f65:	0f 87 b9 00 00 00    	ja     1024 <matchone+0xd5>
     f6b:	8b 04 85 00 16 00 00 	mov    0x1600(,%eax,4),%eax
     f72:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     f74:	b8 01 00 00 00       	mov    $0x1,%eax
     f79:	e9 b9 00 00 00       	jmp    1037 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     f7e:	8b 55 0c             	mov    0xc(%ebp),%edx
     f81:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f85:	52                   	push   %edx
     f86:	50                   	push   %eax
     f87:	e8 f2 fe ff ff       	call   e7e <matchcharclass>
     f8c:	83 c4 08             	add    $0x8,%esp
     f8f:	e9 a3 00 00 00       	jmp    1037 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     f94:	8b 55 0c             	mov    0xc(%ebp),%edx
     f97:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f9b:	52                   	push   %edx
     f9c:	50                   	push   %eax
     f9d:	e8 dc fe ff ff       	call   e7e <matchcharclass>
     fa2:	83 c4 08             	add    $0x8,%esp
     fa5:	85 c0                	test   %eax,%eax
     fa7:	0f 94 c0             	sete   %al
     faa:	0f b6 c0             	movzbl %al,%eax
     fad:	e9 85 00 00 00       	jmp    1037 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     fb2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fb6:	50                   	push   %eax
     fb7:	e8 8f fc ff ff       	call   c4b <matchdigit>
     fbc:	83 c4 04             	add    $0x4,%esp
     fbf:	eb 76                	jmp    1037 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     fc1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fc5:	50                   	push   %eax
     fc6:	e8 80 fc ff ff       	call   c4b <matchdigit>
     fcb:	83 c4 04             	add    $0x4,%esp
     fce:	85 c0                	test   %eax,%eax
     fd0:	0f 94 c0             	sete   %al
     fd3:	0f b6 c0             	movzbl %al,%eax
     fd6:	eb 5f                	jmp    1037 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     fd8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     fdc:	50                   	push   %eax
     fdd:	e8 ff fc ff ff       	call   ce1 <matchalphanum>
     fe2:	83 c4 04             	add    $0x4,%esp
     fe5:	eb 50                	jmp    1037 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     fe7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     feb:	50                   	push   %eax
     fec:	e8 f0 fc ff ff       	call   ce1 <matchalphanum>
     ff1:	83 c4 04             	add    $0x4,%esp
     ff4:	85 c0                	test   %eax,%eax
     ff6:	0f 94 c0             	sete   %al
     ff9:	0f b6 c0             	movzbl %al,%eax
     ffc:	eb 39                	jmp    1037 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     ffe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1002:	50                   	push   %eax
    1003:	e8 9b fc ff ff       	call   ca3 <matchwhitespace>
    1008:	83 c4 04             	add    $0x4,%esp
    100b:	eb 2a                	jmp    1037 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    100d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1011:	50                   	push   %eax
    1012:	e8 8c fc ff ff       	call   ca3 <matchwhitespace>
    1017:	83 c4 04             	add    $0x4,%esp
    101a:	85 c0                	test   %eax,%eax
    101c:	0f 94 c0             	sete   %al
    101f:	0f b6 c0             	movzbl %al,%eax
    1022:	eb 13                	jmp    1037 <matchone+0xe8>
    default:             return  (p.ch == c);
    1024:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    1028:	0f b6 d0             	movzbl %al,%edx
    102b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    102f:	39 c2                	cmp    %eax,%edx
    1031:	0f 94 c0             	sete   %al
    1034:	0f b6 c0             	movzbl %al,%eax
  }
}
    1037:	c9                   	leave  
    1038:	c3                   	ret    

00001039 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1039:	55                   	push   %ebp
    103a:	89 e5                	mov    %esp,%ebp
    103c:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    103f:	8b 45 18             	mov    0x18(%ebp),%eax
    1042:	8b 00                	mov    (%eax),%eax
    1044:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1047:	8b 45 14             	mov    0x14(%ebp),%eax
    104a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    104d:	eb 11                	jmp    1060 <matchstar+0x27>
  {
    text++;
    104f:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1053:	8b 45 18             	mov    0x18(%ebp),%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	8d 50 01             	lea    0x1(%eax),%edx
    105b:	8b 45 18             	mov    0x18(%ebp),%eax
    105e:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1060:	8b 45 14             	mov    0x14(%ebp),%eax
    1063:	0f b6 00             	movzbl (%eax),%eax
    1066:	84 c0                	test   %al,%al
    1068:	74 51                	je     10bb <matchstar+0x82>
    106a:	8b 45 14             	mov    0x14(%ebp),%eax
    106d:	0f b6 00             	movzbl (%eax),%eax
    1070:	0f be c0             	movsbl %al,%eax
    1073:	50                   	push   %eax
    1074:	ff 75 0c             	pushl  0xc(%ebp)
    1077:	ff 75 08             	pushl  0x8(%ebp)
    107a:	e8 d0 fe ff ff       	call   f4f <matchone>
    107f:	83 c4 0c             	add    $0xc,%esp
    1082:	85 c0                	test   %eax,%eax
    1084:	75 c9                	jne    104f <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1086:	eb 33                	jmp    10bb <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    1088:	8b 45 14             	mov    0x14(%ebp),%eax
    108b:	8d 50 ff             	lea    -0x1(%eax),%edx
    108e:	89 55 14             	mov    %edx,0x14(%ebp)
    1091:	83 ec 04             	sub    $0x4,%esp
    1094:	ff 75 18             	pushl  0x18(%ebp)
    1097:	50                   	push   %eax
    1098:	ff 75 10             	pushl  0x10(%ebp)
    109b:	e8 51 01 00 00       	call   11f1 <matchpattern>
    10a0:	83 c4 10             	add    $0x10,%esp
    10a3:	85 c0                	test   %eax,%eax
    10a5:	74 07                	je     10ae <matchstar+0x75>
      return 1;
    10a7:	b8 01 00 00 00       	mov    $0x1,%eax
    10ac:	eb 22                	jmp    10d0 <matchstar+0x97>
    (*matchlength)--;
    10ae:	8b 45 18             	mov    0x18(%ebp),%eax
    10b1:	8b 00                	mov    (%eax),%eax
    10b3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b6:	8b 45 18             	mov    0x18(%ebp),%eax
    10b9:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    10bb:	8b 45 14             	mov    0x14(%ebp),%eax
    10be:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    10c1:	73 c5                	jae    1088 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    10c3:	8b 45 18             	mov    0x18(%ebp),%eax
    10c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10c9:	89 10                	mov    %edx,(%eax)
  return 0;
    10cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10d0:	c9                   	leave  
    10d1:	c3                   	ret    

000010d2 <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    10d2:	55                   	push   %ebp
    10d3:	89 e5                	mov    %esp,%ebp
    10d5:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    10d8:	8b 45 14             	mov    0x14(%ebp),%eax
    10db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    10de:	eb 11                	jmp    10f1 <matchplus+0x1f>
  {
    text++;
    10e0:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    10e4:	8b 45 18             	mov    0x18(%ebp),%eax
    10e7:	8b 00                	mov    (%eax),%eax
    10e9:	8d 50 01             	lea    0x1(%eax),%edx
    10ec:	8b 45 18             	mov    0x18(%ebp),%eax
    10ef:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    10f1:	8b 45 14             	mov    0x14(%ebp),%eax
    10f4:	0f b6 00             	movzbl (%eax),%eax
    10f7:	84 c0                	test   %al,%al
    10f9:	74 51                	je     114c <matchplus+0x7a>
    10fb:	8b 45 14             	mov    0x14(%ebp),%eax
    10fe:	0f b6 00             	movzbl (%eax),%eax
    1101:	0f be c0             	movsbl %al,%eax
    1104:	50                   	push   %eax
    1105:	ff 75 0c             	pushl  0xc(%ebp)
    1108:	ff 75 08             	pushl  0x8(%ebp)
    110b:	e8 3f fe ff ff       	call   f4f <matchone>
    1110:	83 c4 0c             	add    $0xc,%esp
    1113:	85 c0                	test   %eax,%eax
    1115:	75 c9                	jne    10e0 <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1117:	eb 33                	jmp    114c <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    1119:	8b 45 14             	mov    0x14(%ebp),%eax
    111c:	8d 50 ff             	lea    -0x1(%eax),%edx
    111f:	89 55 14             	mov    %edx,0x14(%ebp)
    1122:	83 ec 04             	sub    $0x4,%esp
    1125:	ff 75 18             	pushl  0x18(%ebp)
    1128:	50                   	push   %eax
    1129:	ff 75 10             	pushl  0x10(%ebp)
    112c:	e8 c0 00 00 00       	call   11f1 <matchpattern>
    1131:	83 c4 10             	add    $0x10,%esp
    1134:	85 c0                	test   %eax,%eax
    1136:	74 07                	je     113f <matchplus+0x6d>
      return 1;
    1138:	b8 01 00 00 00       	mov    $0x1,%eax
    113d:	eb 1a                	jmp    1159 <matchplus+0x87>
    (*matchlength)--;
    113f:	8b 45 18             	mov    0x18(%ebp),%eax
    1142:	8b 00                	mov    (%eax),%eax
    1144:	8d 50 ff             	lea    -0x1(%eax),%edx
    1147:	8b 45 18             	mov    0x18(%ebp),%eax
    114a:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    114c:	8b 45 14             	mov    0x14(%ebp),%eax
    114f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1152:	77 c5                	ja     1119 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    1154:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1159:	c9                   	leave  
    115a:	c3                   	ret    

0000115b <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    115b:	55                   	push   %ebp
    115c:	89 e5                	mov    %esp,%ebp
    115e:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    1161:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1165:	84 c0                	test   %al,%al
    1167:	75 07                	jne    1170 <matchquestion+0x15>
    return 1;
    1169:	b8 01 00 00 00       	mov    $0x1,%eax
    116e:	eb 7f                	jmp    11ef <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    1170:	83 ec 04             	sub    $0x4,%esp
    1173:	ff 75 18             	pushl  0x18(%ebp)
    1176:	ff 75 14             	pushl  0x14(%ebp)
    1179:	ff 75 10             	pushl  0x10(%ebp)
    117c:	e8 70 00 00 00       	call   11f1 <matchpattern>
    1181:	83 c4 10             	add    $0x10,%esp
    1184:	85 c0                	test   %eax,%eax
    1186:	74 07                	je     118f <matchquestion+0x34>
      return 1;
    1188:	b8 01 00 00 00       	mov    $0x1,%eax
    118d:	eb 60                	jmp    11ef <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    118f:	8b 45 14             	mov    0x14(%ebp),%eax
    1192:	0f b6 00             	movzbl (%eax),%eax
    1195:	84 c0                	test   %al,%al
    1197:	74 51                	je     11ea <matchquestion+0x8f>
    1199:	8b 45 14             	mov    0x14(%ebp),%eax
    119c:	8d 50 01             	lea    0x1(%eax),%edx
    119f:	89 55 14             	mov    %edx,0x14(%ebp)
    11a2:	0f b6 00             	movzbl (%eax),%eax
    11a5:	0f be c0             	movsbl %al,%eax
    11a8:	83 ec 04             	sub    $0x4,%esp
    11ab:	50                   	push   %eax
    11ac:	ff 75 0c             	pushl  0xc(%ebp)
    11af:	ff 75 08             	pushl  0x8(%ebp)
    11b2:	e8 98 fd ff ff       	call   f4f <matchone>
    11b7:	83 c4 10             	add    $0x10,%esp
    11ba:	85 c0                	test   %eax,%eax
    11bc:	74 2c                	je     11ea <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    11be:	83 ec 04             	sub    $0x4,%esp
    11c1:	ff 75 18             	pushl  0x18(%ebp)
    11c4:	ff 75 14             	pushl  0x14(%ebp)
    11c7:	ff 75 10             	pushl  0x10(%ebp)
    11ca:	e8 22 00 00 00       	call   11f1 <matchpattern>
    11cf:	83 c4 10             	add    $0x10,%esp
    11d2:	85 c0                	test   %eax,%eax
    11d4:	74 14                	je     11ea <matchquestion+0x8f>
    {
      (*matchlength)++;
    11d6:	8b 45 18             	mov    0x18(%ebp),%eax
    11d9:	8b 00                	mov    (%eax),%eax
    11db:	8d 50 01             	lea    0x1(%eax),%edx
    11de:	8b 45 18             	mov    0x18(%ebp),%eax
    11e1:	89 10                	mov    %edx,(%eax)
      return 1;
    11e3:	b8 01 00 00 00       	mov    $0x1,%eax
    11e8:	eb 05                	jmp    11ef <matchquestion+0x94>
    }
  }
  return 0;
    11ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11ef:	c9                   	leave  
    11f0:	c3                   	ret    

000011f1 <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    11f1:	55                   	push   %ebp
    11f2:	89 e5                	mov    %esp,%ebp
    11f4:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    11f7:	8b 45 10             	mov    0x10(%ebp),%eax
    11fa:	8b 00                	mov    (%eax),%eax
    11fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1202:	0f b6 00             	movzbl (%eax),%eax
    1205:	84 c0                	test   %al,%al
    1207:	74 0d                	je     1216 <matchpattern+0x25>
    1209:	8b 45 08             	mov    0x8(%ebp),%eax
    120c:	83 c0 08             	add    $0x8,%eax
    120f:	0f b6 00             	movzbl (%eax),%eax
    1212:	3c 04                	cmp    $0x4,%al
    1214:	75 25                	jne    123b <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	83 c0 10             	add    $0x10,%eax
    121c:	83 ec 0c             	sub    $0xc,%esp
    121f:	ff 75 10             	pushl  0x10(%ebp)
    1222:	ff 75 0c             	pushl  0xc(%ebp)
    1225:	50                   	push   %eax
    1226:	8b 45 08             	mov    0x8(%ebp),%eax
    1229:	ff 70 04             	pushl  0x4(%eax)
    122c:	ff 30                	pushl  (%eax)
    122e:	e8 28 ff ff ff       	call   115b <matchquestion>
    1233:	83 c4 20             	add    $0x20,%esp
    1236:	e9 dd 00 00 00       	jmp    1318 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	83 c0 08             	add    $0x8,%eax
    1241:	0f b6 00             	movzbl (%eax),%eax
    1244:	3c 05                	cmp    $0x5,%al
    1246:	75 25                	jne    126d <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	83 c0 10             	add    $0x10,%eax
    124e:	83 ec 0c             	sub    $0xc,%esp
    1251:	ff 75 10             	pushl  0x10(%ebp)
    1254:	ff 75 0c             	pushl  0xc(%ebp)
    1257:	50                   	push   %eax
    1258:	8b 45 08             	mov    0x8(%ebp),%eax
    125b:	ff 70 04             	pushl  0x4(%eax)
    125e:	ff 30                	pushl  (%eax)
    1260:	e8 d4 fd ff ff       	call   1039 <matchstar>
    1265:	83 c4 20             	add    $0x20,%esp
    1268:	e9 ab 00 00 00       	jmp    1318 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    126d:	8b 45 08             	mov    0x8(%ebp),%eax
    1270:	83 c0 08             	add    $0x8,%eax
    1273:	0f b6 00             	movzbl (%eax),%eax
    1276:	3c 06                	cmp    $0x6,%al
    1278:	75 22                	jne    129c <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    127a:	8b 45 08             	mov    0x8(%ebp),%eax
    127d:	83 c0 10             	add    $0x10,%eax
    1280:	83 ec 0c             	sub    $0xc,%esp
    1283:	ff 75 10             	pushl  0x10(%ebp)
    1286:	ff 75 0c             	pushl  0xc(%ebp)
    1289:	50                   	push   %eax
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	ff 70 04             	pushl  0x4(%eax)
    1290:	ff 30                	pushl  (%eax)
    1292:	e8 3b fe ff ff       	call   10d2 <matchplus>
    1297:	83 c4 20             	add    $0x20,%esp
    129a:	eb 7c                	jmp    1318 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    129c:	8b 45 08             	mov    0x8(%ebp),%eax
    129f:	0f b6 00             	movzbl (%eax),%eax
    12a2:	3c 03                	cmp    $0x3,%al
    12a4:	75 1d                	jne    12c3 <matchpattern+0xd2>
    12a6:	8b 45 08             	mov    0x8(%ebp),%eax
    12a9:	83 c0 08             	add    $0x8,%eax
    12ac:	0f b6 00             	movzbl (%eax),%eax
    12af:	84 c0                	test   %al,%al
    12b1:	75 10                	jne    12c3 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    12b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b6:	0f b6 00             	movzbl (%eax),%eax
    12b9:	84 c0                	test   %al,%al
    12bb:	0f 94 c0             	sete   %al
    12be:	0f b6 c0             	movzbl %al,%eax
    12c1:	eb 55                	jmp    1318 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    12c3:	8b 45 10             	mov    0x10(%ebp),%eax
    12c6:	8b 00                	mov    (%eax),%eax
    12c8:	8d 50 01             	lea    0x1(%eax),%edx
    12cb:	8b 45 10             	mov    0x10(%ebp),%eax
    12ce:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    12d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d3:	0f b6 00             	movzbl (%eax),%eax
    12d6:	84 c0                	test   %al,%al
    12d8:	74 31                	je     130b <matchpattern+0x11a>
    12da:	8b 45 0c             	mov    0xc(%ebp),%eax
    12dd:	8d 50 01             	lea    0x1(%eax),%edx
    12e0:	89 55 0c             	mov    %edx,0xc(%ebp)
    12e3:	0f b6 00             	movzbl (%eax),%eax
    12e6:	0f be d0             	movsbl %al,%edx
    12e9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ec:	8d 48 08             	lea    0x8(%eax),%ecx
    12ef:	89 4d 08             	mov    %ecx,0x8(%ebp)
    12f2:	83 ec 04             	sub    $0x4,%esp
    12f5:	52                   	push   %edx
    12f6:	ff 70 04             	pushl  0x4(%eax)
    12f9:	ff 30                	pushl  (%eax)
    12fb:	e8 4f fc ff ff       	call   f4f <matchone>
    1300:	83 c4 10             	add    $0x10,%esp
    1303:	85 c0                	test   %eax,%eax
    1305:	0f 85 f4 fe ff ff    	jne    11ff <matchpattern+0xe>

  *matchlength = pre;
    130b:	8b 45 10             	mov    0x10(%ebp),%eax
    130e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1311:	89 10                	mov    %edx,(%eax)
  return 0;
    1313:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1318:	c9                   	leave  
    1319:	c3                   	ret    
