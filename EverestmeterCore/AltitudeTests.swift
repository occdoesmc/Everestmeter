import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

// https://en.wikipedia.org/wiki/Atmospheric_pressure
// http://keisan.casio.com/exec/system/1224585971
final class AltitudeTests: XCTestCase {
    func testCalculatesAltitudeAtSeaLevel() {
        let pressure = Pressure(kilopascals: 101.325)
        let altitude = Altitude(pressure: pressure)
        XCTAssertEqual(altitude.meters, 0)
    }

    func testCalculatesAltitude1000Meters() {
        let pressure = Pressure(kilopascals: 90.1492)
        let altitude = Altitude(pressure: pressure)
        XCTAssertEqual(altitude.meters, 1000, accuracy: 0.1)
    }
}
