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
    @State var teamsData : [AverageTeamStruct] = []
    @State var averageTeams : [AverageDataTeamStruct] = []
    var name = ""
    @State var location = 0
    @State var selectedChartView = "total points"
    @State var chartViews = ["total points", "auto points", "tele points"]
    @State var yValueText = "Total Points"
    @State var yValue = 0
    @State var selectedTeam : AverageTeamStruct = AverageTeamStruct(id: 0, name: "3082", totalPoints: 0.0, obj: AverageDataTeamStruct(team: "0", matchNumber: "0", alliance: "blue", autoBottom: 0.0, autoMiddle: 0.0, autoTop: 0.0, teleBottom: 0.0, teleMiddle: 0.0, teleTop: 0.0, allianceLinks: 0.0, autoCharged: 0.0, teleCharged: 0.0, engagement: 0.0, mobilityPoints: 0.0, parkingPoints: 0.0, rankingPoints: 0.0))
    //Decoded JSON For Team Data
        func decodeJSONTeamData() {
            if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
                let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
                teams.removeAll()
                if (decodedTeamData?.count ?? 0 > 0) {
                    for i in 0...(decodedTeamData?.count ?? 1)-1 {
                        teams.append(decodedTeamData![i])
                    }
                }
            }
        }
    //Decode Average Team Data JSON
    func decodeJSONAverageTeamData() {
        if let averageTeamData = UserDefaults.standard.data(forKey: "averageTeamsKey") {
            let decodedAverageTeamData = try? JSONDecoder().decode([AverageDataTeamStruct].self, from: averageTeamData)
            averageTeams.removeAll()
            if (decodedAverageTeamData?.count ?? 0 > 0) {
                for i in 0...(decodedAverageTeamData?.count ?? 1)-1 {
                    averageTeams.append(decodedAverageTeamData![i])
                    print(decodedAverageTeamData![i])
                    print("runnin")
                }
            }
        }
        for i in 0...averageTeams.count-1 {
            if (averageTeams[i].team == name) {
                selectedTeam = AverageTeamStruct(id: 1, name: averageTeams[i].team, totalPoints: averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints, obj: AverageDataTeamStruct(team: averageTeams[i].team, matchNumber: "0", alliance: "blue", autoBottom: averageTeams[i].autoBottom, autoMiddle: averageTeams[i].autoMiddle, autoTop: averageTeams[i].autoTop, teleBottom: averageTeams[i].teleBottom, teleMiddle: averageTeams[i].teleMiddle, teleTop: averageTeams[i].teleTop, allianceLinks: averageTeams[i].allianceLinks, autoCharged: averageTeams[i].autoCharged, teleCharged: averageTeams[i].teleCharged, engagement: averageTeams[i].engagement, mobilityPoints: averageTeams[i].mobilityPoints, parkingPoints: averageTeams[i].parkingPoints, rankingPoints: averageTeams[i].rankingPoints))
            }
        }
    }
    
    //Set Teams Data var
    @State var count = 0.0
    @State var averagePoints = 0.0
    @State var averageAutoBottomPoints = 0.0
    @State var averageAutoMiddlePoints = 0.0
    @State var averageAutoTopPoints = 0.0
    @State var averageTeleBottomPoints = 0.0
    @State var averageTeleMiddlePoints = 0.0
    @State var averageTeleTopPoints = 0.0
    @State var averageAutoCharged = 0.0
    @State var averageTeleCharged = 0.0
    @State var averageEngagement = 0.0
    @State var averageMobilityPoints = 0.0
    @State var averageParkingPoints = 0.0
    @State var averageRankingPoints = 0.0
    @State var averageAllianceLinks = 0.0
    func assignTeamsData() {
        
        count = Double(teams.count)
        print("Count \(count)")
        print("Average Teams Count is \(averageTeams.count)")
        if (teams.count > 0) {
            for i in 0...teams.count-1 {
                print("I is \(i)")
                averagePoints += averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints + averageTeams[i].allianceLinks
                averageAutoBottomPoints += averageTeams[i].autoBottom
                averageAutoMiddlePoints += averageTeams[i].autoMiddle
                averageAutoTopPoints += averageTeams[i].autoTop
                averageTeleBottomPoints += averageTeams[i].teleBottom
                averageTeleMiddlePoints += averageTeams[i].teleMiddle
                averageTeleTopPoints += averageTeams[i].teleTop
                averageAutoCharged += averageTeams[i].autoCharged
                averageTeleCharged += averageTeams[i].teleCharged
                averageEngagement += averageTeams[i].engagement
                averageMobilityPoints += averageTeams[i].mobilityPoints
                averageParkingPoints += averageTeams[i].parkingPoints
                averageRankingPoints += averageTeams[i].rankingPoints
                averageAllianceLinks += averageTeams[i].allianceLinks
            }
            averagePoints = averagePoints/count
            averageAutoBottomPoints = averageAutoBottomPoints/count
            averageAutoMiddlePoints = averageAutoMiddlePoints/count
            averageAutoTopPoints = averageAutoTopPoints/count
            averageTeleBottomPoints = averageTeleBottomPoints/count
            averageTeleMiddlePoints = averageTeleMiddlePoints/count
            averageTeleTopPoints = averageTeleTopPoints/count
            averageAutoCharged = averageAutoCharged/count
            averageTeleCharged = averageTeleCharged/count
            averageEngagement = averageEngagement/count
            averageMobilityPoints = averageMobilityPoints/count
            averageParkingPoints = averageParkingPoints/count
            averageRankingPoints = averageRankingPoints/count
            averageAllianceLinks = averageAllianceLinks/count
        }
        //Assign
        @State var averageTeam = AverageDataTeamStruct(team: "1", matchNumber: "0", alliance: "blue", autoBottom: averageAutoBottomPoints, autoMiddle: averageAutoMiddlePoints, autoTop: averageAutoTopPoints, teleBottom: averageTeleBottomPoints, teleMiddle: averageTeleMiddlePoints, teleTop: averageTeleTopPoints, allianceLinks: averageAllianceLinks, autoCharged: averageAutoCharged, teleCharged: averageTeleCharged, engagement: averageEngagement, mobilityPoints: averageMobilityPoints, parkingPoints: averageParkingPoints, rankingPoints: averageRankingPoints)
        @State var newAverageTeam = AverageTeamStruct(id: 2, name: "Average Team", totalPoints: averagePoints, obj: averageTeam);
        teamsData.removeAll()
        teamsData.append(selectedTeam)
        teamsData.append(newAverageTeam)
        print("POINTSJSLKDNFSJF \(newAverageTeam.totalPoints)")
        print("POINSTNSLFNSFSDD \(selectedTeam.totalPoints)")
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
                            x: .value("Team", team.name),
                            //Add up values in average team struct and use here
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
            decodeJSONAverageTeamData()
            assignTeamsData()
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
