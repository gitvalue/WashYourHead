//
//  MonthlyCalendarEnumerator.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

/// Пространство имён констант модуля
enum Constants {
    /// Календарь
    static let calendar: Calendar = {
        var result = Calendar.current
//        result.locale = .russian

        return result
    }()

    /// Количество дней в неделе
    static let weekdaysCount = 7

    /// Продолжительность дня в секундах
    static let dayDuration: Int = 60 * 60 * 24
}

/// Стандартная реализация энумератора по датам сетки календаря
final class MonthlyCalendarViewDateEnumerator: CalendarViewDateEnumeratorProtocol {
    private let calendar = Constants.calendar
    private var base: Date?
    private var firstDayOfMonth: Date?
    private var firstDayOfMonthWeekdayIndex: Int?
    private var index: Int?

    private let weekdaysCount = Constants.weekdaysCount
    private let maxWeeksCount = 6

    func set(base: Date) {
        self.base = base

        var firstDayOfMonthComponents = calendar.dateComponents([.year, .month], from: base)
        firstDayOfMonthComponents.day = 1

        if let firstDayOfMonth = calendar.date(from: firstDayOfMonthComponents) {
            self.firstDayOfMonth = firstDayOfMonth

            let firstDayOfMonthWeekday = calendar.component(.weekday, from: firstDayOfMonth)
            let firstWeekday = calendar.firstWeekday
            let displacement = firstDayOfMonthWeekday - firstWeekday
            firstDayOfMonthWeekdayIndex = (weekdaysCount + displacement) % weekdaysCount
        }

        index = 0
    }

    func moveToNext() -> Date? {
        guard
            let index = index,
            index < weekdaysCount * maxWeeksCount,
            let day = date(atIndex: index)
        else {
            return nil
        }

        self.index? += 1

        return day
    }

    func date(atIndex index: Int) -> Date? {
        if let firstDayOfMonth = firstDayOfMonth, let firstDayOfMonthWeekdayIndex = firstDayOfMonthWeekdayIndex {
            return calendar.date(byAdding: .day, value: index - firstDayOfMonthWeekdayIndex, to: firstDayOfMonth)
        } else {
            return nil
        }
    }
}
