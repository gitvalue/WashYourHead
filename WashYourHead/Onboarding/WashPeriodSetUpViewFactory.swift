//
//  WashPeriodSetUpViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftData
import SwiftUI

final class WashPeriodSetUpViewFactory {
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = WashPeriodSetUpOnboardingViewModel(lazyModelContext: lazyModelContext)
        let view = WashPeriodSetUpOnboardingView(viewModel: viewModel)
        
        return view
    }
}
