OBJS_NOT_MAIN = util.cmx intmap.cmx trie.cmx gra2srs_util.cmx gra2srs_syntax.cmx gra2srs_parse.cmx gra2srs_lex.cmx gra2srs_pp.cmx gra2srs_eq.cmx gra2srs_gviz.cmx gra2srs_ppast.cmx term.cmx trs.cmx grammar.cmx termination.cmx rewriting.cmx localconf.cmx ast.cmx rewrite_rules.cmx parsing_trs.cmx sccs.cmx tree.cmx genrtn.cmx compile_agda.cmx complexity.cmx uf.cmx aut.cmx ambig.cmx builddfa.cmx
OBJS = $(OBJS_NOT_MAIN) main.cmx 

gratr:	$(OBJS)
	ocamlopt -o gratr str.cmxa unix.cmxa nums.cmxa $(OBJS)

main.cmx: main.ml $(OBJS_NOT_MAIN)
	ocamlopt -c main.ml

complexity.cmx:	complexity.ml gra2srs_syntax.cmx grammar.cmx util.cmx 
	ocamlopt -c complexity.ml

compile_agda.cmx : compile_agda.ml parsing_trs.cmx aut.cmx grammar.cmx gra2srs_syntax.cmx util.cmx
	ocamlopt -c compile_agda.ml

builddfa.cmx: builddfa.ml aut.cmx ambig.cmx
	ocamlopt -c builddfa.ml

ambig.cmx: ambig.ml aut.cmx util.cmx intmap.cmx
	ocamlopt -c ambig.ml

uf.cmx : uf.ml util.cmx
	ocamlopt -c uf.ml

sccs.cmx : sccs.ml util.cmx trie.cmx parsing_trs.cmx
	ocamlopt -c sccs.ml

genrtn.cmx:	genrtn.ml util.cmx parsing_trs.cmx trs.cmx rewriting.cmx
	ocamlopt -c genrtn.ml

aut.cmx: aut.ml tree.cmx util.cmx uf.cmx trie.cmx sccs.cmx
	ocamlopt -c aut.ml

tree.cmx: tree.ml util.cmx
	ocamlopt -c tree.ml

rewriting.cmx: rewriting.ml util.cmx term.cmx grammar.cmx trs.cmx 
	ocamlopt -c rewriting.ml

parsing_trs.cmx: parsing_trs.ml rewrite_rules.cmx util.cmx trs.cmx term.cmx grammar.cmx
	ocamlopt -c parsing_trs.ml

rewrite_rules.cmx: rewrite_rules.ml util.cmx grammar.cmx trs.cmx trie.cmx term.cmx ast.cmx
	ocamlopt -c rewrite_rules.ml

ast.cmx: ast.ml trie.cmx
	ocamlopt -c ast.ml

trie.cmx: trie.ml util.cmx intmap.cmx #orderedint.cmx
	ocamlopt -c trie.ml

intmap.cmx: intmap.ml
	ocamlopt -c intmap.ml

term.cmx: term.ml util.cmx trie.cmx
	ocamlopt -c term.ml

util.cmx: util.ml 
	ocamlopt -c util.ml

trs.cmx: trs.ml util.cmx term.cmx
	ocamlopt -c trs.ml

localconf.cmx: localconf.ml util.cmx term.cmx grammar.cmx trs.cmx rewriting.cmx trie.cmx
	ocamlopt -c localconf.ml

grammar.cmx: grammar.ml util.cmx term.cmx trs.cmx trie.cmx gra2srs_syntax.cmx
	ocamlopt -c grammar.ml

gra2srs_syntax.cmx: gra2srs_syntax.ml gra2srs_util.cmx 
	ocamlopt -c gra2srs_syntax.ml

gra2srs_pp.cmx: gra2srs_pp.ml gra2srs_syntax.cmx 
	ocamlopt -c gra2srs_pp.ml

gra2srs_ppast.cmx: gra2srs_ppast.ml gra2srs_syntax.cmx 
	ocamlopt -c gra2srs_ppast.ml

gra2srs_gviz.cmx: gra2srs_gviz.ml gra2srs_syntax.cmx 
	ocamlopt -c gra2srs_gviz.ml

gra2srs_eq.cmx: gra2srs_eq.ml gra2srs_syntax.cmx 
	ocamlopt -c gra2srs_eq.ml

gra2srs_util.cmx: gra2srs_util.ml 
	ocamlopt -c gra2srs_util.ml

gra2srs_lex.cmx: gra2srs_lex.ml gra2srs_util.cmx gra2srs_parse.cmi 
	ocamlopt -c gra2srs_lex.ml

gra2srs_parse.cmx: gra2srs_parse.ml gra2srs_util.cmx gra2srs_syntax.cmx gra2srs_parse.cmi 
	ocamlopt -c gra2srs_parse.ml

gra2srs_parse.cmi: gra2srs_parse.mli gra2srs_syntax.cmx 
	ocamlopt -c gra2srs_parse.mli

gra2srs_parse.mli gra2srs_parse.ml: gra2srs_parse.mly gra2srs_syntax.cmx
	ocamlyacc -v gra2srs_parse.mly

gra2srs_lex.ml: gra2srs_lex.mll gra2srs_parse.cmi 
	ocamllex gra2srs_lex.mll

termination.cmi: termination.mli grammar.cmx
	ocamlopt -c termination.mli

termination.cmx: termination.ml term.cmx grammar.cmx termination.cmi
	ocamlopt -c termination.ml

clean:
	rm -f gra2srs_lex.ml gra2srs_parse.mli gra2srs_parse.ml *.cmx *.cmo *.cmi *.o 

cleanall: clean
	rm -f gratr gratr.prof gratr.gprof
