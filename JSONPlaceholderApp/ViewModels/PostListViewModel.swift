//
//  PostListViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation
import SwiftUI

@MainActor
class PostListViewModel: ObservableObject {
    @Published var state: PostListState = .notLoaded
    
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        Task {
            await loadInitialData()
        }
    }
    
    private func loadInitialData() async {
        // Only fetch if we haven't loaded data yet
        if case .notLoaded = state {
            await fetchPosts()
        }
    }
    
    func fetchPosts() async {
        state = .loading
        
        do {
            let posts = try await apiService.fetchPosts()
            state = .loaded(posts)
        } catch {
            state = .error("\(Strings.PostList.fetchError): \(error.localizedDescription)")
        }
    }
    
    func refresh() async {
        await fetchPosts()
    }
}
