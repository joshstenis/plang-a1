%{ 
//name, ID; 

#include "tokens.h"
# undef yywrap
# define yywrap() 1



#undef YY_DECL
#define YY_DECL int yylex()
YY_DECL;


// Code run each time a pattern is matched.
#undef  YY_USER_ACTION  
# define YY_USER_ACTION  {}



%}

%option yylineno
%option noyywrap 

DIGIT [0-9] 
ALPHA [a-zA-Z]
KEYWORD ["integer""float""foreach""begin""end""repeat""until""while""declare""if""then""print"]

%%

\/\/.*$   
[ \t]+						
[\n]+							
"+"{DIGIT}+"."{DIGIT}$|"-"{DIGIT}+"."{DIGIT}$|{DIGIT}+"."{DIGIT}$		{
																			return L_FLOAT;
																		}
"+"					{
						return OP_ADD;
					}
"-"					{
						return OP_SUB;
					}
"*"					{
						return OP_MUL;
					}
"/"					{
						return OP_DIV;
					}
";"					{ 
						return ';'; 
    	            }
"="					{ 
						return OP_ASSIGN; 
    	            }
"+="				{
						return OP_ADDINC;
					}
"++"				{
						return OP_PLUSPLUS;
					}
"<="				{
						return OP_LEQ;
					}
">="				{
						return OP_GEQ;
					}
"=="				{
						return OP_EQ;
					}
"~="				{
						return OP_DIFF;
					}
"<"					{
						return OP_LT;
					}
">"					{
						return OP_GT;
					}

"main"				{ 
						return K_MAIN; 
	                }
{KEYWORD}			{
						if(strcmp(yytext, "integer") == 0) return K_INTEGER;
						else if(strcmp(yytext, "float") == 0) return K_FLOAT;
						else if(strcmp(yytext, "foreach") == 0) return K_FOREACH;
						else if(strcmp(yytext, "begin") == 0) return K_BEGIN;
						else if(strcmp(yytext, "end") == 0) return K_END;
						else if(strcmp(yytext, "repeat") == 0) return K_REPEAT;
						else if(strcmp(yytext, "until") == 0) return K_UNTIL;
						else if(strcmp(yytext, "while") == 0) return K_WHILE;
						else if(strcmp(yytext, "declare") == 0) return K_DECLARE;
						else if(strcmp(yytext, "if") == 0) return K_IF;
						else if(strcmp(yytext, "then") == 0) return K_THEN;
						else if(strcmp(yytext, "print") == 0) return K_PRINT;
					}
{DIGIT}+				{ 
							return L_INTEGER;
						}
\@{ALPHA}+$	        {
						return T_ID;
					}
<<EOF>>						{ return T_EOF ; }
.									{ return yytext[0]; }



%%