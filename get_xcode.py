#!/usr/bin/env python3
from urllib import request
import json


def main():
    r = request.urlopen("https://xcodereleases.com/data.json")
    if r.code != 200:
        print(f"Network response error: [{r.code}] {r.msg}")
        return

    l = json.loads(r.read())
    for info in l:
        isRelease = info["version"]["release"].get("release", False)
        if isRelease == True:
            ver = info["version"]["number"]
            link = info["links"]["download"]["url"]
            note = info["links"]["notes"]["url"]
            cs = info["checksums"]["sha1"]
            print(f"Xcode {ver}\nRelease Notes: {note}\nDownload: {link}\nSHA-1: {cs}")
            return


if __name__ == "__main__":
    main()
