//
//  PostDetailView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct PostDetailView: View {
    let postId: Int
    @ObservedObject var viewModel: PostDetailViewModel
    
    var body: some View {
        ScrollView {
            Group {
                switch viewModel.state {
                case .notLoaded:
                    EmptyStateView(message: Strings.Common.noDataLoaded)
                    
                case .loading:
                    LoadingView(message: Strings.PostDetail.loadingDetails)
                    
                case .loaded(let post, let user, let comments):
                    PostDetailContentView(
                        post: post,
                        user: user,
                        comments: comments
                    )
                    
                case .error(let message):
                    ErrorView(message: message) {
                        Task {
                            await viewModel.fetchPostDetails(postId: postId)
                        }
                    }
                }
            }
        }
        .navigationTitle(Strings.PostDetail.navigationTitle)
    }
}
