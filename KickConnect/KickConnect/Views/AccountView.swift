//
//  AccountView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 07/01/2026.
//

import SwiftUI

struct AccountView: View {

    // MARK: - Profile State
    @State private var name = ""
    @State private var nickname = ""

    @State private var preferredFoot = "Right"
    @State private var selectedPositions: Set<String> = []
    @State private var age = ""
    @State private var sex = "Male"

    @State private var showDeleteConfirm = false
    @State private var confirmDelete = false
    @State private var loggedOut = false

    let feet = ["Right", "Left", "Both"]
    let positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"]
    let sexes = ["Male", "Female", "Other"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {

                        // MARK: - Profile Header
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 100, height: 100)

                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.white)
                            }

                            Text(name.isEmpty ? "Your Name" : name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)

                            Text(nickname.isEmpty ? "@nickname" : "@\(nickname)")
                                .foregroundColor(Color.gray)
                        }

                        // MARK: - Personal Details
                        sectionTitle("Personal Details")

                        groupField("Name", text: $name)
                        groupField("Nickname", text: $nickname)

                        // Preferred Foot
                        labeledPicker(
                            label: "Preferred Foot",
                            selection: $preferredFoot,
                            options: feet
                        )

                        // Preferred Positions (MAX 3)
                        sectionTitle("Preferred Position (max 3)")

                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(positions, id: \.self) { position in
                                Button {
                                    togglePosition(position)
                                } label: {
                                    HStack {
                                        Image(systemName: selectedPositions.contains(position)
                                              ? "checkmark.square.fill"
                                              : "square")
                                            .foregroundColor(Color.green)

                                        Text(position)
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }
                        }

                        groupField("Age", text: $age, keyboard: .numberPad)

                        // Sex
                        labeledPicker(
                            label: "Sex",
                            selection: $sex,
                            options: sexes
                        )

                        // MARK: - Games
                        sectionTitle("Your Games")
                        infoRow("Games Played", value: "0")
                        infoRow("Upcoming Games", value: "0")

                        // MARK: - Social
                        sectionTitle("Social")
                        infoRow("Followers", value: "0")
                        infoRow("Following", value: "0")

                        // MARK: - Support
                        sectionTitle("Support")

                        Button("Contact Us") { }
                            .foregroundColor(Color.green)

                        // MARK: - Account Actions
                        sectionTitle("Account")

                        Button("Log Out") {
                            loggedOut = true
                        }
                        .foregroundColor(Color.red)

                        Button("Delete Account") {
                            showDeleteConfirm.toggle()
                        }
                        .foregroundColor(Color.red)

                        if showDeleteConfirm {
                            VStack(alignment: .leading, spacing: 8) {
                                Button {
                                    confirmDelete.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: confirmDelete ? "checkmark.square.fill" : "square")
                                            .foregroundColor(Color.red)

                                        Text("Your data will be removed from the system within 2 months.")
                                            .font(.caption)
                                            .foregroundColor(Color.white)
                                    }
                                }

                                Button("Confirm Delete") {
                                    if confirmDelete {
                                        UserDefaults.standard.removePersistentDomain(
                                            forName: Bundle.main.bundleIdentifier!
                                        )
                                        loggedOut = true
                                    }
                                }
                                .foregroundColor(confirmDelete ? Color.red : Color.gray)
                                .disabled(!confirmDelete)
                            }
                        }

                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: $loggedOut) {
                WelcomeView()
            }
            .onAppear { loadProfile() }
            .onDisappear { saveProfile() }
        }
    }

    // MARK: - Helpers

    func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(maxWidth: CGFloat.infinity, alignment: .leading)
    }

    func groupField(
        _ placeholder: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        TextField(placeholder, text: text)
            .keyboardType(keyboard)
            .padding(12)
            .background(Color.white)
            .cornerRadius(8)
    }

    func labeledPicker(
        label: String,
        selection: Binding<String>,
        options: [String]
    ) -> some View {
        HStack {
            Text(label)
                .foregroundColor(Color.white)
            Spacer()
            Picker(label, selection: selection) {
                ForEach(options, id: \.self) { Text($0) }
            }
            .pickerStyle(.menu)
            .tint(Color.green)
        }
    }

    func infoRow(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(Color.white)
            Spacer()
            Text(value)
                .foregroundColor(Color.gray)
        }
    }

    func togglePosition(_ position: String) {
        if selectedPositions.contains(position) {
            selectedPositions.remove(position)
        } else if selectedPositions.count < 3 {
            selectedPositions.insert(position)
        }
    }

    // MARK: - Persistence (Frontend Only)

    func saveProfile() {
        UserDefaults.standard.set(name, forKey: "profileName")
        UserDefaults.standard.set(nickname, forKey: "profileNickname")
        UserDefaults.standard.set(preferredFoot, forKey: "profileFoot")
        UserDefaults.standard.set(Array(selectedPositions), forKey: "profilePositions")
        UserDefaults.standard.set(age, forKey: "profileAge")
        UserDefaults.standard.set(sex, forKey: "profileSex")
    }

    func loadProfile() {
        name = UserDefaults.standard.string(forKey: "profileName") ?? ""
        nickname = UserDefaults.standard.string(forKey: "profileNickname") ?? ""
        preferredFoot = UserDefaults.standard.string(forKey: "profileFoot") ?? "Right"
        age = UserDefaults.standard.string(forKey: "profileAge") ?? ""
        sex = UserDefaults.standard.string(forKey: "profileSex") ?? "Male"

        if let savedPositions = UserDefaults.standard.stringArray(forKey: "profilePositions") {
            selectedPositions = Set(savedPositions)
        }
    }
}

#Preview {
    AccountView()
}
