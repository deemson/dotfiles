set -x
for PLUGIN in $HOME/.zsh/plugins/*; do
    cd $PLUGIN
    git pull
done
