//
//  CalendarViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftUI

final class CalendarViewFactory {
    
    // MARK: - Public
    
    @MainActor func create() -> some View {
        guard let modelContext = WashYourHeadApp.modelContainer?.mainContext else {
            fatalError()
        }
        
        let washEventsService = WashEventsService(modelContext: modelContext)
        let viewModel = CalendarViewModel(washEventsService: washEventsService)
        
        return CalendarView(viewModel: viewModel)
    }
}
