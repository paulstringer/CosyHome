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
        
        presenter.temperatures = nil
        
        XCTAssertNil(displaySpy.comfy)
        XCTAssertNil(displaySpy.cosy)
        XCTAssertNil(displaySpy.slumber)
    }

    func testSetZeroTemperatureSettingConvertsToString() {
        
        presenter.temperatures = TemperatureGroupEntity()
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "14")
        } else {
            XCTFail()
        }
    }
    
    func testSetHighestTemperatureSettingConvertsToString() {
        
        presenter.temperatures = TemperatureGroupEntity(slumber: 14, comfy: 18, cosy: 21)
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "14")
        } else {
            XCTFail()
        }
    }
    
    
    func testSetDecimalTemperatureSettingConvertsToString() {
        
        presenter.temperatures = TemperatureGroupEntity(slumber: 25.5, comfy: 26.5, cosy: 27.5);
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "25.5")
        } else {
            XCTFail()
        }
    }
    
    func testMaximumTemperatureSettingConvertsToString() {
        
        let group = TemperatureGroupEntity(slumber:20, comfy:29, cosy:30);
        
        presenter.temperatures = group
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.maximum, "28")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalMaximumTemperatureSettingConvertsToString() {
        
        let group = TemperatureGroupEntity(slumber: 25.5, comfy: 28, cosy: 29);
        
        presenter.temperatures = group
        
        if let setting = displaySpy.comfy {
            XCTAssertEqual(setting.minimum, "26.5")
        } else {
            XCTFail()
        }
    }
    
    func testSetDecimalTemperatureSettingRoundsUpToSingleDecimalPlaceString() {
    
        let group = TemperatureGroupEntity(slumber: 14.46, comfy: 19, cosy: 29);
        
        presenter.temperatures = group
        
        if let setting = displaySpy.slumber {
            XCTAssertEqual(setting.temp, "14.5")
        } else {
            XCTFail()
        }
        
    }
    
    func testComfySetting() {
        
        let group = TemperatureGroupEntity(slumber:14, comfy: 18, cosy: 30)
        
        presenter.temperatures = group
        
        if let setting = displaySpy.comfy {
            XCTAssertEqual(setting.temp, "18")
            XCTAssertEqual(setting.minimum, "15")
            XCTAssertEqual(setting.maximum, "29")
        } else {
            XCTFail()
        }
        
    }
    
    func testCosySetting() {
        
        let group = TemperatureGroupEntity(slumber: 14, comfy: 18, cosy: 25.45)
        
        presenter.temperatures = group
        
        if let setting = displaySpy.cosy {
            XCTAssertEqual(setting.temp, "25.4")
            XCTAssertEqual(setting.minimum, "19")
            XCTAssertEqual(setting.maximum, "30")
        } else {
            XCTFail()
        }
        
    }
    
    
}
