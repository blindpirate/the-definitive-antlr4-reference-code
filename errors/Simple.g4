/**
From antlr 4.3 on actions accessing text attributes in the form of $rule.text need to be changed to $ctx.getText();
*/
grammar Simple;

prog:   classDef+ ; // match one or more class definitions

classDef
    :   'class' ID '{' member+ '}' // a class has one or more members
        {System.out.println("class "+$ID.text);}
    ;

member
    :   'int' ID ';'                       // field definition
        {System.out.println("var "+$ID.text);}
    |   'int' f=ID '(' ID ')' '{' stat '}' // method definition
        {System.out.println("method: "+$f.text);}
    ;

stat:   expr ';'
        {System.out.println("found expr: "+$ctx.getText());}
    |   ID '=' expr ';'
        {System.out.println("found assign: "+$ctx.getText());}
    ;

expr:   INT 
    |   ID '(' INT ')'
    ;

INT :   [0-9]+ ;
ID  :   [a-zA-Z]+ ;
WS  :   [ \t\r\n]+ -> skip ;
