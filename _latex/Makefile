OPTS=-shell-escape -halt-on-error -interaction=errorstopmode
DEPS=$(wildcard **/*.tex)

all: resume.pdf

%.pdf: %.tex $(DEPS)
	pdflatex ${OPTS} $<

clean:
	rm -rf *.pdf *.out *.log *.aux

