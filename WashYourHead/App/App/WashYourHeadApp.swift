//
//  WashYourHeadApp.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI
import SwiftData

@main
@MainActor struct WashYourHeadApp: App {
    static let modelContainer: ModelContainer? = try? ModelContainer(
        for: SettingsEntityModel.self,
        WashEventEntity.self
    )
    
    private var hasWashPeriodBeenSetUp: Bool {
        guard let context = Self.modelContainer?.mainContext else { return false }
        
        let fetchDescriptor = FetchDescriptor<SettingsEntityModel>()
        if let settings = try? context.fetch(fetchDescriptor), !settings.isEmpty {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if hasWashPeriodBeenSetUp {
                DashboardViewFactory().create()
            } else {
                WashPeriodSetUpOnboardingViewFactory().create()
            }
        }
    }
}
