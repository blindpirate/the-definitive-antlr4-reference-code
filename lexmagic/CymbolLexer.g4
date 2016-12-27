lexer grammar CymbolLexer;

channels{WHITESPACE,COMMENTS}

PLUS:      '+';
MINUS:     '-';
STAR:      '*';
NOT:       '!';
ASSIGN:    '=';
EQUAL:     '==';
FLOAT_T:   'float';
INT_T:     'int';
VOID_T:    'void';
IF:        'if';
THEN:      'then';
ELSE:      'else';
RETURN:    'return';
SEMI:      ';';
LEFT_SQU:  '[';
RIGHT_SQU: ']';
LEFT_PAR:  '(';
RIGHT_PAR: ')';
COMMA:     ',';
LEFT_CUR:  '{';
RIGHT_CUR: '}';

ID  :   LETTER (LETTER | [0-9])* ;

fragment
LETTER : [a-zA-Z] ;

INT :   [0-9]+ ;

WS  :   [ \t\n\r]+ -> channel(WHITESPACE) ;  // channel(1)

SL_COMMENT
    :   '//' .*? '\n' -> channel(COMMENTS)   // channel(2)
    ;

