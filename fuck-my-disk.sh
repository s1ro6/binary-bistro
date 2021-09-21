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
    "$HOME/Library/Developer/CoreSimulator/Caches"
  )

  remove_cache_file "${CACHE_DIR_LIST[@]}"
}

# Tencent WeChat
# TODO: Optimize the way getting the cache path
remove_wechat_caches() {
  base_path="$HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat"
  version_path="2.0b4.0.9/dec0ab91fa2da81feaff27e057044f2c"
  remove_cache_file "${base_path}/${version_path}/Stickers"
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
      remove_cache_file "${cache_path_list[@]}"
    fi
  done
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
}

main
