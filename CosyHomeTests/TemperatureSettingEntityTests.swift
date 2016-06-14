import XCTest

@testable import CosyHome

class TemperatureSettingEntityTests: XCTestCase {

    func testLowerThanSevenDegrees() {
        
        let setting = TemperatureSettingEntity(temperature: 0.0)
        
        XCTAssertEqual(setting.temperature, 7.0)
        
    }
    
    func testHigherThanThirtyDegrees() {
        
        let setting = TemperatureSettingEntity(temperature: 100.0)
        
        XCTAssertEqual(setting.temperature, 30.0)
        
    }
    
    func testMinimumTempOfFirstSetting() {
        
        let setting = TemperatureSettingEntity(temperature: 19.0)
        
        XCTAssertEqual(setting.minimum, 7.0)
    }
    
    func testMinimumTempOfSettingWithPreviousSettingEqualsOneDegreeHotter() {
        
        let setting = TemperatureSettingEntity(temperature: 19.0, previous: 14.0 )
        
        XCTAssertEqual(setting.minimum, 15.0)
    }
    
    func testLowerThanPreviousTemperatureIsAdjustedUp() {
        
        let setting = TemperatureSettingEntity(temperature: 13.0, previous: 14.0)
        
        XCTAssertEqual(setting.temperature, 15.0)
        
    }
    
    func testMaximumTempOfLastSetting() {
        
        let setting = TemperatureSettingEntity(temperature: 19.0)
        
        XCTAssertEqual(setting.maximum, 30.0)
    }
    
    func testMaximumTempOfSettingOneDegreeLowerThanNextSetting() {
        
        let setting = TemperatureSettingEntity(temperature: 14.0, next: 16.0)
        
        XCTAssertEqual(setting.maximum, 15.0)
        
    }
    
    func testHigherThanNextTemperatureOneBelowNextTemperature() {
        
        let setting = TemperatureSettingEntity(temperature: 15.0, next: 14.0)
        
        XCTAssertEqual(setting.temperature, 13.0)
        
    }
    
    func testEqualToNextTemperatureAdjustedToOneBelow() {
        
        let setting = TemperatureSettingEntity(temperature: 14.0, next: 14.0)
        XCTAssertEqual(setting.temperature, 13.0)
        
    }
    
    func testEqualToPreviousTemperatureAdjustedToOneAbove() {
        
        let setting = TemperatureSettingEntity(temperature: 14.0, previous: 14.0)
        XCTAssertEqual(setting.temperature, 15.0)
        
    }
    
    
    func testEntitiesWithTemperaturesCountAndValues() {
        
        let (slumber, comfy, cosy) = TemperatureSettingEntity.entitiesWithTemperaturesLow(12, middle: 18, high: 21)
        
        XCTAssertEqual(slumber.temperature, 12.0)
        XCTAssertEqual(comfy.temperature, 18.0)
        XCTAssertEqual(cosy.temperature, 21.0)
    }
    
    func testEntitiesWithTemperaturesMinimums() {
        
        let (slumber, comfy, cosy) =  TemperatureSettingEntity.entitiesWithTemperaturesLow(12, middle: 18, high: 21)
        
        XCTAssertEqual(slumber.minimum, 7)
        XCTAssertEqual(comfy.minimum, 13)
        XCTAssertEqual(cosy.minimum, 19)
    }
    
    func testEntitiesWithTemperaturesMaximum() {
        
        let (slumber, comfy, cosy) =  TemperatureSettingEntity.entitiesWithTemperaturesLow(12, middle: 18, high: 21)
        XCTAssertEqual(slumber.maximum, 17)
        XCTAssertEqual(comfy.maximum, 20)
        XCTAssertEqual(cosy.maximum, 30)
    }
    
    func testAdjustTemperatureLowerThanMinimum() {
        
        var entity = TemperatureSettingEntity(temperature: 12)
        entity.adjustTemperature(0.0)
        XCTAssertEqual(entity.temperature, 7.0)

    }
    
    func testAdjustTemperatureHigherThanMaximum() {
        
        var entity = TemperatureSettingEntity(temperature: 12)
        entity.adjustTemperature(31)
        XCTAssertEqual(entity.temperature, 30.0)
        
    }
    
    func testAdjustTemperatureWithinBounds() {
        
        var entity = TemperatureSettingEntity(temperature: 12)
        entity.adjustTemperature(13)
        XCTAssertEqual(entity.temperature, 13.0)
        
    }
    
    func testAdjustTemperatureLowerThanPrevious() {
        var entity = TemperatureSettingEntity(temperature: 13, previous: 10)
        entity.adjustTemperature(9)
        XCTAssertEqual(entity.temperature, 11.0)
        
    }
    
    func testAdjustTemperatureHigherThanNext() {
        var entity = TemperatureSettingEntity(temperature: 13, next: 18)
        entity.adjustTemperature(19)
        XCTAssertEqual(entity.temperature, 17)
        
    }
    
    func testAdjustTemperatureEqualToNext() {
        var entity = TemperatureSettingEntity(temperature: 13, next: 18)
        entity.adjustTemperature(18)
        XCTAssertEqual(entity.temperature, 17)
        
    }
    
    func testAdjustPreviousTemperature() {
        var entity = TemperatureSettingEntity(previous: 9)
        entity.previous = 12
        XCTAssertEqual(entity.minimum, 13)
    }
    
    func testAdjustNextTemperature() {
        var entity = TemperatureSettingEntity(previous: 9)
        entity.next = 12
        XCTAssertEqual(entity.maximum, 11)
    }
    

}
