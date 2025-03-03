//
//  LoadingView.swift
//  JSONPlaceholderApp
//
//  Created by Karlo K on 2025-03-02.
//

import SwiftUI

struct LoadingView: View {
    let message: String
    
    var body: some View {
        ProgressView(message)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
