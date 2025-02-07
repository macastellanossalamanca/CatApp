//
//  Cat_AppTests.swift
//  Cat AppTests
//
//  Created by Miguel Castellanos on 3/02/25.
//

import XCTest
@testable import Cat_App

class FetchBreedsTests: XCTestCase {
    var sut: NetworkDataManager!
    var mockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession(configuration: .default)
        sut = NetworkDataManager(session: mockURLSession)
    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func testFetchBreeds_Success() {
        let mockData = "[{\"id\":\"1\",\"name\":\"samplecat\",\"weight\":{\"imperial\":\"10-15\",\"metric\":\"4-7\"},\"temperament\":\"Friendly\",\"origin\":\"UK\",\"country_codes\":\"UK\",\"country_code\":\"UK\",\"description\":\"A friendly breed\",\"life_span\":\"10-12\",\"indoor\":1,\"lap\":1,\"adaptability\":5,\"affection_level\":5,\"child_friendly\":4,\"dog_friendly\":3,\"energy_level\":4,\"grooming\":2,\"health_issues\":1,\"intelligence\":4,\"shedding_level\":3,\"social_needs\":4,\"stranger_friendly\":3,\"vocalisation\":2,\"experimental\":0,\"hairless\":0,\"natural\":1,\"rare\":0,\"rex\":0,\"suppressed_tail\":0,\"short_legs\":0,\"hypoallergenic\":0}]".data(using: .utf8)!
        mockURLSession.mockData = mockData
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://apimock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Success response")
        
        sut.fetchBreeds(page: "1") { result in
            switch result {
            case .success(let breeds):
                XCTAssertEqual(breeds.count, 1)
                XCTAssertEqual(breeds.first?.name, "samplecat")
                XCTAssertEqual(breeds.first?.weight.metric, "4-7")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchBreeds_Failure_InvalidData() {
        mockURLSession.mockData = "invalid json".data(using: .utf8)!
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://apimock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Failure response due to invalid data")
        
        sut.fetchBreeds(page: "1") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertTrue(error is DataSourceError)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchBreeds_Failure_HTTPError() {
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://apimock.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Failure response due to HTTP error")
        
        sut.fetchBreeds(page: "1") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertTrue(error is NetworkError)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}

class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    init(configuration: URLSessionConfiguration = .default) {
        super.init()
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}
