//
//  WashPeriodSetUpOnboardingViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftData
import SwiftUI

final class WashPeriodSetUpOnboardingViewFactory {
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = WashPeriodSetUpOnboardingViewModel(lazyModelContext: lazyModelContext)
        let contentViewModel = WashPeriodSetUpViewModel(lazyModelContext: lazyModelContext)
        let view = WashPeriodSetUpOnboardingView(
            viewModel: viewModel,
            contentViewModel: contentViewModel
        )
        
        return view
    }
}
