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
        ScrollView {
            Text("Team \(String(selected))")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding()
            VStack {
                VStack {
                    Text("Team \(String(selected)) vs Average Team")
                    ChartView(name: selected)
                        .frame(width: UIScreen.main.bounds.width - 10, height: 250)
                }
                VStack {
                    Text("Games Played: \(gamesPlayed)")
                        .padding()
                    //Points Info
                    VStack {
                        Text("Auto Points")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding([.top], 5)
                        VStack {
                            Text("Average Bottom Auto: \(bottomAutoAveragePoints)")
                                .padding([.top, .bottom], 5)
                            Text("Average Middle Auto: \(middleAutoAveragePoints)")
                                .padding([.top, .bottom], 5)
                            Text("Average Top Auto: \(topAutoAveragePoints)")
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width: UIScreen.main.bounds.width/1.75)
                        .overlay (
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2)
                        )
                        Text("Tele Points")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding([.top], 5)
                        VStack {
                            Text("Average Bottom Tele: \(bottomTeleAveragePoints)")
                                .padding([.top, .bottom], 5)
                            Text("Average Middle Tele: \(middleTeleAveragePoints)")
                                .padding([.top, .bottom], 5)
                            Text("Average Top Tele: \(topTeleAveragePoints)")
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width: UIScreen.main.bounds.width/1.75)
                        .overlay (
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2)
                        )
                    }
                    .padding([.bottom], 30)
                }
            }
        }
    }
}

struct TeamInfo_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfo()
    }
}
