//
//  Data.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/12.
//

import SwiftUI

struct Post: Codable, Identifiable{
    var id : Int
    var title : String
    var body : String
}

class Api{
    func getPosts(completion: @escaping ([Post]) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let posts = try!JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}
