//
//  Bundle+Additions.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import Foundation

enum BundleError: LocalizedError {
    case invalidDirectory

    var errorDescription: String? {
        switch self {
        case .invalidDirectory:
            return "Invalid directory found when trying to open file."
        }
    }
}

extension Bundle {
    /**
     Synchronously reads a file from the specified filename
     and file extension.
     */
    func readCSV<T: ArrayInitializable>(
        from filename: String,
        fileExtension: String
    ) -> Result<[T], Error> {
        let url = url(forResource: filename, withExtension: fileExtension)
        guard let url else {
            return .failure(BundleError.invalidDirectory)
        }

        do {
            let file = try String(contentsOf: url, encoding: .utf8)
            let lines = file.components(separatedBy: .newlines)
            let values: [T] = try lines.compactMap {
                // Filter out empty strings.
                guard !$0.isEmpty else {
                    return nil
                }

                return try T($0.components(separatedBy: ","))
            }

            return .success(values)
        } catch let error {
            return .failure(error)
        }
    }
}
