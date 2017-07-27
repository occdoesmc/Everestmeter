import CoreMotion
import EverestmeterCore

final class DeviceBarometer: Barometer {
    var onDidMeasurePressure: BarometerPressureHandler?
    var onError: BarometerErrorHandler?
    fileprivate let altimeter = CMAltimeter()
    init() {}
}

extension DeviceBarometer {
    static var isPressureDataAvailable: Bool {
        return CMAltimeter.isRelativeAltitudeAvailable()
    }
}

extension DeviceBarometer {
    func startMeasuring() {
        let operationQueue = OperationQueue()
        altimeter.startRelativeAltitudeUpdates(to: operationQueue) { [weak self] altitudeData, error in
            OperationQueue.main.addOperation {
                self?.process(altitudeData)
                self?.process(error)
            }
        }
    }

    func stopMeasuring() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}

private extension DeviceBarometer {
    func process(_ altitudeData: CMAltitudeData?) {
        guard let altitudeData = altitudeData else { return }
        guard let handler = onDidMeasurePressure else { return }
        let kilopascals = Double(altitudeData.pressure)
        let pressure = Pressure(kilopascals: kilopascals)
        handler(pressure)
    }

    func process(_ error: Error?) {
        guard let error = error else { return }
        guard let handler = onError else { return }
        handler(error.localizedDescription)
    }
}
