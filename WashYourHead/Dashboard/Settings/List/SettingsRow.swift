//
//  SettingsRow.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import SwiftUI

struct SettingsRow: View {
    
    // MARK: - Properties
    
    var body: some View {
        HStack {
            Image(systemName: model.icon)
            Text(model.title)
        }
    }
    
    private let model: SettingsRowModel
    
    // MARK: - Initialiser
    
    init(model: SettingsRowModel) {
        self.model = model
    }
}
