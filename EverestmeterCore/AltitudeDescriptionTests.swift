import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

final class AltitudeDescriptionTests: XCTestCase {
    func testFormatsAltitude() {
        let altitude = Altitude(meters: 1000)
        let altitudeDescription = AltitudeDescription(altitude: altitude)
        XCTAssertEqual(altitudeDescription.text, "1000m")
    }
    
    func testFormatsOtherAltitude() {
        let altitude = Altitude(meters: 2000)
        let altitudeDescription = AltitudeDescription(altitude: altitude)
        XCTAssertEqual(altitudeDescription.text, "2000m")
    }
    
    func testRoundsAltitude() {
        let altitude = Altitude(meters: 2999.9)
        let altitudeDescription = AltitudeDescription(altitude: altitude)
        XCTAssertEqual(altitudeDescription.text, "3000m")
    }
}
