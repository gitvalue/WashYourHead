//
//  WashYourHeadApp.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftUI
import SwiftData

@main
struct WashYourHeadApp: App {
    var body: some Scene {
        WindowGroup {
            WashPeriodSetUpViewFactory().create()
        }
    }
}
