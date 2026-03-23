import SwiftData
import SwiftUI
import os.log

@main
struct CashflowCoachApp: App {
    private let logger = Logger(subsystem: "com.cashflowcoach", category: "App")
    private let appModel: AppModel

    init() {
        let container = MainActor.assumeIsolated {
            do {
                return try PersistenceController.makeContainer()
            } catch {
                fatalError("ModelContainer failed to initialise: \(error)")
            }
        }
        appModel = MainActor.assumeIsolated { AppModel(container: container) }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appModel)
                .onAppear {
                    logger.info("App launched")
                    appModel.loadSessionState()
                }
        }
        .modelContainer(appModel.container)
    }
}
