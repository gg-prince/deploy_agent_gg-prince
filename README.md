# setup_project.sh Guidance

## Video Walkthrough

Code explanation and demonstration video:
https://drive.google.com/file/d/1ARw64V4EA-BqZKILIQISqZmsxYchzHx3/view?usp=sharing

---

## Overview

This project provides a shell script (`setup_project.sh`) that automates the deployment of a Student Attendance Tracker application. The script demonstrates Infrastructure as Code (IaC) principles by creating the required project structure, configuring application settings, validating the environment, and handling interruptions gracefully.

---

## Important Note

The following files **must remain in the same directory as `setup_project.sh`** for the deployment process to work correctly:

```text
deploy_agent_gg-prince/
│
├── setup_project.sh
├── attendance_checker.py
├── assets.csv
├── config.json
├── reports.log
└── README.md
```

The script uses these files as templates and copies them into the generated project workspace. Moving them elsewhere without modifying the script will cause the setup process to fail.

---

## Generated Structure

Running the script creates the following structure:

```text
attendance_tracker_<project_name>/
│
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log
```

---

## Features

* Automated project directory creation.
* Deployment of required application files.
* Interactive attendance threshold configuration.
* Configuration updates using `sed`.
* Numeric input validation.
* Python environment health checks.
* `SIGINT` (`Ctrl+C`) handling through signal traps.
* Automatic archival of interrupted deployments.
* Cleanup of incomplete project directories.

---

## Requirements

* Bash shell
* Standard Unix utilities (`mkdir`, `cp`, `sed`, `tar`, `rm`)
* Python 3 (optional but recommended)

The script checks whether Python 3 is installed by running:

```bash
python3 --version
```

---

## Running the Script

Clone the repository:

```bash
git clone https://github.com/gg-prince/deploy_agent_gg-prince
cd deploy_agent_gg-prince
```

Grant execute permissions:

```bash
chmod +x setup_project.sh
```

Run the script:

```bash
./setup_project.sh
```

You will be prompted to:

1. Enter a project name.
2. Choose whether to update attendance thresholds.
3. Provide new threshold values if required.

---

## Archive and Recovery Feature

If the script is interrupted using `Ctrl+C`, it will:

1. Archive the current state of the project directory.
2. Save the archive as:

```text
attendance_tracker_<project_name>_archive
```

3. Remove the incomplete project directory.
4. Exit gracefully.

To test this feature, run the script and press `Ctrl+C` before completion. Confirm that the archive exists and that the partially created directory has been removed.

---

## Error Handling

The script includes safeguards to ensure reliable execution:

* Detects existing project directories.
* Validates numeric threshold inputs.
* Handles interruptions gracefully.
* Cleans up incomplete deployments.
* Maintains the required directory structure across environments.
