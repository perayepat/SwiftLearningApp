//
//  UserStore.swift
//  portalView
//
//  Created by IACD-013 on 2022/07/20.
//

import Foundation
import Combine

class UserStore: ObservableObject{
    @Published var isLogged = false
    @Published var showLogin = false
}
