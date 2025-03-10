//
//  PostsListContentView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct PostsListContentView: View {
    let posts: [Post]
    @EnvironmentObject private var coordinator: PostsCoordinator
    
    var body: some View {
        List(posts) { post in
            Button {
                coordinator.navigateToPostDetail(postId: post.id)
            } label: {
                PostRowView(post: post)
            }
        }
        .listStyle(PlainListStyle())
    }
}
