SHELL=/bin/bash

default: preview

# Build everything there is.
all: listings tasks preview publication

# Remove builds and LaTeX output.
clean: 
	@echo Cleaning up temporary files.
	@rm -rf public/*
	@rm -rf temp/*
	@rm -f main-{script,exercises,solutions}.{aux,loc,log,out,pdf,soc,toc}

# Compile listings (only needed when listings have changed)
listings: listings/**/*
	./compile_listings

# Compile pre-rendered tasks
tasks: exercises/**/*
	./compile_tasks

# Compile a preview PDF containing all contents
preview: main-script.tex
	echo "\newcommand\listingsmode{minted}" > listings-mode.tex
	pdflatex -shell-escape main-script.tex
	@echo
	@echo
	@echo Run \'make publication\' to generate PDF and ZIP file for publication.

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
publication-pdf-without-exercises: clean publication-dir main-script.tex
	echo "\newcommand\listingsmode{minted}" > listings-mode.tex
	pdflatex -shell-escape main-script.tex
	pdflatex -shell-escape main-script.tex
	pdflatex -shell-escape main-script.tex
	mv main-script.pdf public/
	
# Compile a printable PDF with exercises and without solutions
publication-pdf-with-exercises: clean publication-dir main-exercises.tex
	echo "\newcommand\listingsmode{minted}" > listings-mode.tex
	pdflatex -shell-escape main-exercises.tex
	pdflatex -shell-escape main-exercises.tex
	pdflatex -shell-escape main-exercises.tex
	mv main-exercises.pdf public/

# Compile a printable PDF with solutions
publication-pdf-with-solutions: clean publication-dir main-solutions.tex
	echo "\newcommand\listingsmode{minted}" > listings-mode.tex
	pdflatex -shell-escape main-solutions.tex
	pdflatex -shell-escape main-solutions.tex
	pdflatex -shell-escape main-solutions.tex
	mv main-solutions.pdf public/

# Build a ZIP file without tasks
publication-zip-without-exercises: clean publication-dir
	rm -rf temp/*
	cp --parents main-script.tex praeamble.tex commands.tex setup.tex content/* graphics/* listings/**/*.{tex,pdf,bib,java,txt} titlepage.tex imprint.tex temp/
	cd temp && zip ../public/project-without-exercises * **/* **/**/*


# Build a ZIP file with tasks and without solutions
publication-zip-with-exercises: clean publication-dir
	rm -rf temp/* exercises/**/_*
	cp --parents main-exercises.tex praeamble.tex commands.tex setup.tex graphics/* listings/**/*.{tex,pdf,bib,java,txt} titlepage.tex imprint.tex first-steps-with-latex.tex temp/
	cp --parents exercises/**/* temp/
	rm -f temp/exercises/**/*.done.{tex,bib,synctex.gz}
	rm -f temp/exercises/**/*.rend.tex
	rm -f temp/exercises/**/*.aux
	find temp/ -name '*.raw.*' -exec bash -c 'sed "s/\.raw\./\./g" <<<{} | xargs mv {}' \;
	find temp/ -name '*.tex' -exec sed -i -e 's/\.raw\./\./g' {} \;
# TODO: Replacement of .raw not working.
	sed -e 's/\.raw//g' temp/main-exercises.tex > temp/main-exercises.tex
	cd temp && zip ../public/project-with-exercises * **/* **/**/*

# Build a ZIP file with tasks and solutions
publication-zip-with-solutions: clean publication-dir
	rm -rf temp/* exercises/**/_*
	cp --parents main-solutions.tex praeamble.tex commands.tex setup.tex graphics/* listings/**/*.{tex,pdf,bib,java,txt} titlepage.tex imprint.tex first-steps-with-latex.tex temp/
	cp --parents exercises/**/* temp/
	rm -f temp/exercises/**/*.raw.{tex,bib,synctex.gz}
	rm -f temp/exercises/**/*.aux
	find temp/ -name '*.done.*' -exec bash -c 'sed "s/\.done\./\./g" <<<{} | xargs mv {}' \;
	find temp/ -name '*.tex' -exec sed -i -e 's/(raw|done)//g' {} \;
# TODO: Replacement of .done not working.
	sed -e 's/\.done//g' temp/main-solutions.tex > temp/main-solutions.tex
	cd temp && zip ../public/project-with-solutions  * **/* **/**/*

	
