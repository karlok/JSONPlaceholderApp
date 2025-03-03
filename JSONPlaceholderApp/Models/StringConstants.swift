//
//  Strings.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-03.
//

enum Strings {
    enum Common {
        static let tryAgain = "Try Again"
        static let loading = "Loading..."
        static let noDataLoaded = "No data loaded yet"
        static let unavailable = "unavailable"
    }
    
    enum PostList {
        static let navigationTitle = "Posts"
        static let loadingPosts = "Loading posts..."
        static let noPosts = "No posts available"
        static let fetchError = "Failed to fetch posts"
    }
    
    enum PostDetail {
        static let navigationTitle = "Post Details"
        static let loadingDetails = "Loading details..."
        static let author = "Author"
        static let userUnavailable = "User information unavailable"
        static let comments = "Comments"
        static let noComments = "No comments available"
        static func commentCount(_ count: Int) -> String {
            "Comments (\(count))"
        }
        static let fetchError = "Failed to fetch post details"
    }
}
