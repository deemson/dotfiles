mod zsh

shed := "shed --collection " + source_directory() / "posix/shed/$DOTFILES_PROFILE.yaml" + " --items-dir " + source_directory() / "posix/shed"

[private]
default:
    @just --list

put:
    {{ shed }} put

get:
    {{ shed }} get

lazygit:
    cd {{ source_directory() }} && lazygit

status:
    cd {{ source_directory() }} && git status
