
_re:     file format elf32-i386


Disassembly of section .text:

00000000 <re_match>:



/* Public functions: */
int re_match(const char* pattern, const char* text, int* matchlength)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  return re_matchp(re_compile(pattern), text, matchlength);
       6:	83 ec 0c             	sub    $0xc,%esp
       9:	ff 75 08             	pushl  0x8(%ebp)
       c:	e8 b0 00 00 00       	call   c1 <re_compile>
      11:	83 c4 10             	add    $0x10,%esp
      14:	83 ec 04             	sub    $0x4,%esp
      17:	ff 75 10             	pushl  0x10(%ebp)
      1a:	ff 75 0c             	pushl  0xc(%ebp)
      1d:	50                   	push   %eax
      1e:	e8 05 00 00 00       	call   28 <re_matchp>
      23:	83 c4 10             	add    $0x10,%esp
}
      26:	c9                   	leave  
      27:	c3                   	ret    

00000028 <re_matchp>:

int re_matchp(re_t pattern, const char* text, int* matchlength)
{
      28:	55                   	push   %ebp
      29:	89 e5                	mov    %esp,%ebp
      2b:	83 ec 18             	sub    $0x18,%esp
  *matchlength = 0;
      2e:	8b 45 10             	mov    0x10(%ebp),%eax
      31:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if (pattern != 0)
      37:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
      3b:	74 7d                	je     ba <re_matchp+0x92>
  {
    if (pattern[0].type == BEGIN)
      3d:	8b 45 08             	mov    0x8(%ebp),%eax
      40:	0f b6 00             	movzbl (%eax),%eax
      43:	3c 02                	cmp    $0x2,%al
      45:	75 2a                	jne    71 <re_matchp+0x49>
    {
      return ((matchpattern(&pattern[1], text, matchlength)) ? 0 : -1);
      47:	8b 45 08             	mov    0x8(%ebp),%eax
      4a:	83 c0 08             	add    $0x8,%eax
      4d:	83 ec 04             	sub    $0x4,%esp
      50:	ff 75 10             	pushl  0x10(%ebp)
      53:	ff 75 0c             	pushl  0xc(%ebp)
      56:	50                   	push   %eax
      57:	e8 30 0a 00 00       	call   a8c <matchpattern>
      5c:	83 c4 10             	add    $0x10,%esp
      5f:	85 c0                	test   %eax,%eax
      61:	74 07                	je     6a <re_matchp+0x42>
      63:	b8 00 00 00 00       	mov    $0x0,%eax
      68:	eb 55                	jmp    bf <re_matchp+0x97>
      6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      6f:	eb 4e                	jmp    bf <re_matchp+0x97>
    }
    else
    {
      int idx = -1;
      71:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

      do
      {
        idx += 1;
      78:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        
        if (matchpattern(pattern, text, matchlength))
      7c:	83 ec 04             	sub    $0x4,%esp
      7f:	ff 75 10             	pushl  0x10(%ebp)
      82:	ff 75 0c             	pushl  0xc(%ebp)
      85:	ff 75 08             	pushl  0x8(%ebp)
      88:	e8 ff 09 00 00       	call   a8c <matchpattern>
      8d:	83 c4 10             	add    $0x10,%esp
      90:	85 c0                	test   %eax,%eax
      92:	74 16                	je     aa <re_matchp+0x82>
        {
          if (text[0] == '\0')
      94:	8b 45 0c             	mov    0xc(%ebp),%eax
      97:	0f b6 00             	movzbl (%eax),%eax
      9a:	84 c0                	test   %al,%al
      9c:	75 07                	jne    a5 <re_matchp+0x7d>
            return -1;
      9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      a3:	eb 1a                	jmp    bf <re_matchp+0x97>
        
          return idx;
      a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
      a8:	eb 15                	jmp    bf <re_matchp+0x97>
        }
      }
      while (*text++ != '\0');
      aa:	8b 45 0c             	mov    0xc(%ebp),%eax
      ad:	8d 50 01             	lea    0x1(%eax),%edx
      b0:	89 55 0c             	mov    %edx,0xc(%ebp)
      b3:	0f b6 00             	movzbl (%eax),%eax
      b6:	84 c0                	test   %al,%al
      b8:	75 be                	jne    78 <re_matchp+0x50>
    }
  }
  return -1;
      ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
      bf:	c9                   	leave  
      c0:	c3                   	ret    

000000c1 <re_compile>:

re_t re_compile(const char* pattern)
{
      c1:	55                   	push   %ebp
      c2:	89 e5                	mov    %esp,%ebp
      c4:	83 ec 20             	sub    $0x20,%esp
  /* The sizes of the two static arrays below substantiates the static RAM usage of this module.
     MAX_REGEXP_OBJECTS is the max number of symbols in the expression.
     MAX_CHAR_CLASS_LEN determines the size of buffer for chars in all char-classes in the expression. */
  static regex_t re_compiled[MAX_REGEXP_OBJECTS];
  static unsigned char ccl_buf[MAX_CHAR_CLASS_LEN];
  int ccl_bufidx = 1;
      c7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
      ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  int j = 0;  /* index into re_compiled    */
      d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
      dc:	e9 55 02 00 00       	jmp    336 <re_compile+0x275>
  {
    c = pattern[i];
      e1:	8b 55 f8             	mov    -0x8(%ebp),%edx
      e4:	8b 45 08             	mov    0x8(%ebp),%eax
      e7:	01 d0                	add    %edx,%eax
      e9:	0f b6 00             	movzbl (%eax),%eax
      ec:	88 45 f3             	mov    %al,-0xd(%ebp)

    switch (c)
      ef:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
      f3:	83 e8 24             	sub    $0x24,%eax
      f6:	83 f8 3a             	cmp    $0x3a,%eax
      f9:	0f 87 13 02 00 00    	ja     312 <re_compile+0x251>
      ff:	8b 04 85 00 14 00 00 	mov    0x1400(,%eax,4),%eax
     106:	ff e0                	jmp    *%eax
    {
      /* Meta-characters: */
      case '^': {    re_compiled[j].type = BEGIN;           } break;
     108:	8b 45 f4             	mov    -0xc(%ebp),%eax
     10b:	c6 04 c5 c0 1c 00 00 	movb   $0x2,0x1cc0(,%eax,8)
     112:	02 
     113:	e9 16 02 00 00       	jmp    32e <re_compile+0x26d>
      case '$': {    re_compiled[j].type = END;             } break;
     118:	8b 45 f4             	mov    -0xc(%ebp),%eax
     11b:	c6 04 c5 c0 1c 00 00 	movb   $0x3,0x1cc0(,%eax,8)
     122:	03 
     123:	e9 06 02 00 00       	jmp    32e <re_compile+0x26d>
      case '.': {    re_compiled[j].type = DOT;             } break;
     128:	8b 45 f4             	mov    -0xc(%ebp),%eax
     12b:	c6 04 c5 c0 1c 00 00 	movb   $0x1,0x1cc0(,%eax,8)
     132:	01 
     133:	e9 f6 01 00 00       	jmp    32e <re_compile+0x26d>
      case '*': {    re_compiled[j].type = STAR;            } break;
     138:	8b 45 f4             	mov    -0xc(%ebp),%eax
     13b:	c6 04 c5 c0 1c 00 00 	movb   $0x5,0x1cc0(,%eax,8)
     142:	05 
     143:	e9 e6 01 00 00       	jmp    32e <re_compile+0x26d>
      case '+': {    re_compiled[j].type = PLUS;            } break;
     148:	8b 45 f4             	mov    -0xc(%ebp),%eax
     14b:	c6 04 c5 c0 1c 00 00 	movb   $0x6,0x1cc0(,%eax,8)
     152:	06 
     153:	e9 d6 01 00 00       	jmp    32e <re_compile+0x26d>
      case '?': {    re_compiled[j].type = QUESTIONMARK;    } break;
     158:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15b:	c6 04 c5 c0 1c 00 00 	movb   $0x4,0x1cc0(,%eax,8)
     162:	04 
     163:	e9 c6 01 00 00       	jmp    32e <re_compile+0x26d>
/*    case '|': {    re_compiled[j].type = BRANCH;          } break; <-- not working properly */

      /* Escaped character-classes (\s \w ...): */
      case '\\':
      {
        if (pattern[i+1] != '\0')
     168:	8b 45 f8             	mov    -0x8(%ebp),%eax
     16b:	8d 50 01             	lea    0x1(%eax),%edx
     16e:	8b 45 08             	mov    0x8(%ebp),%eax
     171:	01 d0                	add    %edx,%eax
     173:	0f b6 00             	movzbl (%eax),%eax
     176:	84 c0                	test   %al,%al
     178:	0f 84 af 01 00 00    	je     32d <re_compile+0x26c>
        {
          /* Skip the escape-char '\\' */
          i += 1;
     17e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
          /* ... and check the next */
          switch (pattern[i])
     182:	8b 55 f8             	mov    -0x8(%ebp),%edx
     185:	8b 45 08             	mov    0x8(%ebp),%eax
     188:	01 d0                	add    %edx,%eax
     18a:	0f b6 00             	movzbl (%eax),%eax
     18d:	0f be c0             	movsbl %al,%eax
     190:	83 e8 44             	sub    $0x44,%eax
     193:	83 f8 33             	cmp    $0x33,%eax
     196:	77 57                	ja     1ef <re_compile+0x12e>
     198:	8b 04 85 ec 14 00 00 	mov    0x14ec(,%eax,4),%eax
     19f:	ff e0                	jmp    *%eax
          {
            /* Meta-character: */
            case 'd': {    re_compiled[j].type = DIGIT;            } break;
     1a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1a4:	c6 04 c5 c0 1c 00 00 	movb   $0xa,0x1cc0(,%eax,8)
     1ab:	0a 
     1ac:	eb 64                	jmp    212 <re_compile+0x151>
            case 'D': {    re_compiled[j].type = NOT_DIGIT;        } break;
     1ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b1:	c6 04 c5 c0 1c 00 00 	movb   $0xb,0x1cc0(,%eax,8)
     1b8:	0b 
     1b9:	eb 57                	jmp    212 <re_compile+0x151>
            case 'w': {    re_compiled[j].type = ALPHA;            } break;
     1bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1be:	c6 04 c5 c0 1c 00 00 	movb   $0xc,0x1cc0(,%eax,8)
     1c5:	0c 
     1c6:	eb 4a                	jmp    212 <re_compile+0x151>
            case 'W': {    re_compiled[j].type = NOT_ALPHA;        } break;
     1c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1cb:	c6 04 c5 c0 1c 00 00 	movb   $0xd,0x1cc0(,%eax,8)
     1d2:	0d 
     1d3:	eb 3d                	jmp    212 <re_compile+0x151>
            case 's': {    re_compiled[j].type = WHITESPACE;       } break;
     1d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d8:	c6 04 c5 c0 1c 00 00 	movb   $0xe,0x1cc0(,%eax,8)
     1df:	0e 
     1e0:	eb 30                	jmp    212 <re_compile+0x151>
            case 'S': {    re_compiled[j].type = NOT_WHITESPACE;   } break;
     1e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1e5:	c6 04 c5 c0 1c 00 00 	movb   $0xf,0x1cc0(,%eax,8)
     1ec:	0f 
     1ed:	eb 23                	jmp    212 <re_compile+0x151>

            /* Escaped character, e.g. '.' or '$' */ 
            default:  
            {
              re_compiled[j].type = CHAR;
     1ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1f2:	c6 04 c5 c0 1c 00 00 	movb   $0x7,0x1cc0(,%eax,8)
     1f9:	07 
              re_compiled[j].ch = pattern[i];
     1fa:	8b 55 f8             	mov    -0x8(%ebp),%edx
     1fd:	8b 45 08             	mov    0x8(%ebp),%eax
     200:	01 d0                	add    %edx,%eax
     202:	0f b6 00             	movzbl (%eax),%eax
     205:	89 c2                	mov    %eax,%edx
     207:	8b 45 f4             	mov    -0xc(%ebp),%eax
     20a:	88 14 c5 c4 1c 00 00 	mov    %dl,0x1cc4(,%eax,8)
            } break;
     211:	90                   	nop
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     212:	e9 16 01 00 00       	jmp    32d <re_compile+0x26c>

      /* Character class: */
      case '[':
      {
        /* Remember where the char-buffer starts. */
        int buf_begin = ccl_bufidx;
     217:	8b 45 fc             	mov    -0x4(%ebp),%eax
     21a:	89 45 ec             	mov    %eax,-0x14(%ebp)

        /* Look-ahead to determine if negated */
        if (pattern[i+1] == '^')
     21d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     220:	8d 50 01             	lea    0x1(%eax),%edx
     223:	8b 45 08             	mov    0x8(%ebp),%eax
     226:	01 d0                	add    %edx,%eax
     228:	0f b6 00             	movzbl (%eax),%eax
     22b:	3c 5e                	cmp    $0x5e,%al
     22d:	75 11                	jne    240 <re_compile+0x17f>
        {
          re_compiled[j].type = INV_CHAR_CLASS;
     22f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     232:	c6 04 c5 c0 1c 00 00 	movb   $0x9,0x1cc0(,%eax,8)
     239:	09 
          i += 1; /* Increment i to avoid including '^' in the char-buffer */
     23a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     23e:	eb 7a                	jmp    2ba <re_compile+0x1f9>
        }  
        else
        {
          re_compiled[j].type = CHAR_CLASS;
     240:	8b 45 f4             	mov    -0xc(%ebp),%eax
     243:	c6 04 c5 c0 1c 00 00 	movb   $0x8,0x1cc0(,%eax,8)
     24a:	08 
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     24b:	eb 6d                	jmp    2ba <re_compile+0x1f9>
                && (pattern[i]   != '\0')) /* Missing ] */
        {
          if (pattern[i] == '\\')
     24d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     250:	8b 45 08             	mov    0x8(%ebp),%eax
     253:	01 d0                	add    %edx,%eax
     255:	0f b6 00             	movzbl (%eax),%eax
     258:	3c 5c                	cmp    $0x5c,%al
     25a:	75 34                	jne    290 <re_compile+0x1cf>
          {
            if (ccl_bufidx >= MAX_CHAR_CLASS_LEN - 1)
     25c:	83 7d fc 26          	cmpl   $0x26,-0x4(%ebp)
     260:	7e 0a                	jle    26c <re_compile+0x1ab>
            {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     262:	b8 00 00 00 00       	mov    $0x0,%eax
     267:	e9 f8 00 00 00       	jmp    364 <re_compile+0x2a3>
            }
            ccl_buf[ccl_bufidx++] = pattern[i++];
     26c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     26f:	8d 50 01             	lea    0x1(%eax),%edx
     272:	89 55 fc             	mov    %edx,-0x4(%ebp)
     275:	8b 55 f8             	mov    -0x8(%ebp),%edx
     278:	8d 4a 01             	lea    0x1(%edx),%ecx
     27b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     27e:	89 d1                	mov    %edx,%ecx
     280:	8b 55 08             	mov    0x8(%ebp),%edx
     283:	01 ca                	add    %ecx,%edx
     285:	0f b6 12             	movzbl (%edx),%edx
     288:	88 90 c0 1d 00 00    	mov    %dl,0x1dc0(%eax)
     28e:	eb 10                	jmp    2a0 <re_compile+0x1df>
          }
          else if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     290:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     294:	7e 0a                	jle    2a0 <re_compile+0x1df>
          {
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
     296:	b8 00 00 00 00       	mov    $0x0,%eax
     29b:	e9 c4 00 00 00       	jmp    364 <re_compile+0x2a3>
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
     2a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2a3:	8d 50 01             	lea    0x1(%eax),%edx
     2a6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2a9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     2ac:	8b 55 08             	mov    0x8(%ebp),%edx
     2af:	01 ca                	add    %ecx,%edx
     2b1:	0f b6 12             	movzbl (%edx),%edx
     2b4:	88 90 c0 1d 00 00    	mov    %dl,0x1dc0(%eax)
        {
          re_compiled[j].type = CHAR_CLASS;
        }

        /* Copy characters inside [..] to buffer */
        while (    (pattern[++i] != ']')
     2ba:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     2be:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2c1:	8b 45 08             	mov    0x8(%ebp),%eax
     2c4:	01 d0                	add    %edx,%eax
     2c6:	0f b6 00             	movzbl (%eax),%eax
     2c9:	3c 5d                	cmp    $0x5d,%al
     2cb:	74 13                	je     2e0 <re_compile+0x21f>
                && (pattern[i]   != '\0')) /* Missing ] */
     2cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2d0:	8b 45 08             	mov    0x8(%ebp),%eax
     2d3:	01 d0                	add    %edx,%eax
     2d5:	0f b6 00             	movzbl (%eax),%eax
     2d8:	84 c0                	test   %al,%al
     2da:	0f 85 6d ff ff ff    	jne    24d <re_compile+0x18c>
              //fputs("exceeded internal buffer!\n", stderr);
              return 0;
          }
          ccl_buf[ccl_bufidx++] = pattern[i];
        }
        if (ccl_bufidx >= MAX_CHAR_CLASS_LEN)
     2e0:	83 7d fc 27          	cmpl   $0x27,-0x4(%ebp)
     2e4:	7e 07                	jle    2ed <re_compile+0x22c>
        {
            /* Catches cases such as [00000000000000000000000000000000000000][ */
            //fputs("exceeded internal buffer!\n", stderr);
            return 0;
     2e6:	b8 00 00 00 00       	mov    $0x0,%eax
     2eb:	eb 77                	jmp    364 <re_compile+0x2a3>
        }
        /* Null-terminate string end */
        ccl_buf[ccl_bufidx++] = 0;
     2ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2f0:	8d 50 01             	lea    0x1(%eax),%edx
     2f3:	89 55 fc             	mov    %edx,-0x4(%ebp)
     2f6:	c6 80 c0 1d 00 00 00 	movb   $0x0,0x1dc0(%eax)
        re_compiled[j].ccl = &ccl_buf[buf_begin];
     2fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     300:	8d 90 c0 1d 00 00    	lea    0x1dc0(%eax),%edx
     306:	8b 45 f4             	mov    -0xc(%ebp),%eax
     309:	89 14 c5 c4 1c 00 00 	mov    %edx,0x1cc4(,%eax,8)
      } break;
     310:	eb 1c                	jmp    32e <re_compile+0x26d>

      /* Other characters: */
      default:
      {
        re_compiled[j].type = CHAR;
     312:	8b 45 f4             	mov    -0xc(%ebp),%eax
     315:	c6 04 c5 c0 1c 00 00 	movb   $0x7,0x1cc0(,%eax,8)
     31c:	07 
        re_compiled[j].ch = c;
     31d:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
     321:	8b 45 f4             	mov    -0xc(%ebp),%eax
     324:	88 14 c5 c4 1c 00 00 	mov    %dl,0x1cc4(,%eax,8)
      } break;
     32b:	eb 01                	jmp    32e <re_compile+0x26d>
        { 
          re_compiled[j].type = CHAR;
          re_compiled[j].ch = pattern[i];
        }
*/
      } break;
     32d:	90                   	nop
      {
        re_compiled[j].type = CHAR;
        re_compiled[j].ch = c;
      } break;
    }
    i += 1;
     32e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    j += 1;
     332:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  char c;     /* current char in pattern   */
  int i = 0;  /* index into pattern        */
  int j = 0;  /* index into re_compiled    */

  while (pattern[i] != '\0' && (j+1 < MAX_REGEXP_OBJECTS))
     336:	8b 55 f8             	mov    -0x8(%ebp),%edx
     339:	8b 45 08             	mov    0x8(%ebp),%eax
     33c:	01 d0                	add    %edx,%eax
     33e:	0f b6 00             	movzbl (%eax),%eax
     341:	84 c0                	test   %al,%al
     343:	74 0f                	je     354 <re_compile+0x293>
     345:	8b 45 f4             	mov    -0xc(%ebp),%eax
     348:	83 c0 01             	add    $0x1,%eax
     34b:	83 f8 1d             	cmp    $0x1d,%eax
     34e:	0f 8e 8d fd ff ff    	jle    e1 <re_compile+0x20>
    }
    i += 1;
    j += 1;
  }
  /* 'UNUSED' is a sentinel used to indicate end-of-pattern */
  re_compiled[j].type = UNUSED;
     354:	8b 45 f4             	mov    -0xc(%ebp),%eax
     357:	c6 04 c5 c0 1c 00 00 	movb   $0x0,0x1cc0(,%eax,8)
     35e:	00 

  return (re_t) re_compiled;
     35f:	b8 c0 1c 00 00       	mov    $0x1cc0,%eax
}
     364:	c9                   	leave  
     365:	c3                   	ret    

00000366 <re_print>:

void re_print(regex_t* pattern)
{
     366:	55                   	push   %ebp
     367:	89 e5                	mov    %esp,%ebp
     369:	57                   	push   %edi
     36a:	56                   	push   %esi
     36b:	53                   	push   %ebx
     36c:	83 ec 5c             	sub    $0x5c,%esp
  const char* types[] = { "UNUSED", "DOT", "BEGIN", "END", "QUESTIONMARK", "STAR", "PLUS", "CHAR", "CHAR_CLASS", "INV_CHAR_CLASS", "DIGIT", "NOT_DIGIT", "ALPHA", "NOT_ALPHA", "WHITESPACE", "NOT_WHITESPACE", "BRANCH" };
     36f:	8d 45 98             	lea    -0x68(%ebp),%eax
     372:	bb 80 16 00 00       	mov    $0x1680,%ebx
     377:	ba 11 00 00 00       	mov    $0x11,%edx
     37c:	89 c7                	mov    %eax,%edi
     37e:	89 de                	mov    %ebx,%esi
     380:	89 d1                	mov    %edx,%ecx
     382:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  int i;
  int j;
  char c;
  for (i = 0; i < MAX_REGEXP_OBJECTS; ++i)
     384:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     38b:	e9 40 01 00 00       	jmp    4d0 <re_print+0x16a>
  {
    if (pattern[i].type == UNUSED)
     390:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     393:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     39a:	8b 45 08             	mov    0x8(%ebp),%eax
     39d:	01 d0                	add    %edx,%eax
     39f:	0f b6 00             	movzbl (%eax),%eax
     3a2:	84 c0                	test   %al,%al
     3a4:	0f 84 32 01 00 00    	je     4dc <re_print+0x176>
    {
      break;
    }

    printf(1,"type: %s", types[pattern[i].type]);
     3aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     3ad:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     3b4:	8b 45 08             	mov    0x8(%ebp),%eax
     3b7:	01 d0                	add    %edx,%eax
     3b9:	0f b6 00             	movzbl (%eax),%eax
     3bc:	0f b6 c0             	movzbl %al,%eax
     3bf:	8b 44 85 98          	mov    -0x68(%ebp,%eax,4),%eax
     3c3:	83 ec 04             	sub    $0x4,%esp
     3c6:	50                   	push   %eax
     3c7:	68 bc 15 00 00       	push   $0x15bc
     3cc:	6a 01                	push   $0x1
     3ce:	e8 71 0c 00 00       	call   1044 <printf>
     3d3:	83 c4 10             	add    $0x10,%esp
    if (pattern[i].type == CHAR_CLASS || pattern[i].type == INV_CHAR_CLASS)
     3d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     3d9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     3e0:	8b 45 08             	mov    0x8(%ebp),%eax
     3e3:	01 d0                	add    %edx,%eax
     3e5:	0f b6 00             	movzbl (%eax),%eax
     3e8:	3c 08                	cmp    $0x8,%al
     3ea:	74 16                	je     402 <re_print+0x9c>
     3ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     3ef:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     3f6:	8b 45 08             	mov    0x8(%ebp),%eax
     3f9:	01 d0                	add    %edx,%eax
     3fb:	0f b6 00             	movzbl (%eax),%eax
     3fe:	3c 09                	cmp    $0x9,%al
     400:	75 79                	jne    47b <re_print+0x115>
    {
      printf(1," [");
     402:	83 ec 08             	sub    $0x8,%esp
     405:	68 c5 15 00 00       	push   $0x15c5
     40a:	6a 01                	push   $0x1
     40c:	e8 33 0c 00 00       	call   1044 <printf>
     411:	83 c4 10             	add    $0x10,%esp
      for (j = 0; j < MAX_CHAR_CLASS_LEN; ++j)
     414:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     41b:	eb 44                	jmp    461 <re_print+0xfb>
      {
        c = pattern[i].ccl[j];
     41d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     420:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     427:	8b 45 08             	mov    0x8(%ebp),%eax
     42a:	01 d0                	add    %edx,%eax
     42c:	8b 50 04             	mov    0x4(%eax),%edx
     42f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     432:	01 d0                	add    %edx,%eax
     434:	0f b6 00             	movzbl (%eax),%eax
     437:	88 45 df             	mov    %al,-0x21(%ebp)
        if ((c == '\0') || (c == ']'))
     43a:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
     43e:	74 27                	je     467 <re_print+0x101>
     440:	80 7d df 5d          	cmpb   $0x5d,-0x21(%ebp)
     444:	74 21                	je     467 <re_print+0x101>
        {
          break;
        }
        printf(1,"%c", c);
     446:	0f be 45 df          	movsbl -0x21(%ebp),%eax
     44a:	83 ec 04             	sub    $0x4,%esp
     44d:	50                   	push   %eax
     44e:	68 c8 15 00 00       	push   $0x15c8
     453:	6a 01                	push   $0x1
     455:	e8 ea 0b 00 00       	call   1044 <printf>
     45a:	83 c4 10             	add    $0x10,%esp

    printf(1,"type: %s", types[pattern[i].type]);
    if (pattern[i].type == CHAR_CLASS || pattern[i].type == INV_CHAR_CLASS)
    {
      printf(1," [");
      for (j = 0; j < MAX_CHAR_CLASS_LEN; ++j)
     45d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     461:	83 7d e0 27          	cmpl   $0x27,-0x20(%ebp)
     465:	7e b6                	jle    41d <re_print+0xb7>
        {
          break;
        }
        printf(1,"%c", c);
      }
      printf(1,"]");
     467:	83 ec 08             	sub    $0x8,%esp
     46a:	68 cb 15 00 00       	push   $0x15cb
     46f:	6a 01                	push   $0x1
     471:	e8 ce 0b 00 00       	call   1044 <printf>
     476:	83 c4 10             	add    $0x10,%esp
     479:	eb 3f                	jmp    4ba <re_print+0x154>
    }
    else if (pattern[i].type == CHAR)
     47b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     47e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     485:	8b 45 08             	mov    0x8(%ebp),%eax
     488:	01 d0                	add    %edx,%eax
     48a:	0f b6 00             	movzbl (%eax),%eax
     48d:	3c 07                	cmp    $0x7,%al
     48f:	75 29                	jne    4ba <re_print+0x154>
    {
      printf(1," '%c'", pattern[i].ch);
     491:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     494:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     49b:	8b 45 08             	mov    0x8(%ebp),%eax
     49e:	01 d0                	add    %edx,%eax
     4a0:	0f b6 40 04          	movzbl 0x4(%eax),%eax
     4a4:	0f b6 c0             	movzbl %al,%eax
     4a7:	83 ec 04             	sub    $0x4,%esp
     4aa:	50                   	push   %eax
     4ab:	68 cd 15 00 00       	push   $0x15cd
     4b0:	6a 01                	push   $0x1
     4b2:	e8 8d 0b 00 00       	call   1044 <printf>
     4b7:	83 c4 10             	add    $0x10,%esp
    }
    printf(1,"\n");
     4ba:	83 ec 08             	sub    $0x8,%esp
     4bd:	68 d3 15 00 00       	push   $0x15d3
     4c2:	6a 01                	push   $0x1
     4c4:	e8 7b 0b 00 00       	call   1044 <printf>
     4c9:	83 c4 10             	add    $0x10,%esp
  const char* types[] = { "UNUSED", "DOT", "BEGIN", "END", "QUESTIONMARK", "STAR", "PLUS", "CHAR", "CHAR_CLASS", "INV_CHAR_CLASS", "DIGIT", "NOT_DIGIT", "ALPHA", "NOT_ALPHA", "WHITESPACE", "NOT_WHITESPACE", "BRANCH" };

  int i;
  int j;
  char c;
  for (i = 0; i < MAX_REGEXP_OBJECTS; ++i)
     4cc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     4d0:	83 7d e4 1d          	cmpl   $0x1d,-0x1c(%ebp)
     4d4:	0f 8e b6 fe ff ff    	jle    390 <re_print+0x2a>
    {
      printf(1," '%c'", pattern[i].ch);
    }
    printf(1,"\n");
  }
}
     4da:	eb 01                	jmp    4dd <re_print+0x177>
  char c;
  for (i = 0; i < MAX_REGEXP_OBJECTS; ++i)
  {
    if (pattern[i].type == UNUSED)
    {
      break;
     4dc:	90                   	nop
    {
      printf(1," '%c'", pattern[i].ch);
    }
    printf(1,"\n");
  }
}
     4dd:	90                   	nop
     4de:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4e1:	5b                   	pop    %ebx
     4e2:	5e                   	pop    %esi
     4e3:	5f                   	pop    %edi
     4e4:	5d                   	pop    %ebp
     4e5:	c3                   	ret    

000004e6 <matchdigit>:



/* Private functions: */
static int matchdigit(char c)
{
     4e6:	55                   	push   %ebp
     4e7:	89 e5                	mov    %esp,%ebp
     4e9:	83 ec 04             	sub    $0x4,%esp
     4ec:	8b 45 08             	mov    0x8(%ebp),%eax
     4ef:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= '0') && (c <= '9'));
     4f2:	80 7d fc 2f          	cmpb   $0x2f,-0x4(%ebp)
     4f6:	7e 0d                	jle    505 <matchdigit+0x1f>
     4f8:	80 7d fc 39          	cmpb   $0x39,-0x4(%ebp)
     4fc:	7f 07                	jg     505 <matchdigit+0x1f>
     4fe:	b8 01 00 00 00       	mov    $0x1,%eax
     503:	eb 05                	jmp    50a <matchdigit+0x24>
     505:	b8 00 00 00 00       	mov    $0x0,%eax
}
     50a:	c9                   	leave  
     50b:	c3                   	ret    

0000050c <matchalpha>:
static int matchalpha(char c)
{
     50c:	55                   	push   %ebp
     50d:	89 e5                	mov    %esp,%ebp
     50f:	83 ec 04             	sub    $0x4,%esp
     512:	8b 45 08             	mov    0x8(%ebp),%eax
     515:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'));
     518:	80 7d fc 60          	cmpb   $0x60,-0x4(%ebp)
     51c:	7e 06                	jle    524 <matchalpha+0x18>
     51e:	80 7d fc 7a          	cmpb   $0x7a,-0x4(%ebp)
     522:	7e 0c                	jle    530 <matchalpha+0x24>
     524:	80 7d fc 40          	cmpb   $0x40,-0x4(%ebp)
     528:	7e 0d                	jle    537 <matchalpha+0x2b>
     52a:	80 7d fc 5a          	cmpb   $0x5a,-0x4(%ebp)
     52e:	7f 07                	jg     537 <matchalpha+0x2b>
     530:	b8 01 00 00 00       	mov    $0x1,%eax
     535:	eb 05                	jmp    53c <matchalpha+0x30>
     537:	b8 00 00 00 00       	mov    $0x0,%eax
}
     53c:	c9                   	leave  
     53d:	c3                   	ret    

0000053e <matchwhitespace>:
static int matchwhitespace(char c)
{
     53e:	55                   	push   %ebp
     53f:	89 e5                	mov    %esp,%ebp
     541:	83 ec 04             	sub    $0x4,%esp
     544:	8b 45 08             	mov    0x8(%ebp),%eax
     547:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r') || (c == '\f') || (c == '\v'));
     54a:	80 7d fc 20          	cmpb   $0x20,-0x4(%ebp)
     54e:	74 1e                	je     56e <matchwhitespace+0x30>
     550:	80 7d fc 09          	cmpb   $0x9,-0x4(%ebp)
     554:	74 18                	je     56e <matchwhitespace+0x30>
     556:	80 7d fc 0a          	cmpb   $0xa,-0x4(%ebp)
     55a:	74 12                	je     56e <matchwhitespace+0x30>
     55c:	80 7d fc 0d          	cmpb   $0xd,-0x4(%ebp)
     560:	74 0c                	je     56e <matchwhitespace+0x30>
     562:	80 7d fc 0c          	cmpb   $0xc,-0x4(%ebp)
     566:	74 06                	je     56e <matchwhitespace+0x30>
     568:	80 7d fc 0b          	cmpb   $0xb,-0x4(%ebp)
     56c:	75 07                	jne    575 <matchwhitespace+0x37>
     56e:	b8 01 00 00 00       	mov    $0x1,%eax
     573:	eb 05                	jmp    57a <matchwhitespace+0x3c>
     575:	b8 00 00 00 00       	mov    $0x0,%eax
}
     57a:	c9                   	leave  
     57b:	c3                   	ret    

0000057c <matchalphanum>:
static int matchalphanum(char c)
{
     57c:	55                   	push   %ebp
     57d:	89 e5                	mov    %esp,%ebp
     57f:	83 ec 04             	sub    $0x4,%esp
     582:	8b 45 08             	mov    0x8(%ebp),%eax
     585:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == '_') || matchalpha(c) || matchdigit(c));
     588:	80 7d fc 5f          	cmpb   $0x5f,-0x4(%ebp)
     58c:	74 22                	je     5b0 <matchalphanum+0x34>
     58e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     592:	50                   	push   %eax
     593:	e8 74 ff ff ff       	call   50c <matchalpha>
     598:	83 c4 04             	add    $0x4,%esp
     59b:	85 c0                	test   %eax,%eax
     59d:	75 11                	jne    5b0 <matchalphanum+0x34>
     59f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     5a3:	50                   	push   %eax
     5a4:	e8 3d ff ff ff       	call   4e6 <matchdigit>
     5a9:	83 c4 04             	add    $0x4,%esp
     5ac:	85 c0                	test   %eax,%eax
     5ae:	74 07                	je     5b7 <matchalphanum+0x3b>
     5b0:	b8 01 00 00 00       	mov    $0x1,%eax
     5b5:	eb 05                	jmp    5bc <matchalphanum+0x40>
     5b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     5bc:	c9                   	leave  
     5bd:	c3                   	ret    

000005be <matchrange>:
static int matchrange(char c, const char* str)
{
     5be:	55                   	push   %ebp
     5bf:	89 e5                	mov    %esp,%ebp
     5c1:	83 ec 04             	sub    $0x4,%esp
     5c4:	8b 45 08             	mov    0x8(%ebp),%eax
     5c7:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     5ca:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     5ce:	74 5b                	je     62b <matchrange+0x6d>
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     5d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     5d3:	0f b6 00             	movzbl (%eax),%eax
     5d6:	84 c0                	test   %al,%al
     5d8:	74 51                	je     62b <matchrange+0x6d>
     5da:	8b 45 0c             	mov    0xc(%ebp),%eax
     5dd:	0f b6 00             	movzbl (%eax),%eax
     5e0:	3c 2d                	cmp    $0x2d,%al
     5e2:	74 47                	je     62b <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     5e4:	8b 45 0c             	mov    0xc(%ebp),%eax
     5e7:	83 c0 01             	add    $0x1,%eax
     5ea:	0f b6 00             	movzbl (%eax),%eax
{
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
     5ed:	3c 2d                	cmp    $0x2d,%al
     5ef:	75 3a                	jne    62b <matchrange+0x6d>
         (str[1] == '-') && (str[1] != '\0') &&
     5f1:	8b 45 0c             	mov    0xc(%ebp),%eax
     5f4:	83 c0 01             	add    $0x1,%eax
     5f7:	0f b6 00             	movzbl (%eax),%eax
     5fa:	84 c0                	test   %al,%al
     5fc:	74 2d                	je     62b <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     5fe:	8b 45 0c             	mov    0xc(%ebp),%eax
     601:	83 c0 02             	add    $0x2,%eax
     604:	0f b6 00             	movzbl (%eax),%eax
  return ((c == '_') || matchalpha(c) || matchdigit(c));
}
static int matchrange(char c, const char* str)
{
  return ((c != '-') && (str[0] != '\0') && (str[0] != '-') &&
         (str[1] == '-') && (str[1] != '\0') &&
     607:	84 c0                	test   %al,%al
     609:	74 20                	je     62b <matchrange+0x6d>
         (str[2] != '\0') && ((c >= str[0]) && (c <= str[2])));
     60b:	8b 45 0c             	mov    0xc(%ebp),%eax
     60e:	0f b6 00             	movzbl (%eax),%eax
     611:	3a 45 fc             	cmp    -0x4(%ebp),%al
     614:	7f 15                	jg     62b <matchrange+0x6d>
     616:	8b 45 0c             	mov    0xc(%ebp),%eax
     619:	83 c0 02             	add    $0x2,%eax
     61c:	0f b6 00             	movzbl (%eax),%eax
     61f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     622:	7c 07                	jl     62b <matchrange+0x6d>
     624:	b8 01 00 00 00       	mov    $0x1,%eax
     629:	eb 05                	jmp    630 <matchrange+0x72>
     62b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     630:	c9                   	leave  
     631:	c3                   	ret    

00000632 <ismetachar>:
static int ismetachar(char c)
{
     632:	55                   	push   %ebp
     633:	89 e5                	mov    %esp,%ebp
     635:	83 ec 04             	sub    $0x4,%esp
     638:	8b 45 08             	mov    0x8(%ebp),%eax
     63b:	88 45 fc             	mov    %al,-0x4(%ebp)
  return ((c == 's') || (c == 'S') || (c == 'w') || (c == 'W') || (c == 'd') || (c == 'D'));
     63e:	80 7d fc 73          	cmpb   $0x73,-0x4(%ebp)
     642:	74 1e                	je     662 <ismetachar+0x30>
     644:	80 7d fc 53          	cmpb   $0x53,-0x4(%ebp)
     648:	74 18                	je     662 <ismetachar+0x30>
     64a:	80 7d fc 77          	cmpb   $0x77,-0x4(%ebp)
     64e:	74 12                	je     662 <ismetachar+0x30>
     650:	80 7d fc 57          	cmpb   $0x57,-0x4(%ebp)
     654:	74 0c                	je     662 <ismetachar+0x30>
     656:	80 7d fc 64          	cmpb   $0x64,-0x4(%ebp)
     65a:	74 06                	je     662 <ismetachar+0x30>
     65c:	80 7d fc 44          	cmpb   $0x44,-0x4(%ebp)
     660:	75 07                	jne    669 <ismetachar+0x37>
     662:	b8 01 00 00 00       	mov    $0x1,%eax
     667:	eb 05                	jmp    66e <ismetachar+0x3c>
     669:	b8 00 00 00 00       	mov    $0x0,%eax
}
     66e:	c9                   	leave  
     66f:	c3                   	ret    

00000670 <matchmetachar>:

static int matchmetachar(char c, const char* str)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	83 ec 04             	sub    $0x4,%esp
     676:	8b 45 08             	mov    0x8(%ebp),%eax
     679:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (str[0])
     67c:	8b 45 0c             	mov    0xc(%ebp),%eax
     67f:	0f b6 00             	movzbl (%eax),%eax
     682:	0f be c0             	movsbl %al,%eax
     685:	83 e8 44             	sub    $0x44,%eax
     688:	83 f8 33             	cmp    $0x33,%eax
     68b:	77 7b                	ja     708 <matchmetachar+0x98>
     68d:	8b 04 85 c4 16 00 00 	mov    0x16c4(,%eax,4),%eax
     694:	ff e0                	jmp    *%eax
  {
    case 'd': return  matchdigit(c);
     696:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     69a:	50                   	push   %eax
     69b:	e8 46 fe ff ff       	call   4e6 <matchdigit>
     6a0:	83 c4 04             	add    $0x4,%esp
     6a3:	eb 72                	jmp    717 <matchmetachar+0xa7>
    case 'D': return !matchdigit(c);
     6a5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     6a9:	50                   	push   %eax
     6aa:	e8 37 fe ff ff       	call   4e6 <matchdigit>
     6af:	83 c4 04             	add    $0x4,%esp
     6b2:	85 c0                	test   %eax,%eax
     6b4:	0f 94 c0             	sete   %al
     6b7:	0f b6 c0             	movzbl %al,%eax
     6ba:	eb 5b                	jmp    717 <matchmetachar+0xa7>
    case 'w': return  matchalphanum(c);
     6bc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     6c0:	50                   	push   %eax
     6c1:	e8 b6 fe ff ff       	call   57c <matchalphanum>
     6c6:	83 c4 04             	add    $0x4,%esp
     6c9:	eb 4c                	jmp    717 <matchmetachar+0xa7>
    case 'W': return !matchalphanum(c);
     6cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     6cf:	50                   	push   %eax
     6d0:	e8 a7 fe ff ff       	call   57c <matchalphanum>
     6d5:	83 c4 04             	add    $0x4,%esp
     6d8:	85 c0                	test   %eax,%eax
     6da:	0f 94 c0             	sete   %al
     6dd:	0f b6 c0             	movzbl %al,%eax
     6e0:	eb 35                	jmp    717 <matchmetachar+0xa7>
    case 's': return  matchwhitespace(c);
     6e2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     6e6:	50                   	push   %eax
     6e7:	e8 52 fe ff ff       	call   53e <matchwhitespace>
     6ec:	83 c4 04             	add    $0x4,%esp
     6ef:	eb 26                	jmp    717 <matchmetachar+0xa7>
    case 'S': return !matchwhitespace(c);
     6f1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     6f5:	50                   	push   %eax
     6f6:	e8 43 fe ff ff       	call   53e <matchwhitespace>
     6fb:	83 c4 04             	add    $0x4,%esp
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 94 c0             	sete   %al
     703:	0f b6 c0             	movzbl %al,%eax
     706:	eb 0f                	jmp    717 <matchmetachar+0xa7>
    default:  return (c == str[0]);
     708:	8b 45 0c             	mov    0xc(%ebp),%eax
     70b:	0f b6 00             	movzbl (%eax),%eax
     70e:	3a 45 fc             	cmp    -0x4(%ebp),%al
     711:	0f 94 c0             	sete   %al
     714:	0f b6 c0             	movzbl %al,%eax
  }
}
     717:	c9                   	leave  
     718:	c3                   	ret    

00000719 <matchcharclass>:

static int matchcharclass(char c, const char* str)
{
     719:	55                   	push   %ebp
     71a:	89 e5                	mov    %esp,%ebp
     71c:	83 ec 04             	sub    $0x4,%esp
     71f:	8b 45 08             	mov    0x8(%ebp),%eax
     722:	88 45 fc             	mov    %al,-0x4(%ebp)
  do
  {
    if (matchrange(c, str))
     725:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     729:	ff 75 0c             	pushl  0xc(%ebp)
     72c:	50                   	push   %eax
     72d:	e8 8c fe ff ff       	call   5be <matchrange>
     732:	83 c4 08             	add    $0x8,%esp
     735:	85 c0                	test   %eax,%eax
     737:	74 0a                	je     743 <matchcharclass+0x2a>
    {
      return 1;
     739:	b8 01 00 00 00       	mov    $0x1,%eax
     73e:	e9 a5 00 00 00       	jmp    7e8 <matchcharclass+0xcf>
    }
    else if (str[0] == '\\')
     743:	8b 45 0c             	mov    0xc(%ebp),%eax
     746:	0f b6 00             	movzbl (%eax),%eax
     749:	3c 5c                	cmp    $0x5c,%al
     74b:	75 42                	jne    78f <matchcharclass+0x76>
    {
      /* Escape-char: increment str-ptr and match on next char */
      str += 1;
     74d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      if (matchmetachar(c, str))
     751:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     755:	ff 75 0c             	pushl  0xc(%ebp)
     758:	50                   	push   %eax
     759:	e8 12 ff ff ff       	call   670 <matchmetachar>
     75e:	83 c4 08             	add    $0x8,%esp
     761:	85 c0                	test   %eax,%eax
     763:	74 07                	je     76c <matchcharclass+0x53>
      {
        return 1;
     765:	b8 01 00 00 00       	mov    $0x1,%eax
     76a:	eb 7c                	jmp    7e8 <matchcharclass+0xcf>
      } 
      else if ((c == str[0]) && !ismetachar(c))
     76c:	8b 45 0c             	mov    0xc(%ebp),%eax
     76f:	0f b6 00             	movzbl (%eax),%eax
     772:	3a 45 fc             	cmp    -0x4(%ebp),%al
     775:	75 58                	jne    7cf <matchcharclass+0xb6>
     777:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     77b:	50                   	push   %eax
     77c:	e8 b1 fe ff ff       	call   632 <ismetachar>
     781:	83 c4 04             	add    $0x4,%esp
     784:	85 c0                	test   %eax,%eax
     786:	75 47                	jne    7cf <matchcharclass+0xb6>
      {
        return 1;
     788:	b8 01 00 00 00       	mov    $0x1,%eax
     78d:	eb 59                	jmp    7e8 <matchcharclass+0xcf>
      }
    }
    else if (c == str[0])
     78f:	8b 45 0c             	mov    0xc(%ebp),%eax
     792:	0f b6 00             	movzbl (%eax),%eax
     795:	3a 45 fc             	cmp    -0x4(%ebp),%al
     798:	75 35                	jne    7cf <matchcharclass+0xb6>
    {
      if (c == '-')
     79a:	80 7d fc 2d          	cmpb   $0x2d,-0x4(%ebp)
     79e:	75 28                	jne    7c8 <matchcharclass+0xaf>
      {
        return ((str[-1] == '\0') || (str[1] == '\0'));
     7a0:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a3:	83 e8 01             	sub    $0x1,%eax
     7a6:	0f b6 00             	movzbl (%eax),%eax
     7a9:	84 c0                	test   %al,%al
     7ab:	74 0d                	je     7ba <matchcharclass+0xa1>
     7ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     7b0:	83 c0 01             	add    $0x1,%eax
     7b3:	0f b6 00             	movzbl (%eax),%eax
     7b6:	84 c0                	test   %al,%al
     7b8:	75 07                	jne    7c1 <matchcharclass+0xa8>
     7ba:	b8 01 00 00 00       	mov    $0x1,%eax
     7bf:	eb 27                	jmp    7e8 <matchcharclass+0xcf>
     7c1:	b8 00 00 00 00       	mov    $0x0,%eax
     7c6:	eb 20                	jmp    7e8 <matchcharclass+0xcf>
      }
      else
      {
        return 1;
     7c8:	b8 01 00 00 00       	mov    $0x1,%eax
     7cd:	eb 19                	jmp    7e8 <matchcharclass+0xcf>
      }
    }
  }
  while (*str++ != '\0');
     7cf:	8b 45 0c             	mov    0xc(%ebp),%eax
     7d2:	8d 50 01             	lea    0x1(%eax),%edx
     7d5:	89 55 0c             	mov    %edx,0xc(%ebp)
     7d8:	0f b6 00             	movzbl (%eax),%eax
     7db:	84 c0                	test   %al,%al
     7dd:	0f 85 42 ff ff ff    	jne    725 <matchcharclass+0xc>

  return 0;
     7e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     7e8:	c9                   	leave  
     7e9:	c3                   	ret    

000007ea <matchone>:

static int matchone(regex_t p, char c)
{
     7ea:	55                   	push   %ebp
     7eb:	89 e5                	mov    %esp,%ebp
     7ed:	83 ec 04             	sub    $0x4,%esp
     7f0:	8b 45 10             	mov    0x10(%ebp),%eax
     7f3:	88 45 fc             	mov    %al,-0x4(%ebp)
  switch (p.type)
     7f6:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     7fa:	0f b6 c0             	movzbl %al,%eax
     7fd:	83 f8 0f             	cmp    $0xf,%eax
     800:	0f 87 b9 00 00 00    	ja     8bf <matchone+0xd5>
     806:	8b 04 85 94 17 00 00 	mov    0x1794(,%eax,4),%eax
     80d:	ff e0                	jmp    *%eax
  {
    case DOT:            return 1;
     80f:	b8 01 00 00 00       	mov    $0x1,%eax
     814:	e9 b9 00 00 00       	jmp    8d2 <matchone+0xe8>
    case CHAR_CLASS:     return  matchcharclass(c, (const char*)p.ccl);
     819:	8b 55 0c             	mov    0xc(%ebp),%edx
     81c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     820:	52                   	push   %edx
     821:	50                   	push   %eax
     822:	e8 f2 fe ff ff       	call   719 <matchcharclass>
     827:	83 c4 08             	add    $0x8,%esp
     82a:	e9 a3 00 00 00       	jmp    8d2 <matchone+0xe8>
    case INV_CHAR_CLASS: return !matchcharclass(c, (const char*)p.ccl);
     82f:	8b 55 0c             	mov    0xc(%ebp),%edx
     832:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     836:	52                   	push   %edx
     837:	50                   	push   %eax
     838:	e8 dc fe ff ff       	call   719 <matchcharclass>
     83d:	83 c4 08             	add    $0x8,%esp
     840:	85 c0                	test   %eax,%eax
     842:	0f 94 c0             	sete   %al
     845:	0f b6 c0             	movzbl %al,%eax
     848:	e9 85 00 00 00       	jmp    8d2 <matchone+0xe8>
    case DIGIT:          return  matchdigit(c);
     84d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     851:	50                   	push   %eax
     852:	e8 8f fc ff ff       	call   4e6 <matchdigit>
     857:	83 c4 04             	add    $0x4,%esp
     85a:	eb 76                	jmp    8d2 <matchone+0xe8>
    case NOT_DIGIT:      return !matchdigit(c);
     85c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     860:	50                   	push   %eax
     861:	e8 80 fc ff ff       	call   4e6 <matchdigit>
     866:	83 c4 04             	add    $0x4,%esp
     869:	85 c0                	test   %eax,%eax
     86b:	0f 94 c0             	sete   %al
     86e:	0f b6 c0             	movzbl %al,%eax
     871:	eb 5f                	jmp    8d2 <matchone+0xe8>
    case ALPHA:          return  matchalphanum(c);
     873:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     877:	50                   	push   %eax
     878:	e8 ff fc ff ff       	call   57c <matchalphanum>
     87d:	83 c4 04             	add    $0x4,%esp
     880:	eb 50                	jmp    8d2 <matchone+0xe8>
    case NOT_ALPHA:      return !matchalphanum(c);
     882:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     886:	50                   	push   %eax
     887:	e8 f0 fc ff ff       	call   57c <matchalphanum>
     88c:	83 c4 04             	add    $0x4,%esp
     88f:	85 c0                	test   %eax,%eax
     891:	0f 94 c0             	sete   %al
     894:	0f b6 c0             	movzbl %al,%eax
     897:	eb 39                	jmp    8d2 <matchone+0xe8>
    case WHITESPACE:     return  matchwhitespace(c);
     899:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     89d:	50                   	push   %eax
     89e:	e8 9b fc ff ff       	call   53e <matchwhitespace>
     8a3:	83 c4 04             	add    $0x4,%esp
     8a6:	eb 2a                	jmp    8d2 <matchone+0xe8>
    case NOT_WHITESPACE: return !matchwhitespace(c);
     8a8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     8ac:	50                   	push   %eax
     8ad:	e8 8c fc ff ff       	call   53e <matchwhitespace>
     8b2:	83 c4 04             	add    $0x4,%esp
     8b5:	85 c0                	test   %eax,%eax
     8b7:	0f 94 c0             	sete   %al
     8ba:	0f b6 c0             	movzbl %al,%eax
     8bd:	eb 13                	jmp    8d2 <matchone+0xe8>
    default:             return  (p.ch == c);
     8bf:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
     8c3:	0f b6 d0             	movzbl %al,%edx
     8c6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
     8ca:	39 c2                	cmp    %eax,%edx
     8cc:	0f 94 c0             	sete   %al
     8cf:	0f b6 c0             	movzbl %al,%eax
  }
}
     8d2:	c9                   	leave  
     8d3:	c3                   	ret    

000008d4 <matchstar>:

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     8d4:	55                   	push   %ebp
     8d5:	89 e5                	mov    %esp,%ebp
     8d7:	83 ec 18             	sub    $0x18,%esp
  int prelen = *matchlength;
     8da:	8b 45 18             	mov    0x18(%ebp),%eax
     8dd:	8b 00                	mov    (%eax),%eax
     8df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  const char* prepoint = text;
     8e2:	8b 45 14             	mov    0x14(%ebp),%eax
     8e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     8e8:	eb 11                	jmp    8fb <matchstar+0x27>
  {
    text++;
     8ea:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     8ee:	8b 45 18             	mov    0x18(%ebp),%eax
     8f1:	8b 00                	mov    (%eax),%eax
     8f3:	8d 50 01             	lea    0x1(%eax),%edx
     8f6:	8b 45 18             	mov    0x18(%ebp),%eax
     8f9:	89 10                	mov    %edx,(%eax)

static int matchstar(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  int prelen = *matchlength;
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     8fb:	8b 45 14             	mov    0x14(%ebp),%eax
     8fe:	0f b6 00             	movzbl (%eax),%eax
     901:	84 c0                	test   %al,%al
     903:	74 51                	je     956 <matchstar+0x82>
     905:	8b 45 14             	mov    0x14(%ebp),%eax
     908:	0f b6 00             	movzbl (%eax),%eax
     90b:	0f be c0             	movsbl %al,%eax
     90e:	50                   	push   %eax
     90f:	ff 75 0c             	pushl  0xc(%ebp)
     912:	ff 75 08             	pushl  0x8(%ebp)
     915:	e8 d0 fe ff ff       	call   7ea <matchone>
     91a:	83 c4 0c             	add    $0xc,%esp
     91d:	85 c0                	test   %eax,%eax
     91f:	75 c9                	jne    8ea <matchstar+0x16>
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     921:	eb 33                	jmp    956 <matchstar+0x82>
  {
    if (matchpattern(pattern, text--, matchlength))
     923:	8b 45 14             	mov    0x14(%ebp),%eax
     926:	8d 50 ff             	lea    -0x1(%eax),%edx
     929:	89 55 14             	mov    %edx,0x14(%ebp)
     92c:	83 ec 04             	sub    $0x4,%esp
     92f:	ff 75 18             	pushl  0x18(%ebp)
     932:	50                   	push   %eax
     933:	ff 75 10             	pushl  0x10(%ebp)
     936:	e8 51 01 00 00       	call   a8c <matchpattern>
     93b:	83 c4 10             	add    $0x10,%esp
     93e:	85 c0                	test   %eax,%eax
     940:	74 07                	je     949 <matchstar+0x75>
      return 1;
     942:	b8 01 00 00 00       	mov    $0x1,%eax
     947:	eb 22                	jmp    96b <matchstar+0x97>
    (*matchlength)--;
     949:	8b 45 18             	mov    0x18(%ebp),%eax
     94c:	8b 00                	mov    (%eax),%eax
     94e:	8d 50 ff             	lea    -0x1(%eax),%edx
     951:	8b 45 18             	mov    0x18(%ebp),%eax
     954:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text >= prepoint)
     956:	8b 45 14             	mov    0x14(%ebp),%eax
     959:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     95c:	73 c5                	jae    923 <matchstar+0x4f>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  *matchlength = prelen;
     95e:	8b 45 18             	mov    0x18(%ebp),%eax
     961:	8b 55 f4             	mov    -0xc(%ebp),%edx
     964:	89 10                	mov    %edx,(%eax)
  return 0;
     966:	b8 00 00 00 00       	mov    $0x0,%eax
}
     96b:	c9                   	leave  
     96c:	c3                   	ret    

0000096d <matchplus>:

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     96d:	55                   	push   %ebp
     96e:	89 e5                	mov    %esp,%ebp
     970:	83 ec 18             	sub    $0x18,%esp
  const char* prepoint = text;
     973:	8b 45 14             	mov    0x14(%ebp),%eax
     976:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while ((text[0] != '\0') && matchone(p, *text))
     979:	eb 11                	jmp    98c <matchplus+0x1f>
  {
    text++;
     97b:	83 45 14 01          	addl   $0x1,0x14(%ebp)
    (*matchlength)++;
     97f:	8b 45 18             	mov    0x18(%ebp),%eax
     982:	8b 00                	mov    (%eax),%eax
     984:	8d 50 01             	lea    0x1(%eax),%edx
     987:	8b 45 18             	mov    0x18(%ebp),%eax
     98a:	89 10                	mov    %edx,(%eax)
}

static int matchplus(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
  const char* prepoint = text;
  while ((text[0] != '\0') && matchone(p, *text))
     98c:	8b 45 14             	mov    0x14(%ebp),%eax
     98f:	0f b6 00             	movzbl (%eax),%eax
     992:	84 c0                	test   %al,%al
     994:	74 51                	je     9e7 <matchplus+0x7a>
     996:	8b 45 14             	mov    0x14(%ebp),%eax
     999:	0f b6 00             	movzbl (%eax),%eax
     99c:	0f be c0             	movsbl %al,%eax
     99f:	50                   	push   %eax
     9a0:	ff 75 0c             	pushl  0xc(%ebp)
     9a3:	ff 75 08             	pushl  0x8(%ebp)
     9a6:	e8 3f fe ff ff       	call   7ea <matchone>
     9ab:	83 c4 0c             	add    $0xc,%esp
     9ae:	85 c0                	test   %eax,%eax
     9b0:	75 c9                	jne    97b <matchplus+0xe>
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
     9b2:	eb 33                	jmp    9e7 <matchplus+0x7a>
  {
    if (matchpattern(pattern, text--, matchlength))
     9b4:	8b 45 14             	mov    0x14(%ebp),%eax
     9b7:	8d 50 ff             	lea    -0x1(%eax),%edx
     9ba:	89 55 14             	mov    %edx,0x14(%ebp)
     9bd:	83 ec 04             	sub    $0x4,%esp
     9c0:	ff 75 18             	pushl  0x18(%ebp)
     9c3:	50                   	push   %eax
     9c4:	ff 75 10             	pushl  0x10(%ebp)
     9c7:	e8 c0 00 00 00       	call   a8c <matchpattern>
     9cc:	83 c4 10             	add    $0x10,%esp
     9cf:	85 c0                	test   %eax,%eax
     9d1:	74 07                	je     9da <matchplus+0x6d>
      return 1;
     9d3:	b8 01 00 00 00       	mov    $0x1,%eax
     9d8:	eb 1a                	jmp    9f4 <matchplus+0x87>
    (*matchlength)--;
     9da:	8b 45 18             	mov    0x18(%ebp),%eax
     9dd:	8b 00                	mov    (%eax),%eax
     9df:	8d 50 ff             	lea    -0x1(%eax),%edx
     9e2:	8b 45 18             	mov    0x18(%ebp),%eax
     9e5:	89 10                	mov    %edx,(%eax)
  while ((text[0] != '\0') && matchone(p, *text))
  {
    text++;
    (*matchlength)++;
  }
  while (text > prepoint)
     9e7:	8b 45 14             	mov    0x14(%ebp),%eax
     9ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     9ed:	77 c5                	ja     9b4 <matchplus+0x47>
    if (matchpattern(pattern, text--, matchlength))
      return 1;
    (*matchlength)--;
  }
  
  return 0;
     9ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
     9f4:	c9                   	leave  
     9f5:	c3                   	ret    

000009f6 <matchquestion>:

static int matchquestion(regex_t p, regex_t* pattern, const char* text, int* matchlength)
{
     9f6:	55                   	push   %ebp
     9f7:	89 e5                	mov    %esp,%ebp
     9f9:	83 ec 08             	sub    $0x8,%esp
  if (p.type == UNUSED)
     9fc:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     a00:	84 c0                	test   %al,%al
     a02:	75 07                	jne    a0b <matchquestion+0x15>
    return 1;
     a04:	b8 01 00 00 00       	mov    $0x1,%eax
     a09:	eb 7f                	jmp    a8a <matchquestion+0x94>
  if (matchpattern(pattern, text, matchlength))
     a0b:	83 ec 04             	sub    $0x4,%esp
     a0e:	ff 75 18             	pushl  0x18(%ebp)
     a11:	ff 75 14             	pushl  0x14(%ebp)
     a14:	ff 75 10             	pushl  0x10(%ebp)
     a17:	e8 70 00 00 00       	call   a8c <matchpattern>
     a1c:	83 c4 10             	add    $0x10,%esp
     a1f:	85 c0                	test   %eax,%eax
     a21:	74 07                	je     a2a <matchquestion+0x34>
      return 1;
     a23:	b8 01 00 00 00       	mov    $0x1,%eax
     a28:	eb 60                	jmp    a8a <matchquestion+0x94>
  if (*text && matchone(p, *text++))
     a2a:	8b 45 14             	mov    0x14(%ebp),%eax
     a2d:	0f b6 00             	movzbl (%eax),%eax
     a30:	84 c0                	test   %al,%al
     a32:	74 51                	je     a85 <matchquestion+0x8f>
     a34:	8b 45 14             	mov    0x14(%ebp),%eax
     a37:	8d 50 01             	lea    0x1(%eax),%edx
     a3a:	89 55 14             	mov    %edx,0x14(%ebp)
     a3d:	0f b6 00             	movzbl (%eax),%eax
     a40:	0f be c0             	movsbl %al,%eax
     a43:	83 ec 04             	sub    $0x4,%esp
     a46:	50                   	push   %eax
     a47:	ff 75 0c             	pushl  0xc(%ebp)
     a4a:	ff 75 08             	pushl  0x8(%ebp)
     a4d:	e8 98 fd ff ff       	call   7ea <matchone>
     a52:	83 c4 10             	add    $0x10,%esp
     a55:	85 c0                	test   %eax,%eax
     a57:	74 2c                	je     a85 <matchquestion+0x8f>
  {
    if (matchpattern(pattern, text, matchlength))
     a59:	83 ec 04             	sub    $0x4,%esp
     a5c:	ff 75 18             	pushl  0x18(%ebp)
     a5f:	ff 75 14             	pushl  0x14(%ebp)
     a62:	ff 75 10             	pushl  0x10(%ebp)
     a65:	e8 22 00 00 00       	call   a8c <matchpattern>
     a6a:	83 c4 10             	add    $0x10,%esp
     a6d:	85 c0                	test   %eax,%eax
     a6f:	74 14                	je     a85 <matchquestion+0x8f>
    {
      (*matchlength)++;
     a71:	8b 45 18             	mov    0x18(%ebp),%eax
     a74:	8b 00                	mov    (%eax),%eax
     a76:	8d 50 01             	lea    0x1(%eax),%edx
     a79:	8b 45 18             	mov    0x18(%ebp),%eax
     a7c:	89 10                	mov    %edx,(%eax)
      return 1;
     a7e:	b8 01 00 00 00       	mov    $0x1,%eax
     a83:	eb 05                	jmp    a8a <matchquestion+0x94>
    }
  }
  return 0;
     a85:	b8 00 00 00 00       	mov    $0x0,%eax
}
     a8a:	c9                   	leave  
     a8b:	c3                   	ret    

00000a8c <matchpattern>:

#else

/* Iterative matching */
static int matchpattern(regex_t* pattern, const char* text, int* matchlength)
{
     a8c:	55                   	push   %ebp
     a8d:	89 e5                	mov    %esp,%ebp
     a8f:	83 ec 18             	sub    $0x18,%esp
  int pre = *matchlength;
     a92:	8b 45 10             	mov    0x10(%ebp),%eax
     a95:	8b 00                	mov    (%eax),%eax
     a97:	89 45 f4             	mov    %eax,-0xc(%ebp)
  do
  {
    if ((pattern[0].type == UNUSED) || (pattern[1].type == QUESTIONMARK))
     a9a:	8b 45 08             	mov    0x8(%ebp),%eax
     a9d:	0f b6 00             	movzbl (%eax),%eax
     aa0:	84 c0                	test   %al,%al
     aa2:	74 0d                	je     ab1 <matchpattern+0x25>
     aa4:	8b 45 08             	mov    0x8(%ebp),%eax
     aa7:	83 c0 08             	add    $0x8,%eax
     aaa:	0f b6 00             	movzbl (%eax),%eax
     aad:	3c 04                	cmp    $0x4,%al
     aaf:	75 25                	jne    ad6 <matchpattern+0x4a>
    {
      return matchquestion(pattern[0], &pattern[2], text, matchlength);
     ab1:	8b 45 08             	mov    0x8(%ebp),%eax
     ab4:	83 c0 10             	add    $0x10,%eax
     ab7:	83 ec 0c             	sub    $0xc,%esp
     aba:	ff 75 10             	pushl  0x10(%ebp)
     abd:	ff 75 0c             	pushl  0xc(%ebp)
     ac0:	50                   	push   %eax
     ac1:	8b 45 08             	mov    0x8(%ebp),%eax
     ac4:	ff 70 04             	pushl  0x4(%eax)
     ac7:	ff 30                	pushl  (%eax)
     ac9:	e8 28 ff ff ff       	call   9f6 <matchquestion>
     ace:	83 c4 20             	add    $0x20,%esp
     ad1:	e9 dd 00 00 00       	jmp    bb3 <matchpattern+0x127>
    }
    else if (pattern[1].type == STAR)
     ad6:	8b 45 08             	mov    0x8(%ebp),%eax
     ad9:	83 c0 08             	add    $0x8,%eax
     adc:	0f b6 00             	movzbl (%eax),%eax
     adf:	3c 05                	cmp    $0x5,%al
     ae1:	75 25                	jne    b08 <matchpattern+0x7c>
    {
      return matchstar(pattern[0], &pattern[2], text, matchlength);
     ae3:	8b 45 08             	mov    0x8(%ebp),%eax
     ae6:	83 c0 10             	add    $0x10,%eax
     ae9:	83 ec 0c             	sub    $0xc,%esp
     aec:	ff 75 10             	pushl  0x10(%ebp)
     aef:	ff 75 0c             	pushl  0xc(%ebp)
     af2:	50                   	push   %eax
     af3:	8b 45 08             	mov    0x8(%ebp),%eax
     af6:	ff 70 04             	pushl  0x4(%eax)
     af9:	ff 30                	pushl  (%eax)
     afb:	e8 d4 fd ff ff       	call   8d4 <matchstar>
     b00:	83 c4 20             	add    $0x20,%esp
     b03:	e9 ab 00 00 00       	jmp    bb3 <matchpattern+0x127>
    }
    else if (pattern[1].type == PLUS)
     b08:	8b 45 08             	mov    0x8(%ebp),%eax
     b0b:	83 c0 08             	add    $0x8,%eax
     b0e:	0f b6 00             	movzbl (%eax),%eax
     b11:	3c 06                	cmp    $0x6,%al
     b13:	75 22                	jne    b37 <matchpattern+0xab>
    {
      return matchplus(pattern[0], &pattern[2], text, matchlength);
     b15:	8b 45 08             	mov    0x8(%ebp),%eax
     b18:	83 c0 10             	add    $0x10,%eax
     b1b:	83 ec 0c             	sub    $0xc,%esp
     b1e:	ff 75 10             	pushl  0x10(%ebp)
     b21:	ff 75 0c             	pushl  0xc(%ebp)
     b24:	50                   	push   %eax
     b25:	8b 45 08             	mov    0x8(%ebp),%eax
     b28:	ff 70 04             	pushl  0x4(%eax)
     b2b:	ff 30                	pushl  (%eax)
     b2d:	e8 3b fe ff ff       	call   96d <matchplus>
     b32:	83 c4 20             	add    $0x20,%esp
     b35:	eb 7c                	jmp    bb3 <matchpattern+0x127>
    }
    else if ((pattern[0].type == END) && pattern[1].type == UNUSED)
     b37:	8b 45 08             	mov    0x8(%ebp),%eax
     b3a:	0f b6 00             	movzbl (%eax),%eax
     b3d:	3c 03                	cmp    $0x3,%al
     b3f:	75 1d                	jne    b5e <matchpattern+0xd2>
     b41:	8b 45 08             	mov    0x8(%ebp),%eax
     b44:	83 c0 08             	add    $0x8,%eax
     b47:	0f b6 00             	movzbl (%eax),%eax
     b4a:	84 c0                	test   %al,%al
     b4c:	75 10                	jne    b5e <matchpattern+0xd2>
    {
      return (text[0] == '\0');
     b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     b51:	0f b6 00             	movzbl (%eax),%eax
     b54:	84 c0                	test   %al,%al
     b56:	0f 94 c0             	sete   %al
     b59:	0f b6 c0             	movzbl %al,%eax
     b5c:	eb 55                	jmp    bb3 <matchpattern+0x127>
    else if (pattern[1].type == BRANCH)
    {
      return (matchpattern(pattern, text) || matchpattern(&pattern[2], text));
    }
*/
  (*matchlength)++;
     b5e:	8b 45 10             	mov    0x10(%ebp),%eax
     b61:	8b 00                	mov    (%eax),%eax
     b63:	8d 50 01             	lea    0x1(%eax),%edx
     b66:	8b 45 10             	mov    0x10(%ebp),%eax
     b69:	89 10                	mov    %edx,(%eax)
  }
  while ((text[0] != '\0') && matchone(*pattern++, *text++));
     b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b6e:	0f b6 00             	movzbl (%eax),%eax
     b71:	84 c0                	test   %al,%al
     b73:	74 31                	je     ba6 <matchpattern+0x11a>
     b75:	8b 45 0c             	mov    0xc(%ebp),%eax
     b78:	8d 50 01             	lea    0x1(%eax),%edx
     b7b:	89 55 0c             	mov    %edx,0xc(%ebp)
     b7e:	0f b6 00             	movzbl (%eax),%eax
     b81:	0f be d0             	movsbl %al,%edx
     b84:	8b 45 08             	mov    0x8(%ebp),%eax
     b87:	8d 48 08             	lea    0x8(%eax),%ecx
     b8a:	89 4d 08             	mov    %ecx,0x8(%ebp)
     b8d:	83 ec 04             	sub    $0x4,%esp
     b90:	52                   	push   %edx
     b91:	ff 70 04             	pushl  0x4(%eax)
     b94:	ff 30                	pushl  (%eax)
     b96:	e8 4f fc ff ff       	call   7ea <matchone>
     b9b:	83 c4 10             	add    $0x10,%esp
     b9e:	85 c0                	test   %eax,%eax
     ba0:	0f 85 f4 fe ff ff    	jne    a9a <matchpattern+0xe>

  *matchlength = pre;
     ba6:	8b 45 10             	mov    0x10(%ebp),%eax
     ba9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bac:	89 10                	mov    %edx,(%eax)
  return 0;
     bae:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bb3:	c9                   	leave  
     bb4:	c3                   	ret    

00000bb5 <main>:

#endif

// 主函数
int main(int argc, char **argv)
{
     bb5:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     bb9:	83 e4 f0             	and    $0xfffffff0,%esp
     bbc:	ff 71 fc             	pushl  -0x4(%ecx)
     bbf:	55                   	push   %ebp
     bc0:	89 e5                	mov    %esp,%ebp
     bc2:	51                   	push   %ecx
     bc3:	83 ec 14             	sub    $0x14,%esp
	int match_length;
	const char *string_to_search="ahem..'hello world!'..";
     bc6:	c7 45 f4 d4 17 00 00 	movl   $0x17d4,-0xc(%ebp)
	re_t pattern = re_compile("[Hh]ello");
     bcd:	68 eb 17 00 00       	push   $0x17eb
     bd2:	e8 ea f4 ff ff       	call   c1 <re_compile>
     bd7:	83 c4 04             	add    $0x4,%esp
     bda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int match_idx = re_matchp(pattern, string_to_search, &match_length);
     bdd:	83 ec 04             	sub    $0x4,%esp
     be0:	8d 45 e8             	lea    -0x18(%ebp),%eax
     be3:	50                   	push   %eax
     be4:	ff 75 f4             	pushl  -0xc(%ebp)
     be7:	ff 75 f0             	pushl  -0x10(%ebp)
     bea:	e8 39 f4 ff ff       	call   28 <re_matchp>
     bef:	83 c4 10             	add    $0x10,%esp
     bf2:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if(match_idx !=-1){
     bf5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     bf9:	74 16                	je     c11 <main+0x5c>
		printf(1,"match at idx %d, %d chars long.\n", match_idx,match_length);
     bfb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bfe:	50                   	push   %eax
     bff:	ff 75 ec             	pushl  -0x14(%ebp)
     c02:	68 f4 17 00 00       	push   $0x17f4
     c07:	6a 01                	push   $0x1
     c09:	e8 36 04 00 00       	call   1044 <printf>
     c0e:	83 c4 10             	add    $0x10,%esp
	}
	exit();
     c11:	e8 57 02 00 00       	call   e6d <exit>

00000c16 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c16:	55                   	push   %ebp
     c17:	89 e5                	mov    %esp,%ebp
     c19:	57                   	push   %edi
     c1a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c1e:	8b 55 10             	mov    0x10(%ebp),%edx
     c21:	8b 45 0c             	mov    0xc(%ebp),%eax
     c24:	89 cb                	mov    %ecx,%ebx
     c26:	89 df                	mov    %ebx,%edi
     c28:	89 d1                	mov    %edx,%ecx
     c2a:	fc                   	cld    
     c2b:	f3 aa                	rep stos %al,%es:(%edi)
     c2d:	89 ca                	mov    %ecx,%edx
     c2f:	89 fb                	mov    %edi,%ebx
     c31:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c34:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c37:	90                   	nop
     c38:	5b                   	pop    %ebx
     c39:	5f                   	pop    %edi
     c3a:	5d                   	pop    %ebp
     c3b:	c3                   	ret    

00000c3c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     c3c:	55                   	push   %ebp
     c3d:	89 e5                	mov    %esp,%ebp
     c3f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     c42:	8b 45 08             	mov    0x8(%ebp),%eax
     c45:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     c48:	90                   	nop
     c49:	8b 45 08             	mov    0x8(%ebp),%eax
     c4c:	8d 50 01             	lea    0x1(%eax),%edx
     c4f:	89 55 08             	mov    %edx,0x8(%ebp)
     c52:	8b 55 0c             	mov    0xc(%ebp),%edx
     c55:	8d 4a 01             	lea    0x1(%edx),%ecx
     c58:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     c5b:	0f b6 12             	movzbl (%edx),%edx
     c5e:	88 10                	mov    %dl,(%eax)
     c60:	0f b6 00             	movzbl (%eax),%eax
     c63:	84 c0                	test   %al,%al
     c65:	75 e2                	jne    c49 <strcpy+0xd>
    ;
  return os;
     c67:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     c6a:	c9                   	leave  
     c6b:	c3                   	ret    

00000c6c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c6c:	55                   	push   %ebp
     c6d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     c6f:	eb 08                	jmp    c79 <strcmp+0xd>
    p++, q++;
     c71:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     c75:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c79:	8b 45 08             	mov    0x8(%ebp),%eax
     c7c:	0f b6 00             	movzbl (%eax),%eax
     c7f:	84 c0                	test   %al,%al
     c81:	74 10                	je     c93 <strcmp+0x27>
     c83:	8b 45 08             	mov    0x8(%ebp),%eax
     c86:	0f b6 10             	movzbl (%eax),%edx
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	0f b6 00             	movzbl (%eax),%eax
     c8f:	38 c2                	cmp    %al,%dl
     c91:	74 de                	je     c71 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	0f b6 00             	movzbl (%eax),%eax
     c99:	0f b6 d0             	movzbl %al,%edx
     c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9f:	0f b6 00             	movzbl (%eax),%eax
     ca2:	0f b6 c0             	movzbl %al,%eax
     ca5:	29 c2                	sub    %eax,%edx
     ca7:	89 d0                	mov    %edx,%eax
}
     ca9:	5d                   	pop    %ebp
     caa:	c3                   	ret    

00000cab <strlen>:

uint
strlen(char *s)
{
     cab:	55                   	push   %ebp
     cac:	89 e5                	mov    %esp,%ebp
     cae:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     cb1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     cb8:	eb 04                	jmp    cbe <strlen+0x13>
     cba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     cbe:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cc1:	8b 45 08             	mov    0x8(%ebp),%eax
     cc4:	01 d0                	add    %edx,%eax
     cc6:	0f b6 00             	movzbl (%eax),%eax
     cc9:	84 c0                	test   %al,%al
     ccb:	75 ed                	jne    cba <strlen+0xf>
    ;
  return n;
     ccd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cd0:	c9                   	leave  
     cd1:	c3                   	ret    

00000cd2 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cd2:	55                   	push   %ebp
     cd3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     cd5:	8b 45 10             	mov    0x10(%ebp),%eax
     cd8:	50                   	push   %eax
     cd9:	ff 75 0c             	pushl  0xc(%ebp)
     cdc:	ff 75 08             	pushl  0x8(%ebp)
     cdf:	e8 32 ff ff ff       	call   c16 <stosb>
     ce4:	83 c4 0c             	add    $0xc,%esp
  return dst;
     ce7:	8b 45 08             	mov    0x8(%ebp),%eax
}
     cea:	c9                   	leave  
     ceb:	c3                   	ret    

00000cec <strchr>:

char*
strchr(const char *s, char c)
{
     cec:	55                   	push   %ebp
     ced:	89 e5                	mov    %esp,%ebp
     cef:	83 ec 04             	sub    $0x4,%esp
     cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     cf8:	eb 14                	jmp    d0e <strchr+0x22>
    if(*s == c)
     cfa:	8b 45 08             	mov    0x8(%ebp),%eax
     cfd:	0f b6 00             	movzbl (%eax),%eax
     d00:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d03:	75 05                	jne    d0a <strchr+0x1e>
      return (char*)s;
     d05:	8b 45 08             	mov    0x8(%ebp),%eax
     d08:	eb 13                	jmp    d1d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     d0a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d0e:	8b 45 08             	mov    0x8(%ebp),%eax
     d11:	0f b6 00             	movzbl (%eax),%eax
     d14:	84 c0                	test   %al,%al
     d16:	75 e2                	jne    cfa <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     d18:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d1d:	c9                   	leave  
     d1e:	c3                   	ret    

00000d1f <gets>:

char*
gets(char *buf, int max)
{
     d1f:	55                   	push   %ebp
     d20:	89 e5                	mov    %esp,%ebp
     d22:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d2c:	eb 42                	jmp    d70 <gets+0x51>
    cc = read(0, &c, 1);
     d2e:	83 ec 04             	sub    $0x4,%esp
     d31:	6a 01                	push   $0x1
     d33:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d36:	50                   	push   %eax
     d37:	6a 00                	push   $0x0
     d39:	e8 47 01 00 00       	call   e85 <read>
     d3e:	83 c4 10             	add    $0x10,%esp
     d41:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     d44:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d48:	7e 33                	jle    d7d <gets+0x5e>
      break;
    buf[i++] = c;
     d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4d:	8d 50 01             	lea    0x1(%eax),%edx
     d50:	89 55 f4             	mov    %edx,-0xc(%ebp)
     d53:	89 c2                	mov    %eax,%edx
     d55:	8b 45 08             	mov    0x8(%ebp),%eax
     d58:	01 c2                	add    %eax,%edx
     d5a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     d5e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     d60:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     d64:	3c 0a                	cmp    $0xa,%al
     d66:	74 16                	je     d7e <gets+0x5f>
     d68:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     d6c:	3c 0d                	cmp    $0xd,%al
     d6e:	74 0e                	je     d7e <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d73:	83 c0 01             	add    $0x1,%eax
     d76:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d79:	7c b3                	jl     d2e <gets+0xf>
     d7b:	eb 01                	jmp    d7e <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     d7d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     d7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d81:	8b 45 08             	mov    0x8(%ebp),%eax
     d84:	01 d0                	add    %edx,%eax
     d86:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     d89:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d8c:	c9                   	leave  
     d8d:	c3                   	ret    

00000d8e <stat>:

int
stat(char *n, struct stat *st)
{
     d8e:	55                   	push   %ebp
     d8f:	89 e5                	mov    %esp,%ebp
     d91:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d94:	83 ec 08             	sub    $0x8,%esp
     d97:	6a 00                	push   $0x0
     d99:	ff 75 08             	pushl  0x8(%ebp)
     d9c:	e8 0c 01 00 00       	call   ead <open>
     da1:	83 c4 10             	add    $0x10,%esp
     da4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     da7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dab:	79 07                	jns    db4 <stat+0x26>
    return -1;
     dad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     db2:	eb 25                	jmp    dd9 <stat+0x4b>
  r = fstat(fd, st);
     db4:	83 ec 08             	sub    $0x8,%esp
     db7:	ff 75 0c             	pushl  0xc(%ebp)
     dba:	ff 75 f4             	pushl  -0xc(%ebp)
     dbd:	e8 03 01 00 00       	call   ec5 <fstat>
     dc2:	83 c4 10             	add    $0x10,%esp
     dc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     dc8:	83 ec 0c             	sub    $0xc,%esp
     dcb:	ff 75 f4             	pushl  -0xc(%ebp)
     dce:	e8 c2 00 00 00       	call   e95 <close>
     dd3:	83 c4 10             	add    $0x10,%esp
  return r;
     dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     dd9:	c9                   	leave  
     dda:	c3                   	ret    

00000ddb <atoi>:

int
atoi(const char *s)
{
     ddb:	55                   	push   %ebp
     ddc:	89 e5                	mov    %esp,%ebp
     dde:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     de1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     de8:	eb 25                	jmp    e0f <atoi+0x34>
    n = n*10 + *s++ - '0';
     dea:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ded:	89 d0                	mov    %edx,%eax
     def:	c1 e0 02             	shl    $0x2,%eax
     df2:	01 d0                	add    %edx,%eax
     df4:	01 c0                	add    %eax,%eax
     df6:	89 c1                	mov    %eax,%ecx
     df8:	8b 45 08             	mov    0x8(%ebp),%eax
     dfb:	8d 50 01             	lea    0x1(%eax),%edx
     dfe:	89 55 08             	mov    %edx,0x8(%ebp)
     e01:	0f b6 00             	movzbl (%eax),%eax
     e04:	0f be c0             	movsbl %al,%eax
     e07:	01 c8                	add    %ecx,%eax
     e09:	83 e8 30             	sub    $0x30,%eax
     e0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e0f:	8b 45 08             	mov    0x8(%ebp),%eax
     e12:	0f b6 00             	movzbl (%eax),%eax
     e15:	3c 2f                	cmp    $0x2f,%al
     e17:	7e 0a                	jle    e23 <atoi+0x48>
     e19:	8b 45 08             	mov    0x8(%ebp),%eax
     e1c:	0f b6 00             	movzbl (%eax),%eax
     e1f:	3c 39                	cmp    $0x39,%al
     e21:	7e c7                	jle    dea <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     e23:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e26:	c9                   	leave  
     e27:	c3                   	ret    

00000e28 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e28:	55                   	push   %ebp
     e29:	89 e5                	mov    %esp,%ebp
     e2b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e2e:	8b 45 08             	mov    0x8(%ebp),%eax
     e31:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e34:	8b 45 0c             	mov    0xc(%ebp),%eax
     e37:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     e3a:	eb 17                	jmp    e53 <memmove+0x2b>
    *dst++ = *src++;
     e3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e3f:	8d 50 01             	lea    0x1(%eax),%edx
     e42:	89 55 fc             	mov    %edx,-0x4(%ebp)
     e45:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e48:	8d 4a 01             	lea    0x1(%edx),%ecx
     e4b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     e4e:	0f b6 12             	movzbl (%edx),%edx
     e51:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e53:	8b 45 10             	mov    0x10(%ebp),%eax
     e56:	8d 50 ff             	lea    -0x1(%eax),%edx
     e59:	89 55 10             	mov    %edx,0x10(%ebp)
     e5c:	85 c0                	test   %eax,%eax
     e5e:	7f dc                	jg     e3c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e63:	c9                   	leave  
     e64:	c3                   	ret    

00000e65 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e65:	b8 01 00 00 00       	mov    $0x1,%eax
     e6a:	cd 40                	int    $0x40
     e6c:	c3                   	ret    

00000e6d <exit>:
SYSCALL(exit)
     e6d:	b8 02 00 00 00       	mov    $0x2,%eax
     e72:	cd 40                	int    $0x40
     e74:	c3                   	ret    

00000e75 <wait>:
SYSCALL(wait)
     e75:	b8 03 00 00 00       	mov    $0x3,%eax
     e7a:	cd 40                	int    $0x40
     e7c:	c3                   	ret    

00000e7d <pipe>:
SYSCALL(pipe)
     e7d:	b8 04 00 00 00       	mov    $0x4,%eax
     e82:	cd 40                	int    $0x40
     e84:	c3                   	ret    

00000e85 <read>:
SYSCALL(read)
     e85:	b8 05 00 00 00       	mov    $0x5,%eax
     e8a:	cd 40                	int    $0x40
     e8c:	c3                   	ret    

00000e8d <write>:
SYSCALL(write)
     e8d:	b8 10 00 00 00       	mov    $0x10,%eax
     e92:	cd 40                	int    $0x40
     e94:	c3                   	ret    

00000e95 <close>:
SYSCALL(close)
     e95:	b8 15 00 00 00       	mov    $0x15,%eax
     e9a:	cd 40                	int    $0x40
     e9c:	c3                   	ret    

00000e9d <kill>:
SYSCALL(kill)
     e9d:	b8 06 00 00 00       	mov    $0x6,%eax
     ea2:	cd 40                	int    $0x40
     ea4:	c3                   	ret    

00000ea5 <exec>:
SYSCALL(exec)
     ea5:	b8 07 00 00 00       	mov    $0x7,%eax
     eaa:	cd 40                	int    $0x40
     eac:	c3                   	ret    

00000ead <open>:
SYSCALL(open)
     ead:	b8 0f 00 00 00       	mov    $0xf,%eax
     eb2:	cd 40                	int    $0x40
     eb4:	c3                   	ret    

00000eb5 <mknod>:
SYSCALL(mknod)
     eb5:	b8 11 00 00 00       	mov    $0x11,%eax
     eba:	cd 40                	int    $0x40
     ebc:	c3                   	ret    

00000ebd <unlink>:
SYSCALL(unlink)
     ebd:	b8 12 00 00 00       	mov    $0x12,%eax
     ec2:	cd 40                	int    $0x40
     ec4:	c3                   	ret    

00000ec5 <fstat>:
SYSCALL(fstat)
     ec5:	b8 08 00 00 00       	mov    $0x8,%eax
     eca:	cd 40                	int    $0x40
     ecc:	c3                   	ret    

00000ecd <link>:
SYSCALL(link)
     ecd:	b8 13 00 00 00       	mov    $0x13,%eax
     ed2:	cd 40                	int    $0x40
     ed4:	c3                   	ret    

00000ed5 <mkdir>:
SYSCALL(mkdir)
     ed5:	b8 14 00 00 00       	mov    $0x14,%eax
     eda:	cd 40                	int    $0x40
     edc:	c3                   	ret    

00000edd <chdir>:
SYSCALL(chdir)
     edd:	b8 09 00 00 00       	mov    $0x9,%eax
     ee2:	cd 40                	int    $0x40
     ee4:	c3                   	ret    

00000ee5 <dup>:
SYSCALL(dup)
     ee5:	b8 0a 00 00 00       	mov    $0xa,%eax
     eea:	cd 40                	int    $0x40
     eec:	c3                   	ret    

00000eed <getpid>:
SYSCALL(getpid)
     eed:	b8 0b 00 00 00       	mov    $0xb,%eax
     ef2:	cd 40                	int    $0x40
     ef4:	c3                   	ret    

00000ef5 <sbrk>:
SYSCALL(sbrk)
     ef5:	b8 0c 00 00 00       	mov    $0xc,%eax
     efa:	cd 40                	int    $0x40
     efc:	c3                   	ret    

00000efd <sleep>:
SYSCALL(sleep)
     efd:	b8 0d 00 00 00       	mov    $0xd,%eax
     f02:	cd 40                	int    $0x40
     f04:	c3                   	ret    

00000f05 <uptime>:
SYSCALL(uptime)
     f05:	b8 0e 00 00 00       	mov    $0xe,%eax
     f0a:	cd 40                	int    $0x40
     f0c:	c3                   	ret    

00000f0d <setCursorPos>:

//add
SYSCALL(setCursorPos)
     f0d:	b8 16 00 00 00       	mov    $0x16,%eax
     f12:	cd 40                	int    $0x40
     f14:	c3                   	ret    

00000f15 <copyFromTextToScreen>:
SYSCALL(copyFromTextToScreen)
     f15:	b8 17 00 00 00       	mov    $0x17,%eax
     f1a:	cd 40                	int    $0x40
     f1c:	c3                   	ret    

00000f1d <clearScreen>:
SYSCALL(clearScreen)
     f1d:	b8 18 00 00 00       	mov    $0x18,%eax
     f22:	cd 40                	int    $0x40
     f24:	c3                   	ret    

00000f25 <writeAt>:
SYSCALL(writeAt)
     f25:	b8 19 00 00 00       	mov    $0x19,%eax
     f2a:	cd 40                	int    $0x40
     f2c:	c3                   	ret    

00000f2d <setBufferFlag>:
SYSCALL(setBufferFlag)
     f2d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f32:	cd 40                	int    $0x40
     f34:	c3                   	ret    

00000f35 <setShowAtOnce>:
SYSCALL(setShowAtOnce)
     f35:	b8 1b 00 00 00       	mov    $0x1b,%eax
     f3a:	cd 40                	int    $0x40
     f3c:	c3                   	ret    

00000f3d <getCursorPos>:
SYSCALL(getCursorPos)
     f3d:	b8 1c 00 00 00       	mov    $0x1c,%eax
     f42:	cd 40                	int    $0x40
     f44:	c3                   	ret    

00000f45 <saveScreen>:
SYSCALL(saveScreen)
     f45:	b8 1d 00 00 00       	mov    $0x1d,%eax
     f4a:	cd 40                	int    $0x40
     f4c:	c3                   	ret    

00000f4d <recorverScreen>:
SYSCALL(recorverScreen)
     f4d:	b8 1e 00 00 00       	mov    $0x1e,%eax
     f52:	cd 40                	int    $0x40
     f54:	c3                   	ret    

00000f55 <colorC>:
SYSCALL(colorC)
     f55:	b8 1f 00 00 00       	mov    $0x1f,%eax
     f5a:	cd 40                	int    $0x40
     f5c:	c3                   	ret    

00000f5d <getColor>:
SYSCALL(getColor)
     f5d:	b8 20 00 00 00       	mov    $0x20,%eax
     f62:	cd 40                	int    $0x40
     f64:	c3                   	ret    

00000f65 <showC>:
     f65:	b8 21 00 00 00       	mov    $0x21,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f6d:	55                   	push   %ebp
     f6e:	89 e5                	mov    %esp,%ebp
     f70:	83 ec 18             	sub    $0x18,%esp
     f73:	8b 45 0c             	mov    0xc(%ebp),%eax
     f76:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f79:	83 ec 04             	sub    $0x4,%esp
     f7c:	6a 01                	push   $0x1
     f7e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f81:	50                   	push   %eax
     f82:	ff 75 08             	pushl  0x8(%ebp)
     f85:	e8 03 ff ff ff       	call   e8d <write>
     f8a:	83 c4 10             	add    $0x10,%esp
}
     f8d:	90                   	nop
     f8e:	c9                   	leave  
     f8f:	c3                   	ret    

00000f90 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	53                   	push   %ebx
     f94:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f97:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     f9e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     fa2:	74 17                	je     fbb <printint+0x2b>
     fa4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fa8:	79 11                	jns    fbb <printint+0x2b>
    neg = 1;
     faa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb4:	f7 d8                	neg    %eax
     fb6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fb9:	eb 06                	jmp    fc1 <printint+0x31>
  } else {
    x = xx;
     fbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     fc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     fc8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     fcb:	8d 41 01             	lea    0x1(%ecx),%eax
     fce:	89 45 f4             	mov    %eax,-0xc(%ebp)
     fd1:	8b 5d 10             	mov    0x10(%ebp),%ebx
     fd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fd7:	ba 00 00 00 00       	mov    $0x0,%edx
     fdc:	f7 f3                	div    %ebx
     fde:	89 d0                	mov    %edx,%eax
     fe0:	0f b6 80 94 1c 00 00 	movzbl 0x1c94(%eax),%eax
     fe7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     feb:	8b 5d 10             	mov    0x10(%ebp),%ebx
     fee:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ff1:	ba 00 00 00 00       	mov    $0x0,%edx
     ff6:	f7 f3                	div    %ebx
     ff8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ffb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fff:	75 c7                	jne    fc8 <printint+0x38>
  if(neg)
    1001:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1005:	74 2d                	je     1034 <printint+0xa4>
    buf[i++] = '-';
    1007:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100a:	8d 50 01             	lea    0x1(%eax),%edx
    100d:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1010:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1015:	eb 1d                	jmp    1034 <printint+0xa4>
    putc(fd, buf[i]);
    1017:	8d 55 dc             	lea    -0x24(%ebp),%edx
    101a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101d:	01 d0                	add    %edx,%eax
    101f:	0f b6 00             	movzbl (%eax),%eax
    1022:	0f be c0             	movsbl %al,%eax
    1025:	83 ec 08             	sub    $0x8,%esp
    1028:	50                   	push   %eax
    1029:	ff 75 08             	pushl  0x8(%ebp)
    102c:	e8 3c ff ff ff       	call   f6d <putc>
    1031:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1034:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1038:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    103c:	79 d9                	jns    1017 <printint+0x87>
    putc(fd, buf[i]);
}
    103e:	90                   	nop
    103f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1042:	c9                   	leave  
    1043:	c3                   	ret    

00001044 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1044:	55                   	push   %ebp
    1045:	89 e5                	mov    %esp,%ebp
    1047:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    104a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1051:	8d 45 0c             	lea    0xc(%ebp),%eax
    1054:	83 c0 04             	add    $0x4,%eax
    1057:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    105a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1061:	e9 59 01 00 00       	jmp    11bf <printf+0x17b>
    c = fmt[i] & 0xff;
    1066:	8b 55 0c             	mov    0xc(%ebp),%edx
    1069:	8b 45 f0             	mov    -0x10(%ebp),%eax
    106c:	01 d0                	add    %edx,%eax
    106e:	0f b6 00             	movzbl (%eax),%eax
    1071:	0f be c0             	movsbl %al,%eax
    1074:	25 ff 00 00 00       	and    $0xff,%eax
    1079:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    107c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1080:	75 2c                	jne    10ae <printf+0x6a>
      if(c == '%'){
    1082:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1086:	75 0c                	jne    1094 <printf+0x50>
        state = '%';
    1088:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    108f:	e9 27 01 00 00       	jmp    11bb <printf+0x177>
      } else {
        putc(fd, c);
    1094:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1097:	0f be c0             	movsbl %al,%eax
    109a:	83 ec 08             	sub    $0x8,%esp
    109d:	50                   	push   %eax
    109e:	ff 75 08             	pushl  0x8(%ebp)
    10a1:	e8 c7 fe ff ff       	call   f6d <putc>
    10a6:	83 c4 10             	add    $0x10,%esp
    10a9:	e9 0d 01 00 00       	jmp    11bb <printf+0x177>
      }
    } else if(state == '%'){
    10ae:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10b2:	0f 85 03 01 00 00    	jne    11bb <printf+0x177>
      if(c == 'd'){
    10b8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10bc:	75 1e                	jne    10dc <printf+0x98>
        printint(fd, *ap, 10, 1);
    10be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10c1:	8b 00                	mov    (%eax),%eax
    10c3:	6a 01                	push   $0x1
    10c5:	6a 0a                	push   $0xa
    10c7:	50                   	push   %eax
    10c8:	ff 75 08             	pushl  0x8(%ebp)
    10cb:	e8 c0 fe ff ff       	call   f90 <printint>
    10d0:	83 c4 10             	add    $0x10,%esp
        ap++;
    10d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10d7:	e9 d8 00 00 00       	jmp    11b4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    10dc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10e0:	74 06                	je     10e8 <printf+0xa4>
    10e2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10e6:	75 1e                	jne    1106 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    10e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10eb:	8b 00                	mov    (%eax),%eax
    10ed:	6a 00                	push   $0x0
    10ef:	6a 10                	push   $0x10
    10f1:	50                   	push   %eax
    10f2:	ff 75 08             	pushl  0x8(%ebp)
    10f5:	e8 96 fe ff ff       	call   f90 <printint>
    10fa:	83 c4 10             	add    $0x10,%esp
        ap++;
    10fd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1101:	e9 ae 00 00 00       	jmp    11b4 <printf+0x170>
      } else if(c == 's'){
    1106:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    110a:	75 43                	jne    114f <printf+0x10b>
        s = (char*)*ap;
    110c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    110f:	8b 00                	mov    (%eax),%eax
    1111:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1114:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1118:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    111c:	75 25                	jne    1143 <printf+0xff>
          s = "(null)";
    111e:	c7 45 f4 15 18 00 00 	movl   $0x1815,-0xc(%ebp)
        while(*s != 0){
    1125:	eb 1c                	jmp    1143 <printf+0xff>
          putc(fd, *s);
    1127:	8b 45 f4             	mov    -0xc(%ebp),%eax
    112a:	0f b6 00             	movzbl (%eax),%eax
    112d:	0f be c0             	movsbl %al,%eax
    1130:	83 ec 08             	sub    $0x8,%esp
    1133:	50                   	push   %eax
    1134:	ff 75 08             	pushl  0x8(%ebp)
    1137:	e8 31 fe ff ff       	call   f6d <putc>
    113c:	83 c4 10             	add    $0x10,%esp
          s++;
    113f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1143:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1146:	0f b6 00             	movzbl (%eax),%eax
    1149:	84 c0                	test   %al,%al
    114b:	75 da                	jne    1127 <printf+0xe3>
    114d:	eb 65                	jmp    11b4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    114f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1153:	75 1d                	jne    1172 <printf+0x12e>
        putc(fd, *ap);
    1155:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1158:	8b 00                	mov    (%eax),%eax
    115a:	0f be c0             	movsbl %al,%eax
    115d:	83 ec 08             	sub    $0x8,%esp
    1160:	50                   	push   %eax
    1161:	ff 75 08             	pushl  0x8(%ebp)
    1164:	e8 04 fe ff ff       	call   f6d <putc>
    1169:	83 c4 10             	add    $0x10,%esp
        ap++;
    116c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1170:	eb 42                	jmp    11b4 <printf+0x170>
      } else if(c == '%'){
    1172:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1176:	75 17                	jne    118f <printf+0x14b>
        putc(fd, c);
    1178:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    117b:	0f be c0             	movsbl %al,%eax
    117e:	83 ec 08             	sub    $0x8,%esp
    1181:	50                   	push   %eax
    1182:	ff 75 08             	pushl  0x8(%ebp)
    1185:	e8 e3 fd ff ff       	call   f6d <putc>
    118a:	83 c4 10             	add    $0x10,%esp
    118d:	eb 25                	jmp    11b4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    118f:	83 ec 08             	sub    $0x8,%esp
    1192:	6a 25                	push   $0x25
    1194:	ff 75 08             	pushl  0x8(%ebp)
    1197:	e8 d1 fd ff ff       	call   f6d <putc>
    119c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    119f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11a2:	0f be c0             	movsbl %al,%eax
    11a5:	83 ec 08             	sub    $0x8,%esp
    11a8:	50                   	push   %eax
    11a9:	ff 75 08             	pushl  0x8(%ebp)
    11ac:	e8 bc fd ff ff       	call   f6d <putc>
    11b1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11bb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11c5:	01 d0                	add    %edx,%eax
    11c7:	0f b6 00             	movzbl (%eax),%eax
    11ca:	84 c0                	test   %al,%al
    11cc:	0f 85 94 fe ff ff    	jne    1066 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    11d2:	90                   	nop
    11d3:	c9                   	leave  
    11d4:	c3                   	ret    

000011d5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11d5:	55                   	push   %ebp
    11d6:	89 e5                	mov    %esp,%ebp
    11d8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11db:	8b 45 08             	mov    0x8(%ebp),%eax
    11de:	83 e8 08             	sub    $0x8,%eax
    11e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e4:	a1 f0 1d 00 00       	mov    0x1df0,%eax
    11e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11ec:	eb 24                	jmp    1212 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11f1:	8b 00                	mov    (%eax),%eax
    11f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11f6:	77 12                	ja     120a <free+0x35>
    11f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11fe:	77 24                	ja     1224 <free+0x4f>
    1200:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1203:	8b 00                	mov    (%eax),%eax
    1205:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1208:	77 1a                	ja     1224 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    120a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    120d:	8b 00                	mov    (%eax),%eax
    120f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1212:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1215:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1218:	76 d4                	jbe    11ee <free+0x19>
    121a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    121d:	8b 00                	mov    (%eax),%eax
    121f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1222:	76 ca                	jbe    11ee <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1224:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1227:	8b 40 04             	mov    0x4(%eax),%eax
    122a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1231:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1234:	01 c2                	add    %eax,%edx
    1236:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1239:	8b 00                	mov    (%eax),%eax
    123b:	39 c2                	cmp    %eax,%edx
    123d:	75 24                	jne    1263 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    123f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1242:	8b 50 04             	mov    0x4(%eax),%edx
    1245:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1248:	8b 00                	mov    (%eax),%eax
    124a:	8b 40 04             	mov    0x4(%eax),%eax
    124d:	01 c2                	add    %eax,%edx
    124f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1252:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1255:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1258:	8b 00                	mov    (%eax),%eax
    125a:	8b 10                	mov    (%eax),%edx
    125c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125f:	89 10                	mov    %edx,(%eax)
    1261:	eb 0a                	jmp    126d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1263:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1266:	8b 10                	mov    (%eax),%edx
    1268:	8b 45 f8             	mov    -0x8(%ebp),%eax
    126b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1270:	8b 40 04             	mov    0x4(%eax),%eax
    1273:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127d:	01 d0                	add    %edx,%eax
    127f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1282:	75 20                	jne    12a4 <free+0xcf>
    p->s.size += bp->s.size;
    1284:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1287:	8b 50 04             	mov    0x4(%eax),%edx
    128a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    128d:	8b 40 04             	mov    0x4(%eax),%eax
    1290:	01 c2                	add    %eax,%edx
    1292:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1295:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1298:	8b 45 f8             	mov    -0x8(%ebp),%eax
    129b:	8b 10                	mov    (%eax),%edx
    129d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a0:	89 10                	mov    %edx,(%eax)
    12a2:	eb 08                	jmp    12ac <free+0xd7>
  } else
    p->s.ptr = bp;
    12a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12aa:	89 10                	mov    %edx,(%eax)
  freep = p;
    12ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12af:	a3 f0 1d 00 00       	mov    %eax,0x1df0
}
    12b4:	90                   	nop
    12b5:	c9                   	leave  
    12b6:	c3                   	ret    

000012b7 <morecore>:

static Header*
morecore(uint nu)
{
    12b7:	55                   	push   %ebp
    12b8:	89 e5                	mov    %esp,%ebp
    12ba:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    12c4:	77 07                	ja     12cd <morecore+0x16>
    nu = 4096;
    12c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    12cd:	8b 45 08             	mov    0x8(%ebp),%eax
    12d0:	c1 e0 03             	shl    $0x3,%eax
    12d3:	83 ec 0c             	sub    $0xc,%esp
    12d6:	50                   	push   %eax
    12d7:	e8 19 fc ff ff       	call   ef5 <sbrk>
    12dc:	83 c4 10             	add    $0x10,%esp
    12df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12e2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12e6:	75 07                	jne    12ef <morecore+0x38>
    return 0;
    12e8:	b8 00 00 00 00       	mov    $0x0,%eax
    12ed:	eb 26                	jmp    1315 <morecore+0x5e>
  hp = (Header*)p;
    12ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    12f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f8:	8b 55 08             	mov    0x8(%ebp),%edx
    12fb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    12fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1301:	83 c0 08             	add    $0x8,%eax
    1304:	83 ec 0c             	sub    $0xc,%esp
    1307:	50                   	push   %eax
    1308:	e8 c8 fe ff ff       	call   11d5 <free>
    130d:	83 c4 10             	add    $0x10,%esp
  return freep;
    1310:	a1 f0 1d 00 00       	mov    0x1df0,%eax
}
    1315:	c9                   	leave  
    1316:	c3                   	ret    

00001317 <malloc>:

void*
malloc(uint nbytes)
{
    1317:	55                   	push   %ebp
    1318:	89 e5                	mov    %esp,%ebp
    131a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	83 c0 07             	add    $0x7,%eax
    1323:	c1 e8 03             	shr    $0x3,%eax
    1326:	83 c0 01             	add    $0x1,%eax
    1329:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    132c:	a1 f0 1d 00 00       	mov    0x1df0,%eax
    1331:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1334:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1338:	75 23                	jne    135d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    133a:	c7 45 f0 e8 1d 00 00 	movl   $0x1de8,-0x10(%ebp)
    1341:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1344:	a3 f0 1d 00 00       	mov    %eax,0x1df0
    1349:	a1 f0 1d 00 00       	mov    0x1df0,%eax
    134e:	a3 e8 1d 00 00       	mov    %eax,0x1de8
    base.s.size = 0;
    1353:	c7 05 ec 1d 00 00 00 	movl   $0x0,0x1dec
    135a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    135d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1360:	8b 00                	mov    (%eax),%eax
    1362:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1365:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1368:	8b 40 04             	mov    0x4(%eax),%eax
    136b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    136e:	72 4d                	jb     13bd <malloc+0xa6>
      if(p->s.size == nunits)
    1370:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1373:	8b 40 04             	mov    0x4(%eax),%eax
    1376:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1379:	75 0c                	jne    1387 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    137b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137e:	8b 10                	mov    (%eax),%edx
    1380:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1383:	89 10                	mov    %edx,(%eax)
    1385:	eb 26                	jmp    13ad <malloc+0x96>
      else {
        p->s.size -= nunits;
    1387:	8b 45 f4             	mov    -0xc(%ebp),%eax
    138a:	8b 40 04             	mov    0x4(%eax),%eax
    138d:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1390:	89 c2                	mov    %eax,%edx
    1392:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1395:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139b:	8b 40 04             	mov    0x4(%eax),%eax
    139e:	c1 e0 03             	shl    $0x3,%eax
    13a1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13aa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b0:	a3 f0 1d 00 00       	mov    %eax,0x1df0
      return (void*)(p + 1);
    13b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b8:	83 c0 08             	add    $0x8,%eax
    13bb:	eb 3b                	jmp    13f8 <malloc+0xe1>
    }
    if(p == freep)
    13bd:	a1 f0 1d 00 00       	mov    0x1df0,%eax
    13c2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13c5:	75 1e                	jne    13e5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    13c7:	83 ec 0c             	sub    $0xc,%esp
    13ca:	ff 75 ec             	pushl  -0x14(%ebp)
    13cd:	e8 e5 fe ff ff       	call   12b7 <morecore>
    13d2:	83 c4 10             	add    $0x10,%esp
    13d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13dc:	75 07                	jne    13e5 <malloc+0xce>
        return 0;
    13de:	b8 00 00 00 00       	mov    $0x0,%eax
    13e3:	eb 13                	jmp    13f8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ee:	8b 00                	mov    (%eax),%eax
    13f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    13f3:	e9 6d ff ff ff       	jmp    1365 <malloc+0x4e>
}
    13f8:	c9                   	leave  
    13f9:	c3                   	ret    
