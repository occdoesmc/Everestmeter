import CoreMotion
import EverestmeterCore

final class DeviceBarometer: Barometer {
    var output: BarometerOutput = .none
    var onDidUpdateOutput: () -> Void = {}
    private let altimeter = CMAltimeter()
    init() {}
}

extension DeviceBarometer {
    func startMeasuring() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            let error = NSLocalizedString("Barometer Not Available", comment: "")
            output = .error(error)
            onDidUpdateOutput()
            return
        }
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
        let kilopascals = Double(truncating: altitudeData.pressure)
        let pressure = Pressure(kilopascals: kilopascals)
        output = .pressure(pressure)
        onDidUpdateOutput()
    }

    func process(_ error: Error?) {
        guard let error = error else { return }
        output = .error(error.localizedDescription)
        onDidUpdateOutput()
    }
}
