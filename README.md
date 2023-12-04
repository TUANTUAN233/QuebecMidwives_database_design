
# GoBabby Midwife Services Database System

## Introduction

This project is a database system designed to manage midwife services efficiently. It was created to facilitate the scheduling and tracking of appointments, as well as the maintenance of patient records and midwife activities, within the healthcare domain. The system leverages a robust database back-end with a user-friendly Java application front-end for interaction.

## ER Model

The entity-relationship (ER) model provides a visual representation of the data structure and the relationships within the database. It is an essential part of the database design and is implemented through the provided SQL scripts.

![Entity-Relationship Model](path_to_your_image.png)

## Project Structure

The project is composed of a Java application and a set of SQL scripts managed by shell scripts for ease of use.

- `GoBabbyApp.java`: The main Java application that interfaces with the database via JDBC.
- `createtbl.sql` / `createtbl.sh`: SQL script and shell script for creating the database schema.
- `droptbl.sql` / `droptbl.sh`: SQL script and shell script for dropping the database tables.
- `loaddata.sql` / `loaddata.sh`: SQL script and shell script for populating the database with initial data.

## Setup and Installation

To set up the project, clone the repository and navigate to the project directory:

```sh
git clone [repository URL]
cd [project directory]
```

Ensure that the shell scripts are executable:

```sh
chmod +x *.sh
```

Run the `createtbl.sh` script to create the database tables:

```sh
./createtbl.sh
```

To populate the database with initial data, run:

```sh
./loaddata.sh
```

## Usage

### Starting the Application

Execute the `GoBabbyApp.java` to launch the application:

```sh
java GoBabbyApp.java
```

Follow the on-screen prompts to navigate through the application.

### Application Workflow

1. **Practitioner ID**: Enter your practitioner ID or type `E` to exit.
2. **Appointment Date**: Enter the date for which you want to view appointments or type `E` to exit.
3. **Appointment List**: Select an appointment to manage or type `E` to exit or `D` to enter a different date.

#### Managing Appointments

- **Review notes**: Lists all notes for the selected pregnancy.
- **Review tests**: Lists all tests for the selected pregnancy.
- **Add a note**: Allows adding a new note to the pregnancy record.
- **Prescribe a test**: Prescribe a new test for the patient.
- **Go back**: Returns to the list of appointments.

Each option provides a simple and intuitive interface for midwives to efficiently manage their appointments and patient interactions.

## Contributing

We welcome contributions to this project. To contribute, please fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
