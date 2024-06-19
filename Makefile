# Makefile para executar exemplo 1 com Cabal

run-example1:
	cabal run < examples/example1.txt

run-example2:
	cabal run < examples/example2.txt

run-example3:
	cabal run < examples/example3.txt

run-example4:
	cabal run < examples/example4.txt

.PHONY: run-example1, run-example2, run-example3, run-example4