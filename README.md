# Game Explorer

Game Explorer is an iOS application built using SwiftUI and the RAWG API.

## Features

- Browse games list
- Pagination (infinite scroll)
- Search games
- View game details
- Favorites management
- Offline cache fallback
- Network error handling

## Tech Stack

- SwiftUI
- Async/Await
- RAWG API
- Kingfisher (image loading & downsampling)
- CoreData (caching)
- Firebase Authentication

## Architecture

The application follows a layered architecture:

- View (SwiftUI)
- ViewModel (State management)
- Repository (Data abstraction)
- API Service (Networking)
- Persistence Service (Caching)

## Networking

Data is fetched from the RAWG API.  
Errors such as no internet or server failure are handled gracefully.

## Performance Improvements

Applied Kingfisher downsampling to reduce memory usage when loading large images.

## Testing

Unit tests cover ViewModel logic, repository behavior, and error scenarios.

## Build & Run

1. Open the project in Xcode
2. Provide RAWG API key if required
3. Run on simulator or device

## Known Limitations

- Uses a single RAWG API environment
- Basic search pagination behavior
