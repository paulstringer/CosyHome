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
    
    let displaySpy = TemperatureSettingsDisplaySpy()
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
        
        let setting = TemperatureSetting();
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "0")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(temperature: 30.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "30")
        } else {
            XCTFail()
        }
    }
    
    
    func testSetDecimalTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(temperature: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    
    
    func testSetLowestMinimumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting();
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.minimum, "0")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestMinimumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(minimum: 30.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.minimum, "30")
        } else {
            XCTFail()
        }
    }
    
    func testSetLowestMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting();
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.maximum, "0")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMinimumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(minimum: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.minimum, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(maximum: 30.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.maximum, "30")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMaximumTemperatureSettingConvertsToString() {
        
        let setting = TemperatureSetting(maximum: 25.5);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.maximum, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalTemperatureSettingRoundsUpToSingleDecimalPlaceString() {
    
        let setting = TemperatureSetting(temperature: 25.46);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testSetDecimalsAllSettingValuesRoundsUpToSingleDecimalPlaceString() {
        
        let setting = TemperatureSetting(temperature: 25.45, minimum: 25.46, maximum: 25.46);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "25.5")
            XCTAssertEqual(setting.maximum, "25.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testSetDecimalsAllSettingZeroDecimals() {
        
        let setting = TemperatureSetting(temperature: 22.0, minimum: 23.0, maximum: 24.0);
        
        presenter.temperatures = [setting]
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "22")
            XCTAssertEqual(setting.minimum, "23")
            XCTAssertEqual(setting.maximum, "24")
        } else {
            XCTFail()
        }
        
    }
    
    func testComfySetting() {
        
        let comfy = TemperatureSetting(type: .Comfy, temperature: 25.45, minimum: 25.46, maximum: 25.46)
        
        presenter.temperatures = [comfy]
        
        if let setting = displaySpy.comfy {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "25.5")
            XCTAssertEqual(setting.maximum, "25.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testCosySetting() {
        
        let comfy = TemperatureSetting(type: .Cosy, temperature: 25.45, minimum: 25.46, maximum: 25.46)
        
        presenter.temperatures = [comfy]
        
        if let setting = displaySpy.cosy {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "25.5")
            XCTAssertEqual(setting.maximum, "25.5")
        } else {
            XCTFail()
        }
        
    }
    
    
}
