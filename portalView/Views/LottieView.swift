//
//  LottieView.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/20.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable{
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        //Create and assign the animation view and the animation
        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        //Scale animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        //specify the contraints so it takes the full width and height of the container
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        //insert the animetion view in the view we are returning
        view.addSubview(animationView)
        
        //Constraints
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
