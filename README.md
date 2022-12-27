# YTS Mobile

Mobile client app for browsing movies listed under [YTS website](https://yts.mx/).

### Content

- [Previews](#previews)
- [App Architecture & Folder Structure](#app-architecture-and-folder-structure)

## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the UI, domain and data layers with a features-first approach for folder structure.

#### Folder Structure

```
lib
├── app
├── core
│   ├── animations
│   ├── app_state
│   ├── configs
│   ├── errors
│   ├── extensions
│   ├── models
│   ├── routes
│   ├── services
│   │   ├── http
│   │   └── storage
│   ├── theme
│   ├── utils
│   ├── widgets
│   │   └── loaders
├── features
│   ├── auth
│   │   ├── application
│   │   ├── infrastructure
│   │   │    ├── models
│   │   │    └── repositories
│   │   └── presentation
│   │       ├── pages
│   │       └── widgets
│   ├── movies
│   │   ├── application
│   │   ├── infrastructure
│   │   │    ├── models
│   │   │    └── repositories
│   │   └── presentation
│   │       ├── pages
│   │       └── widgets
├── firebase_options.dart
└── main.dart
```

- `main.dart` file has services initialization code and wraps the root `YtsApp` with a `ProviderScope`.

- `firebase_options.dart` is auto-generated file by `flutterfire CLI` which contains all the nessary configuration for `firebase`.
  integration.

- The `app` folder with `yts_app` has the root `MaterialApp` which injects the `theme data` and `navigation data` entire all the widget tree.

- The `core` folder contains code shared across features :

  - `animations` folder contains the code to animate the widgets.
  - `app_state` folder contains the model that represents the state of app during api call `i.e initial, loading, loaded, success, error`.
  - `configs` contains the configuration of app such as `base_url` for api call.
  - `constants` folder is where all the constant values used across the app such as `app_assets` with list of the path for `assets` are declared.
  - `errors` folder contains the model that parses `exceptions` and `dio_error` and returns `failure` object.
  - `extensions` folder contains all the extension methods such as `snackbar_extension ` that shows snackbar when called like `context.showSnackbar()`.
  - `models` folder contains the core models for `pagination` and `caching` the api response.
  - `routes` folders contains the list of `route_paths` and `go_router` navigation configurations.

  - `services` folder abstract app-level services with their implementations
    - `http` service is implemented with [`Dio`](https://pub.dev/packages/dio) and uses a `CacheInterceptor` to achieve caching by using the `StorageService`.
    - `storage` service is implemented with [`Hive`](https://pub.dev/packages/hive_flutter) \* Service locator pattern and Riverpod are used to abstract services when used in other layers.
  - `theme` folder contain general styles (colors, themes & text styles)
  - `utils`folder contain the helper methods such as `validators` for `forms`.
  - `widgets` folder contains all the `core-widgets` that are rendered in similar state across the app, such as `shimmer`, `error_view`, `buttons`, `text-fields`, `loading-indicators`, etc.

- The `features` folder: the repository pattern is used to decouple logic required to access data sources from the domain layer.

  - `application` folder also known as `domain layer` that contains all the business logic of the particular feature for example `latest_movie_provider` controls the `app state` from `loading` to `success` or `error` based on `API` response and sends it back to `UI` where the `listeners` and `builders` renders the components based on data provided.
  - `intrastructure` folder also known as `data layer`: The repository pattern is used to decouple logic required to access data sources from the domain layer.
    - `models` folder contains all the data class model generated using [`Freezed`](https://pub.dev/packages/freezed) with support for parsing `json` to `dart object`, `copy-with`, and more.
    - `repositories` folder contains the `abstract-class` and it's `implementation` which interact with `network calls` parses data and sends back to `domain` layer.

- The `presentation` folder also known as `presentation layer` which contains all the `UI` components.
