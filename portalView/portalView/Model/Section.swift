//
//  Section.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import Foundation
import SwiftUI


struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

//Sample Data
let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    Section(title: "Build a SwiftUI app", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Section(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
]
