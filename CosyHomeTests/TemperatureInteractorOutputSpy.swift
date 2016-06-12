import Foundation

@testable import CosyHome

class TemperatureInteractorOutputSpy: TemperatureInteractorOutput {
    
    var temperatures: TemperatureGroupEntity?
    var message: TemperatureInteractorOutputMessage?
}