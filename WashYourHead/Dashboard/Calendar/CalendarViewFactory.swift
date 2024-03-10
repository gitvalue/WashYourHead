//
//  CalendarViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 10/03/2024.
//

import SwiftData
import SwiftUI

final class CalendarViewFactory {
    
    // MARK: - Public
    
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = CalendarViewModel(lazyModelContext: lazyModelContext)
        let result = CalendarView(viewModel: viewModel)
        return result
    }
}
