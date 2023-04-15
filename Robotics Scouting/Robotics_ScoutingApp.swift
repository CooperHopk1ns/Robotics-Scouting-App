//
//  Robotics_ScoutingApp.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

@main
struct Robotics_ScoutingApp: App {
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
