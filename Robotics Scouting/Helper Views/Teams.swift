//
//  Teams.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Teams: View {
    
    
    @State var teams : [Team] = []
    @State var averageTeams : [AverageDataTeamStruct] = []
    @State var availableTeams : [Int] = []
    @State private var showingFilterPage = false
    var testTeam = Team.init(id: 3082, name: "3082", gamesPlayed: 4, totalPoints: 24, autoBottomPoints: 12, autoMiddlePoints: 12, autoTopPoints: 12, teleBottomPoints: 12, teleMiddlePoints: 12, teleTopPoints: 12, autoCharged: 1, teleCharged: 1, engagement: 1, mobilityPoints: 1, parkingPoints: 1, rankingPoints: 3)
    @State var searchText = ""
    @State var averageSearchText = ""
    var filterHigherToLower = false
    @State var displayTeams : [AverageDataTeamStruct] = []
    @State var minPoints : Double = 0.0
    @State var minAutoPoints : Double = 0.0
    @State var minTelePionts : Double = 0.0
    @State var sortBy = "";
    @State var hasInternet = true;
    
    //Initialize
    init() {
        filterHigherToLowerTeamNumbers()
    }
    //Search and Filters
    var searchResults: [AverageDataTeamStruct] {
        if searchText.isEmpty {
            return averageTeams
        } else {
            return averageTeams.filter {
                $0.team.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    @State var higherToLowerTeams : [AverageDataTeamStruct] = []
    func filterHigherToLowerPoints() {
        higherToLowerTeams = averageTeams.sorted { $0.autoBottom + $0.autoMiddle + $0.autoTop + $0.teleBottom + $0.teleMiddle + $0.teleTop + $0.allianceLinks + $0.autoCharged + $0.teleCharged + $0.engagement + $0.mobilityPoints + $0.parkingPoints + $0.rankingPoints > $1.autoBottom + $1.autoMiddle + $1.autoTop + $1.teleBottom + $1.teleMiddle + $1.teleTop + $1.allianceLinks + $1.autoCharged + $1.teleCharged + $1.engagement + $1.mobilityPoints + $1.parkingPoints + $1.rankingPoints }
        averageTeams = higherToLowerTeams
        sortBy = "higherToLowerPoints"
    }
    @State var lowerToHigherTeams : [AverageDataTeamStruct] = []
    func filterLowerToHigherPoints() {
        lowerToHigherTeams = averageTeams.sorted { $0.autoBottom + $0.autoMiddle + $0.autoTop + $0.teleBottom + $0.teleMiddle + $0.teleTop + $0.allianceLinks + $0.autoCharged + $0.teleCharged + $0.engagement + $0.mobilityPoints + $0.parkingPoints + $0.rankingPoints < $1.autoBottom + $1.autoMiddle + $1.autoTop + $1.teleBottom + $1.teleMiddle + $1.teleTop + $1.allianceLinks + $1.autoCharged + $1.teleCharged + $1.engagement + $1.mobilityPoints + $1.parkingPoints + $1.rankingPoints }
        averageTeams = lowerToHigherTeams
        sortBy = "lowerToHigherPoints"
    }
    @State var higherToLowerAutoTeams : [AverageDataTeamStruct] = []
    func filterHigherToLowerAutoPoints() {
        higherToLowerAutoTeams = averageTeams.sorted { $0.autoBottom + $0.autoMiddle + $0.autoTop > $1.autoBottom + $1.autoMiddle + $1.autoTop }
        averageTeams = higherToLowerAutoTeams
        sortBy = "higherToLowerAutoPoints"
    }
    @State var lowerToHigherAutoTeams : [AverageDataTeamStruct] = []
    func filterLowerToHigherAutoPoints() {
        lowerToHigherAutoTeams = averageTeams.sorted { $0.autoBottom + $0.autoMiddle + $0.autoTop < $1.autoBottom + $1.autoMiddle + $1.autoTop }
        averageTeams = lowerToHigherAutoTeams
        sortBy = "lowerToHigherAutoPoints"
    }
    @State var higherToLowerTeleTeams : [AverageDataTeamStruct] = []
    func filterHigherToLowerTelePoints() {
        higherToLowerTeleTeams = averageTeams.sorted { $0.teleBottom + $0.teleMiddle + $0.teleTop > $1.teleBottom + $1.teleMiddle + $1.teleTop }
        averageTeams = higherToLowerTeleTeams
        sortBy = "higherToLowerTelePoints"
    }
    @State var lowerToHigherTeleTeams : [AverageDataTeamStruct] = []
    func filterLowerToHigherTelePoints() {
        lowerToHigherTeleTeams = averageTeams.sorted { $0.teleBottom + $0.teleMiddle + $0.teleTop < $1.teleBottom + $1.teleMiddle + $1.teleTop }
        averageTeams = lowerToHigherTeleTeams
        sortBy = "lowerToHigherTelePoints"
    }
    @State var higherToLowerTeamNumbers : [AverageDataTeamStruct] = []
    func filterHigherToLowerTeamNumbers() {
        higherToLowerTeamNumbers = averageTeams.sorted { $0.team > $1.team}
        averageTeams = higherToLowerTeamNumbers
        sortBy = "higherToLowerTeamNumbers"
    }
    @State var lowerToHigherTeamNumbers : [AverageDataTeamStruct] = []
    func filterLowerToHigherTeamNumbers() {
        lowerToHigherTeamNumbers = averageTeams.sorted { $0.team < $1.team}
        averageTeams = lowerToHigherTeamNumbers
        sortBy = "lowerToHigherTeamNumbers"
    }
    func applyFilters() {
        print("Before Count \(averageTeams.count)")
        //Decode
        //Decode Min Points
        let decodedMinPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfPointsFilterKey") ?? Data())
        let minPoints = Double(decodedMinPoints ?? 0)
        //Decode Min Auto Points
        let decodedMinAutoPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfAutoPointsFilterKey") ?? Data())
        let minAutoPoints = Double(decodedMinAutoPoints ?? 0)
        //Decode Min Tele Points
        let decodedMinTelePoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfTelePointsFilterKey") ?? Data())
        let minTelePoints = Double(decodedMinTelePoints ?? 0)
        //Visual Update
        displayTeams.removeAll()
        @State var count = 0
        if (averageTeams.count > 0) {
            for i in 0...averageTeams.count-1 {
                let teamAutoMinPoints = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop
                let teamTeleMinPoints = averageTeams[i].teleBottom + averageTeams[i].teleBottom + averageTeams[i].teleTop
                let points = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints
                print("Points are \(points)")
                print("Min Points \(minPoints)")
                if (points >= minPoints && teamAutoMinPoints >= minAutoPoints && teamTeleMinPoints >= minTelePoints) {
                    displayTeams.append(averageTeams[i])
                    count+=1
                    print(count)
                }
            }
            averageTeams.removeAll()
            averageTeams = displayTeams
            print("AFter Count \(averageTeams.count)")
        }
    }
    
    func getTeamsRequest() async {
        //Teams URL
        //Get what teams available
        guard let availTeamsURL = URL(string: "http://api.etronicindustries.org/v1/teams") else {
            print("Error fetching available teams")
            return
        }
        do {
            let(availTeamsData, _) = try await URLSession.shared.data(from: availTeamsURL)
            
            let decodedTeamsAvailData = try JSONDecoder().decode(teamsAvailStruct?.self, from: availTeamsData)
            let arrayData = decodedTeamsAvailData?.array
            for i in 0...arrayData!.count - 1 {
                print(Int(arrayData![i].team) ?? 0)
                availableTeams.append(Int(arrayData![i].team) ?? 0)
            }
        } catch {
            print(error)
        }
        //teams.removeAll()
        //FATAL ERROR IF NO INTERNET
        if (availableTeams.count > 0) {
            for i in 0...availableTeams.count-1 {
                guard let teamsURL = URL(string: "http://api.etronicindustries.org/v1/\(availableTeams[i])/data/stand") else {
                    print("Teams URL Error")
                    return
                }
                do {
                    let(data, _) = try await URLSession.shared.data(from: teamsURL)
                    
                    guard let decodedTeamData = try JSONDecoder().decode(responseJSON?.self, from: data) else {
                        print("Error")
                        return
                    }
                    print("Data is \(decodedTeamData)")
                    let totalPoints = Int(decodedTeamData.team.autoBottom)! + Int(decodedTeamData.team.autoMiddle)! + Int(decodedTeamData.team.autoTop)! + Int(decodedTeamData.team.teleBottom)! + Int(decodedTeamData.team.teleMiddle)! + Int(decodedTeamData.team.teleTop)!
                    print("Total Points IS \(totalPoints)")
                    var tempTeam = Team(id: decodedTeamData.team.id, name: decodedTeamData.team.team, gamesPlayed: Int(decodedTeamData.team.priorMatches) ?? 1, totalPoints: totalPoints, autoBottomPoints: Int(decodedTeamData.team.autoBottom) ?? 0, autoMiddlePoints: Int(decodedTeamData.team.autoMiddle) ?? 0, autoTopPoints: Int(decodedTeamData.team.autoTop) ?? 0, teleBottomPoints: Int(decodedTeamData.team.teleBottom) ?? 0, teleMiddlePoints: Int(decodedTeamData.team.teleMiddle) ?? 0, teleTopPoints: Int(decodedTeamData.team.teleTop) ?? 0, autoCharged: Int(decodedTeamData.team.autoCharged) ?? 0, teleCharged: Int(decodedTeamData.team.teleCharged) ?? 0, engagement: Int(decodedTeamData.team.engagement) ?? 0, mobilityPoints: Int(decodedTeamData.team.mobilityPoints) ?? 0, parkingPoints: Int(decodedTeamData.team.parkingPoints) ?? 0, rankingPoints: Int(decodedTeamData.team.rankingPoints) ?? 0)
                    if (tempTeam.gamesPlayed == 0) {
                        tempTeam.gamesPlayed += 1
                    }
                    var new = true
                    print(teams.count)
                    if (teams.count > 0) {
                        for i in 0...teams.count - 1 {
                            if (teams[i].name == tempTeam.name) {
                                new = false
                            }
                        }
                        if (new == true) {
                            teams.append(tempTeam)
                        }
                    } else {
                        teams.append(tempTeam)
                    }
                    if let encoded = try? JSONEncoder().encode(teams) {
                        UserDefaults.standard.set(encoded, forKey: "teamsKey")
                    }
                } catch {
                    
                }
            }
        }
        
    }
    //Get Average Teams Data
    func getTeamAveragesRequest() async {
        averageTeams.removeAll()
        availableTeams.removeAll()
        //Get what teams available
        guard let availTeamsURL = URL(string: "http://api.etronicindustries.org/v1/teams") else {
            print("Error fetching available teams")
            return
        }
        do {
            let(availTeamsData, _) = try await URLSession.shared.data(from: availTeamsURL)
            
            let decodedTeamsAvailData = try JSONDecoder().decode(teamsAvailStruct?.self, from: availTeamsData)
            let arrayData = decodedTeamsAvailData?.array
            for i in 0...arrayData!.count - 1 {
                print(Int(arrayData![i].team) ?? 0)
                availableTeams.append(Int(arrayData![i].team) ?? 0)
            }
        } catch {
            print(error)
        }
        print(availableTeams)
        for i in 0...availableTeams.count-1 {
            guard let teamAveragesURL = URL(string: "http://api.etronicindustries.org/v1/\(availableTeams[i])/data/stand/averages") else {
                print("Average Teams URL Error")
                return
            }
            print(teamAveragesURL)
            do {
                let(decodedTeamData, _) = try await URLSession.shared.data(from: teamAveragesURL)
                guard let decodedAverageData = try JSONDecoder().decode(AverageDataStruct?.self, from: decodedTeamData) else {
                    print("error")
                    return
                }
                let decodedAverageTeam : AverageDataTeamStruct = decodedAverageData.objectJSON
                averageTeams.append(decodedAverageTeam)
                //Encode
                if let encoded = try? JSONEncoder().encode(averageTeams) {
                    UserDefaults.standard.set(encoded, forKey: "averageTeamsKey")
                }
            } catch {

            }
        }
        print("average teams \(averageTeams)")
    }
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    HStack {
                        Button("Filter") {
                            showingFilterPage.toggle()
                        }
                        .frame(width: UIScreen.main.bounds.width/2)
                        .overlay(Rectangle().frame(width: 1, height: 30, alignment: .trailing).foregroundColor(Color.gray), alignment: .trailing)
                        Menu("Sort By") {
                            Button("Higher To Lower", action: filterHigherToLowerPoints)
                            Button("Lower To Higher", action: filterLowerToHigherPoints)
                            Button("Higher To Lower Auto", action: filterHigherToLowerAutoPoints)
                            Button("Lower To Higher Auto", action: filterLowerToHigherAutoPoints)
                            Button("Higher To Lower Tele", action: filterHigherToLowerTelePoints)
                            Button("Lower To Higher Tele", action: filterLowerToHigherTelePoints)
                            Button("Higher To Lower Team Numbers", action: filterHigherToLowerTeamNumbers)
                            Button("Lower To Higher Team Numbers", action: filterLowerToHigherTeamNumbers)
                        }
                        .frame(width: UIScreen.main.bounds.width/2)
                    }
                    .padding([.bottom, .top], 8)
                    VStack {
//                        List((searchResults), id: \.self) {team in
//                            NavigationLink {
//                                TeamInfo(selected: Int(team.name) ?? 0, gamesPlayed: team.gamesPlayed, bottomAutoAveragePoints: Double(team.autoBottomPoints), middleAutoAveragePoints: Double(team.autoMiddlePoints), topAutoAveragePoints: Double(team.autoTopPoints), bottomTeleAveragePoints: Double(team.teleBottomPoints), middleTeleAveragePoints: Double(team.teleMiddlePoints), topTeleAveragePoints: Double(team.teleTopPoints))
//                            } label: {
//                                Text("\(team.name)")
//                            }
//                        }
                            List((searchResults), id: \.self) { avTeam in
                                NavigationLink {
                                    TeamInfo(selected: avTeam.team, bottomAutoAveragePoints: avTeam.autoBottom, middleAutoAveragePoints: avTeam.autoMiddle, topAutoAveragePoints: avTeam.autoTop, bottomTeleAveragePoints: avTeam.teleBottom, middleTeleAveragePoints: avTeam.teleMiddle, topTeleAveragePoints: avTeam.teleTop)
                                } label: {
                                    Text("Team \(avTeam.team)")
                                }
                            }
                    }
                    
                    

                    
                    .onAppear {
//                        if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
//                            let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
//                            teams.removeAll()
//                            if (decodedTeamData?.count ?? 0 > 0) {
//                                for i in 0...(decodedTeamData?.count ?? 1)-1 {
//                                    teams.append(decodedTeamData![i])
//                                    print(decodedTeamData![i])
//                                    print("runnin")
//                                }
//                            }
//                        }
                        //Apply Filters
                        applyFilters()
                        //Apply Sorting
                        switch sortBy {
                        case "higherToLowerPoints":
                            filterHigherToLowerPoints()
                        case "lowerToHigherPoints":
                            filterLowerToHigherPoints()
                        case "higherToLowerAutoPoints":
                            filterHigherToLowerAutoPoints()
                        case "lowerToHigherAutoPoints":
                            filterLowerToHigherAutoPoints()
                        case "higherToLowerTelePoints":
                            filterHigherToLowerTelePoints()
                        case "lowerToHigherTelePoints":
                            filterLowerToHigherTelePoints()
                        case "higherToLowerTeamNumbers":
                            filterHigherToLowerTeamNumbers()
                        case "lowerToHigherTeamNumbers":
                            filterLowerToHigherTeamNumbers()
                        default :
                            print("no filter applied")
                        }
                    }
                    .refreshable {
                        //Get Averages
                        await getTeamAveragesRequest()
                        print("run")
                        applyFilters()
                    }
                    .navigationTitle("Teams")
                }
                .searchable(text: $searchText, prompt: "Enter Team Number")
            }
        }
        .sheet(isPresented: $showingFilterPage) {
                            TeamFilter()
        }
    }
}

struct Teams_Previews: PreviewProvider {
    static var previews: some View {
        Teams()
    }
}
