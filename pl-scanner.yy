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
						return keywords(yytext);
					}
{DIGIT}+				{ 
							return L_INTEGER;
						}
[(\-{DIGIT}\.{DIGIT}$)(\+{DIGIT}\.{DIGIT}$)({DIGIT}\.{DIGIT}$)]		{
							return L_FLOAT;
						}
\@{ALPHA}+$	        {
						return T_ID;
					}
<<EOF>>						{ return T_EOF ; }
.									{ return yytext[0]; }



%%

int keywords(string s) {
	switch(s) {
		case "integer": return K_INTEGER; break;
		case "float": return K_FLOAT; break;
		case "foreach": return K_FOREACH; break;
		case "begin": return K_BEGIN; break;
		case "end": return K_END; break;
		case "repeat": return K_REPEAT; break;
		case "until": return K_UNTIL; break;
		case "while": return K_WHILE; break;
		case "declare": return K_DECLARE; break;
		case "if": return K_IF; break;
		case "then": return K_THEN; break;
		case "print": return K_PRINT; break;
		default: break;
	}
}
