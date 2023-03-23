//
//  Teams.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI
import SystemConfiguration

struct Teams: View {
    
    @State var teams : [Team] = []
    @State private var showingFilterPage = false
    var testTeam = Team.init(id: 3082, name: "3082", gamesPlayed: 4, totalPoints: 24, autoBottomPoints: 12, autoMiddlePoints: 12, autoTopPoints: 12, teleBottomPoints: 12, teleMiddlePoints: 12, teleTopPoints: 12, autoCharged: 1, teleCharged: 1, engagement: 1, mobilityPoints: 1, parkingPoints: 1, rankingPoints: 3)
    @State var searchText = ""
    var filterHigherToLower = false
    @State var displayTeams : [Team] = []
    @State var minPoints = 0
    @State var minAutoPoints = 0.0
    @State var minTelePionts = 0.0
    @State var sortBy = "";
    @State var hasInternet = true;
    
    //Check For Internet Connection
    func checkInternet() {
        guard let googleURL = URL(string: "https://www.google.com") else {
            print("NO INTERNET")
            hasInternet = false
            return
        }
        URLSession.shared.dataTask(with: googleURL) { (data, response, error) in
                if let error = error {
                    print("Error checking internet connection: \(error.localizedDescription)")
                    hasInternet = false
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    hasInternet = false
                    return
                }
            print(httpResponse.statusCode)
            if (httpResponse.statusCode == 200) {
                hasInternet = true;
                return
            }
        }
        print(hasInternet)
    }
    //Initialize
    init() {
        checkInternet()
        filterHigherToLowerTeamNumbers()
    }
    //Search and Filters
    var searchResults: [Team] {
        if searchText.isEmpty {
            return teams
        } else {
            return teams.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    @State var higherToLowerTeams : [Team] = []
    func filterHigherToLowerPoints() {
        higherToLowerTeams = teams.sorted {$0.totalPoints > $1.totalPoints}
        print("Teams are \(higherToLowerTeams)")
        teams = higherToLowerTeams
        sortBy = "higherToLowerPoints"
    }
    @State var lowerToHigherTeams : [Team] = []
    func filterLowerToHigherPoints() {
        lowerToHigherTeams = teams.sorted { $0.totalPoints < $1.totalPoints}
        print(lowerToHigherTeams)
        print("Lower To Higher Teams are \(lowerToHigherTeams)")
        teams = lowerToHigherTeams
        sortBy = "lowerToHigherPoints"
    }
    @State var higherToLowerAutoTeams : [Team] = []
    func filterHigherToLowerAutoPoints() {
        higherToLowerAutoTeams = teams.sorted { $0.autoBottomPoints + $0.autoMiddlePoints + $0.autoTopPoints > $1.autoBottomPoints + $1.autoMiddlePoints + $1.autoMiddlePoints }
        print(higherToLowerAutoTeams)
        print("Higher To Lower Auto Teams are \(higherToLowerAutoTeams)")
        teams = higherToLowerAutoTeams
        sortBy = "higherToLowerAutoPoints"
    }
    @State var lowerToHigherAutoTeams : [Team] = []
    func filterLowerToHigherAutoPoints() {
        lowerToHigherAutoTeams = teams.sorted { $0.autoBottomPoints + $0.autoMiddlePoints + $0.autoTopPoints < $1.autoBottomPoints + $1.autoMiddlePoints + $1.autoMiddlePoints }
        print(lowerToHigherAutoTeams)
        print("Lower To Higher Auto Teams are \(lowerToHigherAutoTeams)")
        teams = lowerToHigherAutoTeams
        sortBy = "lowerToHigherAutoPoints"
    }
    @State var higherToLowerTeleTeams : [Team] = []
    func filterHigherToLowerTelePoints() {
        higherToLowerTeleTeams = teams.sorted { $0.teleBottomPoints + $0.teleMiddlePoints + $0.teleTopPoints > $1.teleBottomPoints + $1.teleMiddlePoints + $1.teleTopPoints }
        print(higherToLowerTeleTeams)
        print("Higher To Lower Tele Teams are \(higherToLowerTeleTeams)")
        teams = higherToLowerTeleTeams
        sortBy = "higherToLowerTelePoints"
    }
    @State var lowerToHigherTeleTeams : [Team] = []
    func filterLowerToHigherTelePoints() {
        lowerToHigherTeleTeams = teams.sorted { $0.teleBottomPoints + $0.teleMiddlePoints + $0.teleTopPoints < $1.teleBottomPoints + $1.teleMiddlePoints + $1.teleTopPoints }
        print(lowerToHigherTeleTeams)
        print("Lower To Higher Tele Teams are \(lowerToHigherTeleTeams)")
        teams = lowerToHigherTeleTeams
        sortBy = "lowerToHigherTelePoints"
    }
    @State var higherToLowerTeamNumbers : [Team] = []
    func filterHigherToLowerTeamNumbers() {
        higherToLowerTeamNumbers = teams.sorted { $0.name < $1.name}
        teams = higherToLowerTeamNumbers
        sortBy = "higherToLowerTeamNumbers"
    }
    @State var lowerToHigherTeamNumbers : [Team] = []
    func filterLowerToHigherTeamNumbers() {
        lowerToHigherTeamNumbers = teams.sorted { $0.name > $1.name}
        teams = lowerToHigherTeamNumbers
        sortBy = "lowerToHigherTeamNumbers"
    }
    
    func applyFilters() {
        //Decode
        //Decode Min Points
        let decodedMinPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfPointsFilterKey") ?? Data())
        let minPoints = Int(decodedMinPoints ?? 0)
        print("Min Points After Filters Applied \(minPoints)")
        //Decode Min Auto Points
        let decodedMinAutoPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfAutoPointsFilterKey") ?? Data())
        let minAutoPoints = Int(decodedMinAutoPoints ?? 0)
        print("Min Auto Points After Filters Applied \(minAutoPoints)")
        //Decode Min Tele Points
        let decodedMinTelePoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfTelePointsFilterKey") ?? Data())
        let minTelePoints = Int(decodedMinTelePoints ?? 0)
        print("Min Tele Points After Filter Applied \(minTelePoints)")
        //Visual Update
        print(teams.count)
        displayTeams.removeAll()
        if (teams.count > 0) {
            for i in 0...teams.count-1 {
                let teamAutoMinPoints = teams[i].autoBottomPoints + teams[i].autoMiddlePoints + teams[i].autoTopPoints
                let teamTeleMinPoints = teams[i].teleBottomPoints + teams[i].teleMiddlePoints + teams[i].teleTopPoints
                print("\(teams[i])")
                if (teams[i].totalPoints >= minPoints && teamAutoMinPoints >= minAutoPoints && teamTeleMinPoints >= minTelePoints) {
                    displayTeams.append(teams[i])
                }
            }
            print(displayTeams)
            teams.removeAll()
            teams = displayTeams
        }
    }
    
    func getTeamsRequest() async {
        //Teams URL
        var availableTeams : [Int] = []
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
                print(Int(arrayData![i].team))
                availableTeams.append(Int(arrayData![i].team) ?? 0)
            }
        } catch {
            print(error)
        }
        //FATAL ERROR IF NO INTERNET
        for i in 0...availableTeams.count-1 {
            guard let teamsURL = URL(string: "http://api.etronicindustries.org/v1/\(availableTeams[i])/data") else {
                print("error")
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
                    List((searchResults), id: \.self) {team in
                        NavigationLink {
                            TeamInfo(selected: Int(team.name) ?? 0, gamesPlayed: team.gamesPlayed, bottomAutoAveragePoints: team.autoBottomPoints, middleAutoAveragePoints: team.autoMiddlePoints, topAutoAveragePoints: team.autoTopPoints, bottomTeleAveragePoints: team.teleBottomPoints, middleTeleAveragePoints: team.teleMiddlePoints, topTeleAveragePoints: team.teleTopPoints)
                        } label: {
                            Text("\(team.name)")
                        }
                        
                    }
                    
                    .onAppear {
                        if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
                            let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
                            teams.removeAll()
                            if (decodedTeamData?.count ?? 0 > 0) {
                                for i in 0...(decodedTeamData?.count ?? 1)-1 {
                                    teams.append(decodedTeamData![i])
                                    print(decodedTeamData![i])
                                    print("runnin")
                                }
                            }
                        }
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
                        await getTeamsRequest()
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
