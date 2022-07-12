    //
    //  PostList.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/12.
    //

import SwiftUI

struct PostList: View {
    @State var posts: [Post] = []
    
    var body: some View {
        List(posts) { post in
            Text("Hello, World!")
        }
        .onAppear{
            Api().getPosts{ (posts) in
                self.posts  = posts
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
