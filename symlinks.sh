cd ~
rm .compton.conf .conkyrc .scimrc .spectrwm.conf .xinitrc .Xresources .zprofile .zshrc
ln -s ~/dotfiles/.compton.conf .compton.conf
ln -s ~/dotfiles/.conkyrc .conkyrc
ln -s ~/dotfiles/.scimrc .scimrc
ln -s ~/dotfiles/.spectrwm.conf .spectrwm.conf
ln -s ~/dotfiles/.xinitrc .xinitrc
ln -s ~/dotfiles/.Xresources .Xresources
ln -s ~/dotfiles/.zprofile .zprofile
ln -s ~/dotfiles/.zshrc .zshrc

rm -rdf .local/share/sidewinderd
ln -s ~/dotfiles/.local/share/sidewinderd .local/share/sidewinderd

cd ~/.config
rm nvim/init.vim onedrive/config ranger/rifle.conf sxhkd/sxhkdrc
ln -s ~/dotfiles/.config/nvim/init.vim nvim/init.vim
ln -s ~/dotfiles/.config/onedrive/config onedrive/config
ln -s ~/dotfiles/.config/ranger/rifle.conf ranger/rifle.conf
ln -s ~/dotfiles/.config/sxhkd/sxhkdrc sxhkd/sxhkdrc

