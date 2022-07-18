    //
    //  CourseStore.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/18.
    //

import Foundation
import Contentful
import Combine
import SwiftUI

let client = Client(spaceId: "zz8v0c6a2hqn", accessToken: "tU6BFSANUXMv9o2Fc5AGIqSOUhqn4MXL3F5SRS-Uonc")

func getArray(id: String, completion: @escaping([Entry]) -> ()){
        //MARK: Getting data from contentful
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result{
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

//MARK: Using Combine to hold to courses
class CourseStore: ObservableObject{
    @Published var courses: [Course] = courseData
    
    init(){
        let colors = [ #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.8333813968, blue: 0.6716601548, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]

        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: (item.fields.linkedAsset(at: "image")?.url ?? URL(string: ""))!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: colors.randomElement()!,
                    show: false))
            }
        }
    }
}
