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
        
        XCTAssertNotNil(temperatures.first)
        
    }
    
    func testConvertingEntities() {
        
        startWithGatewayTemperatures(12, comfy: 18, cosy: 21)
        
        guard let temperatures = output.temperatures else {
            XCTFail(); return
        }
        
        XCTAssertEqual(temperatures.first?.temperature, gateway.group.settings.slumber.temperature)
        XCTAssertEqual(temperatures.first?.minimum, gateway.group.settings.slumber.minimum)
        XCTAssertEqual(temperatures.first?.maximum, gateway.group.settings.slumber.maximum)
        
    }
    
    func testUpdatingSlumberLowerThanSevenDegrees() {
        
        startWithGatewayTemperatures(12.0)
        
        interactor.adjustSlumber(0.0)
        
        XCTAssertEqual(output.temperatures?.first?.temperature, 7.0)
        
    }
    
    func testAdjustingSlumber() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustSlumber(12)
        
        XCTAssertEqual(output.temperatures?.first?.temperature, 12.0)
        
    }
    
    func testAdjustingComfy() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?[1].temperature, 12.0)
        
    }
    
    func testAdjustingCosy() {
        
        startWithGatewayTemperatures()
        
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?[2].temperature, 24.0)
        
    }
    
    func testAdjustingSlumberAdjustsComfyMinimum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustSlumber(12)
        
        XCTAssertEqual(output.temperatures?[1].minimum, 13.0)
    }
    
    func testAdjustingComfyAdjustsSlumberMaximum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?[0].maximum, 11.0)
    }
    
    func testAdjustingComfyAdjustsCosyMinimum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustComfy(12)
        
        XCTAssertEqual(output.temperatures?[2].minimum, 13.0)
    }
    
    func testAdjustingCosyAdjustsComfyMaximum() {
        
        startWithGatewayTemperatures(10, comfy: 16, cosy: 21)
        
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?[1].maximum, 23.0)
    }
    
    func testAdjustingTwoSettings() {
        
        startWithGatewayTemperatures(14, comfy: 19, cosy: 21)
        
        interactor.adjustSlumber(16)
        interactor.adjustCosy(24)
        
        XCTAssertEqual(output.temperatures?[0].temperature, 16)
        XCTAssertEqual(output.temperatures?[1].temperature, 19)
        XCTAssertEqual(output.temperatures?[2].temperature, 24)
    }
    
    //MARK: Helpers
    
    func startWithGatewayTemperatures(slumber: Double = 7, comfy: Double = 18, cosy: Double = 21) {
        
        gateway.group = TemperatureGroupEntity(slumber: slumber, comfy: comfy, cosy: cosy)
        
        interactor.request(.load)
    }

    
}
