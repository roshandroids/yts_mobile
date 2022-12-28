# YTS Mobile

A simple mobile client app for browsing movies listed under [YTS website](https://yts.mx/).

## Content

- [App Architecture & Folder Structure](#app-architecture-and-folder-structure)

- [Plugins and Packages used](#plugins-and-packages-used)

- [Previews](#previews)

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
    - `models` folder contains all the data class model generated using [`Freezed`](https://pub.dev/packages/freezed) with support for parsing `json` to `dart object`, `copy-with` method, and more.
    - `repositories` folder contains the `abstract-class` and it's `implementation` which interact with `network calls` parses data and sends back to `domain` layer.

- The `presentation` folder also known as `presentation layer` which contains all the `UI` components.

##### Authentication :

- [firebase_auth: ^4.2.3](https://pub.dev/packages/firebase_auth)
- [google_sign_in: ^5.4.2](https://pub.dev/packages/google_sign_in)
- [flutter_facebook_login 3.0.0](https://pub.dev/packages/flutter_facebook_login)

###### HTTPs & Connectivity :

###### HTTPs & Connectivity :

- [dio: ^4.0.6](https://pub.dev/packages/dio)

###### State Management and Dependency Injection :

- [flutter_riverpod: ^2.1.1](https://pub.dev/packages/flutter_riverpod)

##### Navigation :

- [go_router: ^6.0.0](https://pub.dev/packages/go_router) -[url_strategy: ^0.2.0](https://pub.dev/packages/url_strategy)

##### Firebase :

- [firebase_core: ^2.4.0](https://pub.dev/packages/firebase_core)

##### Icons, Theme and animations :

- [lottie: ^2.1.0](https://pub.dev/packages/lottie)
- [flutter_vector_icons: ^2.0.0](https://pub.dev/packages/flutter_vector_icons)
- [flutter_svg: ^1.1.6](https://pub.dev/packages/flutter_svg)
- [flex_color_scheme: ^6.1.1](https://pub.dev/packages/flex_color_scheme)
- [flutter_launcher_icons: ^0.11.0](https://pub.dev/packages/flutter_launcher_icons)

###### Code generation and testing :

- [dartz: ^0.10.1](https://pub.dev/packages/dartz)
- [freezed_annotation: ^2.2.0](https://pub.dev/packages/freezed_annotation)
- [freezed: ^2.2.0](https://pub.dev/packages/freezed)
- [json_annotation: ^4.4.0](https://pub.dev/packages/json_annotation)
- [json_serializable: ^6.1.4](https://pub.dev/packages/json_serializable)
- [json_annotation: ^4.7.0](https://pub.dev/packages/json_annotation)
- [build_runner: ^2.3.0](https://pub.dev/packages/build_runner)
- [hive_test: ^1.0.1](https://pub.dev/packages/hive_test)
- [http_mock_adapter: ^0.3.3](https://pub.dev/packages/http_mock_adapter)
- [mocktail: ^0.3.0](https://pub.dev/packages/mocktail)
- [mocktail_image_network: ^0.3.1](https://pub.dev/packages/mocktail_image_network)
- [equatable: ^2.0.5](https://pub.dev/packages/equatable)

###### Local storage :

- [hive_flutter: ^1.1.0](https://pub.dev/packages/hive_flutter)

##### Others utilities :

- [url_launcher: ^6.1.7](https://pub.dev/packages/url_launcher)
- [stack_trace: ^1.10.0](https://pub.dev/packages/stack_trace)
- [shimmer: ^2.0.0](https://pub.dev/packages/shimmer)
- [pull_to_refresh: ^2.0.0](https://pub.dev/packages/pull_to_refresh)
- [flutter_keyboard_visibility: ^5.4.0](https://pub.dev/packages/flutter_keyboard_visibility)
- [another_flushbar: ^1.12.29](https://pub.dev/packages/another_flushbar)
- [clock: ^1.1.1](https://pub.dev/packages/clock)
- [cached_network_image: ^3.2.3](https://pub.dev/packages/cached_network_image)
- [very_good_analysis: ^3.1.0](https://pub.dev/packages/very_good_analysis)

## Previews

<table>
  <tr>
    <td>Light Mode</td>
     <td>Dark Mode</td>
</tr>
<tr>
    <td><img style="display: inline-block" src="https://user-images.githubusercontent.com/44658790/209639361-488728f2-fd52-4d74-a0af-7c8ab60affb6.png"/>
    </td>
    <td><img style="display: inline-block" src="https://user-images.githubusercontent.com/44658790/209639375-f294e78e-ccde-4d30-8a15-415ccf37463b.png"/>
    </td>
    </tr>
    <tr>
    <td><img style="display: inline-block" src ="https://user-images.githubusercontent.com/44658790/209639366-06fcdf78-c28a-4752-92a5-90fb13591549.png"/>
    </td>
    <td><img style="display: inline-block" src ="https://user-images.githubusercontent.com/44658790/209639383-307b85c3-2887-413c-b720-f73ac544b291.png"/>
    </td>
  </tr>
  <tr>
</td>
    <td><img style="display: inline-block" src ="https://user-images.githubusercontent.com/44658790/209640131-e5f09b74-6925-4c21-8e22-035aaddbccaf.gif" />
    <td><img style="display: inline-block" src ="https://user-images.githubusercontent.com/44658790/209639803-2599d420-c558-44f7-a94d-a41f072a38c7.gif" />
</td>
</tr>
</table>
