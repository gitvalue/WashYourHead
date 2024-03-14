//
//  WashPeriodSetUpOnboardingView.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI

struct WashPeriodSetUpOnboardingView: View {
    var body: some View {
        NavigationSplitView {
            WashPeriodSetUpView(viewModel: contentViewModel)
            NavigationLink(destination: viewModel.continueNavigationLinkDestination) {
                Text(viewModel.continueButtonTitle)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
            }.background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding()
        } detail: {
            Text("xyu")
        }
    }
    
    @ObservedObject private var viewModel: WashPeriodSetUpOnboardingViewModel
    private let contentViewModel: WashPeriodSetUpViewModel
    
    init(
        viewModel: WashPeriodSetUpOnboardingViewModel,
        contentViewModel: WashPeriodSetUpViewModel
    ) {
        self.viewModel = viewModel
        self.contentViewModel = contentViewModel
    }
}
