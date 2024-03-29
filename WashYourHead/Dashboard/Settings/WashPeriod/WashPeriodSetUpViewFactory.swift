//
//  WashPeriodSetUpViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import Foundation
import SwiftUI

final class WashPeriodSetUpViewFactory {
    @MainActor 
    func create() -> some View {
        guard let modelContext = WashYourHeadApp.modelContainer?.mainContext else {
            fatalError()
        }
        
        let settingsService = SettingsService(modelContext: modelContext)
        let viewModel = WashPeriodSetUpViewModel(settingsService: settingsService)
        let view = WashPeriodSetUpView(viewModel: viewModel)
        
        return view
    }
}
