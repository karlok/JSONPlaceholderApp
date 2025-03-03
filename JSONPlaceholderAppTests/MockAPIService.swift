//
//  MockAPIService.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation
@testable import JSONPlaceholderApp

class MockAPIService: APIServiceProtocol {
    // Control test behavior with these properties
    var shouldSucceed = true
    var posts: [Post] = []
    var post: Post?
    var user: User?
    var comments: [Comment] = []
    var error: Error = NetworkError.invalidData
    
    func fetchPosts() async throws -> [Post] {
        if shouldSucceed {
            return posts
        } else {
            throw error
        }
    }
    
    func fetchPost(id: Int) async throws -> Post {
        if shouldSucceed, let post = post {
            return post
        } else {
            throw error
        }
    }
    
    func fetchComments(postId: Int) async throws -> [Comment] {
        if shouldSucceed {
            return comments
        } else {
            throw error
        }
    }
    
    func fetchUser(id: Int) async throws -> User {
        if shouldSucceed, let user = user {
            return user
        } else {
            throw error
        }
    }
}
