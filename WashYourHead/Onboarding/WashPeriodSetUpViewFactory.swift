//
//  WashPeriodSetUpViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import Foundation
import SwiftUI

final class WashPeriodSetUpViewFactory {
    func create() -> some View {
        let viewModel = WashPeriodSetUpOnboardingViewModel()
        let view = WashPeriodSetUpOnboardingView(viewModel: viewModel)
        
        return view
    }
}
