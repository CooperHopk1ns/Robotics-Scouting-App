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
    @State var minPoints = 0
    @State var minAutoPoints = 0
    @State var minTelePoints = 0
    @State var maxPoints = 0
    @State var maxAutoPoints = 0
    @State var maxTelePoints = 0
    @State private var isEditing = false
    @State var teams : [Team] = []
    
    func getMinAndMaxPointValues() {
        if let teamData = UserDefaults.standard.data(forKey: "teamsKey") {
            let decodedTeamData = try? JSONDecoder().decode([Team].self, from: teamData)
            teams.removeAll()
            for i in 0...(decodedTeamData?.count ?? 0) - 1 {
                teams.append((decodedTeamData?[i])!)
            }
        }
        if (teams.count > 0) {
            minPoints = teams[0].totalPoints
            minAutoPoints = teams[0].autoBottomPoints + teams[0].autoMiddlePoints + teams[0].autoTopPoints
            minTelePoints = teams[0].teleBottomPoints + teams[0].teleMiddlePoints + teams[0].teleTopPoints
            maxPoints = teams[0].totalPoints
            maxAutoPoints = teams[0].autoBottomPoints + teams[0].autoMiddlePoints + teams[0].autoTopPoints
            maxTelePoints = teams[0].teleBottomPoints + teams[0].teleMiddlePoints + teams[0].teleTopPoints
            for i in 1...teams.count-1 {
                //Check For Min Points
                if (teams[i].totalPoints < minPoints) {
                    minPoints = teams[i].totalPoints
                    print("Min points: \(minPoints)")
                }
                //Check For Min Auto Points
                if (teams[i].autoBottomPoints + teams[i].autoMiddlePoints + teams[i].autoTopPoints < minAutoPoints) {
                    minAutoPoints = teams[i].autoBottomPoints + teams[i].autoMiddlePoints + teams[i].autoTopPoints
                    print("Min Auto Points: \(minAutoPoints)")
                }
                //Check For Min Tele Points
                if (teams[i].teleBottomPoints + teams[i].teleMiddlePoints + teams[i].teleTopPoints < minTelePoints) {
                    minTelePoints = teams[i].teleBottomPoints + teams[i].teleMiddlePoints + teams[i].teleTopPoints
                    print("Min Tele Points: \(minTelePoints)")
                    
                }
                //Check For Max Points
                //Check For Min Points
                if (teams[i].totalPoints > minPoints) {
                    maxPoints = teams[i].totalPoints
                    print("Max points: \(maxPoints)")
                }
                //Check For Max Auto Points
                if (teams[i].autoBottomPoints + teams[i].autoMiddlePoints + teams[i].autoTopPoints > minAutoPoints) {
                    maxAutoPoints = teams[i].autoBottomPoints + teams[i].autoMiddlePoints + teams[i].autoTopPoints
                    print("Max Auto Points: \(maxAutoPoints)")
                }
                //Check For Max Tele Points
                if (teams[i].teleBottomPoints + teams[i].teleMiddlePoints + teams[i].teleTopPoints > minTelePoints) {
                    maxTelePoints = teams[i].teleBottomPoints + teams[i].teleMiddlePoints + teams[i].teleTopPoints
                    print("Max Tele Points: \(maxTelePoints)")
                    
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
                            Text("Min Points \(amtOfPoints, specifier: "%.f")")
                            Slider (
                                value: $amtOfPoints,
                                in: Double(minPoints)...Double(maxPoints),
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                        VStack {
                            Text("Min Auto Points \(amtOfAutoPoints, specifier: "%.f")")
                            Slider (
                                value: $amtOfAutoPoints,
                                in: Double(minAutoPoints)...Double(maxAutoPoints),
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                        VStack {
                            Text("Min Tele points \(amtOfTelePoints, specifier: "%.f")")
                            Slider (
                                value: $amtOfTelePoints,
                                in: Double(minTelePoints)...Double(maxTelePoints),
                                onEditingChanged: { editing in
                                    isEditing = editing
                                }
                            )
                            .padding()
                        }
                    }
                    
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
                    
                }
                .padding([.bottom], 200)
                .navigationTitle("Filters")
                
            }
            .frame(alignment: .top)
            .onAppear {
                getMinAndMaxPointValues()
            }
        }
}

struct TeamFilter_Previews: PreviewProvider {
    static var previews: some View {
        TeamFilter()
    }
}
