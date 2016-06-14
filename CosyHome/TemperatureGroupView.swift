import Foundation

protocol TemperatureGroupView {
    var low: TemperatureGroupItem? { get set }
    var middle: TemperatureGroupItem? { get set }
    var high: TemperatureGroupItem? { get set }
}

struct TemperatureGroupItem: Equatable {
    let name: String
    let temp: String
    let minimum: Double
    let maximum: Double
}

func ==(lhs: TemperatureGroupItem, rhs: TemperatureGroupItem ) -> Bool {
    return lhs.temp == rhs.temp && lhs.minimum == rhs.minimum && lhs.maximum == rhs.maximum
}