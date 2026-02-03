//
//  JoinMatchView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 03/01/2026.
//

import SwiftUI

//this is the screen where users are able to find matches and join them
struct JoinMatchView: View {

    // this is the different filter types users can choose from to find a match tailored to them
    @State private var postcode = ""
    @State private var selectedSkill = "Any"
    @State private var selectedAge = "Any"
    @State private var selectedPitch = "Any"
    @State private var selectedDuration = "Any"
    @State private var selectedDate = Date()

    //this is just an example of players that create matches and it appears in the app
    @State private var matches: [Match] = [
        Match(hostName: "Alex", postcode: "SW1A", skillLevel: "Beginner", ageGroup: "18–25", pitchSize: "5-a-side", duration: "60 min", date: Date(), price: 6.00),
        Match(hostName: "Jamie", postcode: "E14", skillLevel: "Intermediate", ageGroup: "26–35", pitchSize: "7-a-side", duration: "90 min", date: Date(), price: 8.50),
        Match(hostName: "Sam", postcode: "N1", skillLevel: "Advanced", ageGroup: "18–35", pitchSize: "11-a-side", duration: "90 min", date: Date(), price: 10.00)
    ]

    //this iis the logic for finding a match
    var filteredMatches: [Match] {
        matches.filter { match in
            (postcode.isEmpty || match.postcode.contains(postcode)) &&
            (selectedSkill == "Any" || match.skillLevel == selectedSkill) &&
            (selectedAge == "Any" || match.ageGroup == selectedAge) &&
            (selectedPitch == "Any" || match.pitchSize == selectedPitch) &&
            (selectedDuration == "Any" || match.duration == selectedDuration)
        }
    }

    //this is the main UI for the join match page
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                //this allows the users to scroll down and up
                ScrollView {
                    VStack(spacing: 20) {
                        
                        //this is the title of the screen
                        Text("Join a Match")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        // this is the filters sectuion where a drop down appears so they can pick their filter
                        Group {
                            filterTextField("Postcode", text: $postcode)

                            filterPicker("Skill Level", selection: $selectedSkill, options: ["Any", "Beginner", "Intermediate", "Advanced"])
                            filterPicker("Age Group", selection: $selectedAge, options: ["Any", "18–25", "26–35", "36+"])
                            filterPicker("Pitch Size", selection: $selectedPitch, options: ["Any", "5-a-side", "7-a-side", "11-a-side"])
                            filterPicker("Game Duration", selection: $selectedDuration, options: ["Any", "60 min", "90 min"])

                            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .colorScheme(.dark)
                        }
                        //this seperates the filters
                        Divider().background(Color.white.opacity(0.3))

                        // this lists the matches, if theres no matches the text bellow appears
                        VStack(spacing: 14) {
                            if filteredMatches.isEmpty {
                                Text("No matches found")
                                    .foregroundColor(.gray)
                            } else {
                                //this displays each match individually
                                ForEach(filteredMatches) { match in
                                    matchCard(match)
                                }
                            }
                        }
                    }
                    .padding()
                    //this just adds paddind around the UI
                }
            }
        }
    }

    //used repeatble text input foe the filters

    func filterTextField(_ title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .padding(12)
            .background(Color.white)
            .cornerRadius(8)
    }

    func filterPicker(_ title: String, selection: Binding<String>, options: [String]) -> some View {
        Picker(title, selection: selection) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.menu)
        .tint(.green)
    }

    func matchCard(_ match: Match) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hosted by \(match.hostName)")
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("\(match.pitchSize) • \(match.duration)")
                .foregroundColor(.white.opacity(0.8))

            Text("Skill: \(match.skillLevel) | Age: \(match.ageGroup)")
                .foregroundColor(.white.opacity(0.8))

            Text("Postcode: \(match.postcode)")
                .foregroundColor(.white.opacity(0.7))

            HStack {
                Text("£\(match.price, specifier: "%.2f")")
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Spacer()

                Button("Join") {
                    // Payment implemented during backend later
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    JoinMatchView()
}
