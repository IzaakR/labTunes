//
//  NetworkTest.swift
//  labTunesTests
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import XCTest
@testable import labTunes

class NetworkTests: XCTestCase {
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    func testValidCallToItunes() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=Queen")
        var statusCode: Int?
        var responseError: Error?
        let primise = expectation(description: "handler invoked")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            primise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testSlowValidCallToItunes() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=Queen")
        let primise = expectation(description: "status code: 200")
        let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    primise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
