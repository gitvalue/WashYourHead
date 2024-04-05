//
//  WashPeriodSetUpView.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import SwiftUI

struct WashPeriodSetUpView: View {
    
    // MARK: - Properties
    
    var body: some View {
        Text(viewModel.header)
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(.top, 50.0)
            .padding(.horizontal, 16.0)
        VStack {
            Toggle(isOn: $viewModel.isSwitchOn) {
                Text(viewModel.sliderTitle)
            }.padding(.horizontal, 16.0)
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
                }).padding(.horizontal, 16.0)
        }
        Spacer()
    }
    
    @ObservedObject private var viewModel: WashPeriodSetUpViewModel
    
    // MARK: - Initialisers
    
    init(viewModel: WashPeriodSetUpViewModel) {
        self.viewModel = viewModel
    }
}
