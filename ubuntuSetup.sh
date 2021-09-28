######################Functions######################
# Install Gnome-Tweaks extensions (Add desired extension's .zip file to the
#   Extensions folder. If the Extensions folder does not exist, please create
#   in the same current directory.)
function installExtension()
{
  # Get UUID from extension metadata.json
  uuid=$(unzip -c "Extensions/$1.zip" metadata.json | grep uuid | cut -d \" -f4)

  #Create extension's directory
  mkdir -p ~/.local/share/gnome-shell/extensions/$uuid

  #Unzip all the contents from extension's zip
  unzip -q "Extensions/$1.zip" -d ~/.local/share/gnome-shell/extensions/$uuid/

  #Enable extension
  gnome-extensions enable $uuid
}

###################End of Funtions###################

# Add PPAs
echo ""
echo "************************"
echo "Adding PPAs"
echo "************************"
echo ""
sudo add-apt-repository ppa:alexlarsson/flatpak
sudo add-apt-repository ppa:kisak/kisak-mesa # Stable AMD graphic drivers

# Update system
echo ""
echo "************************"
echo " Updating System"
echo "************************"
echo ""
sudo apt update; sudo apt -y --allow-downgrades upgrade

# Install Apps
echo ""
echo "************************"
echo "Installing Apt Packages"
echo "************************"
echo ""
sudo apt install -y --allow-downgrades steam lutris gamemode google-chrome-stable \
atom cool-retro-term discord snapd piper dolphin-emu \
gnome-tweaks rclone freerdp2-x11 flatpak

echo ""
echo "************************"
echo "Installing Gnome Extnesions"
echo "************************"
echo ""
# Install Gnome-Tweaks extensions
installExtension putWindows
installExtension dashToDock
installExtension audioSwitcher

# Install snap packages
echo ""
echo "************************"
echo "Installing Snap Packages"
echo "************************"
echo ""
sudo snap install whatsdesk

# Configure Flatpak
echo ""
echo "************************"
echo "Configuring FlatPak with flathub"
echo "************************"
echo ""
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Setup cool-retro-terminal as default Terminal
echo ""
echo "************************"
echo "Setting up cool-retro-term as default Terminal"
echo "************************"
echo ""
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator \
/usr/bin/cool-retro-term 50

# Restart Gnome-Shell (Leave this as the last command)
echo ""
echo "************************"
echo "Restarting Gnome Shell"
echo "************************"
echo ""
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s \
'Meta.restart("Restarting…")'
