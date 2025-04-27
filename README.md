# pOCR

**pOCR** (personal OCR) is a simple Bash script to quickly capture a selected area of your screen, extract text using OCR (Tesseract), and copy it directly to your clipboard.

## Features
- Select any part of your screen.
- Extract text from the selected screenshot.
- Automatically copies the text to clipboard.
- Sends a desktop notification (optional).

## Requirements
- `slop` (for area selection)
- `scrot` (for taking the screenshot)
- `tesseract` (for OCR)
- `xclip` (for clipboard copy)
- (Optional) `notify-send` (for notification)

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
