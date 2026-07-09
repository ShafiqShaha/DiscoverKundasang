# Video Presentation Script: Discover Kundasang 🎙️

Use this script as a word-for-word guide when recording your presentation video. It is structured to satisfy every criterion of the assignment rubric.

* **Target Duration**: ~8-10 Minutes (No time limit)
* **Formatting Key**:
  * 🎬 `[ACTION]` = What you should do on screen (clicks, scrolling, typing).
  * 🗣️ `[SPOKEN]` = The exact words you should speak.
  * 🎯 `[RUBRIC TRIGGER]` = Explains which grading rubric criteria is being satisfied in this segment.

---

### **Segment 1: Introduction & Project Scope (0:00 - 1:00)**
* **🎬 [ACTION]**: Start the recording with your web browser open directly to the **Developer Profile** page (`http://localhost:8080/discoverkundasang/developer.jsp`) showing your name (Shafiq Shaharuddin), Student ID (2023618226), Class (NBCS2306A), and course credentials clearly on the screen.
* **🗣️ [SPOKEN]**: 
  > *"Good day to my lecturer. Today, I am excited to present a live demonstration of my J2EE web application project, **Discover Kundasang**. This system is built using Java Servlets, dynamic JSP pages, and a MySQL database backend.*
  >
  > *Instead of slides, I will be conducting a direct, live walkthrough of the functional application and its codebase. As shown on my developer profile page, my name is Shafiq Shaharuddin, student ID 2023618226, class NBCS2306A.*
  >
  > *Let's begin by looking at the public portal homepage."*
* **🎯 [RUBRIC TRIGGER]**: Shows clear objectives, project scope, and professional presentation structure.

---

### **Segment 2: Public Website Tour & Persistent Audio Player (1:00 - 2:45)**
* **🎬 [ACTION]**: Open your browser at `http://localhost:8080/discoverkundasang/`. Refresh the page to show the preloader and the clean layout.
* **🗣️ [SPOKEN]**:
  > *"Here is the homepage of **Discover Kundasang**. When we load the website, we are greeted by a custom preloader that fades out to reveal the landing section. As we scroll down, we see the 'About Kundasang' section, featuring a fixed background image parallax effect, a dark forest-green overlay, and glassmorphic card details.*
  > *In the footer, you can see a floating lofi music player. To comply with browser security rules, it remains fully muted by default when the site loads, showing a volume-off icon so the user is not surprised by sudden sound."*
* **🎬 [ACTION]**: Click the music toggle button in the footer. The icon changes to a volume-on symbol, a pulse animation begins, and the lofi track plays.
* **🗣️ [SPOKEN]**:
  > *"As soon as I click the button, the player unmutes and plays. More importantly, this audio player uses client-side state tracking. Using JavaScript `localStorage`, it continuously saves the play/pause state and the exact playback timestamp. If I navigate to another page, the music continues playing seamlessly from the exact second it left off. Let's see this in action as we visit the **Gallery** page."*
* **🎬 [ACTION]**: Click on the **Gallery** link in the navbar. The page transitions with a smooth fade, and the lofi audio continues playing smoothly.
* **🗣️ [SPOKEN]**:
  > *"As you can hear, the music transitions between pages without interrupting the user. In the **Gallery** page, we have exactly **eight high-quality images** representing Kundasang landmarks, styled with hover title effects. Let's check the **Activities** page."*
* **🎬 [ACTION]**: Click on **Activities** in the navbar.
* **🗣️ [SPOKEN]**:
  > *"The **Activities** page showcases **four main attractions** using an alternating glassmorphic card layout. Let's visit the **Accommodation** page."*
* **🎬 [ACTION]**: Click on **Accommodation** in the navbar.
* **🗣️ [SPOKEN]**:
  > *"The **Accommodation** page displays **four popular stays**. Instead of dummy booking forms, I updated these buttons to say 'More Info'. Clicking on them takes the user directly to external official booking portals in a new browser tab using the secure `target='_blank'` attribute, ensuring our users get real-time rates."*
* **🎬 [ACTION]**: Click the **More Info** button for Umea Glam Kundasang to show it opening a new tab, then close it and return to the app. Navigate to the **Developer** page.
* **🗣️ [SPOKEN]**:
  > *"On the **Developer** page, I have detailed my student profile, course details, and links to my professional profiles. Throughout the entire public site, the navigation bar remains fully consistent and responsive."*
* **🎯 [RUBRIC TRIGGER]**: Highlights the **UI/UX & Navigation (15%)** and **Content & Gallery (15%)** criteria, specifically proving you met the exact count requirements (8 gallery images, 4 activities, 4 rooms, consistent navbar, and developer page) alongside custom state-tracking features.

---

### **Segment 3: Database Persistence & Diagnostic Checker (2:45 - 4:15)**
* **🎬 [ACTION]**: Click on **Contact** page. Scroll down to show the inquiry form.
* **🗣️ [SPOKEN]**:
  > *"Now let's explore the **Contact** page. It features an embedded interactive Google Map and a button to open Google Maps in a new tab.*
  >
  > *Below is the **Visitor Inquiry Form**. We have input fields for Name, Contact Number, Gender, Email, Source Channel, and Message. All fields are compulsory. If I try to submit the form empty, HTML5 validation blocks the request. If I enter temporary data and click the **Clear** button, it resets all input fields instantly. Let's submit a realistic inquiry."*
* **🎬 [ACTION]**: Fill out the form with actual test data (e.g., Name: `Adam Haris`, Phone: `012-7766554`, Gender: `Male`, Email: `adam@example.com`, Channel: `Friend Recommendation`, Message: `Hi, is it easy to secure a hiking slot for Mount Kinabalu in September?`). Click **Submit**.
* **🗣️ [SPOKEN]**:
  > *"Upon clicking **Submit**, the browser sends a POST request to **InquiryServlet**. The servlet establishes a JDBC connection, validates the input, and runs a SQL insert query to save the inquiry into the MySQL database. After saving, the servlet redirects back to the contact page and displays a green success feedback alert."*
* **🎬 [ACTION]**: Open browser tab at `http://localhost:8080/discoverkundasang/dbTest.jsp`.
* **🗣️ [SPOKEN]**:
  > *"To ensure the database setup is secure and robust, I followed industry best practices. Database credentials are kept in a Git-ignored `sql.env` file to protect passwords from being exposed on GitHub.*
  >
  > *I also built this **Database Diagnostic Checker** page. It displays the connection status and lists all database tables. If the database is empty, the teacher or user can initialize all required tables and populate mock data with a single click."*
* **🎯 [RUBRIC TRIGGER]**: Addresses the **Database Persistence (20%)** rubric. Proves form validation, JDBC connection, SQL inserts, user feedback, and security of environment credentials.

---

### **Segment 4: Admin Access & Session Protection (4:15 - 5:15)**
* **🎬 [ACTION]**: Click the **Login** link in the navigation bar.
* **🗣️ [SPOKEN]**:
  > *"Now let's examine the administrative portal. The admin dashboard is protected by a session guard. If an unauthorized user attempts to bypass the login screen by typing the servlet URL directly into the address bar..."*
* **🎬 [ACTION]**: Manually type `http://localhost:8080/discoverkundasang/DashboardServlet` in the address bar and press Enter. It should redirect back to `login.jsp`.
* **🗣️ [SPOKEN]**:
  > *"...As you can see, the servlet checks the HTTP Session. Since no user is logged in, it denies access and redirects back to the login page. Let's log in using our credentials: username `admin` and password `admin123`."*
* **🎬 [ACTION]**: Type `admin` and `admin123` in the login fields, then click **Sign In**.
* **🗣️ [SPOKEN]**:
  > *"Upon clicking Sign In, a secure session is initialized, and the page redirects to the administrator dashboard."*
* **🎯 [RUBRIC TRIGGER]**: Addresses **Security & Sessions (20%)** rubric. Proves strict session tracking, unauthorized URL block, and login verification.

---

### **Segment 5: Admin Dashboard, DataTables & Suggestion Center (5:15 - 7:30)**
* **🎬 [ACTION]**: Show the dashboard. Scroll down to the table.
* **🗣️ [SPOKEN]**:
  > *"Welcome to the **Admin Dashboard**. At the top, we have glassmorphic stats cards indicating the total inquiries count and the gender ratio calculated dynamically from the database.*
  >
  > *Below the cards is our **Visitor Inquiries Table**. I integrated this table with **jQuery DataTables** for advanced data management. As requested by the usability feedback, the table columns are optimized: Gender, Status, and Action columns are compact, and Date, Contact, and Tag fields are prevented from wrapping awkwardly. The Email column is fully readable.*
  >
  > *I also relocated the search input box to the same row as the table header on the right side. When we slide the table horizontally, the search bar remains locked in position. Let's search for the inquiry we just submitted."*
* **🎬 [ACTION]**: Type `Adam` in the header search input box. Watch the table filter instantly.
* **🗣️ [SPOKEN]**:
  > *"As you can see, the table filters instantly. The sorting arrows in the headers are fully functional, and pagination handles multiple rows smoothly.
  >
  > *Now, let's look at the **Reply and Suggestion System**. In the table, each row has a status badge:
  > - Green **Replied** badges indicate we have already sent advice.
  > - Yellow **Pending** badges indicate new customer questions.
  > 
  > *For the record we just searched, the status is **Pending**. I will click the **Reply** button."*
* **🎬 [ACTION]**: Click the **Reply** button next to Adam Haris's record. The reply modal pops up.
* **🗣️ [SPOKEN]**:
  > *"This launches a custom glassmorphic modal containing the visitor's details and message. I will type our official suggestions in the text area."*
* **🎬 [ACTION]**: Type a short reply (e.g., `Hello Adam, yes! Hiking slots are limited. We suggest booking at least 3-6 months in advance through Sutera Sanctuary Operators.`). Click **Save Suggestion**.
* **🗣️ [SPOKEN]**:
  > *"When I click Save Suggestion, the form submits a POST request directly to our J2EE controller, **DashboardServlet**. The servlet processes the form data and updates the inquiry row in MySQL with our reply text and a timestamp.*
  >
  > *Upon successful update, the page redirects back to the dashboard, and as you can see, Adam's status has now transitioned to a green **Replied** badge. The system now replaces the reply button with a **View** button."*
* **🎬 [ACTION]**: Click the **View** button on Adam Haris's row. The read-only view modal pops up.
* **🗣️ [SPOKEN]**:
  > *"...it opens a read-only modal displaying our saved suggestion and the exact reply timestamp. Let's log out to securely end our session."*
* **🎬 [ACTION]**: Click the **Logout** button.
* **🗣️ [SPOKEN]**:
  > *"Logging out invalidates the session, locking the servlet routes again."*
* **🎯 [RUBRIC TRIGGER]**: Highlights **Admin Dashboard (20%)** and **Security & Sessions (20%)**. Proves advanced DataTable custom styling, interactive modal dialog flows, and status state persistence.

---

### **Segment 6: Database Migrations & Codebase Structure (7:30 - 8:30)**
* **🎬 [ACTION]**: Open your IDE or project file browser showing the files directory.
* **🗣️ [SPOKEN]**:
  > *"For maximum deployment compatibility, I implemented a J2EE **Auto-Migration script** inside the servlet. If the dashboard is loaded on a new database that does not have the reply columns, the servlet automatically detects this and updates the schema on the fly. This ensures the application works out-of-the-box for grading.
  >
  > *The codebase is organized cleanly. In the root, we have our `pom.xml` configuration, the `database.sql` setup file, and local deployment script helpers. All presentation plans and scripts have been moved to the `extra_materials` folder so the root folder remains tidy for final submission."*
* **🎯 [RUBRIC TRIGGER]**: Proves codebase organization, version control friendliness, and deployment stability.

---

### **Segment 7: Conclusion (8:30 - END)**
* **🎬 [ACTION]**: Show the homepage one last time.
* **🗣️ [SPOKEN]**:
  > *"In summary, the Discover Kundasang web portal integrates robust front-end layouts with persistent background audio, reliable Servlet-based controllers, secure database queries, and a highly interactive admin panel.
  >
  > *That concludes my system presentation. Thank you very much."*
* **🎯 [RUBRIC TRIGGER]**: Summarizes deliverables and wraps up the presentation professionally.
