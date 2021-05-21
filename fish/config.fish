set fish_greeting

# Colors for the shell itself
set --universal fish_color_command blue
set --universal fish_color_param cyan
set --universal fish_color_comment --dim brblack
set --universal fish_color_escape yellow
set --universal fish_color_normal normal
set --universal fish_color_error red
set --universal fish_color_autosuggestion --dim brblack
# () $something && || etc
set --universal fish_color_operator magenta
# stuff in single and double quotes
set --universal fish_color_quote green
# ; & etc
set --universal fish_color_end yellow
# | >1 >2 etc
set --universal fish_color_redirection yellow
set --universal fish_color_valid_path --underline
# typing and pressing C^P (or up) causes fish to search history
# this is the highlighting of the match
set --universal fish_color_search_match --background=magenta
# pager is shown the tab is pressed
set --universal fish_pager_color_description yellow
# prefix shows search match in pager
set --universal fish_pager_color_prefix brwhite
# this color is used for everying after prefix
set --universal fish_pager_color_completion brblack
# same as the above only for the selected pager element
set --universal fish_pager_color_selected_prefix --bold white
set --universal fish_pager_color_selected_completion white
set --universal fish_pager_color_selected_background --dim --background=brblack

# Colors and config for the git prompt
set --global __fish_git_prompt_show_informative_status 1
set --global __fish_git_prompt_showupstream "informative"

set --global ___fish_git_prompt_color (set_color --dim blue)
set --global ___fish_git_prompt_color_done (set_color normal)
set --global ___fish_git_prompt_color_upstream (set_color brblack)
set --global ___fish_git_prompt_color_upstream_done (set_color normal)
set --global ___fish_git_prompt_color_invalidstate (set_color red)
set --global ___fish_git_prompt_color_invalidstate_done (set_color normal)
set --global ___fish_git_prompt_color_merging (set_color red)
set --global ___fish_git_prompt_color_merging_done (set_color normal)

set --global __fish_git_prompt_color_branch magenta
set --global __fish_git_prompt_color_cleanstate blue
set --global __fish_git_prompt_color_stagedstate green
set --global __fish_git_prompt_color_dirtystate yellow
set --global __fish_git_prompt_color_untrackedfiles brblack
set --global __fish_git_prompt_color_invalidstate red

set --global __fish_git_prompt_char_cleanstate '.'
set --global __fish_git_prompt_char_conflictedstate '-'
set --global __fish_git_prompt_char_dirtystate '-'
set --global __fish_git_prompt_char_stagedstate '+'
set --global __fish_git_prompt_char_untrackedfiles '.'
set --global __fish_git_prompt_char_upstream_ahead '+'
set --global __fish_git_prompt_char_upstream_behind '-'
set --global __fish_git_prompt_char_upstream_diverged '!'
set --global __fish_git_prompt_char_upstream_equal '='
set --global __fish_git_prompt_char_invalidstate '#'
set --global __fish_git_prompt_char_stashstate '$'

# Read env dependent stuff
source $HOME/.config/fish/env.fish