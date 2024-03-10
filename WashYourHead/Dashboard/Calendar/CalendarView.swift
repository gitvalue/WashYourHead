//
//  CalendarView.swift
//  WashYourHead
//
//  Created by Admin on 09/03/2024.
//

import SwiftUI
import SwiftUICalendar

struct CalendarView: View {
    
    // MARK: - Properties
    
    var body: some View {
        SwiftUICalendar.CalendarView() { date in
            Text("\(date.day)")
        }
    }
    
    @ObservedObject private var viewModel: CalendarViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
}
