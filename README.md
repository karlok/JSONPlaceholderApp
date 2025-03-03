# JSONPlaceholder SwiftUI MVVM-C Example

A demonstration of clean architecture in iOS using SwiftUI, following the MVVM-C (Model-View-ViewModel-Coordinator) pattern. This project showcases best practices for building scalable, maintainable iOS applications while consuming a REST API.

## 🌟 Features

- Fetches and displays posts from [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- Clean MVVM-C architecture implementation
- Async/await for network calls
- Unit tests for ViewModels
- String management via Enums
- SwiftUI for UI
- Dependency injection pattern
- Error handling and loading states

## 🏗 Architecture

This project is a prime example of the MVVM-C pattern, with:

### Clean Architecture
- Clear separation of concerns
- Each component has a single responsibility
- Easy to understand and maintain
- Follows SOLID principles

### Testability
- ViewModels are easily testable
- Dependencies are injected
- States are clearly defined
- Comprehensive unit test coverage

### Scalability
- Easy to add new features
- Easy to modify existing features
- Clear pattern to follow for new developers

### SwiftUI Integration
- Works well with SwiftUI's declarative nature
- Maintains MVVM-C pattern while leveraging SwiftUI features
- Handles async operations cleanly

## 🧱 Project Structure

```plaintext
├── JSONPlaceholderApp
│   ├── Coordinators
│   │   └── PostsCoordinator.swift
│   ├── JSONPlaceholderApp.swift
│   ├── Models
│   │   ├── Comment.swift
│   │   ├── Post.swift
│   │   ├── StringConstants.swift
│   │   └── User.swift
│   ├── Services
│   │   ├── APIService.swift
│   │   ├── NetworkError.swift
│   │   └── NetworkManager.swift
│   ├── ViewModels
│   │   ├── PostDetailViewModel.swift
│   │   ├── PostListViewModel.swift
│   │   └── ViewState.swift
│   └── Views
│       ├── CommentRowView.swift
│       ├── CommentsView.swift
│       ├── ContentView.swift
│       ├── EmptyStateView.swift
│       ├── ErrorView.swift
│       ├── LoadingView.swift
│       ├── PostContentView.swift
│       ├── PostDetailContentView.swift
│       ├── PostDetailView.swift
│       ├── PostListView.swift
│       ├── PostRowView.swift
│       ├── PostsListContentView.swift
│       └── UserInfoView.swift
```

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0+
- iOS 15.0+
- Swift 5.5+

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/JSONPlaceholderSwiftUI.git
```
2. Open `JSONPlaceholderApp.xcodeproj` in Xcode
3. Build and run the project

## 🧪 Running the Tests

The project includes unit tests for the ViewModels and Coordinator. To run the tests:

1. Open the project in Xcode
2. Press `⌘ + U` or navigate to Product > Test

## 📖 Key Concepts Demonstrated

### State Management
```swift
enum PostListState {
    case notLoaded
    case loading
    case loaded([Post])
    case error(String)
}
```

### Dependency Injection
```swift
protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

class PostListViewModel {
    init(apiService: APIServiceProtocol)
}
```

### Coordinator Pattern
```swift
class PostsCoordinator: ObservableObject {
    func createDetailViewModel(for postId: Int) -> PostDetailViewModel {
        let viewModel = PostDetailViewModel(apiService: listViewModel.apiService)
        Task {
            await viewModel.fetchPostDetails(postId: postId)
        }
        return viewModel
    }
}
```

## 🛠 Technologies Used

- SwiftUI
- async/await for asynchronous operations
- XCTest for unit testing

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## 👏 Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for providing the free API
- Apple's SwiftUI documentation
- The Swift and SwiftUI community for inspiration and best practices

## 📫 Contact

LinkedIn: [https://www.linkedin.com/in/karlokilayko/](https://www.linkedin.com/in/karlokilayko/)

Project Link: [https://github.com/karlok/JSONPlaceholderSwiftUI](https://github.com/karlok/JSONPlaceholderSwiftUI)

---

⭐️ If you found this project helpful, please give it a star on GitHub!

![iOS](https://img.shields.io/badge/iOS-15.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.5%2B-orange)
![License](https://img.shields.io/badge/license-MIT-green)