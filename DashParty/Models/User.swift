//
//  User.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation

struct User: Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
}
