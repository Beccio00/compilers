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
uint = 0 | [1-9][0-9]*
id = [a-zA-Z_][a-zA-Z0-9_]*
hexnum = [0-9a-fA-F]
real = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]\. | 0\.)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
qstring = \" ~ \"
all = a | A | b | B | c | C | d | D | e | E | f | F
*/


sep = "***"

tok1 = {hexnum} \* ({char}{char})* {char}{5} \- ((\*\*)* (\*){4} | "Y""X"*"Y" )? \; 

hexnum = 27[AaBbCcFf] | [3-9a-fA-F][0-9a-fA-F]{2} | 0[0-9a-fA-F]{3} | 1[01][0-9a-fA-F]{2} | 12[0-9aA]{2} | 12b[0-3]

char = a | A | b | B | c | C | d | D | e | E | f | F


tok2 = {ip} \- {date} \;

ip = ({ipnum}\.){3}{ipnum}
ipnum = [0-9] | [1-9][0-9] | [1-9][0-9]{2} | 2([0-4][0-9] | 5[0-5])

date = ([0-2][5-9] | 3[01])"/" 10 "/" 2023 | ([0-2][0-9] | 30) "/" 11 "/" 



tok2 =

tok3 =

comment = "//".* | "/*" ~ "*/" | "{{" ~ "}}"

%%

";"				{return sym(sym.S);}

/*
"sth"			{return sym(sym.STH, new String(yytext()));}

"."				{return sym(sym.DOT);}
","				{return sym(sym.CM);}

":"				{return sym(sym.COL);}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
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

{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}
{tok3} 			{return sym(sym.TOK3);}

/*
{qstring}		{return sym(sym.QSTRING, new String(yytext()));}
{id}			{return sym(sym.ID, new String(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{real}			{return sym(sym.REAL, new Float(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}