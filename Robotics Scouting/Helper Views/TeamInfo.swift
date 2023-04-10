//
//  TeamInfo.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct TeamInfo: View {
    
    var id = 0
    var selected = ""
    var teams : [Team] = []
    @State var pointBreakdownDisplay = false
    //Points
    var bottomAutoAveragePoints = 0.0
    var middleAutoAveragePoints = 0.0
    var topAutoAveragePoints = 0.0
    var bottomTeleAveragePoints = 0.0
    var middleTeleAveragePoints = 0.0
    var topTeleAveragePoints = 0.0
    //Flip Vars
    @State var chartFlip = false
    @State var cycleFlip = false
    @State var autoFlip = false
    @State var teleFlip = false
    
    var body: some View {
        ScrollView {
            VStack {
                //Chart
                VStack {
                    if (chartFlip == false) {
                        ChartView(name: selected)
                    } else {
                        VStack {
                            Text("Tele Points are the points scored during the 2 minute and 15 second period where the robot is manually controlled. Tele points includes charge station points.")
                                .padding([.bottom], 5)
                            Text("Auto Points are the points scored during the first 15 seconds when the robot acts autonomously. Auto Points includes charge station points.")
                                .padding([.bottom], 5)
                            Text("Other Points are points earned as bonuses such as parking points, ranking points, etc.")
                        }
                        .multilineTextAlignment(.center)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 30)
                        .frame(width: UIScreen.main.bounds.width - 20)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 3)
                )
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 5, y: 5)
                .onTapGesture {
                    chartFlip = !chartFlip

                }
                .font(.system(size: 14))
                .rotation3DEffect(
                    Angle.degrees(chartFlip ? 180:0),
                    axis: (0,1,0),
                    anchor: .center,
                    anchorZ: 0,
                    perspective: 0
                ).rotation3DEffect(
                    Angle.degrees(chartFlip ? 180:0),
                    axis: (0,1,0),
                    anchor: .center,
                    anchorZ: 0,
                    perspective: 0
                )
                .animation(Animation.linear(duration: 0.3), value: chartFlip)
                .padding([.bottom])
                //Cycles
                VStack {
                    VStack {
                        if (cycleFlip == false) {
                            VStack {
                                Text("Average Cycles: \(bottomAutoAveragePoints + middleAutoAveragePoints + topAutoAveragePoints + bottomTeleAveragePoints + middleTeleAveragePoints + topTeleAveragePoints, specifier: "%.3f")")
                                Text("Average Cycle Time: \(150/(bottomAutoAveragePoints + middleAutoAveragePoints + topAutoAveragePoints + bottomTeleAveragePoints + middleTeleAveragePoints + topTeleAveragePoints), specifier: "%.2f")s")
                            }
                                .fontWeight(.bold)
                                .padding([.top, .bottom], 8)
                                .frame(width: UIScreen.main.bounds.width - 20)
                                
                        } else {
                            VStack {
                                Text("A cycle is when a team successfuly scores a piece.")
                                    .padding([.bottom], 5)
                                Text("Average cycle time is calculated by dividing the total amount of cycles by the game time.")
                            }
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], 20)
                            .padding([.top, .bottom], 8)
                            .frame(width: UIScreen.main.bounds.width - 20)
                            }
                        }
                        .overlay (
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                        )
                        
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5, y: 5)
                        .onTapGesture {
                            cycleFlip = !cycleFlip
                        }
                        .rotation3DEffect(
                            Angle.degrees(cycleFlip ? 180:0),
                            axis: (0,1,0),
                            anchor: .center,
                            anchorZ: 0,
                            perspective: 0
                        ).rotation3DEffect(
                            Angle.degrees(cycleFlip ? 180:0),
                            axis: (0,1,0),
                            anchor: .center,
                            anchorZ: 0,
                            perspective: 0
                        )
                        .animation(Animation.linear(duration: 0.3), value: cycleFlip)
                        .padding([.bottom])
                }
                VStack {
                    //Points Info
                    VStack {
                        //Auto points
                        VStack {
                            if (autoFlip == false) {
                                Text("Auto Points")
                                    .fontWeight(.bold)
                                    .font(.system(size: 18))
                                    .padding([.top], 5)
                                VStack {
                                    Text("Average Bottom Auto: \(bottomAutoAveragePoints, specifier: "%.3f")")
                                        .padding([.top, .bottom], 3)
                                    Text("Average Middle Auto: \(middleAutoAveragePoints, specifier: "%.3f")")
                                        .padding([.top, .bottom], 3)
                                    Text("Average Top Auto: \(topAutoAveragePoints, specifier: "%.3f")")
                                        .padding([.top, .bottom], 3)
                                }
                                .fontWeight(.bold)
                                .frame(width: UIScreen.main.bounds.width - 20)
                            } else {
                                Text("Auto points are earned during the autonomous period. Scoring on the top spot is worth 6 points, scoring on the middle is worth 4 points, and scoring on bottom is worth 3 points.")
                                    .padding([.leading, .trailing], 30)
                                    .padding([.top, .bottom], 13)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .padding([.bottom, .top], 5)
                        .overlay (
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 3)
                        )
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5, y: 5)
                        .onTapGesture {
                            autoFlip = !autoFlip
                        }
                        .rotation3DEffect(
                            Angle.degrees(autoFlip ? 180:0),
                            axis: (0,1,0),
                            anchor: .center,
                            anchorZ: 0,
                            perspective: 0
                        ).rotation3DEffect(
                            Angle.degrees(autoFlip ? 180:0),
                            axis: (0,1,0),
                            anchor: .center,
                            anchorZ: 0,
                            perspective: 0
                        )
                        .animation(Animation.linear(duration: 0.3), value: autoFlip)
                        .padding([.bottom])
                        //Tele Points
                        VStack {
                                    if (teleFlip == false) {
                                        Text("Tele Points")
                                            .fontWeight(.bold)
                                            .font(.system(size: 18))
                                            .padding([.top], 5)
                                        VStack {
                                            Text("Average Bottom Tele: \(bottomTeleAveragePoints, specifier: "%.3f")")
                                                .padding([.top, .bottom], 3)
                                            Text("Average Middle Tele: \(middleTeleAveragePoints, specifier: "%.3f")")
                                                .padding([.top, .bottom], 3)
                                            Text("Average Top Tele: \(topTeleAveragePoints, specifier: "%.3f")")
                                                .padding([.top, .bottom], 3)
                                        }
                                        .fontWeight(.bold)
                                        .frame(width: UIScreen.main.bounds.width - 20)
                                } else {
                                    Text("Tele points are the points earned while the robot is controlled by a human player. Scoring on the top spot is worth 5 points, scoring on the middle is worth 3 points, and scoring on bottom is worth 2 points.")
                                        .padding([.leading, .trailing], 30)
                                        .padding([.top, .bottom], 13)
                                        .multilineTextAlignment(.center)
                                        .frame(width: UIScreen.main.bounds.width - 20)
                                }
                            }
                            .padding([.bottom, .top], 5)
                            .overlay (
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5, y: 5)
                            .onTapGesture {
                                teleFlip = !teleFlip
                            }
                            .rotation3DEffect(
                                Angle.degrees(teleFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            ).rotation3DEffect(
                                Angle.degrees(teleFlip ? 180:0),
                                axis: (0,1,0),
                                anchor: .center,
                                anchorZ: 0,
                                perspective: 0
                            )
                            .animation(Animation.linear(duration: 0.3), value: teleFlip)
                            .padding([.bottom])
                    }
                    .padding([.bottom], 30)
                }
            }
        }
        .navigationTitle("Team \(selected)")
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.gray.opacity(0.2))
    }
}

struct TeamInfo_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfo()
    }
}
