//
//  Photo.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation

struct Photo: Codable {
    let id: String
    let urls: Urls

    struct Urls: Codable {
        let small: String
    }
}

public struct PhotoParameters {
    var accessKey: String
    var terms: String
    var count: Int
    var perPage: Int
    
    private var info: [String: String] {
        return ["client_id": accessKey,
                "query": terms,
                "count": String(count),
                "per_page": String(perPage)]
    }
}

extension PhotoParameters {
    var queryItems: [URLQueryItem] {
        return self.info.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
