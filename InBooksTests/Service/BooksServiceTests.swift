//
//  BooksServiceTests.swift
//  InBooksTests
//
//  Created by Matheus Lenke on 13/05/22.
//

import XCTest
@testable import InBooks

class BooksServiceTests: XCTestCase {
    
    private var sut: BooksService!
    private var networkClientMock: NetworkClientMock!

    override func setUp()  {
        networkClientMock = NetworkClientMock()
        sut = BooksService(networkClient: networkClientMock)
    }

    override func tearDown() {
        sut = nil
        networkClientMock = nil
    }
    
    func testBooksServiceFetchBooksMethod_WhenJsonDecoded_ShoutBeNotNil() {
        let expectations = self.expectation(description: "WhenJSONDecoded_ShouldBeNotNil")
        var result: ApiSearchBooksResponse? = nil
        
        sut.fetchSearchBooksBy(title: "Test") { response in
            switch response {
            case .success(let apiResult):
                result = apiResult
                expectations.fulfill()
            case .failure:
                result = nil
            }
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertNotNil(result, "Fails because result is nil")
    }
    
    func testBooksServiceFetchBooksMethod_WhenJSONDecoded_ShouldHaveCorrectInformations() {
        let expectations = self.expectation(description: "WhenJSONDecoded_ShouldHaveCorrectInformations")
        var result: ApiSearchBooksResponse? = nil
        
        sut.fetchSearchBooksBy(title: "Test") { response in
            switch response {
            case .success(let apiResult):
                result = apiResult
                expectations.fulfill()
            case .failure:
                result = nil
            }
        }
        waitForExpectations(timeout: 3.0)
        XCTAssertNotNil(result?.books)
        
        if let books = result?.books {
            let book = books[0]
            XCTAssertEqual(book.titulo, "Titulo", "the received name property fails becuase is not equal to json payload.")
            XCTAssertEqual(book.subtitulo, "Subtitulo", "the received name property fails becuase is not equal to json payload.")
            XCTAssertEqual(book.isbn, "9788573794427", "the received name property fails becuase is not equal to json payload.")
        }
    }

}
