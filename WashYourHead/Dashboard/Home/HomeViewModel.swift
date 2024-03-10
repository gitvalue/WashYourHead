//
//  HomeViewModel.swift
//  WashYourHead
//
//  Created by Admin on 10/03/2024.
//

import Foundation
import SwiftData

@MainActor 
final class HomeViewModel: ObservableObject {
    
    // MARK: - Model
    
    enum ButtonStyle {
        case constructive
        case destructive
    }
    
    // MARK: - Properties
    
    @Published private(set) var body: String = ""
    
    var buttonText: String {
        washedToday ? "Didn't wash today" : "Washed today"
    }
    
    var buttonStyle: ButtonStyle {
        washedToday ? .destructive : .constructive
    }
    
    private var washedToday: Bool {
        if let dateLastWashed {
            return Calendar.current.isDateInToday(dateLastWashed)
        } else {
            return false
        }
    }
    
    private var dateLastWashed: Date? {
        guard let context = lazyModelContext() else { return nil }
        
        var fetchDescriptor = FetchDescriptor<HistoryEntryEntityModel>(
            sortBy: [SortDescriptor<HistoryEntryEntityModel>(\.date)]
        )
        fetchDescriptor.includePendingChanges = true

        return try? context.fetch(fetchDescriptor).last?.date
    }
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
    
    // MARK: - Initialising
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
        update()
    }
    
    // MARK: - Public
        
    func onButtonPress() {
        guard let context = lazyModelContext() else { return }
                
        if washedToday {
            var fetchDescriptor = FetchDescriptor<HistoryEntryEntityModel>()
            fetchDescriptor.includePendingChanges = true

            try? context.fetch(fetchDescriptor).filter {
                Calendar.current.isDateInToday($0.date)
            }.forEach {
                context.delete($0)
            }
        } else {
            context.insert(HistoryEntryEntityModel(date: .now))
        }
        
        try? context.save()
        
        update()
    }
    
    // MARK: - Private
        
    private func update() {
        let noHistoryBodyText = "You haven't marked washing yet"
        
        guard let dateLastWashed else {
            body = noHistoryBodyText
            return
        }
        
        var settingsFetchDescriptor = FetchDescriptor<SettingsEntityModel>()
        settingsFetchDescriptor.includePendingChanges = true
        
        guard let settings = try? lazyModelContext()?.fetch(settingsFetchDescriptor).first else {
            body = noHistoryBodyText
            return
        }
                
        // TODO: expired date case
        
        let nextWashDate = Calendar.current.date(
            byAdding: .day, 
            value: settings.washingPeriod,
            to: dateLastWashed
        )
        
        if let nextWashDate {
            body = "Next wash date — \(dayOfWeekString(from: nextWashDate))"
        } else {
            body = noHistoryBodyText
        }
    }
    
    private func dayOfWeekString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
