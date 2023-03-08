//
//  Settings.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            // Testing API button
            // Remove before app release
            VStack {
                Text("In Progress")
                Button(action: {
                    let e = APIManager()
                    e.fetchTeam(team: "3082")
                    //print(e.teamData)
                }) {
                    Text("Refresh?")
                        .padding(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                                .shadow(color: .blue, radius: 10.0)
                        )
                }.offset(x: -100, y: -20)            }
            .navigationTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
