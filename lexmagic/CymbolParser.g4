/** Simple statically-typed programming language with functions and variables
 *  taken from "Language Implementation Patterns" book.
 *  
 *  Customized token channels should be declared with channels block, see https://github.com/antlr/antlr4/blob/master/doc/lexer-rules.md for more details.
 *  However, in 4.6, it is not permitted to place channels in combined grammar, hence we must extract them to a lexer grammar, see https://github.com/antlr/antlr4/issues/1555 for more details.
 */
parser grammar  CymbolParser;

options {tokenVocab=CymbolLexer;}

file:   (functionDecl | varDecl)+ ;

varDecl
    :   type ID (ASSIGN expr)? SEMI 
    ;
type:   FLOAT_T | INT_T | VOID_T ; // user-defined types

functionDecl
    :   type ID LEFT_PAR formalParameters? RIGHT_PAR block // "void f(int x) {...}"
    ;

formalParameters
    :   formalParameter (COMMA formalParameter)*
    ;
formalParameter
    :   type ID
    ;

block:  LEFT_CUR stat* RIGHT_CUR ;   // possibly empty statement block

stat:   block
    |   varDecl
    |   IF expr THEN stat (ELSE stat)?
    |   RETURN expr? SEMI 
    |   expr ASSIGN expr SEMI // assignment
    |   expr SEMI          // func call
    ;

expr:   ID LEFT_PAR exprList? RIGHT_PAR    // func call like f(), f(x), f(1,2)
    |   expr LEFT_SQU expr RIGHT_SQU       // array index like a[i], a[i][j]
    |   MINUS expr                // unary minus
    |   NOT expr                // boolean not
    |   expr STAR expr
    |   expr (PLUS|MINUS) expr
    |   expr EQUAL expr          // equality comparison (lowest priority op)
    |   ID                      // variable reference
    |   INT
    |   LEFT_PAR expr RIGHT_PAR 
    ;

exprList : expr (COMMA expr)* ;   // arg list

