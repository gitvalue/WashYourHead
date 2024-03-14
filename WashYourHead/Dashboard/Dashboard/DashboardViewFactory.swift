//
//  DashboardViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import SwiftData
import SwiftUI

final class DashboardViewFactory {
    
    // MARK: - Public
    
    @MainActor 
    func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let homeView = HomeViewFactory().create(withLazyModelContext: lazyModelContext)
        let calendarView = CalendarViewFactory().create(withLazyModelContext: lazyModelContext)
        let settingsView = SettingsViewFactory().create(withLazyModelContext: lazyModelContext)
        
        let view = DashboardView(
            homeView: AnyView(homeView),
            calendarView: AnyView(calendarView),
            settingsView: AnyView(settingsView)
        )
        return view
    }
}
