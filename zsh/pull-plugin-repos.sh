set -x

$HOME/.dotfiles/zsh/repos.py | while read url path; do
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/$path
    git pull
done
