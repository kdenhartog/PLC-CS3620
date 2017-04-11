type token =
  | EOF
  | ARROW of (Gra2srs_syntax.__term_not_in_ast__)
  | BANG of (Gra2srs_syntax.__term_not_in_ast__)
  | BAR of (Gra2srs_syntax.__term_not_in_ast__)
  | COLON of (Gra2srs_syntax.__term_not_in_ast__)
  | COMMA of (Gra2srs_syntax.__term_not_in_ast__)
  | DOT of (Gra2srs_syntax.__term_not_in_ast__)
  | LEXICAL of (Gra2srs_syntax.__term_not_in_ast__)
  | LP of (Gra2srs_syntax.__term_not_in_ast__)
  | LS of (Gra2srs_syntax.__term_not_in_ast__)
  | MINUS of (Gra2srs_syntax.__term_not_in_ast__)
  | PLUS of (Gra2srs_syntax.__term_not_in_ast__)
  | QMARK of (Gra2srs_syntax.__term_not_in_ast__)
  | RP of (Gra2srs_syntax.__term_not_in_ast__)
  | RS of (Gra2srs_syntax.__term_not_in_ast__)
  | RULES of (Gra2srs_syntax.__term_not_in_ast__)
  | STAR of (Gra2srs_syntax.__term_not_in_ast__)
  | START of (Gra2srs_syntax.__term_not_in_ast__)
  | SYNTACTIC of (Gra2srs_syntax.__term_not_in_ast__)
  | THICKARROW of (Gra2srs_syntax.__term_not_in_ast__)
  | TILDE of (Gra2srs_syntax.__term_not_in_ast__)
  | VARS of (Gra2srs_syntax.__term_not_in_ast__)
  | WHITESPACE of (Gra2srs_syntax.__term_not_in_ast__)
  | ID of (Gra2srs_syntax.__terminal__)
  | STRING_LIT of (Gra2srs_syntax.__terminal__)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Gra2srs_syntax.grammar option
