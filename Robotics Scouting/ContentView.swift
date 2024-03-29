//
//  ContentView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    var body: some View {
        if (networkMonitor.isConnected) {
            NavigationView {
                TabView {
                    Teams()
                        .tabItem {
                            Label("Teams", systemImage: "person.3")
                        }
                    TeamInfoInput()
                        .tabItem {
                            Label("Input", systemImage: "plus.square")
                        }
//                    Settings()
//                        .tabItem{
//                            Label("Settings", systemImage: "gearshape.fill")
//                        }
                }
            }
        } else {
            NoInternetView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
