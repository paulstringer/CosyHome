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
                
                view.low = itemForTemperature(temperatures.low, name: "SLUMBER")
                
                view.middle = itemForTemperature(temperatures.middle, name:  "COMFY")
                
                view.high = itemForTemperature(temperatures.high, name: "COSY")

            }

        }
    }
    
    var message: TemperatureInteractorOutputMessage?
    
    //MARK: Private
    
    fileprivate func itemForTemperature(_ setting: TemperatureSettingEntity, name: String) -> TemperatureGroupItem {
        
        let formattedTemperature = formattedStrings(setting)
        
        return TemperatureGroupItem(name: name, temp: formattedTemperature, minimum: setting.minimum, maximum: setting.maximum)
        
    }
    
    fileprivate func formattedStrings(_ setting: TemperatureSettingEntity) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: setting.temperature as Double))!
    }
}
