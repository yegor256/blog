all: resume.pdf resume-boring.pdf

%.pdf: %.tex
	latexmk -pdf $<

clean:
	rm -rf *.pdf *.out *.log *.aux

