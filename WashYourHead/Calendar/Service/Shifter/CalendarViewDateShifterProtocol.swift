//
//  Created by Dmitry Volosach on 10.03.2024.
//

import Foundation

/// Интерфейс алгоритма смещения опорной даты календаря
public protocol CalendarViewDateShifterProtocol: AnyObject {
    /// Смещает дату на заданное количество шагов
    /// - Parameters:
    ///   - date: Опорная дата
    ///   - steps: Количество шагов
    /// - Returns: Смещённая дата
    func date(byShiftingDate date: Date, byNumberOfSteps steps: Int) -> Date
}
