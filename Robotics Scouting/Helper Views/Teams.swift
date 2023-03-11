//
//  Teams.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Teams: View {
    
    @State var teams : [Team] = []
    
    var testTeam = Team.init(id: 3082, name: "3082", gamesPlayed: 4, autoBottomPoints: 12, autoMiddlePoints: 12, autoTopPoints: 12, teleBottomPoints: 12, teleMiddlePoints: 12, teleTopPoints: 12)
    @State var searchText = ""
    
    var searchResults: [Team] {
        if searchText.isEmpty {
            return teams
        } else {
            return teams.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    struct teamJSONStruct: Decodable {
        var id: Int
        var team: String
        var matchNumber: Int
        var alliance: String
        var priorMatches: Int
        var autoBottom: Int
        var autoMiddle: Int
        var autoTop: Int
        var teleBottom: Int
        var teleMiddle: Int
        var teleTop: Int
        var allianceLinks: Int
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
                print(Int(arrayData![i].team)!)
                availableTeams.append(Int(arrayData![i].team)!)
            }
        } catch {
            print(error)
        }
        
        
        
        
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
                var points = Int(decodedTeamData.team.autoBottom) ?? 1
                if (points == 0) {
                    points+=1
                }
                var tempTeam = Team(id: decodedTeamData.team.id, name: decodedTeamData.team.team, gamesPlayed: Int(decodedTeamData.team.priorMatches) ?? 0, autoBottomPoints: Int(decodedTeamData.team.autoBottom) ?? 0, autoMiddlePoints: Int(decodedTeamData.team.autoMiddle) ?? 0, autoTopPoints: Int(decodedTeamData.team.autoTop) ?? 0, teleBottomPoints: Int(decodedTeamData.team.teleBottom) ?? 0, teleMiddlePoints: Int(decodedTeamData.team.teleMiddle) ?? 0, teleTopPoints: Int(decodedTeamData.team.teleTop) ?? 0)
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
                }
                .refreshable {
                    await getTeamsRequest()
                    print("run")
                }
                .navigationTitle("Teams")
            }
            .searchable(text: $searchText, prompt: "Enter Team Number")
        }
    }
}

struct Teams_Previews: PreviewProvider {
    static var previews: some View {
        Teams()
    }
}
