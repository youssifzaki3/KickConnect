//
//  HostMatchView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 04/01/2026.
//

import SwiftUI

//shows the host match view
struct HostMatchView: View {

    //this stores the data and inputs that the host entered
    @State private var postcode = ""
    @State private var selectedDate = Date()
    @State private var skillLevel = "Beginner"
    @State private var ageGroup = "18–25"
    @State private var pitchSize = "5-a-side"
    @State private var playersPerTeam = 5
    @State private var pricePerPlayer = ""
    
    
    // this is used to see if the match has been created
    @State private var matchCreated = false

    // these are the options from which the host can pick from
    let skillLevels = ["Beginner", "Intermediate", "Advanced"]
    let ageGroups = ["18–25", "26–35", "36+"]
    let pitchSizes = ["5-a-side", "7-a-side", "11-a-side"]

    //the layout of host match
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                //allows users to scroll down and up
                ScrollView {
                    VStack(spacing: 20) {

                        //the title of this page
                        Text("Host a Match")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        // this is the heading for the location area
                        sectionTitle("Pitch Location")

                        //input area for the postcode
                        TextField("Postcode", text: $postcode)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)

                        // Map Placeholder for when maps api is integrated
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.25))

                            VStack(spacing: 8) {
                                //this is the map icon
                                Image(systemName: "map")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)

                                Text("Map will be shown here")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.caption)
                            }
                        }
                        .frame(height: 180)

                        // where the user inputs the match details
                        sectionTitle("Match Details")

                        //where the host inputs the date and time of the game
                        DatePicker(
                            "Date & Time",
                            selection: $selectedDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        .colorScheme(.dark)
                        
                        //where the host picks the skill level, age group and pitch size
                        picker("Skill Level", selection: $skillLevel, options: skillLevels)
                        picker("Age Group", selection: $ageGroup, options: ageGroups)
                        picker("Pitch Size", selection: $pitchSize, options: pitchSizes)
                        
                        //this is where the host picks the number of players per team up to 11
                        Stepper("Players per team: \(playersPerTeam)", value: $playersPerTeam, in: 3...11)
                            .foregroundColor(.white)

                        //this is where the host puts the price per player
                        TextField("Price per player (£)", text: $pricePerPlayer)
                            .keyboardType(.decimalPad)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)

                        // this is the button for when the host wants to complete the match creation
                        Button {
                            matchCreated = true
                        } label: {
                            Text("Create Match")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)

                        //this lets the user know that the match was created successfully
                        if matchCreated {
                            Text("Match created successfully!")
                                .foregroundColor(.green)
                                .font(.caption)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    //this is the resuable content for host to create a game 
    func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    func picker(_ title: String, selection: Binding<String>, options: [String]) -> some View {
        Picker(title, selection: selection) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.menu)
        .tint(.green)
    }
}

#Preview {
    HostMatchView()
}
