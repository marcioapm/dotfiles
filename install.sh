#/usr/bin/bash


# copy all the setting files over
cp -v -a .config $HOME/
cp -v -a home/. $HOME/


# setup bash settings
echo "source $HOME/.config/bash/profile" >> $HOME/.bashrc

# setup gnome terminal
BG_COLOR="#FDFDF6F6E3E3"
FG_COLOR="#838394949696"

gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "$PALETTE"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "$BG_COLOR"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "$FG_COLOR"


# setup vim
#----------

# setup temp dirs
mkdir -p $HOME/.vim/swap
mkdir -p $HOME/.vim/undo
mkdir -p $HOME/.vim/backup

# install vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# install powerline symbol fonts
mkdir -p $HOME/.fonts
mkdir -p $HOME/.config/fontconfig/conf.d

(cd $HOME/.fonts && wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf)
(cd $HOME/.config/fontconfig/conf.d && wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf)
fc-cache -vf $HOME/.fonts

# install vundle plugins
vim +BundleInstall +qall


echo "\nif your terminal colors didn't change or are incorrect"
echo "you should open your terminal profile preferences,"
echo "set colors to custom, and rerun this script\n"
