//
//  UpdateRow.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import SwiftUI

struct UpdateRow: View {
     var update: Update
    var body: some View {
        HStack {
            Image(update.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .background(Color.black)
                .cornerRadius(20)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(update.title)
                    .font(.system(size: 20, weight: .bold))
                
                Text(update.text)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                
                Text(update.date)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct UpdateRow_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRow(update: updateData[0])
    }
}
