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

n1 = \r\n|\n|\r
ws = [ \t]

/*
id = [a-zA-Z_][a-zA-Z0-9_]*
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
all = a | A | b | B | c | C | d | D | e | E | f | F
ip = ({ipnum}\.){3}{ipnum}
ipnum = [0-9] | [1-9][0-9] | [1-9][0-9]{2} | 2([0-4][0-9] | 5[0-5])
*/
date=2022\/11\/(1[5-9]|2[0-9]|30)|2022\/12\/(0[1-9]|1[012456789]|2[0-9]|3[0-1]) 
      |2023\/01\/([0-2][0-9]|3[0-1])|2023\/02\/(0[1-9]|1[012356789]|2[0-8]) 
      |2023\/03\/(0[1-9]|[1-2][0-9]|30) //2022/11/15 fino a 2023/03/30 escludendo 2022/12/13 e 2023/02/14


uint = 0 | [1-9][0-9]*
qstring = \" ~ \"

real =[0-9]+\.[0-9]{2}
hexchar =[0-9a-fA-F]
sep =\${4}(\$\$)*

hexnum =({hexchar}{2,3}|{hexchar}{6})

tok1 = ((\%\*){4,17} | (\*\%){4,17} | (\%\%){4,17})
    ({hexnum} \+ {hexnum} \+ {hexnum} 
    |{hexnum} \+ {hexnum} \+ {hexnum} \+ {hexnum} \+ {hexnum} \+ {hexnum})\;

tok2 ={date}(\$|\%){date}(\$|\%){date}(\-{bin})?\;

//1011->10111
bin=1011|11[01]{2}|10[01]{3}

comment = "(*-" ~ "-*)"

%%

";"				{return sym(sym.S);}
":"				{return sym(sym.COL);}
"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}
","				{return sym(sym.CM);}
"EURO/kg"	    {return sym(sym.EURO, new String(yytext()));}
"kg"	    {return sym(sym.KG, new String(yytext()));}
"."				{return sym(sym.DOT);}

/*
"sth"			{return sym(sym.STH, new String(yytext()));}


"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
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
{qstring}		{return sym(sym.QSTRING, new String(yytext()));}
{real}			{return sym(sym.REAL, new Float(yytext()));}
{uint}			{return sym(sym.UINT, new Integer(yytext()));}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}

/*
{id}			{return sym(sym.ID, new String(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}