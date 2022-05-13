//
//  UITableViewCellExtensionsTests.swift
//  InBooksTests
//
//  Created by Matheus Lenke on 13/05/22.
//

import XCTest
@testable import InBooks

class UITableViewCellExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClassIdentifierMethod_WhenUITableViewCell_ShouldReturnIdentifier() throws {
            let identifier = UITableViewCell.classIdentifier()
            let bookCellIdentifier = BookTableViewCell.classIdentifier()
            
            XCTAssertEqual(identifier, "UITableViewCell")
            XCTAssertEqual(bookCellIdentifier, "BookTableViewCell")
    }

}
