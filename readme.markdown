# Year of Monsters

## What is this?

This is a LaTeX template to allow you to format a mystery for the game Monster of the Week in a style that matches the original book.

### Can I see a sample  of the output?

Sure!  You can find the mysteries I've released using this template [here](https://drive.google.com/drive/folders/1Y9k-DbwUaDRgSAJccwTEcFJLZtGjHfyt?usp=sharing)

## How do I install it?

You will need three things, at least one of which you probably already have:

* This repository, using the command `git clone https://github.com/TheFeshy/YearOfMonsters.git`
* A distribution of [LaTeX](https://www.latex-project.org/get/) (It's free and open source)
* A text editor

### Okay, I've got all that.  Now what?

Open a command prompt in the directory where you cloned this repository, and type `latexmk`.  This should find all the `.tex` files in the `content` directory, and compile them into PDFs.  These will be stored in `output/build`.  Since there is a `sample.tex` file you should get at least one `sample.pdf` file.

### I don't really do command lines.  Is there another way?

There are many LaTeX editors, both online (such as [overleaf](https://www.overleaf.com/)) and downloadable for free, but I am not personally familiar with any of them.  You should be able to get them to work with some tinkering.  One thing you should know is that this template must be compiled with either XeLaTeX or LuaLaTeX, due to the fonts it uses.  And you will need to place the files in `lib` wherever your LaTeX editor expects to find fonts and classes.

## Walk me through making a mystery with this template

The basics of LaTeX aren't much harder to use than markdown-based languages like many popular social media sites use.  So if you can use those, you should be able to create a mystery with this template.  I recommend copying the file `content/sample/sample.tex` to `/content/mymystery.tex`, and using this copy as the start of the mystery you want to write.  We'll go over it here in detail:

### Document preamble

```tex
% Year of Monsters: A Sample template for a LaTeX formatted Monster of the Week mystery

\documentclass{motw}
```

The first line is a comment.  Comments always start with a `%`.  Everything after the `%` is ignored.  You can also use this to get LaTeX to ignore things like blank lines, if you want to add some space to your document, but don't want it to show up in the final version.

The second line is the document class, which tells LaTeX to use the monster of the week template that you downloaded.  If you are familiar with LaTeX, it might help to know that the `motw` class is based on the memoir class.

### Beginning the document
```tex
\begin{document}

\appendtographicspath{{content/sample/images}}
```

The first line here tells LaTeX that we're going to start giving it content for the document.  Commands to LaTeX (called macros) begin with a `\`, and they take parameters in `{}` brackets.  `\begin` tells LaTeX we are going to begin a section (if you scroll down to the end, you will see a corresponding `\end` macro as well.)  All the contents that you wish to have in your PDF will be in a `document` section - that is, between these `\begin{document}` and `\end{document}` tags.

The second line tells LaTeX where it can find the images you will be using in this document.  The sample's example images are in `/content/sample/images`.  Note that in this one special case, the path is wrapped in double `{{}}`.  Most parameters won't be like this.

### Mystery Macro
```tex
\Mystery{Sample Mystery}{Your Name Goes Here}
```

Now we're starting on the actual mystery.  The `\Mystery` macro creates a header in the right font and size, with the name of your mystery (in this case, `Sample Mystery`) and a by-line for the author (`Your Name Goes Here`).  Go ahead and change these, and run `latexmk` in the base directory, and see `mymystery.pdf` in the `output/build` directory.  It should have your name and title now, both at the top and in the margin heading.

### Images
```tex
\imageTop[width=\paperwidth]{top}
```

Here we will add an image to the very top of the document.  Note that the command comes after the header, but still appears above it - that's because the `\imageTop` macro will put the image at the top of whatever page it is on.  This is helpful if you later add more text and the number of pages changes - LaTeX will still lay out the images as you have specified.  There are also other image macros I've created that we'll see, for adding images in other locations (such as `\imageBottom` and `\imageHere`, which place an image at the bottom, and right here in the text, respectively)

Here we also see a new type of LaTeX parameter - the optional parameter, enclosed in `[]` brackets.  If you do not provide these options, the macro will take a guess at what they should be.  In this case, we tell the image macro how wide to make our image - we pass it another macro for this, `\paperwidth`, which tells the `\imageTop` macro to make the image as wide as the paper.  You can also use units of measurement, like `1.0in` or `2.4cm`.  LaTeX supports some other units, like `pt` (point) and `ex` (the width of a lowercase `x` on the current line) and `em` (width of an uppercase `M`.)

There are other optional parameters that aren't used here, but that you can use to fine-tune your image placement.  They are `xoffset` and `yoffset`.  If you wanted your image to be indented half an inch down from the top, and be only 2 inches wide, you could give the optional parameters `[width=2in, yoffset=0.5in]`

The last parameter, `{top}`, is the name of the image.  Note that it doesn't have an extension; LaTeX will try to use the best-quality image with that name.  So if you have `top.png` and `top.jpg` in the folder you specified in `\appendtographicspath`, it will choose `top.png`.

### Image Credits
```tex
\imageCredit{Name of top image}{Sample Artist}{CC0}
```

I like to credit hard-working artists, *especially* the ones kind enough to release their artwork for public use.  To do so, I use this image credit macro.  It takes three parameters: the name of the artwork, the name of the artist, and the copyright.  I use lots of Creative Commons and Public Domain images in my mysteries.  

Note that this  macro doesn't output anything to the PDF right away.  Instead, it stores it until later, allowing the image credits and copyright information for your work to be displayed in a group at the end.  But by putting the macro next to the image, like we've done in the sample, the image credits will appear in the same order as the images, and you won't forget to update them if an image is removed or changed.

The image credit macro can also take a single optional parameter, `[modified]`.  I use this if I've had to convert an image from color to black and white or line-art to match the style of the original books.  I don't want an artist to get blamed for my terrible photo manipulation, but I also don't want them to go un-credited!

### Headers and basic content
```tex
\Mhead{Concept}
This is where you will put the text describing the content of your mystery.  You can use the same syntax for the Hook, the Background, and anything else your mystery needs!
```

In the MotW book, you get headers in a fancy font, in a few different sizes.  The template gives us two (three, if you count the mystery name which is a bit larger): `\Mhead` and `\mhead`, with the capital `M` being the larger one.  This is used for sections of your mystery like "Concept" and "Hook" and "Threats", but could be used for any information you want to include in your mystery.

### Image (here)

```tex
You can add centered images anywhere in a page:
\imageHere[width=3in]{here}
\imageCredit{Centered image}{}{CC0}
```

You can see that the `\imageHere` macro is almost identical to the `\imageTop` macro, and places its image right where it appears in the text (rather than at the top or the bottom of the page.)

### Image (here) with a caption

```tex
\imageHereCaption[width=3in]{here}{caption below image}
```

All of the image macros have a form with `Caption` added to the end that will place a caption below the image (or above it, in the case of `\imageBottomCaption`)  They take an additional parameter that is the caption you wish to use.  This can be any formatted text, with the usual `\emph{}` or other commands.  If you would like to use this caption space for image credits, and you like the formatting of the image credits that is donew with the `\imageCredit` macro, you can use the same syntax with `\formatImageCredit`.  For example, to place the image 'here' with the same image credit as the previous example, you would use

```tex
You can add centered images anywhere in a page:
\imageHereCaption[width=3in]{here}{\formatImageCredit{Centered image}{}{CC0}}
```

### Countdown

```tex
\Countdown%
{This is where your countdown starts}
{Each day is a separate parameter}
{You can put \emph{formatted} text in here too, if you like}
{Even lists with items
\begin{itemize}
    \item Item 1
    \item Item 2
\end{itemize}
}
{I hope your hunters have figured things out by here}
{Because usually this last step is pretty dangerous}
```

Countdown clocks are very important to Monster of the Week, and I've provided a macro to easily create them.  The `\Countdown` macro takes *six* parameters - but these correspond to the six stages of the countdown clock (from day to midnight, in order.)

Usually, your countdown will just be simple text in a parameter (like `{the monster eats Jones}`).  But the `\Countdown` macro can contain any arbitrary text or formatting - such as `\emph` emphasized text.  (Emphasized text is usually *italicized*, but if *the entire section it is in is emphasized,* the text *is not*.)

It can also contain more complicated text structures, like itemized lists.  You can see one here; as you can see LaTeX has an `itemize` section in `\begin` and `\end` tags, and inside this section can use `\item` macros.

### Side images

```tex
\imageCredit{left}{}{CC0}
\imageLeft[width=1.0in, margin=0in]{side}{%
    Side images are trickier.  As you can see, you have to pass the text that will go beside the image as a parameter.  Like before, you can \emph{format} the text however you want, including headings and lists.%
}
```

Images on the side of the page are, unfortunately, much trickier than images that are centered.  The difficulty comes from wrapping text around them.  LaTeX has optional add-ons to handle text wrapping, but I didn't find any of them satisfactory - so I made my own.  It has its own limitation; specifically the text that is wrapped (formatted next to the image) must be passed as a parameter, rather than simply flowing into and out of the surrounding text.  This can require some manual trial-and-error effort to get to look nice, so you might want to use these sparingly.

As  you can see, the optional parameters are much like for `\imageTop` and `\imageBottom`, with one additional option: `margin=`.  This parameter is how far into the margin you want the image to protrude.  The original book sometimes has images all the way to the edge of the page (`margin=1in`).  Other times, you might want the image flush with the rest of the text (`margin=0in`).  Anything in between is also acceptable.

The `\imageRight` and `\imageLeft` take two mandatory parameters; the name of the image (in the same way as `\imageTop`, leaving off the file extension if you like) and the text that will go next to the image.  This text can be anything, including headers, lists, etc.

### Monster, Minions, Locations, and Bystanders

```tex
\Mhead{Threats}

\Cast{Doctor Minionson}{minion}{renfield}

This is how you add a monster, minion, phenomenon, bystander, or location.  The second parameter is one of those categories, and the third is the specific type (such as 'beast' or 'cultist')  All the categories and types from both Monster of the Week as well as Tome of Mysteries can be used.

```

Now we can get to the meat of the mystery:  The monster, its minions, and the other cast.  First, put them under a "Threats" heading, with `\Mhead{threats}`.  Next, for each of those things you want in  your mystery, use the `\Cast` macro to add them (like the cast of your show.)  The `\Cast` macro takes three mandatory parameters:  The name of your person, place, or thing, the type of thing it is (phenomenon, monster, minion, location, or bystander) and it's motivation (which is the lower-case version of the motivation taken from the books.  Things like `beast` and `assassin` and `heper`.)

Using that information, the macro will generate and format a line for your monster's name, type, and motivation.

Additionally, you can put anything you want in those categories, and your custom text will be substituted for the standard motivations and types.

Below that, you can put your monster's information, description, and stats:

### Monster (and minion/bystander/location) stats

```tex
\begin{mStatList}{Powers}
    \mStat{A Cool Power}{You can add powers in itemized lists, like this}
    \mStat{Less cool Power}{and this}
\end{mStatList}

\begin{mStatBlock}{Attacks}
    \mStat{An attack}{You can also add stats in blocks}
    \mStat{another attack}{like these two attacks}
\end{mStatBlock}

\begin{mStatBlock}{Armor}
    \mStat{Sturdy Lab coat}{1-armor}
\end{mStatBlock}
```

This is how the template generates stats lists for your monster. In Monster of the Week, stats tend to show up in two forms:  As an itemized list, or as a block with bold-face headings identifying the different powers.  You can use either, and switch easily between them if you decide to add or remove powers and need the room.

To do so, start a new section with `\begin`, and begin either a `mStatList` or `mStatBlock` to begin a list or a block, respectively.  Pass in a heading for this block as well, such as `{Powers}` or `{Attacks}` or `{Custom Moves}`.  

Then, list your stats with an `\mStat` macro.  This macro takes two parameters; the name of the stat ("big sharp claws" or "immortal terror") and the text describing it ("3-harm" or "Is so frightening bystanders can't remember it well.")

Lastly, close your stat block with an `\end` of the same type (`mStatList` or `mStatBlock`.)

### Harm Tracks

```tex
\harmtrack{10}
```

Don't forget that you actually want your hunters to *defeat* this monster at some point, so it will probably need a harm track to keep track of any harm it has received.  This is done with the easy to remember macro `\harmtrack`.  It takes one parameter: the number of harm boxes.  In this case, ten.  (it will add an additional space between every 5 boxes, to make them easier to count on the page.)

It can also take an optional parameter to add a mark for where the creature is "unstable" - if your creature or minion *can* be unstable.  This would look like `\harmtrack[4][11]` if your monster had 11 boxes of harm, and became unstable after 4.

Humans are `\harmtrack[3]{7}`, but for convenience you can just use `\humanharmtrack`

### Image Credits
```tex
\makeImageCredits[cc0]

\end{document}
```

At the very end of your document, you want to do three things:  Place the image credits, include your own copyright information, and `\end` the document section.  `\makeImageCredits` does the first two of these things.  It automatically generates the image credits from the information you gave it with `\imageCredit` macros.  If you give it an optional parameter with your chosen copyright, it will include that as well.  If you use one of these:

* cc-by
* cc-by-nc
* cc-by-nc-sa
* cc-by-sa
* cc0

it will even include the graphic version of that copyright from the Creative Commons.  Of course, if you want something fancier, you can leave off the optional parameter and put your own copyright information or images in yourself.

## Troubleshooting

### I have many underfull / overfull hbox / vbox errors

This is normal for LaTeX.  It tries to fit and align your text into pretty tight margins, and if it can't do so it warns you.  Usually this is by a very small value, like 1-2 points (<1 mm.)  If you want to see where these are occuring, you can add the `[draft]` parameter to the document, like this: `\documentclass[draft]{motw}`  The ovefull and underfull areas will be filled in black in the PDF so you can see them.

## Advanced Topics

### Reducing Image Resolution

LaTeX happily adds images in whatever resolution you have included them in - so if you've added a 1080p image at 2 inches, it's going to have a resolution much higher than most screens can display.  This won't hurt anything, but it does make your PDF larger than necessary.  If you run `release_quality.sh` in the root directory, it will convert all the images in your PDF to both 300  DPI (print_quality) or 150 DPI (ebook_quality) in your output folder.  These should result in PDFs sized suitably for reasonable download speeds.  The script will also have ghostscript make a few other optimizations, like leaving out font characters that aren't used.

## Legal

### Disclaimers

This template and all sample mysteries are distributed without any warranty, express or implied, including the implied assumption that it won't subvert the laws of physics and unleash an evil that needs to be stopped.

### Copyright

The template and associated documentation is distributed cc-by-nc.  Though, if you make improvements to the LaTeX template, I'd love it if you shared those back.  The individual example mysteries I've made have their own copyright information.  

Anything you *make* with this template can be distributed under whatever copyright you wish, of course.

### I never gave permission for my image to be used

For my example mysteries, I only use images that have been posted with "Public Domain" or "Creative Commons" licenses - but of course, I have no way to verify that the person posting them as such is the original artist.  If this has happened, I'm very sorry - simply send me proof that you are the original artist and I'll remove the image immediately.

You might also consider granting a limited license to distribute for non-commercial purposes - but I understand that's not always an option (nor always what an artist wants.)

### I'm credited for an image, but I don't want to be

In trying to get images to fit the style of the original rule-book, I sometimes go a bit ham on the photoshop filters - something I have no skill with.  So I totally understand.  I'll be happy to take your name off the artwork credits.