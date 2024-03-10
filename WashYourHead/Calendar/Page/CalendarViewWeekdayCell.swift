//
//  Created by Dmitry Volosach on 10.03.2024.
//

import SnapKit
import UIKit

/// Ячейка, отображающая название дня недели на странице календаря
public final class CalendarViewWeekdayCell: UICollectionViewCell, CalendarViewCellProtocol {
    private lazy var label = UILabel()/*.with {
        $0.style = appearance.labelStyle
    }*/

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

    public func update(model: String) {
        label.text = model
    }

    private func setupSubviews() {
        addSubview(label)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Appearance

private extension CalendarViewWeekdayCell {
    struct Appearance {
//        let labelStyle = TextStyle.smallCaps.set(color: .abm_darkIndigoFlat60)
    }
}
