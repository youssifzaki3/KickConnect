//
//  EventsView.swift
//  KickConnect
//
//  Created by Youssif Zaki on 05/01/2026.
//

import SwiftUI

struct EventsView: View {

    
    @State private var events: [Event] = [
        // left empty when there are no events  show "No upcoming events"
        // show "No upcoming events"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {

                    //creates the title screen
                    Text("Events")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top)

                    if events.isEmpty {
                        emptyState
                    } else {
                        //allows users to scroll when there are several events
                        ScrollView {
                            VStack(spacing: 16) {
                                //when there are events cards will be created for each one
                                ForEach(events) { event in
                                    eventCard(event)
                                }
                            }
                            .padding()
                        }
                    }

                    Spacer()
                }
            }
        }
    }

    //this is shown when theres no events
    var emptyState: some View {
        VStack(spacing: 14) {
            //has the calendar icon
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(Color.gray)

            //when theres no events this is said
            Text("No upcoming events")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)

            // text for empty games
            Text("Check back soon for KickConnect sponsored events.")
                .font(.caption)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
        }
        //adds spacing from the top
        .padding(.top, 60)
    }

    // creats a card for the events when theres events
    func eventCard(_ event: Event) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(Color.white)
            
            //this creates a description of the event
            Text(event.description)
                .font(.subheadline)
                .foregroundColor(Color.white.opacity(0.8))

            //this formats the data and time of the event
            Text(event.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(Color.gray)
        }
        //creats padding and styling for the event card
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    EventsView()
}
