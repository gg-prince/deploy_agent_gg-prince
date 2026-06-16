#!/usr/bin/env bash

exit_func() {

	if [ -d "attendance_tracker_$at_dir" ]; then
		
		if [ -d "attendance_tracker_${at_dir}_archive" ]; then
			rm -rf "attendance_tracker_${at_dir}_archive"
			echo ""
			echo "Removed previous archive"
		fi

		mv "attendance_tracker_$at_dir" "attendance_tracker_${at_dir}_archive"
		echo ""
		echo "Saved to archive attendance_tracker_${at_dir}_archive"
	fi

	echo ""
	echo "Exiting..."

	exit 1
}

trap exit_func SIGINT

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
echo ""
echo "Folders created"
echo ""

cp -v "attendance_checker.py" "attendance_tracker_$at_dir/"
cp -v "assets.csv" "config.json" "attendance_tracker_$at_dir/Helpers/"
cp -v "reports.log" "attendance_tracker_$at_dir/reports"
echo ""
echo "Files Added"
echo ""

echo "------------------------------------------------------------"

updte=""

until [ "$updte" == "Y" ] || [ "$updte" == "n" ]
do
	echo ""
	read -rp "Do you want to update attendance thresholds(Y/n): " updte
	if [ ! $updte == "Y" ] && [ ! $updte == "n" ]; then
		echo "Follow format (Y/n)"
	fi
done

echo ""

if [ "$updte" == "Y" ]; then

	warning=""
	failure=""

	until [[ "$warning" =~ ^[0-9]*\.?[0-9]+$ ]]
	do
		echo ""
	        read -rp "Enter new Warning threshold: " warning
	        if [[ ! "$warning" =~ ^[0-9]*\.?[0-9]+$ ]]; then
	                echo "Please enter a positive number"
	        fi
	done

	sed -i -E "s/(\"warning\"[[:space:]]*:[[:space:]]*)[0-9]+(\.[0-9]+)?/\1$warning/" attendance_tracker_$at_dir/Helpers/config.json

	echo "Updated Warning threshold."

	until [[ "$failure" =~ ^[0-9]*\.?[0-9]+$ ]]
        do
                echo ""
                read -rp "Enter new Failure threshold: " failure
                if [[ ! "$failure" =~ ^[0-9]*\.?[0-9]+$ ]]; then
                        echo "Please enter a positive number"
                fi
        done

        sed -i -E "s/(\"failure\"[[:space:]]*:[[:space:]]*)[0-9]+(\.[0-9]+)?/\1$failure/" attendance_tracker_$at_dir/Helpers/config.json

        echo "Updated Failure threshold."

fi

echo "------------------------------------------------------------"

echo ""

echo "Searching for Python3..."

if python3 --version >/dev/null 2>&1; then
        echo "Awesome, Python3 is available on your computer!!"
else
    echo "Warning, Python3 is not available on your computer."
fi

echo ""

until [ -d "attendance_tracker_$at_dir" ] && [ -d "attendance_tracker_${at_dir}/Helpers" ] && [ -d "attendance_tracker_${at_dir}/reports" ] && [ -f "attendance_tracker_${at_dir}/Helpers/assets.csv" ] && [ -f "attendance_tracker_${at_dir}/Helpers/config.json" ] && [ -f "attendance_tracker_${at_dir}/reports/reports.log" ]
do

        if [ ! -d "attendance_tracker_$at_dir" ]; then
		mkdir "attendance_tracker_$at_dir"
        fi

	if [ ! -d "attendance_tracker_$at_dir/Helpers" ]; then
		mkdir "attendance_tracker_$at_dir/Helpers"
	fi

	if [ ! -d "attendance_tracker_$at_dir/reports" ]; then
		mkdir "attendance_tracker_$at_dir/reports"
	fi

	if [ ! -f "attendance_tracker_${at_dir}/Helpers/assets.csv" ]; then
		cp -v "assets.csv" "attendance_tracker_$at_dir/Helpers/"
	fi

	if [ -f "attendance_tracker_${at_dir}/Helpers/config.json" ]; then
		cp -v "config.json" "attendance_tracker_$at_dir/Helpers/"
	fi

	if [ -f "attendance_tracker_${at_dir}/reports/reports.log" ]; then
		cp -v "reports.log" "attendance_tracker_$at_dir/reports"
	fi

done

echo "Application Directory structure is followed."


echo ""
