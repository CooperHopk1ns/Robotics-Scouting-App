//
//  InputPointsView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/18/23.
//

import SwiftUI

struct InputPointsView: View {
    
    //Basic Variables
    @State var screenWidth = UIScreen.main.bounds.width
    //Points Variables
    @State var rankingPoints = 0
    @State var pointsScored = 0
    @State var bottomAutoPoints = 0
    @State var middleAutoPoints = 0
    @State var topAutoPoints = 0
    @State var bottomTelePoints = 0
    @State var middleTelePoints = 0
    @State var topTelePoints = 0
    @State var allianceLinks = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("Points")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding([.bottom], 2)
                Text("Enter Pieces Scored")
                    .font(.system(size: 13))
                //Auto Points
                VStack {
                    //Bottom Auto Points
                    HStack {
                        Stepper {
                            Text("Bottom Auto: \(bottomAutoPoints)")
                        } onIncrement: {
                            bottomAutoPoints += 1
                        } onDecrement: {
                            if (bottomAutoPoints >= 1) {
                                bottomAutoPoints -= 1
                            }
                        }
                        .padding([.leading, .trailing], screenWidth/6)
                    }
                    //Middle Auto Points
                    HStack {
                        Stepper {
                            Text("Middle Auto: \(middleAutoPoints)")
                        } onIncrement: {
                            middleAutoPoints += 1
                        } onDecrement: {
                            if (middleAutoPoints >= 1) {
                                middleAutoPoints -= 1
                            }
                        }
                        .padding([.leading, .trailing], screenWidth/6)
                    }
                    //Top Auto Points
                    HStack {
                        Stepper {
                            Text("Top Auto: \(topAutoPoints)")
                        } onIncrement: {
                            topAutoPoints += 1
                        } onDecrement: {
                            if (topAutoPoints >= 1) {
                                topAutoPoints -= 1
                            }
                        }
                        .padding([.leading, .trailing], screenWidth/6)
                    }
                }
                //Tele Points
                VStack {
                    //Bottom Tele Points
                    HStack {
                        Stepper {
                            Text("Bottom Tele: \(bottomTelePoints)")
                        } onIncrement: {
                            bottomTelePoints += 1
                        } onDecrement: {
                            if (bottomTelePoints >= 1) {
                                bottomTelePoints -= 1
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], screenWidth/6)
            }
            //Middle Tele Points
            HStack {
                Stepper {
                    Text("Middle Tele: \(middleTelePoints)")
                } onIncrement: {
                    middleTelePoints += 1
                } onDecrement: {
                    if (middleTelePoints >= 1) {
                        middleTelePoints -= 1
                    }
                }
                .padding([.leading, .trailing], screenWidth/6)
            }
            //Top Tele Points
            HStack {
                Stepper {
                    Text("Top Tele: \(topTelePoints)")
                } onIncrement: {
                    topTelePoints += 1
                } onDecrement: {
                    if (topTelePoints >= 1) {
                        topTelePoints -= 1
                    }
                }
                .padding([.leading, .trailing], screenWidth/6)
            }
        }
    }
}

struct InputPointsView_Previews: PreviewProvider {
    static var previews: some View {
        InputPointsView()
    }
}
