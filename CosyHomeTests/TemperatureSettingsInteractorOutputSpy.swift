import Foundation

@testable import CosyHome

class TemperatureSettingsInteractorOutputSpy: TemperatureSettingsInteractorOutput {
    
    var temperatures: [TemperatureSetting]?
    var message: TemperatureSettingsInteractorOutputMessage?
}