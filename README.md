# Discover Kundasang 🏔️

A clean, responsive, and interactive Java Web Portal showcasing the scenic highland tourism of **Kundasang, Sabah, Malaysia**. Built with Jakarta Servlet technology and a MySQL database backend, this portal allows visitors to explore attractions, accommodations, and activities, while also submitting inquiries. A secure administration panel allows managing incoming inquiries.

---

## 🚀 Features

- **Responsive Landing Page**: Modern, responsive layout highlighting the beautiful sights, rich culture, and fresh environment of Kundasang.
- **Dynamic Accommodations & Activities Sections**: Details on lodging and attractions with curated imagery and sleek transitions.
- **Interactive Inquiry Form**: A user-friendly form that validates input and saves inquiry records to a MySQL database.
- **Admin Dashboard**: A secure portal with session management where administrators can log in, view, search, and manage user inquiries.
- **Automated Deployment**: Local PowerShell (`deploy.ps1`) and Batch (`deploy.bat`) scripts to build the Maven WAR artifact and deploy it directly to an Apache Tomcat server.

---

## 🛠️ Tech Stack & Dependencies

- **Java Version**: Java 17 (LTS)
- **Framework/Specs**: Jakarta Servlet API 6.0, JSP (JavaServer Pages), JSTL (Jakarta Server Pages Standard Tag Library)
- **Database**: MySQL Server 8+
- **Build Tool**: Apache Maven
- **Secret Management**: `dotenv-java` (loads database credentials securely from a local environment file)
- **Frontend Utilities**: HTML5, Vanilla CSS3 (custom responsive grid, blur transitions, and glassmorphic cards), Feather Icons

---

## 📂 Project Structure

```
├── .idea/                 # IDE Configuration files
├── src/
│   ├── main/
│   │   ├── java/          # Java controller Servlets & DB utilities
│   │   └── webapp/        # JSP files, styles, scripts, and image assets
│   └── test/              # Unit tests
├── database.sql           # MySQL database configuration & table schemas
├── sql.env                # Local DB environment variables (Ignored in Git)
├── deploy.ps1             # PowerShell script for compiling & deploying to Tomcat
├── deploy.bat             # Batch script for compiling & deploying to Tomcat
├── pom.xml                # Maven configuration file (Project Object Model)
└── .gitignore             # Configured git ignore patterns (excluding secrets & targets)
```

---

## ⚙️ Local Setup Instructions

### 1. Prerequisites
Ensure you have the following installed locally:
- **Java SE Development Kit (JDK) 17**
- **Apache Maven**
- **Apache Tomcat 11.0.x** (or compatible version)
- **MySQL Community Server**

### 2. Database Setup
1. Open your MySQL client (e.g., MySQL Workbench or terminal).
2. Execute the setup script from the `database.sql` file. This creates the database `discover_kundasang` and creates the `inquiries` and `admins` tables.
   ```sql
   SOURCE C:/path/to/project/database.sql;
   ```
3. The database script pre-configures a default administrator:
   - **Username**: `admin`
   - **Password**: `admin123`

### 3. Environment Secrets configuration
Create a file named `sql.env` in the root folder of the project. Fill in your local MySQL login credentials:
```properties
DB_URL=jdbc:mysql://localhost:3306/discover_kundasang?useSSL=false&allowPublicKeyRetrieval=true
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
```
*(Note: `sql.env` is added to `.gitignore` to prevent committing your password details to version control.)*

### 4. Build & Deploy
If you are running Apache Tomcat locally, update the webapps destination path in `deploy.ps1` or `deploy.bat`:
- **For PowerShell (`deploy.ps1`)**:
  ```powershell
  $TomcatWebapps = "C:\path-to-tomcat\webapps"
  ```
- **For Batch (`deploy.bat`)**:
  ```cmd
  set TOMCAT_WEBAPPS="C:\path-to-tomcat\webapps"
  ```

Run the script to package the WAR and copy it to Tomcat:
- In PowerShell:
  ```powershell
  ./deploy.ps1
  ```
- In Command Prompt:
  ```cmd
  deploy.bat
  ```

### 5. Access the Web Portal
Once the Tomcat server is running and the application deployment finishes, open your browser and navigate to:
```
http://localhost:8080/discoverkundasang/
```

---

## 👨‍💻 Developer Info

Created as an academic project for **CSC584 Individual Assignment** at **UiTM Shah Alam**.
- **Developer**: Shafiq Shaharuddin
- **GitHub**: [@ShafiqShaha](https://github.com/ShafiqShaha)
- **LinkedIn**: [Shafiq Shaharuddin](https://www.linkedin.com/in/muhammad-shafiq-bin-shaharuddin-15b997196)
- **Email**: [2023618226@student.uitm.edu.my](mailto:2023618226@student.uitm.edu.my)
