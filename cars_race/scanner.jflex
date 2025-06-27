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
real = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]\. | 0\.)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
all = a | A | b | B | c | C | d | D | e | E | f | F
ip = ({ipnum}\.){3}{ipnum}
ipnum = [0-9] | [1-9][0-9] | [1-9][0-9]{2} | 2([0-4][0-9] | 5[0-5])
*/

uint = 0 | [1-9][0-9]*
sep = \# {4} \#*

tok1 = ((\% {5} (\#\#)* ) | (\*\* | \?\?\?){2,3})? {odd_bounded_number}

odd_bounded_number = \- 3[531] | \- [1-2][13579] | (\-)? [13579] 
                    | [1-9][13579] | [1-2][1-9][13579] | 3[1-2][13579] 
                    | 33[13] 
tok2 = {date} (\- | \+) {date}

date =  2015\/12\/(1[2-9] | 2[0-9] | 3[0-1]) | 2016\/01\/([1-4] | [6-9]| [1-2][0-9] | 3[0-1])  
        | 2016\/02\/([1-9] | [1-2][0-9] | 29) | 2016\/03\/([1-9] | 1[0-3])    
        
tok3 = \$ {bin}

bin = 101 | 11[01] | 1[01]{3,4} | 100[01]{3} | 101000 //101-101000

comment1 = "//".*
comment2 = "/*" ~ "*/"
qstring = \" ~ \"

%%

";"				{return sym(sym.S);}
"="				{return sym(sym.EQ);}
"{"				{return sym(sym.BO);}
"}"				{return sym(sym.BC);}
"m/s"			{return sym(sym.MS, new String(yytext()));}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
"->"			{return sym(sym.ARROW);}
"|"				{return sym(sym.PIPE);}
","				{return sym(sym.CM);}
"PRINT_MIN_MAX"			{return sym(sym.PRINT_MIN_MAX, new String(yytext()));}
"PART"			{return sym(sym.PART, new String(yytext()));}
"m"			{return sym(sym.M, new String(yytext()));}
":"				{return sym(sym.COL);}


/*
"sth"			{return sym(sym.STH, new String(yytext()));}

"."				{return sym(sym.DOT);}

"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}

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

*/

{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}
{tok3} 			{return sym(sym.TOK3);}

/*
{id}			{return sym(sym.ID, new String(yytext()));}
{real}			{return sym(sym.REAL, new Float(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{qstring}		{return sym(sym.QSTRING, new String(yytext()));}
{comment1}		{;}
{comment2}		{;}

{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}