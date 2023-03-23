//
//  ArrayInitializable.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import Foundation

protocol ArrayInitializable {
    init(_ array: [Any]) throws
}

enum ArrayInitializationError: LocalizedError {
    case invalidArrayLength
    case invalidFormat(String)

    var errorDescription: String? {
        switch self {
        case .invalidArrayLength:
            return "Invalid length of array."
        case .invalidFormat(let description):
            return "Data provided in the incorrect format: \(description)"
        }
    }
}
