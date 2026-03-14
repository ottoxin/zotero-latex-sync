# Troubleshooting

## Redirect to login

If the Zotero collection URL or API request redirects to `/user/login`, the collection is not publicly readable or the URL is wrong.

Fix:

- verify the collection key
- verify whether it is a user or group library
- add `ZOTERO_API_KEY` if the library is private

## Script says `ZOTERO_LIBRARY_ID is required`

Your `.zotero.env` was not found or is incomplete.

Fix:

- make sure `.zotero.env` exists in the project root
- or pass the values as exported environment variables

## Build has undefined citations

The `.bib` file may be present but the citekeys may not match what the manuscript uses.

Fix:

- compare the keys in the manuscript with the keys in the synced `.bib`
- keep a compatibility `.bib` if needed
- rerun `biber` and LaTeX after syncing

## Build works incrementally but fails from clean state

This usually means an old `.bbl` or compatibility bibliography was masking a missing citekey or missing data source.

Fix:

- inspect `.bcf`, `.blg`, `.bbl`, and the LaTeX log
- confirm all bibliography files named in the manuscript still exist

## Concern about secrets

Do not commit:

- `.zotero.env`
- API keys

Commit only:

- `.zotero.env.example`
- scripts
- templates
- documentation
