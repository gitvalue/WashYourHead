//
//  SettingsView.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    viewModel.washingPeriodNavigationLinkDestination
                } label: {
                    SettingsRow(model: viewModel.washPeriodRowModel)
                }
                NavigationLink {
                    
                } label: {
                    SettingsRow(model: viewModel.languageRowModel).onTapGesture {
                        viewModel.onLanguageRowPress()
                    }
                }
            }
            .navigationTitle("Settings")
        } detail: {
            Text("")
        }
    }
    
    private let viewModel: SettingsViewModel
    
    // MARK: - Initialisers
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
}
