//
//  PullRequest.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 29/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import Foundation
import UIKit

struct PullRequest: Decodable {
    let html_url: String?
    let title: String?
    let body: String?
    let created_at: String?
    let user: PRUser?
}

struct PRUser: Decodable {
    let login: String?
    let avatar_url: String?
}
