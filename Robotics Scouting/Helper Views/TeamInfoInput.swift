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
    @State var new = true
    @State var location = 0
    //Team Variables
    @State var alliance = "red"
    @State var alliances = ["red", "blue"]
    @State var team = ""
    @State var matchNumber = 0
    @State var teams = TeamInfo().teams
    @State var amtOfGames = 0
    //Points Var
    @State var pointsScored = 0
    @State var bottomAutoPoints = 0
    @State var middleAutoPoints = 0
    @State var topAutoPoints = 0
    @State var bottomTelePoints = 0
    @State var middleTelePoints = 0
    @State var topTelePoints = 0
    @State var allianceLinks = 0
    
    var body: some View {
        NavigationView {
                VStack {
                    ScrollView {
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
                    //Team Input
                    VStack {
                        HStack {
                            Text("Enter Team Number: ")
                            TextField (
                                "Team Number",
                                text: $team
                            )
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        }
                    }
                    .padding()
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
                            .keyboardType(.numberPad)
                        }
                        .padding()
                    }
                    //Games Played
                    HStack {
                        Text("Games Played:")
                        TextField (
                            "Games Played",
                            value: $amtOfGames,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                    .padding()
                    //Alliance Links
                    HStack {
                        Text("Alliance Links")
                        TextField (
                                "Alliance Links",
                                value: $allianceLinks,
                                formatter: NumberFormatter()
                        )
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                    .padding()
                    //Points
                    VStack {
                        Text("Points")
                        VStack {
                            //Bottom Auto Points Scored
                            HStack {
                                Text("Bottom Auto:")
                                TextField (
                                    "Bottom Auto",
                                    value: $bottomAutoPoints,
                                    formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            }
                            .padding([.top, .bottom], 8)
                            //Middle Auto Points Scored
                            HStack {
                                Text("Middle Auto:")
                                TextField (
                                        "Middle Auto",
                                        value: $middleAutoPoints,
                                        formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            }
                            //Top Auto Points Scored
                            HStack {
                                Text("Top Auto:")
                                TextField (
                                    "Top Auto",
                                    value: $topAutoPoints,
                                    formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            }
                        }
                        VStack {
                            //Bottom Tele Points Scored
                            HStack {
                                Text("Bottom Tele:")
                                TextField (
                                    "Bottom Tele",
                                    value: $bottomTelePoints,
                                    formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            }
                            //Middle Tele Points Scored
                            HStack {
                                Text("Middle Tele:")
                                TextField (
                                    "Middle Tele",
                                    value: $middleTelePoints,
                                    formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            }
                            //Top Tele Points Scored
                            HStack {
                                Text("Top Tele:")
                                TextField (
                                        "Top Tele",
                                        value: $topTelePoints,
                                        formatter: NumberFormatter()
                                )
                                .textFieldStyle(.roundedBorder)
                                
                            }
                        }
                    }
                    .padding()
                    //Enter
                    Button("Enter", action: {
                        if (team != "" && matchNumber != 0 && amtOfGames != 0 && allianceLinks != 0 && bottomAutoPoints != 0 && middleAutoPoints != 0 && topAutoPoints != 0 && bottomTelePoints != 0 && middleTelePoints != 0 && topTelePoints != 0) {
                            pointsScored = bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints
                            print(teams.count)
                            if (teams.count > 0) {
                                for i in 0...teams.count-1 {
                                    print(i)
                                    let teamName = teams[i].name
                                    if (teamName == team) {
                                        new = false
                                    } else {
                                        new = true
                                        location = i
                                    }
                                }
                            }
                            if (new == true) {
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, averagePoints: Double(pointsScored), gamesPlayed: amtOfGames, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints))
                            } else {
                                //Math for adding then averaging
                                //Add check for if games played not changed
                                if (teams.count > 0) {
                                    let tempTeam = teams[location]
                                    teams.remove(at: location)
                                    teams.append(Team.init(id: Int(team) ?? 0, name: team, averagePoints: Double((tempTeam.averagePoints + Double(pointsScored))/2), gamesPlayed: amtOfGames, autoBottomPoints: tempTeam.autoBottomPoints + bottomAutoPoints, autoMiddlePoints: tempTeam.autoMiddlePoints + middleAutoPoints, autoTopPoints: tempTeam.autoTopPoints + topAutoPoints, teleBottomPoints: tempTeam.teleBottomPoints + bottomTelePoints, teleMiddlePoints: tempTeam.teleMiddlePoints + middleTelePoints, teleTopPoints: tempTeam.teleTopPoints + topTelePoints))
                                    
                                }
                            }
                            print("Points Scored")
                            print(teams.count)
                            if let encoded = try? JSONEncoder().encode(teams) {
                                UserDefaults.standard.set(encoded, forKey: "teamsKey")
                            }
                        } else {
                            print("Error")
                        }
                    })
                }
                .frame(alignment: .top)
                .padding([.bottom], 50)
                .navigationTitle("New Team Data")
            }
        }
        
    }
}

struct TeamInfoInput_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoInput()
    }
}
