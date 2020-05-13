//
//  APIManager+Injection.swift
//  Development
//
//  Created by Fitzgerald Afful on 12/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerAPIManager() {
        register { APIManager() }
    }
}
