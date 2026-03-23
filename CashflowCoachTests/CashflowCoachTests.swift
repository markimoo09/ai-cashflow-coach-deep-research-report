import Foundation
import SwiftData
import Testing
@testable import CashflowCoach

// MARK: - Empty-Store Bootstrap

@Suite("Persistence — empty store bootstrap")
@MainActor
struct EmptyStoreTests {
    var container: ModelContainer

    init() throws {
        container = try PersistenceController.makeInMemoryContainer()
    }

    @Test("Fresh store has no user profile")
    func noProfileOnBootstrap() throws {
        let repo = SwiftDataUserProfileRepository(context: container.mainContext)
        let profile = try repo.fetchProfile()
        #expect(profile == nil)
    }

    @Test("Fresh store has no accounts")
    func noAccountsOnBootstrap() throws {
        let repo = SwiftDataCashAccountRepository(context: container.mainContext)
        let accounts = try repo.fetchAll()
        #expect(accounts.isEmpty)
    }

    @Test("Fresh store has no obligations")
    func noObligationsOnBootstrap() throws {
        let repo = SwiftDataRecurringObligationRepository(context: container.mainContext)
        let obligations = try repo.fetchAll()
        #expect(obligations.isEmpty)
    }

    @Test("Fresh store has no ledger entries")
    func noLedgerEntriesOnBootstrap() throws {
        let repo = SwiftDataLedgerEntryRepository(context: container.mainContext)
        let entries = try repo.fetchAll()
        #expect(entries.isEmpty)
    }

    @Test("Fresh store has no scenarios")
    func noScenariosOnBootstrap() throws {
        let repo = SwiftDataScenarioRepository(context: container.mainContext)
        let scenarios = try repo.fetchAll()
        #expect(scenarios.isEmpty)
    }
}

// MARK: - Seeded Store Round-trip

@Suite("Persistence — seeded store CRUD")
@MainActor
struct SeededStoreTests {
    var container: ModelContainer
    var ctx: ModelContext

    init() throws {
        container = try PersistenceController.makeInMemoryContainer()
        ctx = container.mainContext
    }

    @Test("UserProfile upsert and fetch round-trip")
    func userProfileRoundTrip() throws {
        let repo = SwiftDataUserProfileRepository(context: ctx)
        let original = UserProfileDTO(
            id: UUID(),
            name: "Alice",
            createdAt: .now,
            onboardingCompleted: false
        )

        try repo.upsert(original)
        let fetched = try repo.fetchProfile()
        #expect(fetched?.id == original.id)
        #expect(fetched?.name == "Alice")
        #expect(fetched?.onboardingCompleted == false)

        var updated = original
        updated.onboardingCompleted = true
        try repo.upsert(updated)

        let refetched = try repo.fetchProfile()
        #expect(refetched?.onboardingCompleted == true)
    }

    @Test("CashAccount upsert, fetch-active, and delete")
    func cashAccountCRUD() throws {
        let repo = SwiftDataCashAccountRepository(context: ctx)
        let dto = CashAccountDTO(
            id: UUID(),
            name: "Main Checking",
            accountType: .checking,
            balanceCents: 50_000,
            currencyCode: "USD",
            institution: "First Bank",
            isActive: true,
            createdAt: .now,
            sortOrder: 0
        )

        try repo.upsert(dto)
        let active = try repo.fetchActive()
        #expect(active.count == 1)
        #expect(active.first?.name == "Main Checking")
        #expect(active.first?.balanceCents == 50_000)
        #expect(active.first?.accountType == .checking)

        try repo.delete(id: dto.id)
        #expect((try repo.fetchAll()).isEmpty)
    }

    @Test("IncomeSchedule round-trip preserves frequency")
    func incomeScheduleFrequency() throws {
        let repo = SwiftDataIncomeScheduleRepository(context: ctx)
        let dto = IncomeScheduleDTO(
            id: UUID(),
            name: "Salary",
            amountCents: 5_000_00,
            frequency: .biweekly,
            customFrequencyDays: 0,
            nextPayDate: .now,
            isActive: true,
            createdAt: .now,
            accountID: nil
        )

        try repo.upsert(dto)
        let fetched = try repo.fetchActive()
        #expect(fetched.first?.frequency == .biweekly)
        #expect(fetched.first?.amountCents == 5_000_00)
    }

    @Test("RecurringObligation upsert and fetch")
    func recurringObligationRoundTrip() throws {
        let repo = SwiftDataRecurringObligationRepository(context: ctx)
        let dto = RecurringObligationDTO(
            id: UUID(),
            name: "Rent",
            amountCents: 1_500_00,
            frequency: .monthly,
            customFrequencyDays: 0,
            nextDueDate: .now,
            category: "Housing",
            isFixed: true,
            isActive: true,
            createdAt: .now,
            accountID: nil
        )

        try repo.upsert(dto)
        let active = try repo.fetchActive()
        #expect(active.first?.name == "Rent")
        #expect(active.first?.category == "Housing")
        #expect(active.first?.isFixed == true)
    }

    @Test("LedgerEntry date-range filter")
    func ledgerEntryDateRange() throws {
        let repo = SwiftDataLedgerEntryRepository(context: ctx)
        let now = Date.now
        let yesterday = now.addingTimeInterval(-86400)
        let twoDaysAgo = now.addingTimeInterval(-172800)

        let recent = LedgerEntryDTO(
            id: UUID(), amountCents: -1000, date: now,
            note: "Coffee", category: "Food", entryType: .expense, createdAt: now
        )
        let old = LedgerEntryDTO(
            id: UUID(), amountCents: -2000, date: twoDaysAgo,
            note: "Groceries", category: "Food", entryType: .expense, createdAt: twoDaysAgo
        )
        try repo.upsert(recent)
        try repo.upsert(old)

        let inRange = try repo.fetchInRange(from: yesterday, to: now)
        #expect(inRange.count == 1)
        #expect(inRange.first?.note == "Coffee")
    }

    @Test("ForecastSnapshot insert and fetchLatest")
    func forecastSnapshotRoundTrip() throws {
        let repo = SwiftDataForecastSnapshotRepository(context: ctx)
        let dto = ForecastSnapshotDTO(
            id: UUID(),
            snapshotDate: .now,
            projectedBalanceCents: 10_000_00,
            horizonDays: 30,
            generatedAt: .now,
            scenarioID: nil
        )

        try repo.insert(dto)
        let latest = try repo.fetchLatest(limit: 5)
        #expect(latest.count == 1)
        #expect(latest.first?.projectedBalanceCents == 10_000_00)

        try repo.deleteAll()
        #expect((try repo.fetchLatest(limit: 5)).isEmpty)
    }

    @Test("Scenario upsert and fetchActive")
    func scenarioRoundTrip() throws {
        let repo = SwiftDataScenarioRepository(context: ctx)
        let dto = ScenarioDTO(
            id: UUID(),
            name: "Best Case",
            scenarioDescription: "Optimistic projection",
            createdAt: .now,
            isActive: true
        )

        try repo.upsert(dto)
        let active = try repo.fetchActive()
        #expect(active.first?.name == "Best Case")
        #expect(active.first?.scenarioDescription == "Optimistic projection")
    }

    @Test("ReminderPreference round-trip preserves type and enabled state")
    func reminderPreferenceRoundTrip() throws {
        let repo = SwiftDataReminderPreferenceRepository(context: ctx)
        let dto = ReminderPreferenceDTO(
            id: UUID(),
            reminderType: .paymentDue,
            daysBeforeEvent: 5,
            isEnabled: true,
            obligationID: nil
        )

        try repo.upsert(dto)
        let enabled = try repo.fetchEnabled()
        #expect(enabled.count == 1)
        #expect(enabled.first?.reminderType == .paymentDue)
        #expect(enabled.first?.daysBeforeEvent == 5)
    }

    @Test("Seeded AppModel loads session state from profile")
    func appModelSessionState() throws {
        let model = AppModel(container: container)
        #expect(model.hasCompletedOnboarding == false)

        let profileDTO = UserProfileDTO(
            id: UUID(), name: "Bob", createdAt: .now, onboardingCompleted: true
        )
        try model.profiles.upsert(profileDTO)
        model.loadSessionState()
        #expect(model.hasCompletedOnboarding == true)
    }
}
