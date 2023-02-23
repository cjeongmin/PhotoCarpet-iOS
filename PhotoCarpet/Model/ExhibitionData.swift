//
//  ExhibitionData.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/23.
//

import Foundation
import SwiftUI

final class ExhibitionData: ObservableObject {
    var userId: Int? // User Id 있으면, 다른 사람의 전시회
    
    @Published var photo1: Image?
    @Published var photo2: Image?
    @Published var photo3: Image?
    @Published var photo4: Image?
    
    @Published var price1: String = "" {
        didSet {
            let filtered = price1.filter { $0.isNumber }
            if filtered == "0" {
                price1 = ""
            } else if filtered.count > 9 {
                price1 = String(filtered[filtered.startIndex ..< filtered.index(filtered.endIndex, offsetBy: -1)])
            } else if price1 != filtered {
                price1 = filtered
            }
        }
    }
    @Published var price2: String = "" {
        didSet {
            let filtered = price2.filter { $0.isNumber }
            if filtered == "0" {
                price2 = ""
            } else if filtered.count > 9 {
                price2 = String(filtered[filtered.startIndex ..< filtered.index(filtered.endIndex, offsetBy: -1)])
            } else if price2 != filtered {
                price2 = filtered
            }
        }
    }
    @Published var price3: String = "" {
        didSet {
            let filtered = price3.filter { $0.isNumber }
            if filtered == "0" {
                price3 = ""
            } else if filtered.count > 9 {
                price3 = String(filtered[filtered.startIndex ..< filtered.index(filtered.endIndex, offsetBy: -1)])
            } else if price3 != filtered {
                price3 = filtered
            }
        }
    }
    @Published var price4: String = "" {
        didSet {
            let filtered = price4.filter { $0.isNumber }
            if filtered == "0" {
                price4 = ""
            } else if filtered.count > 9 {
                price4 = String(filtered[filtered.startIndex ..< filtered.index(filtered.endIndex, offsetBy: -1)])
            } else if price4 != filtered {
                price4 = filtered
            }
        }
    }
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var rawHashTags: String = ""
    @Published var date: Date = Date()
    
    @Published var isLiked: Bool = false
    
    var hashTags: [String] {
        var hashTags: [String] = []
        for tag in rawHashTags.components(separatedBy: " ") {
            if !tag.hasPrefix("#") { continue }
            if tag[tag.index(tag.startIndex, offsetBy: 1) ..< tag.endIndex].isEmpty { continue }
            hashTags.append(tag)
        }
        return hashTags
    }
    
    var dateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    var isFillData: Bool {
        return (
            !title.isEmpty &&
            !description.isEmpty &&
            hashTags.count > 0 &&
            photo1 != nil && !price1.isEmpty &&
            photo2 != nil && !price2.isEmpty &&
            photo3 != nil && !price3.isEmpty &&
            photo4 != nil && !price4.isEmpty
        )
    }
    
    func clear() {
        photo1 = nil
        photo2 = nil
        photo3 = nil
        photo4 = nil
        price1 = ""
        price2 = ""
        price3 = ""
        price4 = ""
        title = ""
        description = ""
        rawHashTags = ""
        date = Date()
        isLiked = false
    }
    
    func setDummyData() {
        userId = 1
        photo1 = Image("example")
        photo2 = Image("example")
        photo3 = Image("example")
        photo4 = Image("example")
        price1 = "1000"
        price2 = "2000"
        price3 = "3000"
        price4 = "4000"
        title = "테스트"
        description = "테스트용 더미 데이터입니다."
        rawHashTags = "#테스트 #태그1 #태그2 #iOS"
        date = Date()
        isLiked = true
    }
}
