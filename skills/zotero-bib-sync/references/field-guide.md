# Zotero Bib Sync Field Guide

## Identify the library

- Personal collection URL:
  - `https://www.zotero.org/<username>/collections/<collection_key>`
- Group collection URL:
  - `https://www.zotero.org/groups/<group_id>/<group_name>/collections/<collection_key>`
- Personal profile pages often expose `profileUserID` in the HTML.

## Minimal env file

```bash
export ZOTERO_LIBRARY_ID=YOUR_NUMERIC_ID
export ZOTERO_LIBRARY_TYPE=user
export ZOTERO_COLLECTION_KEY=YOUR_COLLECTION_KEY
export ZOTERO_API_KEY=YOUR_API_KEY_IF_PRIVATE
export ZOTERO_EXPORT_FORMAT=biblatex
export ZOTERO_BIB_FILE=references.bib
```

## Repo wiring pattern

- Manuscript:
  - `\addbibresource{references.bib}`
- Makefile:
  - `zotero-sync:`
  - `./sync_zotero_bib.sh`
  - `pdf-sync:`
  - `ZOTERO_SYNC=1 ./build_tex.sh main.tex`
- Build helper:
  - Read `ZOTERO_SYNC=1`
  - Run the sync script before `latexmk`
- Git hygiene:
  - Ignore `.zotero.env`
  - Ignore `.zotero.env.*`

## Validation commands

```bash
./sync_zotero_bib.sh
make pdf-sync
rg -n "addbibresource|bibliography\\{" path/to/main.tex
rg -n "undefined references|Please \\(re\\)run Biber|Empty bibliography" *.log *.blg
```

## Common failure modes

- Login redirect:
  - The collection is private or the URL is wrong.
- Secret leakage risk:
  - Keep only `.zotero.env.example` in version control.
  - Store real credentials in an ignored `.zotero.env`.
- Different citekeys after sync:
  - Zotero API export keys do not match Better BibTeX keys.
  - Keep a compatibility `.bib` or migrate citekeys deliberately.
- Build works incrementally but fails after clean:
  - Check whether a legacy `.bib` compatibility layer was masking missing keys.
- Missing toolchain:
  - Load the project TeX environment before running `latexmk` or `biber`.
