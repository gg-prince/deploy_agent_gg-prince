#!/usr/bin/env bash

at_dir=""

until [ ! -d "attendance_tracker_$at_dir" ] && [ -n "$at_dir" ]
do
        read -rp "Enter the attendance folder name here: " at_dir

        if [ -d "attendance_tracker_$at_dir" ]; then
                echo "Please enter a different name"
                echo ""
        fi
done

mkdir "attendance_tracker_$at_dir"
echo "Folder created"

