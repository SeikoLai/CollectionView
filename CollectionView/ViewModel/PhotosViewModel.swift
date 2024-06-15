//
//  PhotosViewModel.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation
import Combine

class PhotosViewModel: ObservableObject {
    @Published var imageUrls: [URL] = []
    @Published var isLoading = false
    private var currentPage = 1
    private var cancellable = Set<AnyCancellable>()
    private let photosService: PhotosServiceProtocol

    // Dependency injection for better testability
    init(photosService: PhotosServiceProtocol = PhotosService()) {
        self.photosService = photosService
        fetchNextPage()
    }

    func fetchNextPage() {
        guard !isLoading else { return }

        isLoading = true
        photosService.fetchPhotos(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching image URLs: \(error)")
                }
            }, receiveValue: { [weak self] newPhotos in
                let urls = newPhotos.compactMap { URL(string: $0.urls.small) }
                self?.imageUrls.append(contentsOf: urls)
                self?.currentPage += 1
            })
            .store(in: &cancellable)
    }
}
