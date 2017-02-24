import XCTest

@testable import CosyHome

class TemperatureInteractorTests: XCTestCase {

    var gateway = TemperatureGatewaySimple()
    
    var output = TemperatureInteractorOutputSpy()
    
    var interactor: TemperatureInteractor!
    
    override func setUp() {
        
        super.setUp()
        
        interactor = TemperatureInteractor(gateway: gateway, output: output)
    }
    
    func testStartWhenGatewayFails() {
        
        gateway.enabled = false
        
        interactor.request(.load)
        
        guard let message = output.message else {
            XCTFail(); return
        }
        
        XCTAssertEqual(message, TemperatureInteractorOutputMessage.error_Fetching_Temperatures)

    }
    
    func testStartWhenGatewaySucceeds() {
        
        startWithGatewayTemperatures()
        
        guard let temperatures = output.temperatureGroup else {
            XCTFail(); return
        }
        
        XCTAssertNotNil(temperatures)
        
    }
    
    func testConvertingEntities() {
        
        startWithGatewayTemperatures(slumber: 12, comfy: 18, cosy: 21)
        
        guard let temperatures = output.temperatureGroup else {
            XCTFail(); return
        }
        
        XCTAssertEqual(temperatures.settings.low.temperature, gateway.group.settings.low.temperature)
        XCTAssertEqual(temperatures.settings.low.minimum, gateway.group.settings.low.minimum)
        XCTAssertEqual(temperatures.settings.low.maximum, gateway.group.settings.low.maximum)
        
    }
    
    func testUpdatingSlumberLowerThanSevenDegrees() {
        
        startWithGatewayTemperatures(slumber: 12.0)
        
        interactor.request(.adjustLow(temperature: 0.0))
        
        XCTAssertEqual(output.temperatureGroup?.settings.low.temperature, 7.0)
        
    }
    
    func testAdjustingSlumber() {
        
        startWithGatewayTemperatures()
        
        interactor.request(.adjustLow(temperature: 12))
        
        XCTAssertEqual(output.temperatureGroup?.settings.low.temperature, 12.0)
        
    }
    
    func testAdjustingComfy() {
        
        startWithGatewayTemperatures()
        
        interactor.request(.adjustMiddle(temperature: 12))
        
        XCTAssertEqual(output.temperatureGroup?.settings.middle.temperature, 12.0)
        
    }
    
    func testAdjustingCosy() {
        
        startWithGatewayTemperatures()
        
        interactor.request(.adjustHigh(temperature: 24))
        
        XCTAssertEqual(output.temperatureGroup?.settings.high.temperature, 24.0)
        
    }
    
    func testAdjustingSlumberAdjustsComfyMinimum() {
        
        startWithGatewayTemperatures(slumber: 10, comfy: 16, cosy: 21)
        
        interactor.request(.adjustLow(temperature: 12))
        
        XCTAssertEqual(output.temperatureGroup?.settings.middle.minimum, 13.0)
    }
    
    func testAdjustingComfyAdjustsSlumberMaximum() {
        
        startWithGatewayTemperatures(slumber: 10, comfy: 16, cosy: 21)
        
        interactor.request(.adjustMiddle(temperature: 12))
        
        XCTAssertEqual(output.temperatureGroup?.settings.low.maximum, 11.0)
    }
    
    func testAdjustingComfyAdjustsCosyMinimum() {
        
        startWithGatewayTemperatures(slumber: 10, comfy: 16, cosy: 21)
        
        interactor.request(.adjustMiddle(temperature: 12))
        
        XCTAssertEqual(output.temperatureGroup?.settings.high.minimum, 13.0)
    }
    
    func testAdjustingCosyAdjustsComfyMaximum() {
        
        startWithGatewayTemperatures(slumber: 10, comfy: 16, cosy: 21)
        
        interactor.request(.adjustHigh(temperature: 24))
        
        XCTAssertEqual(output.temperatureGroup?.settings.middle.maximum, 23.0)
    }
    
    func testAdjustingTwoSettings() {
        
        startWithGatewayTemperatures(slumber: 14, comfy: 19, cosy: 21)
        
        interactor.request(.adjustLow(temperature: 16))
        interactor.request(.adjustHigh(temperature: 24))
        
        XCTAssertEqual(output.temperatureGroup?.settings.low.temperature, 16)
        XCTAssertEqual(output.temperatureGroup?.settings.middle.temperature, 19)
        XCTAssertEqual(output.temperatureGroup?.settings.high.temperature, 24)
    }
    
    //MARK: Helpers
    
    func startWithGatewayTemperatures(slumber: Double = 7, comfy: Double = 18, cosy: Double = 21) {
        
        let temperatures = TemperatureGroupModel(low: slumber,  middle: comfy, high: cosy)
        gateway.group = TemperatureGroupEntity(temperatures: temperatures)
        
        interactor.request(.load)
    }

    
}
