import Foundation
import EverestmeterCore

final class SimulatedBarometer: Barometer {
    var onDidMeasurePressure: BarometerPressureHandler?
    var onError: BarometerErrorHandler?
    init() {}
}

extension SimulatedBarometer {
    static var isPressureDataAvailable: Bool {
        guard case .some = SimulatedBarometer.pressure else { return false }
        return true
    }
}

extension SimulatedBarometer {
    func startMeasuring() {
        switch SimulatedBarometer.pressure {
        case .none:
            fatalError()
        case .some(let value):
            onDidMeasurePressure?(Pressure(kilopascals: value))
        case .error(let error):
            onError?(error)
        }
    }

    func stopMeasuring() {}
}

private extension SimulatedBarometer {
    enum SimulatedPressure {
        case none
        case some(Double)
        case error(String)
    }

    static var pressure: SimulatedPressure {
        guard let candidate = ProcessInfo.processInfo.environment["SIMULATED_PRESSURE"] else {
            return .none
        }
        guard let value = Double(candidate) else {
            let error = NSLocalizedString("Invalid Simulated Pressure", comment: "")
            return .error(error)
        }
        return .some(value)
    }
}
