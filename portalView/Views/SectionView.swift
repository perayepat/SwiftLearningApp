//
//  SectionView.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import SwiftUI

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text .uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        ///Contectual shadow
        .shadow(color: section.color.opacity(0.4), radius: 20, x: 0, y: 20)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: sectionData[0])
    }
}

