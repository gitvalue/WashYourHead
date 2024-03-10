//
//  MonthlyCalendarViewDateShifter.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

/// Стандартный алгоритм смещения опорной даты календаря (помесячно)
final class MonthlyCalendarViewDateShifter: CalendarViewDateShifterProtocol {
    /// Смещает дату на заданное количество месяцев
    /// - Parameters:
    ///   - date: Опорная дата
    ///   - steps: Количество шагов
    /// - Returns: Смещённая дата
    /// - Note: В случае если по каким-то причинами `Calendar.date(byAdding:value:to:)` вернёт `nil` то
    /// опорная дата смещена не будет.
    func date(byShiftingDate date: Date, byNumberOfSteps steps: Int) -> Date {
        var calendar = Calendar.current
//        calendar.locale = .russian

        return calendar.date(byAdding: .month, value: steps, to: date) ?? date
    }
}
