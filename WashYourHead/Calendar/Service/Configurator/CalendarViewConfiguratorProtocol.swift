//
//  Created by Dmitry Volosach on 10.03.2024.
//

import UIKit

/// Интерфейс конфигуратора страницы календаря
public protocol CalendarViewConfiguratorProtocol: AnyObject {
    /// Модель ячейки дня на странице
    associatedtype Model

    /// Конфигурирует страницу календаря
    /// - Parameter calendarView: Страница календаря
    /// - Parameter date: Опорная дата
    func configure<Cell: CalendarViewCellProtocol>(calendarView: CalendarPageView<Cell>, withBaseDate date: Date) where Cell.ModelType == Model
}
