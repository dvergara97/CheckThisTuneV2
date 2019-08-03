//
//  TunerModelTests.swift
//  CheckThisTuneV2Tests
//
//  Created by Daniel Vergara on 8/1/19.
//  Copyright © 2019 Daniel Vergara. All rights reserved.
//

import XCTest

@testable import CheckThisTuneV2

class TunerModelTests: XCTestCase, ObserverProtocol {

    var id = "TunerModelTests";
    private var output : Any?;
    
    override func setUp() {
        output = nil;
        
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
        model.addObserver(observer: self);
        model.setNote(newFrequency: 220.0 - 0.01);
        if let message = (output as? TunerMessage) {
            XCTAssertEqual(message.getCurrentFrequencyNote(), "A");
        }
    }
    
    func testPutFrequencyInRangeToHigh() {
        let model = TunerModel();
        model.addObserver(observer: self);
        model.setNote(newFrequency: 440.0 + 0.01);
        if let message = (output as? TunerMessage) {
            XCTAssertEqual(message.getCurrentFrequencyNote(), "A");
        }
    }
    
    func testPutFrequencyInRangeOnLow() {
        let model = TunerModel();
        model.addObserver(observer: self);
        model.setNote(newFrequency: 220.0);
        if let message = (output as? TunerMessage) {
            XCTAssertEqual(message.getCurrentFrequencyNote(), "A");
        }
    }
    
    func testPutFrequencyInRangeOnHigh() {
        let model = TunerModel();
        model.addObserver(observer: self);
        model.setNote(newFrequency: 440.0);
        if let message = (output as? TunerMessage) {
            XCTAssertEqual(message.getCurrentFrequencyNote(), "A");
        }
    }
    
    func onChanged(value: Any?) {
        output = value;
    }

}
