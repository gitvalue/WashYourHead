//
//  CalendarUIViewRepresentable.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import SwiftUI

struct CalendarUIViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let viewModel: CalendarViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let calendarListView = CalendarListView<CalendarViewDayCell, CalendarViewConfigurator>(frame: .zero)
        calendarListView.update(model: viewModel.model)
        
        calendarListView.onDayCellSelection = { [weak viewModel, weak calendarListView] input in
            guard let viewModel, let calendarListView else { return }

            let (indexPath, date) = input

            viewModel.onDayCellSelection(indexPath, date)
            calendarListView.reload()
        }
        calendarListView.onDecelerationEnd = { [weak viewModel] date in
            viewModel?.onDecelerationDidEnd(date)
        }
        
        return calendarListView
    }
}
