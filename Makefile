default: all

all: listings main.tex
	./compile_listings
	pdflatex --shell-escape main.tex
	
latex: main.tex
	pdflatex --shell-escape main.tex

