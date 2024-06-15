//
//  PhotosService.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation
import Combine

protocol PhotosServiceProtocol {
    func fetchPhotos(page: Int) -> AnyPublisher<[Photo], Error>
}

// Service implementation
class PhotosService: PhotosServiceProtocol {
    func fetchPhotos(page: Int) -> AnyPublisher<[Photo], Error> {
        let task = HTTPTask.fetchPhotos(parameters: PhotoParameters(accessKey: APIKey.default, terms: "Tokyo", count: 20, perPage: 20))
        
        guard let request = task.request else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
