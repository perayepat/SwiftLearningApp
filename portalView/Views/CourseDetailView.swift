    //
    //  CourseDetailView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/12.
    //

import SwiftUI

struct CourseDetailView: View {
    var course: Course
    @Binding var show:Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Text(course.subtitle)
                                .foregroundColor(.white)
                        }
                        Spacer()
                            //MARK: Transition logo
                        ZStack {
                                //Close button
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                        }
                    }
                    Spacer()
                    Image(uiImage: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(show ? 30 : 20)
                .padding(.top, show ? 30 : 0)
//                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280 )
                .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height - 400 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Take your SwiftUI app to the App Store with advanced techiques like API data, packages and CMS. ")
                    Text("About this Course")
                        .font(.title)
                        .bold()
                    Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for IOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and peformance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions")
                    
                    Text("Minimal coding experience required, such as in HTML and css, Please note that Xcode 11 and Catalina are eessential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the ends of this page to help you navigate the issues you might encounter")
                }
                .padding(30)
            }
        }
        .frame(height: screen.height)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: courseData[0], show: .constant(true),active: .constant(true),activeIndex: .constant(-1))
    }
}
