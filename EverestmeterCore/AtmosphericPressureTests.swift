import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

final class AtmosphericPressureTests: XCTestCase {
    func testKilopascals1() {
        let atmosphericPressure = AtmosphericPressure(kilopascals: 300)
        XCTAssertEqual(atmosphericPressure.kilopascals, 300)
    }
    
    func testKilopascals2() {
        let atmosphericPressure = AtmosphericPressure(kilopascals: 400)
        XCTAssertEqual(atmosphericPressure.kilopascals, 400)
    }
}
