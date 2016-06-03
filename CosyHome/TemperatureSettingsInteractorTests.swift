import XCTest

@testable import CosyHome

class TemperatureSettingsInteractorTests: XCTestCase {

    var gateway = TemperatureSettingEntityGatewaySimple()
    
    var output = TemperatureSettingsInteractorOutputSpy()
    
    var interactor: TemperatureSettingsInteractor!
    
    override func setUp() {
        
        super.setUp()
        
        interactor = TemperatureSettingsInteractor(gateway: gateway, output: output)
    }
    
    func testStartWhenGatewayFails() {
        
        gateway.enabled = false
        
        interactor.start()
        
        guard let message = output.message else {
            XCTFail(); return
        }
        
        XCTAssertEqual(message, TemperatureSettingsInteractorOutputMessage.Error_Fetching_Temperatures)

    }
    
    func testStartWhenGatewaySucceeds() {
        
        let entity = TemperatureSettingEntity(type: .Slumber)
        
        gateway.entities = [entity]
        
        interactor.start()
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertNotNil(temperatures.first)
        
    }
    
    func testConvertingEntities() {
        
        let entity = TemperatureSettingEntity(temperature: 17.5, minimum: 7.0, maximum: 24.0)
        
        gateway.entities = [entity]
        
        interactor.start()
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertEqual(temperatures.first?.temperature, entity.temperature)
        XCTAssertEqual(temperatures.first?.minimum, entity.minimum)
        XCTAssertEqual(temperatures.first?.maximum, entity.maximum)
        
    }
    
    func testConvertingTemperatureTypes() {
        
        let entity = TemperatureSettingEntity(type: .Cosy)
        
        gateway.entities = [entity]
        
        interactor.start()
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertEqual(temperatures.first?.type, .Cosy)
    }
    
}
