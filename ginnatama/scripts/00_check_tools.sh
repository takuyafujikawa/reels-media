#!/bin/bash
# ツール確認のみ。インストールはしない（入れる前にユーザー確認）。
for t in ffmpeg ffprobe python3 whisper-cli whisper mlx_whisper yt-dlp; do
  if command -v "$t" >/dev/null; then echo "OK  $t -> $(command -v $t)"; else echo "なし $t"; fi
done
python3 -c "import faster_whisper" 2>/dev/null && echo "OK  faster_whisper" || echo "なし faster_whisper"
