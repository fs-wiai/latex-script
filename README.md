# LaTeX Script by Fachschaft WIAI

This script introduces the most fundamental LaTeX mechanisms to get learners started. It is used both as a reference and as exercise material for our [LaTeX workshop](https://wiai.stuve-bamberg.de/latex-weekend), a **two-day tutorial aimed at students from various backgrounds**. The following topics are covered:

* general introduction to the LaTeX system 
* basic document structure
* structuring a more complex project
* special characters
* text markup
* formatting paragraphs
* lists
* maths and formulas
* sourcecode listings
* graphics
* tables
* footnotes
* references
* literature management

Most chapters contain exercises to be performed within the script itself, practically teaching the aspects that are introduced by the text.

## Requirements

Compiling the script requires a working [LaTeX installation](https://tug.org/texlive/).
For sourcecode listings, we are using [Pygments](https://pygments.org/) and [Python3](https://www.python.org/).
The Makefile comes in handy for compiling the different versions of the script (see usage section).
For learners, we recommend using [TeXstudio](https://www.texstudio.org/) to compile the script.

## Project Structure

```
latex-skript/
├── commands.tex
├── compile_listings
├── compile_tasks
├── content
│   ├── basic-document-structure.tex
│   ├── basic-functionality.tex
│   └── …
├── exercises
│   ├── basic-document-structure
│   ├── footnotes
│   └── …
├── graphics
│   ├── benzene-ring.pdf
│   ├── cc-by-sa.png
│   └── …
├── listings
│   ├── basic-document-structure
│   ├── formatting-paragraphs
│   └── …
├── main.tex
├── Makefile
├── praeamble.tex
├── public
└── README.md
```

* **`main.tex`** is the entry point. It includes the preamble (`preamble.tex`), our custom commands (`commands.tex`) as well as all sections.
* **`content`** comprises the individual chapters of this script.
* Most chapters include a task that can be found in the **`exercises`** folder.
* **`public`** is the folder where all packed-up versions of the script are moved to, once they have been created using the `Makefile` and the command `make publication`. There are two zip archives of this repository (one containing only the exercises and one with solutions included) as well as three PDF versions (one with the content only, one with exercises, and one with exercises and solutions).
* `compile_listings` and `compile_commands` are two **utility bash scripts**. They produce a rendered and cropped PDF version of all `.tex` files within the `listings`/`exercises` folders and their sub folders. Rendered listings remain in `listings` whereas tasks are moved to the **`graphics`** folder afterwards. The compiled tasks are necessary for students who receive the project archive, but should not be given the sourcecode of tasks, e.g., if an exercise demands them to code up a table based on a pre-coded example.

## Usage

**For beginners**: A PDF version of the script can be found in the “releases” section. It will give you an overview of how to use any LaTeX project. For this, have a look at the “Erste Schritte mit LaTeX” section.

**Commandline usage**: The project can be compiled by running a LaTeX compiler on `main.tex`. Note that we make (heavy) use of the Pygments package, which requires additional installation (see section above) and a flag (`--shell-escape`) that has to be passed to the compiler. To configure TeXstudio with Pygments, see the chapter “Quelltext-Listings” (especially “10.2 – Compilerbefehl ändern”) in the script. A simple command would be:

```sh
$ pdflatex --shell-escape main.tex
```

Run the command twice to generate the table of contents and other registers. Once the literature tasks are being worked on, compilation requires an additional call to BibTeX:

```sh
$ pdflatex --shell-escape main.tex
$ bibtex main.aux
$ pdflatex --shell-escape main.tex
$ pdflatex --shell-escape main.tex
```

## Contributing

You are welcome to contribute to this project by creating issues, opening pull requests, or reporting bugs. Note that our goal is to keep the content rather condensed, so we might not choose to incorporate further sections.

These are the main contributors so far:
* Evelyn Fradtschuk
* Florian Knoch
* Christian Kremitzl
* Bernhard Luedtke

## License

The LaTeX Script has been assembled by the Student Council of the Faculty of Information Systems and Applied Computer Sciences (Fachschaft WIAI) at University of Bamberg. It is licensed under Creative Commons “Attribution-ShareAlike 4.0 International” (CC BY-SA 4.0): http://creativecommons.org/licenses/by-sa/4.0/. Upon request, allowances exceeding the limitations of this license may be granted.
