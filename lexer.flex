// User code
import java.util.*;

%%
// import & definition (Option and Declaration) when generate it's will exclude syntax in java 
%class Lexer
%public
%unicode
%line
%column
%standalone

%{
    HashSet<String> symbolTable = new HashSet<String>();
%}

OPERATOR     = "+"|"-"|">="|"<="|"=="|"++"|"--"|"*"|"/"|"="|">"|"<"
PAREN        = "("|")"
SEMICOLON    = ";"
KEYWORD      = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
IDENTIFIER   = {LETTER}({LETTER}|{DIGIT})*
LETTER       = [a-zA-Z]
STRING       = \"([^\"\\n]|\\.)*\"

// Comment
COMMENT      = "/*"([^*]|"*"[^/])*"*/"
COMMENT_LINE = "//".*

// Space
WHITESPACE   = [ \t]+
NEWLINE      = (\r\n|\n|\r)

// Number
DECIMAL      = {DIGIT}+"."{DIGIT}+  
INTEGER      = {DIGIT}+
LEADING_ZERO = 0{DIGIT}+            
DIGIT        = [0-9]

%%
// expression1   { some action }  --> Lexical Rules (Action)

{WHITESPACE}   { /* Nothing */ }

{COMMENT}      { /* Nothing */ }

{COMMENT_LINE} { /* Nothing */ }

{NEWLINE}      { /* Nothing */ }

// Input Floating
{DECIMAL}      { 
                   System.out.println("Error: Invalid decimal number \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }

// Leading Zero (Integers)
{LEADING_ZERO} { 
                   System.out.println("Error: Invalid leading zero in number \"" + yytext() + "\" at line " + yyline + " column " + yycolumn);
                   System.exit(1);
               }

{DIGIT}        { System.out.println("integers: " + yytext());}

{OPERATOR}     { System.out.println("operator: " + yytext()); }

{PAREN}        { System.out.println("parenthesis: " + yytext()); }

{SEMICOLON}    { System.out.println("semicolon: " + yytext()); }

{KEYWORD}      { System.out.println("keyword: " + yytext()); }

{INTEGER}      { System.out.println("integer: " + yytext()); }

{STRING}       { System.out.println("string: " + yytext()); }

{IDENTIFIER}   {
                  if (symbolTable.contains(yytext())) {
                      System.out.println("identifier \"" + yytext() + "\" already in symbol table");
                  } else {
                      symbolTable.add(yytext());
                      System.out.println("new identifier: " + yytext());
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