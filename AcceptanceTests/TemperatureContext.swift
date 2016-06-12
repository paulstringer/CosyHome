import Foundation

typealias TemperatureContextInput = (slumber: Double, comfy: Double, cosy: Double)

struct TemperatureContext: TemperatureSettingsDisplay {
    
    static var interactor: TemperatureInteractor?
    
    static var slumber: TemperatureSettingItem?
    static var comfy: TemperatureSettingItem?
    static var cosy: TemperatureSettingItem?
    
    init(temperatures: TemperatureContextInput) {
        
        TemperatureContext.interactor = createInteractor(temperatures)
        
        TemperatureContext.interactor?.request(.load)
    }
    
    private func createInteractor(temperatures: TemperatureContextInput) -> TemperatureInteractor {
    
        let gateway = TemperatureGatewaySimple(slumber: temperatures.slumber, comfy: temperatures.comfy, cosy: temperatures.cosy)
    
        let output = TemperaturePresenter(display: self)
    
        return TemperatureInteractor(gateway: gateway, output: output)
    
    }
    
    var slumber: TemperatureSettingItem? {
        
        set {
            TemperatureContext.slumber = newValue
        }
        
        get {
            return TemperatureContext.slumber
        }
        
    }
    
    var comfy: TemperatureSettingItem? {
        
        set {
            TemperatureContext.comfy = newValue
        }
        
        get {
            return TemperatureContext.comfy
        }
        
    }
    
    var cosy: TemperatureSettingItem? {
        set {
            TemperatureContext.cosy = newValue
        }
        
        get{
            return TemperatureContext.cosy
        }
    }
    
    
    
}