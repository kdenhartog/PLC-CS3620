{
 (* auto-generated by gt *)

open Gra2srs_parse;;
 
}

rule token = parse
| ['\t' ' ' '\n' '\r']+ as str { let i = ref 0 in String.iter(fun s -> if s <> ' ' && s <> '\t' then incr i) str; Gra2srs_util.line := !Gra2srs_util.line + !i; token lexbuf }
| '%'  (_ # ['\n' '\r'])* { token lexbuf }
| "!" { BANG(Gra2srs_util.cur_pd()) }
| "->" { ARROW(Gra2srs_util.cur_pd()) }
| "=>" { THICKARROW(Gra2srs_util.cur_pd()) }
| "|" { BAR(Gra2srs_util.cur_pd()) }
| "*" { STAR(Gra2srs_util.cur_pd()) }
| "+" { PLUS(Gra2srs_util.cur_pd()) }
| "?" { QMARK(Gra2srs_util.cur_pd()) }
| "." { DOT(Gra2srs_util.cur_pd()) }
| "(" { LP(Gra2srs_util.cur_pd()) }
| ")" { RP(Gra2srs_util.cur_pd()) }
| "[" { LS(Gra2srs_util.cur_pd()) }
| "]" { RS(Gra2srs_util.cur_pd()) }
| "~" { TILDE(Gra2srs_util.cur_pd()) }
| "-" { MINUS(Gra2srs_util.cur_pd()) }
| "," { COMMA(Gra2srs_util.cur_pd()) }
| ":" { COLON(Gra2srs_util.cur_pd()) }
| "Start" { START(Gra2srs_util.cur_pd()) }
| "Whitespace" { WHITESPACE(Gra2srs_util.cur_pd()) }
| "Syntactic" { SYNTACTIC(Gra2srs_util.cur_pd()) }
| "Lexical" { LEXICAL(Gra2srs_util.cur_pd()) }
| "Vars" { VARS(Gra2srs_util.cur_pd()) }
| "Rules" { RULES(Gra2srs_util.cur_pd()) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '_' '-' '0'-'9']* as str { ID((Gra2srs_util.cur_pd(),str)) }
| ('\''[^ '\'' ' ']+'\'') as str { STRING_LIT((Gra2srs_util.cur_pd(),str)) }
| eof { EOF }
| _ {failwith((Lexing.lexeme lexbuf) ^": lexing error"^(Gra2srs_util.string_of_pos (Gra2srs_util.cur_pd())))}{}
