    //
    //  Home.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/06.
    //

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        ZStack {
            
                //MARK: Root for every screen
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
                //MARK: Home view & Top Bar
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
          
                .background(Color("background1"))
                ///Effects
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                ///Animation
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .edgesIgnoringSafeArea(.all)
            
            MenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: viewState)
                .onTapGesture {
                    self.showProfile.toggle()
                }
                ///gesture modifier with a gesture offset so it can be dragged
                .gesture(
                    DragGesture().onChanged{ value in
                        self.viewState = value.translation
                    }
                        .onEnded{ value in
                                //MARK: Drag to dismiss
                            if self.viewState.height > 50 {
                                self.showProfile = false
                            }
                            self.viewState = .zero
                        }
                )
            if user.showLogin{
                LoginView()
                    .overlay {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                        .padding()
                        .onTapGesture {
                            self.user.showLogin = false
                        }
                    }
            }
            if showContent {
                BlurView(style: .systemUltraThinMaterial).edgesIgnoringSafeArea(.all)
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserStore())
    }
}

    ///Helps us avoid hard coding the screen sizes
    ///
let screen = UIScreen.main.bounds


