//
//  Created by Dmitry Volosach on 10.03.2024.
//

import UIKit

/// Ячейка "дня" на странице календаря
public final class CalendarViewDayCell: UICollectionViewCell, CalendarViewCellProtocol {
    private lazy var label = UILabel()/*.with {
        $0.style = appearance.labelStyle
    }*/

    private lazy var markView = UIView().with {
        $0.layer.cornerRadius = appearance.markCornerRadius
        $0.backgroundColor = appearance.markColor
    }

    private lazy var backView = UIView().with {
        $0.layer.cornerRadius = appearance.backgroundViewCornerRadius
        $0.layer.borderWidth = appearance.backgroundViewBorderWidth
    }

    private let appearance = Appearance()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(model: Model) {
        label.textColor = model.style.color
        label.text = model.text
        markView.isHidden = model.isMarkHidden
        backView.backgroundColor = model.fillColor
        backView.layer.borderColor = model.strokeColor.cgColor
    }

    private func setupSubviews() {
        addSubview(backView)
        addSubview(label)
        addSubview(markView)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        markView.snp.makeConstraints { make in
            make.size.equalTo(appearance.markSize)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-appearance.markBottom)
        }

        backView.snp.makeConstraints { make in
            make.edges.equalTo(appearance.backgroundViewInsets)
        }
    }
}

// - MARK: Model

public extension CalendarViewDayCell {
    /// Стиль отображения текста
    enum Style {
        /// Будний день
        case weekday

        /// Выходной/праздничный день
        case holiday

        /// День вне текущей страницы
        case outOfBounds
    }

    struct Model {
        fileprivate let text: String
        fileprivate let style: Style
        fileprivate let isMarkHidden: Bool
        fileprivate let fillColor: UIColor
        fileprivate let strokeColor: UIColor

        /// Назначенный инициализатор
        /// - Parameters:
        ///   - text: Текст в ячейке
        ///   - style: Стиль отображения текста
        ///   - isMarkHidden: Признак того, что маркер спрятан
        ///   - fillColor: Цвет заполнения ячейки
        ///   - strokeColor: Цвет контура ячейки
        public init(text: String, style: Style, isMarkHidden: Bool, fillColor: UIColor, strokeColor: UIColor) {
            self.text = text
            self.style = style
            self.isMarkHidden = isMarkHidden
            self.fillColor = fillColor
            self.strokeColor = strokeColor
        }
    }
}

// MARK: - Appearance

private extension CalendarViewDayCell {
    struct Appearance {
        let markSize: CGSize = .init(width: 6.12, height: 6.12)
        var markCornerRadius: CGFloat { markSize.width * 0.5 }
        let markColor: UIColor = .brown
        let markBottom: CGFloat = 6.12
        let backgroundViewInsets: UIEdgeInsets = .init(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
        let backgroundViewCornerRadius: CGFloat = 4.0
        let backgroundViewBorderWidth: CGFloat = 1.0
    }
}

private extension CalendarViewDayCell.Style {
    var color: UIColor {
        switch self {
        case .weekday:
            return .black
        case .holiday:
            return .red
        case .outOfBounds:
            return .gray
        }
    }
}
