//
//  User.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/23.
//

import Foundation

final class User {
    static let shared: User = User()
    private init() {}
    
    let userId: Int = 0
}
