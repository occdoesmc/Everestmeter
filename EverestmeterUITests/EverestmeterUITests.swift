import XCTest

final class EverestmeterUITests: XCTestCase {
    fileprivate let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
}

extension EverestmeterUITests {
    func testAltitude() {
        app.launch(withSimulatedPressure: 90)
        XCTAssertTrue(app.staticTexts["1014m"].isHittable)
    }

    func testOtherAltitude() {
        app.launch(withSimulatedPressure: 100)
        XCTAssertTrue(app.staticTexts["112m"].isHittable)
    }

    func testSingleStaticText() {
        app.launch(withSimulatedPressure: 100)
        XCTAssertEqual(app.staticTexts.count, 1)
    }

    func testStaticTextVerticalOffset() {
        app.launch(withSimulatedPressure: 100)
        let lower = app.staticTexts.element(boundBy: 0).frame.midY
        app.launch(withSimulatedPressure: 90)
        let higher = app.staticTexts.element(boundBy: 0).frame.midY
        XCTAssertGreaterThan(lower, higher)
    }

    func testError() {
        app.launch()
        XCTAssertTrue(app.staticTexts["Barometer Not Available"].isHittable)
    }

    func testErrorOnlyTextPresent() {
        app.launch()
        XCTAssertEqual(app.staticTexts.count, 1)
    }
}

private extension XCUIApplication {
    func launch(withSimulatedPressure simulatedPressure: Int) {
        launchEnvironment = ["SIMULATED_PRESSURE": String(simulatedPressure)]
        launch()
    }
}
