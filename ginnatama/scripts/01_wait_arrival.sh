#!/bin/bash
# 使い方: 01_wait_arrival.sh "<ぎんたま様_テスト中のフォルダ>"
# 到着条件: .movが1つ / 3.8GB以上 / 60秒空けて2回サイズ不変 / ffprobeで長さ取得可。最大30分。
# （ドライブの「オフライン利用可能」は手動確認：Finderで雲マークが無いこと）
DIR="$1"; MIN=$((3800*1000*1000)); END=$((SECONDS+1800))
size(){ stat -f%z "$1" 2>/dev/null || stat -c%s "$1"; }
while [ $SECONDS -lt $END ]; do
  N=$(find "$DIR" -maxdepth 1 -name '*.mov' | wc -l | tr -d ' ')
  if [ "$N" -gt 1 ]; then echo "STOP: .movが複数。確認が必要"; exit 2; fi
  if [ "$N" -eq 1 ]; then
    F=$(find "$DIR" -maxdepth 1 -name '*.mov'); S1=$(size "$F")
    if [ "$S1" -ge "$MIN" ]; then
      sleep 60; S2=$(size "$F")
      if [ "$S1" = "$S2" ] && ffprobe -v error -show_entries format=duration -of csv=p=0 "$F" >/dev/null 2>&1; then
        echo "ARRIVED: $F ($S2 bytes)"; exit 0; fi
    fi
  fi
  sleep 60
done
echo "TIMEOUT: 30分来なかった。停止して報告"; exit 3
