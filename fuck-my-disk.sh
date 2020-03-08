#!/bin/bash
#
# Fuck my disk, save my disk.

TOTAL_CACHE_SIZE=0

function removeFiles() {
    for DIR_PATH in "$@"; do
        if [[ -e $DIR_PATH ]] && [[ -d $DIR_PATH ]]; then
            DIR_SIZE=$(du -ks "$DIR_PATH" | awk '{print $1}')
            TOTAL_CACHE_SIZE=$((TOTAL_CACHE_SIZE + DIR_SIZE))
            echo "$DIR_SIZE KB [$DIR_PATH]"
        else
            echo "The folder does not exist. [$DIR_PATH]"
        fi
    done
}

function getHumanReadableResult() {
    SIZE_NUMBER=$1
    if [[ $SIZE_NUMBER -gt 1000000 ]]; then
        SIZE_NUMBER="$((SIZE_NUMBER / 1000000)) GB"
    elif [[ $SIZE_NUMBER -gt 1000 ]]; then
        SIZE_NUMBER="$((SIZE_NUMBER / 1000)) MB"
    fi
    echo -e "\nTotal cache size: \033[32m$SIZE_NUMBER\033[0m\n"
    echo -e "Curren available space: $(df -H | grep "disk1s1" | awk '{print $4}')"
}

function main() {
    CACHE_DIR_LIST=(
        # QQ Caches
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Avatar"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Images"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/Videos"
        "$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/QQThumbnail"

        # WeChat Caches
        "$HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/dec0ab91fa2da81feaff27e057044f2c/Stickers"

        # WeChat Work Caches
        "$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data/1688852443323900/Avator"
        "$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data/1688852443323900/Cache"
        "$HOME/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data/1688852443323900/Emotion"

        # Netease Music Caches
        "$HOME/Library/Containers/com.netease.163music/Data/Library/Caches"

        # Xcode Caches
        "$HOME/Library/Developer/Xcode/DerivedData"
        "$HOME/Library/Developer/Xcode/iOS DeviceSupport"

        # Steel Drivers
        "/Library/Application Support/SteelSeries Engine 3/updates"
    )

    removeFiles "${CACHE_DIR_LIST[@]}"
    getHumanReadableResult $TOTAL_CACHE_SIZE
}
main
