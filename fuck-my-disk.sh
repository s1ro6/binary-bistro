#!/bin/bash
#
# Fuck my disk, save my disk.
set -e

TOTAL_CACHE_SIZE=0

count_then_remove() {
    for dir_path in "$@"; do
        if [[ -d $dir_path ]]; then
            dir_size=$(du -ks "$dir_path" | awk '{print $1}')
            TOTAL_CACHE_SIZE=$((TOTAL_CACHE_SIZE + dir_size))
            echo "$dir_size KB [$dir_path]"
            last_name=$(echo "$dir_path" | awk -F '/' '{ print $NF }')
            mv "$dir_path" "$HOME/.Trash/$(date +%s)_${last_name}"
        fi
    done
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

    count_then_remove "${CACHE_DIR_LIST[@]}"
}

# Tencent WeChat
remove_wechat_caches() {
    base_path="$HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9"
    account_md5_list=$(ls -a "$base_path" | awk '{if (length($0) == 32) print $0}')
    for account_md5 in $account_md5_list; do
        count_then_remove "$base_path/$account_md5/Avatar"
        count_then_remove "$base_path/$account_md5/Stickers"
    done
}

# Tencent WeWork (aka WeChat Work Edition)
remove_wecom_caches() {
    base_path="$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data"
    subdir_list=$(ls "$base_path")

    for random_dir_name in $subdir_list; do
        random_dir_path="$base_path/$random_dir_name"
        if [[ -d "$random_dir_path/Cache" ]]; then
            cache_path_list=(
                "$random_dir_path/Cache"
                "$random_dir_path/Avator"
                "$random_dir_path/Emotion"
                "$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Upgrade"
            )
            count_then_remove "${cache_path_list[@]}"
        fi
    done
}

# Remove the unused libs and old version apps.
remove_homebrew_cache() {
    if [[ -n $(type brew 2>/dev/null) ]]; then
        brew cleanup --prune=all --verbose
        brew autoremove --verbose
    fi
}

show_readable_result() {
    if [[ $TOTAL_CACHE_SIZE -gt 1000000 ]]; then
        TOTAL_CACHE_SIZE="$((TOTAL_CACHE_SIZE / 1000000)) GB"
    elif [[ $TOTAL_CACHE_SIZE -gt 1000 ]]; then
        TOTAL_CACHE_SIZE="$((TOTAL_CACHE_SIZE / 1000)) MB"
    fi
    echo -e "\nRemoved cache size: \033[32m$TOTAL_CACHE_SIZE\033[0m"
    echo -e "Previous available space: $(df -H | grep "disk1s1" | awk '{print $4}')"
}

main() {
    remove_normal_caches
    remove_wecom_caches
    remove_wechat_caches
    show_readable_result
    remove_homebrew_cache
}

main
exit 0
