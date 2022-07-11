    //
    //  RingView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/11.
    //

import SwiftUI

//MARK: Customisable component

struct RingView: View {
    var color1 = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    var color2 = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    var width : CGFloat =  200
    var height : CGFloat = 200
    var percent : CGFloat = 90
    @Binding var show : Bool
   
    
    var body: some View {
        //we can use variables as long as we return the container
        let multiplier = width / 44
        let progress = 1 -  (percent / 100)
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: width)
            
            Circle()
               .trim(from: show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(
                        color1),Color(color2)]),startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.2), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
                .animation(.easeInOut, value: show)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
