//
//  CalendarViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Combine
import Foundation
import SwiftUI
import YourCalendar

@MainActor
final class CalendarViewModel: ObservableObject {
    
    // MARK: - Model
    
    enum ButtonStyle {
        case constructive
        case destructive
    }
    
    // MARK: - Properties
    
    @Published private(set) var title: String = ""
    
    var model: CalendarListView<CalendarViewDayCell, BasicCalendarViewConfigurator>.Model {
        return CalendarListView<CalendarViewDayCell, BasicCalendarViewConfigurator>.Model(
            date: .now,
            dateShifter: MonthlyCalendarViewDateShifter(),
            configurator: configurator
        )
    }
    
    @Published private(set) var buttonTitle: String = ""
    @Published private(set) var isButtonVisible: Bool = false
    @Published private(set) var buttonStyle: ButtonStyle = .constructive {
        didSet {
            switch buttonStyle {
            case .constructive:
                buttonTitle = "I washed my head this day"
            case .destructive:
                buttonTitle = "I didn't wash my head this day"
            }
        }
    }
        
    private lazy var configurator: BasicCalendarViewConfigurator = {
        let result = BasicCalendarViewConfigurator(enumerator: MonthlyCalendarViewDateEnumerator())
        result.set(markVisibilityPredicate: { [weak self] date in
            guard let self else { return false }
            
            return self.washingTookPlace(on: date)
        })
        
        return result
    }()
    
    private var currentMonth: Date = .now {
        didSet {
            updateTitle()
        }
    }
    
    private var onReloadHandler: (() -> ())?
    private let washEventsService: WashEventsServiceProtocol
    
    // MARK: - Initialisation
    
    init(washEventsService: WashEventsServiceProtocol) {
        self.washEventsService = washEventsService
        updateTitle()
    }
    
    // MARK: - Public
    
    func setOnReloadHandler(_ onReloadHandler: @escaping () -> ()) {
        self.onReloadHandler = onReloadHandler
    }
    
    func onDidAppear() {
        reload()
    }
    
    func onDayCellSelection(_ indexPath: IndexPath, _ date: Date) {
        if let date = configurator.date(fromBase: date, indexPath: indexPath), date.timeIntervalSinceNow <= 0 {
            configurator.set(selectedDay: date, resetIfSame: true)
            reload()
        }
    }
    
    func onButtonPress() {
        guard 
            let selectedDay = configurator.selectedDay
        else {
            return
        }
        
        let entries = washEventsService.getAllEvents().filter {
            selectedDay.isInSameDayAs($0.date)
        }
        
        if entries.isEmpty {
            washEventsService.addEvent(on: selectedDay, markCompleted: true)
        } else {
            washEventsService.removeEvent(selectedDay)
        }
        
        reload()
    }
    
    func onDecelerationDidEnd(_ date: Date) {
        currentMonth = date
    }
    
    // MARK: - Private
    
    private func updateTitle() {
        // Создаем объект DateFormatter
        let dateFormatter = DateFormatter()

        // Устанавливаем стиль вывода, который содержит только название месяца
        dateFormatter.dateFormat = "LLLL yyyy"

        // Преобразуем дату в строку с названием месяца
        title = dateFormatter.string(from: currentMonth)
    }
    
    private func washingTookPlace(on date: Date) -> Bool {
        return washEventsService.getAllEvents().contains { date.isInSameDayAs($0.date) }
    }
    
    private func reload() {
        if let selectedDay = configurator.selectedDay {
            isButtonVisible = true
            buttonStyle = washingTookPlace(on: selectedDay) ? .destructive : .constructive
        } else {
            isButtonVisible = false
        }
                
        onReloadHandler?()
    }
}
