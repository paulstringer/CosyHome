import Foundation

@testable import CosyHome

class TemperatureInteractorOutputSpy: TemperatureInteractorOutput {
    
    var temperatures: [TemperatureSetting]?
    var message: TemperatureInteractorOutputMessage?
}