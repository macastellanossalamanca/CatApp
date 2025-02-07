//
//  Factory.swift
//  Cat App
//
//  Created by Miguel Castellanos on 7/02/25.
//

class Factory {
    static func makeViewModel() -> BreedViewModel {
        let dataManager = NetworkDataManager()
        let viewModel = BreedViewModel(dataManager: dataManager)
        return viewModel
    }
}
