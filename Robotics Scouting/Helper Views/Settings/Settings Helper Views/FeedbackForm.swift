//
//  FeedbackForm.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/6/23.
//

import SwiftUI

struct FeedbackForm: View {
    
    @State var feedbackType = ["General", "Design", "Bug", "Overall Improvements"]
    @State var feedbackTypeSelected = ""
    @State var feedback = ""
    @State var canFollowUp = false
    @State var userEmail = ""
    
    func sendFeedback() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    //Category Of Feedback
                    Text("Catgegory")
                    Picker("Alliance", selection: $feedbackTypeSelected) {
                        ForEach(feedbackType, id: \.self) { type in
                            Text(type.capitalized)
                        }
                    }
                    .padding([.leading, .trailing], 100)
                    .padding([.bottom], 20)
                    //Body Text
                    Text("Enter Feedback Here")
                    //FIX TO BE ABLE TO WORK WITH LOWER LEVEL IOS
                    TextField (
                        "Feedback",
                        text: $feedback
                        //axis: .vertical
                    )
                    .padding([.trailing, .leading], 40)
                    .padding([.bottom], 20)
                    .textFieldStyle(.roundedBorder)
                    //Where To Reach To Follow Up
                    Toggle("Can We Follow Up With You", isOn: $canFollowUp)
                        .toggleStyle(.switch)
                        .padding([.leading, .trailing], 60)
                        .padding([.bottom], 20)
                    if (canFollowUp == true) {
                        VStack {
                            Text("Please Enter Your Email Below")
                            TextField (
                                "Email",
                                text: $userEmail
                                )
                            .textFieldStyle(.roundedBorder)
                            .padding([.leading, .trailing], 40)
                            }
                        .padding()
                        }
                    }
                    //Submit
                    Button("Submit") {
                        sendFeedback()
                    }
            }
        }
        .navigationTitle("Send Feedback")
    }
}

struct FeedbackForm_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackForm()
    }
}
