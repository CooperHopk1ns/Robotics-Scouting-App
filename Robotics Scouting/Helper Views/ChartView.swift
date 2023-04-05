//
//  ChartView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/22/23.
//

import SwiftUI
import Charts

struct AverageDataTeamStructDisplay: Identifiable {
    let id : Int
    let team : AverageTeamStruct
    let points : Double
    let pointType: String
}

struct ChartView: View {
    
    @State var teams : [Team] = []
    @State var teamsData : [AverageTeamStruct] = []
    @State var averageTeams : [AverageDataTeamStruct] = []
    @State var averageTeamsChartDisplay : [AverageDataTeamStructDisplay] = []
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
        count = Double(averageTeams.count)
        print("Average Teams Count is \(averageTeams.count)")
        if (averageTeams.count > 0) {
            for i in 0...averageTeams.count-1 {
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
        //Create Average Team
        @State var averageTeam = AverageDataTeamStruct(team: "1", matchNumber: "0", alliance: "blue", autoBottom: averageAutoBottomPoints, autoMiddle: averageAutoMiddlePoints, autoTop: averageAutoTopPoints, teleBottom: averageTeleBottomPoints, teleMiddle: averageTeleMiddlePoints, teleTop: averageTeleTopPoints, allianceLinks: averageAllianceLinks, autoCharged: averageAutoCharged, teleCharged: averageTeleCharged, engagement: averageEngagement, mobilityPoints: averageMobilityPoints, parkingPoints: averageParkingPoints, rankingPoints: averageRankingPoints)
        @State var newAverageTeam = AverageTeamStruct(id: 2, name: "Average Team", totalPoints: averagePoints, obj: averageTeam)
        //New
        @State var newSelectedTelePointsDisplayTeam = AverageDataTeamStructDisplay(id: 1, team: selectedTeam, points: selectedTeam.obj.teleBottom + selectedTeam.obj.teleMiddle + selectedTeam.obj.teleTop + selectedTeam.obj.teleCharged, pointType: "Tele Points")
        @State var newSelectedAutoPointsDisplayTeam = AverageDataTeamStructDisplay(id: 1, team: selectedTeam, points: selectedTeam.obj.autoBottom + selectedTeam.obj.autoMiddle + selectedTeam.obj.autoTop + selectedTeam.obj.autoCharged, pointType: "Auto Points")
        @State var newSelectedOtherPointsDisplayTeam = AverageDataTeamStructDisplay(id: 1, team: selectedTeam, points: selectedTeam.obj.mobilityPoints + selectedTeam.obj.parkingPoints + selectedTeam.obj.rankingPoints, pointType: "Other Points")
        averageTeamsChartDisplay.append(newSelectedTelePointsDisplayTeam)
        averageTeamsChartDisplay.append(newSelectedAutoPointsDisplayTeam)
        averageTeamsChartDisplay.append(newSelectedOtherPointsDisplayTeam)
        @State var newAverageTelePointsDisplayTeam = AverageDataTeamStructDisplay(id: 2, team: newAverageTeam, points: newAverageTeam.obj.teleBottom + newAverageTeam.obj.teleMiddle + newAverageTeam.obj.teleTop + newAverageTeam.obj.teleCharged, pointType: "Tele Points")
        @State var newAverageAutoPointsDisplayTeam = AverageDataTeamStructDisplay(id: 2, team: newAverageTeam, points: newAverageTeam.obj.autoBottom + newAverageTeam.obj.autoMiddle + newAverageTeam.obj.autoTop + newAverageTeam.obj.autoCharged, pointType: "Auto Points")
        @State var newAverageOtherPointsDisplayTeam = AverageDataTeamStructDisplay(id: 2, team: newAverageTeam, points: newAverageTeam.obj.mobilityPoints + newAverageTeam.obj.parkingPoints + newAverageTeam.obj.rankingPoints, pointType: "Other Points")
        averageTeamsChartDisplay.append(newAverageTelePointsDisplayTeam)
        averageTeamsChartDisplay.append(newAverageAutoPointsDisplayTeam)
        averageTeamsChartDisplay.append(newAverageOtherPointsDisplayTeam)
    }
    
    var body: some View {
        VStack {
            //Chart View
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(averageTeamsChartDisplay) { team in
                        BarMark (
                            //Selected Team Points
                            x: .value("Team", team.team.name),
                            //Add up values in average team struct and use here
                            y: .value("Total Points", team.points),
                            width: 50,
                            stacking: .standard
                        )
                        //.foregroundStyle(Color.blue)
                        .cornerRadius(12, style: .continuous)
                        .foregroundStyle(by: .value("Point Type", team.pointType))
                    }
                }
                .padding(20)
            } else {
                // Fallback on earlier versions
            }
        }
        .onAppear {
            decodeJSONAverageTeamData()
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
