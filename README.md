# Shell

The **Bash Shell Library** provides a set of functions to simplify common shell scripting tasks, such as file manipulation, string processing, and system information retrieval.

- [1. Usage](#1-usage)
  - [1.1. Details](#11-details)
  - [1.2. Task Runner](#12-task-runner)

## 1. Usage

### 1.1. Details

1. Include Library

    Add the following line to the top of a shell script to include the library:

    ```bash
    #!/bin/bash

    source path/to/bash_library.sh
    ```

2. Explore Functions

    Browse the library files (`bash_library.sh` and related modules) to discover available functions. Use them directly in your scripts.

### 1.2. Task Runner

- [Makefile](Makefile)
  > Refer to the Makefile as the Task Runner file.

  > [!NOTE]
  > Run the `make help` command in the terminal to list the tasks used for the project.

  ```plaintext
  $ make help

  Tasks
          A collection of tasks used in the current project.

  Usage
          make <task>

          bootstrap           Initialize a software development workspace with requisites
          setup               Install and configure all dependencies essential for development
          teardown            Remove development artifacts and restore the host to its pre-setup state
  ```
