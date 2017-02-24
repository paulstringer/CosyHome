import Foundation

@objc(CheckTemperatures)

class CheckTemperatures : NSObject, SlimQueryTable {

    func query() -> [AnyObject]! {
       
        let query = [TemperatureContext.low, TemperatureContext.middle, TemperatureContext.high].map { (item) -> [String:String] in
            
            return queryRowWithTemperatureItem(item)
            
        }
        
        return NSArray(array: query) as [AnyObject]
        
        
    }
    
    fileprivate func queryRowWithTemperatureItem(_ item: TemperatureGroupItem?) -> [String:String] {
        
        if let item = item {
            
            let state = TemperatureContext.stateNameForItem(item)
            
            return ["state":state, "minimum":String(item.minimum), "temperature": item.temp, "maximum": String(item.maximum), "name" : item.name]
            
        } else {
            
            return [:]
            
        }
        
        
    }
    
}

