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
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchPostDetails(postId: Int) async {
        state = .loading
        
        do {
            let fetchedPost = try await apiService.fetchPost(id: postId)
            
            // Fetch user and comments in parallel
            async let userTask = apiService.fetchUser(id: fetchedPost.userId)
            async let commentsTask = apiService.fetchComments(postId: postId)
            
            do {
                let (user, comments) = try await (userTask, commentsTask)
                state = .loaded(post: fetchedPost, user: user, comments: comments)
            } catch {
                // If we at least have the post, show it with the error for other data
                state = .loaded(post: fetchedPost, user: nil, comments: [])
            }
        } catch {
            state = .error("\(Strings.PostDetail.fetchError): \(error.localizedDescription)")
        }
    }
}
