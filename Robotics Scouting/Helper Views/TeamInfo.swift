//
//  TeamInfo.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct TeamInfo: View {
    
    var selected = 0
    var points = 0
    var gamesPlayed = 0
    var average = 0
    var teams : [Team] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Team \(String(selected))")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                Text("Team Number \(String(selected))")
                    .padding()
                Text("Average points \(average)")
                    .padding()
                Text("Games Played \(gamesPlayed)")
                    .padding()
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
