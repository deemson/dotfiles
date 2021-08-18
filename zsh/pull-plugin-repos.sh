set -x

while read url path; do
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/$path
    git pull
done <<<$($HOME/.dotfiles/zsh/repos.py)
