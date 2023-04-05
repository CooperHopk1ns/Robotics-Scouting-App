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
    @State private var showCompletionAlert = false
    @State var count = 0
    //Data Display Variables
    @State var pointsInfoDisplay = false
    @State var otherPointsInfoDisplay = false
    @State var chargePointsInfoDisplay = false
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
    @State var autoChargeEngagedInt = 0
    @State var teleChargeEngagedInt = 0
    @State var mobilityBonusInt = 0
    @State var parkingBonusInt = 0
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
            //Check
        if (autoChargeEngaged == true) {
            autoChargeEngagedInt = 2
        }
        if (autoChargeNotEngaged == true) {
            autoChargeEngagedInt = 1
        }
        if (teleChargeEngaged == true) {
            teleChargeEngagedInt = 2
        }
        if (teleChargeNotEngaged == true) {
            teleChargeEngagedInt = 1
        }
        if (mobilityBonus == true) {
            mobilityBonusInt = 1
        }
        if (parkingBonus == true) {
            parkingBonusInt = 1
        }
            //Convert to pushJSON
        let tempPushJSON = pushJSON.init(team: Int(team) ?? 0, password: "chicken3082!", matchNumber: amtOfGames, alliance: "blue", priorMatches: amtOfGames, autoBottom: bottomAutoPoints, autoMiddle: middleAutoPoints, autoTop: topAutoPoints, teleBottom: bottomTelePoints, teleMiddle: middleTelePoints, teleTop: topTelePoints, allianceLinks: allianceLinks, autoCharged: autoChargeEngagedInt, teleCharged: teleChargeEngagedInt, engagement: 1, mobilityPoints: mobilityBonusInt, parkingPoints: parkingBonusInt, rankingPoints: rankingPoints)
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
        rankingPoints = 0
        team = ""
        amtOfGames = 0
        matchNumber = 0
        new = true
        count = 0
        autoChargeEngaged = false
        autoChargeNotEngaged = false
        teleChargeEngaged = false
        teleChargeNotEngaged = false
        mobilityBonus = false
        parkingBonus = false
        notes = ""
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
                                //Add Color Change Based On Alliance Color
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
                    //Points
                        VStack {
                            VStack {
                                VStack {
                                    HStack {
                                        Button {
                                            pointsInfoDisplay = true
                                        } label: {
                                            Image(systemName: "questionmark.circle")
                                        }
                                        .popover(isPresented: $pointsInfoDisplay) {
                                            VStack {
                                                Text("Points Info")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                ScrollView {
                                                    VStack {
                                                        Text("Bottom Auto")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("This is worth three points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Middle Auto")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("This is worth four points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Top Auto")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("THis is worth six points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Bottom Tele")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("This is worth two points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Middle Tele")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("This is worth three points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Top Tele")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("This is worth five points")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Alliance Links")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("Alliance Links are gained when three nodes in a row contain pieces.")
                                                            .padding([.leading, .trailing], 25)
                                                            .multilineTextAlignment(.center)
                                                        Image("AllianceLinkExample")
                                                            .resizable()
                                                            .frame(width: UIScreen.main.bounds.width-20)
                                                            .aspectRatio(3.192/1, contentMode: .fit)
                                                    }
                                                    .padding()
                                                    VStack {
                                                        Text("Ranking Points")
                                                            .font(.system(size: 17))
                                                            .fontWeight(.semibold)
                                                        Text("Ranking Points are earned three ways:")
                                                            .padding([.leading, .trailing], 25)
                                                            .padding([.top, .bottom], 2)
                                                            .multilineTextAlignment(.center)
                                                        Text("- If there are twenty-six total charge station points during the game, one ranking point is gained.")
                                                            .padding([.leading, .trailing], 15)
                                                            .padding([.top, .bottom], 2)
                                                            .multilineTextAlignment(.center)
                                                        Text("- If there is a draw, it is one ranking point.")
                                                            .padding([.leading, .trailing], 15)
                                                            .padding([.top, .bottom], 2)
                                                            .multilineTextAlignment(.center)
                                                        Text("- If you win, it is two ranking points.")
                                                            .padding([.leading, .trailing], 15)
                                                            .padding([.top, .bottom], 2)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                    .padding()
                                                }
                                            }
                                            .padding()
                                        }
                                        Text("Points")
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                            .padding([.bottom], 2)
                                    }
                                    Text("Enter Pieces Scored")
                                        .font(.system(size: 13))
                                    //Auto Points
                                    VStack {
                                        //Bottom Auto Points
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
                                        //Middle Auto Points
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
                                        //Top Auto Points
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
                                    //Tele Points
                                    VStack {
                                        //Bottom Tele Points
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
                                        }
                                    }
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                //Middle Tele Points
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
                                //Top Tele Points
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
                                }
                                .padding([.leading, .trailing], screenWidth/6)
                                //Alliance Links
                                VStack {
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
                                    .padding([.leading, .trailing], screenWidth/6)
                                }
                                //Ranking Points
                                VStack {
                                    HStack {
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
                                        }
                                    .padding([.leading, .trailing], screenWidth/6)
                                    }
                                //Other Points
                                VStack {
                                    HStack {
                                        Button {
                                            otherPointsInfoDisplay = true
                                        } label: {
                                            Image(systemName: "questionmark.circle")
                                        }
                                        .popover(isPresented: $otherPointsInfoDisplay) {
                                            VStack {
                                                Text("Other Points Info")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                VStack {
                                                    Text("Mobility Points")
                                                        .font(.system(size: 17))
                                                        .fontWeight(.semibold)
                                                    Text("Mobility Points can only be earned during auto. It is worth three points and is gained when the robots bumpers completely leave its community.")
                                                        .padding([.leading, .trailing], 25)
                                                        .multilineTextAlignment(.center)
                                                }
                                                .padding()
                                                VStack {
                                                    Text("Parking Points")
                                                        .font(.system(size: 17))
                                                        .fontWeight(.semibold)
                                                    Text("Parking Points are earned when a robot is completely within its community at the end of a match, but is not docked. It is worth 2 points.")
                                                        .padding([.leading, .trailing], 25)
                                                        .multilineTextAlignment(.center)
                                                }
                                            }
                                            .padding([.bottom], 325)
                                        }
                                        Text("Other Points")
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                    }
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
                                HStack {
                                    Button {
                                        chargePointsInfoDisplay = true
                                    } label: {
                                        Image(systemName: "questionmark.circle")
                                    }
                                    .popover(isPresented: $chargePointsInfoDisplay) {
                                        VStack {
                                            Text("Charge Points Info")
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                            VStack {
                                                Text("Auto Charge")
                                                    .font(.system(size: 17))
                                                    .fontWeight(.semibold)
                                                Text("- Docked and Not Engaged is worth eight points in auto.")
                                                    .multilineTextAlignment(.center)
                                                Text("- Docked and Engaged is worth twelve points in atuo.")
                                                    .multilineTextAlignment(.center)
                                            }
                                            .padding()
                                            VStack {
                                                Text("Tele Charge")
                                                    .font(.system(size: 17))
                                                    .fontWeight(.semibold)
                                                Text("- Docked and Not Engaged is worth six points in tele.")
                                                    .multilineTextAlignment(.center)
                                                Text("- Docked and Engaged is worth ten points in tele.")
                                                    .multilineTextAlignment(.center)
                                            }
                                            .padding()
                                        }
                                        .padding([.bottom], 300)
                                    }
                                    Text("Charge Points")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                        .padding([.bottom], 2)
                                }
                                VStack {
                                    HStack {
                                        Text("Auto Charge Not Engaged")
                                        Spacer()
                                        checkbox(checked: $autoChargeNotEngaged)
                                    }
                                    .padding([.bottom], 1)
                                    HStack {
                                        Text("Auto Charge Engaged")
                                        Spacer()
                                        checkbox(checked: $autoChargeEngaged)
                                    }
                                }
                                .padding([.bottom], 10)
                                VStack {
                                    HStack {
                                        Text("Tele Charge Not Engaged")
                                        Spacer()
                                        checkbox(checked: $teleChargeNotEngaged)
                                    }
                                    .padding([.bottom], 1)
                                    HStack {
                                        Text("Tele Charge Engaged")
                                        Spacer()
                                        checkbox(checked: $teleChargeEngaged)
                                    }
                                }
                            }
                            .padding([.leading, .trailing], 50)
                            .padding()
                        }
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
                        //Check
                        if (autoChargeEngaged == true) {
                            autoChargeEngagedInt = 2
                        }
                        if (autoChargeNotEngaged == true) {
                            autoChargeEngagedInt = 1
                        }
                        if (teleChargeEngaged == true) {
                            teleChargeEngagedInt = 2
                        }
                        if (teleChargeNotEngaged == true) {
                            teleChargeEngagedInt = 1
                        }
                        if (mobilityBonus == true) {
                            mobilityBonusInt = 1
                        }
                        if (parkingBonus == true) {
                            parkingBonusInt = 1
                        }
                        //Add Standard Input Logic Checking // For Parking, if got parking then charge cannot be selected and vice versa
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
                        if (team != "") {
                            pointsScored = bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints
                            print(teams.count)
                            if (teams.count > 0) {
                                for i in 0...teams.count-1 {
                                    let teamName = teams[i].name
                                    print("_____________")
                                    print(teamName)
                                    print(team)
                                    print("_____________")
                                    if (teamName == team) {
                                        new = false
                                        location = i
                                    }
                                }
                            } else {
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: 0, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints, autoCharged: autoChargeEngagedInt, teleCharged: teleChargeEngagedInt, engagement: 1, mobilityPoints: mobilityBonusInt, parkingPoints: parkingBonusInt, rankingPoints: rankingPoints))
                            }
                            //Append
                            print(new)
                            if (new == true) {
                                print(count)
                                teams.append(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: 0, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints, autoCharged: autoChargeEngagedInt, teleCharged: teleChargeEngagedInt, engagement: 1, mobilityPoints: mobilityBonusInt, parkingPoints: parkingBonusInt, rankingPoints: rankingPoints))
                            } else {
                                //let tempTeam = teams[location]
                                teams.remove(at: location)
                                teams.insert(Team.init(id: Int(team) ?? 0, name: team, gamesPlayed: 0, totalPoints: bottomAutoPoints + middleAutoPoints + topAutoPoints + bottomTelePoints + middleTelePoints + topTelePoints, autoBottomPoints: bottomAutoPoints, autoMiddlePoints: middleAutoPoints, autoTopPoints: topAutoPoints, teleBottomPoints: bottomTelePoints, teleMiddlePoints: middleTelePoints, teleTopPoints: topTelePoints, autoCharged: autoChargeEngagedInt, teleCharged: teleChargeEngagedInt, engagement: 1, mobilityPoints: mobilityBonusInt, parkingPoints: parkingBonusInt, rankingPoints: rankingPoints), at: location)
                            }
                            if let encoded = try? JSONEncoder().encode(teams) {
                                UserDefaults.standard.set(encoded, forKey: "teamsKey")
                            }
                            //Push To API
                            Task {
                                await pushTeam()
                            }
                            //Present Completion Alert
                            showCompletionAlert = true
                        } else {
                            print("Error")
                            showAlert = true
                        }
                    }
                    //Error Alert
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Please Fill In All Values Not Listed Under Points"))
                    }

                    //Enter Alert
                    .alert(isPresented: $showCompletionAlert) {
                        Alert(title: Text("Success!"), message: Text("You Have Successfully Added Data"))
                    }
                }
                .frame(alignment: .top)
                .padding([.bottom], 20)
                .navigationTitle("New Team Data")
            }
        }
//        .onAppear {
//            //Reset Inputs
//            pointsScored = 0
//            bottomAutoPoints = 0
//            middleAutoPoints = 0
//            topAutoPoints = 0
//            bottomTelePoints = 0
//            middleTelePoints = 0
//            topTelePoints = 0
//            allianceLinks = 0
//            team = ""
//            amtOfGames = 0
//            matchNumber = 0
//            new = true
//        }
    }
}

struct TeamInfoInput_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoInput()
    }
}
