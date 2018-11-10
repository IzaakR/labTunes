//
//  labTunesTests.swift
//  labTunesTests
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import XCTest
@testable import labTunes

class labTunesTests: XCTestCase {

    override func setUp() {
        let session = Session.shareInstance
        session.token = nil
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCorrectLogin() {
        XCTAssertTrue(User.login(userName: "iOSLab", password: "verysecurepasword"))
       
    }
    
    func testWrongLogin() {
         XCTAssertFalse(User.login(userName: "Raul", password: ""))
    }
    
    
    func testSaveSession() {
        let session = Session.shareInstance
        let _ = User.login(userName: "iOSLab", password: "verysecurepasword")
        XCTAssertNotNil(session.token)
    }
    
    func testFailSaveSession() {
        let session = Session.shareInstance
        let _ = User.login(userName: "iOSLdab", password: "verysecurepasword")
        XCTAssertNil(session.token)
    }
    
    func testExpectedToken() {
        let _ = User.login(userName: "iOSLab", password: "234")
        let session = Session.shareInstance
        XCTAssertEqual(session.token, "1234567890", "Token should match")
        
    }
    
    func testFailExpectedToken() {
        let _ = User.login(userName: "iOSLab", password: "234")
        let session = Session.shareInstance
        XCTAssertNotEqual(session.token, "123234", "Token not match")
    }
    
    func testThrowsError() {
        XCTAssertThrowsError(try User.fetchSongs())
    }

    
    func testMusicSongs() {
        var resultsSongs: [Song] = []
        let promise = expectation(description: "Songs Downloaded")
        Music.fetchSongs { (songs) in
            resultsSongs = songs
            promise.fulfill()
        }
       waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotEqual(resultsSongs.count, 0)
    }
}
