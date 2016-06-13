import Foundation

protocol TemperatureGroupView {
    var slumber: TemperatureGroupItem? { get set }
    var comfy: TemperatureGroupItem? { get set }
    var cosy: TemperatureGroupItem? { get set }
}

struct TemperatureGroupItem: Equatable {
    let temp: String
    let minimum: Double
    let maximum: Double
}

func ==(lhs: TemperatureGroupItem, rhs: TemperatureGroupItem ) -> Bool {
    return lhs.temp == rhs.temp && lhs.minimum == rhs.minimum && lhs.maximum == rhs.maximum
}