# Year of Monsters

A creative commons project for the TTRPG *Monster of the Week*

This project has two goals:

1. To create a usable LaTeX template for formatting third-party text to match the Monster of the Week RPG style
2. To create at least 52 ready-to-play mysteries - a whole year of monsters at the "monster a week" pace.

## 52 Mysteries!

So far, of course, this repository falls well short of 52 mysteries.  But I wanted to start putting up
what I had, so that others can contribute and take advantage of the LaTeX template in the meantime.

## To Use the Template

### Install

In order to compile your own mysteries/playbooks/etc, or modify these, you
will need a few things:

* A text editor
* This repository (can be fetched with `git clone TBD get this address`)
* A distribution of LaTeX with many of its optional packages (`TODO: xelatex, lualatex, necessary still?`)
* Two fonts, [Warnock Pro](`TODO: URL`) and [3rd Man](`TODO: URL`), both of which are available free of charge.

That's it; as you can see it's a very short list to get started!

## Creating a mystery

### Getting started

First, take a look at some of the other mysteries - they're the ones in the `latex` folder whose names start with `mystery_` 
and end with `.tex`.  This should give you an idea of the basics:  LaTeX uses a simple text file with
a mix of standard markup and custom macros from this class.  Images for each mystery are stored in
an image folder with the mystery's name.  `TODO: multiple print formats`

So writing your own mystery using this template will be easy:  You just create a text file with your
mystery content, and use some markup and helper macros to format it to match the books.  Below is a partial example:

```
%My Example Mystery
% CC BY-NC-SA by You

\documentclass{motw}

%============================================================================
\begin{comment}

You can put some helpful comments here if you like.

\end{comment}
%============================================================================

\begin{document}
\graphicspath{ {../images/mystery_example_mystery/} }

% Mystery title
\Mystery{Example Mystery}{Your Name}

\Mhead{Concept}

Brief concept of your mystery

\Mhead{Hook}

A hook to draw in the players

\imageTop[width=\paperwidth]{header3}
\imageCredit[modified]{Title for art}{artist}{Public Domain}

\makeImageCredits[cc-by-nc-sa]

\end{document}
```

### LaTeX basics
LaTeX is a complicated and sophisticated language for formatting text that has been in continuous use and
updates since the 70's.  So a thorough understanding is beyond this manual (and this manual's author.)
But this template is designed to be as simple as possible to use, so to get started you will only need to
learn a few basic things:

* Comments start with a `%` - everything after the `%` is ignored.  `% This is a comment.`

* Macro commands start with a `\`, have optional arguments enclosed in `[]` braces, and mandatory arguments enclosed in `{}` braces.
`\exampleMacro[optional_argument]{argument 1}{argument 2}`

* Excess spaces are ignored, as are single line breaks.

* To insert a paragraph break, use an empty line
```
one line

another line
```
or use `\\` to indicate one
```
one line \\
another line
```

* Only the text between the macros `\begin{document}` and `\end{document}` is in the final PDF.  Things outside 
of this in the header are used to set up macros and other processing.  One example is setting the document template
to this one: `\documentclass{motw}`

* You can do some basic formatting with `\emph{}` to italicize, and `\textbf{}` to bold text.

* sizes have to specify units, such as `4.5in` for four and a half inches, or `11pt` for 11 points.

That should be enough to get you started.  More information (much, *much* more) about LaTeX can be found online.

### Headers

The Monster of the Week books aren't completely consistent in style, but generally within a mystery they
only have three types of headers:  The mystery name, a large header, and a smaller header.  

The larger and smaller headers are made in this template by using the macros `Mheader` and `mheader` 
(note the capital `M`) for the larger header and smaller header, respectively. Usually, `Mheader` is
used for sections like "Hook" and "Threats", while the smaller header is used for things like the
individual monsters.  

The mystery name has a special macro, so that it can be formatted correctly with the author name.
It looks like this `Mystery{mystery title}{mystery author}`

An example:

```
\Mystery{The threat of Doctor Minionson}{Example Author}

\Mhead{Hook}

The hunters get a call from their agency about a mysterious happening they are to investigate

\Mhead{Threats}

\mhead{Doctor Minionson}

Doctor Minionson is up to no good!
```

### Countdown Clock

There is a custom macro for building your countdown clock, as these are a standard feature of MotW mysteries.
The macro is used as follows:
```
\Countdown%
{What happens during the 'day'}%
{What happens during the 'shadows'}%
{What happens during the 'sunset'}%
{What happens during the 'dusk'}%
{What happens during the 'nightfall'}%
{What happens during the 'midnight'}%
```
Note the `%` at the end of the line - this is a LaTeX convention to avoid having extra spaces inserted in the document,
by making the line break a comment.

### Monster Name and Motivation

There is a custom macro for creating the name and motivation for monsters, minions, phenomenon, bystanders, and locations.  You can call it with
`\Cast{Monster Name}{monster}{beast}` or `\Cast{Bystander Bill}{bystander}{victim}`  All the types listed in MotW and ToM are present, but you are
welcome to make your own.  The code is just

```
\mhead{Monster, minion, phenomenon, bystander, or location name}
\emph{category like beast or victim (motivation: the thing's motivation)}
```

### Monster Stats

Within the books, there are two ways that powers, moves, attacks, etc. are listed.  One is a bulleted list, and the other is a line with each power
or stat delineated by bold-faced words.  We have helper macros for both, and you can change between them by changing the outer block if you decide
one or the other looks better.

Bulleted list style example:
```
\begin{mStatList}{Stat category, such as Attacks or Moves}
    \mStat{Stat name, such as "sharp claws"}{stat value, such as 2-harm}
\end{mStatList}
```

Bold-delineated block style example:
```
\begin{mStatBlock}{Stat category, such as Attacks or Moves}
    \mStat{Stat name, such as "sharp claws"}{stat value, such as 2-harm}
\end{mStatBlock}
```

As you can see, the only difference is the name of the block type in the `\begin{}` macro.  So feel free to try out different options.

### Harm Tracks

To insert a harm track for your monster, minion, or bystander, use the macro `\harmtrack{7}`  Here, `7` is the number of harm boxes
your monster has.  There is an extra space inserted between every 5 boxes to make counting visually easier.  If you would like a bar
delineating when your minion or bystander becomes unstable, it can be given as an optional argument, such as `\harmtrack[3]{7}` for
the default human harm track.  Though, as humans are a very common minion, you can also use the shortcut `\humanharmtrack` which is
identical.

### Images

First, to use images, you must tell LaTeX where the images for your mystery are.  This must be done within the document, in other words between
the `\begin{document}` and `\end{document}` macros.  The command to do this, if your mystery's images are in the folder `images/mystery_template` and your document is in `latex/mystery_mymystery.tex` is: `\graphicspath{ {../images/mystery_template/} }`

#### Centered Images

Three macros are available for placing images centered on the page.  In the original Monster of the Week books, more than 2/3rds of the images are centered, so this should be your most common image placement too.  The three commands are: `\imageTop`, `\imageHere`, and `\imageBottom`.  They place the image you give them at the top of the page, at the location you are in the text, and at the bottom of the page, respectively.  They take the image name (without extension) as a parameter, e.g: `\imageTop{a_nice_header_image}`

All three also take an optional `width` parameter.  So if you wanted your header to be scaled to be the same width as the page, you would  use: `\imageTop[width=\paperwidth]{a_nice_header_image}`.  If you want it to be scaled to 4 inches instead, you would use `\imageTop[width=4in]{a_nice_header_image}`.  Note that all sizes have to be specified; but latex is pretty liberal with the types of sizes you can use.  `in` for inches, `cm` for centimeters, `pt` for point, `em` for the width of the letter 'm' in the current font, and so on.

The Top and Bottom image macros also take an `xoffset` and `yoffset` parameter for fine-tuning the position.  This can be helpful if you want the image to be above the page number, for example.

#### Side Images

Unfortunately, one thing latex does not do well is wrap text around images positioned at the sides of pages.  There are numerous workarounds and packages, but the ones I tried (such as /wrapfloat) did not give me the control or results I wanted.  So I wrote my own hacky macro to place images on the side.  It is trickier to use than my centered image macros, so be warned!

##### The first caveat: You must specify the text next to the image

The macro works by taking the image, and a bunch of text, and making them into its own little mini-page.  Then it can place this mini page onto the text normally.  Unfortunately, this means you will have to tell the macro specifically which text you want to be beside the image; it can't figure it out automatically.  This is passed in as the last parameter in the image macro, which looks like this:

```
\imageRight[width=2in, margin=0.5in, position=center]{my_image_name}{%
Here is the short bit of text that will be typeset next to your image.  If it is too long or too short, it won't look correct; so you might have to experiment some!}
```

As you can see, it is more cumbersome and has more options than the top and bottom macros.  The parameter `width=2in` is the same, and sets the width of the image.  `margin=0.5` tells the macro how far into the margin the image should extend - in the original, images ranged from flush with the text, all the way out to the side of the paper (`margin=1in`)

The optional parameter `position=center` only matters if you have more text than image - if so, the image will be vertically centered next to the text block.  The other option is `bottom`.  It will also accept `top`, but it won't do what you want; sorry.

Fortunately, you can put pretty much any text into the macro - headings, lists, tables, etc. should all work fine (try that with the wrapfigure package sometime)

##### The second caveat: Indents

Text on the minipage does not indent properly.  The side image macro adds an indent by default, as aligning your image with the start of a paragraph is the typical case.  You can disable this by passing a zero size as a parameter: `indent=0in`.

If your image / text block spans multiple paragraphs, you may have to manually add paragraph indentations.  The standard latex indent size is `\hspace{1.5em}`; put that in front of your paragraph to indent it properly.


###### The third caveat: the space above the image/text pair is sometimes too large

Unfortunately I haven't found a reliable solution for this.  If latex can't fit the next element on the bottom of the page (a large image, a table, etc.) it will put it on the next page, and stretch the space between distinct elements on this page to avoid large empty areas.  Because the text and image is considered a different element than the rest of the text, it will insert space between them.  Add more text to fill your page, enlarge your image, or otherwise fill the page to fix this.

#### Image Credits and Copyright

I love artists, and crediting people properly.  So when I use an image, I always make certain to include as much information
about the artist and the copyright as I can.  Year of Monsters has a macro for assigning an artist and copyright to an image,
and then printing them out at the end of the mystery, where they won't get in the way during gameplay.

To credit an artist, use the `\imagecredit` macro.  It takes three parameters: a name for the image, the name of the artist,
and the copyright.  For example: `\imagecredit{Scary Monster}{A. Rtist}{CC-BY-SA}` would put in the credits a line like
*"Scary Monster"* by A. Rtist, *CC-BY-SA*.

Sometimes, I must edit an image heavily to make it fit with the Monster of the Week style, such as converting it to grayscale
or line art.  To credit the original artist whose work I modified, I add the optional parameter `[modified]`, which changes
the "by" line to "original by" so that people don't judge the original artist harshly for my poor editing skills.  Make certain
if you distribute your own mysteries with modified images that you choose images with a copyright policy that allows for that,
such as CC-0, Public Domain, CC-BY, etc.

If you don't know who the artist is (maybe the image came from a clipart collection or ancient manuscript) you can leave the
artist parameter blank `{}`, and "not attributed" will be inserted instead of "by artist name" or "original by artist name."

##### Printing copyrights

To print out your image credits, and optionally your own copyright information, use the `\makeimagecredits` macro at the end of your document. You can pass it an optional parameter with the copyright for your own material as well, such as `Public Domain`.  If you use a lower-case version of most creative commons licenses, the appropriate CC image will be inserted instead.  Example:

`\makeimagecredits[cc-by-nc-sa]`

## To contribute

`TODO: how to contribute, what the style / image copyright /etc. are`

## Images used in these mysteries

### Hey, my artwork is on here and it shouldn't be!

I *only* take artwork that is marked Public Domain, or has an appropriate copyleft policy such as Creative Commons.  Of course, I have no way of verifying that the person who posted the image with a PD or CC actually owns the rights to do so!  If I have used your artwork in error, and you wish for me to stop, contact me with proof and I'll remove it immediately.

### Hey, my artwork is here, and you've hacked it up so bad I don't want to be associated with it!

Sorry.  I'll be happy to take your name off it; I've done some terrile things in the name of mangling otherwise good artworks into the black and white line-art style of the origional Mystery of the Week books.

### Seriously, your photo manipulation is bad!

It is.  I'd say I'm a talentless hack, but even a hack *aspires* to be an artist.  I've no such pretentions.  I like working with latex and writing; I just add images to better match the original style, and I use a grand total of about fifteen minutes of youtube learning in Gimp to accomplish it.  If you've got better artwork you'd like me to use instead, send it my way!