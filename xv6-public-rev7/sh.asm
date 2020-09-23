
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 c4 0e 00 00       	call   ed5 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 c4 1e 00 00 	mov    0x1ec4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 98 1e 00 00       	push   $0x1e98
      2c:	e8 6b 03 00 00       	call   39c <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 8c 0e 00 00       	call   ed5 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 ae 0e 00 00       	call   f0d <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 9f 1e 00 00       	push   $0x1e9f
      71:	6a 02                	push   $0x2
      73:	e8 34 10 00 00       	call   10ac <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 68 0e 00 00       	call   efd <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 67 0e 00 00       	call   f15 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 af 1e 00 00       	push   $0x1eaf
      c4:	6a 02                	push   $0x2
      c6:	e8 e1 0f 00 00       	call   10ac <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 02 0e 00 00       	call   ed5 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 c7 02 00 00       	call   3bc <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 cd 0d 00 00       	call   edd <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 ac 0d 00 00       	call   ee5 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 bf 1e 00 00       	push   $0x1ebf
     148:	e8 4f 02 00 00       	call   39c <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 67 02 00 00       	call   3bc <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 9a 0d 00 00       	call   efd <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 db 0d 00 00       	call   f4d <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 7c 0d 00 00       	call   efd <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 6d 0d 00 00       	call   efd <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 12 02 00 00       	call   3bc <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 45 0d 00 00       	call   efd <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 86 0d 00 00       	call   f4d <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 27 0d 00 00       	call   efd <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 18 0d 00 00       	call   efd <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 f7 0c 00 00       	call   efd <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 e8 0c 00 00       	call   efd <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 c0 0c 00 00       	call   edd <wait>
    wait();
     21d:	e8 bb 0c 00 00       	call   edd <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 8d 01 00 00       	call   3bc <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 8a 0c 00 00       	call   ed5 <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 dc 1e 00 00       	push   $0x1edc
     259:	6a 02                	push   $0x2
     25b:	e8 4c 0e 00 00       	call   10ac <printf>
     260:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	pushl  0x8(%ebp)
     26f:	e8 c6 0a 00 00       	call   d3a <memset>
     274:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	pushl  0xc(%ebp)
     27d:	ff 75 08             	pushl  0x8(%ebp)
     280:	e8 02 0b 00 00       	call   d87 <gets>
     285:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	75 07                	jne    299 <getcmd+0x4e>
    return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 05                	jmp    29e <getcmd+0x53>
  return 0;
     299:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29e:	c9                   	leave  
     29f:	c3                   	ret    

000002a0 <main>:

int
main(void)
{
     2a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a4:	83 e4 f0             	and    $0xfffffff0,%esp
     2a7:	ff 71 fc             	pushl  -0x4(%ecx)
     2aa:	55                   	push   %ebp
     2ab:	89 e5                	mov    %esp,%ebp
     2ad:	51                   	push   %ecx
     2ae:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b1:	eb 16                	jmp    2c9 <main+0x29>
    if(fd >= 3){
     2b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b7:	7e 10                	jle    2c9 <main+0x29>
      close(fd);
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	ff 75 f4             	pushl  -0xc(%ebp)
     2bf:	e8 39 0c 00 00       	call   efd <close>
     2c4:	83 c4 10             	add    $0x10,%esp
      break;
     2c7:	eb 1b                	jmp    2e4 <main+0x44>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	6a 02                	push   $0x2
     2ce:	68 df 1e 00 00       	push   $0x1edf
     2d3:	e8 3d 0c 00 00       	call   f15 <open>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e2:	79 cf                	jns    2b3 <main+0x13>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e4:	e9 94 00 00 00       	jmp    37d <main+0xdd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e9:	0f b6 05 20 29 00 00 	movzbl 0x2920,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 21 29 00 00 	movzbl 0x2921,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 22 29 00 00 	movzbl 0x2922,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 20 29 00 00       	push   $0x2920
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 20 29 00 00 00 	movb   $0x0,0x2920(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 23 29 00 00       	mov    $0x2923,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 13 0c 00 00       	call   f45 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 23 29 00 00       	mov    $0x2923,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 e7 1e 00 00       	push   $0x1ee7
     347:	6a 02                	push   $0x2
     349:	e8 5e 0d 00 00       	call   10ac <printf>
     34e:	83 c4 10             	add    $0x10,%esp
      continue;
     351:	eb 2a                	jmp    37d <main+0xdd>
    }
    if(fork1() == 0)
     353:	e8 64 00 00 00       	call   3bc <fork1>
     358:	85 c0                	test   %eax,%eax
     35a:	75 1c                	jne    378 <main+0xd8>
      runcmd(parsecmd(buf));
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 20 29 00 00       	push   $0x2920
     364:	e8 ab 03 00 00       	call   714 <parsecmd>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	83 ec 0c             	sub    $0xc,%esp
     36f:	50                   	push   %eax
     370:	e8 8b fc ff ff       	call   0 <runcmd>
     375:	83 c4 10             	add    $0x10,%esp
    wait();
     378:	e8 60 0b 00 00       	call   edd <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     37d:	83 ec 08             	sub    $0x8,%esp
     380:	6a 64                	push   $0x64
     382:	68 20 29 00 00       	push   $0x2920
     387:	e8 bf fe ff ff       	call   24b <getcmd>
     38c:	83 c4 10             	add    $0x10,%esp
     38f:	85 c0                	test   %eax,%eax
     391:	0f 89 52 ff ff ff    	jns    2e9 <main+0x49>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     397:	e8 39 0b 00 00       	call   ed5 <exit>

0000039c <panic>:
}

void
panic(char *s)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
     39f:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     3a2:	83 ec 04             	sub    $0x4,%esp
     3a5:	ff 75 08             	pushl  0x8(%ebp)
     3a8:	68 f5 1e 00 00       	push   $0x1ef5
     3ad:	6a 02                	push   $0x2
     3af:	e8 f8 0c 00 00       	call   10ac <printf>
     3b4:	83 c4 10             	add    $0x10,%esp
  exit();
     3b7:	e8 19 0b 00 00       	call   ed5 <exit>

000003bc <fork1>:
}

int
fork1(void)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     3c2:	e8 06 0b 00 00       	call   ecd <fork>
     3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3ca:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3ce:	75 10                	jne    3e0 <fork1+0x24>
    panic("fork");
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	68 f9 1e 00 00       	push   $0x1ef9
     3d8:	e8 bf ff ff ff       	call   39c <panic>
     3dd:	83 c4 10             	add    $0x10,%esp
  return pid;
     3e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3e3:	c9                   	leave  
     3e4:	c3                   	ret    

000003e5 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3e5:	55                   	push   %ebp
     3e6:	89 e5                	mov    %esp,%ebp
     3e8:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	6a 54                	push   $0x54
     3f0:	e8 8a 0f 00 00       	call   137f <malloc>
     3f5:	83 c4 10             	add    $0x10,%esp
     3f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3fb:	83 ec 04             	sub    $0x4,%esp
     3fe:	6a 54                	push   $0x54
     400:	6a 00                	push   $0x0
     402:	ff 75 f4             	pushl  -0xc(%ebp)
     405:	e8 30 09 00 00       	call   d3a <memset>
     40a:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     410:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     416:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     419:	c9                   	leave  
     41a:	c3                   	ret    

0000041b <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     41b:	55                   	push   %ebp
     41c:	89 e5                	mov    %esp,%ebp
     41e:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     421:	83 ec 0c             	sub    $0xc,%esp
     424:	6a 18                	push   $0x18
     426:	e8 54 0f 00 00       	call   137f <malloc>
     42b:	83 c4 10             	add    $0x10,%esp
     42e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     431:	83 ec 04             	sub    $0x4,%esp
     434:	6a 18                	push   $0x18
     436:	6a 00                	push   $0x0
     438:	ff 75 f4             	pushl  -0xc(%ebp)
     43b:	e8 fa 08 00 00       	call   d3a <memset>
     440:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     443:	8b 45 f4             	mov    -0xc(%ebp),%eax
     446:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	8b 55 08             	mov    0x8(%ebp),%edx
     452:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8b 55 0c             	mov    0xc(%ebp),%edx
     45b:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	8b 55 10             	mov    0x10(%ebp),%edx
     464:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8b 55 14             	mov    0x14(%ebp),%edx
     46d:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	8b 55 18             	mov    0x18(%ebp),%edx
     476:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     479:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     47c:	c9                   	leave  
     47d:	c3                   	ret    

0000047e <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     47e:	55                   	push   %ebp
     47f:	89 e5                	mov    %esp,%ebp
     481:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     484:	83 ec 0c             	sub    $0xc,%esp
     487:	6a 0c                	push   $0xc
     489:	e8 f1 0e 00 00       	call   137f <malloc>
     48e:	83 c4 10             	add    $0x10,%esp
     491:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     494:	83 ec 04             	sub    $0x4,%esp
     497:	6a 0c                	push   $0xc
     499:	6a 00                	push   $0x0
     49b:	ff 75 f4             	pushl  -0xc(%ebp)
     49e:	e8 97 08 00 00       	call   d3a <memset>
     4a3:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     4a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a9:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b2:	8b 55 08             	mov    0x8(%ebp),%edx
     4b5:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4bb:	8b 55 0c             	mov    0xc(%ebp),%edx
     4be:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4c4:	c9                   	leave  
     4c5:	c3                   	ret    

000004c6 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4c6:	55                   	push   %ebp
     4c7:	89 e5                	mov    %esp,%ebp
     4c9:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4cc:	83 ec 0c             	sub    $0xc,%esp
     4cf:	6a 0c                	push   $0xc
     4d1:	e8 a9 0e 00 00       	call   137f <malloc>
     4d6:	83 c4 10             	add    $0x10,%esp
     4d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0c                	push   $0xc
     4e1:	6a 00                	push   $0x0
     4e3:	ff 75 f4             	pushl  -0xc(%ebp)
     4e6:	e8 4f 08 00 00       	call   d3a <memset>
     4eb:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fa:	8b 55 08             	mov    0x8(%ebp),%edx
     4fd:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8b 55 0c             	mov    0xc(%ebp),%edx
     506:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     509:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     50c:	c9                   	leave  
     50d:	c3                   	ret    

0000050e <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     50e:	55                   	push   %ebp
     50f:	89 e5                	mov    %esp,%ebp
     511:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	6a 08                	push   $0x8
     519:	e8 61 0e 00 00       	call   137f <malloc>
     51e:	83 c4 10             	add    $0x10,%esp
     521:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 08                	push   $0x8
     529:	6a 00                	push   $0x0
     52b:	ff 75 f4             	pushl  -0xc(%ebp)
     52e:	e8 07 08 00 00       	call   d3a <memset>
     533:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     536:	8b 45 f4             	mov    -0xc(%ebp),%eax
     539:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	8b 55 08             	mov    0x8(%ebp),%edx
     545:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     54b:	c9                   	leave  
     54c:	c3                   	ret    

0000054d <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     54d:	55                   	push   %ebp
     54e:	89 e5                	mov    %esp,%ebp
     550:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     553:	8b 45 08             	mov    0x8(%ebp),%eax
     556:	8b 00                	mov    (%eax),%eax
     558:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     55b:	eb 04                	jmp    561 <gettoken+0x14>
    s++;
     55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     561:	8b 45 f4             	mov    -0xc(%ebp),%eax
     564:	3b 45 0c             	cmp    0xc(%ebp),%eax
     567:	73 1e                	jae    587 <gettoken+0x3a>
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	68 e0 28 00 00       	push   $0x28e0
     57b:	e8 d4 07 00 00       	call   d54 <strchr>
     580:	83 c4 10             	add    $0x10,%esp
     583:	85 c0                	test   %eax,%eax
     585:	75 d6                	jne    55d <gettoken+0x10>
    s++;
  if(q)
     587:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     58b:	74 08                	je     595 <gettoken+0x48>
    *q = s;
     58d:	8b 45 10             	mov    0x10(%ebp),%eax
     590:	8b 55 f4             	mov    -0xc(%ebp),%edx
     593:	89 10                	mov    %edx,(%eax)
  ret = *s;
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	0f b6 00             	movzbl (%eax),%eax
     59b:	0f be c0             	movsbl %al,%eax
     59e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 f8 29             	cmp    $0x29,%eax
     5ad:	7f 14                	jg     5c3 <gettoken+0x76>
     5af:	83 f8 28             	cmp    $0x28,%eax
     5b2:	7d 28                	jge    5dc <gettoken+0x8f>
     5b4:	85 c0                	test   %eax,%eax
     5b6:	0f 84 94 00 00 00    	je     650 <gettoken+0x103>
     5bc:	83 f8 26             	cmp    $0x26,%eax
     5bf:	74 1b                	je     5dc <gettoken+0x8f>
     5c1:	eb 3a                	jmp    5fd <gettoken+0xb0>
     5c3:	83 f8 3e             	cmp    $0x3e,%eax
     5c6:	74 1a                	je     5e2 <gettoken+0x95>
     5c8:	83 f8 3e             	cmp    $0x3e,%eax
     5cb:	7f 0a                	jg     5d7 <gettoken+0x8a>
     5cd:	83 e8 3b             	sub    $0x3b,%eax
     5d0:	83 f8 01             	cmp    $0x1,%eax
     5d3:	77 28                	ja     5fd <gettoken+0xb0>
     5d5:	eb 05                	jmp    5dc <gettoken+0x8f>
     5d7:	83 f8 7c             	cmp    $0x7c,%eax
     5da:	75 21                	jne    5fd <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5e0:	eb 75                	jmp    657 <gettoken+0x10a>
  case '>':
    s++;
     5e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e9:	0f b6 00             	movzbl (%eax),%eax
     5ec:	3c 3e                	cmp    $0x3e,%al
     5ee:	75 63                	jne    653 <gettoken+0x106>
      ret = '+';
     5f0:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5fb:	eb 56                	jmp    653 <gettoken+0x106>
  default:
    ret = 'a';
     5fd:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     604:	eb 04                	jmp    60a <gettoken+0xbd>
      s++;
     606:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     60a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     610:	73 44                	jae    656 <gettoken+0x109>
     612:	8b 45 f4             	mov    -0xc(%ebp),%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	68 e0 28 00 00       	push   $0x28e0
     624:	e8 2b 07 00 00       	call   d54 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 e8 28 00 00       	push   $0x28e8
     642:	e8 0d 07 00 00       	call   d54 <strchr>
     647:	83 c4 10             	add    $0x10,%esp
     64a:	85 c0                	test   %eax,%eax
     64c:	74 b8                	je     606 <gettoken+0xb9>
      s++;
    break;
     64e:	eb 06                	jmp    656 <gettoken+0x109>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     650:	90                   	nop
     651:	eb 04                	jmp    657 <gettoken+0x10a>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     653:	90                   	nop
     654:	eb 01                	jmp    657 <gettoken+0x10a>
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
     656:	90                   	nop
  }
  if(eq)
     657:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     65b:	74 0e                	je     66b <gettoken+0x11e>
    *eq = s;
     65d:	8b 45 14             	mov    0x14(%ebp),%eax
     660:	8b 55 f4             	mov    -0xc(%ebp),%edx
     663:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     665:	eb 04                	jmp    66b <gettoken+0x11e>
    s++;
     667:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     671:	73 1e                	jae    691 <gettoken+0x144>
     673:	8b 45 f4             	mov    -0xc(%ebp),%eax
     676:	0f b6 00             	movzbl (%eax),%eax
     679:	0f be c0             	movsbl %al,%eax
     67c:	83 ec 08             	sub    $0x8,%esp
     67f:	50                   	push   %eax
     680:	68 e0 28 00 00       	push   $0x28e0
     685:	e8 ca 06 00 00       	call   d54 <strchr>
     68a:	83 c4 10             	add    $0x10,%esp
     68d:	85 c0                	test   %eax,%eax
     68f:	75 d6                	jne    667 <gettoken+0x11a>
    s++;
  *ps = s;
     691:	8b 45 08             	mov    0x8(%ebp),%eax
     694:	8b 55 f4             	mov    -0xc(%ebp),%edx
     697:	89 10                	mov    %edx,(%eax)
  return ret;
     699:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     69c:	c9                   	leave  
     69d:	c3                   	ret    

0000069e <peek>:

int
peek(char **ps, char *es, char *toks)
{
     69e:	55                   	push   %ebp
     69f:	89 e5                	mov    %esp,%ebp
     6a1:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     6a4:	8b 45 08             	mov    0x8(%ebp),%eax
     6a7:	8b 00                	mov    (%eax),%eax
     6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6ac:	eb 04                	jmp    6b2 <peek+0x14>
    s++;
     6ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     6b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6b8:	73 1e                	jae    6d8 <peek+0x3a>
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	0f be c0             	movsbl %al,%eax
     6c3:	83 ec 08             	sub    $0x8,%esp
     6c6:	50                   	push   %eax
     6c7:	68 e0 28 00 00       	push   $0x28e0
     6cc:	e8 83 06 00 00       	call   d54 <strchr>
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	85 c0                	test   %eax,%eax
     6d6:	75 d6                	jne    6ae <peek+0x10>
    s++;
  *ps = s;
     6d8:	8b 45 08             	mov    0x8(%ebp),%eax
     6db:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6de:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e3:	0f b6 00             	movzbl (%eax),%eax
     6e6:	84 c0                	test   %al,%al
     6e8:	74 23                	je     70d <peek+0x6f>
     6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ed:	0f b6 00             	movzbl (%eax),%eax
     6f0:	0f be c0             	movsbl %al,%eax
     6f3:	83 ec 08             	sub    $0x8,%esp
     6f6:	50                   	push   %eax
     6f7:	ff 75 10             	pushl  0x10(%ebp)
     6fa:	e8 55 06 00 00       	call   d54 <strchr>
     6ff:	83 c4 10             	add    $0x10,%esp
     702:	85 c0                	test   %eax,%eax
     704:	74 07                	je     70d <peek+0x6f>
     706:	b8 01 00 00 00       	mov    $0x1,%eax
     70b:	eb 05                	jmp    712 <peek+0x74>
     70d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     712:	c9                   	leave  
     713:	c3                   	ret    

00000714 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     714:	55                   	push   %ebp
     715:	89 e5                	mov    %esp,%ebp
     717:	53                   	push   %ebx
     718:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     71e:	8b 45 08             	mov    0x8(%ebp),%eax
     721:	83 ec 0c             	sub    $0xc,%esp
     724:	50                   	push   %eax
     725:	e8 e9 05 00 00       	call   d13 <strlen>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	01 d8                	add    %ebx,%eax
     72f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     732:	83 ec 08             	sub    $0x8,%esp
     735:	ff 75 f4             	pushl  -0xc(%ebp)
     738:	8d 45 08             	lea    0x8(%ebp),%eax
     73b:	50                   	push   %eax
     73c:	e8 61 00 00 00       	call   7a2 <parseline>
     741:	83 c4 10             	add    $0x10,%esp
     744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     747:	83 ec 04             	sub    $0x4,%esp
     74a:	68 fe 1e 00 00       	push   $0x1efe
     74f:	ff 75 f4             	pushl  -0xc(%ebp)
     752:	8d 45 08             	lea    0x8(%ebp),%eax
     755:	50                   	push   %eax
     756:	e8 43 ff ff ff       	call   69e <peek>
     75b:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     75e:	8b 45 08             	mov    0x8(%ebp),%eax
     761:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     764:	74 26                	je     78c <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	83 ec 04             	sub    $0x4,%esp
     76c:	50                   	push   %eax
     76d:	68 ff 1e 00 00       	push   $0x1eff
     772:	6a 02                	push   $0x2
     774:	e8 33 09 00 00       	call   10ac <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 0e 1f 00 00       	push   $0x1f0e
     784:	e8 13 fc ff ff       	call   39c <panic>
     789:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     78c:	83 ec 0c             	sub    $0xc,%esp
     78f:	ff 75 f0             	pushl  -0x10(%ebp)
     792:	e8 eb 03 00 00       	call   b82 <nulterminate>
     797:	83 c4 10             	add    $0x10,%esp
  return cmd;
     79a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     79d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a0:	c9                   	leave  
     7a1:	c3                   	ret    

000007a2 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     7a2:	55                   	push   %ebp
     7a3:	89 e5                	mov    %esp,%ebp
     7a5:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	ff 75 0c             	pushl  0xc(%ebp)
     7ae:	ff 75 08             	pushl  0x8(%ebp)
     7b1:	e8 99 00 00 00       	call   84f <parsepipe>
     7b6:	83 c4 10             	add    $0x10,%esp
     7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7bc:	eb 23                	jmp    7e1 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7be:	6a 00                	push   $0x0
     7c0:	6a 00                	push   $0x0
     7c2:	ff 75 0c             	pushl  0xc(%ebp)
     7c5:	ff 75 08             	pushl  0x8(%ebp)
     7c8:	e8 80 fd ff ff       	call   54d <gettoken>
     7cd:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7d0:	83 ec 0c             	sub    $0xc,%esp
     7d3:	ff 75 f4             	pushl  -0xc(%ebp)
     7d6:	e8 33 fd ff ff       	call   50e <backcmd>
     7db:	83 c4 10             	add    $0x10,%esp
     7de:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     7e1:	83 ec 04             	sub    $0x4,%esp
     7e4:	68 15 1f 00 00       	push   $0x1f15
     7e9:	ff 75 0c             	pushl  0xc(%ebp)
     7ec:	ff 75 08             	pushl  0x8(%ebp)
     7ef:	e8 aa fe ff ff       	call   69e <peek>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	85 c0                	test   %eax,%eax
     7f9:	75 c3                	jne    7be <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     7fb:	83 ec 04             	sub    $0x4,%esp
     7fe:	68 17 1f 00 00       	push   $0x1f17
     803:	ff 75 0c             	pushl  0xc(%ebp)
     806:	ff 75 08             	pushl  0x8(%ebp)
     809:	e8 90 fe ff ff       	call   69e <peek>
     80e:	83 c4 10             	add    $0x10,%esp
     811:	85 c0                	test   %eax,%eax
     813:	74 35                	je     84a <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     815:	6a 00                	push   $0x0
     817:	6a 00                	push   $0x0
     819:	ff 75 0c             	pushl  0xc(%ebp)
     81c:	ff 75 08             	pushl  0x8(%ebp)
     81f:	e8 29 fd ff ff       	call   54d <gettoken>
     824:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     827:	83 ec 08             	sub    $0x8,%esp
     82a:	ff 75 0c             	pushl  0xc(%ebp)
     82d:	ff 75 08             	pushl  0x8(%ebp)
     830:	e8 6d ff ff ff       	call   7a2 <parseline>
     835:	83 c4 10             	add    $0x10,%esp
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	50                   	push   %eax
     83c:	ff 75 f4             	pushl  -0xc(%ebp)
     83f:	e8 82 fc ff ff       	call   4c6 <listcmd>
     844:	83 c4 10             	add    $0x10,%esp
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     84d:	c9                   	leave  
     84e:	c3                   	ret    

0000084f <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     84f:	55                   	push   %ebp
     850:	89 e5                	mov    %esp,%ebp
     852:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     855:	83 ec 08             	sub    $0x8,%esp
     858:	ff 75 0c             	pushl  0xc(%ebp)
     85b:	ff 75 08             	pushl  0x8(%ebp)
     85e:	e8 ec 01 00 00       	call   a4f <parseexec>
     863:	83 c4 10             	add    $0x10,%esp
     866:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     869:	83 ec 04             	sub    $0x4,%esp
     86c:	68 19 1f 00 00       	push   $0x1f19
     871:	ff 75 0c             	pushl  0xc(%ebp)
     874:	ff 75 08             	pushl  0x8(%ebp)
     877:	e8 22 fe ff ff       	call   69e <peek>
     87c:	83 c4 10             	add    $0x10,%esp
     87f:	85 c0                	test   %eax,%eax
     881:	74 35                	je     8b8 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     883:	6a 00                	push   $0x0
     885:	6a 00                	push   $0x0
     887:	ff 75 0c             	pushl  0xc(%ebp)
     88a:	ff 75 08             	pushl  0x8(%ebp)
     88d:	e8 bb fc ff ff       	call   54d <gettoken>
     892:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     895:	83 ec 08             	sub    $0x8,%esp
     898:	ff 75 0c             	pushl  0xc(%ebp)
     89b:	ff 75 08             	pushl  0x8(%ebp)
     89e:	e8 ac ff ff ff       	call   84f <parsepipe>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	83 ec 08             	sub    $0x8,%esp
     8a9:	50                   	push   %eax
     8aa:	ff 75 f4             	pushl  -0xc(%ebp)
     8ad:	e8 cc fb ff ff       	call   47e <pipecmd>
     8b2:	83 c4 10             	add    $0x10,%esp
     8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8bb:	c9                   	leave  
     8bc:	c3                   	ret    

000008bd <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8bd:	55                   	push   %ebp
     8be:	89 e5                	mov    %esp,%ebp
     8c0:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8c3:	e9 b6 00 00 00       	jmp    97e <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     8c8:	6a 00                	push   $0x0
     8ca:	6a 00                	push   $0x0
     8cc:	ff 75 10             	pushl  0x10(%ebp)
     8cf:	ff 75 0c             	pushl  0xc(%ebp)
     8d2:	e8 76 fc ff ff       	call   54d <gettoken>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8dd:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8e0:	50                   	push   %eax
     8e1:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8e4:	50                   	push   %eax
     8e5:	ff 75 10             	pushl  0x10(%ebp)
     8e8:	ff 75 0c             	pushl  0xc(%ebp)
     8eb:	e8 5d fc ff ff       	call   54d <gettoken>
     8f0:	83 c4 10             	add    $0x10,%esp
     8f3:	83 f8 61             	cmp    $0x61,%eax
     8f6:	74 10                	je     908 <parseredirs+0x4b>
      panic("missing file for redirection");
     8f8:	83 ec 0c             	sub    $0xc,%esp
     8fb:	68 1b 1f 00 00       	push   $0x1f1b
     900:	e8 97 fa ff ff       	call   39c <panic>
     905:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     908:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90b:	83 f8 3c             	cmp    $0x3c,%eax
     90e:	74 0c                	je     91c <parseredirs+0x5f>
     910:	83 f8 3e             	cmp    $0x3e,%eax
     913:	74 26                	je     93b <parseredirs+0x7e>
     915:	83 f8 2b             	cmp    $0x2b,%eax
     918:	74 43                	je     95d <parseredirs+0xa0>
     91a:	eb 62                	jmp    97e <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     91c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     91f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     922:	83 ec 0c             	sub    $0xc,%esp
     925:	6a 00                	push   $0x0
     927:	6a 00                	push   $0x0
     929:	52                   	push   %edx
     92a:	50                   	push   %eax
     92b:	ff 75 08             	pushl  0x8(%ebp)
     92e:	e8 e8 fa ff ff       	call   41b <redircmd>
     933:	83 c4 20             	add    $0x20,%esp
     936:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     939:	eb 43                	jmp    97e <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     93b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     93e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     941:	83 ec 0c             	sub    $0xc,%esp
     944:	6a 01                	push   $0x1
     946:	68 01 02 00 00       	push   $0x201
     94b:	52                   	push   %edx
     94c:	50                   	push   %eax
     94d:	ff 75 08             	pushl  0x8(%ebp)
     950:	e8 c6 fa ff ff       	call   41b <redircmd>
     955:	83 c4 20             	add    $0x20,%esp
     958:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     95b:	eb 21                	jmp    97e <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     95d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     960:	8b 45 f0             	mov    -0x10(%ebp),%eax
     963:	83 ec 0c             	sub    $0xc,%esp
     966:	6a 01                	push   $0x1
     968:	68 01 02 00 00       	push   $0x201
     96d:	52                   	push   %edx
     96e:	50                   	push   %eax
     96f:	ff 75 08             	pushl  0x8(%ebp)
     972:	e8 a4 fa ff ff       	call   41b <redircmd>
     977:	83 c4 20             	add    $0x20,%esp
     97a:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     97d:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     97e:	83 ec 04             	sub    $0x4,%esp
     981:	68 38 1f 00 00       	push   $0x1f38
     986:	ff 75 10             	pushl  0x10(%ebp)
     989:	ff 75 0c             	pushl  0xc(%ebp)
     98c:	e8 0d fd ff ff       	call   69e <peek>
     991:	83 c4 10             	add    $0x10,%esp
     994:	85 c0                	test   %eax,%eax
     996:	0f 85 2c ff ff ff    	jne    8c8 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     99f:	c9                   	leave  
     9a0:	c3                   	ret    

000009a1 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     9a1:	55                   	push   %ebp
     9a2:	89 e5                	mov    %esp,%ebp
     9a4:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9a7:	83 ec 04             	sub    $0x4,%esp
     9aa:	68 3b 1f 00 00       	push   $0x1f3b
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 3d 1f 00 00       	push   $0x1f3d
     9c9:	e8 ce f9 ff ff       	call   39c <panic>
     9ce:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9d1:	6a 00                	push   $0x0
     9d3:	6a 00                	push   $0x0
     9d5:	ff 75 0c             	pushl  0xc(%ebp)
     9d8:	ff 75 08             	pushl  0x8(%ebp)
     9db:	e8 6d fb ff ff       	call   54d <gettoken>
     9e0:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9e3:	83 ec 08             	sub    $0x8,%esp
     9e6:	ff 75 0c             	pushl  0xc(%ebp)
     9e9:	ff 75 08             	pushl  0x8(%ebp)
     9ec:	e8 b1 fd ff ff       	call   7a2 <parseline>
     9f1:	83 c4 10             	add    $0x10,%esp
     9f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9f7:	83 ec 04             	sub    $0x4,%esp
     9fa:	68 48 1f 00 00       	push   $0x1f48
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 4a 1f 00 00       	push   $0x1f4a
     a19:	e8 7e f9 ff ff       	call   39c <panic>
     a1e:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a21:	6a 00                	push   $0x0
     a23:	6a 00                	push   $0x0
     a25:	ff 75 0c             	pushl  0xc(%ebp)
     a28:	ff 75 08             	pushl  0x8(%ebp)
     a2b:	e8 1d fb ff ff       	call   54d <gettoken>
     a30:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a33:	83 ec 04             	sub    $0x4,%esp
     a36:	ff 75 0c             	pushl  0xc(%ebp)
     a39:	ff 75 08             	pushl  0x8(%ebp)
     a3c:	ff 75 f4             	pushl  -0xc(%ebp)
     a3f:	e8 79 fe ff ff       	call   8bd <parseredirs>
     a44:	83 c4 10             	add    $0x10,%esp
     a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a4d:	c9                   	leave  
     a4e:	c3                   	ret    

00000a4f <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a4f:	55                   	push   %ebp
     a50:	89 e5                	mov    %esp,%ebp
     a52:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     a55:	83 ec 04             	sub    $0x4,%esp
     a58:	68 3b 1f 00 00       	push   $0x1f3b
     a5d:	ff 75 0c             	pushl  0xc(%ebp)
     a60:	ff 75 08             	pushl  0x8(%ebp)
     a63:	e8 36 fc ff ff       	call   69e <peek>
     a68:	83 c4 10             	add    $0x10,%esp
     a6b:	85 c0                	test   %eax,%eax
     a6d:	74 16                	je     a85 <parseexec+0x36>
    return parseblock(ps, es);
     a6f:	83 ec 08             	sub    $0x8,%esp
     a72:	ff 75 0c             	pushl  0xc(%ebp)
     a75:	ff 75 08             	pushl  0x8(%ebp)
     a78:	e8 24 ff ff ff       	call   9a1 <parseblock>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	e9 fb 00 00 00       	jmp    b80 <parseexec+0x131>

  ret = execcmd();
     a85:	e8 5b f9 ff ff       	call   3e5 <execcmd>
     a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a90:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a9a:	83 ec 04             	sub    $0x4,%esp
     a9d:	ff 75 0c             	pushl  0xc(%ebp)
     aa0:	ff 75 08             	pushl  0x8(%ebp)
     aa3:	ff 75 f0             	pushl  -0x10(%ebp)
     aa6:	e8 12 fe ff ff       	call   8bd <parseredirs>
     aab:	83 c4 10             	add    $0x10,%esp
     aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     ab1:	e9 87 00 00 00       	jmp    b3d <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ab6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ab9:	50                   	push   %eax
     aba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     abd:	50                   	push   %eax
     abe:	ff 75 0c             	pushl  0xc(%ebp)
     ac1:	ff 75 08             	pushl  0x8(%ebp)
     ac4:	e8 84 fa ff ff       	call   54d <gettoken>
     ac9:	83 c4 10             	add    $0x10,%esp
     acc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     acf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ad3:	0f 84 84 00 00 00    	je     b5d <parseexec+0x10e>
      break;
    if(tok != 'a')
     ad9:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     add:	74 10                	je     aef <parseexec+0xa0>
      panic("syntax");
     adf:	83 ec 0c             	sub    $0xc,%esp
     ae2:	68 0e 1f 00 00       	push   $0x1f0e
     ae7:	e8 b0 f8 ff ff       	call   39c <panic>
     aec:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     aef:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     af2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     af8:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     afc:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aff:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b02:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b05:	83 c1 08             	add    $0x8,%ecx
     b08:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     b0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     b10:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     b14:	7e 10                	jle    b26 <parseexec+0xd7>
      panic("too many args");
     b16:	83 ec 0c             	sub    $0xc,%esp
     b19:	68 5d 1f 00 00       	push   $0x1f5d
     b1e:	e8 79 f8 ff ff       	call   39c <panic>
     b23:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b26:	83 ec 04             	sub    $0x4,%esp
     b29:	ff 75 0c             	pushl  0xc(%ebp)
     b2c:	ff 75 08             	pushl  0x8(%ebp)
     b2f:	ff 75 f0             	pushl  -0x10(%ebp)
     b32:	e8 86 fd ff ff       	call   8bd <parseredirs>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     b3d:	83 ec 04             	sub    $0x4,%esp
     b40:	68 6b 1f 00 00       	push   $0x1f6b
     b45:	ff 75 0c             	pushl  0xc(%ebp)
     b48:	ff 75 08             	pushl  0x8(%ebp)
     b4b:	e8 4e fb ff ff       	call   69e <peek>
     b50:	83 c4 10             	add    $0x10,%esp
     b53:	85 c0                	test   %eax,%eax
     b55:	0f 84 5b ff ff ff    	je     ab6 <parseexec+0x67>
     b5b:	eb 01                	jmp    b5e <parseexec+0x10f>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     b5d:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b61:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b64:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b6b:	00 
  cmd->eargv[argc] = 0;
     b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b72:	83 c2 08             	add    $0x8,%edx
     b75:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b7c:	00 
  return ret;
     b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b80:	c9                   	leave  
     b81:	c3                   	ret    

00000b82 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b82:	55                   	push   %ebp
     b83:	89 e5                	mov    %esp,%ebp
     b85:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b88:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b8c:	75 0a                	jne    b98 <nulterminate+0x16>
    return 0;
     b8e:	b8 00 00 00 00       	mov    $0x0,%eax
     b93:	e9 e4 00 00 00       	jmp    c7c <nulterminate+0xfa>
  
  switch(cmd->type){
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	8b 00                	mov    (%eax),%eax
     b9d:	83 f8 05             	cmp    $0x5,%eax
     ba0:	0f 87 d3 00 00 00    	ja     c79 <nulterminate+0xf7>
     ba6:	8b 04 85 70 1f 00 00 	mov    0x1f70(,%eax,4),%eax
     bad:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     baf:	8b 45 08             	mov    0x8(%ebp),%eax
     bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     bb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bbc:	eb 14                	jmp    bd2 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc4:	83 c2 08             	add    $0x8,%edx
     bc7:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bcb:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     bce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bd8:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bdc:	85 c0                	test   %eax,%eax
     bde:	75 de                	jne    bbe <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     be0:	e9 94 00 00 00       	jmp    c79 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     be5:	8b 45 08             	mov    0x8(%ebp),%eax
     be8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     beb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bee:	8b 40 04             	mov    0x4(%eax),%eax
     bf1:	83 ec 0c             	sub    $0xc,%esp
     bf4:	50                   	push   %eax
     bf5:	e8 88 ff ff ff       	call   b82 <nulterminate>
     bfa:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c00:	8b 40 0c             	mov    0xc(%eax),%eax
     c03:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c06:	eb 71                	jmp    c79 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     c08:	8b 45 08             	mov    0x8(%ebp),%eax
     c0b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     c0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c11:	8b 40 04             	mov    0x4(%eax),%eax
     c14:	83 ec 0c             	sub    $0xc,%esp
     c17:	50                   	push   %eax
     c18:	e8 65 ff ff ff       	call   b82 <nulterminate>
     c1d:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c20:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c23:	8b 40 08             	mov    0x8(%eax),%eax
     c26:	83 ec 0c             	sub    $0xc,%esp
     c29:	50                   	push   %eax
     c2a:	e8 53 ff ff ff       	call   b82 <nulterminate>
     c2f:	83 c4 10             	add    $0x10,%esp
    break;
     c32:	eb 45                	jmp    c79 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     c3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c3d:	8b 40 04             	mov    0x4(%eax),%eax
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	50                   	push   %eax
     c44:	e8 39 ff ff ff       	call   b82 <nulterminate>
     c49:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c4f:	8b 40 08             	mov    0x8(%eax),%eax
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	50                   	push   %eax
     c56:	e8 27 ff ff ff       	call   b82 <nulterminate>
     c5b:	83 c4 10             	add    $0x10,%esp
    break;
     c5e:	eb 19                	jmp    c79 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     c66:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c69:	8b 40 04             	mov    0x4(%eax),%eax
     c6c:	83 ec 0c             	sub    $0xc,%esp
     c6f:	50                   	push   %eax
     c70:	e8 0d ff ff ff       	call   b82 <nulterminate>
     c75:	83 c4 10             	add    $0x10,%esp
    break;
     c78:	90                   	nop
  }
  return cmd;
     c79:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c7c:	c9                   	leave  
     c7d:	c3                   	ret    

00000c7e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c7e:	55                   	push   %ebp
     c7f:	89 e5                	mov    %esp,%ebp
     c81:	57                   	push   %edi
     c82:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c86:	8b 55 10             	mov    0x10(%ebp),%edx
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	89 cb                	mov    %ecx,%ebx
     c8e:	89 df                	mov    %ebx,%edi
     c90:	89 d1                	mov    %edx,%ecx
     c92:	fc                   	cld    
     c93:	f3 aa                	rep stos %al,%es:(%edi)
     c95:	89 ca                	mov    %ecx,%edx
     c97:	89 fb                	mov    %edi,%ebx
     c99:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c9c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c9f:	90                   	nop
     ca0:	5b                   	pop    %ebx
     ca1:	5f                   	pop    %edi
     ca2:	5d                   	pop    %ebp
     ca3:	c3                   	ret    

00000ca4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ca4:	55                   	push   %ebp
     ca5:	89 e5                	mov    %esp,%ebp
     ca7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     caa:	8b 45 08             	mov    0x8(%ebp),%eax
     cad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     cb0:	90                   	nop
     cb1:	8b 45 08             	mov    0x8(%ebp),%eax
     cb4:	8d 50 01             	lea    0x1(%eax),%edx
     cb7:	89 55 08             	mov    %edx,0x8(%ebp)
     cba:	8b 55 0c             	mov    0xc(%ebp),%edx
     cbd:	8d 4a 01             	lea    0x1(%edx),%ecx
     cc0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     cc3:	0f b6 12             	movzbl (%edx),%edx
     cc6:	88 10                	mov    %dl,(%eax)
     cc8:	0f b6 00             	movzbl (%eax),%eax
     ccb:	84 c0                	test   %al,%al
     ccd:	75 e2                	jne    cb1 <strcpy+0xd>
    ;
  return os;
     ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cd2:	c9                   	leave  
     cd3:	c3                   	ret    

00000cd4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cd4:	55                   	push   %ebp
     cd5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cd7:	eb 08                	jmp    ce1 <strcmp+0xd>
    p++, q++;
     cd9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cdd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ce1:	8b 45 08             	mov    0x8(%ebp),%eax
     ce4:	0f b6 00             	movzbl (%eax),%eax
     ce7:	84 c0                	test   %al,%al
     ce9:	74 10                	je     cfb <strcmp+0x27>
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	0f b6 10             	movzbl (%eax),%edx
     cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf4:	0f b6 00             	movzbl (%eax),%eax
     cf7:	38 c2                	cmp    %al,%dl
     cf9:	74 de                	je     cd9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     cfb:	8b 45 08             	mov    0x8(%ebp),%eax
     cfe:	0f b6 00             	movzbl (%eax),%eax
     d01:	0f b6 d0             	movzbl %al,%edx
     d04:	8b 45 0c             	mov    0xc(%ebp),%eax
     d07:	0f b6 00             	movzbl (%eax),%eax
     d0a:	0f b6 c0             	movzbl %al,%eax
     d0d:	29 c2                	sub    %eax,%edx
     d0f:	89 d0                	mov    %edx,%eax
}
     d11:	5d                   	pop    %ebp
     d12:	c3                   	ret    

00000d13 <strlen>:

uint
strlen(char *s)
{
     d13:	55                   	push   %ebp
     d14:	89 e5                	mov    %esp,%ebp
     d16:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d20:	eb 04                	jmp    d26 <strlen+0x13>
     d22:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d26:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	0f b6 00             	movzbl (%eax),%eax
     d31:	84 c0                	test   %al,%al
     d33:	75 ed                	jne    d22 <strlen+0xf>
    ;
  return n;
     d35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d38:	c9                   	leave  
     d39:	c3                   	ret    

00000d3a <memset>:

void*
memset(void *dst, int c, uint n)
{
     d3a:	55                   	push   %ebp
     d3b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d3d:	8b 45 10             	mov    0x10(%ebp),%eax
     d40:	50                   	push   %eax
     d41:	ff 75 0c             	pushl  0xc(%ebp)
     d44:	ff 75 08             	pushl  0x8(%ebp)
     d47:	e8 32 ff ff ff       	call   c7e <stosb>
     d4c:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d52:	c9                   	leave  
     d53:	c3                   	ret    

00000d54 <strchr>:

char*
strchr(const char *s, char c)
{
     d54:	55                   	push   %ebp
     d55:	89 e5                	mov    %esp,%ebp
     d57:	83 ec 04             	sub    $0x4,%esp
     d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d60:	eb 14                	jmp    d76 <strchr+0x22>
    if(*s == c)
     d62:	8b 45 08             	mov    0x8(%ebp),%eax
     d65:	0f b6 00             	movzbl (%eax),%eax
     d68:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d6b:	75 05                	jne    d72 <strchr+0x1e>
      return (char*)s;
     d6d:	8b 45 08             	mov    0x8(%ebp),%eax
     d70:	eb 13                	jmp    d85 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     d72:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d76:	8b 45 08             	mov    0x8(%ebp),%eax
     d79:	0f b6 00             	movzbl (%eax),%eax
     d7c:	84 c0                	test   %al,%al
     d7e:	75 e2                	jne    d62 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     d80:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d85:	c9                   	leave  
     d86:	c3                   	ret    

00000d87 <gets>:

char*
gets(char *buf, int max)
{
     d87:	55                   	push   %ebp
     d88:	89 e5                	mov    %esp,%ebp
     d8a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d94:	eb 42                	jmp    dd8 <gets+0x51>
    cc = read(0, &c, 1);
     d96:	83 ec 04             	sub    $0x4,%esp
     d99:	6a 01                	push   $0x1
     d9b:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d9e:	50                   	push   %eax
     d9f:	6a 00                	push   $0x0
     da1:	e8 47 01 00 00       	call   eed <read>
     da6:	83 c4 10             	add    $0x10,%esp
     da9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     dac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     db0:	7e 33                	jle    de5 <gets+0x5e>
      break;
    buf[i++] = c;
     db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db5:	8d 50 01             	lea    0x1(%eax),%edx
     db8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     dbb:	89 c2                	mov    %eax,%edx
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	01 c2                	add    %eax,%edx
     dc2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dc6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     dc8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dcc:	3c 0a                	cmp    $0xa,%al
     dce:	74 16                	je     de6 <gets+0x5f>
     dd0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dd4:	3c 0d                	cmp    $0xd,%al
     dd6:	74 0e                	je     de6 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddb:	83 c0 01             	add    $0x1,%eax
     dde:	3b 45 0c             	cmp    0xc(%ebp),%eax
     de1:	7c b3                	jl     d96 <gets+0xf>
     de3:	eb 01                	jmp    de6 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     de5:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     de6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	01 d0                	add    %edx,%eax
     dee:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     df1:	8b 45 08             	mov    0x8(%ebp),%eax
}
     df4:	c9                   	leave  
     df5:	c3                   	ret    

00000df6 <stat>:

int
stat(char *n, struct stat *st)
{
     df6:	55                   	push   %ebp
     df7:	89 e5                	mov    %esp,%ebp
     df9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dfc:	83 ec 08             	sub    $0x8,%esp
     dff:	6a 00                	push   $0x0
     e01:	ff 75 08             	pushl  0x8(%ebp)
     e04:	e8 0c 01 00 00       	call   f15 <open>
     e09:	83 c4 10             	add    $0x10,%esp
     e0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     e0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e13:	79 07                	jns    e1c <stat+0x26>
    return -1;
     e15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e1a:	eb 25                	jmp    e41 <stat+0x4b>
  r = fstat(fd, st);
     e1c:	83 ec 08             	sub    $0x8,%esp
     e1f:	ff 75 0c             	pushl  0xc(%ebp)
     e22:	ff 75 f4             	pushl  -0xc(%ebp)
     e25:	e8 03 01 00 00       	call   f2d <fstat>
     e2a:	83 c4 10             	add    $0x10,%esp
     e2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e30:	83 ec 0c             	sub    $0xc,%esp
     e33:	ff 75 f4             	pushl  -0xc(%ebp)
     e36:	e8 c2 00 00 00       	call   efd <close>
     e3b:	83 c4 10             	add    $0x10,%esp
  return r;
     e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e41:	c9                   	leave  
     e42:	c3                   	ret    

00000e43 <atoi>:

int
atoi(const char *s)
{
     e43:	55                   	push   %ebp
     e44:	89 e5                	mov    %esp,%ebp
     e46:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e50:	eb 25                	jmp    e77 <atoi+0x34>
    n = n*10 + *s++ - '0';
     e52:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e55:	89 d0                	mov    %edx,%eax
     e57:	c1 e0 02             	shl    $0x2,%eax
     e5a:	01 d0                	add    %edx,%eax
     e5c:	01 c0                	add    %eax,%eax
     e5e:	89 c1                	mov    %eax,%ecx
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
     e63:	8d 50 01             	lea    0x1(%eax),%edx
     e66:	89 55 08             	mov    %edx,0x8(%ebp)
     e69:	0f b6 00             	movzbl (%eax),%eax
     e6c:	0f be c0             	movsbl %al,%eax
     e6f:	01 c8                	add    %ecx,%eax
     e71:	83 e8 30             	sub    $0x30,%eax
     e74:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	0f b6 00             	movzbl (%eax),%eax
     e7d:	3c 2f                	cmp    $0x2f,%al
     e7f:	7e 0a                	jle    e8b <atoi+0x48>
     e81:	8b 45 08             	mov    0x8(%ebp),%eax
     e84:	0f b6 00             	movzbl (%eax),%eax
     e87:	3c 39                	cmp    $0x39,%al
     e89:	7e c7                	jle    e52 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     e8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e8e:	c9                   	leave  
     e8f:	c3                   	ret    

00000e90 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e96:	8b 45 08             	mov    0x8(%ebp),%eax
     e99:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     ea2:	eb 17                	jmp    ebb <memmove+0x2b>
    *dst++ = *src++;
     ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ea7:	8d 50 01             	lea    0x1(%eax),%edx
     eaa:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ead:	8b 55 f8             	mov    -0x8(%ebp),%edx
     eb0:	8d 4a 01             	lea    0x1(%edx),%ecx
     eb3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     eb6:	0f b6 12             	movzbl (%edx),%edx
     eb9:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ebb:	8b 45 10             	mov    0x10(%ebp),%eax
     ebe:	8d 50 ff             	lea    -0x1(%eax),%edx
     ec1:	89 55 10             	mov    %edx,0x10(%ebp)
     ec4:	85 c0                	test   %eax,%eax
     ec6:	7f dc                	jg     ea4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     ec8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ecb:	c9                   	leave  
     ecc:	c3                   	ret    

00000ecd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ecd:	b8 01 00 00 00       	mov    $0x1,%eax
     ed2:	cd 40                	int    $0x40
     ed4:	c3                   	ret    

00000ed5 <exit>:
SYSCALL(exit)
     ed5:	b8 02 00 00 00       	mov    $0x2,%eax
     eda:	cd 40                	int    $0x40
     edc:	c3                   	ret    

00000edd <wait>:
SYSCALL(wait)
     edd:	b8 03 00 00 00       	mov    $0x3,%eax
     ee2:	cd 40                	int    $0x40
     ee4:	c3                   	ret    

00000ee5 <pipe>:
SYSCALL(pipe)
     ee5:	b8 04 00 00 00       	mov    $0x4,%eax
     eea:	cd 40                	int    $0x40
     eec:	c3                   	ret    

00000eed <read>:
SYSCALL(read)
     eed:	b8 05 00 00 00       	mov    $0x5,%eax
     ef2:	cd 40                	int    $0x40
     ef4:	c3                   	ret    

00000ef5 <write>:
SYSCALL(write)
     ef5:	b8 10 00 00 00       	mov    $0x10,%eax
     efa:	cd 40                	int    $0x40
     efc:	c3                   	ret    

00000efd <close>:
SYSCALL(close)
     efd:	b8 15 00 00 00       	mov    $0x15,%eax
     f02:	cd 40                	int    $0x40
     f04:	c3                   	ret    

00000f05 <kill>:
SYSCALL(kill)
     f05:	b8 06 00 00 00       	mov    $0x6,%eax
     f0a:	cd 40                	int    $0x40
     f0c:	c3                   	ret    

00000f0d <exec>:
SYSCALL(exec)
     f0d:	b8 07 00 00 00       	mov    $0x7,%eax
     f12:	cd 40                	int    $0x40
     f14:	c3                   	ret    

00000f15 <open>:
SYSCALL(open)
     f15:	b8 0f 00 00 00       	mov    $0xf,%eax
     f1a:	cd 40                	int    $0x40
     f1c:	c3                   	ret    

00000f1d <mknod>:
SYSCALL(mknod)
     f1d:	b8 11 00 00 00       	mov    $0x11,%eax
     f22:	cd 40                	int    $0x40
     f24:	c3                   	ret    

00000f25 <unlink>:
SYSCALL(unlink)
     f25:	b8 12 00 00 00       	mov    $0x12,%eax
     f2a:	cd 40                	int    $0x40
     f2c:	c3                   	ret    

00000f2d <fstat>:
SYSCALL(fstat)
     f2d:	b8 08 00 00 00       	mov    $0x8,%eax
     f32:	cd 40                	int    $0x40
     f34:	c3                   	ret    

00000f35 <link>:
SYSCALL(link)
     f35:	b8 13 00 00 00       	mov    $0x13,%eax
     f3a:	cd 40                	int    $0x40
     f3c:	c3                   	ret    

00000f3d <mkdir>:
SYSCALL(mkdir)
     f3d:	b8 14 00 00 00       	mov    $0x14,%eax
     f42:	cd 40                	int    $0x40
     f44:	c3                   	ret    

00000f45 <chdir>:
SYSCALL(chdir)
     f45:	b8 09 00 00 00       	mov    $0x9,%eax
     f4a:	cd 40                	int    $0x40
     f4c:	c3                   	ret    

00000f4d <dup>:
SYSCALL(dup)
     f4d:	b8 0a 00 00 00       	mov    $0xa,%eax
     f52:	cd 40                	int    $0x40
     f54:	c3                   	ret    

00000f55 <getpid>:
SYSCALL(getpid)
     f55:	b8 0b 00 00 00       	mov    $0xb,%eax
     f5a:	cd 40                	int    $0x40
     f5c:	c3                   	ret    

00000f5d <sbrk>:
SYSCALL(sbrk)
     f5d:	b8 0c 00 00 00       	mov    $0xc,%eax
     f62:	cd 40                	int    $0x40
     f64:	c3                   	ret    

00000f65 <sleep>:
SYSCALL(sleep)
     f65:	b8 0d 00 00 00       	mov    $0xd,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <uptime>:
SYSCALL(uptime)
     f6d:	b8 0e 00 00 00       	mov    $0xe,%eax
     f72:	cd 40                	int    $0x40
     f74:	c3                   	ret    

00000f75 <setCursorPos>:


//add
SYSCALL(setCursorPos)
     f75:	b8 16 00 00 00       	mov    $0x16,%eax
     f7a:	cd 40                	int    $0x40
     f7c:	c3                   	ret    

00000f7d <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     f7d:	b8 17 00 00 00       	mov    $0x17,%eax
     f82:	cd 40                	int    $0x40
     f84:	c3                   	ret    

00000f85 <clearScreen>:
SYSCALL(clearScreen)
     f85:	b8 18 00 00 00       	mov    $0x18,%eax
     f8a:	cd 40                	int    $0x40
     f8c:	c3                   	ret    

00000f8d <writeAt>:
SYSCALL(writeAt)
     f8d:	b8 19 00 00 00       	mov    $0x19,%eax
     f92:	cd 40                	int    $0x40
     f94:	c3                   	ret    

00000f95 <setBufferFlag>:
SYSCALL(setBufferFlag)
     f95:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f9a:	cd 40                	int    $0x40
     f9c:	c3                   	ret    

00000f9d <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     f9d:	b8 1b 00 00 00       	mov    $0x1b,%eax
     fa2:	cd 40                	int    $0x40
     fa4:	c3                   	ret    

00000fa5 <getCursorPos>:
SYSCALL(getCursorPos)
     fa5:	b8 1c 00 00 00       	mov    $0x1c,%eax
     faa:	cd 40                	int    $0x40
     fac:	c3                   	ret    

00000fad <saveScreen>:
SYSCALL(saveScreen)
     fad:	b8 1d 00 00 00       	mov    $0x1d,%eax
     fb2:	cd 40                	int    $0x40
     fb4:	c3                   	ret    

00000fb5 <recorverScreen>:
SYSCALL(recorverScreen)
     fb5:	b8 1e 00 00 00       	mov    $0x1e,%eax
     fba:	cd 40                	int    $0x40
     fbc:	c3                   	ret    

00000fbd <ToScreen>:
SYSCALL(ToScreen)
     fbd:	b8 1f 00 00 00       	mov    $0x1f,%eax
     fc2:	cd 40                	int    $0x40
     fc4:	c3                   	ret    

00000fc5 <getColor>:
SYSCALL(getColor)
     fc5:	b8 20 00 00 00       	mov    $0x20,%eax
     fca:	cd 40                	int    $0x40
     fcc:	c3                   	ret    

00000fcd <showC>:
SYSCALL(showC)
     fcd:	b8 21 00 00 00       	mov    $0x21,%eax
     fd2:	cd 40                	int    $0x40
     fd4:	c3                   	ret    

00000fd5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     fd5:	55                   	push   %ebp
     fd6:	89 e5                	mov    %esp,%ebp
     fd8:	83 ec 18             	sub    $0x18,%esp
     fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fde:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fe1:	83 ec 04             	sub    $0x4,%esp
     fe4:	6a 01                	push   $0x1
     fe6:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fe9:	50                   	push   %eax
     fea:	ff 75 08             	pushl  0x8(%ebp)
     fed:	e8 03 ff ff ff       	call   ef5 <write>
     ff2:	83 c4 10             	add    $0x10,%esp
}
     ff5:	90                   	nop
     ff6:	c9                   	leave  
     ff7:	c3                   	ret    

00000ff8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     ff8:	55                   	push   %ebp
     ff9:	89 e5                	mov    %esp,%ebp
     ffb:	53                   	push   %ebx
     ffc:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1006:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    100a:	74 17                	je     1023 <printint+0x2b>
    100c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1010:	79 11                	jns    1023 <printint+0x2b>
    neg = 1;
    1012:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1019:	8b 45 0c             	mov    0xc(%ebp),%eax
    101c:	f7 d8                	neg    %eax
    101e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1021:	eb 06                	jmp    1029 <printint+0x31>
  } else {
    x = xx;
    1023:	8b 45 0c             	mov    0xc(%ebp),%eax
    1026:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1029:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1030:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1033:	8d 41 01             	lea    0x1(%ecx),%eax
    1036:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1039:	8b 5d 10             	mov    0x10(%ebp),%ebx
    103c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    103f:	ba 00 00 00 00       	mov    $0x0,%edx
    1044:	f7 f3                	div    %ebx
    1046:	89 d0                	mov    %edx,%eax
    1048:	0f b6 80 f0 28 00 00 	movzbl 0x28f0(%eax),%eax
    104f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1053:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1056:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1059:	ba 00 00 00 00       	mov    $0x0,%edx
    105e:	f7 f3                	div    %ebx
    1060:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1063:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1067:	75 c7                	jne    1030 <printint+0x38>
  if(neg)
    1069:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    106d:	74 2d                	je     109c <printint+0xa4>
    buf[i++] = '-';
    106f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1072:	8d 50 01             	lea    0x1(%eax),%edx
    1075:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1078:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    107d:	eb 1d                	jmp    109c <printint+0xa4>
    putc(fd, buf[i]);
    107f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1082:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1085:	01 d0                	add    %edx,%eax
    1087:	0f b6 00             	movzbl (%eax),%eax
    108a:	0f be c0             	movsbl %al,%eax
    108d:	83 ec 08             	sub    $0x8,%esp
    1090:	50                   	push   %eax
    1091:	ff 75 08             	pushl  0x8(%ebp)
    1094:	e8 3c ff ff ff       	call   fd5 <putc>
    1099:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    109c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    10a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10a4:	79 d9                	jns    107f <printint+0x87>
    putc(fd, buf[i]);
}
    10a6:	90                   	nop
    10a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10aa:	c9                   	leave  
    10ab:	c3                   	ret    

000010ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    10ac:	55                   	push   %ebp
    10ad:	89 e5                	mov    %esp,%ebp
    10af:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    10b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    10b9:	8d 45 0c             	lea    0xc(%ebp),%eax
    10bc:	83 c0 04             	add    $0x4,%eax
    10bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    10c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    10c9:	e9 59 01 00 00       	jmp    1227 <printf+0x17b>
    c = fmt[i] & 0xff;
    10ce:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10d4:	01 d0                	add    %edx,%eax
    10d6:	0f b6 00             	movzbl (%eax),%eax
    10d9:	0f be c0             	movsbl %al,%eax
    10dc:	25 ff 00 00 00       	and    $0xff,%eax
    10e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10e8:	75 2c                	jne    1116 <printf+0x6a>
      if(c == '%'){
    10ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10ee:	75 0c                	jne    10fc <printf+0x50>
        state = '%';
    10f0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10f7:	e9 27 01 00 00       	jmp    1223 <printf+0x177>
      } else {
        putc(fd, c);
    10fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10ff:	0f be c0             	movsbl %al,%eax
    1102:	83 ec 08             	sub    $0x8,%esp
    1105:	50                   	push   %eax
    1106:	ff 75 08             	pushl  0x8(%ebp)
    1109:	e8 c7 fe ff ff       	call   fd5 <putc>
    110e:	83 c4 10             	add    $0x10,%esp
    1111:	e9 0d 01 00 00       	jmp    1223 <printf+0x177>
      }
    } else if(state == '%'){
    1116:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    111a:	0f 85 03 01 00 00    	jne    1223 <printf+0x177>
      if(c == 'd'){
    1120:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1124:	75 1e                	jne    1144 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1126:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1129:	8b 00                	mov    (%eax),%eax
    112b:	6a 01                	push   $0x1
    112d:	6a 0a                	push   $0xa
    112f:	50                   	push   %eax
    1130:	ff 75 08             	pushl  0x8(%ebp)
    1133:	e8 c0 fe ff ff       	call   ff8 <printint>
    1138:	83 c4 10             	add    $0x10,%esp
        ap++;
    113b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    113f:	e9 d8 00 00 00       	jmp    121c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1144:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1148:	74 06                	je     1150 <printf+0xa4>
    114a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    114e:	75 1e                	jne    116e <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1150:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1153:	8b 00                	mov    (%eax),%eax
    1155:	6a 00                	push   $0x0
    1157:	6a 10                	push   $0x10
    1159:	50                   	push   %eax
    115a:	ff 75 08             	pushl  0x8(%ebp)
    115d:	e8 96 fe ff ff       	call   ff8 <printint>
    1162:	83 c4 10             	add    $0x10,%esp
        ap++;
    1165:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1169:	e9 ae 00 00 00       	jmp    121c <printf+0x170>
      } else if(c == 's'){
    116e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1172:	75 43                	jne    11b7 <printf+0x10b>
        s = (char*)*ap;
    1174:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1177:	8b 00                	mov    (%eax),%eax
    1179:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    117c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1180:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1184:	75 25                	jne    11ab <printf+0xff>
          s = "(null)";
    1186:	c7 45 f4 88 1f 00 00 	movl   $0x1f88,-0xc(%ebp)
        while(*s != 0){
    118d:	eb 1c                	jmp    11ab <printf+0xff>
          putc(fd, *s);
    118f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1192:	0f b6 00             	movzbl (%eax),%eax
    1195:	0f be c0             	movsbl %al,%eax
    1198:	83 ec 08             	sub    $0x8,%esp
    119b:	50                   	push   %eax
    119c:	ff 75 08             	pushl  0x8(%ebp)
    119f:	e8 31 fe ff ff       	call   fd5 <putc>
    11a4:	83 c4 10             	add    $0x10,%esp
          s++;
    11a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    11ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ae:	0f b6 00             	movzbl (%eax),%eax
    11b1:	84 c0                	test   %al,%al
    11b3:	75 da                	jne    118f <printf+0xe3>
    11b5:	eb 65                	jmp    121c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    11b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    11bb:	75 1d                	jne    11da <printf+0x12e>
        putc(fd, *ap);
    11bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11c0:	8b 00                	mov    (%eax),%eax
    11c2:	0f be c0             	movsbl %al,%eax
    11c5:	83 ec 08             	sub    $0x8,%esp
    11c8:	50                   	push   %eax
    11c9:	ff 75 08             	pushl  0x8(%ebp)
    11cc:	e8 04 fe ff ff       	call   fd5 <putc>
    11d1:	83 c4 10             	add    $0x10,%esp
        ap++;
    11d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11d8:	eb 42                	jmp    121c <printf+0x170>
      } else if(c == '%'){
    11da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11de:	75 17                	jne    11f7 <printf+0x14b>
        putc(fd, c);
    11e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e3:	0f be c0             	movsbl %al,%eax
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	50                   	push   %eax
    11ea:	ff 75 08             	pushl  0x8(%ebp)
    11ed:	e8 e3 fd ff ff       	call   fd5 <putc>
    11f2:	83 c4 10             	add    $0x10,%esp
    11f5:	eb 25                	jmp    121c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11f7:	83 ec 08             	sub    $0x8,%esp
    11fa:	6a 25                	push   $0x25
    11fc:	ff 75 08             	pushl  0x8(%ebp)
    11ff:	e8 d1 fd ff ff       	call   fd5 <putc>
    1204:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1207:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    120a:	0f be c0             	movsbl %al,%eax
    120d:	83 ec 08             	sub    $0x8,%esp
    1210:	50                   	push   %eax
    1211:	ff 75 08             	pushl  0x8(%ebp)
    1214:	e8 bc fd ff ff       	call   fd5 <putc>
    1219:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    121c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1223:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1227:	8b 55 0c             	mov    0xc(%ebp),%edx
    122a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    122d:	01 d0                	add    %edx,%eax
    122f:	0f b6 00             	movzbl (%eax),%eax
    1232:	84 c0                	test   %al,%al
    1234:	0f 85 94 fe ff ff    	jne    10ce <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    123a:	90                   	nop
    123b:	c9                   	leave  
    123c:	c3                   	ret    

0000123d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    123d:	55                   	push   %ebp
    123e:	89 e5                	mov    %esp,%ebp
    1240:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	83 e8 08             	sub    $0x8,%eax
    1249:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    124c:	a1 8c 29 00 00       	mov    0x298c,%eax
    1251:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1254:	eb 24                	jmp    127a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1256:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1259:	8b 00                	mov    (%eax),%eax
    125b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    125e:	77 12                	ja     1272 <free+0x35>
    1260:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1263:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1266:	77 24                	ja     128c <free+0x4f>
    1268:	8b 45 fc             	mov    -0x4(%ebp),%eax
    126b:	8b 00                	mov    (%eax),%eax
    126d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1270:	77 1a                	ja     128c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1272:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1275:	8b 00                	mov    (%eax),%eax
    1277:	89 45 fc             	mov    %eax,-0x4(%ebp)
    127a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    127d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1280:	76 d4                	jbe    1256 <free+0x19>
    1282:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    128a:	76 ca                	jbe    1256 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    128c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    128f:	8b 40 04             	mov    0x4(%eax),%eax
    1292:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1299:	8b 45 f8             	mov    -0x8(%ebp),%eax
    129c:	01 c2                	add    %eax,%edx
    129e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a1:	8b 00                	mov    (%eax),%eax
    12a3:	39 c2                	cmp    %eax,%edx
    12a5:	75 24                	jne    12cb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    12a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12aa:	8b 50 04             	mov    0x4(%eax),%edx
    12ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b0:	8b 00                	mov    (%eax),%eax
    12b2:	8b 40 04             	mov    0x4(%eax),%eax
    12b5:	01 c2                	add    %eax,%edx
    12b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12ba:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    12bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c0:	8b 00                	mov    (%eax),%eax
    12c2:	8b 10                	mov    (%eax),%edx
    12c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12c7:	89 10                	mov    %edx,(%eax)
    12c9:	eb 0a                	jmp    12d5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    12cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ce:	8b 10                	mov    (%eax),%edx
    12d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12d3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    12d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d8:	8b 40 04             	mov    0x4(%eax),%eax
    12db:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e5:	01 d0                	add    %edx,%eax
    12e7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12ea:	75 20                	jne    130c <free+0xcf>
    p->s.size += bp->s.size;
    12ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ef:	8b 50 04             	mov    0x4(%eax),%edx
    12f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12f5:	8b 40 04             	mov    0x4(%eax),%eax
    12f8:	01 c2                	add    %eax,%edx
    12fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12fd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1300:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1303:	8b 10                	mov    (%eax),%edx
    1305:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1308:	89 10                	mov    %edx,(%eax)
    130a:	eb 08                	jmp    1314 <free+0xd7>
  } else
    p->s.ptr = bp;
    130c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    130f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1312:	89 10                	mov    %edx,(%eax)
  freep = p;
    1314:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1317:	a3 8c 29 00 00       	mov    %eax,0x298c
}
    131c:	90                   	nop
    131d:	c9                   	leave  
    131e:	c3                   	ret    

0000131f <morecore>:

static Header*
morecore(uint nu)
{
    131f:	55                   	push   %ebp
    1320:	89 e5                	mov    %esp,%ebp
    1322:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1325:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    132c:	77 07                	ja     1335 <morecore+0x16>
    nu = 4096;
    132e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1335:	8b 45 08             	mov    0x8(%ebp),%eax
    1338:	c1 e0 03             	shl    $0x3,%eax
    133b:	83 ec 0c             	sub    $0xc,%esp
    133e:	50                   	push   %eax
    133f:	e8 19 fc ff ff       	call   f5d <sbrk>
    1344:	83 c4 10             	add    $0x10,%esp
    1347:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    134a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    134e:	75 07                	jne    1357 <morecore+0x38>
    return 0;
    1350:	b8 00 00 00 00       	mov    $0x0,%eax
    1355:	eb 26                	jmp    137d <morecore+0x5e>
  hp = (Header*)p;
    1357:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    135d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1360:	8b 55 08             	mov    0x8(%ebp),%edx
    1363:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1366:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1369:	83 c0 08             	add    $0x8,%eax
    136c:	83 ec 0c             	sub    $0xc,%esp
    136f:	50                   	push   %eax
    1370:	e8 c8 fe ff ff       	call   123d <free>
    1375:	83 c4 10             	add    $0x10,%esp
  return freep;
    1378:	a1 8c 29 00 00       	mov    0x298c,%eax
}
    137d:	c9                   	leave  
    137e:	c3                   	ret    

0000137f <malloc>:

void*
malloc(uint nbytes)
{
    137f:	55                   	push   %ebp
    1380:	89 e5                	mov    %esp,%ebp
    1382:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1385:	8b 45 08             	mov    0x8(%ebp),%eax
    1388:	83 c0 07             	add    $0x7,%eax
    138b:	c1 e8 03             	shr    $0x3,%eax
    138e:	83 c0 01             	add    $0x1,%eax
    1391:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1394:	a1 8c 29 00 00       	mov    0x298c,%eax
    1399:	89 45 f0             	mov    %eax,-0x10(%ebp)
    139c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13a0:	75 23                	jne    13c5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    13a2:	c7 45 f0 84 29 00 00 	movl   $0x2984,-0x10(%ebp)
    13a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13ac:	a3 8c 29 00 00       	mov    %eax,0x298c
    13b1:	a1 8c 29 00 00       	mov    0x298c,%eax
    13b6:	a3 84 29 00 00       	mov    %eax,0x2984
    base.s.size = 0;
    13bb:	c7 05 88 29 00 00 00 	movl   $0x0,0x2988
    13c2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13c8:	8b 00                	mov    (%eax),%eax
    13ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d0:	8b 40 04             	mov    0x4(%eax),%eax
    13d3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13d6:	72 4d                	jb     1425 <malloc+0xa6>
      if(p->s.size == nunits)
    13d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13db:	8b 40 04             	mov    0x4(%eax),%eax
    13de:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13e1:	75 0c                	jne    13ef <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e6:	8b 10                	mov    (%eax),%edx
    13e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13eb:	89 10                	mov    %edx,(%eax)
    13ed:	eb 26                	jmp    1415 <malloc+0x96>
      else {
        p->s.size -= nunits;
    13ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f2:	8b 40 04             	mov    0x4(%eax),%eax
    13f5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13f8:	89 c2                	mov    %eax,%edx
    13fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1400:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1403:	8b 40 04             	mov    0x4(%eax),%eax
    1406:	c1 e0 03             	shl    $0x3,%eax
    1409:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    140c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1412:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1415:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1418:	a3 8c 29 00 00       	mov    %eax,0x298c
      return (void*)(p + 1);
    141d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1420:	83 c0 08             	add    $0x8,%eax
    1423:	eb 3b                	jmp    1460 <malloc+0xe1>
    }
    if(p == freep)
    1425:	a1 8c 29 00 00       	mov    0x298c,%eax
    142a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    142d:	75 1e                	jne    144d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    142f:	83 ec 0c             	sub    $0xc,%esp
    1432:	ff 75 ec             	pushl  -0x14(%ebp)
    1435:	e8 e5 fe ff ff       	call   131f <morecore>
    143a:	83 c4 10             	add    $0x10,%esp
    143d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1440:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1444:	75 07                	jne    144d <malloc+0xce>
        return 0;
    1446:	b8 00 00 00 00       	mov    $0x0,%eax
    144b:	eb 13                	jmp    1460 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    144d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1450:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1453:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1456:	8b 00                	mov    (%eax),%eax
    1458:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    145b:	e9 6d ff ff ff       	jmp    13cd <malloc+0x4e>
}
    1460:	c9                   	leave  
    1461:	c3                   	ret    

00001462 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
    1462:	55                   	push   %ebp
    1463:	89 e5                	mov    %esp,%ebp
    1465:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
    1468:	83 ec 0c             	sub    $0xc,%esp
    146b:	ff 75 08             	pushl  0x8(%ebp)
    146e:	e8 b0 00 00 00       	call   1523 <re_compile>
    1473:	83 c4 10             	add    $0x10,%esp
    1476:	83 ec 04             	sub    $0x4,%esp
    1479:	ff 75 10             	pushl  0x10(%ebp)
    147c:	ff 75 0c             	pushl  0xc(%ebp)
    147f:	50                   	push   %eax
    1480:	e8 05 00 00 00       	call   148a <re_matchp>
    1485:	83 c4 10             	add    $0x10,%esp
}
    1488:	c9                   	leave  
    1489:	c3                   	ret    

0000148a <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
    148a:	55                   	push   %ebp
    148b:	89 e5                	mov    %esp,%ebp
    148d:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
    1490:	8b 45 10             	mov    0x10(%ebp),%eax
    1493:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
    1499:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    149d:	74 7d                	je     151c <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	0f b6 00             	movzbl (%eax),%eax
    14a5:	3c 02                	cmp    $0x2,%al
    14a7:	75 2a                	jne    14d3 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
    14a9:	8b 45 08             	mov    0x8(%ebp),%eax
    14ac:	83 c0 08             	add    $0x8,%eax
    14af:	83 ec 04             	sub    $0x4,%esp
    14b2:	ff 75 10             	pushl  0x10(%ebp)
    14b5:	ff 75 0c             	pushl  0xc(%ebp)
    14b8:	50                   	push   %eax
    14b9:	e8 b0 08 00 00       	call   1d6e <matchpattern>
    14be:	83 c4 10             	add    $0x10,%esp
    14c1:	85 c0                	test   %eax,%eax
    14c3:	74 07                	je     14cc <re_matchp+0x42>
    14c5:	b8 00 00 00 00       	mov    $0x0,%eax
    14ca:	eb 55                	jmp    1521 <re_matchp+0x97>
    14cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14d1:	eb 4e                	jmp    1521 <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
    14d3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
    14da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
    14de:	83 ec 04             	sub    $0x4,%esp
    14e1:	ff 75 10             	pushl  0x10(%ebp)
    14e4:	ff 75 0c             	pushl  0xc(%ebp)
    14e7:	ff 75 08             	pushl  0x8(%ebp)
    14ea:	e8 7f 08 00 00       	call   1d6e <matchpattern>
    14ef:	83 c4 10             	add    $0x10,%esp
    14f2:	85 c0                	test   %eax,%eax
    14f4:	74 16                	je     150c <re_matchp+0x82>
        {
          if (text[0] == '\0')
    14f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f9:	0f b6 00             	movzbl (%eax),%eax
    14fc:	84 c0                	test   %al,%al
    14fe:	75 07                	jne    1507 <re_matchp+0x7d>
            return -1;
    1500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1505:	eb 1a                	jmp    1521 <re_matchp+0x97>
        
          return idx;
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	eb 15                	jmp    1521 <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
    150c:	8b 45 0c             	mov    0xc(%ebp),%eax
    150f:	8d 50 01             	lea    0x1(%eax),%edx
    1512:	89 55 0c             	mov    %edx,0xc(%ebp)
    1515:	0f b6 00             	movzbl (%eax),%eax
    1518:	84 c0                	test   %al,%al
    151a:	75 be                	jne    14da <re_matchp+0x50>
    }
  }
  return -1;
    151c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1521:	c9                   	leave  
    1522:	c3                   	ret    

00001523 <re_compile>:

re_t re_compile(const char* pattern)
{
    1523:	55                   	push   %ebp
    1524:	89 e5                	mov    %esp,%ebp
    1526:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
    1529:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
    1530:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
    1537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
    153e:	e9 55 02 00 00       	jmp    1798 <re_compile+0x275>
  {
    c = pattern[i];
    1543:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1546:	8b 45 08             	mov    0x8(%ebp),%eax
    1549:	01 d0                	add    %edx,%eax
    154b:	0f b6 00             	movzbl (%eax),%eax
    154e:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
    1551:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
    1555:	83 e8 24             	sub    $0x24,%eax
    1558:	83 f8 3a             	cmp    $0x3a,%eax
    155b:	0f 87 13 02 00 00    	ja     1774 <re_compile+0x251>
    1561:	8b 04 85 90 1f 00 00 	mov    0x1f90(,%eax,4),%eax
    1568:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
    156a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156d:	c6 04 c5 a0 29 00 00 	movb   $0x2,0x29a0(,%eax,8)
    1574:	02 
    1575:	e9 16 02 00 00       	jmp    1790 <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
    157a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157d:	c6 04 c5 a0 29 00 00 	movb   $0x3,0x29a0(,%eax,8)
    1584:	03 
    1585:	e9 06 02 00 00       	jmp    1790 <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
    158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158d:	c6 04 c5 a0 29 00 00 	movb   $0x1,0x29a0(,%eax,8)
    1594:	01 
    1595:	e9 f6 01 00 00       	jmp    1790 <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	c6 04 c5 a0 29 00 00 	movb   $0x5,0x29a0(,%eax,8)
    15a4:	05 
    15a5:	e9 e6 01 00 00       	jmp    1790 <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
    15aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ad:	c6 04 c5 a0 29 00 00 	movb   $0x6,0x29a0(,%eax,8)
    15b4:	06 
    15b5:	e9 d6 01 00 00       	jmp    1790 <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	c6 04 c5 a0 29 00 00 	movb   $0x4,0x29a0(,%eax,8)
    15c4:	04 
    15c5:	e9 c6 01 00 00       	jmp    1790 <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
    15ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15cd:	8d 50 01             	lea    0x1(%eax),%edx
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	01 d0                	add    %edx,%eax
    15d5:	0f b6 00             	movzbl (%eax),%eax
    15d8:	84 c0                	test   %al,%al
    15da:	0f 84 af 01 00 00    	je     178f <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
    15e0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
    15e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    15e7:	8b 45 08             	mov    0x8(%ebp),%eax
    15ea:	01 d0                	add    %edx,%eax
    15ec:	0f b6 00             	movzbl (%eax),%eax
    15ef:	0f be c0             	movsbl %al,%eax
    15f2:	83 e8 44             	sub    $0x44,%eax
    15f5:	83 f8 33             	cmp    $0x33,%eax
    15f8:	77 57                	ja     1651 <re_compile+0x12e>
    15fa:	8b 04 85 7c 20 00 00 	mov    0x207c(,%eax,4),%eax
    1601:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
    1603:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1606:	c6 04 c5 a0 29 00 00 	movb   $0xa,0x29a0(,%eax,8)
    160d:	0a 
    160e:	eb 64                	jmp    1674 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	c6 04 c5 a0 29 00 00 	movb   $0xb,0x29a0(,%eax,8)
    161a:	0b 
    161b:	eb 57                	jmp    1674 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	c6 04 c5 a0 29 00 00 	movb   $0xc,0x29a0(,%eax,8)
    1627:	0c 
    1628:	eb 4a                	jmp    1674 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	c6 04 c5 a0 29 00 00 	movb   $0xd,0x29a0(,%eax,8)
    1634:	0d 
    1635:	eb 3d                	jmp    1674 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
    1637:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163a:	c6 04 c5 a0 29 00 00 	movb   $0xe,0x29a0(,%eax,8)
    1641:	0e 
    1642:	eb 30                	jmp    1674 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	c6 04 c5 a0 29 00 00 	movb   $0xf,0x29a0(,%eax,8)
    164e:	0f 
    164f:	eb 23                	jmp    1674 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
    1651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1654:	c6 04 c5 a0 29 00 00 	movb   $0x7,0x29a0(,%eax,8)
    165b:	07 
              re_compiled[j].ch = pattern[i];
    165c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	01 d0                	add    %edx,%eax
    1664:	0f b6 00             	movzbl (%eax),%eax
    1667:	89 c2                	mov    %eax,%edx
    1669:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166c:	88 14 c5 a4 29 00 00 	mov    %dl,0x29a4(,%eax,8)
            } break;
    1673:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
    1674:	e9 16 01 00 00       	jmp    178f <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
    1679:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167c:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
    167f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1682:	8d 50 01             	lea    0x1(%eax),%edx
    1685:	8b 45 08             	mov    0x8(%ebp),%eax
    1688:	01 d0                	add    %edx,%eax
    168a:	0f b6 00             	movzbl (%eax),%eax
    168d:	3c 5e                	cmp    $0x5e,%al
    168f:	75 11                	jne    16a2 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	c6 04 c5 a0 29 00 00 	movb   $0x9,0x29a0(,%eax,8)
    169b:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
    169c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    16a0:	eb 7a                	jmp    171c <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	c6 04 c5 a0 29 00 00 	movb   $0x8,0x29a0(,%eax,8)
    16ac:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
    16ad:	eb 6d                	jmp    171c <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
    16af:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16b2:	8b 45 08             	mov    0x8(%ebp),%eax
    16b5:	01 d0                	add    %edx,%eax
    16b7:	0f b6 00             	movzbl (%eax),%eax
    16ba:	3c 5c                	cmp    $0x5c,%al
    16bc:	75 34                	jne    16f2 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
    16be:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
    16c2:	7e 0a                	jle    16ce <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
    16c4:	b8 00 00 00 00       	mov    $0x0,%eax
    16c9:	e9 f8 00 00 00       	jmp    17c6 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
    16ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d1:	8d 50 01             	lea    0x1(%eax),%edx
    16d4:	89 55 fc             	mov    %edx,-0x4(%ebp)
    16d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16da:	8d 4a 01             	lea    0x1(%edx),%ecx
    16dd:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    16e0:	89 d1                	mov    %edx,%ecx
    16e2:	8b 55 08             	mov    0x8(%ebp),%edx
    16e5:	01 ca                	add    %ecx,%edx
    16e7:	0f b6 12             	movzbl (%edx),%edx
    16ea:	88 90 a0 2a 00 00    	mov    %dl,0x2aa0(%eax)
    16f0:	eb 10                	jmp    1702 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
    16f2:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
    16f6:	7e 0a                	jle    1702 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
    16f8:	b8 00 00 00 00       	mov    $0x0,%eax
    16fd:	e9 c4 00 00 00       	jmp    17c6 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
    1702:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1705:	8d 50 01             	lea    0x1(%eax),%edx
    1708:	89 55 fc             	mov    %edx,-0x4(%ebp)
    170b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    170e:	8b 55 08             	mov    0x8(%ebp),%edx
    1711:	01 ca                	add    %ecx,%edx
    1713:	0f b6 12             	movzbl (%edx),%edx
    1716:	88 90 a0 2a 00 00    	mov    %dl,0x2aa0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
    171c:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1720:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1723:	8b 45 08             	mov    0x8(%ebp),%eax
    1726:	01 d0                	add    %edx,%eax
    1728:	0f b6 00             	movzbl (%eax),%eax
    172b:	3c 5d                	cmp    $0x5d,%al
    172d:	74 13                	je     1742 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
    172f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1732:	8b 45 08             	mov    0x8(%ebp),%eax
    1735:	01 d0                	add    %edx,%eax
    1737:	0f b6 00             	movzbl (%eax),%eax
    173a:	84 c0                	test   %al,%al
    173c:	0f 85 6d ff ff ff    	jne    16af <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
    1742:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
    1746:	7e 07                	jle    174f <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
    1748:	b8 00 00 00 00       	mov    $0x0,%eax
    174d:	eb 77                	jmp    17c6 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
    174f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1752:	8d 50 01             	lea    0x1(%eax),%edx
    1755:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1758:	c6 80 a0 2a 00 00 00 	movb   $0x0,0x2aa0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
    175f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1762:	8d 90 a0 2a 00 00    	lea    0x2aa0(%eax),%edx
    1768:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176b:	89 14 c5 a4 29 00 00 	mov    %edx,0x29a4(,%eax,8)
      } break;
    1772:	eb 1c                	jmp    1790 <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
    1774:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1777:	c6 04 c5 a0 29 00 00 	movb   $0x7,0x29a0(,%eax,8)
    177e:	07 
        re_compiled[j].ch = c;
    177f:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
    1783:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1786:	88 14 c5 a4 29 00 00 	mov    %dl,0x29a4(,%eax,8)
      } break;
    178d:	eb 01                	jmp    1790 <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
    178f:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
    1790:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
    1794:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
    1798:	8b 55 f8             	mov    -0x8(%ebp),%edx
    179b:	8b 45 08             	mov    0x8(%ebp),%eax
    179e:	01 d0                	add    %edx,%eax
    17a0:	0f b6 00             	movzbl (%eax),%eax
    17a3:	84 c0                	test   %al,%al
    17a5:	74 0f                	je     17b6 <re_compile+0x293>
    17a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17aa:	83 c0 01             	add    $0x1,%eax
    17ad:	83 f8 1d             	cmp    $0x1d,%eax
    17b0:	0f 8e 8d fd ff ff    	jle    1543 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
    17b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b9:	c6 04 c5 a0 29 00 00 	movb   $0x0,0x29a0(,%eax,8)
    17c0:	00 

  return (re_t) re_compiled;
    17c1:	b8 a0 29 00 00       	mov    $0x29a0,%eax
}
    17c6:	c9                   	leave  
    17c7:	c3                   	ret    

000017c8 <matchdigit>:
*/


/* Private functions: */
static int matchdigit(char c)
{
    17c8:	55                   	push   %ebp
    17c9:	89 e5                	mov    %esp,%ebp
    17cb:	83 ec 04             	sub    $0x4,%esp
    17ce:	8b 45 08             	mov    0x8(%ebp),%eax
    17d1:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
    17d4:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
    17d8:	7e 0d                	jle    17e7 <matchdigit+0x1f>
    17da:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
    17de:	7f 07                	jg     17e7 <matchdigit+0x1f>
    17e0:	b8 01 00 00 00       	mov    $0x1,%eax
    17e5:	eb 05                	jmp    17ec <matchdigit+0x24>
    17e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17ec:	c9                   	leave  
    17ed:	c3                   	ret    

000017ee <matchalpha>:
static int matchalpha(char c)
{
    17ee:	55                   	push   %ebp
    17ef:	89 e5                	mov    %esp,%ebp
    17f1:	83 ec 04             	sub    $0x4,%esp
    17f4:	8b 45 08             	mov    0x8(%ebp),%eax
    17f7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
    17fa:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
    17fe:	7e 06                	jle    1806 <matchalpha+0x18>
    1800:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
    1804:	7e 0c                	jle    1812 <matchalpha+0x24>
    1806:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
    180a:	7e 0d                	jle    1819 <matchalpha+0x2b>
    180c:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
    1810:	7f 07                	jg     1819 <matchalpha+0x2b>
    1812:	b8 01 00 00 00       	mov    $0x1,%eax
    1817:	eb 05                	jmp    181e <matchalpha+0x30>
    1819:	b8 00 00 00 00       	mov    $0x0,%eax
}
    181e:	c9                   	leave  
    181f:	c3                   	ret    

00001820 <matchwhitespace>:
static int matchwhitespace(char c)
{
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	83 ec 04             	sub    $0x4,%esp
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
    182c:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
    1830:	74 1e                	je     1850 <matchwhitespace+0x30>
    1832:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
    1836:	74 18                	je     1850 <matchwhitespace+0x30>
    1838:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
    183c:	74 12                	je     1850 <matchwhitespace+0x30>
    183e:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
    1842:	74 0c                	je     1850 <matchwhitespace+0x30>
    1844:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
    1848:	74 06                	je     1850 <matchwhitespace+0x30>
    184a:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
    184e:	75 07                	jne    1857 <matchwhitespace+0x37>
    1850:	b8 01 00 00 00       	mov    $0x1,%eax
    1855:	eb 05                	jmp    185c <matchwhitespace+0x3c>
    1857:	b8 00 00 00 00       	mov    $0x0,%eax
}
    185c:	c9                   	leave  
    185d:	c3                   	ret    

0000185e <matchalphanum>:
static int matchalphanum(char c)
{
    185e:	55                   	push   %ebp
    185f:	89 e5                	mov    %esp,%ebp
    1861:	83 ec 04             	sub    $0x4,%esp
    1864:	8b 45 08             	mov    0x8(%ebp),%eax
    1867:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
    186a:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
    186e:	74 22                	je     1892 <matchalphanum+0x34>
    1870:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1874:	50                   	push   %eax
    1875:	e8 74 ff ff ff       	call   17ee <matchalpha>
    187a:	83 c4 04             	add    $0x4,%esp
    187d:	85 c0                	test   %eax,%eax
    187f:	75 11                	jne    1892 <matchalphanum+0x34>
    1881:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1885:	50                   	push   %eax
    1886:	e8 3d ff ff ff       	call   17c8 <matchdigit>
    188b:	83 c4 04             	add    $0x4,%esp
    188e:	85 c0                	test   %eax,%eax
    1890:	74 07                	je     1899 <matchalphanum+0x3b>
    1892:	b8 01 00 00 00       	mov    $0x1,%eax
    1897:	eb 05                	jmp    189e <matchalphanum+0x40>
    1899:	b8 00 00 00 00       	mov    $0x0,%eax
}
    189e:	c9                   	leave  
    189f:	c3                   	ret    

000018a0 <matchrange>:
static int matchrange(char c, const char* str)
{
    18a0:	55                   	push   %ebp
    18a1:	89 e5                	mov    %esp,%ebp
    18a3:	83 ec 04             	sub    $0x4,%esp
    18a6:	8b 45 08             	mov    0x8(%ebp),%eax
    18a9:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    18ac:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    18b0:	74 5b                	je     190d <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
    18b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    18b5:	0f b6 00             	movzbl (%eax),%eax
    18b8:	84 c0                	test   %al,%al
    18ba:	74 51                	je     190d <matchrange+0x6d>
    18bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    18bf:	0f b6 00             	movzbl (%eax),%eax
    18c2:	3c 2d                	cmp    $0x2d,%al
    18c4:	74 47                	je     190d <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
    18c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    18c9:	83 c0 01             	add    $0x1,%eax
    18cc:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
    18cf:	3c 2d                	cmp    $0x2d,%al
    18d1:	75 3a                	jne    190d <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
    18d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d6:	83 c0 01             	add    $0x1,%eax
    18d9:	0f b6 00             	movzbl (%eax),%eax
    18dc:	84 c0                	test   %al,%al
    18de:	74 2d                	je     190d <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    18e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e3:	83 c0 02             	add    $0x2,%eax
    18e6:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
    18e9:	84 c0                	test   %al,%al
    18eb:	74 20                	je     190d <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
    18ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    18f0:	0f b6 00             	movzbl (%eax),%eax
    18f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
    18f6:	7f 15                	jg     190d <matchrange+0x6d>
    18f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    18fb:	83 c0 02             	add    $0x2,%eax
    18fe:	0f b6 00             	movzbl (%eax),%eax
    1901:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1904:	7c 07                	jl     190d <matchrange+0x6d>
    1906:	b8 01 00 00 00       	mov    $0x1,%eax
    190b:	eb 05                	jmp    1912 <matchrange+0x72>
    190d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1912:	c9                   	leave  
    1913:	c3                   	ret    

00001914 <ismetachar>:
static int ismetachar(char c)
{
    1914:	55                   	push   %ebp
    1915:	89 e5                	mov    %esp,%ebp
    1917:	83 ec 04             	sub    $0x4,%esp
    191a:	8b 45 08             	mov    0x8(%ebp),%eax
    191d:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
    1920:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
    1924:	74 1e                	je     1944 <ismetachar+0x30>
    1926:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
    192a:	74 18                	je     1944 <ismetachar+0x30>
    192c:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
    1930:	74 12                	je     1944 <ismetachar+0x30>
    1932:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
    1936:	74 0c                	je     1944 <ismetachar+0x30>
    1938:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
    193c:	74 06                	je     1944 <ismetachar+0x30>
    193e:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
    1942:	75 07                	jne    194b <ismetachar+0x37>
    1944:	b8 01 00 00 00       	mov    $0x1,%eax
    1949:	eb 05                	jmp    1950 <ismetachar+0x3c>
    194b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1950:	c9                   	leave  
    1951:	c3                   	ret    

00001952 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
    1952:	55                   	push   %ebp
    1953:	89 e5                	mov    %esp,%ebp
    1955:	83 ec 04             	sub    $0x4,%esp
    1958:	8b 45 08             	mov    0x8(%ebp),%eax
    195b:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
    195e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1961:	0f b6 00             	movzbl (%eax),%eax
    1964:	0f be c0             	movsbl %al,%eax
    1967:	83 e8 44             	sub    $0x44,%eax
    196a:	83 f8 33             	cmp    $0x33,%eax
    196d:	77 7b                	ja     19ea <matchmetachar+0x98>
    196f:	8b 04 85 4c 21 00 00 	mov    0x214c(,%eax,4),%eax
    1976:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
    1978:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    197c:	50                   	push   %eax
    197d:	e8 46 fe ff ff       	call   17c8 <matchdigit>
    1982:	83 c4 04             	add    $0x4,%esp
    1985:	eb 72                	jmp    19f9 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
    1987:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    198b:	50                   	push   %eax
    198c:	e8 37 fe ff ff       	call   17c8 <matchdigit>
    1991:	83 c4 04             	add    $0x4,%esp
    1994:	85 c0                	test   %eax,%eax
    1996:	0f 94 c0             	sete   %al
    1999:	0f b6 c0             	movzbl %al,%eax
    199c:	eb 5b                	jmp    19f9 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
    199e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    19a2:	50                   	push   %eax
    19a3:	e8 b6 fe ff ff       	call   185e <matchalphanum>
    19a8:	83 c4 04             	add    $0x4,%esp
    19ab:	eb 4c                	jmp    19f9 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
    19ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    19b1:	50                   	push   %eax
    19b2:	e8 a7 fe ff ff       	call   185e <matchalphanum>
    19b7:	83 c4 04             	add    $0x4,%esp
    19ba:	85 c0                	test   %eax,%eax
    19bc:	0f 94 c0             	sete   %al
    19bf:	0f b6 c0             	movzbl %al,%eax
    19c2:	eb 35                	jmp    19f9 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
    19c4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    19c8:	50                   	push   %eax
    19c9:	e8 52 fe ff ff       	call   1820 <matchwhitespace>
    19ce:	83 c4 04             	add    $0x4,%esp
    19d1:	eb 26                	jmp    19f9 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
    19d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    19d7:	50                   	push   %eax
    19d8:	e8 43 fe ff ff       	call   1820 <matchwhitespace>
    19dd:	83 c4 04             	add    $0x4,%esp
    19e0:	85 c0                	test   %eax,%eax
    19e2:	0f 94 c0             	sete   %al
    19e5:	0f b6 c0             	movzbl %al,%eax
    19e8:	eb 0f                	jmp    19f9 <matchmetachar+0xa7>
    default:  return (c == str[0]);
    19ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ed:	0f b6 00             	movzbl (%eax),%eax
    19f0:	3a 45 fc             	cmp    -0x4(%ebp),%al
    19f3:	0f 94 c0             	sete   %al
    19f6:	0f b6 c0             	movzbl %al,%eax
  }
}
    19f9:	c9                   	leave  
    19fa:	c3                   	ret    

000019fb <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
    19fb:	55                   	push   %ebp
    19fc:	89 e5                	mov    %esp,%ebp
    19fe:	83 ec 04             	sub    $0x4,%esp
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
    1a07:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1a0b:	ff 75 0c             	pushl  0xc(%ebp)
    1a0e:	50                   	push   %eax
    1a0f:	e8 8c fe ff ff       	call   18a0 <matchrange>
    1a14:	83 c4 08             	add    $0x8,%esp
    1a17:	85 c0                	test   %eax,%eax
    1a19:	74 0a                	je     1a25 <matchcharclass+0x2a>
    {
      return 1;
    1a1b:	b8 01 00 00 00       	mov    $0x1,%eax
    1a20:	e9 a5 00 00 00       	jmp    1aca <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
    1a25:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a28:	0f b6 00             	movzbl (%eax),%eax
    1a2b:	3c 5c                	cmp    $0x5c,%al
    1a2d:	75 42                	jne    1a71 <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
    1a2f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
    1a33:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1a37:	ff 75 0c             	pushl  0xc(%ebp)
    1a3a:	50                   	push   %eax
    1a3b:	e8 12 ff ff ff       	call   1952 <matchmetachar>
    1a40:	83 c4 08             	add    $0x8,%esp
    1a43:	85 c0                	test   %eax,%eax
    1a45:	74 07                	je     1a4e <matchcharclass+0x53>
      {
        return 1;
    1a47:	b8 01 00 00 00       	mov    $0x1,%eax
    1a4c:	eb 7c                	jmp    1aca <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
    1a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a51:	0f b6 00             	movzbl (%eax),%eax
    1a54:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1a57:	75 58                	jne    1ab1 <matchcharclass+0xb6>
    1a59:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1a5d:	50                   	push   %eax
    1a5e:	e8 b1 fe ff ff       	call   1914 <ismetachar>
    1a63:	83 c4 04             	add    $0x4,%esp
    1a66:	85 c0                	test   %eax,%eax
    1a68:	75 47                	jne    1ab1 <matchcharclass+0xb6>
      {
        return 1;
    1a6a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a6f:	eb 59                	jmp    1aca <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
    1a71:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a74:	0f b6 00             	movzbl (%eax),%eax
    1a77:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1a7a:	75 35                	jne    1ab1 <matchcharclass+0xb6>
    {
      if (c == '-')
    1a7c:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
    1a80:	75 28                	jne    1aaa <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
    1a82:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a85:	83 e8 01             	sub    $0x1,%eax
    1a88:	0f b6 00             	movzbl (%eax),%eax
    1a8b:	84 c0                	test   %al,%al
    1a8d:	74 0d                	je     1a9c <matchcharclass+0xa1>
    1a8f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a92:	83 c0 01             	add    $0x1,%eax
    1a95:	0f b6 00             	movzbl (%eax),%eax
    1a98:	84 c0                	test   %al,%al
    1a9a:	75 07                	jne    1aa3 <matchcharclass+0xa8>
    1a9c:	b8 01 00 00 00       	mov    $0x1,%eax
    1aa1:	eb 27                	jmp    1aca <matchcharclass+0xcf>
    1aa3:	b8 00 00 00 00       	mov    $0x0,%eax
    1aa8:	eb 20                	jmp    1aca <matchcharclass+0xcf>
      }
      else
      {
        return 1;
    1aaa:	b8 01 00 00 00       	mov    $0x1,%eax
    1aaf:	eb 19                	jmp    1aca <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
    1ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ab4:	8d 50 01             	lea    0x1(%eax),%edx
    1ab7:	89 55 0c             	mov    %edx,0xc(%ebp)
    1aba:	0f b6 00             	movzbl (%eax),%eax
    1abd:	84 c0                	test   %al,%al
    1abf:	0f 85 42 ff ff ff    	jne    1a07 <matchcharclass+0xc>

  return 0;
    1ac5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1aca:	c9                   	leave  
    1acb:	c3                   	ret    

00001acc <matchone>:

static int matchone(regex_t p, char c)
{
    1acc:	55                   	push   %ebp
    1acd:	89 e5                	mov    %esp,%ebp
    1acf:	83 ec 04             	sub    $0x4,%esp
    1ad2:	8b 45 10             	mov    0x10(%ebp),%eax
    1ad5:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
    1ad8:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1adc:	0f b6 c0             	movzbl %al,%eax
    1adf:	83 f8 0f             	cmp    $0xf,%eax
    1ae2:	0f 87 b9 00 00 00    	ja     1ba1 <matchone+0xd5>
    1ae8:	8b 04 85 1c 22 00 00 	mov    0x221c(,%eax,4),%eax
    1aef:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
    1af1:	b8 01 00 00 00       	mov    $0x1,%eax
    1af6:	e9 b9 00 00 00       	jmp    1bb4 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
    1afb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1afe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b02:	52                   	push   %edx
    1b03:	50                   	push   %eax
    1b04:	e8 f2 fe ff ff       	call   19fb <matchcharclass>
    1b09:	83 c4 08             	add    $0x8,%esp
    1b0c:	e9 a3 00 00 00       	jmp    1bb4 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
    1b11:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b14:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b18:	52                   	push   %edx
    1b19:	50                   	push   %eax
    1b1a:	e8 dc fe ff ff       	call   19fb <matchcharclass>
    1b1f:	83 c4 08             	add    $0x8,%esp
    1b22:	85 c0                	test   %eax,%eax
    1b24:	0f 94 c0             	sete   %al
    1b27:	0f b6 c0             	movzbl %al,%eax
    1b2a:	e9 85 00 00 00       	jmp    1bb4 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
    1b2f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b33:	50                   	push   %eax
    1b34:	e8 8f fc ff ff       	call   17c8 <matchdigit>
    1b39:	83 c4 04             	add    $0x4,%esp
    1b3c:	eb 76                	jmp    1bb4 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
    1b3e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b42:	50                   	push   %eax
    1b43:	e8 80 fc ff ff       	call   17c8 <matchdigit>
    1b48:	83 c4 04             	add    $0x4,%esp
    1b4b:	85 c0                	test   %eax,%eax
    1b4d:	0f 94 c0             	sete   %al
    1b50:	0f b6 c0             	movzbl %al,%eax
    1b53:	eb 5f                	jmp    1bb4 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
    1b55:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b59:	50                   	push   %eax
    1b5a:	e8 ff fc ff ff       	call   185e <matchalphanum>
    1b5f:	83 c4 04             	add    $0x4,%esp
    1b62:	eb 50                	jmp    1bb4 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
    1b64:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b68:	50                   	push   %eax
    1b69:	e8 f0 fc ff ff       	call   185e <matchalphanum>
    1b6e:	83 c4 04             	add    $0x4,%esp
    1b71:	85 c0                	test   %eax,%eax
    1b73:	0f 94 c0             	sete   %al
    1b76:	0f b6 c0             	movzbl %al,%eax
    1b79:	eb 39                	jmp    1bb4 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
    1b7b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b7f:	50                   	push   %eax
    1b80:	e8 9b fc ff ff       	call   1820 <matchwhitespace>
    1b85:	83 c4 04             	add    $0x4,%esp
    1b88:	eb 2a                	jmp    1bb4 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
    1b8a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1b8e:	50                   	push   %eax
    1b8f:	e8 8c fc ff ff       	call   1820 <matchwhitespace>
    1b94:	83 c4 04             	add    $0x4,%esp
    1b97:	85 c0                	test   %eax,%eax
    1b99:	0f 94 c0             	sete   %al
    1b9c:	0f b6 c0             	movzbl %al,%eax
    1b9f:	eb 13                	jmp    1bb4 <matchone+0xe8>
    default:             return  (p.ch == c);
    1ba1:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    1ba5:	0f b6 d0             	movzbl %al,%edx
    1ba8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
    1bac:	39 c2                	cmp    %eax,%edx
    1bae:	0f 94 c0             	sete   %al
    1bb1:	0f b6 c0             	movzbl %al,%eax
  }
}
    1bb4:	c9                   	leave  
    1bb5:	c3                   	ret    

00001bb6 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1bb6:	55                   	push   %ebp
    1bb7:	89 e5                	mov    %esp,%ebp
    1bb9:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
    1bbc:	8b 45 18             	mov    0x18(%ebp),%eax
    1bbf:	8b 00                	mov    (%eax),%eax
    1bc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
    1bc4:	8b 45 14             	mov    0x14(%ebp),%eax
    1bc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1bca:	eb 11                	jmp    1bdd <matchstar+0x27>
  {
    text++;
    1bcc:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1bd0:	8b 45 18             	mov    0x18(%ebp),%eax
    1bd3:	8b 00                	mov    (%eax),%eax
    1bd5:	8d 50 01             	lea    0x1(%eax),%edx
    1bd8:	8b 45 18             	mov    0x18(%ebp),%eax
    1bdb:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1bdd:	8b 45 14             	mov    0x14(%ebp),%eax
    1be0:	0f b6 00             	movzbl (%eax),%eax
    1be3:	84 c0                	test   %al,%al
    1be5:	74 51                	je     1c38 <matchstar+0x82>
    1be7:	8b 45 14             	mov    0x14(%ebp),%eax
    1bea:	0f b6 00             	movzbl (%eax),%eax
    1bed:	0f be c0             	movsbl %al,%eax
    1bf0:	50                   	push   %eax
    1bf1:	ff 75 0c             	pushl  0xc(%ebp)
    1bf4:	ff 75 08             	pushl  0x8(%ebp)
    1bf7:	e8 d0 fe ff ff       	call   1acc <matchone>
    1bfc:	83 c4 0c             	add    $0xc,%esp
    1bff:	85 c0                	test   %eax,%eax
    1c01:	75 c9                	jne    1bcc <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1c03:	eb 33                	jmp    1c38 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
    1c05:	8b 45 14             	mov    0x14(%ebp),%eax
    1c08:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c0b:	89 55 14             	mov    %edx,0x14(%ebp)
    1c0e:	83 ec 04             	sub    $0x4,%esp
    1c11:	ff 75 18             	pushl  0x18(%ebp)
    1c14:	50                   	push   %eax
    1c15:	ff 75 10             	pushl  0x10(%ebp)
    1c18:	e8 51 01 00 00       	call   1d6e <matchpattern>
    1c1d:	83 c4 10             	add    $0x10,%esp
    1c20:	85 c0                	test   %eax,%eax
    1c22:	74 07                	je     1c2b <matchstar+0x75>
      return 1;
    1c24:	b8 01 00 00 00       	mov    $0x1,%eax
    1c29:	eb 22                	jmp    1c4d <matchstar+0x97>
    (*matchlength)--;
    1c2b:	8b 45 18             	mov    0x18(%ebp),%eax
    1c2e:	8b 00                	mov    (%eax),%eax
    1c30:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c33:	8b 45 18             	mov    0x18(%ebp),%eax
    1c36:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
    1c38:	8b 45 14             	mov    0x14(%ebp),%eax
    1c3b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1c3e:	73 c5                	jae    1c05 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
    1c40:	8b 45 18             	mov    0x18(%ebp),%eax
    1c43:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c46:	89 10                	mov    %edx,(%eax)
  return 0;
    1c48:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1c4d:	c9                   	leave  
    1c4e:	c3                   	ret    

00001c4f <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1c4f:	55                   	push   %ebp
    1c50:	89 e5                	mov    %esp,%ebp
    1c52:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
    1c55:	8b 45 14             	mov    0x14(%ebp),%eax
    1c58:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
    1c5b:	eb 11                	jmp    1c6e <matchplus+0x1f>
  {
    text++;
    1c5d:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
    1c61:	8b 45 18             	mov    0x18(%ebp),%eax
    1c64:	8b 00                	mov    (%eax),%eax
    1c66:	8d 50 01             	lea    0x1(%eax),%edx
    1c69:	8b 45 18             	mov    0x18(%ebp),%eax
    1c6c:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
    1c6e:	8b 45 14             	mov    0x14(%ebp),%eax
    1c71:	0f b6 00             	movzbl (%eax),%eax
    1c74:	84 c0                	test   %al,%al
    1c76:	74 51                	je     1cc9 <matchplus+0x7a>
    1c78:	8b 45 14             	mov    0x14(%ebp),%eax
    1c7b:	0f b6 00             	movzbl (%eax),%eax
    1c7e:	0f be c0             	movsbl %al,%eax
    1c81:	50                   	push   %eax
    1c82:	ff 75 0c             	pushl  0xc(%ebp)
    1c85:	ff 75 08             	pushl  0x8(%ebp)
    1c88:	e8 3f fe ff ff       	call   1acc <matchone>
    1c8d:	83 c4 0c             	add    $0xc,%esp
    1c90:	85 c0                	test   %eax,%eax
    1c92:	75 c9                	jne    1c5d <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1c94:	eb 33                	jmp    1cc9 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
    1c96:	8b 45 14             	mov    0x14(%ebp),%eax
    1c99:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c9c:	89 55 14             	mov    %edx,0x14(%ebp)
    1c9f:	83 ec 04             	sub    $0x4,%esp
    1ca2:	ff 75 18             	pushl  0x18(%ebp)
    1ca5:	50                   	push   %eax
    1ca6:	ff 75 10             	pushl  0x10(%ebp)
    1ca9:	e8 c0 00 00 00       	call   1d6e <matchpattern>
    1cae:	83 c4 10             	add    $0x10,%esp
    1cb1:	85 c0                	test   %eax,%eax
    1cb3:	74 07                	je     1cbc <matchplus+0x6d>
      return 1;
    1cb5:	b8 01 00 00 00       	mov    $0x1,%eax
    1cba:	eb 1a                	jmp    1cd6 <matchplus+0x87>
    (*matchlength)--;
    1cbc:	8b 45 18             	mov    0x18(%ebp),%eax
    1cbf:	8b 00                	mov    (%eax),%eax
    1cc1:	8d 50 ff             	lea    -0x1(%eax),%edx
    1cc4:	8b 45 18             	mov    0x18(%ebp),%eax
    1cc7:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
    1cc9:	8b 45 14             	mov    0x14(%ebp),%eax
    1ccc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1ccf:	77 c5                	ja     1c96 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
    1cd1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1cd6:	c9                   	leave  
    1cd7:	c3                   	ret    

00001cd8 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
    1cd8:	55                   	push   %ebp
    1cd9:	89 e5                	mov    %esp,%ebp
    1cdb:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
    1cde:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1ce2:	84 c0                	test   %al,%al
    1ce4:	75 07                	jne    1ced <matchquestion+0x15>
    return 1;
    1ce6:	b8 01 00 00 00       	mov    $0x1,%eax
    1ceb:	eb 7f                	jmp    1d6c <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
    1ced:	83 ec 04             	sub    $0x4,%esp
    1cf0:	ff 75 18             	pushl  0x18(%ebp)
    1cf3:	ff 75 14             	pushl  0x14(%ebp)
    1cf6:	ff 75 10             	pushl  0x10(%ebp)
    1cf9:	e8 70 00 00 00       	call   1d6e <matchpattern>
    1cfe:	83 c4 10             	add    $0x10,%esp
    1d01:	85 c0                	test   %eax,%eax
    1d03:	74 07                	je     1d0c <matchquestion+0x34>
      return 1;
    1d05:	b8 01 00 00 00       	mov    $0x1,%eax
    1d0a:	eb 60                	jmp    1d6c <matchquestion+0x94>
  if (*text && matchone(p, *text++))
    1d0c:	8b 45 14             	mov    0x14(%ebp),%eax
    1d0f:	0f b6 00             	movzbl (%eax),%eax
    1d12:	84 c0                	test   %al,%al
    1d14:	74 51                	je     1d67 <matchquestion+0x8f>
    1d16:	8b 45 14             	mov    0x14(%ebp),%eax
    1d19:	8d 50 01             	lea    0x1(%eax),%edx
    1d1c:	89 55 14             	mov    %edx,0x14(%ebp)
    1d1f:	0f b6 00             	movzbl (%eax),%eax
    1d22:	0f be c0             	movsbl %al,%eax
    1d25:	83 ec 04             	sub    $0x4,%esp
    1d28:	50                   	push   %eax
    1d29:	ff 75 0c             	pushl  0xc(%ebp)
    1d2c:	ff 75 08             	pushl  0x8(%ebp)
    1d2f:	e8 98 fd ff ff       	call   1acc <matchone>
    1d34:	83 c4 10             	add    $0x10,%esp
    1d37:	85 c0                	test   %eax,%eax
    1d39:	74 2c                	je     1d67 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
    1d3b:	83 ec 04             	sub    $0x4,%esp
    1d3e:	ff 75 18             	pushl  0x18(%ebp)
    1d41:	ff 75 14             	pushl  0x14(%ebp)
    1d44:	ff 75 10             	pushl  0x10(%ebp)
    1d47:	e8 22 00 00 00       	call   1d6e <matchpattern>
    1d4c:	83 c4 10             	add    $0x10,%esp
    1d4f:	85 c0                	test   %eax,%eax
    1d51:	74 14                	je     1d67 <matchquestion+0x8f>
    {
      (*matchlength)++;
    1d53:	8b 45 18             	mov    0x18(%ebp),%eax
    1d56:	8b 00                	mov    (%eax),%eax
    1d58:	8d 50 01             	lea    0x1(%eax),%edx
    1d5b:	8b 45 18             	mov    0x18(%ebp),%eax
    1d5e:	89 10                	mov    %edx,(%eax)
      return 1;
    1d60:	b8 01 00 00 00       	mov    $0x1,%eax
    1d65:	eb 05                	jmp    1d6c <matchquestion+0x94>
    }
  }
  return 0;
    1d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d6c:	c9                   	leave  
    1d6d:	c3                   	ret    

00001d6e <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
    1d6e:	55                   	push   %ebp
    1d6f:	89 e5                	mov    %esp,%ebp
    1d71:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
    1d74:	8b 45 10             	mov    0x10(%ebp),%eax
    1d77:	8b 00                	mov    (%eax),%eax
    1d79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
    1d7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7f:	0f b6 00             	movzbl (%eax),%eax
    1d82:	84 c0                	test   %al,%al
    1d84:	74 0d                	je     1d93 <matchpattern+0x25>
    1d86:	8b 45 08             	mov    0x8(%ebp),%eax
    1d89:	83 c0 08             	add    $0x8,%eax
    1d8c:	0f b6 00             	movzbl (%eax),%eax
    1d8f:	3c 04                	cmp    $0x4,%al
    1d91:	75 25                	jne    1db8 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
    1d93:	8b 45 08             	mov    0x8(%ebp),%eax
    1d96:	83 c0 10             	add    $0x10,%eax
    1d99:	83 ec 0c             	sub    $0xc,%esp
    1d9c:	ff 75 10             	pushl  0x10(%ebp)
    1d9f:	ff 75 0c             	pushl  0xc(%ebp)
    1da2:	50                   	push   %eax
    1da3:	8b 45 08             	mov    0x8(%ebp),%eax
    1da6:	ff 70 04             	pushl  0x4(%eax)
    1da9:	ff 30                	pushl  (%eax)
    1dab:	e8 28 ff ff ff       	call   1cd8 <matchquestion>
    1db0:	83 c4 20             	add    $0x20,%esp
    1db3:	e9 dd 00 00 00       	jmp    1e95 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
    1db8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbb:	83 c0 08             	add    $0x8,%eax
    1dbe:	0f b6 00             	movzbl (%eax),%eax
    1dc1:	3c 05                	cmp    $0x5,%al
    1dc3:	75 25                	jne    1dea <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
    1dc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc8:	83 c0 10             	add    $0x10,%eax
    1dcb:	83 ec 0c             	sub    $0xc,%esp
    1dce:	ff 75 10             	pushl  0x10(%ebp)
    1dd1:	ff 75 0c             	pushl  0xc(%ebp)
    1dd4:	50                   	push   %eax
    1dd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd8:	ff 70 04             	pushl  0x4(%eax)
    1ddb:	ff 30                	pushl  (%eax)
    1ddd:	e8 d4 fd ff ff       	call   1bb6 <matchstar>
    1de2:	83 c4 20             	add    $0x20,%esp
    1de5:	e9 ab 00 00 00       	jmp    1e95 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
    1dea:	8b 45 08             	mov    0x8(%ebp),%eax
    1ded:	83 c0 08             	add    $0x8,%eax
    1df0:	0f b6 00             	movzbl (%eax),%eax
    1df3:	3c 06                	cmp    $0x6,%al
    1df5:	75 22                	jne    1e19 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
    1df7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfa:	83 c0 10             	add    $0x10,%eax
    1dfd:	83 ec 0c             	sub    $0xc,%esp
    1e00:	ff 75 10             	pushl  0x10(%ebp)
    1e03:	ff 75 0c             	pushl  0xc(%ebp)
    1e06:	50                   	push   %eax
    1e07:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0a:	ff 70 04             	pushl  0x4(%eax)
    1e0d:	ff 30                	pushl  (%eax)
    1e0f:	e8 3b fe ff ff       	call   1c4f <matchplus>
    1e14:	83 c4 20             	add    $0x20,%esp
    1e17:	eb 7c                	jmp    1e95 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
    1e19:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1c:	0f b6 00             	movzbl (%eax),%eax
    1e1f:	3c 03                	cmp    $0x3,%al
    1e21:	75 1d                	jne    1e40 <matchpattern+0xd2>
    1e23:	8b 45 08             	mov    0x8(%ebp),%eax
    1e26:	83 c0 08             	add    $0x8,%eax
    1e29:	0f b6 00             	movzbl (%eax),%eax
    1e2c:	84 c0                	test   %al,%al
    1e2e:	75 10                	jne    1e40 <matchpattern+0xd2>
    {
      return (text[0] == '\0');
    1e30:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e33:	0f b6 00             	movzbl (%eax),%eax
    1e36:	84 c0                	test   %al,%al
    1e38:	0f 94 c0             	sete   %al
    1e3b:	0f b6 c0             	movzbl %al,%eax
    1e3e:	eb 55                	jmp    1e95 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
    1e40:	8b 45 10             	mov    0x10(%ebp),%eax
    1e43:	8b 00                	mov    (%eax),%eax
    1e45:	8d 50 01             	lea    0x1(%eax),%edx
    1e48:	8b 45 10             	mov    0x10(%ebp),%eax
    1e4b:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
    1e4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e50:	0f b6 00             	movzbl (%eax),%eax
    1e53:	84 c0                	test   %al,%al
    1e55:	74 31                	je     1e88 <matchpattern+0x11a>
    1e57:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e5a:	8d 50 01             	lea    0x1(%eax),%edx
    1e5d:	89 55 0c             	mov    %edx,0xc(%ebp)
    1e60:	0f b6 00             	movzbl (%eax),%eax
    1e63:	0f be d0             	movsbl %al,%edx
    1e66:	8b 45 08             	mov    0x8(%ebp),%eax
    1e69:	8d 48 08             	lea    0x8(%eax),%ecx
    1e6c:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1e6f:	83 ec 04             	sub    $0x4,%esp
    1e72:	52                   	push   %edx
    1e73:	ff 70 04             	pushl  0x4(%eax)
    1e76:	ff 30                	pushl  (%eax)
    1e78:	e8 4f fc ff ff       	call   1acc <matchone>
    1e7d:	83 c4 10             	add    $0x10,%esp
    1e80:	85 c0                	test   %eax,%eax
    1e82:	0f 85 f4 fe ff ff    	jne    1d7c <matchpattern+0xe>

  *matchlength = pre;
    1e88:	8b 45 10             	mov    0x10(%ebp),%eax
    1e8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e8e:	89 10                	mov    %edx,(%eax)
  return 0;
    1e90:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1e95:	c9                   	leave  
    1e96:	c3                   	ret    
