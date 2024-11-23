# Instructions for compiling LaTeX documents in Visual Studio Code

This tutorial demonstrates how to set up VS Code to compile the LaTeX script.

## Software installation

1. Download and install [VS Code](https://code.visualstudio.com/) or its open-source version [VS Codium](https://vscodium.com/).
2. Install the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) plugin.

## Build recipes

LaTeX Workshop uses so-called recipes to compile documents. A recipe refers to a list of commands that are executed one after the other. For our exercises, we will need one basic recipe which simply runs the compiler twice. Later on, we will need a second recipe to deal with bibliographic data.

1. Launch the VS Code settings and search for “recipes.”
2. In the “Latex: Recipes” section, click on “Edit in settings.json.”
3. Go ahead and add the following two entries to the list. The first one just uses the `pdflatex` compiler twice to build our document, whereas the second one adds an intermediate round of `bibtex` compilation.

```json
"latex-workshop.latex.recipes": [
    {
    {
        "name": "pdflatex × 2",
        "tools": [
            "pdflatex",
            "pdflatex"
        ]
    },
        "name": "pdflatex -> bibtex -> pdflatex × 2",
        "tools": [
            "pdflatex",
            "bibtex",
            "pdflatex",
            "pdflatex"
        ]
    },
    // EXISTING ENTRIES GO HERE
]
```

4. Save and close the settings file.
5. For later convenience, set the “Recipe: Default” option to `lastUsed`.

## Compiling

1. Open the unzipped project archive (available in the [Releases section](https://github.com/fs-wiai/latex-script/releases)).
2. To test your installation, open `main-exercises.tex`.
3. In the left side bar, click on the TeX symbol, open the “Build LaTeX project entry” (clicking on the little arrow on the left) and choose the “pdflatex × 2” recipe. For the duration of the compilation, you should see a spinning icon in the bottom row next to the Git icons. Any errors will appear in the problems tab.
4. To open the resulting document, click on “View LaTeX PDF” in the TeX section below the recipes. If this succeeded, you are ready to work on the exercises. The document will compile again once you save it.

## Some useful notes

+ LaTeX Workshop will always try to compile the file your cursor is currently in. If you are working in sub-files, then this will result in errors. You can **specify the document root** by adding a magic TeX root comment. Press `Ctrl + Shift + P` and select “Insert !TeX magic root command.” Then simply select your root document and compile again. We provided these comments for you in all exercise files:

```tex
% !TeX root = ../../main-exercises.tex
```

This plugin offers a couple of other handy features:

+ Sometimes, it is helpful to kill all compiler processes and **clean up the auxiliary files** afterwards.
+ If you need to **find a certain section** in the PDF or in the source document, you can use the “Navigate, select and edit” menu.
+ In the left sidebar, you will also find the entire **document structure** and **snippets** that will make your life easier.

