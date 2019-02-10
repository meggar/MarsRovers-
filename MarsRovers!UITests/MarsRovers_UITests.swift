//
//  MarsRovers_UITests.swift
//  MarsRovers!UITests
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest

class MarsRover_UITests: XCTestCase {

    // The expected values in theses tests come from files in folder "DataSources/FakeDataFiles"
    
    override func setUp() {
        continueAfterFailure = false
    }

    private func testApplication() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("fakeCoreData")
        app.launchArguments.append("fakeAPI")
        app.launch()
        return app
    }
    
    
    /*
     Tap the first row in the table.
     verify that there are min/max values in the labels to the left and right of the slider.
     verify that the label above the slider inits to "Sol Date: \(x)", where x is the min slider value.
     tap the increment button, the label above the slider should increment to next sol date.
     tap the decrement button, the label should revert to original value.
     tap the decrement button, the label should not change.
     slide the slider all the way to the right.
     tap the decrement button, the label above the slider should decrement to previous sol date.
     tap the increment button, the label should revert to original value.
     tap the increment button, the label should not change.
    */
    func testSliderAdjustingButtons() {
        
        let app = testApplication()

        let table = app.tables[AccessibilityIdentifier.roverSelectorTable.rawValue]
        let selectedDate = app.staticTexts[AccessibilityIdentifier.roverSelectorSelectedDate.rawValue]
        let increment = app.buttons[AccessibilityIdentifier.roverSelectorIncrementDate.rawValue]
        let decrement = app.buttons[AccessibilityIdentifier.roverSelectorDecrementDate.rawValue]
        let slider = app.sliders[AccessibilityIdentifier.roverSelectorSlider.rawValue]
        let min = app.staticTexts[AccessibilityIdentifier.roverSelectorMinSliderLabel.rawValue]
        let max = app.staticTexts[AccessibilityIdentifier.roverSelectorMaxSliderLabel.rawValue]
        
        [table,
         selectedDate,
         increment,
         decrement,
         slider,
         min,
         max].forEach{ element in XCTAssertTrue(element.exists) }
        
        // select the first row in the table
        table.cells.element(boundBy: 0).tap()
        
        // wait until there is data in the labels
        verify(element: min, hasText: "label != ''")
        verify(element: max, hasText: "label != ''")
        
        // verify labels
        verify(element: selectedDate, hasText: "label == 'Sol Date: 0'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
        
        // increment once, verify labels
        increment.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 1'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")

        // decrement once, verify labels
        decrement.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 0'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
        
        // decrementing when slider is all the way left should have no effect.
        decrement.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 0'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
        
        
        
        // move the slider all the way to the right
        slider.adjust(toNormalizedSliderPosition: 1.0)
        
        verify(element: selectedDate, hasText: "label == 'Sol Date: 12'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
        
        // decrement once, verify labels
        decrement.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 10'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
        
        // increment once, verify labels
        increment.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 12'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")

        // incrementing when slider is all the way right should have no effect.
        increment.tap()
        verify(element: selectedDate, hasText: "label == 'Sol Date: 12'")
        verify(element: min, hasText: "label == '0'")
        verify(element: max, hasText: "label == '12'")
    }
    
    
    /*
     tap the first row in the table.
     tap the showImages button.
     this should push a CollectionViewController onto the stack.
     verify that the navBar now has a new title (a rover name)
     tap the left nav button to go back to the rover selector screen.
     verify that the navBar now has the original title (Mars Rovers)
    */
    func testShowImagesButton() {
        
        let app = testApplication()
        
        let table = app.tables[AccessibilityIdentifier.roverSelectorTable.rawValue]
        let min = app.staticTexts[AccessibilityIdentifier.roverSelectorMinSliderLabel.rawValue]
        let showImages = app.buttons[AccessibilityIdentifier.RoverSelectorShowImagesButton.rawValue]
        
        [table,
         min,
         showImages,
         table.cells.staticTexts["Curiosity"]].forEach{ element in XCTAssertTrue(element.exists) }

        
        // initial state: nav title should be Mars Rovers
        XCTAssertTrue(app.navigationBars["Mars Rovers"].exists)
        XCTAssertFalse(app.navigationBars["Curiosity"].exists)
        
        // tap the "Curiosity" cell in the table
        table.cells.staticTexts["Curiosity"].tap()
        
        // wait until there is data in the labels
        verify(element: min, hasText: "label != ''")
        
        // tap button to transition to Curiosity ViewController
        showImages.tap()
        
        // nav title should be Curiosity
        XCTAssertTrue(app.navigationBars["Curiosity"].exists)
        XCTAssertFalse(app.navigationBars["Mars Rovers"].exists)
        
        let curiosityNavigationBar = app.navigationBars["Curiosity"]
        
        // tap back button (if exists) to return to Mars Rovers view
        XCTAssertTrue(curiosityNavigationBar.buttons["Mars Rovers"].exists)
        curiosityNavigationBar.buttons["Mars Rovers"].tap()
        
        // nav title should be Mars Rovers
        XCTAssertTrue(app.navigationBars["Mars Rovers"].exists)
        XCTAssertFalse(app.navigationBars["Curiosity"].exists)
    }
    
    /*
     tap the Favorites button, navBar-left.
     this should push a CollectionViewController onto the stack.
     verify that the navBar now has a new title (Favorite Images)
     tap the left nav button to go back to the rover selector screen.
     verify that the navBar now has the original title (Mars Rovers)
     */
    func testShowFavoritesButton() {
        
        let app = testApplication()
        
        let showFavorites = app.buttons[AccessibilityIdentifier.RoverSelectorFavoritesButton.rawValue]
        
        [showFavorites].forEach{ element in XCTAssertTrue(element.exists) }
        
        
        // initial state: nav title should be Mars Rovers
        XCTAssertTrue(app.navigationBars["Mars Rovers"].exists)
        XCTAssertFalse(app.navigationBars["Favorite Images"].exists)
        
        // tap the Favorites button, navBar-left
        showFavorites.tap()

        
        // nav title should be Favorite Images
        XCTAssertTrue(app.navigationBars["Favorite Images"].exists)
        XCTAssertFalse(app.navigationBars["Mars Rovers"].exists)
        
        // tap back button (if exists) to return to Mars Rovers view
        app.navigationBars["Favorite Images"].buttons.element(boundBy: 0).tap()
        
        // nav title should be Mars Rovers
        XCTAssertTrue(app.navigationBars["Mars Rovers"].exists)
        XCTAssertFalse(app.navigationBars["Favorite Images"].exists)
    }
    
    /*
     tap the Favorites button, navBar-left.
     this should push a CollectionViewController onto the stack.
     verify that the navBar now has a right barItem "Slide Show"
     tap the "Slide Show" nav button
     verify that slideShowViewController is now on screen
     tap the screen
     verify that it returns to the "Favorite Images" collectionView
     */
    func testFavoritesSlideShow() {
        
        let app = testApplication()
        
        let showFavorites = app.buttons[AccessibilityIdentifier.RoverSelectorFavoritesButton.rawValue]
        let slideShowImageView = app.otherElements[AccessibilityIdentifier.FavoritesSlideShowView.rawValue]
        
        [showFavorites].forEach{ element in XCTAssertTrue(element.exists) }
        
        
        // initial state: nav title should be Mars Rovers
        XCTAssertTrue(app.navigationBars["Mars Rovers"].exists)
        XCTAssertFalse(app.navigationBars["Favorite Images"].exists)
        
        // tap the Favorites button, navBar-left
        showFavorites.tap()
        
        // nav title should be Favorite Images
        XCTAssertTrue(app.navigationBars["Favorite Images"].exists)
        XCTAssertFalse(app.navigationBars["Mars Rovers"].exists)
        
        // nav bar should have a "Slide Show" right barItem
        XCTAssertTrue(app.navigationBars["Favorite Images"].buttons["SlideShow"].exists)
        app.navigationBars["Favorite Images"].buttons["SlideShow"].tap()
        
        // slideShow should now be on screen
        verify(element: slideShowImageView)
        XCTAssertFalse(app.navigationBars["Favorite Images"].exists)
        
        // tapping dismisses the slideShow
        slideShowImageView.tap()
        XCTAssertTrue(app.navigationBars["Favorite Images"].exists)
    }
}
