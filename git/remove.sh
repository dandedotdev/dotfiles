#!/usr/bin/env bash
#
# Remove git global config.

set -e

GITCONFIG_BACKUP="$SCRIPT_DIR/.gitconfig.backup"
GITCONFIG_TARGET="$HOME/.gitconfig"

echo "Removing Git global configuration..."

if [ -f "$GITCONFIG_BACKUP" ]; then
  echo "Restoring backup .gitconfig"
  cp "$GITCONFIG_BACKUP" "$GITCONFIG_TARGET"
  echo "Removing backup file"
  rm "$GITCONFIG_BACKUP"
  echo "✅ Git configuration restored from backup and backup removed!"
else
  if [ -f "$GITCONFIG_TARGET" ]; then
    echo "No backup found, removing .gitconfig"
    rm "$GITCONFIG_TARGET"
    echo "✅ Git configuration removed!"
  else
    echo "⚠️  .gitconfig does not exist"
  fi
fi
