# setup_project.sh guidance

## Link to video explaining code: https://drive.google.com/file/d/1ARw64V4EA-BqZKILIQISqZmsxYchzHx3/view?usp=sharing

## Overview

This project implements a shell-based deployment utility for automating the setup of a **Student Attendance Tracker** application. The objective is to demonstrate the principles of Infrastructure as Code (IaC) by replacing manual environment setup with a reproducible, efficient, and reliable automation process.

The solution is delivered through a master shell script named `setup_project.sh`, which acts as a project factory. When executed, it creates the required directory structure, deploys the application files, updates configuration settings based on user input, validates the execution environment, and handles unexpected interruptions gracefully.

---

## Features

* Automated creation of the required project directory structure.
* Deployment of all attendance tracker source files into their designated locations.
* Interactive configuration of attendance thresholds.
* Configuration file updates using `sed` stream editing.
* Validation of user input before applying configuration changes.
* Environment health checks to verify Python availability.
* Signal trapping for `SIGINT` (`Ctrl+C`) interruptions.
* Automatic archival of incomplete projects during interrupted execution.
* Cleanup of partially created directories to maintain a tidy workspace.

---

## Project Structure

### Repository Structure

The following files **must remain in the same directory as `setup_project.sh`** for the script to function correctly:

```text
deploy_agent_GitHubUsername/
│
├── setup_project.sh
├── attendance_checker.py
├── assets.csv
├── config.json
├── reports.log
└── README.md
```

**Important:** The shell script relies on these files being present alongside it. The deployment process uses these files as templates and copies them into the newly generated project workspace.

Moving these files to another directory without updating the script accordingly will cause the deployment process to fail.

---

### Generated Project Structure

When the script is executed successfully, it creates the following structure:

```text
attendance_tracker_<project_name>/
│
├── attendance_checker.py
│
├── Helpers/
│   ├── assets.csv
│   └── config.json
│
└── reports/
    └── reports.log
```

For example, if the user provides the name `semester1`, the generated structure will be:

```text
attendance_tracker_semester1/
│
├── attendance_checker.py
│
├── Helpers/
│   ├── assets.csv
│   └── config.json
│
└── reports/
    └── reports.log
```

---

## Requirements

The script was developed for Unix-like operating systems that support Bash.

### Prerequisites

* Bash shell
* Standard Unix utilities (`mkdir`, `cp`, `sed`, `tar`, `rm`)
* 

Although Python 3 is recommended, the setup script performs a health check and reports whether Python is installed on the system.

---

## Running the Script

### Step 1: Clone the Repository

```bash
git clone https://github.com/gg-prince/deploy_agent_gg-prince
cd deploy_agent_gg-prince
```

### Step 2: Grant Execute Permission

```bash
chmod +x setup_project.sh
```

### Step 3: Execute the Script

```bash
./setup_project.sh
```

The script will prompt you for:

1. A project name.
2. Whether you would like to update attendance thresholds.
3. New threshold values if configuration updates are requested.

---

## Configuration Updates

The setup process allows users to modify attendance thresholds stored in `config.json`.

If configuration updates are requested, the script:

1. Prompts for a warning threshold value.
2. Prompts for a failure threshold value.
3. Validates that the supplied values are numeric.
4. Uses `sed` to perform in-place modifications to the configuration file.

If invalid input is detected, the script will reject the value and request valid numeric input.

---

## Environment Validation

Before completing execution, the script performs a health check by verifying the availability of Python 3 using:

```bash
python3 --version
```

The script then reports one of the following outcomes:

* Python 3 detected successfully.
* Python 3 not found on the system.

This validation step does not terminate the setup process; it simply informs the user about the current environment status.

---

## Interrupt Handling and Archive Recovery

The script implements signal trapping to handle `SIGINT` interruptions generated through `Ctrl+C`.

If the setup process is interrupted before completion, the following actions occur automatically:

1. The current state of the project directory is archived.
2. The archive is named using the following convention:

```text
attendance_tracker_<project_name>_archive
```

3. The incomplete project directory is removed.
4. The script exits gracefully.

This behaviour prevents partially configured workspaces from cluttering the system while preserving any progress made before interruption.

---

## Testing the Archive Feature

To verify the interrupt handling functionality:

1. Start the setup process:

```bash
./setup_project.sh
```

2. While the script is running, press:

```text
Ctrl+C
```

3. Confirm that:

* An archive file has been created.
* The incomplete project directory has been removed.

Example:

```text
attendance_tracker_semester1_archive
```

should exist, while:

```text
attendance_tracker_semester1/
```

should no longer be present.

---

## Error Handling

The script includes safeguards to improve reliability, including:

* Detection of existing project directories.
* Validation of numeric user input.
* Graceful handling of execution interruptions.
* Cleanup of incomplete deployments.
* Ensures directory structure is consistent wherever it is ran

These measures help ensure consistent and reproducible project setup.

---
