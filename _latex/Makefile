all: resume.pdf resume-boring.pdf

%.pdf: %.tex yb.cls
	latexmk -pdf $<

clean:
	rm -rf *.pdf *.out *.log *.aux

