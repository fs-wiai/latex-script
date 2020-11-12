default:
	pdflatex --output-directory content/grundstruktur/ content/grundstruktur/hallowelt.tex
	pdflatex --output-directory content/grundstruktur/ content/grundstruktur/titelei.tex
	pdflatex --shell-escape main.tex
