//
//  HomeViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

@MainActor 
final class HomeViewModel: ObservableObject {
    
    // MARK: - Model
    
    enum ButtonStyle {
        case constructive
        case destructive
    }
    
    // MARK: - Properties
    
    @Published private(set) var body: String = ""
    
    var buttonText: String {
        washedToday ? "Didn't wash today" : "Washed today"
    }
    
    var buttonStyle: ButtonStyle {
        washedToday ? .destructive : .constructive
    }
    
    private var washedToday: Bool {
        if let dateLastWashed {
            return Calendar.current.isDateInToday(dateLastWashed)
        } else {
            return false
        }
    }
    
    private var dateLastWashed: Date? {
        return washEventsService.getAllEvents().sorted { $0.date < $1.date }.last?.date
    }
    
    private let washEventsService: WashEventsServiceProtocol
    private let settingsService: SettingsServiceProtocol
    
    // MARK: - Initialising
    
    init(washEventsService: WashEventsServiceProtocol, settingsService: SettingsServiceProtocol) {
        self.washEventsService = washEventsService
        self.settingsService = settingsService
        update()
    }
    
    // MARK: - Public
    
    func onDidAppear() {
        update()
    }
        
    func onButtonPress() {
        if washedToday {
            washEventsService.removeEvent(.now)
        } else {
            washEventsService.addEvent(on: .now, markCompleted: true)
        }
        
        update()
    }
    
    // MARK: - Private
        
    private func update() {
        let noHistoryBodyText = "You haven't marked washing yet"
        
        guard let dateLastWashed else {
            body = noHistoryBodyText
            return
        }
        
        guard let settings = settingsService.settings else {
            body = noHistoryBodyText
            return
        }
                
        // TODO: expired date case
        
        let nextWashDate = Calendar.current.date(
            byAdding: .day, 
            value: settings.washingPeriod,
            to: dateLastWashed
        )
        
        if let nextWashDate {
            body = "Next wash date — \(dayOfWeekString(from: nextWashDate))"
        } else {
            body = noHistoryBodyText
        }
    }
    
    private func dayOfWeekString(from date: Date) -> String {
        let formatStyle: Date.FormatStyle
        
        if Calendar.current.isDate(.now, equalTo: date, toGranularity: .weekOfMonth) {
            formatStyle = Date.FormatStyle().weekday(.wide)
        } else {
            formatStyle = Date.FormatStyle()
                .weekday()
                .day()
                .month()
        }
        
        return date.formatted(formatStyle)
    }
}
