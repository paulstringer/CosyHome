import Foundation

enum TemperatureSettingEntityType: String {
    case Slumber = "SLUMBER"
    case Comfy = "COMFY"
    case Cosy = "COSY"
}

struct TemperatureSettingEntity {
    
    let type: TemperatureSettingEntityType
    let temperature: Double
    let maximum: Double
    let minimum: Double
    
    init(type: TemperatureSettingEntityType = .Slumber, temperature: Double = 0.0, minimum: Double = 0.0, maximum: Double = 0.0) {
        self.type = type
        self.temperature = temperature
        self.minimum = minimum
        self.maximum = maximum
    }
}
