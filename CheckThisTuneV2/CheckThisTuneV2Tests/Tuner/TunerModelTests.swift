//
//  TunerModelTests.swift
//  CheckThisTuneV2Tests
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import XCTest

@testable import CheckThisTuneV2

class TunerModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPutFrequencyInRangeToLow() {
        let model = TunerModel();
        model.setNote(newFrequency: 220.0 - 0.01);
        XCTAssertTrue(220.0 < model.getCurrentFrequency());
        XCTAssertTrue(440.0 > model.getCurrentFrequency());
    }
    
    func testPutFrequencyInRangeToHigh() {
        let model = TunerModel();
        model.setNote(newFrequency: 440.0 + 0.01);
        XCTAssertTrue(220.0 < model.getCurrentFrequency());
        XCTAssertTrue(440.0 > model.getCurrentFrequency());
    }
    
    func testPutFrequencyInRangeOnLow() {
        let model = TunerModel();
        model.setNote(newFrequency: 220.0);
        XCTAssertEqual(model.getCurrentFrequency(), 220.0, accuracy: 0.000000001);
    }
    
    func testPutFrequencyInRangeOnHigh() {
        let model = TunerModel();
        model.setNote(newFrequency: 440.0);
        XCTAssertEqual(model.getCurrentFrequency(), 440.0, accuracy: 0.000000001);
    }

}
