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
            Text(viewModel.header)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top, 50.0)
                .padding(.horizontal, 16.0)
            Spacer()
            VStack {
                Text(viewModel.sliderTitle)
                    .font(.title2)
                Slider(
                    value: $viewModel.sliderValue,
                    in: viewModel.sliderRange,
                    step: viewModel.sliderStep,
                    label: {
                        Text("")
                    }, minimumValueLabel: {
                        Text(viewModel.sliderLowerBound)
                    }, maximumValueLabel: {
                        Text(viewModel.sliderUpperBound)
                    }).padding()
            }
            Spacer()
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
    
    init(viewModel: WashPeriodSetUpOnboardingViewModel) {
        self.viewModel = viewModel
    }
}
