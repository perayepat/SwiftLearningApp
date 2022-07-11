//
//  UpdateStore.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/06.
//

import SwiftUI
import Combine


/// Allows us to edit data
/// swipe to delete and sort the data 
class UpdateStore: ObservableObject{
    @Published var updates : [Update] = updateData
}

//MARK: Add Updated items to the array 
func addUpdate(store: UpdateStore) {
    store.updates.append(Update(image: "Card1", title: "New Item", text: "Text", date: "Jan 1"))
}
