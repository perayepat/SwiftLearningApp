    //
    //  SuccessView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/20.
    //

import SwiftUI

struct SuccessView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Text("Logging you..")
                .font(.title)
                .bold()
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.4), value: show)
            
            LottieView(filename: "success")
                .frame(width: 300, height: 300)
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2), value: show)
        }
        .padding(.top,30)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: show)
        .onAppear{
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BlurView(style: .systemThinMaterialDark).opacity(show ? 1 : 0))
        .animation(.linear(duration: 0.7), value: show)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
