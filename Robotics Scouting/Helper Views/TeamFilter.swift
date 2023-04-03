//
//  TeamFilter.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/12/23.
//

import SwiftUI

struct TeamFilter: View {
    
    @Environment(\.dismiss) var dismiss
    @State var amtOfPoints = 0.0
    @State var amtOfAutoPoints = 0.0
    @State var amtOfTelePoints = 0.0
    @State var minPoints = 0.0
    @State var minAutoPoints = 0.0
    @State var minTelePoints = 0.0
    @State var maxPoints = 0.0
    @State var maxAutoPoints = 0.0
    @State var maxTelePoints = 0.0
    @State private var isEditing = false
    @State var averageTeams : [AverageDataTeamStruct] = []
    
    func resetFilters() {
        amtOfPoints = 0.0
        amtOfAutoPoints = 0.0
        amtOfTelePoints = 0.0
    }
    
    func getCurrentFilters() {
        let decodedMinPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfPointsFilterKey") ?? Data())
        let decodedMinAutoPoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfAutoPointsFilterKey") ?? Data())
        let decodedMinTelePoints = try? JSONDecoder().decode(Double.self, from: UserDefaults.standard.data(forKey: "amtOfTelePointsFilterKey") ?? Data())
        amtOfPoints = decodedMinPoints ?? 0
        amtOfAutoPoints = decodedMinAutoPoints ?? 0
        amtOfTelePoints = decodedMinTelePoints ?? 0
    }
    
    func getMinAndMaxPointValues() {
        if let teamData = UserDefaults.standard.data(forKey: "averageTeamsKey") {
            let decodedTeamData = try? JSONDecoder().decode([AverageDataTeamStruct].self, from: teamData)
            averageTeams.removeAll()
            for i in 0...(decodedTeamData?.count ?? 1) - 1 {
                averageTeams.append((decodedTeamData?[i])!)
            }
        }
        if (averageTeams.count > 0) {
            minPoints = averageTeams[0].autoBottom + averageTeams[0].autoMiddle + averageTeams[0].autoTop + averageTeams[0].teleBottom + averageTeams[0].teleMiddle + averageTeams[0].teleTop + averageTeams[0].allianceLinks + averageTeams[0].autoCharged + averageTeams[0].teleCharged + averageTeams[0].engagement + averageTeams[0].mobilityPoints + averageTeams[0].parkingPoints + averageTeams[0].rankingPoints
            minAutoPoints = averageTeams[0].autoBottom + averageTeams[0].autoMiddle + averageTeams[0].autoTop
            minTelePoints = averageTeams[0].teleBottom + averageTeams[0].teleMiddle + averageTeams[0].teleTop
            maxPoints = averageTeams[0].autoBottom + averageTeams[0].autoMiddle + averageTeams[0].autoTop + averageTeams[0].teleBottom + averageTeams[0].teleMiddle + averageTeams[0].teleTop + averageTeams[0].allianceLinks + averageTeams[0].autoCharged + averageTeams[0].teleCharged + averageTeams[0].engagement + averageTeams[0].mobilityPoints + averageTeams[0].parkingPoints + averageTeams[0].rankingPoints
            maxAutoPoints = averageTeams[0].autoBottom + averageTeams[0].autoMiddle + averageTeams[0].autoTop
            maxTelePoints = averageTeams[0].teleBottom + averageTeams[0].teleMiddle + averageTeams[0].teleTop
            for i in 1...averageTeams.count-1 {
                //Check For Min Points
                if (averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints < minPoints) {
                    minPoints = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints
                    //print("Min points: \(minPoints)")
                }
                //Check For Min Auto Points
                if (averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop < minAutoPoints) {
                    minAutoPoints = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop
                    //print("Min Auto Points: \(minAutoPoints)")
                }
                //Check For Min Tele Points
                if (averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop < minTelePoints) {
                    minTelePoints = averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop
                    //print("Min Tele Points: \(minTelePoints)")
                    
                }
                //Check For Max Points
                //Check For Min Points
                if (averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints > minPoints) {
                    maxPoints = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop + averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop + averageTeams[i].allianceLinks + averageTeams[i].autoCharged + averageTeams[i].teleCharged + averageTeams[i].engagement + averageTeams[i].mobilityPoints + averageTeams[i].parkingPoints + averageTeams[i].rankingPoints
                    //print("Max points: \(maxPoints)")
                }
                //Check For Max Auto Points
                if (averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop > minAutoPoints) {
                    maxAutoPoints = averageTeams[i].autoBottom + averageTeams[i].autoMiddle + averageTeams[i].autoTop
                    //print("Max Auto Points: \(maxAutoPoints)")
                }
                //Check For Max Tele Points
                if (averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop > minTelePoints) {
                    maxTelePoints = averageTeams[i].teleBottom + averageTeams[i].teleMiddle + averageTeams[i].teleTop
                    //print("Max Tele Points: \(maxTelePoints)")
                    
                }
            }
        }
        }
        
        var body: some View {
            NavigationView {
                VStack {
                    //Filters
                    VStack {
                        VStack {
                            Text("Min Points \(amtOfPoints, specifier: "%.2f")")
                            Slider (
                                value: $amtOfPoints,
                                in: minPoints...maxPoints,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                        VStack {
                            Text("Min Auto Points \(amtOfAutoPoints, specifier: "%.2f")")
                            Slider (
                                value: $amtOfAutoPoints,
                                in: minAutoPoints...maxAutoPoints,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                        VStack {
                            Text("Min Tele points \(amtOfTelePoints, specifier: "%.2f")")
                            Slider (
                                value: $amtOfTelePoints,
                                in: minTelePoints...maxTelePoints,
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                    }
                    //Reset Filters
                    HStack {
                        Button("Reset") {
                            resetFilters()
                        }
                        .foregroundColor(.red)
                        .padding()
                        .padding([.trailing], 10)
                        .overlay(Rectangle().frame(width: 1, height: 30, alignment: .trailing).foregroundColor(Color.gray), alignment: .trailing)
                        //Dismiss
                        Button("Enter") {
                            if let encoded = try? JSONEncoder().encode(amtOfPoints) {
                                UserDefaults.standard.set(encoded, forKey: "amtOfPointsFilterKey")
                            }
                            if let encoded = try? JSONEncoder().encode(amtOfTelePoints) {
                                UserDefaults.standard.set(encoded, forKey: "amtOfTelePointsFilterKey")
                            }
                            if let encoded = try? JSONEncoder().encode(amtOfAutoPoints) {
                                UserDefaults.standard.set(encoded, forKey: "amtOfAutoPointsFilterKey")
                            }
                            dismiss()
                        }
                        .padding([.leading], 15)
                    }
                }
                .padding([.bottom], 200)
                .navigationTitle("Filters")
                
            }
            .frame(alignment: .top)
            .onAppear {
                getCurrentFilters()
                getMinAndMaxPointValues()
            }
        }
}

struct TeamFilter_Previews: PreviewProvider {
    static var previews: some View {
        TeamFilter()
    }
}
