//
//  Match.swift
//  KickConnect
//
//  Created by Youssif Zaki on 21/01/2026.
//

import Foundation

struct Match: Identifiable {
    //this generates a unique id for the host show in join games
    let id = UUID()
    //shows the name of the host
    let hostName: String
    //shows the location of the match being hosted
    let postcode: String
    //shows the skill level for the match
    let skillLevel: String
    //shows the age group
    let ageGroup: String
    //shows the pitch size
    let pitchSize: String
    //shows how long the match will be
    let duration: String
    //shows the date of the match
    let date: Date
    //shows the price per player for each match
    let price: Double
}
