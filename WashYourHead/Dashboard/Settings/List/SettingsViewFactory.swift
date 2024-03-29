//
//  SettingsViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import Foundation
import SwiftUI

final class SettingsViewFactory {
    @MainActor
    func create() -> some View {
        let viewModel = SettingsViewModel()
        let view = SettingsView(viewModel: viewModel)
        
        return view
    }
}
