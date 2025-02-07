//
//  Cat_AppUITests.swift
//  Cat AppUITests
//
//  Created by Miguel Castellanos on 3/02/25.
//

import XCTest
import SwiftUI
@testable import Cat_App

final class ContentViewTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testSearchBarFiltersResults() {
        // Arrange: Find the search bar
        let searchField = app.searchFields["Filter by breed name"]
        XCTAssertTrue(searchField.exists)
        
        // Act: Type a breed name
        searchField.tap()
        searchField.typeText("Aegean")
        
        // Assert: Check if "Maine Coon" appears in the filtered results
        let filteredResult = app.staticTexts["Aegean"]
        XCTAssertTrue(filteredResult.waitForExistence(timeout: 2))
    }
    
    func testBreedGridDisplayed() {
        // Act: Tap the first breed in the list
        let firstBreed = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstBreed.exists)
        firstBreed.tap()
        
        // Assert: Check if the detail view appeared
        let gridView = app.otherElements["Grid of Breeds"]
        XCTAssertTrue(gridView.waitForExistence(timeout: 5))
    }
    
    func testPaginationButtons() {
        let nextButton = app.buttons[">> Next"]
        let prevButton = app.buttons["Previous <<"]
        
        // Assert: Ensure "Next" button exists
        XCTAssertTrue(nextButton.exists)
        
        // Act: Tap "Next" and verify page changes
        nextButton.tap()
        let pageNumberLabel = app.staticTexts["Page 2"]
        XCTAssertTrue(pageNumberLabel.waitForExistence(timeout: 2))
        
        // Assert: Ensure "Previous" button exists after navigating
        XCTAssertTrue(prevButton.exists)
        prevButton.tap()
        let pageOneLabel = app.staticTexts["Page 1"]
        XCTAssertTrue(pageOneLabel.waitForExistence(timeout: 2))
    }
    
    func testPaginationButtonsAndSearchResult() {
        let nextButton = app.buttons[">> Next"]
        let prevButton = app.buttons["Previous <<"]
        
        // Assert: Ensure "Next" button exists
        XCTAssertTrue(nextButton.exists)
        
        // Act: Tap "Next" and verify page changes
        nextButton.tap()
        let pageNumberLabel = app.staticTexts["Page 2"]
        XCTAssertTrue(pageNumberLabel.waitForExistence(timeout: 2))
        
        // Assert: Ensure "Previous" button exists after navigating
        XCTAssertTrue(prevButton.exists)
        prevButton.tap()
        let pageOneLabel = app.staticTexts["Page 1"]
        XCTAssertTrue(pageOneLabel.waitForExistence(timeout: 2))
        
        let searchField = app.searchFields["Filter by breed name"]
        XCTAssertTrue(searchField.exists)
        
        // Act: Type a breed name
        searchField.tap()
        searchField.typeText("Aegean")
        
        // Assert: Check if "Maine Coon" appears in the filtered results
        let filteredResult = app.staticTexts["Aegean"]
        XCTAssertTrue(filteredResult.waitForExistence(timeout: 2))
    }
    
    func testSearchBarFiltersResultsInNextPages() {
        // Arrange: Find the search bar and next button
        let searchField = app.searchFields["Filter by breed name"]
        let nextButton = app.buttons[">> Next"]
        XCTAssertTrue(searchField.exists)
        
        // Assert: Ensure "Next" button exists
        XCTAssertTrue(nextButton.exists)
        
        // Act: Tap "Next" and verify page changes
        nextButton.tap()
        
        // Act: Type a breed name
        searchField.tap()
        searchField.typeText("Burmese")
        
        let filteredResult = app.staticTexts["Burmese"]
        XCTAssertTrue(filteredResult.waitForExistence(timeout: 2))
    }
}
