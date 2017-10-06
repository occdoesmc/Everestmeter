import WatchConnectivity

final class RemoteBarometer: Barometer {
    public private(set) var output: BarometerOutput
    public var onDidUpdateOutput: () -> Void

    init() {
        fatalError()
    }
}

extension RemoteBarometer {
    func startMeasuring() {
        WCSession.default.delegate = self
    }

    func stopMeasuring() {

    }
}

extension RemoteBarometer: WCSessionDelegate {}
