//
//  TemperatureDisplayPresenterTests.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import XCTest
@testable import CosyHome

class TemperatureDisplayPresenterTests: XCTestCase {
    
    let displaySpy = TemperatureRangeDisplaySpy()
    var presenter: TemperaturePresenter!
    
    override func setUp() {
        super.setUp()
        presenter = TemperaturePresenter(display: displaySpy)
    }
    
    func testSetZeroTemperaturesUpdatesDisplay() {
        presenter.setTemperatures([])
        if let settings = displaySpy.settings {
            XCTAssertEqual(settings, [])
        } else {
            XCTFail()
        }
    }

    func testSetOneTemperatureUpdatesDisplay() {
        let setting = TemperatureSetting(temp: 0.0, minimum: 0.0, maximum: 0.0);
        presenter.setTemperatures([setting])
        if let setting = displaySpy.settings?.first {
            XCTAssertEqual(setting.temp, "0.0")
        } else {
            XCTFail()
        }
    }
    
    
}
