import Foundation

protocol TemperatureSettingsInteractorOutput {
    func setTemperatures(temperatures: [TemperatureSetting])
}

struct TemperatureSetting: Equatable {
    let temperature: Double
    let minimum: Double
    let maximum: Double
}

func ==(lhs: TemperatureSetting, rhs: TemperatureSetting ) -> Bool {
    return lhs.temperature == rhs.temperature
}
