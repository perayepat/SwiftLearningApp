    // Notes
    ///Using the negative min Y to take the whole screen space
    ///`-60` takes the left and right screen space into consideration  and spaces it properly
    ///Using `SecondShow` we are able to show the elements in the geometry reader in full screen
    ///Using `courseData` we can loop through each course item and apply the geometry reader to it
    /// IN reapeating the  data we are using the index value to get each of the state
    /// // 1 //  using the indicies we are able to target each course in course data and access thier show property
    /// his allows us to use each cards geometry offsets to show the card full  screen no matter where it is on the screen
    /// // 2 //  the Z index has been fixed , because each card has a zindex of 0 when its active it will take priority
    /// // 3 // by creating the binding `active` we are able to trigger animaitons the same time goes fulll screen as we can't acces the show bool
    /// // 4 // We are passing the active index to the index so we know which card i being pressed and which card is active
    /// //5// if stetment to get tht cards that arent active and fade them out
    //




import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    @State var active  = false
    @State var activeIndex = -1
    @State var isScrollable = false
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear, value: active)
                .edgesIgnoringSafeArea(.all)
                
                
            ScrollView(.vertical) {
                VStack(spacing: 30) {
                    
                        Text("Course")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: active ? 20 : 0)
                    
                    ForEach(store.courses.indices, id: \.self) { index in
                        GeometryReader { geo in
                            CourseView(
                                isScrollable: isScrollable,
                                show: self.$store.courses[index].show,
                                active: self.$active,
                                activeIndex: self.$activeIndex,
                                course: self.store.courses[index],
                                index: index) //1//
                            .offset(y: self.store.courses[index].show ?  -geo.frame(in:.global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1) //5//
                                .scaleEffect(self.activeIndex != index && self.active ? 0.2 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.height : 0)
                            
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.store.courses[index].show  ? .infinity : screen.width - 60)
                        .zIndex(self.store.courses[index].show ? 1 : 0) //2//
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: active)
            }
            .statusBar(hidden: active ? true : false)
        } //3//
//        .animation(.linear(duration: 0.09), value: active)
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
            .environmentObject(UserStore())
    }
}

struct CourseView: View {
    @State var isScrollable: Bool
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    var course: Course
    var index: Int
    
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
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(.white)
                    }
                    Spacer()
                        //MARK: Transition logo
                    ZStack {
                        Image(uiImage: course.logo)
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
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
                //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280 )
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                //4//
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    self.isScrollable = true
                }
            }
            if isScrollable {
                CourseDetailView(course: course, show: $show,active: $active, activeIndex: $activeIndex)
                    .background(Color.white)
                    .transition(.identity)
//                    .animation(nil, value: show)
            }
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: show)
        .edgesIgnoringSafeArea(.all)

    }
}
