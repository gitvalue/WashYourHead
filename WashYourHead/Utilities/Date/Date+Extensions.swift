//
//  Date+Extensions.swift
//  WashYourHead
//
//  Created by Admin on 29/03/2024.
//

import Foundation

extension Date {
    func isInSameDayAs(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}
