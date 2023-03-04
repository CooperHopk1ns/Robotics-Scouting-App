//
//  Teams.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Teams: View {
    
    var testTeam = Team.init(name: "3082", averagePoints: 154, gamesPlayed: 21)
    @State var teams = TeamInfo().teams
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
                        TeamInfo(selected: Int(team.name) ?? 0, points: Int(team.averagePoints), gamesPlayed: team.gamesPlayed, average: Int(team.averagePoints)/team.gamesPlayed)
                    } label: {
                        Text("\(team.name)")
                    }
                }
                .refreshable {
                    if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
                        let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
                        teams = decodedTeamData ?? [testTeam]
                    }
                    print("------")
                    print(TeamsClass().teams)
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
