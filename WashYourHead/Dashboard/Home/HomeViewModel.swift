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
        return washEventsService.getAllEvents().contains { Calendar.current.isDateInToday($0.date) == true }
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
        let startOfDay = Calendar.current.startOfDay(for: .now)
        let dateLastWashed = washEventsService.getAllEvents().sorted {
            $0.date < $1.date
        }.map {
            $0.date
        }.filter {
            $0 < startOfDay || Calendar.current.isDate($0, inSameDayAs: startOfDay)
        }.last
        
        guard let settings = settingsService.settings else {
            fatalError()
        }
        
        let scheduledWashes = washEventsService.getAllEvents().sorted {
            $0.date < $1.date
        }.filter {
            .now < $0.date
        }
        
        if let washingPeriod = settings.washingPeriod {
            let nextWashDateByPeriod = dateLastWashed.map {
                Calendar.current.date(
                   byAdding: .day,
                   value: washingPeriod,
                   to: $0
               )!
            }
            let nextWashDateSheduled = scheduledWashes.first?.date
            
            let nextWashDate: Date? = [
                nextWashDateByPeriod,
                nextWashDateSheduled
            ].compactMap {
                $0
            }.sorted {
                $0 < $1
            }.first
            
            if let nextWashDate {
                if nextWashDate < startOfDay {
                    if let nextWashDateSheduled {
                        body = "You should've washed your head on \(dayOfWeekString(from: nextWashDate)). Next wash date — \(dayOfWeekString(from: nextWashDateSheduled))"
                    } else {
                        body = "You should've washed your head on \(dayOfWeekString(from: nextWashDate))"
                    }
                } else {
                    body = "Next wash date — \(dayOfWeekString(from: nextWashDate))"
                }
            } else {
                body = "You haven't washed or scheduled head yet"
            }
        } else {
            if let scheduledWash = scheduledWashes.first {
                body = "Next wash date — \(dayOfWeekString(from: scheduledWash.date))"
            } else if let dateLastWashed {
                body = "You haven't scheduled wash yet. Last washing date — \(dayOfWeekString(from: dateLastWashed))"
            } else {
                body = "You haven't scheduled or washed head yet"
            }
        }
    }
    
    private func dayOfWeekString(from date: Date) -> String {
        guard Calendar.current.startOfDay(for: .now) != Calendar.current.startOfDay(for: date) else {
            return "Today"
        }
        
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
