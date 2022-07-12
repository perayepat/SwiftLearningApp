    //
    //  PostList.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/12.
    //
    /// When using combine the data can be edited in any view
    
import SwiftUI

struct PostList: View {
    //MARK: Using Combine
    @ObservedObject var store  = DataStore()
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.system(.title, design: .serif)).bold()
                Text(post.body)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }.listStyle(.plain)
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
