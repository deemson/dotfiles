function mnt
    command sudo mount --options  gid=users,fmask=113,dmask=002 $argv
end