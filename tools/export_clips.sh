#!/usr/bin/env bash
set -euo pipefail

# Export clips from a source video using ffmpeg.

# Usage:
#   bash tools/export_clips.sh [input_video]

INPUT="${1:-/Users/default/Desktop/The Neighbourhood - Sweater Weather (Official Video) - TheNeighbourhoodVEVO (720p, h264).mp4}"
OUTDIR="clips"
mkdir -p "$OUTDIR"

extract() {
  local name="$1"
  local start="$2"   # format HH:MM:SS or seconds
  local duration="$3"
  echo "Exporting $name (start=$start, duration=${duration}s) ..."
  ffmpeg -y -ss "$start" -i "$INPUT" -t "$duration" -c:v libx264 -c:a aac -b:a 192k -preset fast "$OUTDIR/${name}.mp4"
}

# Start all clips 14 seconds into the video
extract "sweater_3s" "00:00:14" 3
extract "sweater_10s" "00:00:14" 10
extract "sweater_60s" "00:00:14" 60

echo "Done. Exported files:"
ls -lh "$OUTDIR"
