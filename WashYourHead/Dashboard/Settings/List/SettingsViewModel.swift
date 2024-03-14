//
//  SettingsViewModel.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
final class SettingsViewModel {
    
    // MARK: - Properties
    
    let washPeriodRowModel = SettingsRowModel(icon: "shower", title: "Wash period")
    var washingPeriodNavigationLinkDestination: some View {
        return WashPeriodSetUpViewFactory().create(withLazyModelContext: lazyModelContext)
    }
    
    let languageRowModel = SettingsRowModel(icon: "globe", title: "Language")
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
    
    // MARK: - Initialisers
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
    }
    
    // MARK: - Public
    
    func onLanguageRowPress() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
