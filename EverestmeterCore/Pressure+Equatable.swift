#if os(macOS)
    @testable import EverestmeterDesktop
#else
    @testable import EverestmeterCore
#endif

extension Pressure: Equatable {
    public static func == (lhs: Pressure, rhs: Pressure) -> Bool {
        return lhs.kilopascals == rhs.kilopascals
    }
}
