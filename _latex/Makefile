# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
.PHONY: all clean test
.SHELLFLAGS := -e -o pipefail -c
SHELL := bash

TEXS=$(wildcard *.tex)
PDFS=$(TEXS:.tex=.pdf)

all: $(PDFS)

test: all

clean:
	rm -rf .DS_Store *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out
	rm -rf $(PDFS)
	rm -rf _minted*

%.pdf: %.tex yb.cls aspell.en.pws
	latexmk -pdf $<
	texqc --ignore 'You have requested document class' $<
	texsc $<
