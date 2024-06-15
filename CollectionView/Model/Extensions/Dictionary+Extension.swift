//
//  Dictionary+Extension.swift
//  CollectionView
//
//  Created by Sam on 2024/6/15.
//

import Foundation

extension Dictionary where Key : StringProtocol, Value : StringProtocol {
    var queryString: String {
        self.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
