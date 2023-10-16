# Email Client

![logo](https://i.ibb.co/2gRmGVq/email-logo-min.jpg)

This project about a complex email client built using Flutter and other cutting-edge technologies. Below are the key features, components and demo of this email client.

## Try Now

#### [Email Client Web App](https://itayemail.online/)

## Features

- **Flutter Frontend:** A responsive and intuitive user interface built with Flutter to provide a seamless email client experience on various devices.

- **SQL Local Storage:** Emails and user data are stored securely in a local SQL database, ensuring data integrity and reliability.

- **Node.js Express Backend:** The backend server, developed using Node.js Express, efficiently handles SMTP and IMAP connections for sending and receiving emails.

- **Advanced Data Compression:** Utilizes GZIP compression to optimize data transfer, ensuring fast and efficient email communication.

- **JWT Security:** Implements JSON Web Tokens (JWT) for enhanced security, providing a secure way to authenticate and protect user data.

- **Docker Compose:** Easily set up the email client environment using Docker Compose, simplifying the deployment process and ensuring consistency across different platforms.


## Technologies Used

- **Flutter:** A popular open-source UI framework created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.

- **Node.js:** A JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js is used for the backend server, handling SMTP and IMAP connections, and implementing advanced data compression with GZIP.

- **Nginx:** A high-performance web server and reverse proxy server. Nginx is used for SSL termination, serving static assets, and providing additional security and optimization features.


## Screenshots

![Screenshot 1](https://i.ibb.co/3Cwjf2B/email-client-desktop-screenshot.png)
![Screenshot 2](https://i.ibb.co/sPPd4F7/email-client-desktop-screenshot2.png)

## Installation

### Using Docker Compose (Recommended)

1. **Download Docker Compose File:**
   You can download the `docker-compose.yaml` file from this repository.

2. **setup environment variables:**
   Create env folder with `backend.env` file
   ```bash
   PORT=1111
   JWT_SECRET=""
3. **Run Docker Compose:**
   ```bash
   docker-compose up -d
### Using Git Repository

##### 1. Clone the repository:
git clone https://github.com/Itay-Lavi/Email.git

##### 2. Navigate to the project directory:
cd Email

#### Flutter
##### 1. Navigate to the project directory
cd email_client

##### 2. Install the required dependencies
flutter pub get

##### 3. Run the app
flutter run

#### Nodejs

##### 1. Navigate to the project directory
cd backend

##### 2. Install the required dependencies
npm install

##### 2. Compile Typescript
npx tsc

##### 3. Run the app
npm start

### License
This project is licensed under the MIT License.

### Acknowledgments
Disclaimer: This app was developed as a personal project and is not affiliated with any official Israeli radio stations.

For any inquiries, please contact us at  itailavi0212@gmail.com.

© 2023 Email Client