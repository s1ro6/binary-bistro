#!/usr/bin/env python3
import os
import re
import shutil

TEMP_TRASH_PATH = os.path.expanduser('~/Desktop/_FuckingCaches_')


# Remove JetBrain IDE's cache.¬
def remove_jetbrain_cache():
    base_path = os.path.expanduser('~/Library/Caches')
    for name in os.listdir(base_path):
        regex = r'^(WebStorm)\d{4}\.\d+'
        if re.match(regex, name):
            path = os.path.join(base_path, name)
            delete_cache(path)
            print(os.path.abspath(path))

    # Open the trash bin with Finder.app
    # os.system(f'open {TEMP_TRASH_PATH}')


# Remove Xcode cache.
def remove_xcode_cache():
    # Remove Derived data
    derived_path = os.path.expanduser('~/Library/Developer/Xcode/DerivedData')
    for f in os.listdir(derived_path):
        delete_cache(os.path.join(derived_path, f))
        print(os.path.join(derived_path, f))

    # Remove archives data
    archives_path = os.path.expanduser('~/Library/Developer/Xcode/Archives')


# Move the files to temp trash.
def delete_cache(path):
    if not os.path.exists(TEMP_TRASH_PATH):
        os.mkdir(TEMP_TRASH_PATH)
    shutil.move(path, TEMP_TRASH_PATH)


if __name__ == '__main__':
    # remove_jetbrain_cache()
    remove_xcode_cache()
