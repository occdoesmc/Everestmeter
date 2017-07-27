import XCTest

final class EverestmeterUITests: XCTestCase {
    fileprivate let app = XCUIApplication()
}

extension EverestmeterUITests {
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

    func testAltitudeIsOnlyTextPresent() {
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
}

extension EverestmeterUITests {
    func testError() {
        app.launch()
        XCTAssertTrue(app.staticTexts["Barometer Not Available"].isHittable)
    }

    func testErrorIsOnlyTextPresent() {
        app.launch()
        XCTAssertEqual(app.staticTexts.count, 1)
    }

    func testBarometerError() {
        app.launchWithInvalidSimulatedPressure()
        XCTAssertTrue(app.staticTexts["Invalid Simulated Pressure"].isHittable)
    }

    func testBarometerErrorIsOnlyTextPresent() {
        app.launchWithInvalidSimulatedPressure()
        XCTAssertEqual(app.staticTexts.count, 1)
    }
}

private extension XCUIApplication {
    func launch(withSimulatedPressure simulatedPressure: Int) {
        launch(withSimulatedPressure: String(simulatedPressure))
    }

    func launchWithInvalidSimulatedPressure() {
        launch(withSimulatedPressure: "invalid")
    }

    func launch(withSimulatedPressure simulatedPressure: String) {
        launchEnvironment = ["SIMULATED_PRESSURE": simulatedPressure]
        launch()
    }
}
