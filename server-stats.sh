#!/usr/bin/env bash
set -euo pipefail

hr() { printf '%s\n' "----------------------------------------"; }
title() { hr; printf "%s\n" "$1"; hr; }

cpu_used_pct() {
  local idle
  idle=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {print $4}' | awk '{print $1}' | tr -d '%')
  awk -v idle="${idle:-0}" 'BEGIN { printf "%.1f", 100 - idle }'
}

mem_stats() {
  local total used avail pct
  total=$(free -b | awk '/Mem:/ {print $2}')
  used=$(free -b | awk '/Mem:/ {print $3}')
  avail=$(free -b | awk '/Mem:/ {print $7}')
  pct=$(awk -v u="$used" -v t="$total" 'BEGIN { printf "%.1f", (u/t)*100 }')

  printf "Total: %s\n" "$(numfmt --to=iec --suffix=B "$total")"
  printf "Used : %s (%s%%)\n" "$(numfmt --to=iec --suffix=B "$used")" "$pct"
  printf "Free : %s (available)\n" "$(numfmt --to=iec --suffix=B "$avail")"
}

disk_stats_root() {
  local line size used avail usep
  line=$(df -P -B1 / | awk 'NR==2')
  size=$(awk '{print $2}' <<<"$line")
  used=$(awk '{print $3}' <<<"$line")
  avail=$(awk '{print $4}' <<<"$line")
  usep=$(awk '{print $5}' <<<"$line" | tr -d '%')

  printf "Mount: /\n"
  printf "Total: %s\n" "$(numfmt --to=iec --suffix=B "$size")"
  printf "Used : %s (%s%%)\n" "$(numfmt --to=iec --suffix=B "$used")" "$usep"
  printf "Free : %s\n" "$(numfmt --to=iec --suffix=B "$avail")"
}

top5_cpu() {
  ps -eo pid,comm,%cpu --sort=-%cpu | awk 'NR==1 || NR<=6'
}

top5_mem() {
  ps -eo pid,comm,%mem --sort=-%mem | awk 'NR==1 || NR<=6'
}

title "Server Performance Stats"

title "Total CPU Usage"
printf "CPU Used: %s%%\n" "$(cpu_used_pct)"

title "Total Memory Usage (Free vs Used)"
mem_stats

title "Total Disk Usage (Free vs Used)"
disk_stats_root

title "Top 5 Processes by CPU Usage"
top5_cpu

title "Top 5 Processes by Memory Usage"
top5_mem


