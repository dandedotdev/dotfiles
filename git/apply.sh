#!/usr/bin/env bash
#
# Apply git global configuration.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITCONFIG_SOURCE="$SCRIPT_DIR/.gitconfig"
GITCONFIG_TARGET="$HOME/.gitconfig"
GITCONFIG_BACKUP="$HOME/.gitconfig.backup"

echo "Applying Git global configuration..."

if [ -f "$GITCONFIG_TARGET" ] && [ ! -f "$GITCONFIG_BACKUP" ]; then
  echo "Backing up existing .gitconfig to $GITCONFIG_BACKUP"
  cp "$GITCONFIG_TARGET" "$GITCONFIG_BACKUP"
fi

echo "Copying gitconfig to $GITCONFIG_TARGET"
cp "$GITCONFIG_SOURCE" "$GITCONFIG_TARGET"

echo "✅ Git global configuration applied successfully!"
