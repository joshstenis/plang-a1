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

SIGN [-+]
DIGIT [0-9] 
ALPHA [a-zA-Z]
KEYWORD ["integer""float""foreach""begin""end""repeat""until""while""declare""if""then""print"]

%%

\/\/.*$   
[ \t]+						
[\n]+							
{SIGN}*{DIGIT}+"."{DIGIT}+$		{
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
"integer"			return K_INTEGER;
"float"				return K_FLOAT;
"foreach"			return K_FOREACH;
"begin"				return K_BEGIN;
"end"				return K_END;
"repeat"			return K_REPEAT;
"until"				return K_UNTIL;
"then"				return K_THEN;
"while"				return K_WHILE;
"declare"			return K_DECLARE;
"if"				return K_IF;
"print"				return K_PRINT;
{DIGIT}+				{ 
							return L_INTEGER;
						}
"@"{ALPHA}+$	        {
						return T_ID;
					}
<<EOF>>						{ return T_EOF ; }
.									{ return yytext[0]; }

%%
