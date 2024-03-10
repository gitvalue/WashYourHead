//
//  CalendarViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

@MainActor
final class CalendarViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var title: String = ""
    
    var model: CalendarListView<CalendarViewDayCell, CalendarViewConfigurator>.Model {
        return CalendarListView<CalendarViewDayCell, CalendarViewConfigurator>.Model(
            date: currentMonth,
            dateShifter: MonthlyCalendarViewDateShifter(),
            configurator: configurator
        )
    }
    
    @Published private(set) var isButtonVisible: Bool = false
        
    private lazy var configurator: CalendarViewConfigurator = {
        let result = CalendarViewConfigurator(enumerator: MonthlyCalendarViewDateEnumerator())
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
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
    
    // MARK: - Initialisation
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
        updateTitle()
    }
    
    // MARK: - Public
    
    func onDayCellSelection(_ indexPath: IndexPath, _ date: Date) {
        if let date = configurator.date(fromBase: date, indexPath: indexPath) {
            configurator.set(selectedDay: date, resetIfSame: true)
            isButtonVisible = washingTookPlace(on: date)
        }
    }
    
    func onDecelerationDidEnd(_ date: Date) {
        currentMonth = date
    }
    
    // MARK: - Private
    
    private func updateTitle() {
        // Создаем объект DateFormatter
        let dateFormatter = DateFormatter()

        // Устанавливаем стиль вывода, который содержит только название месяца
        dateFormatter.dateFormat = "LLLL"

        // Преобразуем дату в строку с названием месяца
        title = dateFormatter.string(from: currentMonth)
    }
    
    private func washingTookPlace(on date: Date) -> Bool {
        guard let context = lazyModelContext() else { return false }
        
        var fetchDescriptor = FetchDescriptor<HistoryEntryEntityModel>()
        fetchDescriptor.includePendingChanges = true
        
        if let entries = try? context.fetch(fetchDescriptor),
            entries.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            return true
        } else {
            return false
        }
    }
}
