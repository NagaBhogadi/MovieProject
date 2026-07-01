# 🎬 Movie Explorer

A modern iOS application built with **UIKit** and the **MVVM architecture** that allows users to discover popular movies from **The Movie Database (TMDB)**. The app features a clean, dark-themed interface, asynchronous image loading, dependency injection, and a well-organized project structure following iOS best practices.

---

# 📱 Features

* 🎥 Browse popular movies from TMDB
* 📄 View detailed information for each movie
* 🖼️ Load movie posters and backdrops asynchronously
* ⭐ Display ratings, vote count, popularity, and release date
* 🌍 Show original movie language
* ⏳ Activity Indicator while fetching data
* 📱 Programmatic UIKit (No Storyboards)
* 🧩 MVVM Architecture
* 💉 Dependency Injection
* 🧹 Clean Code with MARK sections
* 🔄 Reusable UITableViewCell
* 🌐 REST API Integration
* 📦 Codable JSON Parsing

---

# 🏗️ Architecture

This project follows the **MVVM (Model–View–ViewModel)** architecture.

```
View
│
├── MovieViewController
├── MovieDetailViewController
│
ViewModel
│
├── MovieDetailsViewModel
│
Model
│
├── Movie
├── MovieResponse
│
Network
│
├── NetworkManager
│
Utilities
│
├── APIConstants
├── UIImageView Extension
```

---

# 🛠️ Technologies Used

* Swift 6
* UIKit
* MVVM Architecture
* URLSession
* Codable
* Auto Layout (Programmatic)
* Dependency Injection
* Singleton Pattern
* Extensions
* TMDB REST API

---

# 📂 Project Structure

```
MovieApp
│
├── Constants
│   └── APIConstants.swift
│
├── Models
│   ├── Movie.swift
│   └── MovieResponse.swift
│
├── Network
│   └── NetworkManager.swift
│
├── ViewModels
│   └── MovieDetailsViewModel.swift
│
├── Views
│   └── MovieCell.swift
│
├── Controllers
│   ├── MovieViewController.swift
│   └── MovieDetailViewController.swift
│
├── Extensions
│   └── UIImageView+Extension.swift
```

---

# 🚀 How It Works

1. The application launches with `MovieViewController`.
2. `MovieViewModel` requests movie data from `NetworkManager`.
3. `NetworkManager` calls the TMDB Discover Movies API.
4. The JSON response is decoded into Swift models using `Codable`.
5. The ViewModel stores the movie data.
6. The ViewController reloads the table view.
7. Selecting a movie opens the detail screen with additional information.

---

# 📸 Screenshots

### Movie List

<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-25 at 09 47 55" src="https://github.com/user-attachments/assets/f2755fc9-0f34-4be6-bee4-404aff7da962" />


### Movie Details

<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-25 at 09 48 05" src="https://github.com/user-attachments/assets/a3be0fe3-64a5-4f13-b1c4-40fbeb2e4c00" />

### App Working

<img width="295" height="640" alt="Simulator Screen Recording - iPhone 17 Pro - 2026-06-25 at 13 44 56" src="https://github.com/user-attachments/assets/669f8b28-5a24-4a06-b7ef-83f31369d53a" />


---

# 🔑 API

**Movie Database (TMDB)**

* Discover Movies Endpoint
* Poster Images
* Backdrop Images

---

# 📚 Concepts Practiced

* MVVM Architecture
* Dependency Injection
* UITableView
* UITableViewCell
* UINavigationController
* URLSession Networking
* JSON Parsing
* Codable
* Auto Layout
* UIImageView Extension
* Async Image Loading
* Singleton Pattern
* Protocol-Oriented Programming
* Memory Management (`weak self`)
* Activity Indicator
* Programmatic UI

---

# 🔮 Future Improvements

* Search Movies
* Pagination
* Pull to Refresh
* Offline Caching
* Favorites
* Unit Testing
* Swift Concurrency (async/await)
* Image Caching
* Error Handling Improvements

---

# 👩‍💻 Author

**Naga Rajitha Bhogadi**

Passionate iOS Developer focused on building clean, scalable, and maintainable UIKit applications while continuously learning modern iOS development practices.
