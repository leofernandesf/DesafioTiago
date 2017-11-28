//
//  Iten.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 27/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import Foundation
import UIKit

struct GitObject: Decodable {
    let items: [Iten]?
}

struct Iten: Decodable {
    let id: Int?
    let name: String?
    let full_name: String?
    let description: String?
    let stargazers_count: Int?
    let forks_count: Int?
    let owner: Owner?

}

struct Owner: Decodable {
    let login: String?
    let id: Int?
    let avatar_url: String?
    let url: String?
}

struct User: Decodable {
    let name: String?
}
