# Scratch notepad for Year of Monsters

## Project notes (mostly unsorted)

### LaTeX Workshop (VS Code plugin)

Currently has custom recipes in settings.json to work with xelatex, which is required for decent 
fonts (or lualatex, but workshop), but workshop keeps closing github issues that show how these
should be added.

CHANGED: Now we are using latexmk instead, and have set up latex workshop to work with that instead.

### Design Notes

#### Monsters of the Week physical book measurements

* Width: 6 inches, Height: 9 inches
* Margins: Top: 0.5 inches, outside: 0.9 inches, inside 1.05 inches, bottom: 0.4 inches (page numbers too)
* Vertical chapters: 0.5 inches from outside (page number slightly less for 3-digit pages)
* This gives text size of 8.1 high x 4.05 wide, 4.5 wide counting page numbers/chapter
* Actual width is 4.1 wide, with 11 point font, when using latex
* vertical chapter font: 2mm smallcaps? (6 point) (pdf says 7 pt)
* Normal font: 2.4mm (7 point) (pdf says 10 pt)
* Section: 10mm (28 point) (pdf says 36 pt)
* Subsection: 7.4mm (21 point) (pdf says 24)
* subsubsection 4.9mm (14 point) (pdf says 15)
* page numbers 6.6mm (19 point) (pdf says 20)
* Chapter (Varies, around 14mm, with a 7.4mm "the") (40 point) (pdf says 48)
* Chapter plain text: 3.6mm (10 point) (pdf says 12)
* 3rd man font progression (measured): 14, 19,21,28,40
* 3rd man font progression (pdf): 15, 20,24,36,48
* 3rd man font sizes: smallest is 14, 1.2 incriments are 17, 20, 24, 29, 35, 42, 50
* If smallest is 15, 18, 22, 26, 31, 37, 45

#### Fitting to paper:

##### A5

* 5.82 x 8.26
* Would require removing 0.11 from each side margin, and a total of 0.74 from top/bottom, when we only have 0.9!

##### Double-fit on A4:

* Automatic using A5 setup above

##### Double-fit on US-Letter:

* 8.5 x 11
* half is 5.5 x 8.5
* Would require removing 0.27 from each side, and 0.5 total from top/bottom

##### Changing to new dimension:

* Our shortest height is 8.26 inches; our shortest width is 5.5.
* Recommended minimum margins are 5% of distance per side, which is 0.275 for width and 0.413 for height.
* Applying these would get us a printable area of 7.2 x 5, compared to the original 8.1 x 4.5.
* Total volume of original is 36.5 inches, total of wider shorter is 36.  But visually it will be noticeably squatter (aspect 1.44, original 1.8)
* 1.8 aspect ratio would be 4 inch width, 29 inch volume (so 20% less space), but similar 1 inch margins on each side

##### Double-fit on US letter:

* Keeping marins the same is approximately 7.6 x 4 instead of 8.1 x 4.5, a decrease of 15%.  Keeping width 4.5 would be a 5% space reduction.

#### Images

* Full Page images (every chapter)
* Full top: 21
* Full bottom: 32
* Outside bottom edge: 14 (7 into margin, 6 ragged text)
* Inside bottom edge: 3
* Outside top edge: 1
* Inside top edge: 1


## Notes for Year of Monsters:

* Make this playbook more broad - include late-season Scully?  Make it something different than an "expert"
* Maybe choose a past - rich parents, tribal life in the jungle, struggling poor person?
* 'I know where it is weak' - move for double doctor, add armor piercing to all attacks
* Karmic guide? - Instead of chosing a glitch on use magic, can give the keeper one? hold (-1 on a roll) to borrow against future luck
* Spirit quest based sharp check? see other playbooks for examples
* war chant - can use magic to enchant one of each hunters weapons
* definitely some investigate options based on sharp for diseases and curses?
* maybe some curses?
* Connections to other hunters - In a vision quest, you were directed to (choose one): help them complete a task, stop them from completing a task
* your tribe or ancestors once wronged them
* someone you cured of a curse or disease

## Stories

* Story size in ToM:
* 4 pages: 16%
* 5 pages: 28%
* 6 pages: 32%
* 7 pages: 12%
* 8 pages: 12%
* 9 pages: 4%
* 10 pages: 4%

# Horror notes
* Subtle violence / threats of violence.  Things like waking up to find a lock of hair missing, then dreading the witchcraft
* dilemas - set up bad choices.  Let the bad guy go so he can help you save an innocent - bad guy gets out, or innocent dies?