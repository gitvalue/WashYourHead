//
//  WashEventsService.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftData

protocol WashEventsServiceProtocol: AnyObject {
    func getAllEvents() -> [WashEventEntity]
    func addEvent(on date: Date, markCompleted: Bool)
    func removeEvent(_ date: Date)
    func markEventCompleted(_ date: Date)
}

final class WashEventsService: WashEventsServiceProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllEvents() -> [WashEventEntity] {
        var fetchDescriptor = FetchDescriptor<WashEventEntity>()
        fetchDescriptor.includePendingChanges = true
        
        return (try? modelContext.fetch(fetchDescriptor)) ?? []
    }
        
    func addEvent(on date: Date, markCompleted: Bool) {
        var fetchDescriptor = FetchDescriptor<WashEventEntity>()
        fetchDescriptor.includePendingChanges = true
        
        let events = try? modelContext.fetch(fetchDescriptor).filter { $0.date.isInSameDayAs(date) }
        events?.forEach {
            modelContext.delete($0)
        }
        
        modelContext.insert(WashEventEntity(date: date, isCompleted: markCompleted))
        try? modelContext.save()
    }
    
    func removeEvent(_ date: Date) {
        var fetchDescriptor = FetchDescriptor<WashEventEntity>()
        fetchDescriptor.includePendingChanges = true
        
        guard
            let events = try? modelContext.fetch(fetchDescriptor).filter({ $0.date.isInSameDayAs(date) }),
            !events.isEmpty
        else {
            return
        }
        
        for event in events {
            modelContext.delete(event)
        }
    }
    
    func markEventCompleted(_ date: Date) {
        var fetchDescriptor = FetchDescriptor<WashEventEntity>()
        fetchDescriptor.includePendingChanges = true
        
        guard 
            let events = try? modelContext.fetch(fetchDescriptor).filter({ $0.date.isInSameDayAs(date) }),
            !events.isEmpty
        else {
            return
        }
        
        for event in events {
            modelContext.delete(event)
        }
        
        modelContext.insert(WashEventEntity(date: date, isCompleted: true))
        try? modelContext.save()
    }
}
