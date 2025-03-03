//
//  ViewState.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation

enum PostListState {
    case notLoaded
    case loading
    case loaded([Post])
    case error(String)
}

enum PostDetailState {
    case notLoaded
    case loading
    case loaded(post: Post, user: User?, comments: [Comment])
    case error(String)
}
