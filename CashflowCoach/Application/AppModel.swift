import Foundation
import SwiftData
import os.log

// MARK: - AppModel

@MainActor
@Observable
final class AppModel {
    private let logger = Logger(subsystem: LogCategory.subsystem, category: LogCategory.data)

    // Persistence
    let container: ModelContainer

    // Repositories
    let profiles: any UserProfileRepository
    let accounts: any CashAccountRepository
    let incomes: any IncomeScheduleRepository
    let obligations: any RecurringObligationRepository
    let ledger: any LedgerEntryRepository
    let forecasts: any ForecastSnapshotRepository
    let scenarios: any ScenarioRepository
    let reminders: any ReminderPreferenceRepository

    // Session state — observed by SwiftUI screens
    var hasCompletedOnboarding = false
    var isLoading = false
    var activeScenarioID: UUID?

    init(container: ModelContainer) {
        self.container = container
        let ctx = container.mainContext
        profiles = SwiftDataUserProfileRepository(context: ctx)
        accounts = SwiftDataCashAccountRepository(context: ctx)
        incomes = SwiftDataIncomeScheduleRepository(context: ctx)
        obligations = SwiftDataRecurringObligationRepository(context: ctx)
        ledger = SwiftDataLedgerEntryRepository(context: ctx)
        forecasts = SwiftDataForecastSnapshotRepository(context: ctx)
        scenarios = SwiftDataScenarioRepository(context: ctx)
        reminders = SwiftDataReminderPreferenceRepository(context: ctx)
        logger.debug("AppModel initialised")
    }

    func loadSessionState() {
        guard let profile = try? profiles.fetchProfile() else { return }
        hasCompletedOnboarding = profile.onboardingCompleted
    }
}
