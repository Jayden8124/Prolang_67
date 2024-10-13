// User code
import java.util.*;

%%
%class Lexer
%public
%unicode
%line
%column
%standalone

%{
    int tokenIndex = 0;
    HashMap<String, Integer> symbolTable = new HashMap<String, Integer>();

    static final int IDENTIFIER = 100;
    static final int KEYWORD    = 101;
    static final int OPERATOR   = 102;
    static final int INTEGER    = 103;
    static final int STRING     = 104;
    static final int PAREN      = 105;
    static final int SEMICOLON  = 106;
%}

OPERATOR     = "+"|"-"|">="|"<="|"=="|"++"|"--"|"*"|"/"|"="|">"|"<"
PAREN        = "("|")"
SEMICOLON    = ";"
KEYWORD      = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
IDENTIFIER   = {LETTER}({LETTER}|{DIGIT})*
LETTER       = [a-zA-Z]
STRING       = \"([^\"\\n]|\\.)*\"

COMMENT      = "/*"([^*]|"*"[^/])*"*/"
COMMENT_LINE = "//".*

WHITESPACE   = [ \t]+
NEWLINE      = (\r\n|\n|\r)

DECIMAL      = {DIGIT}+"."{DIGIT}+  
INTEGER      = {DIGIT}+
LEADING_ZERO = 0{DIGIT}+            
DIGIT        = [0-9]

%%
{WHITESPACE}   { /* ไม่ทำอะไร */ }

{COMMENT}      { /* ไม่ทำอะไร */ }

{COMMENT_LINE} { /* ไม่ทำอะไร */ }

{NEWLINE}      { /* ไม่ทำอะไร */ }

{DECIMAL}      { 
                   System.out.println("Error: Invalid decimal number \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }

{LEADING_ZERO} { 
                   System.out.println("Error: Invalid leading zero in number \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }

{INTEGER}      {
                   System.out.println("integer: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + INTEGER);
                   tokenIndex++;
               }

{OPERATOR}     {
                   System.out.println("operator: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + OPERATOR);
                   tokenIndex++;
               }

{PAREN}        {
                   System.out.println("parenthesis: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + PAREN);
                   tokenIndex++;
               }

{SEMICOLON}    {
                   System.out.println("semicolon: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + SEMICOLON);
                   tokenIndex++;
               }

{KEYWORD}      {
                   System.out.println("keyword: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + KEYWORD);
                   tokenIndex++;
               }

{STRING}       {
                   System.out.println("string: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + tokenIndex + " tokenType = " + STRING);
                   tokenIndex++;
               }

{IDENTIFIER}   {
                   Integer index = symbolTable.get(yytext());
                   if (index != null) {
                       System.out.println("identifier \"" + yytext() + "\" already in symbol table --> Token(" + yytext() + ") tokenIndex = " + index + " tokenType = " + IDENTIFIER);
                   } else {
                       index = tokenIndex++;
                       symbolTable.put(yytext(), index);
                       System.out.println("new identifier: " + yytext() + " --> Token(" + yytext() + ") tokenIndex = " + index + " tokenType = " + IDENTIFIER);
                   }
               }

{DIGIT}+{LETTER}+  {
                   System.out.println("Error: Invalid input \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }

.              {
                   System.out.println("Error: Invalid input \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }
