//
//  PhotoDownloader.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import SwiftUI
import Combine

class PhotoDownloader: ObservableObject {
    @Published var image: Image? = nil
    
    private var cancellable: AnyCancellable?
    private let cache = URLCache.shared
    
    func load(url: URL) {
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)),
           let uiImage = UIImage(data: cachedResponse.data) {
            self.image = Image(uiImage: uiImage)
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response -> Image? in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    self.cache.storeCachedResponse(cachedData, for: URLRequest(url: url))
                }
                return Image(uiImage: UIImage(data: data)!)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

