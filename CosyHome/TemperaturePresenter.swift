import Foundation

class TemperaturePresenter: TemperatureInteractorOutput {
    
    var view: TemperatureGroupView
    
    init(view: TemperatureGroupView) {
        self.view = view
    }
    
    //MARK: Temperature Interactor Output
    
    var temperatureGroup: TemperatureGroupEntity? {
       
        didSet {
            
            if let temperatures = temperatureGroup?.settings {
                
                view.slumber = itemForTemperature(temperatures.slumber)
                
                view.comfy = itemForTemperature(temperatures.comfy)
                
                view.cosy = itemForTemperature(temperatures.cosy)

            }

        }
    }
    
    var message: TemperatureInteractorOutputMessage?
    
    //MARK: Private
    
    private func itemForTemperature(setting: TemperatureSettingEntity) -> TemperatureGroupItem {
        
        let formatted = formattedStrings(setting)
        
        return TemperatureGroupItem(temp: formatted.temperature, minimum: formatted.min, maximum: formatted.max)
        
    }
    
    private func formattedStrings(setting: TemperatureSettingEntity) -> (temperature: String, min: String, max:String) {
        
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        
        let temp = formatter.stringFromNumber(NSNumber(double: setting.temperature))!
        let min = formatter.stringFromNumber(NSNumber(double: setting.minimum))!
        let max = formatter.stringFromNumber(NSNumber(double: setting.maximum))!
        
        return (temp, min, max)
    }
}