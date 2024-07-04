//
//  struct.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/06/28.
//

import Foundation

struct NewImg: Codable {
    let updated_at:String?
    let id: String
    let slug: String
//    let alternativeText: [String: String]
//    let createdAt: String
//    let updatedAt: String
    let width: Int
    let height: Int
    let color: String
//    let blurHash: String
//    let downloads: Int
    let likes: Int
//    let likedByUser: Bool
    let description: String?
    let user: User
    let urls: UrlsSize
    let links: Links
    let location: String?
}



struct User: Codable {
    let id: String?
    let username: String?
    let name: String?
//    let firstName: String
//    let lastName: String
//    let profileImage: ProfileImage
    let links: UserLinks
}

struct UrlsSize: Codable {
    let full: String
    let regular: URL?
    
}

struct Links: Codable {
    let `self`: String
    let html: String
    let download: String?
//    let downloadLocation: String
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

struct UserLinks: Codable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
}
