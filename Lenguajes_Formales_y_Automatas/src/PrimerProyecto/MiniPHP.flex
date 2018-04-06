package PrimerProyecto;
import static PrimerProyecto.Token.*;
%%
%class MiniPHP
%type Token
//------------------------------------------------------------------------------
//-----------------------------------Conjuntos----------------------------------
Comentario = "/""*" ({Espacio}*|{Ti_Entero}|{Ti_Reales}|{ASCII}|{Intervalos}|\"|\')* "*""/"

Espacio     =   [" "|\n|\r|\t]
                
Intervalos = [{]|[}]|[(]|[)]|"["|"]"
Asignacion = "=>" | "=" | "!"
ASCII = [A-Za-z_.!#$%&=\?¡¿@´¨\*\+<>,;.:-]
ASCII2 = [_!#$%&\?¡¿@´¨\.]

//------------------------------------------------------------------------------
//-----------------------------Palabras Reservadas------------------------------
P_Reservadas =  "<?php" | "?>" | 
                "__halt_compiler" | "&" |
                "abstract" | "arraytoselect" | "array_pop" |"array" | "as" | 
                "callable" | "catch" | "class" | "clone" | "const" |
                "declare" | "default" | "die" | 
                "echo" | "else" | "empty" | "enddeclare" | "endswitch" | "eval" | "exit" | "extends" | 
                "final" | "finally" | "function" | 
                "global" | "goto" |
                "implements" | "instanceof" | "insteadof" | "interface" | "isset" | 
                "list" |
                "namespace" | "new" | 
                "or" | "object" |
                "print" | "private" | "protected" | "public" |
                "require_once" | "require" |
                "static" | "set_element" | "setcookie" | "simplexmlelement" | "string" |
                "time" | "throw" | "trait" | "try" | "trim" |
                "unset" | "use" | 
                "var" | 
                "yield"
Variables = [$]([A-Za-z])+[_]*({Ti_Entero}|{Ti_Reales})*

DataBase =  "mysql_query" {Espacio}* [(] {Espacio}* ({Cadena}|{Variables}) {Espacio}* [)] [;] |
            "mysql_query" {Espacio}* [(] {Espacio}* ({Cadena}|{Variables}) {Espacio}* [)] [;] |
            "mysql_fetch_assoc" | "mysql_error" | "mysql_real_escape_string" | "mysql_connect"
//------------------------------------------------------------------------------
//----------------------------------Operadores----------------------------------
//Aritmeticos-------------------------------------------------------------------
Operadores_Aritmeticos = "+" | "-" | "*" | "/" 
//Logicos-----------------------------------------------------------------------
Operadores_Logicos =  "==" | "!=" | "<" | ">" | ">=" | "<=" | "||" | "and" | "or" | "&&" | "xor"
//------------------------------------------------------------------------------
//------------------------------------Tipos-------------------------------------
//Logicos-----------------------------------------------------------------------
Ti_Logicos  =   "bool"
//Enteros-----------------------------------------------------------------------
Ti_Entero    =  ("+"|"-")? [0-9]+ |
                "int" 
//Reales------------------------------------------------------------------------
Ti_Reales    =  ("+"|"-")?([1-9][0-9]* "." [0-9]*) | 
                ("."[0-9]+) | 
                (0 "." [0-9]*) 
//Cadena------------------------------------------------------------------------
Cadena      =   (\") ({Espacio}*|{Ti_Entero}|{Ti_Reales}|{ASCII}|{Intervalos})* (\") |
                (\') ({Espacio}*|{Ti_Entero}|{Ti_Reales}|{ASCII}|{Intervalos})* (\') 
Cadena2     =   [A-Za-z_]*
//------------------------------------------------------------------------------
//----------------------------------Funciones-----------------------------------
//------------------------------------------------------------------------------
Funciones   =   "public function" {Espacio}* [A-Za-z]+ |
                "function" {Espacio}* [A-Za-z]+
//------------------------------------------------------------------------------
//---------------------------Estructuras de control-----------------------------
//If----------------------------------------------------------------------------
If =   "elseif" | "endif" | "if"
//While do----------------------------------------------------------------------
While = "endwhile" | "while" | "do"  
//For---------------------------------------------------------------------------
For = "endfor" | "for"
//Foreach-----------------------------------------------------------------------
Foreach = "endforeach" | "foreach"
//Switch------------------------------------------------------------------------
Switch = "switch" | "case" | "break"
//Include-----------------------------------------------------------------------
Include = "include_once" | "include"
//continue----------------------------------------------------------------------
Continue = "continue"
//return------------------------------------------------------------------------
Return = "return"
//------------------------------------------------------------------------------
//---------------------------Variables predefinidas-----------------------------
//------------------------------------------------------------------------------
Var_Predefinicas=   "$_COOKIE" | "$_ENV" | "$_FILES" | "$_GET" | "$_POST" | "$_REQUEST" | "$_SERVER" | "$_SESSION" | 
                    "$argc" | "$argv" | "$GLOBALS" | "$HTTP_RAW_POST_DATA" | "$http_response_header" | "$php_errormsg" |
                    "Superglobals"

%{
    public String Texto;
%}
%%
//------------------------------------------------------------------------------
//------------------------------------Ignorar-----------------------------------
" " {/*Ignore*/}
"\t" {/*Ignore*/}
"\n" {/*Ignore*/}
"\r" {/*Ignore*/}
"//".* {/*Ignore*/}
{Comentario} {/*Ignore*/}
//------------------------------------------------------------------------------
//-----------------------------------Retornos-----------------------------------
(","|";"|".") {Texto = yytext(); return SEPARACION;}
{Var_Predefinicas} {Texto = yytext(); return V_PREDEFINIDAS;}

{P_Reservadas} {Texto = yytext(); return P_RESERVADA;}
{DataBase} {Texto = yytext(); return P_RESERVADA_DB;}
{Variables} {Texto = yytext(); return VARIABLE;}

{Operadores_Aritmeticos} {Texto = yytext(); return OP_ARITMETICO;}
{Operadores_Logicos} {Texto = yytext(); return OP_LOGICOS;}

{Ti_Logicos} {Texto = yytext(); return TI_LOGICO;}
{Ti_Entero} {Texto = yytext(); return TI_ENTERO;}
{Ti_Reales} {Texto = yytext(); return TI_REALES;}
{Cadena} {Texto = yytext(); return CADENA;}

{Funciones} {Texto = yytext(); return FUNCIONES;}

{If} {Texto = yytext(); return IF;}
{While} {Texto = yytext(); return WHILE;}
{Foreach} {Texto = yytext(); return FOREACH;}
{For} {Texto = yytext(); return FOR;}
{Switch} {Texto = yytext(); return SWITCH;}
{Include} {Texto = yytext(); return INCLUDE;}
{Continue} {Texto = yytext(); return CONTINUE;}
{Return} {Texto = yytext(); return RETURN;}

{Intervalos} {Texto = yytext(); return INTERVALO;}

{Asignacion} {Texto = yytext(); return ASIGNACION;}

{ASCII2} {Texto = yytext(); return SIGNO;}

{Cadena2} {Texto = yytext(); return ERROR;} 
. {Texto = yytext(); return ERROR;}