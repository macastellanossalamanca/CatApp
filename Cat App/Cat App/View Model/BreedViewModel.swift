//
//  CatViewModel.swift
//  Cat App
//
//  Created by Miguel Castellanos on 4/02/25.
//

import Foundation

class BreedViewModel: ObservableObject {
    @Published var breeds = [BreedModel]()
    var pageNumber = 0
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        loadPage()
    }
    
    func loadPage() {
        breeds = [BreedModel]()
        dataManager.fetchBreeds(page: String(pageNumber)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.breeds = data
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
        }
    }
}
