//
//  UpdateDetail.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import SwiftUI

struct UpdateDetailView: View {
    var update: Update = updateData[0]
    
    var body: some View {
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .navigationTitle(update.title)
        }
        .listStyle(.plain)
        
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailView()
    }
}
