//
//  InternetCheck.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 4/13/23.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}

struct NoInternetView : View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .frame(width: 200, height: 155)
            Text("No Internet")
                .font(.system(size: 30))
        }
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView()
    }
}
