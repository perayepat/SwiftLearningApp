//
//  Course.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/11.
//

import Foundation
import UIKit

struct Course: Identifiable{
    var id = UUID()
    var title : String
    var subtitle : String
    var image : UIImage
    var logo : UIImage
    var color : UIColor
    var show : Bool
}

var courseData = [
   Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), show: false)
]
