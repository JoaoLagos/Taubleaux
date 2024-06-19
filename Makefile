# Makefile para executar os exemplos

run-example1:
	cabal run < examples/example1.txt

run-example2:
	cabal run < examples/example2.txt

run-example3:
	cabal run < examples/example3.txt

run-example4:
	cabal run < examples/example4.txt

run-example5: 
	cabal run < examples/example5.txt

run-example6: 
	cabal run < examples/example6.txt

run-example7: 
	cabal run < examples/example7.txt

.PHONY: run-example1, run-example2, run-example3, run-example4, run-example5, run-example6, run-example7