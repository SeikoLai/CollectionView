//
//  APIKey.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation

enum APIKey {
    // Fetch the API key from `CollectionView-Info.plist`
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "CollectionView-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'CollectionView-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'CollectionView-Info.plist'.")
        }
        if value.starts(with: "_") {
            fatalError(
                "Get API Key failure"
            )
        }
        return value
    }
}
