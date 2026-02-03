//
//  SignUpView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 01/01/2026.
//

import SwiftUI

struct SignUpView: View {

    // this stores users inputs in the fields
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    //this ensures that users accept t&c before being allowed to sign up
    @State private var acceptedTerms = false
    //this sends the users to the login page once they have signed up
    @State private var navigateToLogin = false

    // creates a focus state depending on what the user is doing
    @FocusState private var focusedField: Field?

    //can be focused on either email, password or confrim email
    enum Field {
        case email, password, confirmPassword
    }

    //uses regex to ensure the email has a valid format
    private var isEmailValid: Bool {
        let regex =
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        //tests to see if the email matches the regex format
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: email)
    }

    // this checks the passowrd field isnt empty and the passowrdds match
    private var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    //this allows the user to check the text box only when he carries out this first
    private var canAcceptTerms: Bool {
        isEmailValid && passwordsMatch
    }

    //sign up button is enabled only once they accept terms
    private var canSignUp: Bool {
        canAcceptTerms && acceptedTerms
    }

    // sign up page view
    var body: some View {
        //allows the user to navigate between different screens
        NavigationStack {
            //stacks stuff over eachother-background
            ZStack {
                // Background graident colours with black at the bottom
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.08, blue: 0.08),
                        .black
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                //where i implemented the main content
                VStack(spacing: 26) {

                    // my KickCOnnect Logo
                    Image("kickconnect-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240)
                        .shadow(color: .white.opacity(0.35), radius: 25)
                        .padding(.bottom, 10)
                    

                    // title under image
                    Text("Let’s get you game ready")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    // email field
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Email", text: $email)
                        //shows email
                            .keyboardType(.emailAddress)
                        //doesnt allow auto-captials
                            .textInputAutocapitalization(.never)
                        //disables autocorrection
                            .autocorrectionDisabled()
                        //tracks the focus statte and add a blue outline around the focused area
                            .focused($focusedField, equals: .email)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        focusedField == .email ? .blue : .clear,
                                        lineWidth: 2
                                    )
                            )
                        
                        // if the email is invalid a read text saying email is invalid appears
                        if !email.isEmpty && !isEmailValid {
                            Text("Email is invalid")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    // password field
                    SecureField("Password", text: $password)
                    //hides the typed characters
                        .focused($focusedField, equals: .password)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                    //tracks the focus statte and add a blue outline around the focused area
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    focusedField == .password ? .blue : .clear,
                                    lineWidth: 2
                                )
                        )

                    // Cconfirm password field
                    VStack(alignment: .leading, spacing: 6) {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .focused($focusedField, equals: .confirmPassword)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)
                        //tracks the focus statte and add a blue outline around the focused area
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        focusedField == .confirmPassword ? .blue : .clear,
                                        lineWidth: 2
                                    )
                            )
                        
                        
                        if !confirmPassword.isEmpty && !passwordsMatch {
                            Text("Passwords do not match")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    // checkbox field
                    Button {
                        //only allows textbox to be checked once emails and passwords are valid
                        if canAcceptTerms {
                            acceptedTerms.toggle()
                        }
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            //creates the textbox
                            Image(systemName: acceptedTerms ? "checkmark.square.fill" : "square")
                                .font(.title3)
                                .foregroundColor(acceptedTerms ? .green : .white)

                            //creates the text by the textbox
                            Text("By ticking this you accept KickConnect to gather and store your data for use.")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                    
                    //disables the checkbix until terms are accpeted
                    .disabled(!canAcceptTerms)
                    //while its disabled the opacaity is lowered
                    .opacity(canAcceptTerms ? 1 : 0.5)
                    .padding(.top, 8)

                    // sign up butto,
                    Button {
                        // this is temporary frontend authentication until iimplement backend authentication using firebse
                        UserDefaults.standard.set(email, forKey: "userEmail")
                        UserDefaults.standard.set(password, forKey: "userPassword")

                        //this navigates the user to login screen once they sign up
                        navigateToLogin = true
                    } label: {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!canSignUp)
                    .opacity(canSignUp ? 1 : 0.6)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.horizontal)
            }
            //naviagates to login view page 
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    SignUpView()
}
