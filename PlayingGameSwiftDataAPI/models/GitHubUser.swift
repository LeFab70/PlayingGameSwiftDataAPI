//
//  GitHubUser.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-11.
//
//dto
import Foundation
struct GitHubUser: Decodable {
    let login: String
    let name: String?
    let avatar_url: String
    
}
