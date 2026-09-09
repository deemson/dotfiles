mod zsh

shed_manifest := source_directory() / "posix/shed/$DOTFILES_PROFILE.yaml"

[private]
default:
    @just --list

put:
    shed put {{ shed_manifest }}

get:
    shed get {{ shed_manifest }}

lazygit:
    cd {{ source_directory() }} && lazygit

status:
    cd {{ source_directory() }} && git status
