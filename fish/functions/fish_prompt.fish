function __prompt_git
    set --local prompt_git (fish_git_prompt "%s")
    if test $status -eq 0
        echo -n -s $argv[1] "-[" $argv[2] $prompt_git $argv[1] "]"
    end
end

function fish_prompt --description 'Write out the prompt'
    set --local last_pipestatus $pipestatus
    # Setting colors variables
    set --local col_normal (set_color normal)
    set --local col_prompt (set_color --dim blue)
    set --local col_path (set_color green)
    set --local col_status (set_color red)
    # Preparing parts of the prompt
    set --local prompt_path (echo -n -s $col_prompt "[" $col_normal $col_path (prompt_pwd) $col_prompt "]")
    set --local prompt_git (__prompt_git $col_prompt $col_normal)
    set --local prompt_status (__fish_print_pipestatus "-[" "]" "|" $col_prompt $col_status $last_pipestatus)
    set --local prompt_suffix (echo -n -s $col_prompt "-> ")
    echo -n -s $prompt_path $prompt_git $prompt_status $prompt_suffix $col_normal
end
