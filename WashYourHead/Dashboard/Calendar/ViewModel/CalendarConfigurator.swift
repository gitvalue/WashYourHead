//
//  CalendarConfigurator.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import UIKit



/// Стандартная реализация конфигуратора страницы календаря
final class CalendarViewConfigurator: CalendarViewConfiguratorProtocol {
    // Модель предиката, т.е. некоторого условия, которое можно вычислить по дате
    typealias Predicate = (Date) -> Bool

    typealias Model = CalendarViewDayCell.Model

    private var formatter = DateFormatter().with {
        $0.dateFormat = "d"
    }

    private lazy var holidayPredicate: Predicate = { [weak self] date in
        self?.calendar.isDateInWeekend(date) == true
    }

    private lazy var markVisibilityPredicate: Predicate = { _ in false }

    private let dateEnumerator: CalendarViewDateEnumeratorProtocol

    private lazy var calendar: Calendar = {
        var result = Calendar.current
//        result.locale = .russian

        return result
    }()

    private let weekdaysCount = 7

    private lazy var firstWeekdayIndex = calendar.firstWeekday - 1

    private lazy var weekdays = (firstWeekdayIndex..<firstWeekdayIndex + weekdaysCount).map {
        (calendar.shortWeekdaySymbols[safe: $0 % weekdaysCount] ?? "").uppercased()
    }

    private var selectedDay: Date?

    /// Назначенный инициализатор
    init(enumerator: CalendarViewDateEnumeratorProtocol) {
        dateEnumerator = enumerator
    }

    /// Устанавливает преобразование дата -> текст в ячейке
    /// - Parameter formatter: Преобразователь даты в текст на ячейке
    func set(formatter: DateFormatter) {
        self.formatter = formatter
    }

    /// Устанавливает предикат выходного/праздничного дня
    /// - Parameter holidayPredicate: Предикат выходного/праздничного дня
    func set(holidayPredicate: @escaping Predicate) {
        self.holidayPredicate = holidayPredicate
    }

    /// Устанавливает предикат видимости маркера
    /// - Parameter markVisibilityPredicate: Предикат видимости маркера
    func set(markVisibilityPredicate: @escaping Predicate) {
        self.markVisibilityPredicate = markVisibilityPredicate
    }

    /// Устанавливает выбранный день
    /// - Parameter date: Дата, соответствущая выбранному дню
    /// - Parameter resetIfSame: Признак того, что выбор нужно сбросить если текущий выбранный день совпадает с новым
    func set(selectedDay date: Date?, resetIfSame: Bool) {
        if resetIfSame, let currentSelection = selectedDay, let date = date, calendar.isDate(date, inSameDayAs: currentSelection) {
            selectedDay = nil
        } else {
            selectedDay = date
        }
    }

    /// Вычисляет дату по координатам дня в сетке и опорной дате
    /// - Parameters:
    ///   - date: Опорная дата
    ///   - indexPath: Координаты дня в сетке страницы
    /// - Returns: Дата для ячейки на странице
    func date(fromBase date: Date, indexPath: IndexPath) -> Date? {
        dateEnumerator.set(base: date)
        let index = indexPath.section * weekdaysCount + indexPath.row

        return dateEnumerator.date(atIndex: index)
    }

    func configure<Cell>(calendarView: CalendarPageView<Cell>, withBaseDate date: Date) where Cell: CalendarViewCellProtocol, Cell.ModelType == Model {
        let dateComponents = calendar.dateComponents([.year, .month], from: date)

        dateEnumerator.set(base: date)

        var days: [Model] = []

        while let day = dateEnumerator.moveToNext() {
            let dayComponents = calendar.dateComponents([.month], from: day)
            let text = formatter.string(from: day)
            let isWeekend = holidayPredicate(day)

            let style: CalendarViewDayCell.Style

            if dayComponents.month != dateComponents.month {
                style = .outOfBounds
            } else if isWeekend {
                style = .holiday
            } else {
                style = .weekday
            }

            let fillColor: UIColor = calendar.isDate(day, inSameDayAs: Date()) ? .yellow : .clear
            let isSelected: Bool? = selectedDay.map { calendar.isDate(day, inSameDayAs: $0) }
            let strokeColor: UIColor = isSelected == true ? .gray : .clear

            let model = Model(
                text: text,
                style: style,
                isMarkHidden: !markVisibilityPredicate(day),
                fillColor: fillColor,
                strokeColor: strokeColor
            )

            days.append(model)
        }

        calendarView.update(
            model: .init(
                weekdays: weekdays,
                days: days,
                rowSpacing: 0.0,
                columnSpacing: 0.0
            )
        )
    }
}
