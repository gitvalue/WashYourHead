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
    private let modelContainer: ModelContainer? = try? ModelContainer(
        for: SettingsEntityModel.self, HistoryEntryEntityModel.self
    )
    
    private var hasWashPeriodBeenSetUp: Bool {
        guard let context =  modelContainer?.mainContext else { return false }
        
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
                DashboardViewFactory().create {
                    return modelContainer?.mainContext
                }
            }
            else {
                WashPeriodSetUpViewFactory().create {
                    return modelContainer?.mainContext
                }
            }
        }
    }
}
