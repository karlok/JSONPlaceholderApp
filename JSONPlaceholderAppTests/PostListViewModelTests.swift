//
//  PostListViewModelTests.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import XCTest
@testable import JSONPlaceholderApp

@MainActor
class PostListViewModelTests: XCTestCase {
    
    var mockAPIService: MockAPIService!
    var viewModel: PostListViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        // Disable auto-loading in tests
        viewModel = PostListViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        mockAPIService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Verify the initial state is .notLoaded
        if case .notLoaded = viewModel.state {
            // Success
        } else {
            XCTFail("Initial state should be .notLoaded")
        }
    }
    
    func testFetchPostsSuccess() async {
        // Arrange
        let mockPosts = [
            Post(id: 1, userId: 1, title: "Test Post 1", body: "Test Body 1"),
            Post(id: 2, userId: 1, title: "Test Post 2", body: "Test Body 2")
        ]
        mockAPIService.posts = mockPosts
        mockAPIService.shouldSucceed = true
        
        // Act
        await viewModel.fetchPosts()
        
        // Assert
        if case .loaded(let posts) = viewModel.state {
            XCTAssertEqual(posts.count, 2)
            XCTAssertEqual(posts[0].id, 1)
            XCTAssertEqual(posts[1].id, 2)
        } else {
            XCTFail("State should be .loaded with posts")
        }
    }
    
    func testFetchPostsEmpty() async {
        // Arrange
        mockAPIService.posts = []
        mockAPIService.shouldSucceed = true
        
        // Act
        await viewModel.fetchPosts()
        
        // Assert
        if case .loaded(let posts) = viewModel.state {
            XCTAssertTrue(posts.isEmpty)
        } else {
            XCTFail("State should be .loaded with empty posts array")
        }
    }
    
    func testFetchPostsFailure() async {
        // Arrange
        mockAPIService.shouldSucceed = false
        mockAPIService.error = NetworkError.invalidResponse
        
        // Act
        await viewModel.fetchPosts()
        
        // Assert
        if case .error(let message) = viewModel.state {
            XCTAssertTrue(message.contains("Failed to fetch posts"))
        } else {
            XCTFail("State should be .error")
        }
    }
    
    func testLoadingState() async {
        // Create a delayed mock to test loading state
        let expectation = XCTestExpectation(description: "Loading state shown")
        
        // Create a custom mock that delays the response
        class DelayedMockAPIService: APIServiceProtocol {
            func fetchPosts() async throws -> [Post] {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                return [Post(id: 1, userId: 1, title: "Test", body: "Test")]
            }
            
            func fetchPost(id: Int) async throws -> Post {
                fatalError("Not implemented")
            }
            
            func fetchComments(postId: Int) async throws -> [Comment] {
                fatalError("Not implemented")
            }
            
            func fetchUser(id: Int) async throws -> User {
                fatalError("Not implemented")
            }
        }
        
        // Create view model with delayed service
        let delayedViewModel = PostListViewModel(apiService: DelayedMockAPIService())
        
        // Start a background task to check for loading state
        Task {
            // Act
            Task {
                await delayedViewModel.fetchPosts()
            }
            
            // Wait a bit for the loading state to be set
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
            
            // Assert
            if case .loading = delayedViewModel.state {
                expectation.fulfill()
            } else {
                XCTFail("State should be .loading")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testRefresh() async {
        // Arrange
        let initialPosts = [Post(id: 1, userId: 1, title: "Initial", body: "Initial")]
        let refreshedPosts = [Post(id: 2, userId: 2, title: "Refreshed", body: "Refreshed")]
        
        mockAPIService.posts = initialPosts
        mockAPIService.shouldSucceed = true
        
        // Act - Initial fetch
        await viewModel.fetchPosts()
        
        // Verify initial state
        if case .loaded(let posts) = viewModel.state {
            XCTAssertEqual(posts[0].title, "Initial")
        } else {
            XCTFail("State should be .loaded with initial posts")
        }
        
        // Update mock for refresh
        mockAPIService.posts = refreshedPosts
        
        // Act - Refresh
        await viewModel.refresh()
        
        // Assert
        if case .loaded(let posts) = viewModel.state {
            XCTAssertEqual(posts[0].title, "Refreshed")
        } else {
            XCTFail("State should be .loaded with refreshed posts")
        }
    }
}
