import UIKit
import XCTest
@testable import AutoAutoLayout

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidateHorizontalAttributes() {
        let view = UIView()
        XCTAssert(view.validateHorizontalAttributes(forStackViews: [UIView()], horizontalAttributes: [[]]))
        XCTAssertFalse(view.validateHorizontalAttributes(forStackViews: [UIView()], horizontalAttributes: []))
    }
    
    func testValidateHorizontalRelations() {
        let view = UIView()
        XCTAssert(view.validateHorizontalRelations(forStackViews: [UIView()], horizontalRelations: [[]]))
        XCTAssertFalse(view.validateHorizontalRelations(forStackViews: [UIView()], horizontalRelations: []))
    }
    
    func testValidateHorizontalPadding() {
        let view = UIView()
        XCTAssert(view.validateHorizontalPadding(forStackViews: [UIView()], horizontalPadding: [[]]))
        XCTAssertFalse(view.validateHorizontalPadding(forStackViews: [UIView()], horizontalPadding: []))
    }
    
    func testValidateViews() {
        let view = UIView()
        XCTAssert(view.validateViews(forAttributes: [.Top], views: [UIView()]))
        XCTAssertFalse(view.validateViews(forAttributes: [.Top], views: []))
    }
    

    
}

extension UIView {
    func abortWithMessage(message: String) {
        
    }
}
