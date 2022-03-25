//
//  NetworkError.swift
//  imageApi
//
//  Created by Amir Bakhshi on 2022-03-25.
//

import Foundation

enum NetworkError: Error {
    case network(string: String)
    case jsonParsing(string: String)
    case unknown(string: String)
}
