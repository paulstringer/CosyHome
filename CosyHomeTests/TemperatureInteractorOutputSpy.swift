import Foundation

@testable import CosyHome

class TemperatureInteractorOutputSpy: TemperatureInteractorOutput {
    
    var temperatures: [TemperatureGroupItemEntity]?
    var message: TemperatureInteractorOutputMessage?
}