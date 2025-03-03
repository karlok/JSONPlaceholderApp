//
//  Comment.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
