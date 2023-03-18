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
    @State var autoChargeEngaged = false
    @State var autoChargeNotEngaged = false
    @State var teleChargeEngaged = false
    @State var teleChargeNotEngaged = false
    @State var mobilityBonus = false
    @State var parkingBonus = false
    @State var rankingPoints = 0
    @State var notes = ""
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
    
    //Push New Team To API
    func pushTeam() async {
        print(team)
        guard let teamsURL = URL(string: "http://api.etronicindustries.org/v1/\(team)/data") else {
            print("error")
            return
        }
            //Convert to pushJSON
            let tempPushJSON = pushJSON.init(team: Int(team) ?? 0, password: "chicken3082!", matchNumber: amtOfGames, alliance: "blue", priorMatches: amtOfGames, autoBottom: bottomAutoPoints, autoMiddle: middleAutoPoints, autoTop: topAutoPoints, teleBottom: bottomTelePoints, teleMiddle: middleTelePoints, teleTop: topTelePoints, allianceLinks: 3)
            if let encoded = try? JSONEncoder().encode(tempPushJSON) {
                print(tempPushJSON)
                print(encoded)
                var request = URLRequest(url: teamsURL)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = encoded
                do {
                    print("Pushed to API")
                    URLSession.shared.dataTask(with: request) {
                                (data, response, error) in
                                print(response as Any)
                                if let error = error {
                                    print("Error\(error)")
                                    return
                                }
                                guard let data = data else{
                                    return
                                }
                                print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
                    }.resume()
                }
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
    }
    
    
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
                    //Alliance Links
                    HStack {
                        Stepper {
                            Text("Alliance Links: \(allianceLinks)")
                        } onIncrement: {
                            if (allianceLinks <= 8) {
                                allianceLinks += 1
                            }
                        } onDecrement: {
                            if (allianceLinks >= 1) {
                                allianceLinks -= 1
                            }
                        }
                    }
                    .padding()
                    //Points
                        VStack {
                            Text("Points")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .padding([.bottom], 2)
                            Text("Enter Pieces Scored")
                                .font(.system(size: 13))
                            VStack {
                                //Ranking Points Scored
                                //Add Calculating Based On Others
                                Stepper {
                                    Text("Ranking Points: \(rankingPoints)")
                                } onIncrement: {
                                    if (rankingPoints <= 3) {
                                        rankingPoints += 1
                                    }
                                } onDecrement: {
                                    if (rankingPoints >= 1) {
                                        rankingPoints -= 1
                                    }
                                }
                                .padding([.leading, .trailing], screenWidth/6)
                            }
                            VStack {
                                //Bottom Auto Points Scored
                                HStack {
                                    Stepper {
                                        Text("Bottom Auto: \(bottomAutoPoints)")
                                    } onIncrement: {
                                        bottomAutoPoints += 1
                                    } onDecrement: {
                                        if (bottomAutoPoints >= 1) {
                                            bottomAutoPoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                .padding([.top, .bottom], 8)
                                //Middle Auto Points Scored
                                HStack {
                                    Stepper {
                                        Text("Middle Auto: \(middleAutoPoints)")
                                    } onIncrement: {
                                        middleAutoPoints += 1
                                    } onDecrement: {
                                        if (middleAutoPoints >= 1) {
                                            middleAutoPoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                //Top Auto Points Scored
                                HStack {
                                    Stepper {
                                        Text("Top Auto: \(topAutoPoints)")
                                    } onIncrement: {
                                        topAutoPoints += 1
                                    } onDecrement: {
                                        if (topAutoPoints >= 1) {
                                            topAutoPoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                            }
                            VStack {
                                //Bottom Tele Points Scored
                                HStack {
                                    Stepper {
                                        Text("Bottom Tele: \(bottomTelePoints)")
                                    } onIncrement: {
                                        bottomTelePoints += 1
                                    } onDecrement: {
                                        if (bottomTelePoints >= 1) {
                                            bottomTelePoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                //Middle Tele Points Scored
                                HStack {
                                    Stepper {
                                        Text("Middle Tele: \(middleTelePoints)")
                                    } onIncrement: {
                                        middleTelePoints += 1
                                    } onDecrement: {
                                        if (middleTelePoints >= 1) {
                                            middleTelePoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                //Top Tele Points Scored
                                HStack {
                                    Stepper {
                                        Text("Top Tele: \(topTelePoints)")
                                    } onIncrement: {
                                        topTelePoints += 1
                                    } onDecrement: {
                                        if (topTelePoints >= 1) {
                                            topTelePoints -= 1
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                            }
                            //Other Points
                            VStack {
                                Text("Other Points")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                            }
                            //Mobility Check
                            VStack {
                                    HStack {
                                        Text("Got Mobility Points")
                                        Spacer()
                                        checkbox(checked: $mobilityBonus)
                                    }
                                    .padding([.leading, .trailing], 68)
                                }
                                .padding([.top], 1)
                            }
                            .padding([.top], 5)
                    //Parking Check
                        VStack {
                            HStack {
                                Text("Got Parking Bonus")
                                //ADD CHECK SO NOT SELECTED IF CHARGE IS SELECTED
                                Spacer()
                                checkbox(checked: $parkingBonus)
                            }
                            .padding([.leading, .trailing], 68)
                        }
                        .padding([.top], 1)
                    //Charging Check

                    VStack {
                        Text("Charge Points")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding([.bottom], 2)
                        VStack {
                            HStack {
                                Text("Got Auto Charge Not Engaged")
                                Spacer()
                                checkbox(checked: $autoChargeNotEngaged)
                            }
                            .padding([.bottom], 1)
                            HStack {
                                Text("Got Auto Charge Engaged")
                                Spacer()
                                checkbox(checked: $autoChargeEngaged)
                            }
                        }
                        .padding([.bottom], 10)
                        VStack {
                            HStack {
                                Text("Got Tele Charge Not Engaged")
                                Spacer()
                                checkbox(checked: $teleChargeNotEngaged)
                            }
                            .padding([.bottom], 1)
                            HStack {
                                Text("Got Tele Charge Engaged")
                                Spacer()
                                checkbox(checked: $teleChargeEngaged)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 50)
                    .padding()
                //Quick Notes
                    VStack {
                        TextField (
                            "Any Quick Notes?",
                            text: $notes
                        )
                        .padding([.leading, .trailing], 75)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                    }
                    //Enter
                    Button("Enter") {
                        //ADD ON ENTER SWITCHING VIEWS
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
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: 0, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints))
                            }
                            //Append
                            print(new)
                            if (new == true) {
                                print(count)
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: 0, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints))
                                    print("its new")
                            } else {
                                let tempTeam = teams[location]
                                teams.remove(at: location)
                                teams.insert(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: tempTeam.gamesPlayed, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: tempTeam.autoBottomPoints + bottomAutoPoints, autoMiddlePoints: tempTeam.autoMiddlePoints + middleAutoPoints, autoTopPoints: tempTeam.autoTopPoints + topAutoPoints, teleBottomPoints: tempTeam.teleBottomPoints + bottomTelePoints, teleMiddlePoints: tempTeam.teleMiddlePoints + middleTelePoints, teleTopPoints: tempTeam.teleTopPoints + topTelePoints), at: location)
                            }
                            if let encoded = try? JSONEncoder().encode(teams) {
                                UserDefaults.standard.set(encoded, forKey: "teamsKey")
                            }
                            //Push To API
                            Task {
                                await pushTeam()
                            }
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
                .padding([.bottom], 20)
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
