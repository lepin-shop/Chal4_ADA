//
//  PostFilter.swift
//  Chal4_ADA
//
//  Created by Danniel on 10/07/26.
//

enum PostFilter: String, CaseIterable, Identifiable {
    case active = "Active", booked = "Booked", done = "Done"
    var id: Self { self }
}
