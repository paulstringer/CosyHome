import Foundation


class TemperatureSettingsPresenter: TemperatureSettingsInteractorOutput {
    
    let display: TemperatureSettingsDisplay
    
    init(display: TemperatureSettingsDisplay) {
        self.display = display
    }
    
    //MARK: Interactor Output
    
    func setTemperatures(temperatures: [TemperatureSetting]) {
        let items = temperatures.map { (setting) -> TemperatureSettingItem in
            setting.temperature
            let formatted = temperatureFormattedStringsForSetting(setting)
            return TemperatureSettingItem(temp: formatted.temp, minimum: formatted.min, maximum: formatted.max)
        }
         display.setTemperatureSettings(items)
    }
    
    private func temperatureFormattedStringsForSetting(setting: TemperatureSetting) -> (temp: String, min: String, max:String) {
        
        let format = "%0.1f"
        
        let temp = String(format: format, setting.temperature)
        let min = String(format: format, setting.minimum)
        let max = String(format: format, setting.maximum)
        
        return (temp, min, max)
    }
}