import Foundation

protocol TemperatureGateway {
    func fetchGroup() -> TemperatureGatewayResponse
}

enum TemperatureGatewayResponse {
    case success(group: TemperatureSettingGroup)
    case error
}

protocol TemperatureInteractorOutput {
    var temperatures: [TemperatureSetting]? { get set }
    var message: TemperatureInteractorOutputMessage?{ get set }
}

enum TemperatureSettingType {
    case Slumber
    case Comfy
    case Cosy
    
    init(type: TemperatureSettingEntityType) {
        switch type {
        case .Slumber:
            self = .Slumber
        case .Comfy:
            self = .Comfy
        case .Cosy:
            self = .Cosy
        }
    }
}

struct TemperatureSetting {
    let type: TemperatureSettingType
    let temperature: Double
    let minimum: Double
    let maximum: Double
    
    init(type: TemperatureSettingType = .Slumber, temperature: Double = 0.0, minimum: Double = 0.0, maximum: Double = 0.0) {
        self.type = type
        self.temperature = temperature
        self.minimum = minimum
        self.maximum = maximum
    }
}

func ==(lhs: TemperatureSetting, rhs: TemperatureSetting) -> Bool{
    return lhs.temperature == rhs.temperature
}

enum TemperatureInteractorOutputMessage {
    case Error_Fetching_Temperatures
}

enum TemperatureSettingsInputRequest {
    case load
}

struct TemperatureInteractor {
    
    let gateway: TemperatureGateway
    var output: TemperatureInteractorOutput
    var temperatureGroup: TemperatureSettingGroup?
    
    init(gateway: TemperatureGateway, output: TemperatureInteractorOutput) {
        self.gateway = gateway
        self.output = output
    }
    
    mutating func request(request: TemperatureSettingsInputRequest) {
        
        switch gateway.fetchGroup() {
        
        case .success(let group):
            
            temperatureGroup = group
            
            output.temperatures = TemperatureInteractor.transform(group)
        
        case .error:
            
            output.message = .Error_Fetching_Temperatures
        }
        
    }
    
    mutating func adjustSlumber(temperature: Double) {
        
        adjustTemperatureWithType(.Slumber, to: temperature)
        
    }
    
    mutating func adjustCosy(temperature: Double) {
        
        adjustTemperatureWithType(.Cosy, to: temperature)
    }
    
    mutating func adjustComfy(temperature: Double) {
        
        adjustTemperatureWithType(.Comfy, to: temperature)
        
    }
    
    private mutating func adjustTemperatureWithType(type: TemperatureSettingEntityType, to temperature: Double) {
    
        temperatureGroup?.adjustTemperatureWithType(type, to: temperature)
        
        guard let temperatureGroup = temperatureGroup else {
            return
        }
        
        output.temperatures = TemperatureInteractor.transform(temperatureGroup)
        
    }
    
    private static func transform(group : TemperatureSettingGroup) -> [TemperatureSetting] {

        let entities = [group.settings.slumber, group.settings.comfy, group.settings.cosy]
        
        return entities.map({ (entity) -> TemperatureSetting in
            return TemperatureSetting(type:TemperatureSettingType(type: entity.type), temperature: entity.temperature, minimum: entity.minimum, maximum: entity.maximum)
        })
        
    }
    
}
