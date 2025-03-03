//
//  APIServiceProtocol.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
    func fetchPost(id: Int) async throws -> Post
    func fetchComments(postId: Int) async throws -> [Comment]
    func fetchUser(id: Int) async throws -> User
}

class APIService: APIServiceProtocol {
    private let networkManager = NetworkManager.shared
    
    func fetchPosts() async throws -> [Post] {
        try await networkManager.fetch(endpoint: "posts")
    }
    
    func fetchPost(id: Int) async throws -> Post {
        try await networkManager.fetch(endpoint: "posts/\(id)")
    }
    
    func fetchComments(postId: Int) async throws -> [Comment] {
        try await networkManager.fetch(endpoint: "posts/\(postId)/comments")
    }
    
    func fetchUser(id: Int) async throws -> User {
        try await networkManager.fetch(endpoint: "users/\(id)")
    }
}
