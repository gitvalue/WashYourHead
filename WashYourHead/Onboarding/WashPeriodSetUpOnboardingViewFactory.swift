//
//  WashPeriodSetUpOnboardingViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import Foundation
import SwiftUI

final class WashPeriodSetUpOnboardingViewFactory {
    @MainActor func create() -> some View {
        guard let modelContext = WashYourHeadApp.modelContainer?.mainContext else {
            fatalError()
        }
        
        let viewModel = WashPeriodSetUpOnboardingViewModel()
        let settingsService = SettingsService(modelContext: modelContext)
        let contentViewModel = WashPeriodSetUpViewModel(settingsService: settingsService)
        let view = WashPeriodSetUpOnboardingView(
            viewModel: viewModel,
            contentViewModel: contentViewModel
        )
        
        return view
    }
}
