# 📽️ Video Presentation Script - Discover Kundasang J2EE Web Application
**Assignment Title**: Tourism in Malaysia (Individual Assignment - 20%)  
**Presenter**: Muhammad Shafiq Bin Shaharuddin (Student ID: 2023618226, Class: NBCS2306A)  

---

## **Segment 1: Introduction & Project Overview (0:00 - 0:45)**
* **🎬 [ACTION]**: Open browser at `http://localhost:8080/discoverkundasang/developer.jsp`. Point to your photo and student details.
* **🗣️ [SPOKEN]**:
  > *"Good day to my lecturer. Today, I am demonstrating my J2EE Web Application project titled **Discover Kundasang**, a tourist hub in Sabah, Malaysia. This is developed for the Web Front-End Development Individual Assignment.*
  > 
  > *As shown on my screen, this is the **Developer Page** which displays my photo, name, student ID, and contact details as required. The application is built using Java Servlets, JSP, JDBC, and a MySQL database backend.*
  > 
  > *Let's begin the walkthrough of the public website by navigating to the Homepage."*

---

## **Segment 2: Public Website & Gallery Content Tour (0:45 - 2:15)**
* **🔍 [RUBRIC FOCUS]**: **UI/UX & Navigation (15%)** and **Content & Gallery (15%)**
* **🎬 [ACTION]**: Click on the **Home** link in the navbar. Refresh the page to show the custom preloader.
* **🗣️ [SPOKEN]**:
  > *"Here is the homepage of **Discover Kundasang**. As we load the site, we see a smooth custom preloader animation that fades out to reveal the main landing layout. The interface is styled with a modern forest-green theme, custom typography, and a parallax scroll effect on the main 'Hero' section, meeting the **UI/UX & Navigation** criteria for a responsive, professional UI.*
  > 
  > *Next, let's look at the **Gallery Page**."*
* **🎬 [ACTION]**: Click on **Gallery** in the navbar. Hover over the images to show the caption effects.
* **🗣️ [SPOKEN]**:
  > *"Under the **Content & Gallery** rubric, we are required to have exactly **eight (8) images**. As you can see, I have exactly 8 high-quality images representing Kundasang landmarks, styled with custom glassmorphic hover overlays showing their titles.*
  > 
  > *Now, let's move to the **Activities Page**."*
* **🎬 [ACTION]**: Click on **Activities** in the navbar. Scroll down slowly.
* **🗣️ [SPOKEN]**:
  > *"For **Activities**, we are required to showcase exactly **four (4) things to do**. I have set up 4 cards showcasing activities like visiting the Desa Dairy Farm and Mount Kinabalu botanical trails, complete with structured titles, high-resolution images, and balanced text descriptions.*
  > 
  > *Let's visit the **Accommodation Page**."*
* **🎬 [ACTION]**: Click on **Accommodation** in the navbar.
* **🗣️ [SPOKEN]**:
  > *"Similarly, the **Accommodation Page** showcases exactly **four (4) places to stay**. To make this user experience premium, the booking buttons say 'More Info' and redirect the visitor directly to official resort booking portals in a new browser tab using the secure `target='_blank'` attribute, satisfying the **External Link** requirement. Let's see this in action."*
* **🎬 [ACTION]**: Click the **More Info** button for Umea Glam Kundasang. A new tab opens showing the official booking portal. Close the tab and return.
* **🗣️ [SPOKEN]**:
  > *"Notice that as I navigate across all pages, the navigation header remains fully consistent and responsive, proving a seamless user experience."*

---

## **Segment 3: Visitor Inquiry & Database Persistence (2:15 - 3:45)**
* **🔍 [RUBRIC FOCUS]**: **Database Persistence (20%)**
* **🎬 [ACTION]**: Click on the **Contact** page. Scroll down to show the Google Map and the form.
* **🗣️ [SPOKEN]**:
  > *"Here on the **Contact Page**, we have an interactive embedded Google Map. Below it is the **Visitor Inquiry Form**, which contains all required fields: Name, Contact Number, Gender, Email Address, the 'How did you know about us?' dropdown list, and a Message text area.*
  > 
  > *To address the **Validation** requirement, all fields are set to compulsory. If I try to submit an empty form, HTML5 validation blocks it immediately. If I type some garbage text and click the **Clear** button, the form is instantly reset and emptied, fulfilling the Form Reset requirement.*
  > 
  > *Let's submit a realistic inquiry to test our JDBC connection."*
* **🎬 [ACTION]**: Fill out the form with mock data (e.g. Name: `Adam Haris`, Phone: `+6012-000-0040`, Gender: `Male`, Email: `adam@gmail.com`, Source: `Social Media`, Message: `Hi, do we need to book Desa Dairy Farm entrance tickets online beforehand?`). Click **Submit**.
* **🗣️ [SPOKEN]**:
  > *"Upon clicking **Submit**, the form issues a POST request to our Java Servlet, `InquiryServlet`. The Servlet establishes a secure **JDBC connection**, parses the form inputs, and saves them into the MySQL `inquiries` table. The Servlet then redirects back to the contact page, showing a green alert box reading 'Inquiry Sent Successfully!' for immediate user feedback.*
  > 
  > *Let's verify this on the **Database Diagnostic Checker** page."*
* **🎬 [ACTION]**: Open browser at `http://localhost:8080/discoverkundasang/dbTest.jsp`.
* **🗣️ [SPOKEN]**:
  > *"I built this Diagnostic Checker page to show the database status. As you can see, the JDBC connection status is green, and it displays our table structure. The database connection parameters are kept inside a secure `sql.env` file, which is Git-ignored, protecting credentials from being exposed on GitHub."*

---

## **Segment 4: Admin Access & Session Security (3:45 - 4:45)**
* **🔍 [RUBRIC FOCUS]**: **Security & Sessions (20%)**
* **🎬 [ACTION]**: Copy the URL `http://localhost:8080/discoverkundasang/DashboardServlet`. Logout first if already logged in. Open a new private browser window or tab, paste the URL, and press enter.
* **🗣️ [SPOKEN]**:
  > *"Under the **Security & Sessions** rubric, the Admin Dashboard must be fully protected. If an unauthorized user tries to bypass the login screen by pasting the Servlet URL directly into the address bar, the system's `HttpSession` check detects it instantly and redirects them back to the login screen.*
  > 
  > *Let's test logging in with invalid credentials first."*
* **🎬 [ACTION]**: Go to the login page `http://localhost:8080/discoverkundasang/login.jsp`. Enter username `admin` and password `wrongpassword`. Click **Login**.
* **🗣️ [SPOKEN]**:
  > *"Entering incorrect credentials displays a red error warning alert. Let's log in using the correct credentials: username `admin` and password `admin123`."*
* **🎬 [ACTION]**: Type `admin` and `admin123`. Click **Login**.
* **🗣️ [SPOKEN]**:
  > *"Now that we are authenticated, a secure session is bound to the server, and we are redirected to the Admin Dashboard."*

---

## **Segment 5: Admin Dashboard & jQuery DataTable (4:45 - 6:00)**
* **🔍 [RUBRIC FOCUS]**: **Admin Dashboard (20%)** and **Organization & Video (10%)**
* **🎬 [ACTION]**: Point to the dashboard header showing the inquiry metrics and total records (39 inquiries).
* **🗣️ [SPOKEN]**:
  > *"Our **Admin Dashboard** maps to the **Admin Dashboard (20%)** rubric. It displays all customer inquiries. To fulfill the database count request, I have seeded **39 realistic inquiries** in the database using diverse email domains.*
  > 
  > *The data is rendered using the **jQuery DataTables** plugin, which supports advanced sorting by clicking headers, instant search filtering, and pagination controls at the bottom. Let's search for Gmail users by typing 'gmail.com' in the search bar."*
* **🎬 [ACTION]**: Type `gmail.com` in the search bar. Show that only Gmail accounts remain. Clear the search.
* **🗣️ [SPOKEN]**:
  > *"We can also reply to customer questions directly from this dashboard. Let's click the **View/Reply** action button on Adam Haris's inquiry."*
* **🎬 [ACTION]**: Click the **View/Reply** button on the row for Adam Haris. Type: `Yes, entrance tickets should be purchased online at least 1 day in advance.` and click **Save Suggestion**.
* **🗣️ [SPOKEN]**:
  > *"This opens a custom dialog box. Clicking **Save Suggestion** executes an update statement in MySQL via a POST request to the dashboard servlet, updating the record status locally. No external email redirection is triggered, keeping the user inside the web application.*
  > 
  > *Finally, let's log out."*
* **🎬 [ACTION]**: Click the **Logout** button.
* **🗣️ [SPOKEN]**:
  > *"Clicking **Logout** immediately invalidates the current `HttpSession` on the server and redirects us back to the homepage. If I try to press the browser back button, the dashboard cannot be accessed because the session is completely destroyed.*
  > 
  > *This concludes the live demo. As you can see, every criterion in the rubric has been met with professional UI, robust database logic, secure sessions, and organized packaging. Thank you."*
