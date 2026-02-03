//
//  WelcomeVIew.swift
//  KickConnect
//
//  Created by Youssif Zaki on 01/01/2026.
//

import SwiftUI

//the swiftUI screen view is called welcome view
struct WelcomeView: View {
//this is where i created the user interface for the page
    var body: some View {
// allows us to move between screens
        NavigationStack {
 //allows us to stack things ontop of each other
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.08, blue: 0.08),
                        Color.black
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                //by implementing ignores safe area i ensured that the whole scrren is covered with the gradient colours
                .ignoresSafeArea()
            
                // vertical stacking with spacing
                VStack(spacing: 30) {
                    Image("kickconnect-logo")
                    //resizes the image
                        .resizable()
                    //ensures the image is proportionate and still fits in the frame
                        .scaledToFit()
                        .frame(width: 400)
                    //creates a shadow around the logo
                        .shadow(color: .white.opacity(1), radius: 100)

                    //app text for the welcome page
                    Text("Connecting footballers anytime, anywhere")
                    //sets the title size
                        .font(.title2)
                    //makes the text bold
                        .fontWeight(.bold)
                    //changes the colour to green
                        .foregroundColor(.green)
                    //enures the text is centres
                        .multilineTextAlignment(.center)

                    //this semds user to page sign up view when the sign up button is pressed
                    NavigationLink {
                        SignUpView()
                    } label: {
                       //this is the button texy
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)

                    //this semds user to page login view when the login button is pressed
                    NavigationLink {
                        LoginView()
                    } label: {
                        //this is the button text
                        Text("Log In")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    //this outlines the button and gives it a white color
                    .buttonStyle(.bordered)
                    .tint(.white)
                }
                .padding()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
