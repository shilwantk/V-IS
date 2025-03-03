# MTV

Mtv is a SwiftUI-based iOS application that provides detailed information about movies and TV shows. Users can browse, search, and view details of various titles, leveraging a clean and responsive UI.

## Features

- **Movie & TV Show Listings**: Fetches and displays a list of movies and TV shows.
- **Detailed View**: Provides in-depth details about a selected title, including release date, plot overview, and poster.
- **Shimmer Effect**: Displays a loading animation while fetching data.
- **Error Handling**: Displays user-friendly messages in case of network failures.
- **SwiftUI & Combine**: Fully reactive UI using SwiftUI with data fetching and state management via Combine.

## Tech Stack

- **Language**: Swift
- **Frameworks**: SwiftUI, Combine
- **Networking**: URLSession, Combine framework
- **Dependency Injection**: API services are injected for better testability.
- **Unit Testing**: XCTest for ViewModels

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/V-IS.git
   ```
2. Navigate to the project folder:
   ```sh
   cd V-IS
   ```
3. Open the project in Xcode:
   ```sh
   open V-IS.xcodeproj
   ```
4. Build and run the app using an iOS Simulator or a physical device.

## Project Structure

```
V-IS/
├── Models/
│   ├── MovieTVItem.swift
│   ├── ItemDetails.swift
│
├── ViewModels/
│   ├── MovieTVViewModel.swift
│   ├── DetailsViewModel.swift
│
├── Views/
│   ├── MovieView.swift
│   ├── DetailsView.swift
│
├── Services/
│   ├── APIService.swift
│   ├── APIServiceProtocol.swift
│
├── Tests/
│   ├── MovieTVViewModelTests.swift
│   ├── DetailsViewModelTests.swift
│
├── Assets/
│   ├── AppIcon/
│   ├── LaunchScreen.storyboard
│
└── V-IS.xcodeproj
```

## API Integration

This app integrates with an external API using `AppConstants.baseURL` and `AppConstants.apiKey`. Ensure these values are correctly set before running the app.

## Running Tests

Run unit tests with:

```sh
CMD + U
```

Or via Xcode's Test Navigator.

## Contributing

1. Fork the repository.
2. Create a new branch (`feature/your-feature`).
3. Commit your changes.
4. Push to your branch and submit a Pull Request.

## License

This project is licensed under the MIT License.

---

### Author

**Kirti**

---

Feel free to reach out for suggestions or improvements!

