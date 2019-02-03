//
//  MarsRovers_FastlaneUITests.swift
//  MarsRovers!FastlaneUITests
//
//  Created by Mike Eggar on 2/3/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest

class MarsRovers_FastlaneUITests: XCTestCase {


    override func setUp() {
        
        continueAfterFailure = true
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTakeScreenshots() {
        
        
        let app = XCUIApplication()
        
        XCUIApplication().tables["roverSelectorTable"]/*@START_MENU_TOKEN@*/.staticTexts["Curiosity"]/*[[".cells.staticTexts[\"Curiosity\"]",".staticTexts[\"Curiosity\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        snapshot("01launch")
        
        let marsRoversNavigationBar = app.navigationBars["Mars Rovers"]
        marsRoversNavigationBar/*@START_MENU_TOKEN@*/.buttons["🖤"].tap()/*[[".buttons[\"🖤\"]",".tap()",".press(forDuration: 0.7);",".buttons[\"RoverSelectorFavoritesButton\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[1,1]]@END_MENU_TOKEN@*/
        
        
        let collectionViewsQuery = app.collectionViews
        waitForElementToAppear(collectionViewsQuery.children(matching: .cell).element(boundBy: 14))
        
        snapshot("02Grid")
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 14).otherElements.containing(.staticText, identifier:"2016-04-11 - MAST").element.tap()
        
        snapshot("03Detail")
        
        marsRoversNavigationBar.buttons["Zoom"].tap()
        
        snapshot("04zoom")
        
        app.buttons["🚀"].tap()
        
        // back to detail
        
        let favoriteImagesButton = marsRoversNavigationBar.buttons["Favorite Images"]
        favoriteImagesButton.tap()
        
        // back to grid
        
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"2019-01-25 - MAHLI").element.tap()
        favoriteImagesButton.tap()
        
    }

}
