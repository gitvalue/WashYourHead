//
//  Created by Dmitry Volosach on 10.03.2024.
//

import UIKit

/// Ячейка со страницей календаря
final class CalendarListViewCell<DayCell: CalendarViewCellProtocol, Configurator: CalendarViewConfiguratorProtocol>: UICollectionViewCell where Configurator.Model == DayCell.ModelType {
    private lazy var calendarView = CalendarPageView<DayCell>().with {
        $0.onCellSelection = { [weak self] indexPath in
            guard let self = self, let date = self.date else { return }

            self.onDayCellSelection?((indexPath, date))
        }
    }

    private var date: Date?
    private var onDayCellSelection: Handler<(IndexPath, Date)>?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Получает координаты и размер ячейки
    /// - Parameter indexPath: Номер строки и столбца
    /// - Parameter view: Вью, к координатному пространству которой будет преобразован результат
    /// - Returns: Координаты и размер ячейки
    func frameForItem(atIndexPath indexPath: IndexPath, relativeToView view: UIView?) -> CGRect? {
        return calendarView.frameForItem(atIndexPath: indexPath, relativeToView: view)
    }

    func update(model: Model) {
        model.configurator.configure(calendarView: calendarView, withBaseDate: model.date)
        date = model.date
        onDayCellSelection = model.onDayCellSelection
    }

    private func setupSubviews() {
        addSubview(calendarView)
    }

    private func setupConstraints() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Model

extension CalendarListViewCell {
    struct Model {
        fileprivate let configurator: Configurator
        fileprivate let date: Date
        fileprivate let onDayCellSelection: Handler<(IndexPath, Date)>?

        /// Назначенный инициализатор
        /// - Parameters:
        ///   - configurator: Конфигуратор страницы
        ///   - date: Опорная дата страницы
        ///   - onDayCellSelection: Обработчик события выбора дня в формате <координаты дня в сетке страницы, опорная дата страницы>
        init(configurator: Configurator, date: Date, onDayCellSelection: Handler<(IndexPath, Date)>?) {
            self.configurator = configurator
            self.date = date
            self.onDayCellSelection = onDayCellSelection
        }
    }
}
