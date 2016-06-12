//
//  TemperatureDisplayPresenterTests.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import XCTest
@testable import CosyHome

class TemperaturePresenterTests: XCTestCase {
    
    let displaySpy = TemperatureGroupViewSpy()
    var presenter: TemperaturePresenter!
    
    override func setUp() {
        super.setUp()
        presenter = TemperaturePresenter(display: displaySpy)
    }
    
    func testSetZeroTemperatures() {
        
        presenter.temperatures = []
        
        XCTAssertNil(displaySpy.comfy)
        XCTAssertNil(displaySpy.cosy)
        XCTAssertNil(displaySpy.slumber)
    }

    func testSetZeroTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity();
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "7")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity(temperature: 30.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "30")
        } else {
            XCTFail()
        }
    }
    
    
    func testSetDecimalTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity(temperature: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity();
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.maximum, "30")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMinimumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity(temperature: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity(temperature: 30.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "30")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureGroupItemEntity(temperature: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalTemperatureSettingRoundsUpToSingleDecimalPlaceString() {
    
        let setting = TemperatureGroupItemEntity(temperature: 25.46);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testComfySetting() {
        
        let comfy = TemperatureGroupItemEntity(type: .Comfy, temperature: 25.45)
        
        presenter.temperatures = [comfy]
        
        if let setting = displaySpy.comfy {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "7")
            XCTAssertEqual(setting.maximum, "30")
        } else {
            XCTFail()
        }
        
    }
    
    func testCosySetting() {
        
        let comfy = TemperatureGroupItemEntity(type: .Cosy, temperature: 25.45)
        
        presenter.temperatures = [comfy]
        
        if let setting = displaySpy.cosy {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "7")
            XCTAssertEqual(setting.maximum, "30")
        } else {
            XCTFail()
        }
        
    }
    
    
}
