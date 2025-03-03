//
//  PostsCoordinator.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation
import SwiftUI

/**
 - ContentView creates coordinator
 - Coordinator automatically loads initial data
 - PostListView calls refresh callback
 - Coordinator handles refresh
 - PostsListContentView uses coordinator to create detail view
 
 - Single Source of Truth: The coordinator manages the creation and configuration of view models, ensuring consistent state across the app
 - Dependency Injection: It provides a clean way to inject dependencies (like the APIService) into view models
 - Navigation Logic: It centralizes navigation logic and view model creation, making it easier to modify the app's flow
 
 Separation of concerns:
 - Views handle UI
 - ViewModels handle business logic
 - Coordinator handles navigation and dependency management
 */

@MainActor
class PostsCoordinator: ObservableObject {
    @Published var listViewModel: PostListViewModel
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.listViewModel = PostListViewModel(apiService: apiService)
        Task {
            await loadInitialData()
        }
    }
    
    func loadInitialData() async {
        await listViewModel.fetchPosts()
    }
    
    func refreshPosts() async {
        await listViewModel.fetchPosts()
    }
    
    func createDetailViewModel(for postId: Int) -> PostDetailViewModel {
        let viewModel = PostDetailViewModel(apiService: listViewModel.apiService)
        Task {
            await viewModel.fetchPostDetails(postId: postId)
        }
        return viewModel
    }
}

// Future enhancement: Could add deep linking support to Coordinator
//extension PostsCoordinator {
//    func handleDeepLink(_ link: DeepLink) {
//        switch link {
//        case .post(let id):
//            // Navigate to specific post
//        }
//    }
//}
