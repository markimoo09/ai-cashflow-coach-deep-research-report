import SwiftUI

/// Placeholder home screen — replace with real feature views.
struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.tint)

            Text("CashflowCoach")
                .font(.largeTitle.bold())

            Text("Your local-first cash-flow companion.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
