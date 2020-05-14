#!/bin/bash
#
# Fuck my disk, save my disk.

TOTAL_CACHE_SIZE=0

remove_cache_file() {
    for dir_path in "$@"; do
        if [[ -d $dir_path ]]; then
            dir_size=$(du -ks "$dir_path" | awk '{print $1}')
            TOTAL_CACHE_SIZE=$((TOTAL_CACHE_SIZE + dir_size))
            echo "$dir_size KB [$dir_path]"
            mv "$dir_path" "$HOME/.Trash/"
        fi
    done
}

get_human_readable_result() {
    size_number=$1
    if [[ $size_number -gt 1000000 ]]; then
        size_number="$((size_number / 1000000)) GB"
    elif [[ $size_number -gt 1000 ]]; then
        size_number="$((size_number / 1000)) MB"
    fi
    echo -e "\nRemoved cache size: \033[32m$size_number\033[0m"
    echo -e "Previous available space: $(df -H | grep "disk1s1" | awk '{print $4}')"
}

# Fixed path caches
remove_normal_caches() {
    CACHE_DIR_LIST=(
        # Steel Drivers
        "/Library/Application Support/SteelSeries Engine 3/updates"

        # Tencent QQ Caches
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Avatar"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Images"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Videos"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/QQThumbnail"

        # Netease Cloud Music
        "$HOME/Library/Containers/com.netease.163music/Data/Library/Caches"

        # Apple Xcode Caches
        "$HOME/Library/Developer/Xcode/DerivedData"
        "$HOME/Library/Developer/Xcode/iOS DeviceSupport"
    )

    remove_cache_file "${CACHE_DIR_LIST[@]}"
}

# Tencent WeChat
# TODO: Optimize the way getting the cache path
remove_wechat_caches() {
    remove_cache_file "$HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/dec0ab91fa2da81feaff27e057044f2c/Stickers"
}

# Tencent WeWork (aka WeChat Work Edition)
remove_wechat_work_caches() {
    root_data_path="$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data"
    root_data_subdir_list=$(ls "$root_data_path")

    for random_dir_name in $root_data_subdir_list; do
        random_dir_path="$root_data_path/$random_dir_name"
        if [[ -d "$random_dir_path/Cache" ]]; then
            cache_path_list=(
                "$random_dir_path/Cache"
                "$random_dir_path/Avator"
                "$random_dir_path/Emotion"
                "$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Upgrade"
            )
            remove_cache_file "${cache_path_list[@]}"
        fi
    done
}

main() {
    remove_normal_caches
    remove_wechat_work_caches
    get_human_readable_result $TOTAL_CACHE_SIZE
}

main
