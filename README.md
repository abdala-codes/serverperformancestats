# Server Performance Stats

This is a simple Bash script I wrote to check basic server performance stats on a Linux system.

The aim of this project was to practise using Bash, Linux commands, and Git, while building something practical that could be useful on a real server. It’s part of the beginner DevOps projects from Roadmap.sh.

---

## What the script does

When you run the script, it shows:

- Overall CPU usage
- Memory usage (used vs free, including percentage)
- Disk usage for the root filesystem
- Top 5 processes using the most CPU
- Top 5 processes using the most memory

---

## Requirements

The script is designed to run on a Linux system with standard tools installed, including:

- `bash`
- `top` and `ps` (from `procps`)
- `df` and `numfmt` (from `coreutils`)
- `free`

Tested on **Ubuntu 24.04 using WSL**.

---

## How to run it

Clone the repository and run the script:

```bash
git clone https://github.com/abdala-codes/serverperformancestats.git
cd serverperformancestats
chmod +x server-stats.sh
./server-stats.sh

## Project Reference

This project is based on the Roadmap.sh Server Performance Stats project:  
https://roadmap.sh/projects/server-stats


