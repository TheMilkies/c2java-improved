TEST_NAME=test
src=$(shell find src/ -name "*.c")
TEST_FILES=$(shell find tests/ -name "*.c")
TARBALL_FILES=report.pdf Makefile \
	src/c2java.h src/c2java.l src/c2java.tab.h src/c2java.y $(src) \
	README

c2java: src/c2java.l src/c2java.y src/c2java.h $(src)
	cd src && bison -d c2java.y && flex c2java.l
	cc -o $@ $(src) -g -std=c99

report: report.pdf

report.pdf: report.tex
	pdflatex report.tex

tarball: $(TARBALL_FILES)
	tar cvf 5092029004.tar $(TARBALL_FILES)

oldtest: c2java $(TEST_FILES)
	./c2java $(TEST_FILES).c $(TEST_FILES).html

test: c2java
	./runtest.sh

clean:
	rm -f c2java c2java *.o *.output tests/*.html testcases/*/*.s *.pdf *.log *.aux