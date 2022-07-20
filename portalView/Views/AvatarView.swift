//
//  AvatarView.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import SwiftUI

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button {
            self.showProfile.toggle()
            
        } label: {
            Image("Avatar2")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(showProfile: .constant(true))
    }
}
