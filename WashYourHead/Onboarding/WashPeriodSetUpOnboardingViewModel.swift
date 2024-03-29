//
//  WashPeriodSetUpOnboardingViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import Foundation
import SwiftUI

@MainActor
final class WashPeriodSetUpOnboardingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let continueButtonTitle: String = "Продолжить"
    var continueNavigationLinkDestination: some View {
        DashboardViewFactory().create()
    }    
}
