function lsblk
    command lsblk -o NAME,MOUNTPOINT,SIZE,FSUSED,FSAVAIL,FSUSE% | bat -l conf
end
