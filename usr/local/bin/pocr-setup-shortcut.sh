#!/bin/bash
set -e

echo "🛠 Configuring pOCR custom shortcut..."

# Define constants
CUSTOM_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-pocr/"
SCRIPT_PATH="/usr/local/bin/pocr.sh"

# Fetch existing bindings
EXISTING_BINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# If no custom keybindings exist, create new list
if [ "$EXISTING_BINDINGS" = "@as []" ]; then
    NEW_BINDINGS="['$CUSTOM_PATH']"
else
    # Check if CUSTOM_PATH already exists
    if echo "$EXISTING_BINDINGS" | grep -q "$CUSTOM_PATH"; then
        echo "🔵 Shortcut already exists in list. Skipping adding to bindings."
        NEW_BINDINGS="$EXISTING_BINDINGS"
    else
        # Clean brackets
        EXISTING_BINDINGS_CLEAN=$(echo "$EXISTING_BINDINGS" | sed -e "s/^\[//" -e "s/\]$//")
        NEW_BINDINGS="[$EXISTING_BINDINGS_CLEAN, '$CUSTOM_PATH']"
    fi
fi

# Set (or reset) the bindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_BINDINGS"

# Sleep to allow gnome to register new custom keybinding
sleep 1

# Set shortcut properties
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" name "'pOCR Screenshot and Extract'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" command "'$SCRIPT_PATH'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$CUSTOM_PATH" binding "'<Shift>Print'"

echo "✅ Shortcut created or updated successfully!"
