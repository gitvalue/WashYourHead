//
//  WashPeriodSetUpViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import SwiftData
import SwiftUI

final class WashPeriodSetUpViewFactory {
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = WashPeriodSetUpViewModel(lazyModelContext: lazyModelContext)
        let view = WashPeriodSetUpView(viewModel: viewModel)
        
        return view
    }
}
