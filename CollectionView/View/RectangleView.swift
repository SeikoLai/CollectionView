//
//  RectangleView.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import SwiftUI

struct RectangleView: View {
    @StateObject private var photoDownloader = PhotoDownloader()
    private let url: URL
    private let width: CGFloat
    
    init(url: URL, width: CGFloat) {
        self.url = url
        self.width = width
    }
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .aspectRatio(0.75, contentMode: .fit)
            .frame(width: width)
            .overlay {
                Group {
                    if let image = photoDownloader.image {
                        image
                            .resizable()
                            .clipped()
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear {
                photoDownloader.load(url: url)
            }
            .onDisappear {
                photoDownloader.cancel()
            }
    }
}
