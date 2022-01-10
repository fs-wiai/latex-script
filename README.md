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
* source code listings (`minted` + `listings`)
* graphics
* tables
* footnotes
* references
* literature management

Most chapters contain exercises to be performed within the script itself, practically teaching the aspects that are introduced by the text.

## Getting started

### For beginners
A PDF version of the script can be found [in the “releases” section](https://github.com/fs-wiai/latex-script/releases). It will give you an overview of how to approach any, but especially this LaTeX project. For this, have a look at the “First steps with LaTeX” section.

**Optionally**, the `minted` package can be used for source code listings. This requires some additional configuration (including the installation of [Python3](https://www.python.org/)). Please refer to the chapter on “Source code listings” in the aforementioned PDF file.

### Command line usage

The project can be compiled by running a LaTeX compiler on `main.tex`. A simple command would be:

```sh
$ pdflatex main.tex
```

Run the command twice to generate the table of contents and other registers. Once the literature tasks are being worked on, compilation requires an additional call to BibTeX:

```sh
$ pdflatex main.tex
$ bibtex main.aux
$ pdflatex main.tex
$ pdflatex main.tex
```

If you decide to use the optional `minted` package (see section above), don't forget to add the `--shell-escape` flag: 

```sh
$ pdflatex --shell-escape main.tex
```

## Project Structure

```
latex-script/
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
├── setup.tex
└── README.md
```

## Relevant files for learners
* **`main.tex`** is the entry point. It includes the preamble (`preamble.tex`), our custom commands (`commands.tex`) as well as all sections.
* **`content`** comprises the individual chapters of this script.
* Most chapters include a task that can be found in the **`exercises`** folder.

Please don't feel overwhelmed by the amount of files in this repository. You will get to know the most important parts of the project step by step by [following the script](https://github.com/fs-wiai/latex-script/releases) or our workshop. What's more, by using this larger projects you get accustomed to the complexity of real LaTeX projects – bachelor's/master's theses and the like.

## Further information for maintainers

### Listings mode
**`setup.tex`** is used to configure which package to use for source code listings. All listings in the script are set using custom commands that can internally switch between the `listings` and the `minted` package.

**`listings-mode.tex`** is the file that determines the listings mode. If this file is non-existent or contains the line `\newcommand\listingsmode{default}`, `listings` is used. `\newcommand\listingsmode{minted}` switches it to `minted`. We decided to add this abstraction to deal with learners having trouble to install Pygments on their machine.

### Including rendered images of source code
**`compile_listings`** and **`compile_commands`** are two utility bash scripts. They produce a rendered and cropped PDF version of all `.tex` files within the `listings`/`exercises` folders and their sub folders. Rendered listings remain in `listings` whereas exercise renderings are moved to the **`graphics`** folder afterwards. 

The compiled tasks are necessary for students who receive the project archive, but should not be given the source code of tasks, e.&thinsp;g., if an exercise demands them to code up a table based on a pre-coded example.

### Publishing the script
**`public`** is the folder where all packed-up versions of the script are moved to, once they have been created using the `Makefile` and the command `make publication`. There are two zip archives of this repository (one containing only the exercises and one with solutions included) as well as three PDF versions (one with the content only, one with exercises, and one with exercises and solutions).

## Contributing

You are welcome to contribute to this project by creating issues, opening pull requests, or reporting bugs. Note that our goal is to keep the content rather condensed, so we might not choose to incorporate further sections.

These are the main contributors so far:
* Evelyn Fradtschuk
* Florian Knoch
* Christian Kremitzl
* Bernhard Luedtke

## License

The LaTeX Script has been assembled by the Student Council of the Faculty of Information Systems and Applied Computer Sciences (Fachschaft WIAI) at University of Bamberg. It is licensed under Creative Commons “Attribution-ShareAlike 4.0 International” (CC BY-SA 4.0): http://creativecommons.org/licenses/by-sa/4.0/. Upon request, allowances exceeding the limitations of this license may be granted.
