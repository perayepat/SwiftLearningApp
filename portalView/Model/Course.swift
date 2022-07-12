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
   Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.5137254902, green: 0.5647058824, blue: 0.9803921569, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.9803921569, green: 0.6901960784, blue: 0.5921568627, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.9725490196, green: 0.5529411765, blue: 0.6784313725, alpha: 1), show: false)
]
