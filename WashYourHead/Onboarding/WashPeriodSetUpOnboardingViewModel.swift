//
//  WashPeriodSetUpOnboardingViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftData
import SwiftUI

@MainActor
final class WashPeriodSetUpOnboardingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let continueButtonTitle: String = "Продолжить"
    var continueNavigationLinkDestination: some View {
        DashboardViewFactory().create(withLazyModelContext: lazyModelContext)
    }
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
     
    // MARK: - Initialisers
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
    }
}
