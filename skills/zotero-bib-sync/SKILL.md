---
name: zotero-bib-sync
description: Set up and maintain Zotero-to-LaTeX bibliography sync for repositories that use biblatex/biber or BibTeX, especially remote, VM, cluster, or CI workflows where Zotero desktop is unavailable. Use when Codex needs to connect a Zotero user or group library or collection to a local .bib file, add sync scripts or .zotero.env files, wire Makefile/build hooks, inspect Zotero library IDs or collection keys, diagnose API-key or privacy issues, migrate bibliography filenames, or preserve citekey compatibility with an existing manuscript.
---

# Zotero Bib Sync

## Decide the sync path

- Prefer Zotero web API sync on remote machines, VMs, clusters, and CI.
- Prefer Better BibTeX desktop auto-export only when the same machine can run Zotero desktop reliably.
- Before editing, inspect the manuscript for `\addbibresource{...}` or `\bibliography{...}`, the bibliography backend (`biber` or `bibtex`), and any existing compatibility `.bib` files.

## Implement web API sync

1. Copy or adapt [scripts/sync_zotero_bib.sh](scripts/sync_zotero_bib.sh) into the target repo.
2. Add a repo-local `.zotero.env.example` and, if the user wants it, a real `.zotero.env`.
3. Wire the build so users can run either an explicit sync target or a sync-plus-build target.
4. Update the manuscript to point at the chosen live `.bib` file.
5. Document the one-time Zotero setup in the repo README.

## Gather Zotero identifiers

- Parse the collection key from a Zotero collection URL.
- Derive the numeric user ID from `https://www.zotero.org/<username>` when the user only provides a username or collection page.
- Test collection metadata before changing the repo:
  - `curl -H "Zotero-API-Key: $ZOTERO_API_KEY" "https://api.zotero.org/users/$ZOTERO_LIBRARY_ID/collections/$ZOTERO_COLLECTION_KEY"`
- Treat a redirect to `/user/login` as evidence that the collection is not publicly readable.
- Require `ZOTERO_API_KEY` only for private libraries or collections.
- Never commit real `.zotero.env` files or API keys. Add ignore rules before creating secrets-bearing files.

## Preserve citekey compatibility

- Compare manuscript citekeys against the synced `.bib` before removing any legacy bibliography file.
- Expect Zotero API export keys to differ from Better BibTeX keys unless the user has already pinned stable citation keys.
- Keep or generate a small compatibility `.bib` layer when the manuscript already cites legacy keys and the user does not want a full citekey migration.
- Archive the old `.bib` before renaming or replacing it.

## Validate

- Run the sync script against the real library or collection.
- Run both the normal build and the sync-plus-build path.
- Inspect `.blg`, `.bbl`, `.bcf`, and the LaTeX log for undefined citations, empty bibliography warnings, or malformed Biber input.
- If a clean rebuild fails but an incremental build passes, inspect compatibility `.bib` layers and Biber inputs before blaming the sync script.

## Resources

- Use [references/field-guide.md](references/field-guide.md) for URL patterns, env vars, repo wiring, and common failure modes.
- Use [scripts/sync_zotero_bib.sh](scripts/sync_zotero_bib.sh) as the default shell implementation.
