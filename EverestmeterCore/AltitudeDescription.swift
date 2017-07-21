public struct AltitudeDescription {
    public let text: String
}

extension AltitudeDescription {
    public init(altitude: Altitude) {
        let value = Int(altitude.meters.rounded())
        let unit = "m"
        text = String(value) + unit
    }
}
