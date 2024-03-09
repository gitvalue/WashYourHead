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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    DashboardView()
}
