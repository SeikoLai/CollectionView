//
//  Endpoint.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURL: URL? { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}
