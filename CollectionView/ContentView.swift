//
//  ContentView.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: PhotosViewModel = PhotosViewModel()
    
    var body: some View {
        VStack {
            CollectionView(viewModel: viewModel)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
