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
                .refreshable {
                    if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
                        let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
                        teams.removeAll()
                        if (decodedTeamData?.count ?? 0 > 0) {
                            for i in 0...(decodedTeamData?.count ?? 0)-1 {
                                teams.append(decodedTeamData?[i] ?? testTeam)
                                //Add Check
                            }
                        }
                    }
                    print("------")
                    print(teams)
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
