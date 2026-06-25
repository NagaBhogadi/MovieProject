# Movie API UIKit App

## Overview

Movie API UIKit App is an iOS application built using **Swift** and **UIKit**.

This app fetches movie data from **TMDB API** and displays movies in a table view.
When the user taps a movie, the app navigates to a detail screen and shows more movie information.

## Screenshot

### Movie Screen

<img width="295" height="640" alt="Simulator Screen Recording - iPhone 17 Pro - 2026-06-24 at 14 10 52" src="https://github.com/user-attachments/assets/ac03828c-87d5-4b02-9006-a794fbe956a1" />


## Features

* UIKit programmatic UI
* TMDB API integration
* UITableView with custom cell
* Movie poster image loading
* Activity indicator while loading data
* Movie detail screen
* Data passing between view controllers
* JSON parsing using Codable
* API call using URLSession
* MVC architecture

## Project Structure

```text
MovieProject
├── Common
│   └── ImageViewExtension.swift
├── Constants
│   └── APIConstants.swift
├── Model
│   └── Movie.swift
├── Controller
│   ├── MovieViewController.swift
│   └── MovieDetailViewController.swift
├── View
│   └── MovieCell.swift
├── NetworkManager
│   └── NetworkManager.swift
├── Screenshots
│   ├── movie_list.gif
│   └── movie_details.png
└── README.md
```

## API Used

Movie data is fetched from TMDB API.

```text
https://api.themoviedb.org/3/discover/movie
```

Image base URL:

```text
https://image.tmdb.org/t/p/w500
```

The API gives only an image path like this:

```text
/posterImagePath.jpg
```

So the app creates a full image URL like this:

```swift
let fullImageURL = APIConstants.sharePathImg() + posterPath
```

## Technologies Used

* Swift
* UIKit
* UITableView
* URLSession
* Codable
* Auto Layout
* MVC
* GitHub

## What I Learned

* Creating UI programmatically
* Fetching API data using URLSession
* Parsing JSON using Codable
* Loading images from URL
* Creating custom UITableViewCell
* Passing data to another view controller
* Navigating using UINavigationController
* Using Git and GitHub with Xcode

## Author

Naga Rajitha Bhogadi
