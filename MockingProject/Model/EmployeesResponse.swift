//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

struct EmployeesResponse: Codable, Equatable {

    var data: [Employee]
    let status: String

    static func == (lhs: EmployeesResponse, rhs: EmployeesResponse) -> Bool {
        return (lhs.data == rhs.data)
    }
}
