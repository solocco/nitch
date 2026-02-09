#!/bin/sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

LINK="https://github.com/solocco/nitch/releases/download/v1.0.1/nitch"
INSTALL_PATH="/usr/local/bin/nitch"

clear
printf "${CYAN}╔════════════════════════════════╗${NC}\n"
printf "${CYAN}║    Nitch Installer v1.0        ║${NC}\n"
printf "${CYAN}╚════════════════════════════════╝${NC}\n\n"

# Nerd Font Warning
printf "${YELLOW}${BOLD} Warning!${NC}\n"
printf "${YELLOW}This installer uses Nerd Font icons.${NC}\n"
printf "${YELLOW}Please make sure you have a Nerd Font installed.${NC}\n\n"

printf "${CYAN}Download Nerd Fonts at:${NC}\n"
printf "${BLUE}https://www.nerdfonts.com/${NC}\n\n"

# Confirmation
printf "${GREEN}Do you want to continue? ${NC}${BOLD}(y/n)${NC}: "
read -r response

if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
    printf "\n${RED} Installation cancelled.${NC}\n\n"
    exit 0
fi

printf "\n"

# Remove old installation
if [ -f "$INSTALL_PATH" ]; then
    printf "${YELLOW} Removing old installation...${NC}\n"
    sudo rm -fv "$INSTALL_PATH"
    printf "\n"
fi

# Download
printf "${BLUE} Downloading nitch...${NC}\n"
if wget -q --show-progress "$LINK"; then
    printf "${GREEN} Download successful!${NC}\n\n"
else
    printf "${RED} Download failed!${NC}\n"
    exit 1
fi

# Set permissions
printf "${BLUE} Setting permissions...${NC}\n"
chmod +x nitch
printf "${GREEN} Permissions set${NC}\n\n"

# Install
printf "${BLUE} Installing to system...${NC}\n"
if sudo mv nitch "$INSTALL_PATH"; then
    printf "${GREEN} Installation successful!${NC}\n\n"
else
    printf "${RED} Installation failed!${NC}\n"
    exit 1
fi

# Verify installation
if command -v nitch >/dev/null 2>&1; then
    printf "${GREEN}╔════════════════════════════════╗${NC}\n"
    printf "${GREEN}║  Nitch installed successfully! ║${NC}\n"
    printf "${GREEN}╚════════════════════════════════╝${NC}\n\n"
    printf "Run with: ${YELLOW}${BOLD}nitch${NC}\n\n"
    
    # Optional: Run nitch to show it works
    printf "${CYAN} Preview:${NC}\n\n"
    nitch
    printf "\n"
else
    printf "${RED} Installation completed but nitch not found in PATH${NC}\n\n"
fi
