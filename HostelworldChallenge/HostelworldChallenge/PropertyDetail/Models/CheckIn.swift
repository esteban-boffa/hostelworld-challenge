//
//  CheckIn.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

struct CheckIn: Codable {
    // Sometimes it fails because the mocks are returning different types for checkIn.
    // Some mocks bring Strings and others Ints.
    let startsAt: String
    let endsAt: String
}
