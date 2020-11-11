import XCTest
@testable import Project

class NotebookVCextraMenu: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        let nav = app.navigationBars
        XCTAssertTrue(nav.buttons["navigationItem.leftBarButtonItem"].exists)
        nav.buttons["navigationItem.leftBarButtonItem"].tap()        
        app.sheets.scrollViews.otherElements.buttons["Очистить кэш"].tap()
    }
}
