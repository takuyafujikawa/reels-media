#!/bin/bash
# 使い方: 04_transcribe.sh <audio.wav> <出力ディレクトリ>
# ローカル実行のみ。ツールは00で確認し、無ければインストール前にユーザーへ確認。
A="$1"; O="$2"; mkdir -p "$O"
if command -v whisper-cli >/dev/null; then
  echo "whisper.cpp: モデルパスを MODEL 環境変数で指定"; whisper-cli -m "$MODEL" -l ja -f "$A" -osrt -of "$O/transcript"
elif command -v mlx_whisper >/dev/null; then
  mlx_whisper "$A" --language ja --output-format srt --output-dir "$O" --output-name transcript
else
  echo "文字起こしツール無し。インストール前に確認してください"; exit 1
fi
