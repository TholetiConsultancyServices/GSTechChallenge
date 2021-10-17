//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            TechChallengeApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct TechChallengeApp: App {

    private let dependencyProvider = DependencyProvider()
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionsViewFactory.makeTransactionsView(dependencyProvider: dependencyProvider)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsViewFactory.makeInsightsView(dependencyProvider: dependencyProvider)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
