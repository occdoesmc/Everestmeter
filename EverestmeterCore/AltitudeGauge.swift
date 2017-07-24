public struct AltitudeGauge {
    public let verticalOffset: Double
    public let thickness: Double
}

extension AltitudeGauge {
    public init(altitude: Altitude, viewHeight: Double) {
        verticalOffset = AltitudeGauge.verticalOffset(for: altitude, viewHeight: viewHeight)
        thickness = AltitudeGauge.thickness(forViewHeight: viewHeight)
    }

    private static func verticalOffset(for altitude: Altitude, viewHeight: Double) -> Double {
        let altitudeRatio = altitude.meters / 8848
        let viewRatio = 1 - altitudeRatio
        return (Double(viewRatio) * viewHeight).rounded()
    }

    private static func thickness(forViewHeight viewHeight: Double) -> Double {
        let preferredThickness = (viewHeight * 0.005).rounded()
        return max(preferredThickness, 1)
    }
}
