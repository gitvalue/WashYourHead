//
//  DashboardView.swift
//  WashYourHead
//
//  Created by Admin on 09/03/2024.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            VStack {
                homeView
            }.tabItem {
                Label("Home", systemImage: "house")
            }
            VStack {
                calendarView
            }.tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            VStack {
                settingsView
            }.tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }.navigationBarBackButtonHidden()
    }
    
    private let homeView: AnyView
    private let calendarView: AnyView
    private let settingsView: AnyView
        
    init(homeView: AnyView, calendarView: AnyView, settingsView: AnyView) {
        self.homeView = homeView
        self.calendarView = calendarView
        self.settingsView = settingsView
    }
}
