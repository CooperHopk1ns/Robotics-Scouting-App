//
//  TeamInfoInput.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct TeamInfoInput: View {
    
    //Basic Variables
    @State var screenWidth = UIScreen.main.bounds.width
    
    //Team Variables
    @State var pointsScored = 0
    @State var alliance = "red"
    @State var alliances = ["red", "blue"]
    @State var team = ""
    @State var matchNumber = 0
    @State var teams = TeamInfo().teams
    @State var amtOfGames = 0
    
    var body: some View {
        NavigationView {
            VStack {
                //Alliance Picker
                VStack {
                    Text("Alliance")
                    Picker("Alliance", selection: $alliance) {
                        ForEach(alliances, id: \.self) { alliance in
                            Text(alliance.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing], 100)
                    .padding([.bottom])
                }
                //Match Number
                VStack {
                    HStack {
                        Text("Match Number:")
                        TextField (
                            "Match Number",
                            value: $matchNumber,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                }
                //Team Selector
                VStack {
                    HStack {
                        Text("Enter Team Number: ")
                        TextField (
                            "Team Number",
                            text: $team
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                }
                //Points Text Field
                HStack {
                    Text("Points Scored:")
                    TextField (
                        "Points Scored",
                        value: $pointsScored,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(.roundedBorder)
                    Stepper("", onIncrement: {
                        pointsScored += 1
                    }, onDecrement: {
                        pointsScored -= 1
                    })
                }
                .padding()
                //Games Played
                HStack {
                    Text("Games Played:")
                    TextField (
                        "Games Played",
                        value: $amtOfGames,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(.roundedBorder)
                }
                .padding()
                //Enter
                Button("Enter", action: {
                    /*
                     Get team based off name
                     Add wich alliance side for which game
                     possibly
                     and recalculate average
                */
                    teams.append(Team.init(name: team, averagePoints: Double(pointsScored), gamesPlayed: amtOfGames))
                    print("New Input \(teams)")
                    if let encoded = try? JSONEncoder().encode(teams) {
                        UserDefaults.standard.set(encoded, forKey: "teamsKey")
                    }
                })
            }
            .frame(height: 600, alignment: .top)
            .navigationTitle("New Team Data")
        }
    }
}

struct TeamInfoInput_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoInput()
    }
}
