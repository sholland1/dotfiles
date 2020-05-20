#!/bin/sh
cd ~
rm .compton.conf .conkyrc .scimrc .spectrwm.conf .xinitrc .zprofile .zshrc
ln -s ~/dotfiles/.compton.conf .compton.conf
ln -s ~/dotfiles/.conkyrc .conkyrc
ln -s ~/dotfiles/.scimrc .scimrc
ln -s ~/dotfiles/.spectrwm.conf .spectrwm.conf
ln -s ~/dotfiles/.xinitrc .xinitrc
ln -s ~/dotfiles/.zprofile .zprofile
ln -s ~/dotfiles/.zshrc .zshrc

rm -rdf ~/bin
ln -s ~/dotfiles/scripts/ ~/bin

rm -rdf .local/share/sidewinderd
ln -s ~/dotfiles/.local/share/sidewinderd .local/share/sidewinderd

cd ~/.config
rm nvim/init.vim onedrive/config sxhkd/sxhkdrc vifm/vifmrc vifm/colors/terminal.vifm termite/config
ln -s ~/dotfiles/.config/nvim/init.vim nvim/init.vim
ln -s ~/dotfiles/.config/onedrive/config onedrive/config
ln -s ~/dotfiles/.config/sxhkd/sxhkdrc sxhkd/sxhkdrc
ln -s ~/dotfiles/.config/vifm/vifmrc vifm/vifmrc
ln -s ~/dotfiles/.config/vifm/colors/terminal.vifm vifm/colors/terminal.vifm
ln -s ~/dotfiles/.config/termite/config termite/config

