#!/usr/bin/env bash
# Instala em ~/.local/bin o mesmo Hugo extended que o CI usa.
# A versão é lida de .github/workflows/ci.yml: mude lá e rode de novo.
set -euo pipefail

[[ "$(uname -s)" == "Darwin" ]] || { echo "Script para macOS. No Dev Container o Hugo já vem instalado."; exit 1; }

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
version="$(grep -m1 -E 'hugo-version:' "$repo_root/.github/workflows/build.yml" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
dest="${HUGO_INSTALL_DIR:-$HOME/.local/bin}"
pkg="hugo_extended_${version}_darwin-universal.pkg"
base="https://github.com/gohugoio/hugo/releases/download/v${version}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Baixando Hugo extended ${version}..."
curl -fsSL -o "$tmp/$pkg" "$base/$pkg"
curl -fsSL -o "$tmp/checksums.txt" "$base/hugo_${version}_checksums.txt"

expected="$(awk -v f="$pkg" '$2 == f {print $1}' "$tmp/checksums.txt")"
actual="$(shasum -a 256 "$tmp/$pkg" | awk '{print $1}')"
if [[ -z "$expected" || "$expected" != "$actual" ]]; then
  echo "Checksum SHA-256 não confere — abortando."; exit 1
fi
echo "Checksum OK."

# Extrai o binário do .pkg sem instalar nada no sistema (sem sudo)
pkgutil --expand-full "$tmp/$pkg" "$tmp/expanded"
bin="$(find "$tmp/expanded" -type f -name hugo | head -1)"
[[ -n "$bin" ]] || { echo "Binário hugo não encontrado no pacote."; exit 1; }

mkdir -p "$dest"
install -m 0755 "$bin" "$dest/hugo"
echo "Instalado em $dest/hugo"
"$dest/hugo" version

case ":$PATH:" in
  *":$dest:"*) ;;
  *) echo; echo "Adicione ao ~/.zshrc e abra um terminal novo:"; echo "  export PATH=\"$dest:\$PATH\"" ;;
esac

active="$(command -v hugo || true)"
if [[ -n "$active" && "$active" != "$dest/hugo" ]]; then
  echo; echo "Atenção: 'hugo' no PATH ainda é $active."
  echo "Remova a versão do Homebrew:  brew uninstall hugo"
fi
