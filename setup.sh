#!/bin/bash

# Install Xcode Command-Line Tools
if ! xcode-select -p ; then
    xcode-select --install
    exit 0
fi

#Install brew
if which brew > /dev/null;
then
    echo "Good job brew is installed"
else ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing some brew things..."
#Install some brew things
brew tap caskroom/cask
brew install git ykman node ruby cask zsh wget python3 htop wakeonlan geckodriver

brew tap railwaycat/emacsmacport
brew update
#brew install emacs-mac
echo "Installing some casks..."
#Install some casks
brew cask install spotmenu bettertouchtool authy cscreen viscosity visual-studio-code discord google-chrome chromedriver firefox postman sublime-text atom wireshark vlc spectacle keepingyouawake licecap tunnelblick iterm2 cyberduck scroll-reverser flux the-unarchiver fluor scroll-reverser pdftotext gimp java

brew cask install caskroom/cask/intellij-idea-ce

echo "Installing maven"
#maven requires java so needed to install that first
brew install maven

#Download FinderPath
cd ~/Downloads
wget https://bahoom.com/finderpath/0.9.7/FinderPath.zip
unzip FinderPath.zip
mv FinderPath* /Applications/

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip install virtualenv

#Download the iterm 2 color scheme
git clone https://github.com/arcticicestudio/nord-iterm2.git
cd

#clone dotfies
cd ~/repos
git clone https://github.com/jon-van/dotfiles.git

# Symobilic link of configs
for x in `ls -A /Users/$USER/repos/dotfiles/`
do
    if [ -a /Users/$USER/$x ]
    then
        echo "Removing $x"
        rm -rf $x
        ln -sf /Users/$USER/repos/dotfiles/$x ~
    else
        ln -sf /Users/$USER/repos/dotfiles/$x ~
    fi
done

#Setup vim stuff
cd ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#Install vscode extensions
array=( arcticicestudio.nord-visual-studio-code castwide.solargraph christian-kohler.npm-intellisense christian-kohler.path-intellisense CoenraadS.bracket-pair-colorizer dbaeumer.vscode-eslint esbenp.prettier-vscode formulahendry.code-runner k--kato.intellij idea-keybindings mohsen1.prettify-json ms-azuretools.vscode-cosmosdb ms-python.python ms-vscode.azure-account ms-vsliveshare.vsliveshare PeterJausovec.vscode-docker rafaelmaiolla.remote-vscode rebornix.ruby redhat.java techer.open-in-browser )
for i in "${array[@]}"
do
    code --install-extension $i
done

#setup ssh key
echo "Lets setup an ssh key"
ssh-keygen -t rsa

echo "Time to install oh-my-zsh"
#install oh-my-zsh
if which zsh > /dev/null;
then
  echo "congratulations zsh is installed!"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  #switch default shell to zsh
  chsh -s $(which zsh)
else
  echo "Zsh is not installed. Go do that and then install oh-my-zsh"
fi
