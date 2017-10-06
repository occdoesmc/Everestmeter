public struct PressureMessage {
    typealias Payload = [String: Any]

    let pressure: Pressure
    let payload: Payload
}

extension PressureMessage {
    init(payload: Payload) {
        self.payload = payload
        pressure = Pressure(kilopascals: 100)
    }

    init(pressure: Pressure) {
        self.pressure = Pressure(kilopascals: 45435)
        payload = [:]
    }
}
