//
//  CalendarView.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI
import SwiftUICalendar

struct CalendarView: View {
    
    // MARK: - Properties
    
    var body: some View {
        Text(viewModel.title)
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(10)
        CalendarUIViewRepresentable(viewModel: viewModel)
            .padding(10)
            .onAppear {
                viewModel.onDidAppear()
            }
        if viewModel.isButtonVisible {
            Button {
                viewModel.onButtonPress()
            } label: {
                Text(viewModel.buttonTitle)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
            }.background(buttonColor)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding()
        }
    }
    
    private var buttonColor: Color {
        switch viewModel.buttonStyle {
        case .constructive:
            return .blue
        case .destructive:
            return .red
        }
    }
    
    @ObservedObject private var viewModel: CalendarViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
}
