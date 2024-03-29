//
//  HomeViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftUI

final class HomeViewFactory {
    @MainActor func create() -> some View {
        guard let modelContext = WashYourHeadApp.modelContainer?.mainContext else {
            fatalError()
        }
        
        let washEventsService = WashEventsService(modelContext: modelContext)
        let settingsService = SettingsService(modelContext: modelContext)
        let viewModel = HomeViewModel(
            washEventsService: washEventsService,
            settingsService: settingsService
        )
        
        return HomeView(viewModel: viewModel)
    }
}
