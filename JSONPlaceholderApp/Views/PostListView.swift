//
//  PostListView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostListViewModel
    var onRefresh: () async -> Void
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .notLoaded:
                    EmptyStateView(message: Strings.Common.noDataLoaded)
                    
                case .loading:
                    LoadingView(message: Strings.PostList.loadingPosts)
                    
                case .loaded(let posts):
                    if posts.isEmpty {
                        EmptyStateView(message: Strings.PostList.noPosts)
                    } else {
                        PostsListContentView(posts: posts)
                            .refreshable {
                                await onRefresh()
                            }
                    }
                    
                case .error(let message):
                    ErrorView(message: message) {
                        Task {
                            await onRefresh()
                        }
                    }
                }
            }
            .navigationTitle(Strings.PostList.navigationTitle)
        }
    }
}
