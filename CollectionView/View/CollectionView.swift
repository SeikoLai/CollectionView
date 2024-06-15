//
//  CollectionView.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        RectangleCollectionView(viewModel: viewModel)
    }
}

#if DEBUG
struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(viewModel: PhotosViewModel())
    }
}
#endif
