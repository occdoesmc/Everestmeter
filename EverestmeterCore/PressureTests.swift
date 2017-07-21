import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

final class PressureTests: XCTestCase {
    func testKilopascals1() {
        let pressure = Pressure(kilopascals: 300)
        XCTAssertEqual(pressure.kilopascals, 300)
    }
    
    func testKilopascals2() {
        let pressure = Pressure(kilopascals: 400)
        XCTAssertEqual(pressure.kilopascals, 400)
    }
}
