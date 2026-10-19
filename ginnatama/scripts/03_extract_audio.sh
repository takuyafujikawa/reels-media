#!/bin/bash
# 使い方: 03_extract_audio.sh <mov> [トラック番号(0始まり,既定0)]
# 出力はドライブ外のローカル一時フォルダ。16kHzモノのwav（文字起こし用）。元ファイルは触らない。
OUT="${TMPDIR:-/tmp}/ginnatama_work"; mkdir -p "$OUT"
ffmpeg -n -i "$1" -map 0:a:${2:-0} -vn -ac 1 -ar 16000 -c:a pcm_s16le "$OUT/audio.wav" && echo "$OUT/audio.wav"
