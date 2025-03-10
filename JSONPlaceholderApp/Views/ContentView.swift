//
//  ContentView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = PostsCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            PostListView(
                viewModel: coordinator.listViewModel,
                onRefresh: { await coordinator.refreshPosts() }
            )
            .navigationDestination(for: Int.self) { postId in
                PostDetailView(
                    postId: postId,
                    viewModel: coordinator.createDetailViewModel(for: postId)
                )
            }
        }
        .environmentObject(coordinator)
    }
}
