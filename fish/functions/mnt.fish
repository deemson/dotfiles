function mnt
    command sudo mount --options uid=deemson,gid=users,fmask=113,dmask=002 $argv
end