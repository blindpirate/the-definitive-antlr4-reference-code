/** Grammar from tour chapter augmented with actions */
// https://pragprog.com/titles/tpantlr2/errata?utf8=%E2%9C%93&what_to_show=1881
grammar Expr;

@header {
package tools;
import java.util.*;
}

@parser::members {
    /** "memory" for our calculator; variable/value pairs go here */
    Map<String, Integer> memory = new HashMap<String, Integer>();

    int eval(int left, int op, int right) {
        switch ( op ) {
            case MUL : return left * right;
            case DIV : return left / right;
            case ADD : return left + right;
            case SUB : return left - right;
        }
        return 0;
    }
}

stat:   e NEWLINE           {System.out.println($e.v);}
    |   ID '=' e NEWLINE    {memory.put($ID.text, $e.v);}
    |   NEWLINE                   
    ;

e returns [int v]
    : a=e op=('*'|'/') b=e  {$v = eval($a.v, $op.type, $b.v);}
    | a=e op=('+'|'-') b=e  {$v = eval($a.v, $op.type, $b.v);}  
    | INT                   {$v = $INT.int;}    
    | ID
      {
      String id = $ID.text;
      $v = memory.containsKey(id) ? memory.get(id) : 0;
      }
    | '(' a=e ')'             {$v = $a.v;}       
    ; 

MUL : '*' ;
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;

ID  :   [a-zA-Z]+ ;      // match identifiers
INT :   [0-9]+ ;         // match integers
NEWLINE:'\r'? '\n' ;     // return newlines to parser (is end-statement signal)
WS  :   [ \t]+ -> skip ; // toss out whitespace
