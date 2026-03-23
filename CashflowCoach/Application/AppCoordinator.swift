import Foundation
import os.log

/// Application-layer coordinator. Owns top-level navigation state and
/// bootstraps services on launch. Replace placeholder stubs as features land.
@MainActor
@Observable
final class AppCoordinator {
    private let logger = Logger(subsystem: "com.cashflowcoach", category: "AppCoordinator")

    init() {
        logger.debug("AppCoordinator initialised")
    }
}
