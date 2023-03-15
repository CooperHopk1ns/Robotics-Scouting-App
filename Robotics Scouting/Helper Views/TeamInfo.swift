//
//  TeamInfo.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct TeamInfo: View {
    
    var id = 0
    var selected = 0
    var gamesPlayed = 0
    var teams : [Team] = []
    //Points
    var bottomAutoAveragePoints = 0
    var middleAutoAveragePoints = 0
    var topAutoAveragePoints = 0
    var bottomTeleAveragePoints = 0
    var middleTeleAveragePoints = 0
    var topTeleAveragePoints = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Team \(String(selected))")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                Text("Games Played: \(gamesPlayed)")
                    .padding()
                //Points Info
                Text("Points")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                VStack {
                    Text("Average Bottom Auto: \(bottomAutoAveragePoints)")
                        .padding([.top, .bottom], 5)
                    Text("Average Middle Auto: \(middleAutoAveragePoints)")
                        .padding([.top, .bottom], 5)
                    Text("Average Top Auto: \(topAutoAveragePoints)")
                        .padding([.top, .bottom], 5)
                    Text("Average Bottom Tele: \(bottomTeleAveragePoints)")
                        .padding([.top, .bottom], 5)
                    Text("Average Middle Tele: \(middleTeleAveragePoints)")
                        .padding([.top, .bottom], 5)
                    Text("Average Top Tele: \(topTeleAveragePoints)")
                        .padding([.top, .bottom], 5)
                }
                
            }
            .frame(height:  600, alignment: .top)
        }
    }
}

struct TeamInfo_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfo()
    }
}
