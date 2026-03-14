# Setup Guide

## 1. Collect the Zotero details

You need:

- Zotero collection URL, or:
  - `ZOTERO_LIBRARY_ID`
  - `ZOTERO_LIBRARY_TYPE`
  - `ZOTERO_COLLECTION_KEY`
- `ZOTERO_API_KEY` only if the library or collection is private

Collection URL patterns:

- User collection:
  - `https://www.zotero.org/<username>/collections/<collection_key>`
- Group collection:
  - `https://www.zotero.org/groups/<group_id>/<group_name>/collections/<collection_key>`

If you are deciding which collection to sync, a good default is one collection per paper or chapter.

Example:

```text
My Library
├── mts-525-paper
├── dissertation-ch2
└── general-reading
```

For the `mts-525-paper` manuscript, sync only the `mts-525-paper` collection.

Helpful Zotero docs with screenshots:

- https://www.zotero.org/support/collections_and_tags

## 2. Copy the toolkit files into your paper repo

Minimum:

- `scripts/sync_zotero_bib.sh`
- `.zotero.env` copied from `templates/.zotero.env.example`

Optional:

- `templates/latex/Makefile.example`
- `templates/latex/build_tex.sh`
- `templates/latex/biblatex-snippet.tex`

## 3. Fill in `.zotero.env`

Example:

```bash
export ZOTERO_LIBRARY_ID=YOUR_NUMERIC_ID
export ZOTERO_LIBRARY_TYPE=user
export ZOTERO_COLLECTION_KEY=YOUR_COLLECTION_KEY
export ZOTERO_EXPORT_FORMAT=biblatex
export ZOTERO_BIB_FILE=references.bib
```

## 4. Update your LaTeX file

For `biblatex`:

```tex
\usepackage[backend=biber]{biblatex}
\addbibresource{references.bib}
```

## 5. Test the sync

```bash
./scripts/sync_zotero_bib.sh
```

If the sync succeeds, you should get a local `.bib` file.

## 6. Wire the build

Either:

- run the sync manually before building, or
- add `zotero-sync` and `pdf-sync` targets so `make pdf-sync` refreshes the bibliography first

## 7. Check citekeys

If your manuscript already cites legacy Better BibTeX keys, compare them against the new synced `.bib` before deleting older bibliography files.
