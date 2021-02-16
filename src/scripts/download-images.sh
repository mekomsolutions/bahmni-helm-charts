mkdir -p $1
#!/bin/bash
if [ -p /dev/stdin ]; then
        while IFS= read line; do
                skopeo sync --src docker --dest dir ${line} $1 --override-arch arm64 --override-os linux
        done
else
        echo "No input was found on stdin, skipping!"
        # Checking to ensure a filename was specified and that it exists
        if [ -f "$1" ]; then
                echo "Filename specified: ${1}"
                echo "Doing things now.."
        else
                echo "No input given!"
        fi
fi