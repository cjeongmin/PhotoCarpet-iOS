//
//  ExhibitionAPI.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/26.
//

import Alamofire
import Foundation

func createExhibition(_ exhibition: Request.Exhibition) {
    struct ExhibitionRequest: Codable {
        let title: String
        let content: String
        let exhibitionDate: String
        let userId: Int
        let customMoods: [String]
    }

    let header: HTTPHeaders = [
        "Content-Type": "multipart/form-data; boundary=Boundary-\(UUID().uuidString)",
//        "Authorization": "Bearer \(User.shared.jwtToken)",
    ]

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
    let converted = formatter.string(from: exhibition.exhibitionDate)

    AF.upload(multipartFormData: { multipartFormData in
        if let data = try? JSONEncoder().encode(ExhibitionRequest(
            title: exhibition.title,
            content: exhibition.content,
            exhibitionDate: converted,
            userId: User.shared.userId,
            customMoods: exhibition.customMoods
        )) {
            multipartFormData.append(data, withName: "exhibitionRequest", mimeType: "application/json")
        }
        if let image = exhibition.photo.jpegData(compressionQuality: 1) {
            multipartFormData.append(image, withName: "file", fileName: "\(image).jpeg", mimeType: "image/jpeg")
        }
    }, to: Request.baseURL + "/exhibition/create", usingThreshold: UInt64(), method: .post, headers: header).response { response in
        guard let statusCode = response.response?.statusCode, statusCode == 200 else { return }
        print(statusCode)
    }
}
