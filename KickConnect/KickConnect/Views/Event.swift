//
//  Event.swift
//  KickConnect
//
//  Created by Youssif Zaki on 07/01/2026.
//
import Foundation

//information for any kickConnect event
struct Event: Identifiable {
    //gives the event a unique id
    let id = UUID()
    //where admins put the title of event
    let title: String
    //where admins put the description of event
    let description: String
    //where admins put date and time of the event
    let date: Date
}
