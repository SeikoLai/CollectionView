//
//  HTTPTask.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation

public typealias HTTPHeaders = [String: String]?

public enum HTTPTask: Endpoint {
    case fetchPhotos(parameters: PhotoParameters)
}

// MARK: - HTTP METHOD
extension HTTPTask {
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchPhotos: return .get
        }
    }
}

// MARK: - BASE URL
extension HTTPTask {
    var baseURL: URL? {
        switch self {
        case .fetchPhotos: URL(string: "https://api.unsplash.com")
        }
    }
}
// MARK: - PATH
extension HTTPTask {
    var path: String {
        switch self {
        case .fetchPhotos: return "/photos/random"
        }
    }
}
// MARK: - HTTP HEADERS
extension HTTPTask {
    var headers: HTTPHeaders {
        switch self {
        case .fetchPhotos:
            return [:]
        }
    }
}
// MARK: PARAMETERS
extension HTTPTask {
    var parameters: [String: Any]? {
        switch self {
        case .fetchPhotos: return nil
        }
    }
}
// MARK: URL REQUEST
extension HTTPTask {
    var request: URLRequest? {
        switch self {
        case .fetchPhotos(let parameters):
            guard var url = URL(string: path, relativeTo: baseURL) else { return nil }
            url.append(queryItems: parameters.queryItems)
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
