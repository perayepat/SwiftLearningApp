//
//  LoadingView.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        //needed to run on top of the login view
        VStack {
            LottieView(filename:"loading")
                .frame(width: 200, height: 200)
        }
            
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
