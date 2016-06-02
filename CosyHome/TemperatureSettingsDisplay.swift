import Foundation

struct TemperatureSettingItem: Equatable {
    let temp: String
    let minimum: String
    let maximum: String
}

func ==(lhs: TemperatureSettingItem, rhs: TemperatureSettingItem ) -> Bool {
    return lhs.temp == rhs.temp
}

protocol TemperatureSettingsDisplay {
    
    func setTemperatureSettings(settings:[TemperatureSettingItem])
    
}