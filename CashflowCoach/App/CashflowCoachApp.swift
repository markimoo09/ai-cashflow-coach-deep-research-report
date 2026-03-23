import SwiftUI
import os.log

@main
struct CashflowCoachApp: App {
    private let logger = Logger(subsystem: "com.cashflowcoach", category: "App")

    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    logger.info("App launched")
                }
        }
    }
}
