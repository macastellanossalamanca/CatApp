//
//  NetworkDataManager.swift
//  Cat App
//
//  Created by Miguel Castellanos on 4/02/25.
//

import Foundation

struct NetworkDataManager: DataManagerProtocol {
    
    var session = URLSession.shared
    
    func fetchBreeds(page: String, completion: @escaping (Result<[BreedModel], Error>) -> Void) {
        var urlBuilder = URLComponents(string: BusinessConstants.breedsAPIUrl.rawValue)
        urlBuilder?.queryItems = [
            URLQueryItem(name: BusinessConstants.pageParameterName.rawValue, value: page),
            URLQueryItem(name: BusinessConstants.limitParameterName.rawValue, value: BusinessConstants.pageItemsLimit.rawValue)
        ]
        
        guard let safeUrl = urlBuilder?.url else {
            completion(.failure(NetworkError.invalidURL(BusinessConstants.urlErrorMessage.rawValue)))
            return
        }
        
        let task = session.dataTask(with: safeUrl) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.httpResponseError(BusinessConstants.httpResponseError.rawValue)))
                return
            }
            guard let data else {
                completion(.failure(DataSourceError.noData(BusinessConstants.noData.rawValue)))
                return
            }
            if let error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let initialInfo = try decoder.decode([BreedModel].self, from: data)
                completion(.success(initialInfo))
            } catch {
                completion(.failure(DataSourceError.parsingDataError(BusinessConstants.parsingDataError.rawValue)))
            }
        }
        task.resume()
    }
}

protocol DataManagerProtocol {
    func fetchBreeds(page: String, completion: @escaping (Result<[BreedModel], Error>) -> Void)
}
