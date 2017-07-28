import EverestmeterCore

enum BarometerOutput {
    case none
    case pressure(Pressure)
    case error(String)
}

protocol Barometer: class {
    var output: BarometerOutput { get }
    var onDidUpdateOutput: () -> Void { get set }

    init()

    func startMeasuring()
    func stopMeasuring()
}
