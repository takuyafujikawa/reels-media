#!/bin/bash
# 使い方: 02_info.sh <mov>  長さ・解像度・fps・音声トラック数
ffprobe -v error -show_entries format=duration,size:stream=index,codec_type,codec_name,width,height,r_frame_rate,channels -of default=nw=1 "$1"
