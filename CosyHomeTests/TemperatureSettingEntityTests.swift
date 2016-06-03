import XCTest

@testable import CosyHome

class TemperatureSettingEntityTests: XCTestCase {

    func testLowerThanSevenDegrees() {
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 0.0)
        
        XCTAssertEqual(setting.temperature, 7.0)
        
    }
    
    func testHigherThanThirtyDegrees() {
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 100.0)
        
        XCTAssertEqual(setting.temperature, 30.0)
        
    }
    
    func testMinimumTempOfFirstSetting() {
        
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 19.0)
        
        XCTAssertEqual(setting.minimum, 7.0)
    }
    
    func testMinimumTempOfSettingWithPreviousSettingEqualsOneDegreeHotter() {
        
        let setting = TemperatureSettingEntity(type: .Comfy, temperature: 19.0, previous: 14.0 )
        
        XCTAssertEqual(setting.minimum, 15.0)
    }
    
    func testLowerThanPreviousTemperatureIsAdjustedUp() {
        
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 13.0, previous: 14.0)
        
        XCTAssertEqual(setting.temperature, 15.0)
        
    }
    
    func testMaximumTempOfLastSetting() {
        
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 19.0)
        
        XCTAssertEqual(setting.maximum, 30.0)
    }
    
    func testMaximumTempOfSettingOneDegreeLowerThanNextSetting() {
        
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 14.0, next: 16.0)
        
        XCTAssertEqual(setting.maximum, 15.0)
        
    }
    
    func testHigherThanNextTemperatureOneBelowNextTemperature() {
        
        let setting = TemperatureSettingEntity(type: .Slumber, temperature: 15.0, next: 14.0)
        
        XCTAssertEqual(setting.temperature, 13.0)
        
    }
    
    func testEntitiesWithTemperaturesCountAndValues() {
        
        let entities = TemperatureSettingEntity.entitiesWithTemperatureForSlumber(12, comfy: 18, cosy: 21)
        XCTAssertEqual(3, entities.count)
        
        XCTAssertEqual(entities[0].temperature, 12.0)
        XCTAssertEqual(entities[1].temperature, 18.0)
        XCTAssertEqual(entities[2].temperature, 21.0)
    }
    
    func testEntitiesWithTemperaturesMinimums() {
        
        let entities = TemperatureSettingEntity.entitiesWithTemperatureForSlumber(12, comfy: 18, cosy: 21)
        
        XCTAssertEqual(entities[0].minimum, 7)
        XCTAssertEqual(entities[1].minimum, 13)
        XCTAssertEqual(entities[2].minimum, 19)
    }
    
    func testEntitiesWithTemperaturesMaximum() {
        
        let entities = TemperatureSettingEntity.entitiesWithTemperatureForSlumber(12, comfy: 18, cosy: 21)
        XCTAssertEqual(entities[0].maximum, 17)
        XCTAssertEqual(entities[1].maximum, 20)
        XCTAssertEqual(entities[2].maximum, 30)
    }
    

}
