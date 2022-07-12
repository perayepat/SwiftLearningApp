//
//  DataStore.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/12.
//


import SwiftUI
import Combine


class DataStore: ObservableObject{
    @Published var posts: [Post] = []
        //MARK: update publishes posts and run when initialised
    
    init(){
        getPosts()
    }

    func getPosts(){
        Api().getPosts{ (posts) in
            self.posts = posts
        }
    }
}
