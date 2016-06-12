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
        
        XCTAssertEqual(message, TemperatureInteractorOutputMessage.Error_Fetching_Temperatures)

    }
    
    func testStartWhenGatewaySucceeds() {
        
        startWithGatewayTemperatures()
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertNotNil(temperatures)
        
    }
    
    func testConvertingEntities() {
        
        startWithGatewayTemperatures(12, comfy: 18, cosy: 21)
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertEqual(temperatures.settings.slumber.temperature, gateway.group.settings.slumber.temperature)
        XCTAssertEqual(temperatures.settings.slumber.minimum, gateway.group.settings.slumber.minimum)
        XCTAssertEqual(temperatures.settings.slumber.maximum, gateway.group.settings.slumber.maximum)
        
    }
    
    func testUpdatingSlumberLowerThanSevenDegrees() {
        
        startWithGatewayTemperatures(12.0)
        
        interactor.adjustSlumber(0.0)
        
        XCTAssertEqual(output.temperatures?.settings.slumber.temperature, 7.0)
        
    }
    
    func testAdjustingSlumber() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustSlumber(12)
        
        XCTAssertEqual(output.temperatures?.settings.slumber.temperature, 12.0)
        
    }
    
    func testAdjustingComfy() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?.settings.comfy.temperature, 12.0)
        
    }
    
    func testAdjustingCosy() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?.settings.cosy.temperature, 24.0)
        
    }
    
    func testAdjustingSlumberAdjustsComfyMinimum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustSlumber(12)
        
        XCTAssertEqual(output.temperatures?.settings.comfy.minimum, 13.0)
    }
    
    func testAdjustingComfyAdjustsSlumberMaximum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?.settings.slumber.maximum, 11.0)
    }
    
    func testAdjustingComfyAdjustsCosyMinimum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?.settings.cosy.minimum, 13.0)
    }
    
    func testAdjustingCosyAdjustsComfyMaximum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?.settings.comfy.maximum, 23.0)
    }
    
    func testAdjustingTwoSettings() {
        
        startWithGatewayTemperatures(14, comfy: 19, cosy: 21)
        
        interactor.adjustSlumber(16)
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?.settings.slumber.temperature, 16)
        XCTAssertEqual(output.temperatures?.settings.comfy.temperature, 19)
        XCTAssertEqual(output.temperatures?.settings.cosy.temperature, 24)
    }
    
    //MARK: Helpers
    
    func startWithGatewayTemperatures(slumber: Double = 7, comfy: Double = 18, cosy: Double = 21) {
        
        let temperatures = TemperatureGroupModel(slumber: slumber,  comfy: comfy, cosy: cosy)
        gateway.group = TemperatureGroupEntity(temperatures: temperatures)
        
        interactor.request(.load)
    }

    
}
