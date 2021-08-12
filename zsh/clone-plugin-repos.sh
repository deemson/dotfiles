set -x

ZSH_PLUGINS="git@github.com:zsh-users/zsh-syntax-highlighting.git git@github.com:zsh-users/zsh-autosuggestions.git git@github.com:zsh-users/zsh-history-substring-search.git"

mkdir -p $HOME/.zsh/plugins
cd $HOME/.zsh/plugins
for PLUGIN in $ZSH_PLUGINS; do
    git clone $PLUGIN
done
