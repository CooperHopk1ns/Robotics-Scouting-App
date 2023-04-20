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
    //Points Variables
    @State var pointsScored = 0
    @State var bottomAutoPoints = 0
    @State var middleAutoPoints = 0
    @State var topAutoPoints = 0
    @State var bottomTelePoints = 0
    @State var middleTelePoints = 0
    @State var topTelePoints = 0
    @State var allianceLinks = 0
    //Flip Variables
    @State var teamInfoFlip = false
    @State var autoPointsFlip = false
    @State var telePointsFlip = false
    @State var otherPointsFlip = false
    //View Variables
    @State var selectedView = "stand"
    @State var availableViews = ["stand", "pit"]
    //Pit Scouting Variables
    @State var drivetrain = "swerve"
    @State var drivetrainTypes = ["tank", "mecanum", "omni", "swerve"]
    @State var link = "1 link"
    @State var linkOptions = ["1 link", "2 link", "3 link", "elevator", "rotating telescope", "other"]
    @State var intake = "arm"
    @State var intakeOptions = ["pneumatic", "everybot", "our style", "other"]
    @State var pneumatics = "no"
    @State var pneumaticsOptions = ["no", "yes"]
    @State var pieceType = "both"
    @State var pieceTypeOptions = ["both", "cube", "cone"]
    @State var highestNode = "low"
    @State var highestNodeOptions = ["low", "middle", "high"]
    @State var bestAuto = "1 piece"
    @State var bestAutoOptions = ["1 piece", "2 piece", "3 piece", "1 piece + charge", "2 piece + charge", "3 piece + charge", "none"]
    @State var defense = "no"
    @State var defenseOptions = ["no", "yes"]
    //Push New Team To API
    func pushTeam() async {
        print(team)
        guard let teamsURL = URL(string: "http://api.etronicindustries.org/v1/\(team)/data/stand") else {
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
                                    print("Error \(error)")
                                    return
                                }
                                guard let data = data else {
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
    func pushTeamPit() async {
        //CHECK URL
        guard let pitTeamsURL = URL(string: "http://api.etronicindustries.org/v1/\(team)/data/pit") else {
            print("error")
            return
        }
        let pitTeamPushJson = PitTeamStruct.init(team: team, password: "chicken3082!", drivetrain: drivetrain, link: link, intake: intake, pneumatics: pneumatics, pieceType: pieceType, highestNode: highestNode, bestAuto: bestAuto, defense: defense)
        if let encoded = try? JSONEncoder().encode(pitTeamPushJson) {
            print(pitTeamPushJson)
            var request = URLRequest(url: pitTeamsURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encoded
            do {
                print("Pushed Pit Data To API")
                URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    print(response as Any)
                    if let error = error {
                        print("Error \(error)")
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
                }.resume()
            }
        }
        //Clear
        team = ""
        drivetrain = "swerve"
        link = "1 link"
        intake = "pneumatic"
        pneumatics = "no"
        pieceType = "both"
        highestNode = "low"
        bestAuto = "1 piece"
        defense = "no"
        
    }
    var body: some View {
        NavigationView {
            //View Picker
            VStack {
                VStack {
                    Picker("Data Type", selection: $selectedView) {
                        ForEach(availableViews, id: \.self) { view in
                            Text(view.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing], 100)
                }
                if (selectedView == "stand") {
                    VStack {
                        ScrollView {
                            VStack {
                                //Alliance Picker
                                Text("Team Info")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding([.leading, .trailing, .bottom], 5)
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
                                        Text("Team Number: ")
                                        TextField (
                                            "Team Number",
                                            text: $team
                                        )
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numbersAndPunctuation)
                                        .focused($isFocused)
                                    }
                                }
                                .padding([.leading, .trailing])
                                //Match Number
                                VStack {
                                    HStack {
                                        Text("Match Number: ")
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
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding([.bottom, .top], 5)
                            .padding([.top])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //Points
                            //Auto
                            VStack {
                                Text("Auto Points")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding([.top, .leading, .trailing])
                                if (autoPointsFlip == false) {
                                    Text("Enter Pieces Scored")
                                        .font(.system(size: 12))
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
                                    HStack {
                                        Text("Got Mobility Points")
                                        Spacer()
                                        checkbox(checked: $mobilityBonus)
                                    }
                                    .padding([.bottom], 1)
                                    .padding([.leading, .trailing], 68)
                                    HStack {
                                        Text("Auto Charge Not Engaged")
                                        Spacer()
                                        checkbox(checked: $autoChargeNotEngaged)
                                    }
                                    .padding([.leading, .trailing], 68)
                                    .padding([.bottom], 1)
                                    HStack {
                                        Text("Auto Charge Engaged")
                                        Spacer()
                                        checkbox(checked: $autoChargeEngaged)
                                    }
                                    .padding([.leading, .trailing], 68)
                                } else {
                                    VStack {
                                        VStack {
                                            Text("Points")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("Bottom auto points are worth 3 points each.")
                                            Text("Middle auto points are worth 4 points each.")
                                            Text("Top auto points are worth 6 points each.")
                                        }
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                        VStack {
                                            Text("Mobility Points")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("A mobility bonus is gained when a robot moves outside the community during the autonomous period.")
                                        }
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                        VStack {
                                            Text("Auto Charge")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("If the robot gets on the charge station during autonomous but the field element does not light up then it is charged but not engaged, else if it lights up then it is engaged.")
                                        }
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding([.bottom, .top], 5)
                            .padding([.bottom])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //                        .onTapGesture {
                            //                            autoPointsFlip = !autoPointsFlip
                            //                        }
                            .rotation3DEffect(
                                Angle.degrees(autoPointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            ).rotation3DEffect(
                                Angle.degrees(autoPointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            )
                            //.animation(Animation.linear(duration: 0.3), value: autoPointsFlip)
                            //Tele Op
                            VStack {
                                Text("Tele Points")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding([.top, .leading, .trailing])
                                if (telePointsFlip == false) {
                                    Text("Enter Pieces Scored")
                                        .font(.system(size: 12))
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
                                    .padding([.leading, .trailing], screenWidth/6)
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
                                    HStack {
                                        Text("Got Parking Bonus")
                                        //ADD CHECK SO NOT SELECTED IF CHARGE IS SELECTED
                                        Spacer()
                                        checkbox(checked: $parkingBonus)
                                    }
                                    .padding([.leading, .trailing], 68)
                                    .padding([.bottom], 1)
                                    HStack {
                                        Text("Tele Charge Not Engaged")
                                        Spacer()
                                        checkbox(checked: $teleChargeNotEngaged)
                                    }
                                    .padding([.leading, .trailing], 68)
                                    .padding([.bottom], 1)
                                    HStack {
                                        Text("Tele Charge Engaged")
                                        Spacer()
                                        checkbox(checked: $teleChargeEngaged)
                                    }
                                    .padding([.leading, .trailing], 68)
                                } else {
                                    VStack {
                                        VStack {
                                            Text("Points")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("Bottom tele points are worth 2 points each.")
                                            Text("Middle tele points are worth 3 points each.")
                                            Text("Top tele points are worth 5 points each.")
                                        }
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                        VStack {
                                            Text("Parking Points")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("A parking bonus is gained when a robot is parked within its community at the end of tele-op.")
                                        }
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                        VStack {
                                            Text("Tele Charge")
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text("If the robot gets on the charge station during tele-op but the field element does not light up then it is charged but not engaged, else if it lights up then it is engaged.")
                                        }
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 14))
                                        .padding([.leading, .trailing])
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding([.bottom, .top], 5)
                            .padding([.bottom])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //                        .onTapGesture {
                            //                            telePointsFlip = !telePointsFlip
                            //                        }
                            .rotation3DEffect(
                                Angle.degrees(telePointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            ).rotation3DEffect(
                                Angle.degrees(telePointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            )
                            //.animation(Animation.linear(duration: 0.3), value: telePointsFlip)
                            //Other Points
                            VStack {
                                Text("Other Points")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding([.top, .leading, .trailing])
                                if (otherPointsFlip == false) {
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
                                    .padding([.leading, .trailing], screenWidth/6)
                                } else {
                                    VStack {
                                        Text("Alliance Links")
                                            .fontWeight(.bold)
                                            .padding([.top], 1)
                                        Text("Alliance links are gained when 3 adjacent nodes in a row contain scored game pieces. This is worth 5 points.")
                                        Text("Ranking Points")
                                            .fontWeight(.bold)
                                            .padding([.top], 1)
                                        Text("Ranking points can be gained 4 ways. If a team wins they gain two ranking points, if they tie it is one ranking point. Scoring at least 5 links is worth 1 ranking point and getting 26 charge station points total is worht 1 ranking point.")
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    .padding([.leading, .trailing])
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding([.bottom, .top], 5)
                            .padding([.bottom])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //                        .onTapGesture {
                            //                            otherPointsFlip = !otherPointsFlip
                            //                        }
                            .rotation3DEffect(
                                Angle.degrees(otherPointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            ).rotation3DEffect(
                                Angle.degrees(otherPointsFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            )
                            //.animation(Animation.linear(duration: 0.3), value: otherPointsFlip)
                            
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
                            .frame(width: UIScreen.main.bounds.width/2.5, height: 40)
                            .background(Color(UIColor.systemBackground))
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            .padding([.bottom], 20)
                            //Error Alert
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("Please Fill In All Values Not Listed Under Points"))
                            }
                            
                            //Enter Alert
                            .alert(isPresented: $showCompletionAlert) {
                                Alert(title: Text("Success!"), message: Text("You Have Successfully Added Data"))
                            }
                        }
                        .padding([.bottom], 10)
                        .navigationTitle("New Team Data")
                        .frame(width: UIScreen.main.bounds.width, alignment: .top)
                    }
                } else if (selectedView == "pit") {
                    VStack {
                        ScrollView {
                            VStack {
                                //Team Info
                                Text("Team Info")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                HStack {
                                    Text("Team Number: ")
                                    TextField (
                                        "Team Number",
                                        text: $team
                                    )
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numbersAndPunctuation)
                                    .focused($isFocused)
                                }
                                .padding()
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            
                            .padding([.bottom, .top], 5)
                            .padding([.top])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //Build Info
                            VStack {
                                Text("Build Info")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                HStack {
                                    Text("Drive Train:")
                                    Picker("Drive Train Type", selection: $drivetrain) {
                                        ForEach(drivetrainTypes, id: \.self) { drivetrain in
                                            Text(drivetrain.capitalized)
                                        }
                                    }
                                }
                                HStack {
                                    Text("Arm:")
                                    Picker("Arm", selection: $link) {
                                        ForEach(linkOptions, id: \.self) { link in
                                            Text(link.capitalized)
                                            
                                        }
                                    }
                                }
                                HStack {
                                    Text("Intake:")
                                    Picker("Intake", selection: $intake) {
                                        ForEach(intakeOptions, id: \.self) { intake in
                                            Text(intake.capitalized)
                                        }
                                    }
                                }
                                HStack {
                                    Text("Pneumatics:")
                                    Picker("Pneumatics", selection: $pneumatics) {
                                        ForEach(pneumaticsOptions, id: \.self) { pneumatics in
                                            Text(pneumatics.capitalized)
                                        }
                                    }
                                }
                                HStack {
                                    Text("Piece Type:")
                                    Picker("Piece Type", selection: $pieceType) {
                                        ForEach(pieceTypeOptions, id: \.self) { piece in
                                            Text(piece.capitalized)
                                        }
                                    }
                                }
                                HStack {
                                    Text("Highest Node:")
                                    Picker("Highest Node", selection: $highestNode) {
                                        ForEach(highestNodeOptions, id: \.self) { highestNode in
                                            Text(highestNode.capitalized)
                                        }
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            
                            .padding([.bottom, .top], 5)
                            .padding([.top])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //Playstyle Info
                            VStack {
                                Text("Playstyle")
                                HStack {
                                    Text("Best Auto:")
                                    Picker("Best Auto", selection: $bestAuto) {
                                        ForEach(bestAutoOptions, id: \.self) { bestAuto in
                                            Text(bestAuto.capitalized)
                                        }
                                    }
                                }
                                HStack {
                                    Text("Defense:")
                                    Picker("Defense", selection: $defense) {
                                        ForEach(defenseOptions, id: \.self) { defense in
                                            Text(defense.capitalized)
                                        }
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding([.bottom, .top], 5)
                            .padding([.top])
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            //Enter
                            VStack {
                                Button("Enter") {
                                    //Push To API
                                    Task {
                                        await pushTeamPit()
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width/2.5, height: 40)
                            .background(Color(UIColor.systemBackground))
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 215/255, green: 215/255, blue: 215/255), lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            .padding([.bottom], 20)
                        }
                    }
                    .padding([.bottom], 10)
                    .navigationTitle("New Team Pit Data")
                    .frame(width: UIScreen.main.bounds.width, alignment: .top)
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
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct TeamInfoInput_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoInput()
    }
}
