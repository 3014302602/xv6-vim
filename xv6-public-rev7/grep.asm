
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
       d:	e9 ab 00 00 00       	jmp    bd <grep+0xbd>
    m += n;
      12:	8b 45 ec             	mov    -0x14(%ebp),%eax
      15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
      18:	c7 45 f0 a0 1e 00 00 	movl   $0x1ea0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      1f:	eb 4a                	jmp    6b <grep+0x6b>
      *q = 0;
      21:	8b 45 e8             	mov    -0x18(%ebp),%eax
      24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
      27:	83 ec 08             	sub    $0x8,%esp
      2a:	ff 75 f0             	pushl  -0x10(%ebp)
      2d:	ff 75 08             	pushl  0x8(%ebp)
      30:	e8 9a 01 00 00       	call   1cf <match>
      35:	83 c4 10             	add    $0x10,%esp
      38:	85 c0                	test   %eax,%eax
      3a:	74 26                	je     62 <grep+0x62>
        *q = '\n';
      3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
      3f:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
      42:	8b 45 e8             	mov    -0x18(%ebp),%eax
      45:	83 c0 01             	add    $0x1,%eax
      48:	89 c2                	mov    %eax,%edx
      4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      4d:	29 c2                	sub    %eax,%edx
      4f:	89 d0                	mov    %edx,%eax
      51:	83 ec 04             	sub    $0x4,%esp
      54:	50                   	push   %eax
      55:	ff 75 f0             	pushl  -0x10(%ebp)
      58:	6a 01                	push   $0x1
      5a:	e8 43 05 00 00       	call   5a2 <write>
      5f:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
      62:	8b 45 e8             	mov    -0x18(%ebp),%eax
      65:	83 c0 01             	add    $0x1,%eax
      68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      6b:	83 ec 08             	sub    $0x8,%esp
      6e:	6a 0a                	push   $0xa
      70:	ff 75 f0             	pushl  -0x10(%ebp)
      73:	e8 89 03 00 00       	call   401 <strchr>
      78:	83 c4 10             	add    $0x10,%esp
      7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
      82:	75 9d                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      84:	81 7d f0 a0 1e 00 00 	cmpl   $0x1ea0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba a0 1e 00 00       	mov    $0x1ea0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 a0 1e 00 00       	push   $0x1ea0
      b5:	e8 83 04 00 00       	call   53d <memmove>
      ba:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c0:	ba 00 04 00 00       	mov    $0x400,%edx
      c5:	29 c2                	sub    %eax,%edx
      c7:	89 d0                	mov    %edx,%eax
      c9:	89 c2                	mov    %eax,%edx
      cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ce:	05 a0 1e 00 00       	add    $0x1ea0,%eax
      d3:	83 ec 04             	sub    $0x4,%esp
      d6:	52                   	push   %edx
      d7:	50                   	push   %eax
      d8:	ff 75 0c             	pushl  0xc(%ebp)
      db:	e8 ba 04 00 00       	call   59a <read>
      e0:	83 c4 10             	add    $0x10,%esp
      e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
      e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      ea:	0f 8f 22 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
      f0:	90                   	nop
      f1:	c9                   	leave  
      f2:	c3                   	ret    

000000f3 <main>:

int
main(int argc, char *argv[])
{
      f3:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      f7:	83 e4 f0             	and    $0xfffffff0,%esp
      fa:	ff 71 fc             	pushl  -0x4(%ecx)
      fd:	55                   	push   %ebp
      fe:	89 e5                	mov    %esp,%ebp
     100:	53                   	push   %ebx
     101:	51                   	push   %ecx
     102:	83 ec 10             	sub    $0x10,%esp
     105:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
     107:	83 3b 01             	cmpl   $0x1,(%ebx)
     10a:	7f 17                	jg     123 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
     10c:	83 ec 08             	sub    $0x8,%esp
     10f:	68 44 15 00 00       	push   $0x1544
     114:	6a 02                	push   $0x2
     116:	e8 3e 06 00 00       	call   759 <printf>
     11b:	83 c4 10             	add    $0x10,%esp
    exit();
     11e:	e8 5f 04 00 00       	call   582 <exit>
  }
  pattern = argv[1];
     123:	8b 43 04             	mov    0x4(%ebx),%eax
     126:	8b 40 04             	mov    0x4(%eax),%eax
     129:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
     12c:	83 3b 02             	cmpl   $0x2,(%ebx)
     12f:	7f 15                	jg     146 <main+0x53>
    grep(pattern, 0);
     131:	83 ec 08             	sub    $0x8,%esp
     134:	6a 00                	push   $0x0
     136:	ff 75 f0             	pushl  -0x10(%ebp)
     139:	e8 c2 fe ff ff       	call   0 <grep>
     13e:	83 c4 10             	add    $0x10,%esp
    exit();
     141:	e8 3c 04 00 00       	call   582 <exit>
  }

  for(i = 2; i < argc; i++){
     146:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
     14d:	eb 74                	jmp    1c3 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
     14f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     152:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     159:	8b 43 04             	mov    0x4(%ebx),%eax
     15c:	01 d0                	add    %edx,%eax
     15e:	8b 00                	mov    (%eax),%eax
     160:	83 ec 08             	sub    $0x8,%esp
     163:	6a 00                	push   $0x0
     165:	50                   	push   %eax
     166:	e8 57 04 00 00       	call   5c2 <open>
     16b:	83 c4 10             	add    $0x10,%esp
     16e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     171:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     175:	79 29                	jns    1a0 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
     177:	8b 45 f4             	mov    -0xc(%ebp),%eax
     17a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     181:	8b 43 04             	mov    0x4(%ebx),%eax
     184:	01 d0                	add    %edx,%eax
     186:	8b 00                	mov    (%eax),%eax
     188:	83 ec 04             	sub    $0x4,%esp
     18b:	50                   	push   %eax
     18c:	68 64 15 00 00       	push   $0x1564
     191:	6a 01                	push   $0x1
     193:	e8 c1 05 00 00       	call   759 <printf>
     198:	83 c4 10             	add    $0x10,%esp
      exit();
     19b:	e8 e2 03 00 00       	call   582 <exit>
    }
    grep(pattern, fd);
     1a0:	83 ec 08             	sub    $0x8,%esp
     1a3:	ff 75 ec             	pushl  -0x14(%ebp)
     1a6:	ff 75 f0             	pushl  -0x10(%ebp)
     1a9:	e8 52 fe ff ff       	call   0 <grep>
     1ae:	83 c4 10             	add    $0x10,%esp
    close(fd);
     1b1:	83 ec 0c             	sub    $0xc,%esp
     1b4:	ff 75 ec             	pushl  -0x14(%ebp)
     1b7:	e8 ee 03 00 00       	call   5aa <close>
     1bc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
     1bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c6:	3b 03                	cmp    (%ebx),%eax
     1c8:	7c 85                	jl     14f <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
     1ca:	e8 b3 03 00 00       	call   582 <exit>

000001cf <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     1cf:	55                   	push   %ebp
     1d0:	89 e5                	mov    %esp,%ebp
     1d2:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
     1d5:	8b 45 08             	mov    0x8(%ebp),%eax
     1d8:	0f b6 00             	movzbl (%eax),%eax
     1db:	3c 5e                	cmp    $0x5e,%al
     1dd:	75 17                	jne    1f6 <match+0x27>
    return matchhere(re+1, text);
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	83 c0 01             	add    $0x1,%eax
     1e5:	83 ec 08             	sub    $0x8,%esp
     1e8:	ff 75 0c             	pushl  0xc(%ebp)
     1eb:	50                   	push   %eax
     1ec:	e8 38 00 00 00       	call   229 <matchhere>
     1f1:	83 c4 10             	add    $0x10,%esp
     1f4:	eb 31                	jmp    227 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
     1f6:	83 ec 08             	sub    $0x8,%esp
     1f9:	ff 75 0c             	pushl  0xc(%ebp)
     1fc:	ff 75 08             	pushl  0x8(%ebp)
     1ff:	e8 25 00 00 00       	call   229 <matchhere>
     204:	83 c4 10             	add    $0x10,%esp
     207:	85 c0                	test   %eax,%eax
     209:	74 07                	je     212 <match+0x43>
      return 1;
     20b:	b8 01 00 00 00       	mov    $0x1,%eax
     210:	eb 15                	jmp    227 <match+0x58>
  }while(*text++ != '\0');
     212:	8b 45 0c             	mov    0xc(%ebp),%eax
     215:	8d 50 01             	lea    0x1(%eax),%edx
     218:	89 55 0c             	mov    %edx,0xc(%ebp)
     21b:	0f b6 00             	movzbl (%eax),%eax
     21e:	84 c0                	test   %al,%al
     220:	75 d4                	jne    1f6 <match+0x27>
  return 0;
     222:	b8 00 00 00 00       	mov    $0x0,%eax
}
     227:	c9                   	leave  
     228:	c3                   	ret    

00000229 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     229:	55                   	push   %ebp
     22a:	89 e5                	mov    %esp,%ebp
     22c:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	0f b6 00             	movzbl (%eax),%eax
     235:	84 c0                	test   %al,%al
     237:	75 0a                	jne    243 <matchhere+0x1a>
    return 1;
     239:	b8 01 00 00 00       	mov    $0x1,%eax
     23e:	e9 99 00 00 00       	jmp    2dc <matchhere+0xb3>
  if(re[1] == '*')
     243:	8b 45 08             	mov    0x8(%ebp),%eax
     246:	83 c0 01             	add    $0x1,%eax
     249:	0f b6 00             	movzbl (%eax),%eax
     24c:	3c 2a                	cmp    $0x2a,%al
     24e:	75 21                	jne    271 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
     250:	8b 45 08             	mov    0x8(%ebp),%eax
     253:	8d 50 02             	lea    0x2(%eax),%edx
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	0f b6 00             	movzbl (%eax),%eax
     25c:	0f be c0             	movsbl %al,%eax
     25f:	83 ec 04             	sub    $0x4,%esp
     262:	ff 75 0c             	pushl  0xc(%ebp)
     265:	52                   	push   %edx
     266:	50                   	push   %eax
     267:	e8 72 00 00 00       	call   2de <matchstar>
     26c:	83 c4 10             	add    $0x10,%esp
     26f:	eb 6b                	jmp    2dc <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
     271:	8b 45 08             	mov    0x8(%ebp),%eax
     274:	0f b6 00             	movzbl (%eax),%eax
     277:	3c 24                	cmp    $0x24,%al
     279:	75 1d                	jne    298 <matchhere+0x6f>
     27b:	8b 45 08             	mov    0x8(%ebp),%eax
     27e:	83 c0 01             	add    $0x1,%eax
     281:	0f b6 00             	movzbl (%eax),%eax
     284:	84 c0                	test   %al,%al
     286:	75 10                	jne    298 <matchhere+0x6f>
    return *text == '\0';
     288:	8b 45 0c             	mov    0xc(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	0f 94 c0             	sete   %al
     293:	0f b6 c0             	movzbl %al,%eax
     296:	eb 44                	jmp    2dc <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     298:	8b 45 0c             	mov    0xc(%ebp),%eax
     29b:	0f b6 00             	movzbl (%eax),%eax
     29e:	84 c0                	test   %al,%al
     2a0:	74 35                	je     2d7 <matchhere+0xae>
     2a2:	8b 45 08             	mov    0x8(%ebp),%eax
     2a5:	0f b6 00             	movzbl (%eax),%eax
     2a8:	3c 2e                	cmp    $0x2e,%al
     2aa:	74 10                	je     2bc <matchhere+0x93>
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	0f b6 10             	movzbl (%eax),%edx
     2b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b5:	0f b6 00             	movzbl (%eax),%eax
     2b8:	38 c2                	cmp    %al,%dl
     2ba:	75 1b                	jne    2d7 <matchhere+0xae>
    return matchhere(re+1, text+1);
     2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
     2bf:	8d 50 01             	lea    0x1(%eax),%edx
     2c2:	8b 45 08             	mov    0x8(%ebp),%eax
     2c5:	83 c0 01             	add    $0x1,%eax
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	52                   	push   %edx
     2cc:	50                   	push   %eax
     2cd:	e8 57 ff ff ff       	call   229 <matchhere>
     2d2:	83 c4 10             	add    $0x10,%esp
     2d5:	eb 05                	jmp    2dc <matchhere+0xb3>
  return 0;
     2d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2dc:	c9                   	leave  
     2dd:	c3                   	ret    

000002de <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     2de:	55                   	push   %ebp
     2df:	89 e5                	mov    %esp,%ebp
     2e1:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     2e4:	83 ec 08             	sub    $0x8,%esp
     2e7:	ff 75 10             	pushl  0x10(%ebp)
     2ea:	ff 75 0c             	pushl  0xc(%ebp)
     2ed:	e8 37 ff ff ff       	call   229 <matchhere>
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	85 c0                	test   %eax,%eax
     2f7:	74 07                	je     300 <matchstar+0x22>
      return 1;
     2f9:	b8 01 00 00 00       	mov    $0x1,%eax
     2fe:	eb 29                	jmp    329 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
     300:	8b 45 10             	mov    0x10(%ebp),%eax
     303:	0f b6 00             	movzbl (%eax),%eax
     306:	84 c0                	test   %al,%al
     308:	74 1a                	je     324 <matchstar+0x46>
     30a:	8b 45 10             	mov    0x10(%ebp),%eax
     30d:	8d 50 01             	lea    0x1(%eax),%edx
     310:	89 55 10             	mov    %edx,0x10(%ebp)
     313:	0f b6 00             	movzbl (%eax),%eax
     316:	0f be c0             	movsbl %al,%eax
     319:	3b 45 08             	cmp    0x8(%ebp),%eax
     31c:	74 c6                	je     2e4 <matchstar+0x6>
     31e:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
     322:	74 c0                	je     2e4 <matchstar+0x6>
  return 0;
     324:	b8 00 00 00 00       	mov    $0x0,%eax
}
     329:	c9                   	leave  
     32a:	c3                   	ret    

0000032b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     32b:	55                   	push   %ebp
     32c:	89 e5                	mov    %esp,%ebp
     32e:	57                   	push   %edi
     32f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     330:	8b 4d 08             	mov    0x8(%ebp),%ecx
     333:	8b 55 10             	mov    0x10(%ebp),%edx
     336:	8b 45 0c             	mov    0xc(%ebp),%eax
     339:	89 cb                	mov    %ecx,%ebx
     33b:	89 df                	mov    %ebx,%edi
     33d:	89 d1                	mov    %edx,%ecx
     33f:	fc                   	cld    
     340:	f3 aa                	rep stos %al,%es:(%edi)
     342:	89 ca                	mov    %ecx,%edx
     344:	89 fb                	mov    %edi,%ebx
     346:	89 5d 08             	mov    %ebx,0x8(%ebp)
     349:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     34c:	90                   	nop
     34d:	5b                   	pop    %ebx
     34e:	5f                   	pop    %edi
     34f:	5d                   	pop    %ebp
     350:	c3                   	ret    

00000351 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     351:	55                   	push   %ebp
     352:	89 e5                	mov    %esp,%ebp
     354:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     357:	8b 45 08             	mov    0x8(%ebp),%eax
     35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     35d:	90                   	nop
     35e:	8b 45 08             	mov    0x8(%ebp),%eax
     361:	8d 50 01             	lea    0x1(%eax),%edx
     364:	89 55 08             	mov    %edx,0x8(%ebp)
     367:	8b 55 0c             	mov    0xc(%ebp),%edx
     36a:	8d 4a 01             	lea    0x1(%edx),%ecx
     36d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     370:	0f b6 12             	movzbl (%edx),%edx
     373:	88 10                	mov    %dl,(%eax)
     375:	0f b6 00             	movzbl (%eax),%eax
     378:	84 c0                	test   %al,%al
     37a:	75 e2                	jne    35e <strcpy+0xd>
    ;
  return os;
     37c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     37f:	c9                   	leave  
     380:	c3                   	ret    

00000381 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     381:	55                   	push   %ebp
     382:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     384:	eb 08                	jmp    38e <strcmp+0xd>
    p++, q++;
     386:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     38a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     38e:	8b 45 08             	mov    0x8(%ebp),%eax
     391:	0f b6 00             	movzbl (%eax),%eax
     394:	84 c0                	test   %al,%al
     396:	74 10                	je     3a8 <strcmp+0x27>
     398:	8b 45 08             	mov    0x8(%ebp),%eax
     39b:	0f b6 10             	movzbl (%eax),%edx
     39e:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a1:	0f b6 00             	movzbl (%eax),%eax
     3a4:	38 c2                	cmp    %al,%dl
     3a6:	74 de                	je     386 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     3a8:	8b 45 08             	mov    0x8(%ebp),%eax
     3ab:	0f b6 00             	movzbl (%eax),%eax
     3ae:	0f b6 d0             	movzbl %al,%edx
     3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b4:	0f b6 00             	movzbl (%eax),%eax
     3b7:	0f b6 c0             	movzbl %al,%eax
     3ba:	29 c2                	sub    %eax,%edx
     3bc:	89 d0                	mov    %edx,%eax
}
     3be:	5d                   	pop    %ebp
     3bf:	c3                   	ret    

000003c0 <strlen>:

uint
strlen(char *s)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3cd:	eb 04                	jmp    3d3 <strlen+0x13>
     3cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3d6:	8b 45 08             	mov    0x8(%ebp),%eax
     3d9:	01 d0                	add    %edx,%eax
     3db:	0f b6 00             	movzbl (%eax),%eax
     3de:	84 c0                	test   %al,%al
     3e0:	75 ed                	jne    3cf <strlen+0xf>
    ;
  return n;
     3e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e5:	c9                   	leave  
     3e6:	c3                   	ret    

000003e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
     3e7:	55                   	push   %ebp
     3e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     3ea:	8b 45 10             	mov    0x10(%ebp),%eax
     3ed:	50                   	push   %eax
     3ee:	ff 75 0c             	pushl  0xc(%ebp)
     3f1:	ff 75 08             	pushl  0x8(%ebp)
     3f4:	e8 32 ff ff ff       	call   32b <stosb>
     3f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
     3fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3ff:	c9                   	leave  
     400:	c3                   	ret    

00000401 <strchr>:

char*
strchr(const char *s, char c)
{
     401:	55                   	push   %ebp
     402:	89 e5                	mov    %esp,%ebp
     404:	83 ec 04             	sub    $0x4,%esp
     407:	8b 45 0c             	mov    0xc(%ebp),%eax
     40a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     40d:	eb 14                	jmp    423 <strchr+0x22>
    if(*s == c)
     40f:	8b 45 08             	mov    0x8(%ebp),%eax
     412:	0f b6 00             	movzbl (%eax),%eax
     415:	3a 45 fc             	cmp    -0x4(%ebp),%al
     418:	75 05                	jne    41f <strchr+0x1e>
      return (char*)s;
     41a:	8b 45 08             	mov    0x8(%ebp),%eax
     41d:	eb 13                	jmp    432 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     41f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     423:	8b 45 08             	mov    0x8(%ebp),%eax
     426:	0f b6 00             	movzbl (%eax),%eax
     429:	84 c0                	test   %al,%al
     42b:	75 e2                	jne    40f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     42d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     432:	c9                   	leave  
     433:	c3                   	ret    

00000434 <gets>:

char*
gets(char *buf, int max)
{
     434:	55                   	push   %ebp
     435:	89 e5                	mov    %esp,%ebp
     437:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     441:	eb 42                	jmp    485 <gets+0x51>
    cc = read(0, &c, 1);
     443:	83 ec 04             	sub    $0x4,%esp
     446:	6a 01                	push   $0x1
     448:	8d 45 ef             	lea    -0x11(%ebp),%eax
     44b:	50                   	push   %eax
     44c:	6a 00                	push   $0x0
     44e:	e8 47 01 00 00       	call   59a <read>
     453:	83 c4 10             	add    $0x10,%esp
     456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     45d:	7e 33                	jle    492 <gets+0x5e>
      break;
    buf[i++] = c;
     45f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     462:	8d 50 01             	lea    0x1(%eax),%edx
     465:	89 55 f4             	mov    %edx,-0xc(%ebp)
     468:	89 c2                	mov    %eax,%edx
     46a:	8b 45 08             	mov    0x8(%ebp),%eax
     46d:	01 c2                	add    %eax,%edx
     46f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     473:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     475:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     479:	3c 0a                	cmp    $0xa,%al
     47b:	74 16                	je     493 <gets+0x5f>
     47d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     481:	3c 0d                	cmp    $0xd,%al
     483:	74 0e                	je     493 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     485:	8b 45 f4             	mov    -0xc(%ebp),%eax
     488:	83 c0 01             	add    $0x1,%eax
     48b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     48e:	7c b3                	jl     443 <gets+0xf>
     490:	eb 01                	jmp    493 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     492:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     493:	8b 55 f4             	mov    -0xc(%ebp),%edx
     496:	8b 45 08             	mov    0x8(%ebp),%eax
     499:	01 d0                	add    %edx,%eax
     49b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4a1:	c9                   	leave  
     4a2:	c3                   	ret    

000004a3 <stat>:

int
stat(char *n, struct stat *st)
{
     4a3:	55                   	push   %ebp
     4a4:	89 e5                	mov    %esp,%ebp
     4a6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4a9:	83 ec 08             	sub    $0x8,%esp
     4ac:	6a 00                	push   $0x0
     4ae:	ff 75 08             	pushl  0x8(%ebp)
     4b1:	e8 0c 01 00 00       	call   5c2 <open>
     4b6:	83 c4 10             	add    $0x10,%esp
     4b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     4bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4c0:	79 07                	jns    4c9 <stat+0x26>
    return -1;
     4c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4c7:	eb 25                	jmp    4ee <stat+0x4b>
  r = fstat(fd, st);
     4c9:	83 ec 08             	sub    $0x8,%esp
     4cc:	ff 75 0c             	pushl  0xc(%ebp)
     4cf:	ff 75 f4             	pushl  -0xc(%ebp)
     4d2:	e8 03 01 00 00       	call   5da <fstat>
     4d7:	83 c4 10             	add    $0x10,%esp
     4da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     4dd:	83 ec 0c             	sub    $0xc,%esp
     4e0:	ff 75 f4             	pushl  -0xc(%ebp)
     4e3:	e8 c2 00 00 00       	call   5aa <close>
     4e8:	83 c4 10             	add    $0x10,%esp
  return r;
     4eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     4ee:	c9                   	leave  
     4ef:	c3                   	ret    

000004f0 <atoi>:

int
atoi(const char *s)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     4f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     4fd:	eb 25                	jmp    524 <atoi+0x34>
    n = n*10 + *s++ - '0';
     4ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
     502:	89 d0                	mov    %edx,%eax
     504:	c1 e0 02             	shl    $0x2,%eax
     507:	01 d0                	add    %edx,%eax
     509:	01 c0                	add    %eax,%eax
     50b:	89 c1                	mov    %eax,%ecx
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
     510:	8d 50 01             	lea    0x1(%eax),%edx
     513:	89 55 08             	mov    %edx,0x8(%ebp)
     516:	0f b6 00             	movzbl (%eax),%eax
     519:	0f be c0             	movsbl %al,%eax
     51c:	01 c8                	add    %ecx,%eax
     51e:	83 e8 30             	sub    $0x30,%eax
     521:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     524:	8b 45 08             	mov    0x8(%ebp),%eax
     527:	0f b6 00             	movzbl (%eax),%eax
     52a:	3c 2f                	cmp    $0x2f,%al
     52c:	7e 0a                	jle    538 <atoi+0x48>
     52e:	8b 45 08             	mov    0x8(%ebp),%eax
     531:	0f b6 00             	movzbl (%eax),%eax
     534:	3c 39                	cmp    $0x39,%al
     536:	7e c7                	jle    4ff <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     538:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     53b:	c9                   	leave  
     53c:	c3                   	ret    

0000053d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     53d:	55                   	push   %ebp
     53e:	89 e5                	mov    %esp,%ebp
     540:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     543:	8b 45 08             	mov    0x8(%ebp),%eax
     546:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     549:	8b 45 0c             	mov    0xc(%ebp),%eax
     54c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     54f:	eb 17                	jmp    568 <memmove+0x2b>
    *dst++ = *src++;
     551:	8b 45 fc             	mov    -0x4(%ebp),%eax
     554:	8d 50 01             	lea    0x1(%eax),%edx
     557:	89 55 fc             	mov    %edx,-0x4(%ebp)
     55a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     55d:	8d 4a 01             	lea    0x1(%edx),%ecx
     560:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     563:	0f b6 12             	movzbl (%edx),%edx
     566:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     568:	8b 45 10             	mov    0x10(%ebp),%eax
     56b:	8d 50 ff             	lea    -0x1(%eax),%edx
     56e:	89 55 10             	mov    %edx,0x10(%ebp)
     571:	85 c0                	test   %eax,%eax
     573:	7f dc                	jg     551 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     575:	8b 45 08             	mov    0x8(%ebp),%eax
}
     578:	c9                   	leave  
     579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     57a:	b8 01 00 00 00       	mov    $0x1,%eax
     57f:	cd 40                	int    $0x40
     581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
     582:	b8 02 00 00 00       	mov    $0x2,%eax
     587:	cd 40                	int    $0x40
     589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
     58a:	b8 03 00 00 00       	mov    $0x3,%eax
     58f:	cd 40                	int    $0x40
     591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
     592:	b8 04 00 00 00       	mov    $0x4,%eax
     597:	cd 40                	int    $0x40
     599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
     59a:	b8 05 00 00 00       	mov    $0x5,%eax
     59f:	cd 40                	int    $0x40
     5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
     5a2:	b8 10 00 00 00       	mov    $0x10,%eax
     5a7:	cd 40                	int    $0x40
     5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
     5aa:	b8 15 00 00 00       	mov    $0x15,%eax
     5af:	cd 40                	int    $0x40
     5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
     5b2:	b8 06 00 00 00       	mov    $0x6,%eax
     5b7:	cd 40                	int    $0x40
     5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
     5ba:	b8 07 00 00 00       	mov    $0x7,%eax
     5bf:	cd 40                	int    $0x40
     5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
     5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
     5c7:	cd 40                	int    $0x40
     5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
     5ca:	b8 11 00 00 00       	mov    $0x11,%eax
     5cf:	cd 40                	int    $0x40
     5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
     5d2:	b8 12 00 00 00       	mov    $0x12,%eax
     5d7:	cd 40                	int    $0x40
     5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
     5da:	b8 08 00 00 00       	mov    $0x8,%eax
     5df:	cd 40                	int    $0x40
     5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
     5e2:	b8 13 00 00 00       	mov    $0x13,%eax
     5e7:	cd 40                	int    $0x40
     5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
     5ea:	b8 14 00 00 00       	mov    $0x14,%eax
     5ef:	cd 40                	int    $0x40
     5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
     5f2:	b8 09 00 00 00       	mov    $0x9,%eax
     5f7:	cd 40                	int    $0x40
     5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
     5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
     5ff:	cd 40                	int    $0x40
     601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
     602:	b8 0b 00 00 00       	mov    $0xb,%eax
     607:	cd 40                	int    $0x40
     609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
     60a:	b8 0c 00 00 00       	mov    $0xc,%eax
     60f:	cd 40                	int    $0x40
     611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
     612:	b8 0d 00 00 00       	mov    $0xd,%eax
     617:	cd 40                	int    $0x40
     619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
     61a:	b8 0e 00 00 00       	mov    $0xe,%eax
     61f:	cd 40                	int    $0x40
     621:	c3                   	ret    

00000622 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     622:	b8 16 00 00 00       	mov    $0x16,%eax
     627:	cd 40                	int    $0x40
     629:	c3                   	ret    

0000062a <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     62a:	b8 17 00 00 00       	mov    $0x17,%eax
     62f:	cd 40                	int    $0x40
     631:	c3                   	ret    

00000632 <clearScreen>:
SYSCALL(clearScreen)
     632:	b8 18 00 00 00       	mov    $0x18,%eax
     637:	cd 40                	int    $0x40
     639:	c3                   	ret    

0000063a <writeAt>:
SYSCALL(writeAt)
     63a:	b8 19 00 00 00       	mov    $0x19,%eax
     63f:	cd 40                	int    $0x40
     641:	c3                   	ret    

00000642 <setBufferFlag>:
SYSCALL(setBufferFlag)
     642:	b8 1a 00 00 00       	mov    $0x1a,%eax
     647:	cd 40                	int    $0x40
     649:	c3                   	ret    

0000064a <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     64a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     64f:	cd 40                	int    $0x40
     651:	c3                   	ret    

00000652 <getCursorPos>:
SYSCALL(getCursorPos)
     652:	b8 1c 00 00 00       	mov    $0x1c,%eax
     657:	cd 40                	int    $0x40
     659:	c3                   	ret    

0000065a <saveScreen>:
SYSCALL(saveScreen)
     65a:	b8 1d 00 00 00       	mov    $0x1d,%eax
     65f:	cd 40                	int    $0x40
     661:	c3                   	ret    

00000662 <recorverScreen>:
SYSCALL(recorverScreen)
     662:	b8 1e 00 00 00       	mov    $0x1e,%eax
     667:	cd 40                	int    $0x40
     669:	c3                   	ret    

0000066a <ToScreen>:
SYSCALL(ToScreen)
     66a:	b8 1f 00 00 00       	mov    $0x1f,%eax
     66f:	cd 40                	int    $0x40
     671:	c3                   	ret    

00000672 <getColor>:
SYSCALL(getColor)
     672:	b8 20 00 00 00       	mov    $0x20,%eax
     677:	cd 40                	int    $0x40
     679:	c3                   	ret    

0000067a <showC>:
SYSCALL(showC)
     67a:	b8 21 00 00 00       	mov    $0x21,%eax
     67f:	cd 40                	int    $0x40
     681:	c3                   	ret    

00000682 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     682:	55                   	push   %ebp
     683:	89 e5                	mov    %esp,%ebp
     685:	83 ec 18             	sub    $0x18,%esp
     688:	8b 45 0c             	mov    0xc(%ebp),%eax
     68b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     68e:	83 ec 04             	sub    $0x4,%esp
     691:	6a 01                	push   $0x1
     693:	8d 45 f4             	lea    -0xc(%ebp),%eax
     696:	50                   	push   %eax
     697:	ff 75 08             	pushl  0x8(%ebp)
     69a:	e8 03 ff ff ff       	call   5a2 <write>
     69f:	83 c4 10             	add    $0x10,%esp
}
     6a2:	90                   	nop
     6a3:	c9                   	leave  
     6a4:	c3                   	ret    

000006a5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6a5:	55                   	push   %ebp
     6a6:	89 e5                	mov    %esp,%ebp
     6a8:	53                   	push   %ebx
     6a9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6b3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6b7:	74 17                	je     6d0 <printint+0x2b>
     6b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6bd:	79 11                	jns    6d0 <printint+0x2b>
    neg = 1;
     6bf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c9:	f7 d8                	neg    %eax
     6cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6ce:	eb 06                	jmp    6d6 <printint+0x31>
  } else {
    x = xx;
     6d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6dd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6e0:	8d 41 01             	lea    0x1(%ecx),%eax
     6e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ec:	ba 00 00 00 00       	mov    $0x0,%edx
     6f1:	f7 f3                	div    %ebx
     6f3:	89 d0                	mov    %edx,%eax
     6f5:	0f b6 80 1c 1d 00 00 	movzbl 0x1d1c(%eax),%eax
     6fc:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     700:	8b 5d 10             	mov    0x10(%ebp),%ebx
     703:	8b 45 ec             	mov    -0x14(%ebp),%eax
     706:	ba 00 00 00 00       	mov    $0x0,%edx
     70b:	f7 f3                	div    %ebx
     70d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     710:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     714:	75 c7                	jne    6dd <printint+0x38>
  if(neg)
     716:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     71a:	74 2d                	je     749 <printint+0xa4>
    buf[i++] = '-';
     71c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71f:	8d 50 01             	lea    0x1(%eax),%edx
     722:	89 55 f4             	mov    %edx,-0xc(%ebp)
     725:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     72a:	eb 1d                	jmp    749 <printint+0xa4>
    putc(fd, buf[i]);
     72c:	8d 55 dc             	lea    -0x24(%ebp),%edx
     72f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     732:	01 d0                	add    %edx,%eax
     734:	0f b6 00             	movzbl (%eax),%eax
     737:	0f be c0             	movsbl %al,%eax
     73a:	83 ec 08             	sub    $0x8,%esp
     73d:	50                   	push   %eax
     73e:	ff 75 08             	pushl  0x8(%ebp)
     741:	e8 3c ff ff ff       	call   682 <putc>
     746:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     749:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     74d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     751:	79 d9                	jns    72c <printint+0x87>
    putc(fd, buf[i]);
}
     753:	90                   	nop
     754:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     757:	c9                   	leave  
     758:	c3                   	ret    

00000759 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     759:	55                   	push   %ebp
     75a:	89 e5                	mov    %esp,%ebp
     75c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     75f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     766:	8d 45 0c             	lea    0xc(%ebp),%eax
     769:	83 c0 04             	add    $0x4,%eax
     76c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     76f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     776:	e9 59 01 00 00       	jmp    8d4 <printf+0x17b>
    c = fmt[i] & 0xff;
     77b:	8b 55 0c             	mov    0xc(%ebp),%edx
     77e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     781:	01 d0                	add    %edx,%eax
     783:	0f b6 00             	movzbl (%eax),%eax
     786:	0f be c0             	movsbl %al,%eax
     789:	25 ff 00 00 00       	and    $0xff,%eax
     78e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     791:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     795:	75 2c                	jne    7c3 <printf+0x6a>
      if(c == '%'){
     797:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     79b:	75 0c                	jne    7a9 <printf+0x50>
        state = '%';
     79d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7a4:	e9 27 01 00 00       	jmp    8d0 <printf+0x177>
      } else {
        putc(fd, c);
     7a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ac:	0f be c0             	movsbl %al,%eax
     7af:	83 ec 08             	sub    $0x8,%esp
     7b2:	50                   	push   %eax
     7b3:	ff 75 08             	pushl  0x8(%ebp)
     7b6:	e8 c7 fe ff ff       	call   682 <putc>
     7bb:	83 c4 10             	add    $0x10,%esp
     7be:	e9 0d 01 00 00       	jmp    8d0 <printf+0x177>
      }
    } else if(state == '%'){
     7c3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7c7:	0f 85 03 01 00 00    	jne    8d0 <printf+0x177>
      if(c == 'd'){
     7cd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7d1:	75 1e                	jne    7f1 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d6:	8b 00                	mov    (%eax),%eax
     7d8:	6a 01                	push   $0x1
     7da:	6a 0a                	push   $0xa
     7dc:	50                   	push   %eax
     7dd:	ff 75 08             	pushl  0x8(%ebp)
     7e0:	e8 c0 fe ff ff       	call   6a5 <printint>
     7e5:	83 c4 10             	add    $0x10,%esp
        ap++;
     7e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ec:	e9 d8 00 00 00       	jmp    8c9 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7f1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7f5:	74 06                	je     7fd <printf+0xa4>
     7f7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7fb:	75 1e                	jne    81b <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     800:	8b 00                	mov    (%eax),%eax
     802:	6a 00                	push   $0x0
     804:	6a 10                	push   $0x10
     806:	50                   	push   %eax
     807:	ff 75 08             	pushl  0x8(%ebp)
     80a:	e8 96 fe ff ff       	call   6a5 <printint>
     80f:	83 c4 10             	add    $0x10,%esp
        ap++;
     812:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     816:	e9 ae 00 00 00       	jmp    8c9 <printf+0x170>
      } else if(c == 's'){
     81b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     81f:	75 43                	jne    864 <printf+0x10b>
        s = (char*)*ap;
     821:	8b 45 e8             	mov    -0x18(%ebp),%eax
     824:	8b 00                	mov    (%eax),%eax
     826:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     829:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     82d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     831:	75 25                	jne    858 <printf+0xff>
          s = "(null)";
     833:	c7 45 f4 7a 15 00 00 	movl   $0x157a,-0xc(%ebp)
        while(*s != 0){
     83a:	eb 1c                	jmp    858 <printf+0xff>
          putc(fd, *s);
     83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83f:	0f b6 00             	movzbl (%eax),%eax
     842:	0f be c0             	movsbl %al,%eax
     845:	83 ec 08             	sub    $0x8,%esp
     848:	50                   	push   %eax
     849:	ff 75 08             	pushl  0x8(%ebp)
     84c:	e8 31 fe ff ff       	call   682 <putc>
     851:	83 c4 10             	add    $0x10,%esp
          s++;
     854:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     858:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85b:	0f b6 00             	movzbl (%eax),%eax
     85e:	84 c0                	test   %al,%al
     860:	75 da                	jne    83c <printf+0xe3>
     862:	eb 65                	jmp    8c9 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     864:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     868:	75 1d                	jne    887 <printf+0x12e>
        putc(fd, *ap);
     86a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     86d:	8b 00                	mov    (%eax),%eax
     86f:	0f be c0             	movsbl %al,%eax
     872:	83 ec 08             	sub    $0x8,%esp
     875:	50                   	push   %eax
     876:	ff 75 08             	pushl  0x8(%ebp)
     879:	e8 04 fe ff ff       	call   682 <putc>
     87e:	83 c4 10             	add    $0x10,%esp
        ap++;
     881:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     885:	eb 42                	jmp    8c9 <printf+0x170>
      } else if(c == '%'){
     887:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     88b:	75 17                	jne    8a4 <printf+0x14b>
        putc(fd, c);
     88d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     890:	0f be c0             	movsbl %al,%eax
     893:	83 ec 08             	sub    $0x8,%esp
     896:	50                   	push   %eax
     897:	ff 75 08             	pushl  0x8(%ebp)
     89a:	e8 e3 fd ff ff       	call   682 <putc>
     89f:	83 c4 10             	add    $0x10,%esp
     8a2:	eb 25                	jmp    8c9 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8a4:	83 ec 08             	sub    $0x8,%esp
     8a7:	6a 25                	push   $0x25
     8a9:	ff 75 08             	pushl  0x8(%ebp)
     8ac:	e8 d1 fd ff ff       	call   682 <putc>
     8b1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8b7:	0f be c0             	movsbl %al,%eax
     8ba:	83 ec 08             	sub    $0x8,%esp
     8bd:	50                   	push   %eax
     8be:	ff 75 08             	pushl  0x8(%ebp)
     8c1:	e8 bc fd ff ff       	call   682 <putc>
     8c6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8d0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8d4:	8b 55 0c             	mov    0xc(%ebp),%edx
     8d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8da:	01 d0                	add    %edx,%eax
     8dc:	0f b6 00             	movzbl (%eax),%eax
     8df:	84 c0                	test   %al,%al
     8e1:	0f 85 94 fe ff ff    	jne    77b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8e7:	90                   	nop
     8e8:	c9                   	leave  
     8e9:	c3                   	ret    

000008ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8ea:	55                   	push   %ebp
     8eb:	89 e5                	mov    %esp,%ebp
     8ed:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8f0:	8b 45 08             	mov    0x8(%ebp),%eax
     8f3:	83 e8 08             	sub    $0x8,%eax
     8f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8f9:	a1 48 1d 00 00       	mov    0x1d48,%eax
     8fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
     901:	eb 24                	jmp    927 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     903:	8b 45 fc             	mov    -0x4(%ebp),%eax
     906:	8b 00                	mov    (%eax),%eax
     908:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     90b:	77 12                	ja     91f <free+0x35>
     90d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     910:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     913:	77 24                	ja     939 <free+0x4f>
     915:	8b 45 fc             	mov    -0x4(%ebp),%eax
     918:	8b 00                	mov    (%eax),%eax
     91a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     91d:	77 1a                	ja     939 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     91f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     922:	8b 00                	mov    (%eax),%eax
     924:	89 45 fc             	mov    %eax,-0x4(%ebp)
     927:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     92d:	76 d4                	jbe    903 <free+0x19>
     92f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     932:	8b 00                	mov    (%eax),%eax
     934:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     937:	76 ca                	jbe    903 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     939:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93c:	8b 40 04             	mov    0x4(%eax),%eax
     93f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     946:	8b 45 f8             	mov    -0x8(%ebp),%eax
     949:	01 c2                	add    %eax,%edx
     94b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94e:	8b 00                	mov    (%eax),%eax
     950:	39 c2                	cmp    %eax,%edx
     952:	75 24                	jne    978 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     954:	8b 45 f8             	mov    -0x8(%ebp),%eax
     957:	8b 50 04             	mov    0x4(%eax),%edx
     95a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95d:	8b 00                	mov    (%eax),%eax
     95f:	8b 40 04             	mov    0x4(%eax),%eax
     962:	01 c2                	add    %eax,%edx
     964:	8b 45 f8             	mov    -0x8(%ebp),%eax
     967:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     96a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96d:	8b 00                	mov    (%eax),%eax
     96f:	8b 10                	mov    (%eax),%edx
     971:	8b 45 f8             	mov    -0x8(%ebp),%eax
     974:	89 10                	mov    %edx,(%eax)
     976:	eb 0a                	jmp    982 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     978:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97b:	8b 10                	mov    (%eax),%edx
     97d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     980:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     982:	8b 45 fc             	mov    -0x4(%ebp),%eax
     985:	8b 40 04             	mov    0x4(%eax),%eax
     988:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     98f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     992:	01 d0                	add    %edx,%eax
     994:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     997:	75 20                	jne    9b9 <free+0xcf>
    p->s.size += bp->s.size;
     999:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99c:	8b 50 04             	mov    0x4(%eax),%edx
     99f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a2:	8b 40 04             	mov    0x4(%eax),%eax
     9a5:	01 c2                	add    %eax,%edx
     9a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9aa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b0:	8b 10                	mov    (%eax),%edx
     9b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b5:	89 10                	mov    %edx,(%eax)
     9b7:	eb 08                	jmp    9c1 <free+0xd7>
  } else
    p->s.ptr = bp;
     9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9bf:	89 10                	mov    %edx,(%eax)
  freep = p;
     9c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c4:	a3 48 1d 00 00       	mov    %eax,0x1d48
}
     9c9:	90                   	nop
     9ca:	c9                   	leave  
     9cb:	c3                   	ret    

000009cc <morecore>:

static Header*
morecore(uint nu)
{
     9cc:	55                   	push   %ebp
     9cd:	89 e5                	mov    %esp,%ebp
     9cf:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9d2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9d9:	77 07                	ja     9e2 <morecore+0x16>
    nu = 4096;
     9db:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9e2:	8b 45 08             	mov    0x8(%ebp),%eax
     9e5:	c1 e0 03             	shl    $0x3,%eax
     9e8:	83 ec 0c             	sub    $0xc,%esp
     9eb:	50                   	push   %eax
     9ec:	e8 19 fc ff ff       	call   60a <sbrk>
     9f1:	83 c4 10             	add    $0x10,%esp
     9f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9f7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9fb:	75 07                	jne    a04 <morecore+0x38>
    return 0;
     9fd:	b8 00 00 00 00       	mov    $0x0,%eax
     a02:	eb 26                	jmp    a2a <morecore+0x5e>
  hp = (Header*)p;
     a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a0d:	8b 55 08             	mov    0x8(%ebp),%edx
     a10:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a16:	83 c0 08             	add    $0x8,%eax
     a19:	83 ec 0c             	sub    $0xc,%esp
     a1c:	50                   	push   %eax
     a1d:	e8 c8 fe ff ff       	call   8ea <free>
     a22:	83 c4 10             	add    $0x10,%esp
  return freep;
     a25:	a1 48 1d 00 00       	mov    0x1d48,%eax
}
     a2a:	c9                   	leave  
     a2b:	c3                   	ret    

00000a2c <malloc>:

void*
malloc(uint nbytes)
{
     a2c:	55                   	push   %ebp
     a2d:	89 e5                	mov    %esp,%ebp
     a2f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a32:	8b 45 08             	mov    0x8(%ebp),%eax
     a35:	83 c0 07             	add    $0x7,%eax
     a38:	c1 e8 03             	shr    $0x3,%eax
     a3b:	83 c0 01             	add    $0x1,%eax
     a3e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a41:	a1 48 1d 00 00       	mov    0x1d48,%eax
     a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a49:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a4d:	75 23                	jne    a72 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a4f:	c7 45 f0 40 1d 00 00 	movl   $0x1d40,-0x10(%ebp)
     a56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a59:	a3 48 1d 00 00       	mov    %eax,0x1d48
     a5e:	a1 48 1d 00 00       	mov    0x1d48,%eax
     a63:	a3 40 1d 00 00       	mov    %eax,0x1d40
    base.s.size = 0;
     a68:	c7 05 44 1d 00 00 00 	movl   $0x0,0x1d44
     a6f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a75:	8b 00                	mov    (%eax),%eax
     a77:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7d:	8b 40 04             	mov    0x4(%eax),%eax
     a80:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a83:	72 4d                	jb     ad2 <malloc+0xa6>
      if(p->s.size == nunits)
     a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a88:	8b 40 04             	mov    0x4(%eax),%eax
     a8b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a8e:	75 0c                	jne    a9c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a93:	8b 10                	mov    (%eax),%edx
     a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a98:	89 10                	mov    %edx,(%eax)
     a9a:	eb 26                	jmp    ac2 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9f:	8b 40 04             	mov    0x4(%eax),%eax
     aa2:	2b 45 ec             	sub    -0x14(%ebp),%eax
     aa5:	89 c2                	mov    %eax,%edx
     aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaa:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	8b 40 04             	mov    0x4(%eax),%eax
     ab3:	c1 e0 03             	shl    $0x3,%eax
     ab6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abc:	8b 55 ec             	mov    -0x14(%ebp),%edx
     abf:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac5:	a3 48 1d 00 00       	mov    %eax,0x1d48
      return (void*)(p + 1);
     aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acd:	83 c0 08             	add    $0x8,%eax
     ad0:	eb 3b                	jmp    b0d <malloc+0xe1>
    }
    if(p == freep)
     ad2:	a1 48 1d 00 00       	mov    0x1d48,%eax
     ad7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ada:	75 1e                	jne    afa <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     adc:	83 ec 0c             	sub    $0xc,%esp
     adf:	ff 75 ec             	pushl  -0x14(%ebp)
     ae2:	e8 e5 fe ff ff       	call   9cc <morecore>
     ae7:	83 c4 10             	add    $0x10,%esp
     aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
     aed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     af1:	75 07                	jne    afa <malloc+0xce>
        return 0;
     af3:	b8 00 00 00 00       	mov    $0x0,%eax
     af8:	eb 13                	jmp    b0d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afd:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b03:	8b 00                	mov    (%eax),%eax
     b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b08:	e9 6d ff ff ff       	jmp    a7a <malloc+0x4e>
}
     b0d:	c9                   	leave  
     b0e:	c3                   	ret    

00000b0f <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
     b0f:	55                   	push   %ebp
     b10:	89 e5                	mov    %esp,%ebp
     b12:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
     b15:	83 ec 0c             	sub    $0xc,%esp
     b18:	ff 75 08             	pushl  0x8(%ebp)
     b1b:	e8 b0 00 00 00       	call   bd0 <re_compile>
     b20:	83 c4 10             	add    $0x10,%esp
     b23:	83 ec 04             	sub    $0x4,%esp
     b26:	ff 75 10             	pushl  0x10(%ebp)
     b29:	ff 75 0c             	pushl  0xc(%ebp)
     b2c:	50                   	push   %eax
     b2d:	e8 05 00 00 00       	call   b37 <re_matchp>
     b32:	83 c4 10             	add    $0x10,%esp
}
     b35:	c9                   	leave  
     b36:	c3                   	ret    

00000b37 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
     b37:	55                   	push   %ebp
     b38:	89 e5                	mov    %esp,%ebp
     b3a:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
     b3d:	8b 45 10             	mov    0x10(%ebp),%eax
     b40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
     b46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b4a:	74 7d                	je     bc9 <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
     b4c:	8b 45 08             	mov    0x8(%ebp),%eax
     b4f:	0f b6 00             	movzbl (%eax),%eax
     b52:	3c 02                	cmp    $0x2,%al
     b54:	75 2a                	jne    b80 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
     b56:	8b 45 08             	mov    0x8(%ebp),%eax
     b59:	83 c0 08             	add    $0x8,%eax
     b5c:	83 ec 04             	sub    $0x4,%esp
     b5f:	ff 75 10             	pushl  0x10(%ebp)
     b62:	ff 75 0c             	pushl  0xc(%ebp)
     b65:	50                   	push   %eax
     b66:	e8 b0 08 00 00       	call   141b <matchpattern>
     b6b:	83 c4 10             	add    $0x10,%esp
     b6e:	85 c0                	test   %eax,%eax
     b70:	74 07                	je     b79 <re_matchp+0x42>
     b72:	b8 00 00 00 00       	mov    $0x0,%eax
     b77:	eb 55                	jmp    bce <re_matchp+0x97>
     b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b7e:	eb 4e                	jmp    bce <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
     b80:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
     b87:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
     b8b:	83 ec 04             	sub    $0x4,%esp
     b8e:	ff 75 10             	pushl  0x10(%ebp)
     b91:	ff 75 0c             	pushl  0xc(%ebp)
     b94:	ff 75 08             	pushl  0x8(%ebp)
     b97:	e8 7f 08 00 00       	call   141b <matchpattern>
     b9c:	83 c4 10             	add    $0x10,%esp
     b9f:	85 c0                	test   %eax,%eax
     ba1:	74 16                	je     bb9 <re_matchp+0x82>
        {
          if (text[0] == '\0')
     ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba6:	0f b6 00             	movzbl (%eax),%eax
     ba9:	84 c0                	test   %al,%al
     bab:	75 07                	jne    bb4 <re_matchp+0x7d>
            return -1;
     bad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bb2:	eb 1a                	jmp    bce <re_matchp+0x97>
        
          return idx;
     bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb7:	eb 15                	jmp    bce <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
     bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbc:	8d 50 01             	lea    0x1(%eax),%edx
     bbf:	89 55 0c             	mov    %edx,0xc(%ebp)
     bc2:	0f b6 00             	movzbl (%eax),%eax
     bc5:	84 c0                	test   %al,%al
     bc7:	75 be                	jne    b87 <re_matchp+0x50>
    }
  }
  return -1;
     bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     bce:	c9                   	leave  
     bcf:	c3                   	ret    

00000bd0 <re_compile>:

re_t re_compile(const char* pattern)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
     bd6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
     bdd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
     be4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     beb:	e9 55 02 00 00       	jmp    e45 <re_compile+0x275>
  {
    c = pattern[i];
     bf0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bf3:	8b 45 08             	mov    0x8(%ebp),%eax
     bf6:	01 d0                	add    %edx,%eax
     bf8:	0f b6 00             	movzbl (%eax),%eax
     bfb:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
     bfe:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
     c02:	83 e8 24             	sub    $0x24,%eax
     c05:	83 f8 3a             	cmp    $0x3a,%eax
     c08:	0f 87 13 02 00 00    	ja     e21 <re_compile+0x251>
     c0e:	8b 04 85 84 15 00 00 	mov    0x1584(,%eax,4),%eax
     c15:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c1a:	c6 04 c5 60 1d 00 00 	movb   $0x2,0x1d60(,%eax,8)
     c21:	02 
     c22:	e9 16 02 00 00       	jmp    e3d <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2a:	c6 04 c5 60 1d 00 00 	movb   $0x3,0x1d60(,%eax,8)
     c31:	03 
     c32:	e9 06 02 00 00       	jmp    e3d <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3a:	c6 04 c5 60 1d 00 00 	movb   $0x1,0x1d60(,%eax,8)
     c41:	01 
     c42:	e9 f6 01 00 00       	jmp    e3d <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4a:	c6 04 c5 60 1d 00 00 	movb   $0x5,0x1d60(,%eax,8)
     c51:	05 
     c52:	e9 e6 01 00 00       	jmp    e3d <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5a:	c6 04 c5 60 1d 00 00 	movb   $0x6,0x1d60(,%eax,8)
     c61:	06 
     c62:	e9 d6 01 00 00       	jmp    e3d <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6a:	c6 04 c5 60 1d 00 00 	movb   $0x4,0x1d60(,%eax,8)
     c71:	04 
     c72:	e9 c6 01 00 00       	jmp    e3d <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     c77:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c7a:	8d 50 01             	lea    0x1(%eax),%edx
     c7d:	8b 45 08             	mov    0x8(%ebp),%eax
     c80:	01 d0                	add    %edx,%eax
     c82:	0f b6 00             	movzbl (%eax),%eax
     c85:	84 c0                	test   %al,%al
     c87:	0f 84 af 01 00 00    	je     e3c <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     c8d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     c91:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	01 d0                	add    %edx,%eax
     c99:	0f b6 00             	movzbl (%eax),%eax
     c9c:	0f be c0             	movsbl %al,%eax
     c9f:	83 e8 44             	sub    $0x44,%eax
     ca2:	83 f8 33             	cmp    $0x33,%eax
     ca5:	77 57                	ja     cfe <re_compile+0x12e>
     ca7:	8b 04 85 70 16 00 00 	mov    0x1670(,%eax,4),%eax
     cae:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     cb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb3:	c6 04 c5 60 1d 00 00 	movb   $0xa,0x1d60(,%eax,8)
     cba:	0a 
     cbb:	eb 64                	jmp    d21 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc0:	c6 04 c5 60 1d 00 00 	movb   $0xb,0x1d60(,%eax,8)
     cc7:	0b 
     cc8:	eb 57                	jmp    d21 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccd:	c6 04 c5 60 1d 00 00 	movb   $0xc,0x1d60(,%eax,8)
     cd4:	0c 
     cd5:	eb 4a                	jmp    d21 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cda:	c6 04 c5 60 1d 00 00 	movb   $0xd,0x1d60(,%eax,8)
     ce1:	0d 
     ce2:	eb 3d                	jmp    d21 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce7:	c6 04 c5 60 1d 00 00 	movb   $0xe,0x1d60(,%eax,8)
     cee:	0e 
     cef:	eb 30                	jmp    d21 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf4:	c6 04 c5 60 1d 00 00 	movb   $0xf,0x1d60(,%eax,8)
     cfb:	0f 
     cfc:	eb 23                	jmp    d21 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d01:	c6 04 c5 60 1d 00 00 	movb   $0x7,0x1d60(,%eax,8)
     d08:	07 
              re_compiled[j].ch = pattern[i];
     d09:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d0c:	8b 45 08             	mov    0x8(%ebp),%eax
     d0f:	01 d0                	add    %edx,%eax
     d11:	0f b6 00             	movzbl (%eax),%eax
     d14:	89 c2                	mov    %eax,%edx
     d16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d19:	88 14 c5 64 1d 00 00 	mov    %dl,0x1d64(,%eax,8)
            } break;
     d20:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     d21:	e9 16 01 00 00       	jmp    e3c <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     d26:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d29:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     d2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d2f:	8d 50 01             	lea    0x1(%eax),%edx
     d32:	8b 45 08             	mov    0x8(%ebp),%eax
     d35:	01 d0                	add    %edx,%eax
     d37:	0f b6 00             	movzbl (%eax),%eax
     d3a:	3c 5e                	cmp    $0x5e,%al
     d3c:	75 11                	jne    d4f <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d41:	c6 04 c5 60 1d 00 00 	movb   $0x9,0x1d60(,%eax,8)
     d48:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     d49:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d4d:	eb 7a                	jmp    dc9 <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d52:	c6 04 c5 60 1d 00 00 	movb   $0x8,0x1d60(,%eax,8)
     d59:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     d5a:	eb 6d                	jmp    dc9 <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     d5c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d5f:	8b 45 08             	mov    0x8(%ebp),%eax
     d62:	01 d0                	add    %edx,%eax
     d64:	0f b6 00             	movzbl (%eax),%eax
     d67:	3c 5c                	cmp    $0x5c,%al
     d69:	75 34                	jne    d9f <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     d6b:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     d6f:	7e 0a                	jle    d7b <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     d71:	b8 00 00 00 00       	mov    $0x0,%eax
     d76:	e9 f8 00 00 00       	jmp    e73 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     d7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d7e:	8d 50 01             	lea    0x1(%eax),%edx
     d81:	89 55 fc             	mov    %edx,-0x4(%ebp)
     d84:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d87:	8d 4a 01             	lea    0x1(%edx),%ecx
     d8a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     d8d:	89 d1                	mov    %edx,%ecx
     d8f:	8b 55 08             	mov    0x8(%ebp),%edx
     d92:	01 ca                	add    %ecx,%edx
     d94:	0f b6 12             	movzbl (%edx),%edx
     d97:	88 90 60 1e 00 00    	mov    %dl,0x1e60(%eax)
     d9d:	eb 10                	jmp    daf <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     d9f:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     da3:	7e 0a                	jle    daf <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     da5:	b8 00 00 00 00       	mov    $0x0,%eax
     daa:	e9 c4 00 00 00       	jmp    e73 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     daf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     db2:	8d 50 01             	lea    0x1(%eax),%edx
     db5:	89 55 fc             	mov    %edx,-0x4(%ebp)
     db8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     dbb:	8b 55 08             	mov    0x8(%ebp),%edx
     dbe:	01 ca                	add    %ecx,%edx
     dc0:	0f b6 12             	movzbl (%edx),%edx
     dc3:	88 90 60 1e 00 00    	mov    %dl,0x1e60(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     dc9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dcd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     dd0:	8b 45 08             	mov    0x8(%ebp),%eax
     dd3:	01 d0                	add    %edx,%eax
     dd5:	0f b6 00             	movzbl (%eax),%eax
     dd8:	3c 5d                	cmp    $0x5d,%al
     dda:	74 13                	je     def <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     ddc:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ddf:	8b 45 08             	mov    0x8(%ebp),%eax
     de2:	01 d0                	add    %edx,%eax
     de4:	0f b6 00             	movzbl (%eax),%eax
     de7:	84 c0                	test   %al,%al
     de9:	0f 85 6d ff ff ff    	jne    d5c <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     def:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     df3:	7e 07                	jle    dfc <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     df5:	b8 00 00 00 00       	mov    $0x0,%eax
     dfa:	eb 77                	jmp    e73 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dff:	8d 50 01             	lea    0x1(%eax),%edx
     e02:	89 55 fc             	mov    %edx,-0x4(%ebp)
     e05:	c6 80 60 1e 00 00 00 	movb   $0x0,0x1e60(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     e0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e0f:	8d 90 60 1e 00 00    	lea    0x1e60(%eax),%edx
     e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e18:	89 14 c5 64 1d 00 00 	mov    %edx,0x1d64(,%eax,8)
      } break;
     e1f:	eb 1c                	jmp    e3d <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e24:	c6 04 c5 60 1d 00 00 	movb   $0x7,0x1d60(,%eax,8)
     e2b:	07 
        re_compiled[j].ch = c;
     e2c:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e33:	88 14 c5 64 1d 00 00 	mov    %dl,0x1d64(,%eax,8)
      } break;
     e3a:	eb 01                	jmp    e3d <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     e3c:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     e3d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     e41:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     e45:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	01 d0                	add    %edx,%eax
     e4d:	0f b6 00             	movzbl (%eax),%eax
     e50:	84 c0                	test   %al,%al
     e52:	74 0f                	je     e63 <re_compile+0x293>
     e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e57:	83 c0 01             	add    $0x1,%eax
     e5a:	83 f8 1d             	cmp    $0x1d,%eax
     e5d:	0f 8e 8d fd ff ff    	jle    bf0 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e66:	c6 04 c5 60 1d 00 00 	movb   $0x0,0x1d60(,%eax,8)
     e6d:	00 

  return (re_t) re_compiled;
     e6e:	b8 60 1d 00 00       	mov    $0x1d60,%eax
}
     e73:	c9                   	leave  
     e74:	c3                   	ret    

00000e75 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
     e75:	55                   	push   %ebp
     e76:	89 e5                	mov    %esp,%ebp
     e78:	83 ec 04             	sub    $0x4,%esp
     e7b:	8b 45 08             	mov    0x8(%ebp),%eax
     e7e:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     e81:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     e85:	7e 0d                	jle    e94 <matchdigit+0x1f>
     e87:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     e8b:	7f 07                	jg     e94 <matchdigit+0x1f>
     e8d:	b8 01 00 00 00       	mov    $0x1,%eax
     e92:	eb 05                	jmp    e99 <matchdigit+0x24>
     e94:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e99:	c9                   	leave  
     e9a:	c3                   	ret    

00000e9b <matchalpha>:
static int matchalpha(char c)
{
     e9b:	55                   	push   %ebp
     e9c:	89 e5                	mov    %esp,%ebp
     e9e:	83 ec 04             	sub    $0x4,%esp
     ea1:	8b 45 08             	mov    0x8(%ebp),%eax
     ea4:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     ea7:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     eab:	7e 06                	jle    eb3 <matchalpha+0x18>
     ead:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     eb1:	7e 0c                	jle    ebf <matchalpha+0x24>
     eb3:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     eb7:	7e 0d                	jle    ec6 <matchalpha+0x2b>
     eb9:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     ebd:	7f 07                	jg     ec6 <matchalpha+0x2b>
     ebf:	b8 01 00 00 00       	mov    $0x1,%eax
     ec4:	eb 05                	jmp    ecb <matchalpha+0x30>
     ec6:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ecb:	c9                   	leave  
     ecc:	c3                   	ret    

00000ecd <matchwhitespace>:
static int matchwhitespace(char c)
{
     ecd:	55                   	push   %ebp
     ece:	89 e5                	mov    %esp,%ebp
     ed0:	83 ec 04             	sub    $0x4,%esp
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     ed9:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     edd:	74 1e                	je     efd <matchwhitespace+0x30>
     edf:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     ee3:	74 18                	je     efd <matchwhitespace+0x30>
     ee5:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     ee9:	74 12                	je     efd <matchwhitespace+0x30>
     eeb:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     eef:	74 0c                	je     efd <matchwhitespace+0x30>
     ef1:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     ef5:	74 06                	je     efd <matchwhitespace+0x30>
     ef7:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     efb:	75 07                	jne    f04 <matchwhitespace+0x37>
     efd:	b8 01 00 00 00       	mov    $0x1,%eax
     f02:	eb 05                	jmp    f09 <matchwhitespace+0x3c>
     f04:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f09:	c9                   	leave  
     f0a:	c3                   	ret    

00000f0b <matchalphanum>:
static int matchalphanum(char c)
{
     f0b:	55                   	push   %ebp
     f0c:	89 e5                	mov    %esp,%ebp
     f0e:	83 ec 04             	sub    $0x4,%esp
     f11:	8b 45 08             	mov    0x8(%ebp),%eax
     f14:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     f17:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     f1b:	74 22                	je     f3f <matchalphanum+0x34>
     f1d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f21:	50                   	push   %eax
     f22:	e8 74 ff ff ff       	call   e9b <matchalpha>
     f27:	83 c4 04             	add    $0x4,%esp
     f2a:	85 c0                	test   %eax,%eax
     f2c:	75 11                	jne    f3f <matchalphanum+0x34>
     f2e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     f32:	50                   	push   %eax
     f33:	e8 3d ff ff ff       	call   e75 <matchdigit>
     f38:	83 c4 04             	add    $0x4,%esp
     f3b:	85 c0                	test   %eax,%eax
     f3d:	74 07                	je     f46 <matchalphanum+0x3b>
     f3f:	b8 01 00 00 00       	mov    $0x1,%eax
     f44:	eb 05                	jmp    f4b <matchalphanum+0x40>
     f46:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f4b:	c9                   	leave  
     f4c:	c3                   	ret    

00000f4d <matchrange>:
static int matchrange(char c, const char* str)
{
     f4d:	55                   	push   %ebp
     f4e:	89 e5                	mov    %esp,%ebp
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	8b 45 08             	mov    0x8(%ebp),%eax
     f56:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     f59:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     f5d:	74 5b                	je     fba <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f62:	0f b6 00             	movzbl (%eax),%eax
     f65:	84 c0                	test   %al,%al
     f67:	74 51                	je     fba <matchrange+0x6d>
     f69:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6c:	0f b6 00             	movzbl (%eax),%eax
     f6f:	3c 2d                	cmp    $0x2d,%al
     f71:	74 47                	je     fba <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     f73:	8b 45 0c             	mov    0xc(%ebp),%eax
     f76:	83 c0 01             	add    $0x1,%eax
     f79:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     f7c:	3c 2d                	cmp    $0x2d,%al
     f7e:	75 3a                	jne    fba <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     f80:	8b 45 0c             	mov    0xc(%ebp),%eax
     f83:	83 c0 01             	add    $0x1,%eax
     f86:	0f b6 00             	movzbl (%eax),%eax
     f89:	84 c0                	test   %al,%al
     f8b:	74 2d                	je     fba <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     f8d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f90:	83 c0 02             	add    $0x2,%eax
     f93:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     f96:	84 c0                	test   %al,%al
     f98:	74 20                	je     fba <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f9d:	0f b6 00             	movzbl (%eax),%eax
     fa0:	3a 45 fc             	cmp    -0x4(%ebp),%al
     fa3:	7f 15                	jg     fba <matchrange+0x6d>
     fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa8:	83 c0 02             	add    $0x2,%eax
     fab:	0f b6 00             	movzbl (%eax),%eax
     fae:	3a 45 fc             	cmp    -0x4(%ebp),%al
     fb1:	7c 07                	jl     fba <matchrange+0x6d>
     fb3:	b8 01 00 00 00       	mov    $0x1,%eax
     fb8:	eb 05                	jmp    fbf <matchrange+0x72>
     fba:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fbf:	c9                   	leave  
     fc0:	c3                   	ret    

00000fc1 <ismetachar>:
static int ismetachar(char c)
{
     fc1:	55                   	push   %ebp
     fc2:	89 e5                	mov    %esp,%ebp
     fc4:	83 ec 04             	sub    $0x4,%esp
     fc7:	8b 45 08             	mov    0x8(%ebp),%eax
     fca:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     fcd:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     fd1:	74 1e                	je     ff1 <ismetachar+0x30>
     fd3:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     fd7:	74 18                	je     ff1 <ismetachar+0x30>
     fd9:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     fdd:	74 12                	je     ff1 <ismetachar+0x30>
     fdf:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     fe3:	74 0c                	je     ff1 <ismetachar+0x30>
     fe5:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     fe9:	74 06                	je     ff1 <ismetachar+0x30>
     feb:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     fef:	75 07                	jne    ff8 <ismetachar+0x37>
     ff1:	b8 01 00 00 00       	mov    $0x1,%eax
     ff6:	eb 05                	jmp    ffd <ismetachar+0x3c>
     ff8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ffd:	c9                   	leave  
     ffe:	c3                   	ret    

00000fff <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     fff:	55                   	push   %ebp
    1000:	89 e5                	mov    %esp,%ebp
    1002:	83 ec 04             	sub    $0x4,%esp
    1005:	8b 45 08             	mov    0x8(%ebp),%eax
    1008:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
    100b:	8b 45 0c             	mov    0xc(%ebp),%eax
    100e:	0f b6 00             	movzbl (%eax),%eax
    1011:	0f be c0             	movsbl %al,%eax
    1014:	83 e8 44             	sub    $0x44,%eax
    1017:	83 f8 33             	cmp    $0x33,%eax
    101a:	77 7b                	ja     1097 <matchmetachar+0x98>
    101c:	8b 04 85 40 17 00 00 	mov    0x1740(,%eax,4),%eax
    1023:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
    1025:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1029:	50                   	push   %eax
    102a:	e8 46 fe ff ff       	call   e75 <matchdigit>
    102f:	83 c4 04             	add    $0x4,%esp
    1032:	eb 72                	jmp    10a6 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
    1034:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1038:	50                   	push   %eax
    1039:	e8 37 fe ff ff       	call   e75 <matchdigit>
    103e:	83 c4 04             	add    $0x4,%esp
    1041:	85 c0                	test   %eax,%eax
    1043:	0f 94 c0             	sete   %al
    1046:	0f b6 c0             	movzbl %al,%eax
    1049:	eb 5b                	jmp    10a6 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
    104b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    104f:	50                   	push   %eax
    1050:	e8 b6 fe ff ff       	call   f0b <matchalphanum>
    1055:	83 c4 04             	add    $0x4,%esp
    1058:	eb 4c                	jmp    10a6 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
    105a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    105e:	50                   	push   %eax
    105f:	e8 a7 fe ff ff       	call   f0b <matchalphanum>
    1064:	83 c4 04             	add    $0x4,%esp
    1067:	85 c0                	test   %eax,%eax
    1069:	0f 94 c0             	sete   %al
    106c:	0f b6 c0             	movzbl %al,%eax
    106f:	eb 35                	jmp    10a6 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
    1071:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1075:	50                   	push   %eax
    1076:	e8 52 fe ff ff       	call   ecd <matchwhitespace>
    107b:	83 c4 04             	add    $0x4,%esp
    107e:	eb 26                	jmp    10a6 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
    1080:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1084:	50                   	push   %eax
    1085:	e8 43 fe ff ff       	call   ecd <matchwhitespace>
    108a:	83 c4 04             	add    $0x4,%esp
    108d:	85 c0                	test   %eax,%eax
    108f:	0f 94 c0             	sete   %al
    1092:	0f b6 c0             	movzbl %al,%eax
    1095:	eb 0f                	jmp    10a6 <matchmetachar+0xa7>
    default:  return (c == str[0]);
    1097:	8b 45 0c             	mov    0xc(%ebp),%eax
    109a:	0f b6 00             	movzbl (%eax),%eax
    109d:	3a 45 fc             	cmp    -0x4(%ebp),%al
    10a0:	0f 94 c0             	sete   %al
    10a3:	0f b6 c0             	movzbl %al,%eax
  }
}
    10a6:	c9                   	leave  
    10a7:	c3                   	ret    

000010a8 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
    10a8:	55                   	push   %ebp
    10a9:	89 e5                	mov    %esp,%ebp
    10ab:	83 ec 04             	sub    $0x4,%esp
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
    10b4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10b8:	ff 75 0c             	pushl  0xc(%ebp)
    10bb:	50                   	push   %eax
    10bc:	e8 8c fe ff ff       	call   f4d <matchrange>
    10c1:	83 c4 08             	add    $0x8,%esp
    10c4:	85 c0                	test   %eax,%eax
    10c6:	74 0a                	je     10d2 <matchcharclass+0x2a>
    {
      return 1;
    10c8:	b8 01 00 00 00       	mov    $0x1,%eax
    10cd:	e9 a5 00 00 00       	jmp    1177 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
    10d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d5:	0f b6 00             	movzbl (%eax),%eax
    10d8:	3c 5c                	cmp    $0x5c,%al
    10da:	75 42                	jne    111e <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
    10dc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
    10e0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    10e4:	ff 75 0c             	pushl  0xc(%ebp)
    10e7:	50                   	push   %eax
    10e8:	e8 12 ff ff ff       	call   fff <matchmetachar>
    10ed:	83 c4 08             	add    $0x8,%esp
    10f0:	85 c0                	test   %eax,%eax
    10f2:	74 07                	je     10fb <matchcharclass+0x53>
      {
        return 1;
    10f4:	b8 01 00 00 00       	mov    $0x1,%eax
    10f9:	eb 7c                	jmp    1177 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
    10fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fe:	0f b6 00             	movzbl (%eax),%eax
    1101:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1104:	75 58                	jne    115e <matchcharclass+0xb6>
    1106:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    110a:	50                   	push   %eax
    110b:	e8 b1 fe ff ff       	call   fc1 <ismetachar>
    1110:	83 c4 04             	add    $0x4,%esp
    1113:	85 c0                	test   %eax,%eax
    1115:	75 47                	jne    115e <matchcharclass+0xb6>
      {
        return 1;
    1117:	b8 01 00 00 00       	mov    $0x1,%eax
    111c:	eb 59                	jmp    1177 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
    111e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1121:	0f b6 00             	movzbl (%eax),%eax
    1124:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1127:	75 35                	jne    115e <matchcharclass+0xb6>
    {
      if (c == '-')
    1129:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    112d:	75 28                	jne    1157 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
    112f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1132:	83 e8 01             	sub    $0x1,%eax
    1135:	0f b6 00             	movzbl (%eax),%eax
    1138:	84 c0                	test   %al,%al
    113a:	74 0d                	je     1149 <matchcharclass+0xa1>
    113c:	8b 45 0c             	mov    0xc(%ebp),%eax
    113f:	83 c0 01             	add    $0x1,%eax
    1142:	0f b6 00             	movzbl (%eax),%eax
    1145:	84 c0                	test   %al,%al
    1147:	75 07                	jne    1150 <matchcharclass+0xa8>
    1149:	b8 01 00 00 00       	mov    $0x1,%eax
    114e:	eb 27                	jmp    1177 <matchcharclass+0xcf>
    1150:	b8 00 00 00 00       	mov    $0x0,%eax
    1155:	eb 20                	jmp    1177 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
    1157:	b8 01 00 00 00       	mov    $0x1,%eax
    115c:	eb 19                	jmp    1177 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
    115e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1161:	8d 50 01             	lea    0x1(%eax),%edx
    1164:	89 55 0c             	mov    %edx,0xc(%ebp)
    1167:	0f b6 00             	movzbl (%eax),%eax
    116a:	84 c0                	test   %al,%al
    116c:	0f 85 42 ff ff ff    	jne    10b4 <matchcharclass+0xc>

  return 0;
    1172:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1177:	c9                   	leave  
    1178:	c3                   	ret    

00001179 <matchone>:

static int matchone(regex_t p, char c)
{
    1179:	55                   	push   %ebp
    117a:	89 e5                	mov    %esp,%ebp
    117c:	83 ec 04             	sub    $0x4,%esp
    117f:	8b 45 10             	mov    0x10(%ebp),%eax
    1182:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
    1185:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1189:	0f b6 c0             	movzbl %al,%eax
    118c:	83 f8 0f             	cmp    $0xf,%eax
    118f:	0f 87 b9 00 00 00    	ja     124e <matchone+0xd5>
    1195:	8b 04 85 10 18 00 00 	mov    0x1810(,%eax,4),%eax
    119c:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
    119e:	b8 01 00 00 00       	mov    $0x1,%eax
    11a3:	e9 b9 00 00 00       	jmp    1261 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
    11a8:	8b 55 0c             	mov    0xc(%ebp),%edx
    11ab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11af:	52                   	push   %edx
    11b0:	50                   	push   %eax
    11b1:	e8 f2 fe ff ff       	call   10a8 <matchcharclass>
    11b6:	83 c4 08             	add    $0x8,%esp
    11b9:	e9 a3 00 00 00       	jmp    1261 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
    11be:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11c5:	52                   	push   %edx
    11c6:	50                   	push   %eax
    11c7:	e8 dc fe ff ff       	call   10a8 <matchcharclass>
    11cc:	83 c4 08             	add    $0x8,%esp
    11cf:	85 c0                	test   %eax,%eax
    11d1:	0f 94 c0             	sete   %al
    11d4:	0f b6 c0             	movzbl %al,%eax
    11d7:	e9 85 00 00 00       	jmp    1261 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    11dc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11e0:	50                   	push   %eax
    11e1:	e8 8f fc ff ff       	call   e75 <matchdigit>
    11e6:	83 c4 04             	add    $0x4,%esp
    11e9:	eb 76                	jmp    1261 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    11eb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    11ef:	50                   	push   %eax
    11f0:	e8 80 fc ff ff       	call   e75 <matchdigit>
    11f5:	83 c4 04             	add    $0x4,%esp
    11f8:	85 c0                	test   %eax,%eax
    11fa:	0f 94 c0             	sete   %al
    11fd:	0f b6 c0             	movzbl %al,%eax
    1200:	eb 5f                	jmp    1261 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    1202:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1206:	50                   	push   %eax
    1207:	e8 ff fc ff ff       	call   f0b <matchalphanum>
    120c:	83 c4 04             	add    $0x4,%esp
    120f:	eb 50                	jmp    1261 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    1211:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1215:	50                   	push   %eax
    1216:	e8 f0 fc ff ff       	call   f0b <matchalphanum>
    121b:	83 c4 04             	add    $0x4,%esp
    121e:	85 c0                	test   %eax,%eax
    1220:	0f 94 c0             	sete   %al
    1223:	0f b6 c0             	movzbl %al,%eax
    1226:	eb 39                	jmp    1261 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    1228:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    122c:	50                   	push   %eax
    122d:	e8 9b fc ff ff       	call   ecd <matchwhitespace>
    1232:	83 c4 04             	add    $0x4,%esp
    1235:	eb 2a                	jmp    1261 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    1237:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    123b:	50                   	push   %eax
    123c:	e8 8c fc ff ff       	call   ecd <matchwhitespace>
    1241:	83 c4 04             	add    $0x4,%esp
    1244:	85 c0                	test   %eax,%eax
    1246:	0f 94 c0             	sete   %al
    1249:	0f b6 c0             	movzbl %al,%eax
    124c:	eb 13                	jmp    1261 <matchone+0xe8>
    default:             return  (p.ch == c);
    124e:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    1252:	0f b6 d0             	movzbl %al,%edx
    1255:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1259:	39 c2                	cmp    %eax,%edx
    125b:	0f 94 c0             	sete   %al
    125e:	0f b6 c0             	movzbl %al,%eax
  }
}
    1261:	c9                   	leave  
    1262:	c3                   	ret    

00001263 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1263:	55                   	push   %ebp
    1264:	89 e5                	mov    %esp,%ebp
    1266:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    1269:	8b 45 18             	mov    0x18(%ebp),%eax
    126c:	8b 00                	mov    (%eax),%eax
    126e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1271:	8b 45 14             	mov    0x14(%ebp),%eax
    1274:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1277:	eb 11                	jmp    128a <matchstar+0x27>
  {
    text++;
    1279:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    127d:	8b 45 18             	mov    0x18(%ebp),%eax
    1280:	8b 00                	mov    (%eax),%eax
    1282:	8d 50 01             	lea    0x1(%eax),%edx
    1285:	8b 45 18             	mov    0x18(%ebp),%eax
    1288:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    128a:	8b 45 14             	mov    0x14(%ebp),%eax
    128d:	0f b6 00             	movzbl (%eax),%eax
    1290:	84 c0                	test   %al,%al
    1292:	74 51                	je     12e5 <matchstar+0x82>
    1294:	8b 45 14             	mov    0x14(%ebp),%eax
    1297:	0f b6 00             	movzbl (%eax),%eax
    129a:	0f be c0             	movsbl %al,%eax
    129d:	50                   	push   %eax
    129e:	ff 75 0c             	pushl  0xc(%ebp)
    12a1:	ff 75 08             	pushl  0x8(%ebp)
    12a4:	e8 d0 fe ff ff       	call   1179 <matchone>
    12a9:	83 c4 0c             	add    $0xc,%esp
    12ac:	85 c0                	test   %eax,%eax
    12ae:	75 c9                	jne    1279 <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    12b0:	eb 33                	jmp    12e5 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    12b2:	8b 45 14             	mov    0x14(%ebp),%eax
    12b5:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b8:	89 55 14             	mov    %edx,0x14(%ebp)
    12bb:	83 ec 04             	sub    $0x4,%esp
    12be:	ff 75 18             	pushl  0x18(%ebp)
    12c1:	50                   	push   %eax
    12c2:	ff 75 10             	pushl  0x10(%ebp)
    12c5:	e8 51 01 00 00       	call   141b <matchpattern>
    12ca:	83 c4 10             	add    $0x10,%esp
    12cd:	85 c0                	test   %eax,%eax
    12cf:	74 07                	je     12d8 <matchstar+0x75>
      return 1;
    12d1:	b8 01 00 00 00       	mov    $0x1,%eax
    12d6:	eb 22                	jmp    12fa <matchstar+0x97>
    (*matchlength)--;
    12d8:	8b 45 18             	mov    0x18(%ebp),%eax
    12db:	8b 00                	mov    (%eax),%eax
    12dd:	8d 50 ff             	lea    -0x1(%eax),%edx
    12e0:	8b 45 18             	mov    0x18(%ebp),%eax
    12e3:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    12e5:	8b 45 14             	mov    0x14(%ebp),%eax
    12e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12eb:	73 c5                	jae    12b2 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    12ed:	8b 45 18             	mov    0x18(%ebp),%eax
    12f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12f3:	89 10                	mov    %edx,(%eax)
  return 0;
    12f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12fa:	c9                   	leave  
    12fb:	c3                   	ret    

000012fc <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    12fc:	55                   	push   %ebp
    12fd:	89 e5                	mov    %esp,%ebp
    12ff:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1302:	8b 45 14             	mov    0x14(%ebp),%eax
    1305:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1308:	eb 11                	jmp    131b <matchplus+0x1f>
  {
    text++;
    130a:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    130e:	8b 45 18             	mov    0x18(%ebp),%eax
    1311:	8b 00                	mov    (%eax),%eax
    1313:	8d 50 01             	lea    0x1(%eax),%edx
    1316:	8b 45 18             	mov    0x18(%ebp),%eax
    1319:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    131b:	8b 45 14             	mov    0x14(%ebp),%eax
    131e:	0f b6 00             	movzbl (%eax),%eax
    1321:	84 c0                	test   %al,%al
    1323:	74 51                	je     1376 <matchplus+0x7a>
    1325:	8b 45 14             	mov    0x14(%ebp),%eax
    1328:	0f b6 00             	movzbl (%eax),%eax
    132b:	0f be c0             	movsbl %al,%eax
    132e:	50                   	push   %eax
    132f:	ff 75 0c             	pushl  0xc(%ebp)
    1332:	ff 75 08             	pushl  0x8(%ebp)
    1335:	e8 3f fe ff ff       	call   1179 <matchone>
    133a:	83 c4 0c             	add    $0xc,%esp
    133d:	85 c0                	test   %eax,%eax
    133f:	75 c9                	jne    130a <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1341:	eb 33                	jmp    1376 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    1343:	8b 45 14             	mov    0x14(%ebp),%eax
    1346:	8d 50 ff             	lea    -0x1(%eax),%edx
    1349:	89 55 14             	mov    %edx,0x14(%ebp)
    134c:	83 ec 04             	sub    $0x4,%esp
    134f:	ff 75 18             	pushl  0x18(%ebp)
    1352:	50                   	push   %eax
    1353:	ff 75 10             	pushl  0x10(%ebp)
    1356:	e8 c0 00 00 00       	call   141b <matchpattern>
    135b:	83 c4 10             	add    $0x10,%esp
    135e:	85 c0                	test   %eax,%eax
    1360:	74 07                	je     1369 <matchplus+0x6d>
      return 1;
    1362:	b8 01 00 00 00       	mov    $0x1,%eax
    1367:	eb 1a                	jmp    1383 <matchplus+0x87>
    (*matchlength)--;
    1369:	8b 45 18             	mov    0x18(%ebp),%eax
    136c:	8b 00                	mov    (%eax),%eax
    136e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1371:	8b 45 18             	mov    0x18(%ebp),%eax
    1374:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1376:	8b 45 14             	mov    0x14(%ebp),%eax
    1379:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    137c:	77 c5                	ja     1343 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    137e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1383:	c9                   	leave  
    1384:	c3                   	ret    

00001385 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1385:	55                   	push   %ebp
    1386:	89 e5                	mov    %esp,%ebp
    1388:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    138b:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    138f:	84 c0                	test   %al,%al
    1391:	75 07                	jne    139a <matchquestion+0x15>
    return 1;
    1393:	b8 01 00 00 00       	mov    $0x1,%eax
    1398:	eb 7f                	jmp    1419 <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    139a:	83 ec 04             	sub    $0x4,%esp
    139d:	ff 75 18             	pushl  0x18(%ebp)
    13a0:	ff 75 14             	pushl  0x14(%ebp)
    13a3:	ff 75 10             	pushl  0x10(%ebp)
    13a6:	e8 70 00 00 00       	call   141b <matchpattern>
    13ab:	83 c4 10             	add    $0x10,%esp
    13ae:	85 c0                	test   %eax,%eax
    13b0:	74 07                	je     13b9 <matchquestion+0x34>
      return 1;
    13b2:	b8 01 00 00 00       	mov    $0x1,%eax
    13b7:	eb 60                	jmp    1419 <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    13b9:	8b 45 14             	mov    0x14(%ebp),%eax
    13bc:	0f b6 00             	movzbl (%eax),%eax
    13bf:	84 c0                	test   %al,%al
    13c1:	74 51                	je     1414 <matchquestion+0x8f>
    13c3:	8b 45 14             	mov    0x14(%ebp),%eax
    13c6:	8d 50 01             	lea    0x1(%eax),%edx
    13c9:	89 55 14             	mov    %edx,0x14(%ebp)
    13cc:	0f b6 00             	movzbl (%eax),%eax
    13cf:	0f be c0             	movsbl %al,%eax
    13d2:	83 ec 04             	sub    $0x4,%esp
    13d5:	50                   	push   %eax
    13d6:	ff 75 0c             	pushl  0xc(%ebp)
    13d9:	ff 75 08             	pushl  0x8(%ebp)
    13dc:	e8 98 fd ff ff       	call   1179 <matchone>
    13e1:	83 c4 10             	add    $0x10,%esp
    13e4:	85 c0                	test   %eax,%eax
    13e6:	74 2c                	je     1414 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    13e8:	83 ec 04             	sub    $0x4,%esp
    13eb:	ff 75 18             	pushl  0x18(%ebp)
    13ee:	ff 75 14             	pushl  0x14(%ebp)
    13f1:	ff 75 10             	pushl  0x10(%ebp)
    13f4:	e8 22 00 00 00       	call   141b <matchpattern>
    13f9:	83 c4 10             	add    $0x10,%esp
    13fc:	85 c0                	test   %eax,%eax
    13fe:	74 14                	je     1414 <matchquestion+0x8f>
    {
      (*matchlength)++;
    1400:	8b 45 18             	mov    0x18(%ebp),%eax
    1403:	8b 00                	mov    (%eax),%eax
    1405:	8d 50 01             	lea    0x1(%eax),%edx
    1408:	8b 45 18             	mov    0x18(%ebp),%eax
    140b:	89 10                	mov    %edx,(%eax)
      return 1;
    140d:	b8 01 00 00 00       	mov    $0x1,%eax
    1412:	eb 05                	jmp    1419 <matchquestion+0x94>
    }
  }
  return 0;
    1414:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1419:	c9                   	leave  
    141a:	c3                   	ret    

0000141b <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    141b:	55                   	push   %ebp
    141c:	89 e5                	mov    %esp,%ebp
    141e:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1421:	8b 45 10             	mov    0x10(%ebp),%eax
    1424:	8b 00                	mov    (%eax),%eax
    1426:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1429:	8b 45 08             	mov    0x8(%ebp),%eax
    142c:	0f b6 00             	movzbl (%eax),%eax
    142f:	84 c0                	test   %al,%al
    1431:	74 0d                	je     1440 <matchpattern+0x25>
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	83 c0 08             	add    $0x8,%eax
    1439:	0f b6 00             	movzbl (%eax),%eax
    143c:	3c 04                	cmp    $0x4,%al
    143e:	75 25                	jne    1465 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1440:	8b 45 08             	mov    0x8(%ebp),%eax
    1443:	83 c0 10             	add    $0x10,%eax
    1446:	83 ec 0c             	sub    $0xc,%esp
    1449:	ff 75 10             	pushl  0x10(%ebp)
    144c:	ff 75 0c             	pushl  0xc(%ebp)
    144f:	50                   	push   %eax
    1450:	8b 45 08             	mov    0x8(%ebp),%eax
    1453:	ff 70 04             	pushl  0x4(%eax)
    1456:	ff 30                	pushl  (%eax)
    1458:	e8 28 ff ff ff       	call   1385 <matchquestion>
    145d:	83 c4 20             	add    $0x20,%esp
    1460:	e9 dd 00 00 00       	jmp    1542 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    1465:	8b 45 08             	mov    0x8(%ebp),%eax
    1468:	83 c0 08             	add    $0x8,%eax
    146b:	0f b6 00             	movzbl (%eax),%eax
    146e:	3c 05                	cmp    $0x5,%al
    1470:	75 25                	jne    1497 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1472:	8b 45 08             	mov    0x8(%ebp),%eax
    1475:	83 c0 10             	add    $0x10,%eax
    1478:	83 ec 0c             	sub    $0xc,%esp
    147b:	ff 75 10             	pushl  0x10(%ebp)
    147e:	ff 75 0c             	pushl  0xc(%ebp)
    1481:	50                   	push   %eax
    1482:	8b 45 08             	mov    0x8(%ebp),%eax
    1485:	ff 70 04             	pushl  0x4(%eax)
    1488:	ff 30                	pushl  (%eax)
    148a:	e8 d4 fd ff ff       	call   1263 <matchstar>
    148f:	83 c4 20             	add    $0x20,%esp
    1492:	e9 ab 00 00 00       	jmp    1542 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    1497:	8b 45 08             	mov    0x8(%ebp),%eax
    149a:	83 c0 08             	add    $0x8,%eax
    149d:	0f b6 00             	movzbl (%eax),%eax
    14a0:	3c 06                	cmp    $0x6,%al
    14a2:	75 22                	jne    14c6 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	83 c0 10             	add    $0x10,%eax
    14aa:	83 ec 0c             	sub    $0xc,%esp
    14ad:	ff 75 10             	pushl  0x10(%ebp)
    14b0:	ff 75 0c             	pushl  0xc(%ebp)
    14b3:	50                   	push   %eax
    14b4:	8b 45 08             	mov    0x8(%ebp),%eax
    14b7:	ff 70 04             	pushl  0x4(%eax)
    14ba:	ff 30                	pushl  (%eax)
    14bc:	e8 3b fe ff ff       	call   12fc <matchplus>
    14c1:	83 c4 20             	add    $0x20,%esp
    14c4:	eb 7c                	jmp    1542 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    14c6:	8b 45 08             	mov    0x8(%ebp),%eax
    14c9:	0f b6 00             	movzbl (%eax),%eax
    14cc:	3c 03                	cmp    $0x3,%al
    14ce:	75 1d                	jne    14ed <matchpattern+0xd2>
    14d0:	8b 45 08             	mov    0x8(%ebp),%eax
    14d3:	83 c0 08             	add    $0x8,%eax
    14d6:	0f b6 00             	movzbl (%eax),%eax
    14d9:	84 c0                	test   %al,%al
    14db:	75 10                	jne    14ed <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    14dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e0:	0f b6 00             	movzbl (%eax),%eax
    14e3:	84 c0                	test   %al,%al
    14e5:	0f 94 c0             	sete   %al
    14e8:	0f b6 c0             	movzbl %al,%eax
    14eb:	eb 55                	jmp    1542 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    14ed:	8b 45 10             	mov    0x10(%ebp),%eax
    14f0:	8b 00                	mov    (%eax),%eax
    14f2:	8d 50 01             	lea    0x1(%eax),%edx
    14f5:	8b 45 10             	mov    0x10(%ebp),%eax
    14f8:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    14fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fd:	0f b6 00             	movzbl (%eax),%eax
    1500:	84 c0                	test   %al,%al
    1502:	74 31                	je     1535 <matchpattern+0x11a>
    1504:	8b 45 0c             	mov    0xc(%ebp),%eax
    1507:	8d 50 01             	lea    0x1(%eax),%edx
    150a:	89 55 0c             	mov    %edx,0xc(%ebp)
    150d:	0f b6 00             	movzbl (%eax),%eax
    1510:	0f be d0             	movsbl %al,%edx
    1513:	8b 45 08             	mov    0x8(%ebp),%eax
    1516:	8d 48 08             	lea    0x8(%eax),%ecx
    1519:	89 4d 08             	mov    %ecx,0x8(%ebp)
    151c:	83 ec 04             	sub    $0x4,%esp
    151f:	52                   	push   %edx
    1520:	ff 70 04             	pushl  0x4(%eax)
    1523:	ff 30                	pushl  (%eax)
    1525:	e8 4f fc ff ff       	call   1179 <matchone>
    152a:	83 c4 10             	add    $0x10,%esp
    152d:	85 c0                	test   %eax,%eax
    152f:	0f 85 f4 fe ff ff    	jne    1429 <matchpattern+0xe>

  *matchlength = pre;
    1535:	8b 45 10             	mov    0x10(%ebp),%eax
    1538:	8b 55 f4             	mov    -0xc(%ebp),%edx
    153b:	89 10                	mov    %edx,(%eax)
  return 0;
    153d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1542:	c9                   	leave  
    1543:	c3                   	ret    
