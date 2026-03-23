import Foundation
import os.log

// MARK: - Integrations Layer
//
// Third-party SDK wrappers live here.  Each SDK gets its own sub-folder.
// Swap implementations without touching Application or Domain code.

/// OSLog subsystem / category constants for consistent log taxonomy.
enum LogCategory {
    static let subsystem = "com.cashflowcoach"

    static let app        = "App"
    static let analytics  = "Analytics"
    static let data       = "Data"
    static let network    = "Network"
}

/// Thin analytics facade. PostHog (and RevenueCat events) are routed here.
/// Replace stub implementations once SDK credentials are configured via Env.
@MainActor
final class AnalyticsService {
    static let shared = AnalyticsService()

    private let logger = Logger(
        subsystem: LogCategory.subsystem,
        category: LogCategory.analytics
    )

    private init() {}

    func track(_ event: String, properties: [String: Any] = [:]) {
        logger.info("Event: \(event, privacy: .public) properties: \(properties.description, privacy: .private)")
        // TODO: forward to PostHog once credentials are loaded from Env
    }
}
