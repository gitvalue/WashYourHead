//
//  UICollectionView+Extensions.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import UIKit

public extension UICollectionView {
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: String(describing: cellType))
    }

    final func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        cellType: T.Type = T.self
    ) -> T {
        let bareCell = dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(String(describing: cellType)) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly"
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    final func register<T: UICollectionReusableView>(
        supplementaryViewType: T.Type,
        ofKind elementKind: String
    ) {
        register(
            supplementaryViewType.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: String(describing: supplementaryViewType)
        )
    }

    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String,
        for indexPath: IndexPath,
        viewType: T.Type = T.self
    ) -> T {
        let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: String(describing: viewType),
            for: indexPath
        )
        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(String(describing: viewType)) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly"
                    + "and that you registered the supplementary view beforehand"
            )
        }
        return typedView
    }
}
