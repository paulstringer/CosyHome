import Foundation

@objc(CheckTemperatures)

class CheckTemperatures : NSObject, SlimQueryTable {

    func query() -> [AnyObject]! {
       
        let query = [TemperatureContext.slumber, TemperatureContext.comfy, TemperatureContext.cosy].map { (item) -> [String:String] in
            
            return queryRowWithTemperatureItem(item)
            
        }
        
        return NSArray(array: query) as [AnyObject]
        
        
    }
    
    private func queryRowWithTemperatureItem(item: TemperatureSettingItem?) -> [String:String] {
        
        
        if let item = item {
            
            let state = TemperatureContext.stateForItem(item)
            
            return ["state":state, "minimum":item.minimum, "temperature": item.temp, "maximum": item.maximum]
            
        } else {
            
            return [:]
            
        }
        
        
    }
    
}

