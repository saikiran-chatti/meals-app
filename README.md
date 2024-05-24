# Meals App 

![Built with Swift](https://img.shields.io/badge/Built%20with-Swift-FA7343?logo=swift)


A SwiftUI application to explore and view detailed information about various desserts. This app uses TheMealDB API to fetch dessert details and present them in a user-friendly interface.

## Features

- Fetch and display a list of desserts.
- View detailed information about each dessert, including ingredients and instructions.
- Navigate smoothly between the list view and detail view.
- Handle loading states and errors gracefully.

## Demo

Watch the demo video to see the app in action:


https://github.com/saikiran-chatti/meals-app/assets/46348137/1bf31e5f-10b0-46cb-94a5-0bada5636d18



## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/saikiran-chatti/meals-app.git
   cd meals-app
   ```

2. Open the project in Xcode:

   ```bash
   open Meals_app.xcodeproj
   ```

3. Build and run the project on your simulator or device.

## Usage

- On launch, the app fetches and displays a list of desserts.
- Tap on any dessert to view its detailed information, including ingredients and instructions.
- If there's an error fetching data, an alert will be shown with the error message.

## Code Overview

### Models

- `DessertListResponse`: Response model for a list of desserts.
- `Dessert`: Model representing a dessert.
- `MealDetailResponse`: Response model for detailed meal information.
- `MealDetail`: Model representing detailed information about a meal.

### ViewModels

- `DessertListViewModel`: Manages the list of desserts, handles API calls, and manages loading and error states.
- `MealDetailViewModel`: Manages the detailed information of a specific meal.

### Views

- `MealListView`: Displays the list of desserts.
- `MealRowView`: Displays a single row of meal information.
- `MealDetailView`: Displays detailed information about a specific meal.

### Services

- `APIService`: Singleton service for handling API requests to TheMealDB.

## API

This app uses [TheMealDB API](https://www.themealdb.com/api.php) to fetch dessert data. The following endpoints are used:

- `filter.php?c=Dessert`: Fetches a list of desserts.
- `lookup.php?i={id}`: Fetches detailed information about a specific meal by its ID.
