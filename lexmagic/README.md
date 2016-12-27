# build and test sequence:

```
$antlr4 CymbolLexer.g4
$antlr4 CymbolParser.g4
$ grun Cymbol file -tokens -tree 
int i = 3; // testing
EOF
```
