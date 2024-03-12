//
//  CalendarUIViewRepresentable.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Combine
import SwiftUI
import YourCalendar

@MainActor
struct CalendarUIViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    private var cancellable: AnyCancellable?
    private let viewModel: CalendarViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let calendarListView = CalendarListView<CalendarViewDayCell, BasicCalendarViewConfigurator>(frame: .zero)
        calendarListView.update(model: viewModel.model)
        
        calendarListView.onDayCellSelection = { [weak viewModel] indexPath, date in
            viewModel?.onDayCellSelection(indexPath, date)
        }
        calendarListView.onDecelerationEnd = { [weak viewModel] date in
            viewModel?.onDecelerationDidEnd(date)
        }
            
        viewModel.setOnReloadHandler { [weak calendarListView] in
            calendarListView?.reload()
        }
        
        return calendarListView
    }
}
