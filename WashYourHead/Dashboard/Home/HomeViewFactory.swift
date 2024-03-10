//
//  HomeViewFactory.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import SwiftData
import SwiftUI

final class HomeViewFactory {
    @MainActor func create(withLazyModelContext lazyModelContext: @MainActor @escaping () -> (ModelContext?)) -> some View {
        let viewModel = HomeViewModel(lazyModelContext: lazyModelContext)
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
}
