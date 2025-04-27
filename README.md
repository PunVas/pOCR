# pOCR

**pOCR** (personal OCR) is a simple tool to quickly capture a selected area of your screen, extract text using OCR (Tesseract), and copy it directly to your clipboard.

Note: It is only for Debian based systems which use GNOME (Other DEs will be added in future upgrades. Thand rakho add ho jayega. Stay tuned...)


## Features
- Select any part of your screen.
- Extract text from the selected screenshot.
- Automatically copies the text to clipboard.
- Sends a desktop notification.

## Usage
1) Download the .deb file
2) run  
    ```bash
    sudo dpkg -i pOCR-1.0.deb
    ```
3) If keybindings get set automatically, just use Shift+Print, else follow the instructions on  the terminal
   ```bash
   =====================
    INSTALL COMPLETE!
    Please run the following command once to setup the shortcut:

    /usr/local/bin/pocr-setup-shortcut.sh

    After that, you can use Shift+Print Screen!
    =====================
   ```

   4)If still any error occurs, run this to reset the keybinds
   ```bash
   gsettings reset org.gnome.settings-daemon.plugins.media-keys custom-keybindings
    ```

   5) My future plans for this repo
      - A custom screenshot tool
      - Adding GitHub Actions to get releases automatically
      - Adding support for more distros
      - Adding support for more langs.
      - Suggestions by users...
