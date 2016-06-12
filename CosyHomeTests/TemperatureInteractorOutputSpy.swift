import Foundation

@testable import CosyHome

class TemperatureInteractorOutputSpy: TemperatureInteractorOutput {
    var temperatureGroup: TemperatureGroupEntity?
    var message: TemperatureInteractorOutputMessage?
}