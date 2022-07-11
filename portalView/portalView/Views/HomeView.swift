    //
    //  HomeView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/06.
    //

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    @State var showUpdate = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack{
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 30))
                    
                    Spacer()
                    AvatarView(showProfile: $showProfile)
                    
                    Button {
                        self.showUpdate.toggle()
                    } label: {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16,weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.red.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.red.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate){
                            ///show new update view
                        UpdateListView()
                    }
                    
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false){
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom,30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                ScrollView(.horizontal,showsIndicators: false) {
                        ///assign with Hstack so that it works with hortizontally the scroll view is dependant on the content and not on the context
                    HStack(spacing: 30) {
                        ForEach(sectionData) { item in
                                ///3D scroll using a geometry reader
                                ///gives us the edges of each card
                            GeometryReader { geometry  in
                                SectionView(section: item)
                                    ///add a wacky mode for more fun
                                    ///`-30` to remove the offset at the beginning
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30 ) / -20), axis: (x: 0, y: 10, z: 0))
                                
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Course")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.leading,30)
                .offset(y: -60)
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(true),showContent: .constant(true))
    }
}

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                RingView(color1: .cyan, color2: .purple, width: 44, height: 44, percent: 80, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .bold()
                        .modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 min today")
                        .modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: .red, color2: .purple, width: 32, height: 32, percent: 50, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: .cyan, color2: .green, width: 32, height: 32, percent: 90, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
