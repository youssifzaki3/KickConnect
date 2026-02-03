//
//  LoginVIew.swift
//  KickConnect
//
//  Created by Youssif Zaki on 02/01/2026.
//

import SwiftUI

struct LoginView: View {

    //stores the input done by the users
    @State private var email = ""
    @State private var password = ""
    //used when user has incorrect input
    @State private var loginError = false
    //sends user to main view once they login successfully
    @State private var navigateToMain = false

    //tracks what field is being focused on by user
    @FocusState private var focusedField: Field?

    //gives the potnetiall focus fields
    enum Field {
        case email, password
    }

    //the layout of login view
    var body: some View {
        NavigationStack {
            ZStack {
                // Background (same as Sign Up)
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.08, blue: 0.08),
                        Color.black
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                //verstical stack with spacing
                VStack(spacing: 26) {

                    // adds KickConnect Logo
                    Image("kickconnect-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240)
                        .shadow(color: .white.opacity(0.35), radius: 25)

                    //this is the login title that appears
                    Text("Welcome back")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // email field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .email)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    focusedField == .email ? Color.blue : Color.clear,
                                    lineWidth: 2
                                )
                        )

                    // password field
                    SecureField("Password", text: $password)
                        .focused($focusedField, equals: .password)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    focusedField == .password ? Color.blue : Color.clear,
                                    lineWidth: 2
                                )
                        )

                    // if one of the emails or passwords are wrong this text appear
                    if loginError {
                        Text("Incorrect email or password")
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // login button
                    Button {
                        //this calls the login logic funtion
                        handleLogin()
                    } label: {
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)

                    //pushes everthing upwards
                    Spacer()
                    
                }
                .padding(.horizontal)
            }
            //once user logs in they are sent to main view page
            .navigationDestination(isPresented: $navigateToMain) {
                MainView()
            }
        }
    }

    //Login Logic function
    private func handleLogin() {
        //this looks at the users saved details
        let savedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")
    
        //this compares the data with saved credentials
        if email == savedEmail && password == savedPassword {
            //if login is successful the error message is hidden
            loginError = false
            navigateToMain = true
        } else {
            //if login is not sucessfull the error message shows 
            loginError = true
        }
    }
}

#Preview {
    LoginView()
}
