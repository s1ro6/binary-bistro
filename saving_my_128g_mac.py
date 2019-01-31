#!/usr/bin/env python3
import os
import re
import shutil

TEMP_TRASH_PATH = '/Users/s1ro6/Desktop/_FuckingCaches_'


# Remove JetBrain IDE's cache.¬
def remove_jetbrain_cache():
    BASE_PATH = '/Users/s1ro6/Library/Caches'

    # Create temp trash dir
    if not os.path.exists(TEMP_TRASH_PATH):
        os.mkdir(TEMP_TRASH_PATH)

    # Search cache and move cache
    for name in os.listdir(BASE_PATH):
        regex = r'^(WebStorm)\d{4}\.\d+'
        if re.match(regex, name):
            path = os.path.join(BASE_PATH, name)
            # shutil.move(path, TEMP_TRASH_PATH)
            print(os.path.abspath(path))

    # Open the trash bin with Finder.app
    # os.system(f'open {TEMP_TRASH_PATH}')


# Remove Xcode cache.
def remove_xcode_cache():
    pass


if __name__ == '__main__':
    remove_jetbrain_cache()
