# Zotero LaTeX Sync

Small standalone toolkit for syncing a Zotero library or collection to a local `.bib` file for LaTeX projects.

This repo is the non-skill version of the workflow. It is meant to be copied into a normal project or used as a reference when wiring Zotero to `biblatex`/`biber` or BibTeX.

This repo also includes a Codex skill copy under [`skills/zotero-bib-sync`](/projects/p33196/kym9881/zotero-latex-sync/skills/zotero-bib-sync/SKILL.md) so you can use the same workflow either as a plain toolkit repo or as an installable skill.

## What this does

- Pull a bibliography directly from Zotero's web API
- Write the export to a local `.bib` file
- Support user or group libraries
- Work on VMs, clusters, remote servers, and CI where Zotero desktop is not available
- Avoid committing secrets by keeping real credentials in an ignored `.zotero.env`

## What I need from you

To wire this into a real paper repo, I need:

1. Your Zotero collection URL, or your numeric library ID plus collection key
2. Whether the library is a `user` library or `group` library
3. Whether the library or collection is public or private
4. A Zotero API key only if the library or collection is private
5. The target `.bib` filename you want in the LaTeX project
6. The LaTeX entry file and whether the project uses `biblatex`/`biber` or BibTeX
7. Whether the manuscript already has legacy citekeys that must keep working

## How to choose a collection

Most people use one Zotero collection per writing project.

Good defaults:

- one paper -> one collection
- one dissertation chapter -> one collection
- one grant or report -> one collection
- one course project -> one collection

Why:

- smaller `.bib` files
- faster sync
- less clutter in LaTeX autocomplete and bibliography output
- easier citekey cleanup if something changes

Simple example:

```text
My Library
├── MTS 525
├── llm-panel-paper
├── dissertation-ch2
└── general-reading
```

If you are writing `llm-panel-paper`, sync the `llm-panel-paper` collection, not your whole library.

Rule of thumb:

- use a project collection if the document has a clear boundary
- use a broader topic collection only if several documents intentionally share one bibliography
- avoid syncing your whole library unless you really want every reference available in one `.bib`

Official Zotero collections docs with screenshots:

- https://www.zotero.org/support/collections_and_tags

## Quick start

1. Copy the files you need into your project:
   - `scripts/sync_zotero_bib.sh`
   - `templates/.zotero.env.example` copied to `.zotero.env`
   - `templates/latex/Makefile.example` if you want a simple build wrapper
2. Fill in `.zotero.env`
3. Update your `.tex` file to point at your target `.bib`
4. Run:

```bash
./scripts/sync_zotero_bib.sh
```

Or if you wire the provided Makefile pattern:

```bash
make pdf-sync
```

## Files

- `scripts/sync_zotero_bib.sh`: generic Zotero API sync script
- `templates/.zotero.env.example`: safe template for repo-local configuration
- `templates/latex/Makefile.example`: sample Makefile with `zotero-sync` and `pdf-sync`
- `templates/latex/build_tex.sh`: sample `latexmk` helper that can sync before build
- `templates/latex/biblatex-snippet.tex`: minimal `biblatex` snippet
- `docs/setup.md`: full setup walkthrough
- `docs/troubleshooting.md`: common failure modes and fixes
- `skills/zotero-bib-sync`: Codex skill version of the same workflow

## Skill version

If you want the Codex skill form, use:

- [`skills/zotero-bib-sync/SKILL.md`](/projects/p33196/kym9881/zotero-latex-sync/skills/zotero-bib-sync/SKILL.md)
- [`skills/zotero-bib-sync/references/field-guide.md`](/projects/p33196/kym9881/zotero-latex-sync/skills/zotero-bib-sync/references/field-guide.md)
- [`skills/zotero-bib-sync/scripts/sync_zotero_bib.sh`](/projects/p33196/kym9881/zotero-latex-sync/skills/zotero-bib-sync/scripts/sync_zotero_bib.sh)

The toolkit and the skill are both secret-free. Neither one stores a real `.zotero.env` or an API key.

## Helpful links

- Zotero collections docs: https://www.zotero.org/support/collections_and_tags
- Zotero Web API basics: https://www.zotero.org/support/dev/web_api/v3/basics
- Better BibTeX automatic export: https://retorque.re/zotero-better-bibtex/exporting/auto/

## Security

- Do not commit real `.zotero.env` files
- Do not commit API keys
- This repo ignores `.zotero.env` and `.zotero.env.*`

## Notes on citekeys

If your manuscript already cites keys produced by Better BibTeX, Zotero API exports may not match them exactly. In that case you may need one of these:

- keep a small compatibility `.bib`
- migrate the manuscript citekeys
- pin stable Better BibTeX citekeys on the machine where Zotero desktop runs

## Next step

If you want, I can also turn this into a GitHub repo after you review the local version.
