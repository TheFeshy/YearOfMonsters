# Config file for latexmk, which manages running latex for us

# By default, process all .tex files in any subdirectory in './content' (case insensitive match):
use File::Find::Rule;
@search_dirs=( "./content/" );
@default_files=File::Find::Rule->file()->name( qr/\.(?i)tex/ )->in( @search_dirs );
#@default_files=( './content/sample/test.tex' );

# Don't change to the subdir of the processed file
$do_cd=0;

# Set the output directory
$out_dir='./output/build/';

# Because we use fontenc, we must use either XeLaTeX or LuaLaTeX.
#  - LuaLaTeX = 4
#  - XeLaTeX  = 5
$pdf_mode=4;

# Make certain the motw.cls file is available to our .tex files
ensure_path( 'TEXINPUTS', './lib/cls//:' );

# If you need to override the LuaLaTeX default commands, you can do it here (defaults shown):
$lualatex = "lualatex -interactive=nonstopmode %O %S";

# If you need to override the XeLaTex default commands, you can do it here (defaults shown):
$xelatex = "xelatex -interactive=nonstopmode %O %S";