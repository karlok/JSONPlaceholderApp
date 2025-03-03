//
//  PostContentView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct PostContentView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(post.body)
                .font(.body)
                .padding(.top, 4)
        }
        .padding(.bottom, 8)
    }
}
