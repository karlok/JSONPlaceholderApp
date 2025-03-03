//
//  CommentsView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct CommentsView: View {
    let comments: [Comment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.PostDetail.commentCount(comments.count))
                .font(.headline)
            
            if comments.isEmpty {
                Text(Strings.PostDetail.noComments)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(comments) { comment in
                    CommentRowView(comment: comment)
                }
            }
        }
    }
}
