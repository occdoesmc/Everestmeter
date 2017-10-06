import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

final class PressureMessageTests: XCTestCase {
    func testPressureMessage() {
        let pressure = Pressure(kilopascals: 100)
        let pressureMessage1 = PressureMessage(pressure: pressure)
        let pressureMessage2 = PressureMessage(payload: pressureMessage1.payload)
        XCTAssertEqual(pressureMessage2.pressure, pressure)
    }
}
