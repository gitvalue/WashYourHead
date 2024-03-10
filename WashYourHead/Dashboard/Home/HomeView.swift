//
//  HomeView.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Spacer()
        Text(viewModel.body)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
        Button {
            viewModel.onButtonPress()
        } label: {
            Text(viewModel.buttonText)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.white)
        }.background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .padding()
        Spacer()
    }
    
    private var buttonColor: Color {
        switch viewModel.buttonStyle {
        case .constructive:
            return .blue
        case .destructive:
            return .red
        }
    }
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}
