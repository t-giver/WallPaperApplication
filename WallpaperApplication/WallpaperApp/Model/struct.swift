    //
    //  struct.swift
    //  WallpaperApp
    //
    //  Created by spark-05 on 2024/06/28.
    //

    import Foundation

//**新着画像
    struct NewImg: Codable {
        let updated_at:String?
        let id: String
        let slug: String
        let width: Int
        let height: Int
        let color: String
        let likes: Int
        let description: String?
        let user: User
        let urls: UrlsSize
        let links: Links
        let alternative_slugs: AlternativeSlug
    }

struct AlternativeSlug: Codable{
    let ja:String?
}


    struct User: Codable {
        let id: String?
        let username: String?
        let name: String?
    
        let links: UserLinks
        let location: String?
    }

    struct UrlsSize: Codable {
        let full: String
        let regular: String?
        
    }

    struct Links: Codable {
        let `self`: String
        let html: String?
        let download: String?
    }

    struct ProfileImage: Codable {
        let small: String
        let medium: String
        let large: String
    }

    struct UserLinks: Codable {
        let `self`: String
        let html: String?
        let photos: String
        let likes: String
        let portfolio: String
    }



///** tag検索用
struct TagImg: Codable {
    let results: [NewImg]
}





