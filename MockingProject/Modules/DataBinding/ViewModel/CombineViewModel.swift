//
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class CombineViewModel: ObservableObject {
    var errorMessage: String?
    var error: Bool = false

    @Published var employees: [Employee] = []
    var employeeRepository: EmployeeRepository?

    init(repository: EmployeeRepository = APIEmployeeRepository()) {
        self.employeeRepository = repository
    }

    func setEmployeeRepository(repository: EmployeeRepository) {
        self.employeeRepository = repository
    }

    func fetchEmployees() {
        self.employeeRepository!.getEmployees { (result: DataResponse<EmployeesResponseDTO, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = response.map().data
                } else {
                    self.setError(BaseNetworkManager().getErrorMessage(response: result))
                }
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = message
        self.error = true
    }

}
