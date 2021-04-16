SHELL=/bin/bash

default: preview

# Build everything there is.
all: listings tasks preview publication

# Remove builds and LaTeX output.
clean: 
	@echo Cleaning up temporary files.
	@rm -rf public/*
	@rm -rf temp/*
	@rm -f {main,script-only}.{aux,loc,log,out,pdf,soc,toc}

# Compile listings (only needed when listings have changed)
listings: listings/**/*
	./compile_listings

# Compile pre-rendered tasks
tasks: exercises/**/*
	./compile_tasks

# Compile a preview PDF containing all contents
preview: main.tex
	echo "\newcommand\exercisemode{any}" > exercise-mode.tex
	pdflatex -shell-escape main.tex
	@echo
	@echo
	@echo Run \'make publication\' a few times to generate PDF and ZIP file for publication.

# Compile a preview PDF containing all contents and the literature
preview-with-literature: main.tex
	echo "\newcommand\exercisemode{any}" > exercise-mode.tex
	pdflatex -shell-escape main.tex
	bibtex main.aux
	pdflatex -shell-escape main.tex
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
	mkdir -p temp/

# Compile a printable PDF without exercises
publication-pdf-without-exercises: publication-dir main.tex
	echo "\newcommand\exercisemode{none}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-only main.tex
	#bibtex main.aux
	pdflatex -shell-escape -jobname=script-only main.tex
	pdflatex -shell-escape -jobname=script-only main.tex
	mv script-only.pdf public/
	
# Compile a printable PDF with exercises and without solutions
publication-pdf-with-exercises: publication-dir main.tex
	echo "\newcommand\exercisemode{exercises}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-with-exercises main.tex
	#bibtex main.aux
	pdflatex -shell-escape -jobname=script-with-exercises main.tex
	pdflatex -shell-escape -jobname=script-with-exercises main.tex
	mv script-with-exercises.pdf public/

# Compile a printable PDF with exercises and solutions
publication-pdf-with-solutions: publication-dir main.tex
	echo "\newcommand\exercisemode{solutions}" > exercise-mode.tex
	pdflatex -shell-escape -jobname=script-with-solutions main.tex
	#bibtex main.aux
	pdflatex -shell-escape -jobname=script-with-solutions main.tex
	pdflatex -shell-escape -jobname=script-with-solutions main.tex
	mv script-with-solutions.pdf public/

# Build a ZIP file with tasks and without solutions
publication-zip-with-exercises: publication-dir main.tex
	rm -rf temp/*
	cp --parents main.tex praeamble.tex commands.tex content/* graphics/* listings/**/*{.tex,pdf,bib} temp/
	cp --parents exercises/**/* temp/
	rm -f temp/exercises/**/*.done.{tex,bib}
	rm -f temp/exercises/**/*.rend.tex
	find temp/ -name '*.raw.*' -exec bash -c 'sed "s/\.raw\./\./g" <<<{} | xargs mv {}' \;
	find temp/ -name '*.tex' -exec sed -i -e 's/\.raw\./\./g' {} \;
	cd temp && zip ../public/project-with-exercises * **/* **/**/*

# Build a ZIP file with tasks and solutions
publication-zip-with-solutions: publication-dir main.tex
	rm -rf temp/*
	cp --parents main.tex praeamble.tex commands.tex content/* graphics/* listings/**/*.{tex,pdf,bib} temp/
	cp --parents exercises/**/* temp/
	rm -f temp/exercises/**/*.raw.{tex,bib}
	find temp/ -name '*.done.*' -exec bash -c 'sed "s/\.done\./\./g" <<<{} | xargs mv {}' \;
	find temp/ -name '*.tex' -exec sed -i -e 's/(raw|done)//g' {} \;
	cd temp && zip ../public/project-with-solutions  * **/* **/**/*

	
