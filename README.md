# Digilab-NG

Digilab-NG is a modern learning platform designed for Digital Laboratory courses that provides a comprehensive system for managing classes, modules, assignments, and social interactions. Built with React and Express, it features robust support for Markdown and LaTeX content, making it ideal for technical education.

The platform consists of several key components:

- **Classes Management**: Create and manage virtual classrooms for different lab courses
- **Module System**: Organize educational content in structured modules with file attachments
- **Assignment System**: Create assignments with deadlines, receive submissions, and provide feedback
- **Social Interaction**: A built-in social feed for discussions related to course materials
- **Announcements**: Share important updates with enrolled students

Students can enroll in classes, access educational materials, submit assignments, and participate in discussions. Teaching assistants (aslab) can create content, grade assignments, and manage the learning experience.

# 💻 Tech Stack:

![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB) ![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white) ![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white) ![Vite](https://img.shields.io/badge/vite-%23646CFF.svg?style=for-the-badge&logo=vite&logoColor=white) ![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB) ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) ![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white) ![JWT](https://img.shields.io/badge/JWT-black?style=for-the-badge&logo=JSON%20web%20tokens) ![Cloudinary](https://img.shields.io/badge/Cloudinary-%231563FF.svg?style=for-the-badge&logo=cloud&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

# Diagram

## Entity Relational Diagram
![alt text](ImageReadme/ERD.jpg)

## Unified Modelling Language
![alt text](ImageReadme/UML.jpg)

## Flowchart
![alt text](ImageReadme/flowchart.jpg)

# :computer: Installation Guide

Clone this repository

```
git clone https://github.com/your-username/Digilab-NG.git
```

## Frontend

- Ensure you're in the frontend directory

  ```
  cd frontend
  ```

- Create a `.env` file with the following content (for local):
  ```
  VITE_API_URL=http://localhost:5000/api
  ```

- Install dependencies (need to be forced)
  ```
  npm install --force
  ```

- Start the development server
  ```
  npm run dev
  ```

- The application will be available at `http://localhost:5173`

## Backend

- Ensure you're in the backend directory

  ```
  cd backend
  ```

- Create an `.env` file with the following variables:
  ```
  DATABASE_URL=postgres://your-username:your-password@localhost:5432/digilab
  JWT_SECRET=your_jwt_secret_key
  REDIS_URL=redis://localhost:6379
  CLOUDINARY_CLOUD_NAME=your_cloud_name
  CLOUDINARY_API_KEY=your_api_key
  CLOUDINARY_API_SECRET=your_api_secret
  ```

- Install dependencies
  ```
  npm install
  ```

- Start the development server
  ```
  npm run dev
  ```

- The API will be available at `http://localhost:5000/api`

# 💻 Key Features:

## Dashboard
![alt text](ImageReadme/DashboardScreenshot.jpg)

## Classes
![alt text](ImageReadme/ClassesListScreenshot.jpg)
![alt text](ImageReadme/IsiClassesScreenshot.jpg)
![alt text](ImageReadme/ClassesListScreenshot2.jpg)


## Module System with Markdown and LaTeX Support
![alt text](ImageReadme/editaddModule.jpg)

## Assignment Submission and Grading
![alt text](ImageReadme/AssigmentScreenshot.jpg)

## Threads Feed for Discussions
![alt text](ImageReadme/ThreadsScreenshot.jpg)

## News Feed for New Announcement
![alt text](ImageReadme/NewsScreenshot.jpg)

# 🚀 Deployment

## Using Docker

We provide Docker configuration for easy deployment:

```bash
# Build the Docker images
docker-compose build

# Start the services
docker-compose up -d
```

The application will be accessible at http://localhost:5173, with the API running at http://localhost:5000/api.

# 📋 Team Members

- Daffa Sayra Firdaus 
- Alexander Christian 
- Yehezkiel Jonathan
- Muhammad Avicenna Raffaiz Adiharsa

# Documentation
![alt text](ImageReadme/Progcek1.jpg)
![alt text](ImageReadme/Progcek2.jpg)

# 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.