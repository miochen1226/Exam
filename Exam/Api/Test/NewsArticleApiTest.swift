//
//  NewsArticleApiTest.swift
//  ExamTests
//
//  Created by mio on 2023/10/4.
//

import XCTest
@testable import Exam

class NewsArticleApiTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        //try await testFetchArticles()
    }

    
    //Test fetch article via api
    func testFetchArticles() async throws {
        let expectation = XCTestExpectation(description: "Download article asynchronously.")
        NewsArticleApi().fetchArticles() { (data, error) in
            // Update the model with new data
            XCTAssertNil(error, "Expected no errors downloading article.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
