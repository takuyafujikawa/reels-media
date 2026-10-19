#!/usr/bin/env python3
"""使い方: python3 -I 05_srt_to_json.py transcript.srt transcript.json"""
import json, re, sys
t = open(sys.argv[1], encoding="utf-8").read().strip()
out = []
for b in re.split(r"\n\s*\n", t):
    l = b.splitlines()
    if len(l) < 3: continue
    m = re.match(r"(\d+):(\d+):(\d+)[,.](\d+) --> (\d+):(\d+):(\d+)[,.](\d+)", l[1])
    if not m: continue
    g = list(map(int, m.groups()))
    out.append({"id": int(l[0]), "start": g[0]*3600+g[1]*60+g[2]+g[3]/1000,
                "end": g[4]*3600+g[5]*60+g[6]+g[7]/1000, "text": " ".join(l[2:])})
json.dump(out, open(sys.argv[2], "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(len(out), "segments")
