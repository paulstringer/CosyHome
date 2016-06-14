import XCTest
@testable import CosyHome

class TemperaturePresenterTests: XCTestCase {
    
    let displaySpy = TemperatureGroupViewSpy()
    var presenter: TemperaturePresenter!
    
    override func setUp() {
        super.setUp()
        presenter = TemperaturePresenter(view: displaySpy)
    }
    
    func testSetZeroTemperatures() {
        
        presenter.temperatureGroup = nil
        
        XCTAssertNil(displaySpy.low)
        XCTAssertNil(displaySpy.middle)
        XCTAssertNil(displaySpy.high)
    }

    func testSetZeroTemperatureSettingConvertsToString() {
        
        presenter.temperatureGroup = TemperatureGroupEntity()
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.temp, "14")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestTemperatureSettingConvertsToString() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low: 14, middle: 18, high: 21)
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.temp, "14")
        } else {
            XCTFail()
        }
    }
    
    
    func testSetDecimalTemperatureSettingConvertsToString() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low: 25.5, middle: 26.5, high: 27.5);
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testMaximumTemperatureSettingConvertsToString() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low:20, middle:29, high:30);
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.maximum, 28)
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMaximumTemperatureSettingConvertsToString() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low: 25.5, middle: 28, high: 29);
        
        if let setting = displaySpy.middle {
            XCTAssertEqual(setting.minimum, 26.5)
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalTemperatureSettingRoundsUpToSingleDecimalPlaceString() {
    
        presenter.temperatureGroup = TemperatureGroupEntity(low: 14.46, middle: 19, high: 29);
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.temp, "14.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testComfySetting() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low:14, middle: 18, high: 30)
        
        if let setting = displaySpy.middle {
            XCTAssertEqual(setting.temp, "18")
            XCTAssertEqual(setting.minimum, 15)
            XCTAssertEqual(setting.maximum, 29)
        } else {
            XCTFail()
        }
        
    }
    
    func testCosySetting() {
        
        presenter.temperatureGroup = TemperatureGroupEntity(low: 14, middle: 18, high: 25.45)
        
        if let setting = displaySpy.high {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, 19)
            XCTAssertEqual(setting.maximum, 30)
        } else {
            XCTFail()
        }
        
    }
    
    func testSettingNames() {
        
        presenter.temperatureGroup = TemperatureGroupEntity()
        
        if let setting = displaySpy.high {
            XCTAssertEqual(setting.name, "COSY")
        } else {
            XCTFail()
        }
        
        if let setting = displaySpy.middle {
            XCTAssertEqual(setting.name, "COMFY")
        } else {
            XCTFail()
        }
        
        if let setting = displaySpy.low {
            XCTAssertEqual(setting.name, "SLUMBER")
        } else {
            XCTFail()
        }
        
    }
    
    
}
