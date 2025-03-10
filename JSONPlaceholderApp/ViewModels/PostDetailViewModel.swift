//
//  PostDetailViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation
import SwiftUI

@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var state: PostDetailState = .notLoaded
    
    private var currentTask: Task<Void, Never>?
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchPostDetails(postId: Int) async {
        // Cancel any existing task
        currentTask?.cancel()
        
        // Create a new task
        currentTask = Task {
            state = .loading
            
            do {
                // Use async let to fetch all data concurrently
                async let postTask = apiService.fetchPost(id: postId)
                
                // First get the post to get the userId
                let post = try await postTask
                
                // Then fetch user and comments concurrently
                async let userTask = apiService.fetchUser(id: post.userId)
                async let commentsTask = apiService.fetchComments(postId: postId)
                
                // Wait for all concurrent tasks to complete
                let (user, comments) = try await (userTask, commentsTask)
                
                // Check if task was cancelled before updating state
                guard !Task.isCancelled else { return }
                
                // Update state with all fetched data
                state = .loaded(post: post, user: user, comments: comments)
            } catch {
                if !Task.isCancelled {
                    state = .error("\(Strings.PostDetail.fetchError): \(error.localizedDescription)")
                }
            }
        }
    }
}
