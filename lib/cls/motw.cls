% Monster of the Week Latex Class
%
%  CC BY-NC-SA 2021 Dave
%
%  A latex document class for formatting similar to the Monster of the Week 
%   official books
%
%  See included readme for instructions.
%
% ============================================================================

% 
\ProvidesClass{motw}[2021/07/28 version 0.01 Monster of the Week formatting]

% Set Paths to images and fonts
\newcommand\copyrightPath{./lib/copyrightimgs/}
\newcommand\fontPath{./lib/fonts/}

% == Class options ==---------------------------------------------------------

% TODO: switch 6by9 to ebook
% TODO: create "isebook" and "isusletter" and "isiso" macros.
% TODO: create usletter class (maybe a5 as well)

% Set up for 6 inch by 9 inch pages (ebook default and also size of orignal)
\DeclareOption{6by9}{%
    \PassOptionsToClass{10pt}{memoir}%
    \PassOptionsToClass{ebook}{memoir}% Set page size to 9x6
    \def\@USINGSIXBYNINE{}%
}

% pass any unknown options on to the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% Process options, using any defaults specified in ExecuteOptions
\ExecuteOptions{6by9}\ProcessOptions \relax

% Add class features we will always use
\PassOptionsToClass{extrafontsizes}{memoir}

% == Base class memoir ===
\LoadClass{memoir}

% == Packages ==--------------------------------------------------------------
\RequirePackage{pgfkeys} % key/value pairs as arguments
\RequirePackage{microtype} % make small adjustments to font widths
\RequirePackage{lipsum} % Add dummy text for laying out
\RequirePackage{fontspec} % fonts
\RequirePackage[table]{xcolor} % to color countdown clock
\RequirePackage{pgffor} % foreach
\RequirePackage{xintexpr} % basic math
\RequirePackage{etoolbox} % Misc. tools (necessary for box drawing function)
\RequirePackage{tikz}% Drawing package (Harm tracks)
\RequirePackage{xifthen} % For creating our switch statement
\RequirePackage{rotating} % For rotated page headings
\RequirePackage{xstring} % String length measurements
\RequirePackage[absolute,overlay]{textpos} % for text overlays
\RequirePackage{graphicx} % images
\RequirePackage{hyperref} % for document hyperrefs, but used here to set PDF info and TOC

% == Package configuration ==
\usetikzlibrary{shapes.misc,shapes.symbols,calc}

% Add the copyright path to the image path
\graphicspath{{\copyrightPath}}

% Allow our mysteries to add to this path
\newcommand\appendtographicspath[1]{%
    \g@addto@macro\Ginput@path{#1}%
}

% Set depth of label to have a bookmark
\hypersetup{bookmarksdepth=subsubsection}
\hypersetup{bookmarksopen=true}

% == Switch implementation ==-------------------------------------------------
\newboolean{default}
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newcommand{\default}{} % Dummy for default case
\newenvironment{switch}[1]{%
    \setboolean{default}{true}
    \renewcommand{\case}[2]{\ifthenelse{\equal{#1}{##1}}{%
        \setboolean{default}{false}##2}{}}%
    \renewcommand{\default}[1]{\ifthenelse{\boolean{default}}{##1}{}}%
}{}

% == Environment test ==------------------------------------------------------
\def\Mycurrentblock{mStatList} % default to list
\def\ifenv#1{
   \def\@tempa{#1}%
   \ifx\@tempa\Mycurrentblock
      \expandafter\@firstoftwo
    \else
      \expandafter\@secondoftwo
   \fi
}

\newfontface\thirdman{3rdMan}[
    Path        = \fontPath/3rdMan/ ,
    Scale       = 2 ,
    Extension   = .otf ,
]
\setmainfont{WarnockPro}[
    Path            = \fontPath/WarnockPro/ ,
    UprightFont     = *-Regular ,
    ItalicFont      = *-It ,
    BoldFont        = *-Bold ,
    BoldItalicFont  = *-BoldIt ,
]

% TODO: Find out why one of these is trying to italicize 3rd man?

% Set up some font commands
\newcommand\pagenumberfont[1]{\Large\thirdman{#1}}
\newcommand\sssfont[1]{\raggedright\small\thirdman{#1}} %sub-sub-section font
\newcommand\ssfont[1]{\raggedright\LARGE\thirdman{#1}} % sub-section font
\newcommand\sfont[1]{\raggedright\Huge\thirdman{#1}} % section font

\newcommand\byfont[1]{\textit{#1}} % mystery author by-line
\newcommand\cdfonta[1]{\Large\textbf{#1}} % Countdown time font
\newcommand\cdfontb[1]{{#1}} % countdown text font
\newcommand\headerfont[1]{\scalebox{1.2}[0.9]{\large\textbf{#1}}} % Sideways header font
% chapter font is Huge, with huge first char and HUGE last char

\setsecheadstyle{\sfont}
\setsubsecheadstyle{\ssfont}
\setsubsubsecheadstyle{\sssfont}

% == Page Layouts ==----------------------------------------------------------

\makepagestyle{motw_basic} % declare our page styles

% Make tables use vertical-aligned cells for complex text
\renewcommand{\tabularxcolumn}[1]{m{#1}}

% Header content
\newcommand{\@headercontent}{%
    \StrLen{\leftmark}[\chapterlen]%
    \ifthenelse{\chapterlen > 0}%
    {\leftmark • \rightmark}%
    {\rightmark}%
}

% Values for text position for laying out with textpos (use block size in inches)
\setlength{\TPHorizModule}{1in}
\setlength{\TPVertModule}{1in}
\textblockorigin{0in}{0in} % start everything near the top-left corner

% == 6' x 9' Layout ==--------------------------------------------------------
\ifdefined\@USINGSIXBYNINE
    \settypeblocksize{7.9in}{4in}{*} % Original measured at 8.1 x 4.1
    \setlrmargins{1in}{*}{*} % one-inch inner margin, auto left, auto ratio
    \setulmargins{0.5in}{*}{*} % 0.5 inch top margin, auto bottom, auto ratio
    \checkandfixthelayout[fixed] % Set up layout

    % Always break on chapter/paragraph headings when possible
    \clubpenalty=10000%
    \widowpenalty=10000%
    %\raggedbottom%

    \setsecnumdepth{none}% Don't number chapters or sections


    % Print page numbers in boxes so we can place them where we want

    \newcommand{\@boxpagenumber}[1]{%
        \def\side{#1} % should be right or left
        \ifthenelse{\equal{\side}{right}}{%
            \def\side{east}%
            \def\offset{-0.5in}%
        }{%
            \def\side{west}%
            \def\offset{0.5in}%
        }%
        \begin{tikzpicture}[remember picture, overlay]%
            \node[xshift=\offset, yshift=0.6in, signal, signal to=west and east, text=black, fill=white]%
            at (current page.south \side)%
            {\pagenumberfont{\thepage}};%
        \end{tikzpicture}%
    }

    \newcommand{\boxchapter}[1]{%
        \def\side{#1} % should be right or left
        \ifthenelse{\equal{\side}{right}}{%
            \def\angle{-90}%
            \def\points{west}%
            \def\side{east}
            \def\offset{-0.5in}%
        }{%
            \def\angle{90}%
            \def\points{east}%
            \def\side{west}
            \def\offset{0.5in}%
        }%
        \begin{tikzpicture}[remember picture,overlay]%
            \node[xshift=\offset, yshift=-.5in, anchor=\points, signal, signal to=west and east, text=black, fill=white, rotate=\angle]%
            at (current page.north \side)%
            {\headerfont{\@headercontent~~}};%
        \end{tikzpicture}%
    }

    % Set up footer
    \makeevenfoot{motw_basic}{\@boxpagenumber{left} \boxchapter{left}}{}{}
    \makeoddfoot{motw_basic}{}{}{\@boxpagenumber{right} \boxchapter{right}}

\fi

\pagestyle{motw_basic} % usea default page style

% == Section definitions ==---------------------------------------------------

% == Mystery ==
\newcommand{\Mystery}[2]{%
    \setaftersecskip{1pt}%
    {\raggedright\section{#1}}%
    \byfont{By #2}\\%
    \setaftersecskip{1ex}%
    \hypersetup{
        pdftitle={#1},
        pdfauthor={#2}, 
        pdfsubject={A Mystery for Monster of the Week},
    }
}

% == Basic headers ==
\newcommand{\Mhead}[1]{%
    \subsection{#1}%
}

\newcommand{\mhead}[1]{%
    \subsubsection{#1}%
}

% == Countdown Clock ==

% Set up colors used
\definecolor{cdcolor1}{gray}{1.0}
\definecolor{cdcolor2}{gray}{0.9}
\definecolor{cdcolor3}{gray}{0.8}
\definecolor{cdcolor4}{gray}{0.7}
\definecolor{cdcolor5}{gray}{0.6}
\definecolor{cdcolor6}{gray}{0.5}

\newcommand{\Countdown}[8][0.9]{%
    \subsection{Countdown}%
    \begin{center}%
        \begin{tabularx}{#1\textwidth}{ |r|>{\raggedright\arraybackslash}X| }%
            \hline%
            \cellcolor{cdcolor1}\cdfonta{Day} & #2 \\ \hline%
            \cellcolor{cdcolor2}\cdfonta{Shadows} & #3 \\ \hline%
            \cellcolor{cdcolor3}\cdfonta{Sunset} & #4 \\ \hline%
            \cellcolor{cdcolor4}\cdfonta{Dusk} & #5 \\ \hline%
            \cellcolor{cdcolor5}\cdfonta{Nightfall} & #6 \\ \hline%
            \cellcolor{cdcolor6}\cdfonta{Midnight} & #7 \\ \hline%
        \end{tabularx}%
    \end{center}%
}

% == Harm Track ==------------------------------------------------------------
\newcommand{\harmtrack}[2][0]{%
    \medskip\noindent\textbf{Harm Capacity:}~#2.~%
    \foreach \i in {1, ..., #2}{%
        \ifthenelse{\equal{\i}{#1}}{\@harmbox\empty{|}}% With divider
        {\@harmbox~}% Not a divider
        \ifthenelse{\equal{\i}{5}}{ }{}%
        \ifthenelse{\equal{\i}{10}}{ }{}%
        \ifthenelse{\equal{\i}{15}}{ }{}%
    }%
}

\newcommand{\humanharmtrack}{%
    \harmtrack[3]{7}%
}

\newrobustcmd*{\@harmbox}{\tikz{\filldraw[draw=black,fill=white] (0,0)%
    rectangle (1.5ex,1.5ex);}% ex should be height of capital, but isn't.
}

% == Stat List / Block ==------------------------------------------------------------
% Environment for bulleted list of stats
\newenvironment{mStatList}[1]{%
    \begin{samepage}%
    \def\Mycurrentblock{mStatList}%
    \medskip\noindent\textbf{#1:}%
    \begin{itemize}%
}{%
    \end{itemize}%
    \end{samepage}%
}

% Environment for linear block of stats, with bold stat name
\newenvironment{mStatBlock}[1]{%
    \begin{samepage}%
    \def\Mycurrentblock{mStatBlock}%
    \medskip\noindent\textbf{#1:}~%
}{%
    \hfil%
    \end{samepage}
}

% A single stat, either in a list or block
\newcommand{\mStat}[2]{%
    \ifenv{mStatList}{% stat inside a stat list
        \item \textbf{#1} #2%
    }{% stat inside a stat block
        \textbf{#1:}~#2
    }
}

% == Helper macros ==---------------------------------------------------------

%TODO: These all need a fall-through default!

% Monster / location /etc. description
% Parameters are name (e.g. "Werewolf"), type (e.g. "monster") and 
% motivation (e.g. "beast")
\newcommand{\Cast}[3]{%
    \mhead{#1}%
    \begin{switch}{#2}%
        \case{monster}{\emph{Monster:~\@monstermotive{#3}}}%
        \case{minion}{\emph{Minion:~\@minionmotive{#3}}}%
        \case{phenomenon}{\emph{Phenomenon:~\@phentype{#3}}}%
        \case{bystander}{\emph{Bystander:~\@bystandertype{#3}}}%
        \case{location}{\emph{Location:~\@locationtype{#3}}}%
        \default{\emph{#2:~#3}}%
    \end{switch}%
    \medbreak
}

\newcommand{\@monstermotive}[1]{%
    \begin{switch}{#1}%
        \case{beast}{Beast (motivation: to run wild, destroying and killing)}%
        \case{breeder}{Breeder (motivation: to give birth to, bring forth, or create evil)}%
        \case{collector}{Collector (motivation: to steal specific sorts of things)}%
        \case{destroyer}{Destroyer (motivation: to bring about the end of the world)}%
        \case{devourer}{Devourer (motivation: to consume people)}%
        \case{executioner}{Executioner (motivatin: to punish the guilty)}%
        \case{parasite}{Parasite (motivation: to infest, control and devour)}%
        \case{queen}{Queen (motivation: to possess and control)}%
        \case{sorcerer}{Sorcerer (motivation: to usurp unnatural power)}%
        \case{tempter}{Tempter (motivation: to tempt people into evil deeds)}%
        \case{torturer}{Torturer (motivation: to hurt and terrify)}%
        \case{trickster}{Trickster (motivation: to create chaos)}%
        \default{#1}%
    \end{switch}%
}

\newcommand{\@minionmotive}[1]{%
    \begin{switch}{#1}%
        \case{assassin}{Assassin (motivation: to kill the hunters)}%
        \case{brute}{Brute (motivation: to intimidate and attack)}%
        \case{cultist}{Cultist (motivation: to save their own skin at any cost)}%
        \case{guardian}{Guardian (motivation: to bar a way or protect something)}%
        \case{righthand}{Right hand (motivation: to back up the monster)}%
        \case{plague}{Plague (motivation: to swarm and destroy)}%
        \case{renfield}{Renfield (motivation: to push victims towards the monster)}%
        \case{scout}{Scout (motivation: to stalk, watch, and report)}%
        \case{thief}{Thief (motivation: to steal and deliver to the monster)}%
        \case{traitor}{Traitor (motivation: to betray people)}%
        \default{#1}%
    \end{switch}%
}

\newcommand{\@phentype}[1]{%
    \begin{switch}{#1}%
        \case{alien}{Alien (motivation: to be unfathomable)}%
        \case{artifact}{Artifact (motivation: to grant someone more power than they can handle)}%
        \case{biohazard}{Biohazard (motivation: to infect, harm, and spread)}%
        \case{bubble}{Bubble (motivation: to keep inside things inside, and outside things outside)}%
        \case{conspiracy}{Conspiracy (motivation: to gather power, keep secrets, and create confusion)}%
        \case{corruption}{Corruption (motivation: to change the laws of the universe)}%
        \case{experiment}{Experiment (motivation: to unleash dangers)}%
        \case{mutagen}{Mutagen (motivation: to transform creatures and people)}%
        \case{panic}{Panic (motivation: to make people act irrationally)}%
        \case{portal}{Portal (motivation: to draw things from one world to another)}%
        \case{teratogen}{Teratogen (motivation: to turn creatures and people into monsters)}%
        \case{zone}{Zone (motivation: to harm all that venture within)}%
        \default{#1}%
    \end{switch}%
}

\newcommand{\@bystandertype}[1]{%
    \begin{switch}{#1}%
        \case{busybody}{Busybody (motivation: to interfere in other people's plans)}%
        \case{detective}{Detective (motivation: to rule out explanations)}%
        \case{gossip}{Gossip (motivation: to pass on rumours)}%
        \case{helper}{Helper (motivation: to join the hunt)}%
        \case{innocent}{Innocent (motivation: to do the right thing)}%
        \case{official}{Official (motivation: to be suspicious)}%
        \case{skeptic}{Skeptic (motivation: to deny supernatural explanations)}%
        \case{victim}{Victim (motivation: to put themselves in danger)}%
        \case{witness}{Witness (motivation: to reveal information)}%
        \default{#1}%
    \end{switch}%
}

\newcommand{\@locationtype}[1]{%
    \begin{switch}{#1}%
        \case{crossroads}{Crossroads (motivation: to bring people, and things, together)}%
        \case{deathtrap}{Deathtrap (motivation: to harm intruders)}%
        \case{den}{Den (motivation: to harbor monsters)}%
        \case{fortress}{Fortress (motivation: to deny entry)}%
        \case{hellgate}{Hellgate (motivation: to create evil)}%
        \case{hub}{Hub (motivation: to reveal information)}%
        \case{lab}{Lab (motivation: to create weirdness)}%
        \case{maze}{Maze (motivation: to confuse and separate)}%
        \case{prison}{Prison (motivation: to constrain and prevent exit)}%
        \case{wilds}{Wilds (motivation: to contain hidden things)}%
        \default{#1}%
    \end{switch}%
}

% == Image macros ==----------------------------------------------------------

% Centered, full image
\pgfkeys{
    /mycenterimage/.is family, /mycenterimage,
    % Default values
    default/.style =
        {width=\textwidth, image_position=top, xoffset=0in, yoffset=0in},
    width/.estore in = \mycenterimageWidth,
    xoffset/.estore in = \mycenterimageXoffset,
    yoffset/.estore in = \mycenterimageYoffset,
    image_position/.style = {positions/#1/.get = \mycenterimagePosition},
    positions/.cd,
        top/.initial = north,
        bottom/.initial = south,
}

% Lengths used by this function
\newlength{\excludeoffset}
\newlength{\iboxheight}
\newlength{\maxexclude}

\newcommand\@centerimage[3][]{%
    % Parse key / value pairs
    \pgfkeys{/mycenterimage, default, #1}%
    % Set up offsets and top/bottom dependent variables
    \def\xoffset{\mycenterimageXoffset}%
    \def\captioncontents{#3}%
    \setlength{\excludeoffset}{\mycenterimageYoffset}%
    \ifthenelse{\equal{\mycenterimagePosition}{north}}{%
        \def\yoffset{-1*\mycenterimageYoffset}%
        \addtolength{\excludeoffset}{-1\uppermargin}%
    }{%
        \def\yoffset{\mycenterimageYoffset}%
        \addtolength{\excludeoffset}{-1\lowermargin}%
    }%
    % Measure the image so we can create bounding boxes later
    \newbox\ibox%
    \sbox\ibox{%
        \includegraphics[width=\mycenterimageWidth]{#2}%
    }%
    \settoheight\iboxheight{\usebox\ibox}%
    % Actually draw the image
    \begin{tikzpicture}[remember picture,overlay]%
        \node[anchor=\mycenterimagePosition, inner sep=0pt,%
            xshift=\xoffset, yshift=\yoffset,%
            text width=\mycenterimageWidth] at (current page.\mycenterimagePosition){%
            \ifthenelse{\equal{\mycenterimagePosition}{north}}{%
                \usebox\ibox%
                \@optionalCaption{\captioncontents}%
            }{%
                \@optionalCaption{\captioncontents}%
                \usebox\ibox%
            }%
        };%
    \end{tikzpicture}%
    % Create a bounding box to exclude text
    \addtolength{\excludeoffset}{\iboxheight}%
    % maximum float size appears to be 59% of text height; don't make it larger
    \setlength{\maxexclude}{0.55\textheight}%
    \ifthenelse{\lengthtest{\excludeoffset > \maxexclude}}{%
        \setlength{\excludeoffset}{\maxexclude}}{}%
    % Place the bounding box in the appropriate place
    \ifthenelse{\equal{\mycenterimagePosition}{north}}{%
        \begin{figure}[!t]%
            \vspace{\excludeoffset}
        \end{figure}%
    }{%
        \begin{figure}[!b]%
            \vspace{\excludeoffset}
        \end{figure}%
    }
}

\newcommand\imageTop[2][]{%
        \@centerimage[#1, image_position=top]{#2}{}%
}

\newcommand\imageBottom[2][]{%
        \@centerimage[#1, image_position=bottom]{#2}{}%
}

\newcommand\imageBottomCaption[3][]{\@centerimage[#1, image_position=bottom]{#2}{#3}}
\newcommand\imageTopCaption[3][]{\@centerimage[#1, image_position=top]{#2}{#3}}

% Centered, full image right here rather than at top or bottom of page
\pgfkeys{
    /mymanualimage/.is family, /mymanualimage,
    % Default values
    default/.style =
        {width=\textwidth},
    width/.estore in = \mymanualimageWidth,
}

\newcommand\imageHere[2][]{\imageHereCaption[#1]{#2}{}}

\newcommand\imageHereCaption[3][]{%
    \pgfkeys{/mymanualimage, default, #1}%
    \def\captioncontents{#3}%
    \begin{figure}[!h]%
        \makebox[\textwidth][c]{%
            \includegraphics[width=\mymanualimageWidth]{#2}%
        }%
        \@optionalCaption{\captioncontents}%
    \end{figure}%
}

% --Side image w/ text macro--------------------------------------------------

% sideimage key / value pair definitions
\pgfkeys{
    % TODO: add in paragraph space to text
    /mysideimage/.is family, /mysideimage,
    % Default values
    default/.style = 
        {width = 2in, margin = 0in, position = center, side = right, height=0in, indent=1.5em},
    width/.estore in = \mysideimageWidth,
    margin/.estore in = \mysideimageMargin,
    height/.estore in = \mysideimageHeight,
    indent/.estore in = \mysideimageIndent,
    position/.style = {positions/#1/.get = \mysideimageImagePosition},
    side/.style = {positions/#1/.get = \mysideimageSide}, %TODO: we don't have sides defined?!
    % List of possible positions and their values
    positions/.cd,
        top/.initial = t, % Do not use; it places the bottom of the image at the top of the text
        bottom/.initial = b,
        center/.initial = c,
        left/.initial = l,
        right/.initial = r,
}

\newcommand\@optionalCaption[1]{%
    \ifthenelse{\equal{#1}{}}{}{\legend{\\\captioncontents}}%
}

% 
\newcommand\tb{\hspace{1.5em}}

%TODO: Lots to clean up; this function is very large and has some copy/past sections that should be broken out.

% Measurements needed for the below function
\newlength\theight%
\newlength\iheight%
\newlength{\mytextwidth}%

% == Side Image ==
% [] key/value pairs from definition above
% #2 text
% #3 image name
\newcommand\@sideimage[4][]{%
    % Parse key / value pairs
    \pgfkeys{/mysideimage, default, #1}%
    % Requried Parameters
    \def\mytext{#3}%
    \def\myimage{#2}%
    \def\captioncontents{#4}%
    % derived values
    \def\myseparation{1.5em}
    \def\mytotalwidth{\textwidth + \mysideimageMargin}%
    \def\mynontext{\mysideimageWidth - \myseparation}
    \setlength{\mytextwidth}{\mytotalwidth - \mynontext}
    % done new
    \def\negmargin{0in - \mysideimageMargin}%
    % Save text and images in boxes to measure and reuse
    \newbox\tbox%
    \newbox\ibox%
    \ifthenelse{\lengthtest{\mysideimageHeight > 0in}}{%
        % Use fixed-height minipages
        \sbox\tbox{%
            \begin{minipage}[t][\mysideimageHeight][t]{\mytextwidth}%
                \mbox{}
                    \hspace{\mysideimageIndent}\mytext%
            \end{minipage}%
        }%
        \sbox\ibox{%
            \begin{minipage}[t][\mysideimageHeight][\mysideimageImagePosition]{\mysideimageWidth}%
                \includegraphics[width=\mysideimageWidth]{\myimage}%
                \@optionalCaption{\captioncontents}%
            \end{minipage}%
        }%
    }{%
        % Use the height of the largest box (text or image) as the height
        \sbox\tbox{%
            \begin{minipage}[t][][t]{\mytextwidth}%
                \mbox{}
                \hspace{\mysideimageIndent}\mytext%
            \end{minipage}%
        }%
        \sbox\ibox{%
            \begin{minipage}[t][][\mysideimageImagePosition]{\mysideimageWidth}%
                \includegraphics[width=\mysideimageWidth]{\myimage}%
                \@optionalCaption{\captioncontents}%
            \end{minipage}%
        }%
        % Measure our boxes to see which is taller:
        \settodepth\theight{\usebox\tbox}%
        \settodepth\iheight{\usebox\ibox}%
        %Re-set the smaller box to match the larger:
        \ifthenelse{\lengthtest{\theight > \iheight}}%
        {%
            \sbox\ibox{%
                \begin{minipage}[t][\theight][\mysideimageImagePosition]{\mysideimageWidth}%
                    \includegraphics[width=\mysideimageWidth]{\myimage}%
                    \@optionalCaption{\captioncontents}%
                \end{minipage}%
            }%
        }{%
            \sbox\tbox{%
                \begin{minipage}[t][\iheight][t]{\mytextwidth}%
                    \hspace{\mysideimageIndent}\mytext%
                \end{minipage}%
            }%
        }%
    }%
    % Set the boxes in a box so we can control which margin it intrudes into
    \ifthenelse{\equal{\mysideimageSide}{r}}{%
        \medskip
        \noindent\usebox\tbox%
        \hspace{\myseparation}%
        \usebox\ibox%
    }{%
        \medskip
        \noindent\hspace*{\negmargin}%
        \usebox\ibox%
        \hspace{\myseparation}%
        \usebox\tbox%
    }%
}

\newcommand\imageLeft[3][]{%
    \@sideimage[#1, side=left]{#2}{#3}{}%
}

\newcommand\imageRight[3][]{%
    \@sideimage[#1, side=right]{#2}{#3}{}%
}

\newcommand\imageLeftCaption[4][]{%
    \@sideimage[#1, side=left]{#2}{#3}{#4}%
}

\newcommand\imageRightCaption[4][]{%
    \@sideimage[#1, side=right]{#2}{#3}{#4}%
}

% == Image Credits macro ==---------------------------------------------------

\newoutputstream{imagecreditsout}
\newinputstream{imagecreditsin}

\newcommand\formatImageCredit[4][n]{%
    \ifthenelse{\equal{#1}{modified}}{\def\byline{original by }}{\def\byline{by }}
    \def\image{#2}
    %\def\artist{#2} % use if statement to handle uncredited artwork instead
    \def\copyright{#4}
    % Handle anonymous artist
    \if\relax\detokenize{#3}\relax \def\artist{(not credited)}\else \def\artist{\byline #3}\fi
    % Output the formatted image credit
    \emph{"\image"} \artist, \emph{\copyright}%
}

\newcommand\imageCredit[4][n]{%
    % If we last read from the file, close it
    \IfStreamOpen{imagecreditsin}{\closeinputstream{imagecreditsin}}{}
    % Open(and clear) the file if necessary
    \IfStreamOpen{imagecreditsout}{}{\openoutputfile{\jobname.imagecredits.aux}{imagecreditsout}}
    \addtostream{imagecreditsout}{%
        • \formatImageCredit[#1]{#2}{#3}{#4}%
    } 
}

%print either the copyright given, or the correct image.
\newcommand\@imageorcr[1]{%
    \def\img{none}%
    \def\height{4ex}
    \begin{switch}{#1}%
        \case{cc-by}{\includegraphics[height=\height]{cc-by}}%
        \case{cc-by-nc}{\includegraphics[height=\height]{cc-by-nc}}%
        \case{cc-by-nc-sa}{\includegraphics[height=\height]{cc-by-nc-sa}}%
        \case{cc-by-sa}{\includegraphics[height=\height]{cc-by-sa}}%
        \case{cc0}{\includegraphics[height=\height]{cc-zero}}%
        \default{\textbf{Copyright Policy: }#1}
    \end{switch}%
}

\newcommand\makeImageCredits[1][]{%
    \def\copypolicy{#1}
    \IfStreamOpen{imagecreditsout}{\closeoutputstream{imagecreditsout}}{}
    \IfStreamOpen{imagecreditsin}{}{\openinputfile{\jobname.imagecredits.aux}{imagecreditsin}}
    {\center\rule{0.6\textwidth}{0.4pt}\par}
    \textbf{Image Credits: }
    \small\readstream{imagecreditsin}
    \ifthenelse{\equal{\copypolicy}{}}{}{%
        \begin{center}
            \@imageorcr{\copypolicy}
        \end{center}

    }
}
