//
//  RectangleCollectionView.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import SwiftUI

struct RectangleCollectionView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    
    /// This property mainly save the large rectangle height to move those small rectangle location
    @State private var largePhotoHeight: CGFloat = 0
    
    var body: some View {
        // GeometryReader mainly to get the whole screen size
        GeometryReader { proxy in
            let size = proxy.size.width / 3.0
            ScrollView {
                // Use `LazyVGrid` to improve performance
                LazyVGrid(columns: columns, spacing: .zero) {
                    photoList(urls: viewModel.imageUrls, size: size) {
                        debugPrint("Load more")
                        viewModel.fetchNextPage()
                    }
                }
            }
        }
    }
    // MARK: - PHOTO LIST
    private func photoList(urls: [URL], size: CGFloat, loadMoreHandler: (() -> Void)? = nil) -> some View {
        ForEach(urls.indices, id: \.self) { index in
            Group {
                let url = urls[index]
                if index == 3 {
                    // Specified index to calculating the large rectangle height avoid duplicate calculate.
                    largePhotoProxy(url: url, width: size * 2, idealHeight: $largePhotoHeight)
                } else if index%3 == 0 && index%2 != 0 {
                    // The large rectangle at left side in even rows
                    largePhoto(url: url, width: size * 2)
                } else if index%6 == 4 {
                    // The small rectangle at top right side in even rows
                    evenRowTopRightPhoto(url: url, width: size, offsetX: size, offsetY: largePhotoHeight)
                } else if index%6 == 5 {
                    // The small rectangle at bottom right side in even rows
                    evenRowBottomRightPhoto(url: url, width: size, offsetY: largePhotoHeight)
                } else {
                    RectangleView(url: url, width: size)
                }
            }
            .onAppear {
                if index == urls.count - 1 {
                    loadMoreHandler?()
                }
            }
        }
    }
    // MARK: - LARGE PHOTO
    private func largePhoto(url: URL, width: CGFloat) -> some View {
        RectangleView(url: url, width: width)
            .offset(x: width * 0.25)
    }
    // MARK: - LARGE PHOTO CALCULATE PROXY
    private func largePhotoProxy(url: URL, width: CGFloat, idealHeight: Binding<CGFloat>) -> some View {
        largePhoto(url: url, width: width)
            .background(
                // This GeometryReader mainly to get the large rectangle height to move those small rectangles' location
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            guard idealHeight.wrappedValue == 0 else { return }
                            idealHeight.wrappedValue = proxy.size.height
                        }
                }
            )
    }
    // MARK: - EVEN ROW BOTTOM RIGHT PHOTO
    private func evenRowBottomRightPhoto(url: URL, width: CGFloat, offsetY: CGFloat) -> some View {
        RectangleView(url: url, width: width)
            .offset(y: offsetY * 0.25)
    }
    // MARK: - EVEN ROW TOP RIGHT PHOTO
    private func evenRowTopRightPhoto(url: URL, width: CGFloat, offsetX: CGFloat, offsetY: CGFloat) -> some View {
        RectangleView(url: url, width: width)
            .offset(x: offsetX, y: -(offsetY * 0.25))
    }
}

#if DEBUG
struct RectangleCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCollectionView(viewModel: PhotosViewModel())
    }
}
#endif
