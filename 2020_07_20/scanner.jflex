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



real = ("+"|"-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]\. | 0\.)
double = (([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?
qstring = \" ~ \"
all = a | A | b | B | c | C | d | D | e | E | f | F
*/

sep = "$$"

tok1 = ((a|b|c){7}((a|b|c){2})*)\#({hexnum})?
hexnum = \-(5[02468aAcC] | [1-4][02468aAcCeE] | [2468aAcCeE]) | [2468aAcCeE] | [1-9a-fA-F][2468aAcCeE] | [1-9][0-9a-fA-F][2468aAcCeE] | [aA]([0-9aA][2468aAcCeE] | [bB][0-6])
 //-5C -> AB6
tok2 = {hour}\:{bin}
hour = 07\:((13\:(2[4-9] | [3-5][0-9])) | (1[4-9] | [2-5][0-9])\:[0-5][0-9]) 
    | (0[89] | 1[0-6])\:[0-5][0-9]\:[0-5][0-9]
    | 17\:((([0-2][0-9] | 3[0-6])\:[0-5][0-9]) | 37\:([0-3][0-9] | 4[0-3]))
bin = 101 | 11[01] | 1[01]{3} | 10[01]{3} | 1100[01] | 11010 //101-1101

id = [a-zA-Z_][a-zA-Z0-9_]*

uint = 0 | [1-9][0-9]*

comment = "(++" ~ "++)"

%%

";"				{return sym(sym.S);}
"="				{return sym(sym.EQ);}
"{"				{return sym(sym.BO);}
"}"				{return sym(sym.BC);}
"("				{return sym(sym.RO);}
")"				{return sym(sym.RC);}
"+"				{return sym(sym.PLUS);}
"-"				{return sym(sym.MINUS);}
"*"				{return sym(sym.STAR);}
"/"				{return sym(sym.DIV);}

"print"         {return sym(sym.PRINT, new String(yytext()));}
"compare"       {return sym(sym.COMPARE, new String(yytext()));}
"with"          {return sym(sym.WITH, new String(yytext()));}
"end"           {return sym(sym.END, new String(yytext()));}

/*
"."				{return sym(sym.DOT);}
","				{return sym(sym.CM);}

":"				{return sym(sym.COL);}

"["				{return sym(sym.SO);}
"]"				{return sym(sym.SC);}

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

{sep} 			{return sym(sym.SEP);}
{tok1} 			{return sym(sym.TOK1);}
{tok2} 			{return sym(sym.TOK2);}

/*
{qstring}		{return sym(sym.QSTRING, new String(yytext()));}


{real}			{return sym(sym.REAL, new Float(yytext()));}
{double}		{return sym(sym.DOUBLE, new Double(yytext()));}
*/

{id}			{return sym(sym.ID, new String(yytext()));}

{uint}			{return sym(sym.UINT, new Integer(yytext()));}

{comment}		{;}
{n1}|{ws}       {;}

.               {System.out.println("SCANNER ERROR: " + yytext());}