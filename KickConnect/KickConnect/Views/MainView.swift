//
//  MainView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 02/01/2026.
//

import SwiftUI

//this is what appears when the user logis in successfully
struct MainView: View {

    //a navigation bar appears at the bottom with these 4 sections 
    var body: some View {
        TabView {

            JoinMatchView()
                .tabItem {
                    Label("Join", systemImage: "soccerball")
                }

            HostMatchView()
                .tabItem {
                    Label("Host", systemImage: "plus.circle")
                }

            EventsView()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle")
                }
        }
        .tint(.green)
    }
}

#Preview {
    MainView()
}
