mod zsh

shed_manifest := source_directory() / "posix/shed/$DOTFILES_PROFILE.yaml"

[private]
default:
    @just --list

put *options:
    shed put {{ shed_manifest }} {{ options }}

get *options:
    shed get {{ shed_manifest }} {{ options }}

lazygit:
    cd {{ source_directory() }} && lazygit

status:
    cd {{ source_directory() }} && git status
