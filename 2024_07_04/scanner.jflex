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

/*
id = [a-zA-Z_][a-zA-Z0-9_]*
hexnum = [0-9a-fA-F]
uint = 0 | [1-9][0-9]*
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
all = a | A | b | B | c | C | d | D | e | E | f | F
ip = ({ipnum}\.){3}{ipnum}
ipnum = [0-9] | [1-9][0-9] | [1-9][0-9]{2} | 2([0-4][0-9] | 5[0-5])
*/
qstring = \" ~ \"
ureal = ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]\. | 0\.)

sep = \*{4} (\*\*)*

tok1 = (A\:\! ([01]{4} | [01]{6} | [01]{11})) 
    | (B\:\@) {hour}

hour = 07\:((21\:(1[3-9] | [2-5][0-9])) | (2[2-9] | [3-5][0-9])\:[0-5][0-9]) 
    | (0[89] | 1[0-8])\:[0-5][0-9]\:[0-5][0-9]
    | 19\:((([0-3][0-9] | 4[0-4])\:[0-5][0-9]) | 45\:([0-4][0-9] | 5[0-4])) //07:21:13 - 19:45:54

tok2 = C\: ({realnum} | "value") (\@ |\!){2,10} (([a-z][a-z])*[a-z] | ([A-Z][A-Z])*) 

realnum = 10\.(5[3-9] | [6-9][0-9]) | 1[12]\.[0-9][0-9] | 13 \. ([0-6][0-9] | 7[0-4])

comment = "[++" ~ "++]"

%%

";"				{return sym(sym.S);}
//"="				{return sym(sym.EQ);}
"+"				{return sym(sym.PLUS);}
"-"				{return sym(sym.MINUS);}
"*"				{return sym(sym.STAR);}
"/"				{return sym(sym.DIV);}
","				{return sym(sym.CM);}
":"				{return sym(sym.COL);}
"POINT"			{return sym(sym.POINT, new String(yytext()));}
"LOW"			{return sym(sym.LOW, new String(yytext()));}
"MEDIUM"		{return sym(sym.MEDIUM, new String(yytext()));}
"HIGH"			{return sym(sym.HIGH, new String(yytext()));}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}

/*
"sth"			{return sym(sym.STH, new String(yytext()));}

"."				{return sym(sym.DOT);}
"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}
"{"				{return sym(sym.BO);}
"}"				{return sym(sym.BC);}
"|"				{return sym(sym.PIPE);}
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

{ureal}			{return sym(sym.REAL, new Float(yytext()));}
{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}
{qstring}		{return sym(sym.QSTRING, new String(yytext()));}

/*
{id}			{return sym(sym.ID, new String(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}