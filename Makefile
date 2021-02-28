SHELL=/bin/bash

default: preview

# Remove builds and LaTeX output.
clean: 
	@echo Cleaning up temporary files.
	@rm -rf public/*
	@rm -f {main,script-only}.{aux,loc,log,out,pdf,soc,toc}

# Compile listings (only needed when listings have changed)
listings: listings/**/*
	./compile_listings

# Compile a preview PDF containing all contents
preview: main.tex
	echo "\newcommand\exercisemode{any}" > exercise-mode.tex
	pdflatex -shell-escape main.tex
	@echo
	@echo
	@echo Run \'make publication\' a few times to generate PDF and ZIP file for publication.

# Build all PDF and ZIP variants
publication: publication-pdf-without-exercises publication-pdf-with-exercises publication-pdf-with-solutions publication-zip-with-exercises publication-zip-with-solutions

#
# Building blocks from here on:
# 

# Directory for files to be published
publication-dir:
	mkdir -p public/

# Compile a printable PDF without exercises
publication-pdf-without-exercises: publication-dir main.tex
	echo "\newcommand\exercisemode{none}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-only main.tex
	mv script-only.pdf public/
	
# Compile a printable PDF with exercises and without solutions
publication-pdf-with-exercises: publication-dir main.tex
	echo "\newcommand\exercisemode{exercises}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-with-exercises main.tex
	mv script-with-exercises.pdf public/

# Compile a printable PDF with exercises and solutions
publication-pdf-with-solutions: publication-dir main.tex
	echo "\newcommand\exercisemode{solutions}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-with-solutions main.tex
	mv script-with-solutions.pdf public/

# Build a ZIP file with tasks and without solutions
publication-zip-with-exercises: publication-dir main.tex
	zip public/project-with-exercises main.tex praeamble.tex commands.tex literature.bib content/* graphics/* listings/**/*.{tex,pdf} exercises/**/{task.tex,*.raw.tex}

# Build a ZIP file with tasks and solutions
publication-zip-with-solutions: publication-dir main.tex
	zip public/project-with-solutions main.tex praeamble.tex commands.tex literature.bib content/* graphics/* listings/**/*.{tex,pdf} exercises/**/{task.tex,*.done.tex}

	
