## Real-Time Forex Trading App
A Flutter-based real-time Forex trading application that allows users to view live forex prices, track multiple currency pairs, visualize historical data with interactive charts, and handle network connectivity seamlessly.

## Features
- Real-time Forex Data: Fetch live forex prices for selected currency pairs using the Finnhub API.
- Multiple Currency Pairs: View live data for multiple forex pairs at once.
- Historical Data: Visualize historical price data with interactive charts.
- Network Connectivity Detection: Automatically detects when the device is offline or online.
- Offline Support: Cached data for when the user is offline or facing connectivity issues.
- Error Handling: Handles API failures, slow network responses, and other edge cases.
- Real-Time Data Updates: Data updates every 5 seconds using HTTP polling.

## Setup and Installation
  - Prerequisites
     Flutter (version 3.0+)
     Dart SDK (version 2.15+)
     Finnhub API Key for fetching live forex data



## Install dependencies
  - flutter pub get
## Configure Environment Variables
    Create a .env file in the root directory of the project and add your Finnhub API Key:
        FINNHUB_API_KEY=your_api_key_here
You can use the flutter_dotenv package to load environment variables.

## Running the App
    To run the app on an emulator or connected device:
        flutter run 
## API Integration
    The app integrates with the Finnhub API to fetch live forex prices and historical data.

## API Endpoints:
    Live Forex Prices: https://finnhub.io/api/v1/forex?symbol=SYMBOLS
    Historical Data: The app fetches historical data for selected currency pairs using the API.

## Architecture Overview

    This app follows Clean Architecture principles, ensuring maintainability, scalability, and testability. The app is divided into layers that handle different concerns and responsibilities. Here's an overview of each layer:

        1. Presentation Layer
            This layer contains the UI components, including screens and widgets. It directly interacts with the BLoC (Business Logic Component) to update the UI based on state changes.
            Screens: The app includes screens like MarketsScreen and HistoryScreen, where users can view live forex prices and historical data.
        2. Business Logic Layer (BLoC)
            The BLoC manages the state and business logic of the application. It receives events (e.g., fetch live forex data, handle network changes) and emits new states (e.g., data loaded, error occurred).
            The ForexBloc class is responsible for handling the events related to fetching live forex data and historical data.
        3. Data Layer
            The Repository handles data fetching, caching, and processing. It abstracts the data sources and provides the necessary data to the BLoC.
            ForexRepository is responsible for interacting with external data sources (Finnhub API) and providing data to the BLoC.
            Data Models: The app uses models like ForexPrice to represent the forex price data.
        4. Network Layer
            This layer is responsible for making HTTP requests to fetch forex data from the Finnhub API and handling network connectivity.
            NetworkCubit listens for changes in network status (online/offline) and updates the UI accordingly.
            Caching: Data is cached locally to ensure that users can view the latest available data even when they are offline.
        5. Utils Layer
            Env variables: API key and other configurations are managed through .env using the flutter_dotenv package.
   
## Data Flow Overview:
    User Interactions: A user interacts with the UI (e.g., selecting a currency pair).
    Event Trigger: The event is sent to the BLoC (e.g., fetch data for the selected pair).
    BLoC: The BLoC handles the event by calling methods in the ForexRepository to fetch data from the API.
    Repository: The Repository handles the logic of making an HTTP request to the Finnhub API, processes the response, and returns the data.
    State Update: The BLoC updates the state (success/failure), which is then reflected in the UI.



## Testing
    To run unit and widget tests:
    flutter test

## Test Coverage:
    UI Tests: Validates user interactions, such as button presses, network status updates, and data display.
    Data Handling Tests: Ensures that API responses are parsed correctly, and errors are handled appropriately.
    Edge Case Tests: Simulates offline, slow network, and API failures.

## Development
    Code Structure
        lib/core: Contains core classes like network monitoring (NetworkCubit) and error handling.
        lib/repository: Contains the forex data fetching logic from the Finnhub API.
        lib/screens: Contains the Markets Screen and History Screen.
        lib/bloc: Contains state management logic using the BLoC pattern.

## Key Libraries
    flutter_bloc: For managing the app's state using the BLoC pattern.
    connectivity_plus: For detecting network connectivity changes.
    charts_flutter: For rendering interactive charts to display historical forex data.
    http: For making network requests to fetch forex data(Not used websockets as paid Api key was not available )

## Folder Structure:

lib/
├── core/
│   ├── network/
│   │   ├── network_cubit.dart
│   │   └── network_state.dart
│   ├── utils/
│   └── widgets/
├── repository/
│   └── forex_repository.dart
├── models/
│   └── forex_price.dart
├── screens/
│   ├── markets_screen.dart
│   └── history_screen.dart
├── bloc/
│   ├── forex_bloc.dart
│   └── forex_event.dart
└── main.dart



## Acknowledgments
    Finnhub API: For providing live forex data.
    Flutter & Dart: For being the backbone of this app.
    flutter_bloc: For managing the state of the app using the BLoC pattern.
    charts_flutter: For rendering interactive charts to visualize forex data.
    connectivity_plus: For managing network connectivity state in the app.
