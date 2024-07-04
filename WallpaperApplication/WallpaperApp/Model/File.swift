//
//  File.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/06/28.
//

import Foundation

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
                completion(response) // データの取得後にcompletionを呼び出す
            } catch let error {
                print("JSONデコードエラー: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
