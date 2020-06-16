

if [ -d "$HOME/.dotfilecfg" ]; then rm -Rf $HOME/.dotfilecfg; fi

[ -f .gitignore ] && rm .gitignore

git clone --bare https://github.com/rajmahendra/Dotfiles.git $HOME/.dotfilecfg

function config {
   /usr/bin/git --git-dir=$HOME/.dotfilecfg/ --work-tree=$HOME $@
}

mkdir -p .dotfilecfg-backup

config checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfilecfg-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

[ -f LICENSE ] && rm LICENSE
[ -f README.md ] && rm README.md


