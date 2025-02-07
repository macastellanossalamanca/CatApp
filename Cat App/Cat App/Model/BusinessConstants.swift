//
//  BusinessConstants.swift
//  Cat App
//
//  Created by Miguel Castellanos on 4/02/25.
//

import Foundation

enum BusinessConstants: String {
    
    //MARK: Network
    case breedsAPIUrl = "https://api.thecatapi.com/v1/breeds"
    case imageAPIUrl = "https://cdn2.thecatapi.com/images/"
    case defaultImageId = "https://cdn2.thecatapi.com/images/EPF2ejNS0.jpg"
    case pageParameterName = "page"
    case limitParameterName = "limit" 
    case pageItemsLimit = "10"
    
    //MARK: Error Handling
    case urlErrorMessage = "The URL used is not valid."
    case httpResponseError = "The response from the requests throws back an error"
    case parsingDataError = "There was a problem parsing the data to the business model"
    case noData = "There was no data in the request response"
}
