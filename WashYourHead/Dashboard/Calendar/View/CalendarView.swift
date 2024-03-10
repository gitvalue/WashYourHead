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
        if viewModel.isButtonVisible {
            Button {
                
            } label: {
                Text("Button")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
            }.background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding()
        }
    }
    
    @ObservedObject private var viewModel: CalendarViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
}
