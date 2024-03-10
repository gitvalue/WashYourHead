//
//  CalendarViewDateEnumeratorProtocol.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

/// Интерфейс энумератора датам сетки календаря
/// sourcery: AutoMockable
protocol CalendarViewDateEnumeratorProtocol: AnyObject {
    /// Назначает дату-точку отсчёта
    /// - Parameter base: Дата-точка отсчёта
    func set(base: Date)

    /// Перемещается к следующему элементу
    /// - Returns: Следующий элемент последовательности
    func moveToNext() -> Date?

    /// Получает дату по индексу
    /// - Parameter index: Индекс
    func date(atIndex index: Int) -> Date?
}
