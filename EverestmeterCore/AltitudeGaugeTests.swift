import XCTest

#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

final class AltitudeGaugeTests: XCTestCase {}

extension AltitudeGaugeTests {
    func testGaugeVerticalOffsetMaximum() {
        let gauge = AltitudeGauge(altitude: Altitude(meters: 0), viewHeight: 200)
        XCTAssertEqual(gauge.verticalOffset, 200)
    }
    
    func testGaugeVerticalOffsetMinimum() {
        let gauge = AltitudeGauge(altitude: Altitude(meters: 8848), viewHeight: 200)
        XCTAssertEqual(gauge.verticalOffset, 0)
    }
    
    func testGaugeVerticalOffset1() {
        let gauge = AltitudeGauge(altitude: Altitude(meters: 8848 / 2), viewHeight: 400)
        XCTAssertEqual(gauge.verticalOffset, 400 / 2)
    }
    
    func testGaugeVerticalOffset2() {
        let gauge = AltitudeGauge(altitude: Altitude(meters: 8848 / 4), viewHeight: 800)
        XCTAssertEqual(gauge.verticalOffset, 800 - (1 / 4 * 800))
    }
    
    func testGaugeVerticalOffsetRounding() {
        let gauge = AltitudeGauge(altitude: Altitude(meters: 8848 / 8), viewHeight: 800 - 1)
        XCTAssertEqual(gauge.verticalOffset, (7 / 8) * 800 - 1)
    }
}

extension AltitudeGaugeTests {
    func testGaugeThickness1() {
        let gauge = AltitudeGauge(viewHeight: 200)
        XCTAssertEqual(gauge.thickness, 1)
    }
    
    func testGaugeThickness2() {
        let gauge = AltitudeGauge(viewHeight: 400)
        XCTAssertEqual(gauge.thickness, 2)
    }
    
    func testGaugeThicknessRounding() {
        let gauge = AltitudeGauge(viewHeight: 100)
        XCTAssertEqual(gauge.thickness, 1)
    }
    
    func testGaugeThicknessMinimum1() {
        let gauge = AltitudeGauge(viewHeight: 1)
        XCTAssertEqual(gauge.thickness, 1)
    }
    
    func testGaugeThicknessMinimum2() {
        let gauge = AltitudeGauge(viewHeight: 2)
        XCTAssertEqual(gauge.thickness, 1)
    }
}

private extension AltitudeGauge {
    init(viewHeight: Double) {
        self = AltitudeGauge(altitude: .arbitrary, viewHeight: viewHeight)
    }
}

private extension Altitude {
    static let arbitrary = Altitude(meters: 0)
}
