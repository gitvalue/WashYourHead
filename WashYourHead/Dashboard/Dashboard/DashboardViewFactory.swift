//
//  DashboardViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftUI

final class DashboardViewFactory {
    
    // MARK: - Public
    
    @MainActor 
    func create() -> some View {
        let homeView = HomeViewFactory().create()
        let calendarView = CalendarViewFactory().create()
        let settingsView = SettingsViewFactory().create()
        
        return DashboardView(
            homeView: AnyView(homeView),
            calendarView: AnyView(calendarView),
            settingsView: AnyView(settingsView)
        )
    }
}
