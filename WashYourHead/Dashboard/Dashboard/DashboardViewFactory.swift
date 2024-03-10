//
//  DashboardViewFactory.swift
//  WashYourHead
//
//  Created by Admin on 10/03/2024.
//

import SwiftData
import SwiftUI

final class DashboardViewFactory {
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let homeView = HomeViewFactory().create(withLazyModelContext: lazyModelContext)
        
        let view = DashboardView(
            homeView: AnyView(homeView),
            calendarView: AnyView(CalendarView()),
            settingsView: AnyView(SettingsView())
        )
        return view
    }
}
