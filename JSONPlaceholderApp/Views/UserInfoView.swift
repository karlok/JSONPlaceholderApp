//
//  UserInfoView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct UserInfoView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.PostDetail.author)
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(user.email)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(.bottom, 8)
    }
}
