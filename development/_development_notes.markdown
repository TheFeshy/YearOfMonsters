# Development Notes

---

## Differences between public/private repos

### Folders not included in public

* content/mysteries (all the mysteries I'm working on, including unfinished ones - this will be template only)
* development (this folder, which includes all my notes, inspiration, partially finsihed tools, etc.)
* .vscode (see settings.json)

### settings.json

Local settings for just this workspace; included in git for now.  Does two things:

* Disables pytest (because it keeps creating directories)
* changes the latex plugin to just call `latexmk`, as we have set up our `.latexmkrc` to do everything properly when invoked.

### How to push to each repository


---

## Mystery Status
`TODO: re-do the "day" on each countdown based on Sand's recommendation`

### Completed

* Elvis has Entered the Building
* Oklahoma Jaws

### In Progress

* Thank you for Shopping
* The Bone Collector

---

## Building releases

To build releases, just call ./development/release_quality.sh from the root folder.
