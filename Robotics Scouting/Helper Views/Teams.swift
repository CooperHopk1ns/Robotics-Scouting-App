//
//  Teams.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Teams: View {
    
    @State var teams : [Team] = []
    
    var testTeam = Team.init(id: 3082, name: "3082", averagePoints: Double(140), gamesPlayed: 4, autoBottomPoints: 12, autoMiddlePoints: 12, autoTopPoints: 12, teleBottomPoints: 12, teleMiddlePoints: 12, teleTopPoints: 12)
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
    
    let teamJSONDict = """
    {
    "success":team,
    "team": {
            "id":3,
            "team":"team",
            "matchNumber":"",
            "alliance":"",
            "priorMatches":"0",
            "autoBottom":"0",
            "autoMiddle":"0",
            "autoTop":"0",
            "teleBottom":"0",
            "teleMiddle":"0",
            "teleTop":"0",
            allianceLinks":"0",
            "createdAt":"2023-03-08T05:02:41.107Z",
            "updatedAt":"2023-03-08T05:02:41.107Z"
            }
    }
    """.data(using: .utf8)!
    
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
        guard let teamsURL = URL(string: "http://api.etronicindustries.org/v1/team/data") else {
            print("error")
            return
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: teamsURL)
            
            let decodedTeamData = try! JSONDecoder().decode(responseJSON.self, from: data)
            print("Data is \(decodedTeamData)")
            var points = Int(decodedTeamData.team.autoBottom) ?? 1
            if (points == 0) {
                points+=1
            }
            var tempTeam = Team(id: decodedTeamData.team.id, name: String(decodedTeamData.team.id), averagePoints: Double(points), gamesPlayed: Int(decodedTeamData.team.priorMatches) ?? 0, autoBottomPoints: Int(decodedTeamData.team.autoBottom) ?? 0, autoMiddlePoints: Int(decodedTeamData.team.autoMiddle) ?? 0, autoTopPoints: Int(decodedTeamData.team.autoTop) ?? 0, teleBottomPoints: Int(decodedTeamData.team.teleBottom) ?? 0, teleMiddlePoints: Int(decodedTeamData.team.teleMiddle) ?? 0, teleTopPoints: Int(decodedTeamData.team.teleTop) ?? 0)
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
            print("Error, Invalid Data")
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List((searchResults), id: \.self) {team in
                    NavigationLink {
                        TeamInfo(selected: Int(team.name) ?? 0, gamesPlayed: team.gamesPlayed, average: Int(team.averagePoints)/team.gamesPlayed, points: Int(team.averagePoints), bottomAutoAveragePoints: team.autoBottomPoints/team.gamesPlayed, middleAutoAveragePoints: team.autoMiddlePoints/team.gamesPlayed, topAutoAveragePoints: team.autoTopPoints/team.gamesPlayed, bottomTeleAveragePoints: team.teleBottomPoints/team.gamesPlayed, middleTeleAveragePoints: team.teleMiddlePoints/team.gamesPlayed, topTeleAveragePoints: team.teleTopPoints/team.gamesPlayed)
                    } label: {
                        Text("\(team.name)")
                    }
                }
                
                .onAppear {
                    //ADD JSON GET FROM AYMANS API
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
