//
//  CommentRowView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct CommentRowView: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(comment.name)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text(comment.email)
                .font(.caption)
                .foregroundColor(.blue)
            
            Text(comment.body)
                .font(.body)
                .padding(.top, 2)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.vertical, 4)
    }
}
