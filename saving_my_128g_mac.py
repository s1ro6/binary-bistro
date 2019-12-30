#!/usr/bin/env python3
#
# Oh my god, Plz save my little brother 128GB MBP...
#

import os

def remove_file(path):
    if os.path.isdir(path):
        for name in os.listdir(path):
            sub_path = os.path.join(path, name)
            remove_file(sub_path)
    else:
        os.remove(path)


if __name__ == '__main__':
    path_list = [
        '~/Library/Developer/Xcode/DerivedData',
        '~/Library/Developer/Xcode/iOS DeviceSupport',
        '~/Library/Developer/Xcode/iOS Device Logs',
    ]

    for p in path_list:
        path = os.path.expanduser(p)
        if os.path.exists(path):
            remove_file(path)

    print('Done!')
