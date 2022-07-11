    //
    //  CourseList.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/11.
    //

///Using `SecondShow` we are able to show the elements in the geometry reader in full screen

import SwiftUI

struct CourseList: View {
    @State var show = false
    @State var secondShow = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                CourseView(show: $show)
                GeometryReader { geo in
                    CourseView(show: self.$secondShow)
                        .offset(y: self.secondShow ?  -geo.frame(in:.global).minY : 0)
                    ///Using the negative min Y to take the whole screen space
                }
                .frame(height: secondShow ? screen.height : 280)
                ///`-60` takes the left and right screen space into consideration  and spaces it properly 
                .frame(maxWidth: secondShow ? .infinity : screen.width - 60)
            }
            .frame(width: screen.width)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
                //MARK: Text that goes along with the card
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techiques like API data, packages and CMS. ")
                Text("About this Course")
                    .font(.title)
                    .bold()
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for IOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and peformance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions")
                
                Text("Minimal coding experience required, such as in HTML and css, Please note that Xcode 11 and Catalina are eessential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the ends of this page to help you navigate the issues you might encounter")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top )
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("SwiftUI Advanced")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("20 Sections")
                            .foregroundColor(.white)
                    }
                    Spacer()
                        //MARK: Transition logo
                    ZStack {
                        Image("Logo1")
                            .opacity(show ? 0 : 1)
                        
                            //Close button
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.show.toggle()
                                }
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                Image("Card1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
                //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280 )
            .background(Color(hue: 0.563, saturation: 0.388, brightness: 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(hue: 0.563, saturation: 0.388, brightness: 1.0), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: show)
        .edgesIgnoringSafeArea(.all)
    }
}
