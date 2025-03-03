//
//  PostDetailContentView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct PostDetailContentView: View {
    let post: Post
    let user: User?
    let comments: [Comment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            PostContentView(post: post)
            
            if let user = user {
                UserInfoView(user: user)
            } else {
                Text("User information unavailable")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)
            }
            
            CommentsView(comments: comments)
        }
        .padding()
    }
}
