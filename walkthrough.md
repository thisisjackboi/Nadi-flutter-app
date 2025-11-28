# Flutter App Conversion Walkthrough

I have converted the React Native/Web app to a complete Flutter application located in `flutter_app/`.

## Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart                 # Entry point and State Management
│   ├── types.dart                # Data models and Enums
│   ├── constants.dart            # Mock data and Translations
│   ├── theme.dart                # App Theme and Colors
│   ├── widgets/                  # Reusable UI Components
│   │   ├── button.dart
│   │   ├── input.dart
│   │   ├── header.dart
│   │   ├── bottom_nav.dart
│   │   ├── politician_avatar.dart
│   │   └── marketing_card.dart
│   └── screens/                  # App Screens
│       ├── splash_screen.dart
│       ├── language_screen.dart
│       ├── login_screen.dart
│       ├── dashboard_screen.dart
│       ├── grievance_list_screen.dart
│       ├── grievance_detail_screen.dart
│       ├── submit_grievance_screen.dart
│       └── profile_screen.dart
├── assets/
│   ├── splash.png
│   └── politician.svg
└── pubspec.yaml                  # Dependencies
```

## How to Run

1.  **Navigate to the directory:**
    ```bash
    cd flutter_app
    ```

2.  **Get Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the App:**
    ```bash
    flutter run
    ```

## Features Ported

-   **Splash Screen**: Animated entry.
-   **Language Selection**: English and Assamese support.
-   **Login Flow**: Phone -> OTP -> Aadhaar verification simulation.
-   **Dashboard**:
    -   Politician Header with Gradient.
    -   Quick Actions Grid.
    -   Marketing Updates (Horizontal Scroll).
    -   Recent Grievances.
-   **Grievance Management**:
    -   View All Grievances.
    -   Grievance Details with Timeline.
    -   Submit New Grievance (Camera, Category, Location).
-   **Profile**: User details and Logout.

## Dependencies Used

-   `lucide_icons`: For consistent iconography matching the original design.
-   `google_fonts`: For the 'Outfit' font family.
-   `flutter_svg`: For rendering the Politician Avatar.
-   `provider`: (Included in pubspec but state is currently managed via `setState` in `main.dart` for simplicity, mirroring the React `App.tsx` structure).
