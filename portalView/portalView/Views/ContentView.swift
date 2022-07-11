    //
    //  ContentView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/06/20.
    //

import SwiftUI

struct ContentView: View {
        ///animation states jsut like react
    @State var show = false
        ///the x and y postition of the drag will be saved here
    @State var viewState = CGSize.zero
    ///shows the full card view
    @State var showCard = false
    /// controls the bottom states anchor positions
    @State var bottomState = CGSize.zero
    ///
    @State var showFull = false
    
    var body: some View {
            ///Zstack allowing 3D layering
        ZStack {
                //MARK: title
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset( y: showCard ? -200 : 0)
                .animation(.default, value: showCard)
                .animation(Animation
                    .default
                    .delay(0.1),
                           value: showCard)
            
            
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .background(.blue)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1: 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5),value: showCard)
                .animation(.easeInOut(duration: 0.5),value: show)
            
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3), value: showCard)
                .animation(.easeInOut(duration: 0.3), value: show)
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0), value: viewState)
                .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0), value: showCard)
                .onTapGesture {
                        //switch between bluring and unbluring the background
                    showCard.toggle()
                }
                ///Gesture implementation with a state variable
                .gesture(
                    DragGesture().onChanged{ value in
                        self.viewState = value.translation
                        self.show = true
                    }
                        .onEnded{ value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            ///Usefull for knowing which height to dismiss the card
//            Text("\(bottomState.height)").offset(y: -300)
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y:showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
//MARK: Animation
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: bottomState)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showFull)
            
//MARK: Gestures
                .gesture(
                    DragGesture().onChanged{ value in
                        /// store bottom card position
                        self.bottomState = value.translation
                        if self.showFull{
                        self.bottomState .height += -300
                            
                            ///maximum drag so you dont see the bottom of the card
                            if self.bottomState.height < -300
                            {
                                self.bottomState.height = -300
                            }
                        }
                    }
                    ///Reset position on drag
                        .onEnded{ value in
                            
                            ///dismiss the view with a slide
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            ///show full card
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                                self.bottomState.height = -300 // show the full card
                                self.showFull = true
                            }
                            else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding()
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
                ///with this technique we can use any image as a background
        }
      
    }
}

struct BackCardView: View {
    var body: some View {
            // adding a layer underneth the card
            ///background shadow
        VStack{
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate proof that User has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                RingView(color1: .red, color2: .orange, width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut.delay(0.3), value: show)
                
                VStack(alignment: .leading, spacing: 8.0){
                    Text("SwiftUI")
                        .bold()
                    Text("12 of 12 sections completed \n10 Hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}



