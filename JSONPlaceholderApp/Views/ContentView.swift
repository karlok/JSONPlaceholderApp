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
        PostListView(
            viewModel: coordinator.listViewModel,
            onRefresh: { await coordinator.refreshPosts() }
        )
        .environmentObject(coordinator)
    }
}
