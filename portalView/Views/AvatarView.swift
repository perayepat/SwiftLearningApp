    //
    //  AvatarView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/06.
    //

import SwiftUI

struct AvatarView: View {
    @Binding var showProfile: Bool
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        VStack {
            if user.isLogged {
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
            } else {
                Button {
                    self.showProfile.toggle()
                    self.user.showLogin.toggle()
                    
                } label: {
                    Image(systemName: "person")
                        .foregroundColor(.primary)
                        .font(.system(size: 16,weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color("background3"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
            }
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(showProfile: .constant(true))
            .environmentObject(UserStore())
    }
}
