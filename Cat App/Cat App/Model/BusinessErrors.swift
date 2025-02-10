//
//  BusinessErrors.swift
//  Cat App
//
//  Created by Miguel Castellanos on 4/02/25.
//

import Foundation

// Network error types
enum NetworkError: Error {
    case invalidURL(String)
    case httpResponseError(String)
}
// DataSource error types
enum DataSourceError: Error {
    case parsingDataError(String)
    case noData(String)
}

extension Error {
    var localizedDescription: String {
        return String(describing: self)
    }
}
