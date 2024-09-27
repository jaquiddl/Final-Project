## PLOT ##
iOS app designed to help users fetch book information by title or author, manage personal libraries, and categorize books into specific lists: to read, reading, and read.
The app also allows users to track their reading progress, including the current page they're on for each book.

<p align="center">
  <img src="Final-Project/Assets.xcassets/logIn.imageset/logIn.png" alt="Image 1" width="200"/>
  <img src="Final-Project/Assets.xcassets/createUser.imageset/createUser.png" alt="Image 1" width="200"/>
  <img src="Final-Project/Assets.xcassets/profile.imageset/profile.png" alt="Image 1" width="200"/>
  <img src="Final-Project/Assets.xcassets/readingBook.imageset/readingBook.png" alt="Image 1" width="200"/>
  <img src="Final-Project/Assets.xcassets/readingList.imageset/readingList.png" alt="Image 1" width="200"/>
  <img src="Final-Project/Assets.xcassets/search.imageset/search.png" alt="Image 1" width="200"/>
</p>

### Features

1. User Authentication and Sync
   * Create and authenticate users with Firebase.
   * Sync user data across devices.
2. User Data Storage
   * Store and manage user data using Firebase Firestore.
3. Book Information Fetching
   * Retrieve detailed book information (title, author(s), description, publisher, etc.) from external sources.
4. Book Categorization
   * Organize books into categories: To Read, Reading, and Read.
5. Reading Progress Tracking
   * Track and update current reading progress by updating the current page.

### Tech Stack
* SwiftUI
* Xcode (iOS 17)
* Firebase Authentication
* Firestore
* Google Books API
* Disk cache

### App Structure

1. Authentication
   - **AuthViewModel.swift:** Handles user authentication through firebase.
     * Checks if there is an existing user session.
     * Users Sign-in/Log-in with email and password
     * Fetch current user data.
2. Managers
   - **NetworkManager.swift:** handles network calls to retrieve data from the Google Books API.
     * Fetches books data by search query or book(s) ID(s).
     * Checks for cached books before making a request or stores the book data if book is selected for a category.
   - **BooksManager.swift:** stores, updates and retrieves users' book data in firebase firestore.
     * Updates the books dictrionary to store the status and timestamp for a specific book ID.
     * Checks if a book is in the dictionary, retrieves its current status, and either moves it to a new category or leaves it unchanged.
     * Updates the reading progress dictionary for 'reading' books with the current page and timestamp.
     * Fetches users' books data to display it in UI.
3. Screens
   - Welcome
     - **WelcomeView.swift:** UI that welcomes the user to the app with two buttons to select, sign up or log in. 
   - SignUp
     - **SignUpView.swift:** Contains the UI with the name, email and password fields.
       - When focused, displays a checkmark for valid emails or 'Invalid text' for incorrect formats.
       - When focused, displays green checkmarks as each password requirement is met. (e.g., has uppercase letter, lowercase letter, special        character, number, etc. )
     - **SignUpViewModel.swift:** Validates the user email and password formats.
       - Sets a timer that triggers whenever the email and password fields change, allowing SignUpView to display the right checkmarks. 
       - Validates the email format (e.g., validemail.com) with a string extension in **String+Ext.swift**.
       - Validates the password format with boolean variables and a string extension.
       - Creates a new user through AuthViewModel.
   - LogIn
     - **LogInView.swift:** Contains the UI with the name and email fields.
       - When focused, displays a checkmark for valid emails or 'Invalid text' for incorrect formats.
       - Cheks if both email and password formats are valid.
       - Checks for a successfull log in through AuthViewModel.
     - **LogInViewModel.swift:** Validates the user email and password formats.
       - Sets a timer that triggers whenever the email and password fields change, allowing LogInView to display the right checkmarks.
       - Validates the email and password formats with string extensions and boolean variables
   - Tabs
     - **AppTabView.swift:** Main view that contains the tabView (home, search and profile).
     - Home
       - **HomeView.swift:**
     - Search
       - **SearchView.swift:**
       - **SearchViewModel.swift:**
    - Profile
       - **ProfileView.swift:**
       - **ProfileViewModel.swift:**
       - Profile Sections
         - Posts
         - To Read
         - Reading
         - Read



