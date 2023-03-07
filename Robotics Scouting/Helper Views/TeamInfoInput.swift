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
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    @State var count = 0
    //Team Variables
    @State var alliance = "red"
    @State var alliances = ["red", "blue"]
    @State var team = ""
    @State var matchNumber = 0
    @State var amtOfGames = 0
    @State var teams : [Team] = []
    //Points Var
    //CHANGE ALL TO DOUBLES WITH LIMIT OF 3 DECIMALS
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
                    Text("Team Info")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding()
                    VStack {
                        Text("Alliance")
                            .font(.system(size: 15))
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
                            .keyboardType(.numbersAndPunctuation)
                            .focused($isFocused)
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
                            .keyboardType(.numbersAndPunctuation)
                            .focused($isFocused)
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
                        .keyboardType(.numbersAndPunctuation)
                        .focused($isFocused)
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
                        .keyboardType(.numbersAndPunctuation)
                        .focused($isFocused)
                    }
                    .padding()
                    //Points
                    VStack {
                        Text("Points")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
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
                                .keyboardType(.numbersAndPunctuation)
                                .focused($isFocused)
                            }
                        }
                    }
                    .padding()
                    //Enter
                    Button("Enter") {
                        //ADD ON ENTER SWITCHING VIEWS
                        //Bug with input duplicating again when not immediately following
                        //Add Standard Input Logic Checking
                        if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
                            let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
                            teams.removeAll()
                            if (decodedTeamData?.count ?? 0 > 0) {
                                for i in 0...(decodedTeamData?.count ?? 1)-1 {
                                    teams.append(decodedTeamData?[i] ?? Teams().testTeam)
                                }
                            }
                        }
                        isFocused = false
                        if (team != "" && matchNumber != 0 && amtOfGames != 0 && bottomAutoPoints < 50 && middleAutoPoints < 50 && topAutoPoints < 50 && bottomTelePoints < 100 && middleTelePoints < 100 && topTelePoints < 100) {
                            pointsScored = bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints
                            print(teams.count)
                            print("running")
                            if (teams.count > 0) {
                                for i in 0...teams.count-1 {
                                    print("aslajdf;lasf \(i)")
                                    let teamName = teams[i].name
                                    print("_____________")
                                    print(teamName)
                                    print(team)
                                    print("_____________")
                                    if (teamName == team) {
                                        new = false
                                        location = i
                                        print("its new check")
                                    }
                                }
                            } else {
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, averagePoints: Double(pointsScored), gamesPlayed: amtOfGames, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints))
                            }
                            //Append
                            print(new)
                            if (new == true) {
                                print(count)
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, averagePoints: Double(pointsScored), gamesPlayed: amtOfGames, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints))
                                    print("its new")
                            } else {
                                    let tempTeam = teams[location]
                                    teams.remove(at: location)
                                teams.insert(Team.init(id: Int(team) ?? 0, name: team, averagePoints: Double((tempTeam.averagePoints + Double(pointsScored))/2), gamesPlayed: amtOfGames, autoBottomPoints: tempTeam.autoBottomPoints + bottomAutoPoints, autoMiddlePoints: tempTeam.autoMiddlePoints + middleAutoPoints, autoTopPoints: tempTeam.autoTopPoints + topAutoPoints, teleBottomPoints: tempTeam.teleBottomPoints + bottomTelePoints, teleMiddlePoints: tempTeam.teleMiddlePoints + middleTelePoints, teleTopPoints: tempTeam.teleTopPoints + topTelePoints), at: location)
                            }
                            if let encoded = try? JSONEncoder().encode(teams) {
                                UserDefaults.standard.set(encoded, forKey: "teamsKey")
                            }
                            //Clear
                            pointsScored = 0
                            bottomAutoPoints = 0
                            middleAutoPoints = 0
                            topAutoPoints = 0
                            bottomTelePoints = 0
                            middleTelePoints = 0
                            topTelePoints = 0
                            allianceLinks = 0
                            team = ""
                            amtOfGames = 0
                            matchNumber = 0
                            new = true
                            count = 0
                        } else {
                            print("Error")
                            showAlert = true;
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Please Fill In All Values Not Listed Under Points"))
                    }
                }
                .frame(alignment: .top)
                .padding([.bottom], 50)
                .navigationTitle("New Team Data")
            }
        }
        .onAppear {
            //Reset Inputs
            pointsScored = 0
            bottomAutoPoints = 0
            middleAutoPoints = 0
            topAutoPoints = 0
            bottomTelePoints = 0
            middleTelePoints = 0
            topTelePoints = 0
            allianceLinks = 0
            team = ""
            amtOfGames = 0
            matchNumber = 0
            new = true
        }
    }
}

struct TeamInfoInput_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoInput()
    }
}
