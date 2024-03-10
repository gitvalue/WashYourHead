//
//  CalendarViewModel.swift
//  WashYourHead
//
//  Created by Admin on 10/03/2024.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

@MainActor
final class CalendarViewModel: ObservableObject {
    
    // MARK: - Properties
        
    private let lazyModelContext: @MainActor () -> (ModelContext?)
    
    // MARK: - Initialisation
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
    }
}
