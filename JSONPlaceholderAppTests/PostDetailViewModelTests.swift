//
//  PostDetailViewModelTests.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import XCTest
@testable import JSONPlaceholderApp

@MainActor
class PostDetailViewModelTests: XCTestCase {
    
    var mockAPIService: MockAPIService!
    var viewModel: PostDetailViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = PostDetailViewModel(apiService: mockAPIService)
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
    
    func testFetchPostDetailsSuccess() async {
        // Arrange
        let mockPost = Post(id: 1, userId: 1, title: "Test Post", body: "Test Body")
        let mockUser = User(
            id: 1,
            name: "Test User",
            username: "testuser",
            email: "test@example.com",
            address: Address(
                street: "Test Street",
                suite: "Suite 1",
                city: "Test City",
                zipcode: "12345",
                geo: Geo(lat: "0", lng: "0")
            ),
            phone: "123-456-7890",
            website: "example.com",
            company: Company(
                name: "Test Company",
                catchPhrase: "Test Catch Phrase",
                bs: "Test BS"
            )
        )
        let mockComments = [
            Comment(id: 1, postId: 1, name: "Comment 1", email: "comment1@example.com", body: "Comment Body 1"),
            Comment(id: 2, postId: 1, name: "Comment 2", email: "comment2@example.com", body: "Comment Body 2")
        ]
        
        mockAPIService.post = mockPost
        mockAPIService.user = mockUser
        mockAPIService.comments = mockComments
        mockAPIService.shouldSucceed = true
        
        // Act
        await viewModel.fetchPostDetails(postId: 1)
        
        // Assert
        if case .loaded(let post, let user, let comments) = viewModel.state {
            XCTAssertEqual(post.id, 1)
            XCTAssertEqual(post.title, "Test Post")
            
            XCTAssertNotNil(user)
            XCTAssertEqual(user?.id, 1)
            XCTAssertEqual(user?.name, "Test User")
            
            XCTAssertEqual(comments.count, 2)
            XCTAssertEqual(comments[0].id, 1)
            XCTAssertEqual(comments[1].id, 2)
        } else {
            XCTFail("State should be .loaded with post, user, and comments")
        }
    }
    
    func testFetchPostDetailsPostFailure() async {
        // Arrange
        mockAPIService.shouldSucceed = false
        mockAPIService.error = NetworkError.invalidResponse
        
        // Act
        await viewModel.fetchPostDetails(postId: 1)
        
        // Assert
        if case .error(let message) = viewModel.state {
            XCTAssertTrue(message.contains("Failed to fetch post details"))
        } else {
            XCTFail("State should be .error")
        }
    }
    
    func testFetchPostDetailsUserAndCommentsFailure() async {
        // Arrange - Post succeeds but user and comments fail
        let mockPost = Post(id: 1, userId: 1, title: "Test Post", body: "Test Body")
        
        // Custom mock that succeeds for post but fails for user and comments
        class PartialFailureMockAPIService: APIServiceProtocol {
            let post: Post
            
            init(post: Post) {
                self.post = post
            }
            
            func fetchPosts() async throws -> [Post] {
                fatalError("Not implemented")
            }
            
            func fetchPost(id: Int) async throws -> Post {
                return post
            }
            
            func fetchComments(postId: Int) async throws -> [Comment] {
                throw NetworkError.invalidResponse
            }
            
            func fetchUser(id: Int) async throws -> User {
                throw NetworkError.invalidResponse
            }
        }
        
        let partialFailureViewModel = PostDetailViewModel(apiService: PartialFailureMockAPIService(post: mockPost))
        
        // Act
        await partialFailureViewModel.fetchPostDetails(postId: 1)
        
        // Assert - Should still have post but no user or comments
        if case .loaded(let post, let user, let comments) = partialFailureViewModel.state {
            XCTAssertEqual(post.id, 1)
            XCTAssertEqual(post.title, "Test Post")
            
            XCTAssertNil(user)
            XCTAssertTrue(comments.isEmpty)
        } else {
            XCTFail("State should be .loaded with post but no user or comments")
        }
    }
    
    func testLoadingState() async {
        // Create a delayed mock to test loading state
        let expectation = XCTestExpectation(description: "Loading state shown")
        
        // Create a custom mock that delays the response
        class DelayedMockAPIService: APIServiceProtocol {
            func fetchPosts() async throws -> [Post] {
                fatalError("Not implemented")
            }
            
            func fetchPost(id: Int) async throws -> Post {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                return Post(id: 1, userId: 1, title: "Test", body: "Test")
            }
            
            func fetchComments(postId: Int) async throws -> [Comment] {
                return []
            }
            
            func fetchUser(id: Int) async throws -> User {
                fatalError("Not implemented")
            }
        }
        
        // Create view model with delayed service
        let delayedViewModel = PostDetailViewModel(apiService: DelayedMockAPIService())
        
        // Start a background task to check for loading state
        Task {
            // Act
            Task {
                await delayedViewModel.fetchPostDetails(postId: 1)
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
}
