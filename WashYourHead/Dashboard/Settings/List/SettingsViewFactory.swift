//
//  SettingsViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import SwiftData
import SwiftUI

final class SettingsViewFactory {
    @MainActor
    func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = SettingsViewModel(lazyModelContext: lazyModelContext)
        let view = SettingsView(viewModel: viewModel)
        
        return view
    }
}
