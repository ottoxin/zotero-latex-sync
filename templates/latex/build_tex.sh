#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./build_tex.sh [--clean] [path/to/file.tex]

Optional:
  ZOTERO_SYNC=1 ./build_tex.sh main.tex
EOF
}

action="build"
tex_input="main.tex"

while (($#)); do
  case "$1" in
    --clean)
      action="clean"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      tex_input="$1"
      shift
      ;;
  esac
done

if [[ ! -f "$tex_input" ]]; then
  echo "TeX file not found: $tex_input" >&2
  exit 1
fi

tex_dir="$(cd "$(dirname "$tex_input")" && pwd)"
tex_name="$(basename "$tex_input")"

cd "$tex_dir"

if [[ "${ZOTERO_SYNC:-0}" == "1" ]]; then
  ../scripts/sync_zotero_bib.sh
fi

case "$action" in
  build)
    latexmk -pdf -interaction=nonstopmode -halt-on-error "$tex_name"
    ;;
  clean)
    latexmk -c "$tex_name"
    ;;
esac
