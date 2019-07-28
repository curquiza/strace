#!/bin/sh

cd /strace
make re > /log_entrypoint 2>&1
bash
