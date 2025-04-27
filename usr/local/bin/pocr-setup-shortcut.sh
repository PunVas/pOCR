#!/bin/bash
set -e

echo "Configuring pOCR custom shortcut..."

CUSTOM_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-pocr/"
SCRIPT_PATH="/usr/local/bin/pocr.sh"

EXISTING_BINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

if [ "$EXISTING_BINDINGS" = "@as []" ]; then
    NEW_BINDINGS="['$CUSTOM_PATH']"
else
    if echo "$EXISTING_BINDINGS" | grep -q "$CUSTOM_PATH"; then
        echo "🔵 Shortcut already exists in list. Skipping adding to bindings."
        NEW_BINDINGS="$EXISTING_BINDINGS"
    else
        EXISTING_BINDINGS_CLEAN=$(echo "$EXISTING_BINDINGS" | sed -e "s/^\[//" -e "s/\]$//")
        NEW_BINDINGS="[$EXISTING_BINDINGS_CLEAN, '$CUSTOM_PATH']"
    fi
fi

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_BINDINGS"

sleep 1

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" name "'pOCR Screenshot and Extract'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" command "'$SCRIPT_PATH'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" binding "'<Shift>Print'"

echo "Shortcut created or updated successfully!"
