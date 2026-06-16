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
mkdir "attendance_tracker_$at_dir/Helpers" "attendance_tracker_$at_dir/reports"
echo "Folders created"

cp -v "attendance_checker.py" "attendance_tracker_$at_dir/"
cp -v "assets.csv" "config.json" "attendance_tracker_$at_dir/Helpers/"
cp -v "reports.log" "attendance_tracker_$at_dir/reports"
echo "Files Added"

updte=""

until [ $updte == "Y" ] || [ $updte == "n" ]
do
	read -rp "Do you want to update attendance thresholds(Y/n): " updte
	if [ ! $updte == "Y" ] || [ ! $updte == "n" ]; then
		echo "Follow format (Y/n)"
	fi
done

if [ $updte == "Y" ]; then
	
fi
