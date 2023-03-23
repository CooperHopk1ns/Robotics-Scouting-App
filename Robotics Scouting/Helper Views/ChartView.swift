//
//  ChartView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/22/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @State var teams : [Team] = []
    @State var teamsData : [Team] = []
    var name = 0
    @State var location = 0
    @State var selectedTeamData : Team = Team(id: 0, name: "0", gamesPlayed: 0, totalPoints: 0, autoBottomPoints: 0, autoMiddlePoints: 0, autoTopPoints: 0, teleBottomPoints: 0, teleMiddlePoints: 0, teleTopPoints: 0, autoCharged: 0, teleCharged: 0, engagement: 0, mobilityPoints: 0, parkingPoints: 0, rankingPoints: 0)
    @State var selectedChartView = "total points"
    @State var chartViews = ["total points", "auto points", "tele points"]
    @State var yValueText = "Total Points"
    @State var yValue = 0
    
    //Decoded JSON For Team Data
    func decodeJSONTeamData() {
        if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
            let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
            teams.removeAll()
            if (decodedTeamData?.count ?? 0 > 0) {
                for i in 0...(decodedTeamData?.count ?? 1)-1 {
                    teams.append(decodedTeamData![i])
                    if (teams[i].name == String(name)) {
                        location = i
                    }
                }
            }
            selectedTeamData = Team(id: teams[location.self].id, name: teams[location].name, gamesPlayed: teams[location].gamesPlayed, totalPoints: teams[location].totalPoints, autoBottomPoints: teams[location].autoBottomPoints, autoMiddlePoints: teams[location].autoMiddlePoints, autoTopPoints: teams[location].autoTopPoints, teleBottomPoints: teams[location].teleBottomPoints, teleMiddlePoints: teams[location].teleMiddlePoints, teleTopPoints: teams[location].teleTopPoints, autoCharged: teams[location].autoCharged, teleCharged: teams[location].teleCharged, engagement: teams[location].engagement, mobilityPoints: teams[location].mobilityPoints, parkingPoints: teams[location].parkingPoints, rankingPoints: teams[location].rankingPoints)
        }
    }
    
    //Set Teams Data var
    @State var count = 1
    @State var averagePoints = 0
    @State var averageAutoBottomPoints = 0
    @State var averageAutoMiddlePoints = 0
    @State var averageAutoTopPoints = 0
    @State var averageTeleBottomPoints = 0
    @State var averageTeleMiddlePoints = 0
    @State var averageTeleTopPoints = 0
    @State var averageAutoCharged = 0
    @State var averageTeleCharged = 0
    @State var averageEngagement = 0
    @State var averageMobilityPoints = 0
    @State var averageParkingPoints = 0
    @State var averageRankingPoints = 0
    
    func assignTeamsData() {
        
        
        for i in 0...teams.count-1 {
            print("teams \(teams.count)")
            print("Count \(count)")
            count += 1
            averagePoints += teams[i].totalPoints
            averageAutoBottomPoints += teams[i].autoBottomPoints
            averageAutoMiddlePoints += teams[i].autoMiddlePoints
            averageAutoTopPoints += teams[i].autoTopPoints
            averageTeleBottomPoints += teams[i].teleBottomPoints
            averageTeleMiddlePoints += teams[i].teleMiddlePoints
            averageTeleTopPoints += teams[i].teleTopPoints
            averageAutoCharged += teams[i].autoCharged
            averageTeleCharged += teams[i].teleCharged
            averageEngagement += teams[i].engagement
            averageMobilityPoints += teams[i].mobilityPoints
            averageParkingPoints += teams[i].parkingPoints
            averageRankingPoints += teams[i].rankingPoints
        }
        averagePoints = Int(averagePoints/count)
        averageAutoBottomPoints = Int(averageAutoBottomPoints/count)
        averageAutoMiddlePoints = Int(averageAutoMiddlePoints/count)
        averageAutoTopPoints = Int(averageAutoTopPoints/count)
        averageTeleBottomPoints = Int(averageTeleBottomPoints/count)
        averageTeleMiddlePoints = Int(averageTeleMiddlePoints/count)
        averageTeleTopPoints = Int(averageTeleTopPoints/count)
        averageAutoCharged = Int(averageAutoCharged/count)
        averageTeleCharged = Int(averageTeleCharged/count)
        averageEngagement = Int(averageEngagement/count)
        averageMobilityPoints = Int(averageMobilityPoints/count)
        averageParkingPoints = Int(averageParkingPoints/count)
        averageRankingPoints = Int(averageRankingPoints/count)
        //Assign
        @State var averageTeam = Team(id: -1, name: "Average Team", gamesPlayed: 0, totalPoints: averagePoints, autoBottomPoints: averageAutoBottomPoints, autoMiddlePoints: averageAutoMiddlePoints, autoTopPoints: averageAutoTopPoints, teleBottomPoints: averageTeleBottomPoints, teleMiddlePoints: averageTeleMiddlePoints, teleTopPoints: averageTeleTopPoints, autoCharged: averageAutoCharged, teleCharged: averageTeleCharged, engagement: averageEngagement, mobilityPoints: averageMobilityPoints, parkingPoints: averageParkingPoints, rankingPoints: averageRankingPoints)
        teamsData.removeAll()
        teamsData.append(selectedTeamData)
        teamsData.append(averageTeam)
    }
    
    var body: some View {
        VStack {
            //Chart Selector
            Picker("Chart Type", selection: $selectedChartView) {
                ForEach(chartViews, id: \.self) { chart in
                        Text(chart.capitalized)
                    }
            }
            .pickerStyle(.segmented)
            .padding([.leading, .trailing], 10)
            .padding([.bottom])
            .onChange(of: chartViews) { view in
                yValueText = "Auto Points"
                yValue = 12
            }
            //Chart View
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(teamsData) { team in
                        BarMark (
                            //Selected Team Points
                            x: .value("Points", team.name),
                            y: .value("Total Points", team.totalPoints),
                            width: 50
                        )
                        .foregroundStyle(Color.blue)
                        .cornerRadius(12, style: .continuous)
                    }
                }
                .padding(20)
            } else {
                // Fallback on earlier versions
            }
        }
        .onAppear {
            decodeJSONTeamData()
            assignTeamsData()
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
