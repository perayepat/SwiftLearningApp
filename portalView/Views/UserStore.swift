//
//  UserStore.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/20.
//

import Foundation
import Combine

class UserStore: ObservableObject{
    //User Defualts Setting
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
