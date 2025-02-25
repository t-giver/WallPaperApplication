//
//  File.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/06/28.
//

import Foundation
///**新着画像**
class SendData {
    func fetchImg(completion: @escaping ([NewImg]?) -> Void) {
        let urlString = "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=J28noNyOy-HJj56bxWfO8dmlhDJZ_LXb2W6b8v5j0XE"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([NewImg].self, from: data)
                completion(response)// データの取得後にcompletionを呼び出す
            } catch let error {
                print("JSONデコードエラー: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
///**ソートページ**
class TagData {
    var tagColor = ""
    
    func fetchTagImg(tagColor: String, completion: @escaping ([NewImg]?) -> Void) {
        let tagUrlString = "https://api.unsplash.com/search/photos/?query=\(tagColor)&per_page=5&color=\(tagColor)&client_id=J28noNyOy-HJj56bxWfO8dmlhDJZ_LXb2W6b8v5j0XE"
        
        guard let url = URL(string: tagUrlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tagResponse = try decoder.decode(TagImg.self, from: data)
                completion(tagResponse.results)
            } catch let error {
                print("JSONデコードエラー: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

