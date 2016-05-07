export PP = camlp4o

PPFLAGS = \
	-I `ocamlfind -query batteries.pa_comprehension` pa_comprehension.cmo \
	-I `ocamlfind -query batteries.pa_batteries` pa_batteries.cmo \
	-I `ocamlfind -query batteries.pa_strings` pa_strings.cma \
	-I `ocamlfind -query batteries.pa_where` pa_where.cmo

SOURCES = 	main.ml 
RESULT = main

PACKS = batteries
CREATE_LIB = yes

YFLAGS = -v

all: native-code

OCAMLMAKEFILE = OCamlMakefile
-include $(OCAMLMAKEFILE)
