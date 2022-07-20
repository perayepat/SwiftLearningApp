    //
    //  Buttons.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/19.
    //
    ///Creating a background modifier and add a blur layer for that inner shadow

import SwiftUI
//MARK: Haptic feed back
func haptic(type: UINotificationFeedbackGenerator.FeedbackType){
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

struct Buttons: View {

    
    var body: some View {
        VStack(spacing: 50) {
            RectangleSubView()
            CircleButton()
            PayButton()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FAF9F6"))
        .ignoresSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct PayButton: View{
    @GestureState var tap = false
    @State var press = false
    
    var body: some View{
        ZStack {
            //MARK: fill effect
            Image("fingerprint")
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y: tap ? 0: 50))
                .animation(.easeInOut, value: press)
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            //switch to a check mark
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44,weight: .light))
                .foregroundColor(Color(hex: "c1d3fe"))
                .opacity(press ? 1 : 0)
                .scaleEffect(press ? 1 : 0)
            
        }
        .frame(width: 100, height: 100)
        .background(
            //MARK: Shadow Effect
            ZStack {
                LinearGradient(gradient: Gradient(colors: [press ? Color(hex: "d8e2dc"): Color(hex: "FAF9F6") , press ? Color(hex: "FAF9F6") : Color(hex: "FAF9F6")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //Inner Shadow
                Circle()
                    .stroke(Color.black.opacity(0.00001) ,lineWidth: 10)
                    .shadow(color: press ? Color(hex: "FAF9F6") : Color(hex: "d8e2dc" ), radius: 3, x: -5, y: -5)
                
                Circle()
                    .stroke(Color.white.opacity(0.00001) ,lineWidth: 10)
                    .shadow(color: press ? Color(hex: "d8e2dc") : Color.white, radius: 3, x: 5, y: 5)
            }
         
        )
        .clipShape(Circle())
        .overlay(
            //Animated rings
            Circle()
                .trim(from: tap ? 0.001 : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(hex: "f6fff8") , Color(hex: "abc4ff")]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 88, height: 88)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .animation(.easeInOut, value: tap)
                .shadow(color: Color(hex: "cddafd"), radius: 5, x: 3, y: 3)
        )
        .shadow(color: press ? Color(hex: "d8e2dc") : Color.white , radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color.white : Color(hex: "d8e2dc"), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().updating($tap) { currentState, gestureState, transaction in
                gestureState = currentState
                impact(style: .heavy)
                
            }
                .onEnded{ value in
                    haptic(type: .error)
                    self.press.toggle()
                }
        )
    }
}

struct CircleButton: View{
    @State var tap = false
    @State var press = false
    
    var body: some View{
        ZStack {
            //MARK: 3D image rotation effect
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0 )
                .rotation3DEffect(Angle(degrees: press ? 20: 0), axis: (x: 10, y: -10, z: 0))
            
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ?  0 : 90, y: press ? 0 : 90 )
                .rotation3DEffect(Angle(degrees: press ? 0: 20), axis: (x: -10, y: 10, z: 0))
        }
        .frame(width: 100, height: 100)
        .background(
            //MARK: Shadow Effect
            ZStack {
                LinearGradient(gradient: Gradient(colors: [press ? Color(hex: "d8e2dc"): Color(hex: "FAF9F6") , press ? Color(hex: "FAF9F6") : Color(hex: "FAF9F6")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //Inner Shadow
                Circle()
                    .stroke(Color.black.opacity(0.00001) ,lineWidth: 10)
                    .shadow(color: press ? Color(hex: "FAF9F6") : Color(hex: "d8e2dc" ), radius: 3, x: -5, y: -5)
                
                Circle()
                    .stroke(Color.white.opacity(0.00001) ,lineWidth: 10)
                    .shadow(color: press ? Color(hex: "d8e2dc") : Color.white, radius: 3, x: 5, y: 5)
            }
         
        )
        .clipShape(Circle())
        .shadow(color: press ? Color(hex: "d8e2dc") : Color.white , radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color.white : Color(hex: "d8e2dc"), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().onChanged{ value in
                self.tap = true
                impact(style: .heavy)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.tap = false
                }
            }
                .onEnded{ value in
                    haptic(type: .success)
                    self.press.toggle()
                }
        )
    }
}

struct RectangleSubView: View {
    @State var tap = false
    @State var press = false
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                
                ZStack {
                    press ? Color.white : Color(hex: "d8e2dc")
                    RoundedRectangle(cornerRadius: 16,style: .continuous)
                        .foregroundColor( press ?  Color(hex: "d8e2dc"):Color.white )
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16,style: .continuous)
                        //                            .foregroundColor(Color(hex: "BBCCC2"))
                        .fill(
                            
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "DFE7E3"), Color(hex: "F5F8F6")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16,style: .continuous))
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(.white.opacity(press ? 0 : 1))
                        .frame(width: press ? 95 : 54, height: press ? 4 : 50)
                        .background(Color(hex: "c6b3bd"))
                        .clipShape(RoundedRectangle(cornerRadius: 16,style: .continuous))
                        .shadow(color: Color(hex: "d1c2ca"), radius: 10, x: 10, y: 10)
                        .offset(x: press ? 55 : -10 , y: press ? 16 : 0)
                    
                    Spacer()
                }
            )
            .shadow(color: press ? Color.white : Color(hex: "DFE7E3"), radius: 20, x: 20, y: 20)
            .shadow(color: press ? Color(hex: "DFE7E3") : Color.white, radius: 20, x: -20, y: -20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                //same events as the drag gesture
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged{ value in
                    self.tap = true
                    impact(style: .heavy)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                    }
                }
                    .onEnded{ value in
                        haptic(type: .success)
                        self.press.toggle()
                    }
            )
    }
}
