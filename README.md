# Egypt Travel App

A comprehensive travel application for exploring Egypt, built with Flutter and following Clean Architecture principles.

## Features

- **Authentication**: User registration, login, and password reset
- **Social Feed**: Share your travel experiences and connect with other travelers
- **Photo Sharing**: Upload and share photos in your posts (Firebase Storage)
- **Places**: Explore popular places to visit in Egypt, with filtering by category, type, or rating
- **Trip Suggestions**: Get curated trip suggestions based on popular destinations
- **City Transportation**: View public transport options, schedules, and prices for each city
- **City Music**: Listen to popular songs related to each city
- **Landmark Camera Search (Accessibility)**: Use your camera to recognize landmarks and hear descriptions via text-to-speech
- **Landmarks**: Discover historical landmarks and attractions
- **Hotels**: Find and book the best hotels in Egypt
- **Maps**: Interactive maps to help you navigate
- **Chat**: Connect with other travelers and locals
- **Travel Time Estimation**: Estimate travel time between destinations with traffic and weather conditions
- **Favorites List**: Save and manage your favorite places, hotels, and restaurants

## Architecture

This application follows Clean Architecture principles, with a clear separation of concerns:

- **Domain Layer**: Contains business logic, entities, and use cases
- **Data Layer**: Handles data retrieval from remote and local sources
- **Presentation Layer**: Manages UI components and state using Cubit pattern

## Tech Stack

- Flutter for cross-platform mobile development
- Firebase for authentication, database, and photo storage
- BLoC/Cubit for state management
- Get_it for dependency injection
- Shared Preferences for local storage
- HTTP for API requests

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase for your project (Firestore and Storage)
4. Run the app using `flutter run`

## Project Structure

The project follows a feature-based structure, with each feature having its own domain, data, and presentation layers:

```
lib/
  ├── core/                 # Core functionality and utilities
  ├── features/             # Feature modules
  │   ├── auth/             # Authentication feature
  │   ├── social/           # Social feed & photo sharing (Firebase)
  │   ├── places/           # Places feature (with filtering)
  │   ├── trip_suggestions/ # Trip suggestions feature
  │   ├── city_transport/   # City transportation info feature
  │   ├── city_music/       # City music feature
  │   ├── landmarks/        # Landmarks feature
  │   ├── map/              # Map feature
  │   ├── chat/             # Chat feature
  │   ├── favorites/        # Favorites feature
  │   └── onboarding/       # Onboarding feature
  ├── main.dart             # Entry point
  └── constants/            # App-wide constants
```

## Clean Architecture Refactoring

This project has been refactored to follow Clean Architecture principles, with the following structure:

### Project Structure

```
lib/
  ├── core/                 # Core functionality
  │   ├── di/               # Dependency injection
  │   ├── error/            # Error handling
  │   ├── network/          # Network utilities
  │   └── util/             # Utilities
  ├── constants/            # App constants
  ├── features/             # Features (following Clean Architecture)
  │   ├── auth/             # Authentication feature
  │   ├── landmarks/        # Landmarks feature
  │   ├── social/           # Social & photo sharing (Firebase)
  │   ├── map/              # Map feature
  │   ├── places/           # Places feature (with filtering)
  │   ├── trip_suggestions/ # Trip suggestions feature
  │   ├── city_transport/   # City transportation info feature
  │   ├── city_music/       # City music feature
  │   ├── chat/             # Chat feature
  │   ├── favorites/        # Favorites feature
  └── widgets/              # Common widgets
```

### Clean Architecture

The project follows the Clean Architecture pattern with three main layers:

1. **Presentation Layer**: Contains UI components, Cubit for state management, and pages.
2. **Domain Layer**: Contains business logic, use cases, entities, and repository interfaces.
3. **Data Layer**: Contains repository implementations, data sources, and models.

### State Management

The project uses the Cubit pattern from the flutter_bloc package for state management. Each feature has its own Cubit for managing state.

### Dependency Injection

The project uses get_it for dependency injection, making it easy to manage dependencies and facilitate testing.

## Features

### Authentication

- User registration and login
- Password reset functionality
- Profile management

### Social & Photo Sharing (Firebase)

- User profiles
- News feed
- Post creation and sharing
- Photo sharing (upload to Firebase Storage)
- User interactions

### Map

- Interactive map view
- Location search
- Distance calculation
- Travel time estimation
- Transport cost estimation

### Places (with Filtering)

- List of tourist places
- Place details
- Filtering options by category, type, or rating
- Favorites list

### Trip Suggestions

- Curated trip suggestions based on popular destinations
- Each suggestion includes a title, description, image, and list of places

### City Transportation

- Public transport options for each city (bus, metro, tram, etc.)
- Schedules and ticket prices
- Detailed descriptions

### City Music

- Popular songs related to each city
- Listen to music and view details for each city

### Landmark Camera Search (Accessibility)

- Use your camera to recognize landmarks (Google ML Kit integration ready)
- Hear landmark descriptions via text-to-speech (TTS integration ready)
- Accessible UI for visually impaired users

### Landmarks

- Historical and tourist landmarks information
- Detailed landmark descriptions
- Landmark search functionality
- Accessibility information

### Chat

- User-to-user messaging
- Chat history

### Hotels

- Best hotels in each city
- Price and rating comparisons

### Restaurants

- Top restaurants in each city
- Cuisine information

### Favorites

- Save favorite places, hotels, and restaurants
- View and manage your favorites in a dedicated Favorites page
- Favorites are stored locally using SharedPreferences

## Migration Notes

If you're migrating from the previous version of the app, note the following changes:

1. The file structure has been completely reorganized to follow Clean Architecture.
2. All state management has been migrated to use Cubit.
3. Dependency injection has been implemented using get_it.
4. All packages have been updated to their latest stable versions.
5. New features have been added, including Travel Time Estimation, Favorites List, Social Photo Sharing (Firebase), Places Filtering, Trip Suggestions, City Transportation Info, City Music, and Landmark Camera Search (Accessibility).

## Additional Manual Actions

After updating the codebase, you may need to:

1. Run `flutter clean` and then `flutter pub get` to ensure all dependencies are properly resolved.
2. Update Firebase configuration files (Firestore and Storage) if needed.
3. Test the app thoroughly on different devices to ensure compatibility.
4. Provide API keys for Google Maps, Google Places, and other external services.
5. Add sample data for landmarks, hotels, restaurants, and other features.

## Design System

The app uses a unified minimalist design system with the following principles:

- **Color Palette:** Navy (#223A5E) as primary, beige (#F5F5DC) as background, with white and navy for text and accents.
- **Typography:** All text uses the Roboto font for clarity and modern feel.
- **Rounded Corners:** All cards, buttons, and containers use rounded corners (16–20px) for a soft, modern look.
- **Consistent Padding:** Standard padding is `EdgeInsets.symmetric(horizontal: 24, vertical: 16)` for main content.
- **Reusable Widgets:**
  - Use `CustomButton` for all primary/secondary actions.
  - Use `CustomTextField` for all input fields.
- **Theme Usage:**
  - All colors, text styles, and shapes are defined in `theme.dart` and `constants/color.dart`.
  - Use `Theme.of(context)` for all styling in widgets and screens.

### Best Practices for Contributors

- Do not use hardcoded colors, fonts, or border radii. Always use the theme or constants.
- Use the provided custom widgets for buttons and text fields.
- When adding new screens, follow the layout and style patterns in existing feature pages.
- For new widgets, prefer composition and theming over inline styles.

See `lib/theme.dart` and `lib/constants/color.dart` for details.
