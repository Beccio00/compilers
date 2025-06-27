import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column

%{
    private Symbol sym(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol sym(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


n1 = \n|\r|\n\r
ws = [ \t]

uint = 0 | [1-9][0-9]*
qstring = \" ~ \"
sep = ((\+){4})\+*

tok1 = ((\!{bin})|(\?{num}{i_j}?)){end_token}

num = \-12[13]|\-1[01][13579]|\-[1-9][13579]|\-[13579]
	|[13579]|[1-9][0-9][13579]|1[0-9]{2}[13579] 
	|2[0-4][0-9][13579]|25[0-5][13579]|256[0-5]

bin = 101 | 11[01] | 1[01]{3,5} | 100[01]{4} | 101[01]{3}0 

i_j = ("ij")* | ("ji")* | ("ij")* "i" | ("ji")* "j" | "i" | "j"  

tok2 = \$ {date} {hour}? {end_token}

date = "2025" "/" (06)  "/" ( (2[4-9]) | (30) )
        | "2025" "/" (0[781])  "/" ( (0[1-9]) | (1[0-9]) | (2[0-9]) | (3[01]) )
        | "2025" "/" (1[02])  "/" ( (0[1-9]) | (1[0-9]) | (2[0-9]) | (3[01]) )
        | "2025" "/" ((09)|(11))  "/" ( (0[1-9]) | (1[0-9]) | (2[0-9]) | (3[0]) )
        | "2026" "/" (01)  "/"  ( (0[1-9]) | (1[0-9]) | (2[0-9]) | (3[01]) )          
        | "2026" "/" (02)  "/" ( (0[1-9]) | 1[0-9] | 2[0-4] )

hour = \: 05 \: (1[89] | [2-5][0-9]) | \: 0[6-9] \: [0-5][0-9] 
		| \: 10 \: ([0-3][0-9] | 4[0-7])

comment = "//".* | "/*" ~ "*/" | "<++" ~ "++>" 
end_token   = [ \t]* \;


%%

"name"			    {return sym(sym.NAME, new String(yytext()));}
"end"			    {return sym(sym.END, new String(yytext()));}
"obj"			    {return sym(sym.OBJ, new String(yytext()));}
","				    {return sym(sym.CM);}
"?"				    {return sym(sym.INTERR);}
"-?"		        {return sym(sym.INTERR_MIN);}
"("				    {return sym(sym.RO);}
")"				    {return sym(sym.RC);}
"."				    {return sym(sym.DOT);}
"-eq"    	        {return sym(sym.MIN_EQ, new String(yytext()));}
"-neq"    	        {return sym(sym.N_MIN_EQ, new String(yytext()));}
"print"			    {return sym(sym.PRINT, new String(yytext()));}
"IS_TRUE"			{return sym(sym.IS_TRUE, new String(yytext()));}
"IS_FALSE"			{return sym(sym.IS_FALSE, new String(yytext()));}
"NOT"		        {return sym(sym.NOT, new String(yytext()));}
"AND"		        {return sym(sym.AND, new String(yytext()));}
"OR"    	        {return sym(sym.OR, new String(yytext()));}


/*

":"				{return sym(sym.COL);}

"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}
"{"				{return sym(sym.BO);}
"}"				{return sym(sym.BC);}
"|"				{return sym(sym.PIPE);}
"="				{return sym(sym.EQ);}
"+"				{return sym(sym.PLUS);}
"-"				{return sym(sym.MINUS);}
"*"				{return sym(sym.STAR);}
"/"				{return sym(sym.DIV);}
"&&"			{return sym(sym.AND);}
"||"			{return sym(sym.OR);}
"!"				{return sym(sym.NOT);}
"=="			{return sym(sym.EQEQ);}
"!="			{return sym(sym.NEQ);}
">"				{return sym(sym.MAJ);}
"<"				{return sym(sym.MIN);}
">="			{return sym(sym.MAJEQ);}
"<="			{return sym(sym.MINEQ);}
"->"			{return sym(sym.ARROW);}
*/

{qstring}		{return sym(sym.QSTRING, new String(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}

/*
{id}			{return sym(sym.ID, new String(yytext()));}
{real}			{return sym(sym.REAL, new Float(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}