public struct Altitude {
    public let meters: Double
}

extension Altitude {
    public init(atmosphericPressure: AtmosphericPressure) {
        let averageEarthTemperatureInKelvin = 289.15
        let pressureAtSeaLevel = AtmosphericPressure(kilopascals: 101.325)
        let pressureRatio = pressureAtSeaLevel.kilopascals / atmosphericPressure.kilopascals
        meters = ((pressureRatio.power(1 / 5.257) - 1) * averageEarthTemperatureInKelvin) / 0.0065
    }
}
