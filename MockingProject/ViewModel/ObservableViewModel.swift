//
//  HomeViewModel.swift
//  MockingProject
//
//  Created by Fitzgerald Afful on 04/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import Alamofire

protocol ObservableViewModelProtocol {
    func fetchEmployees()
    func setError(_ message: String)
    var employees: Observable<[Employee]> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

class ObservableViewModel: ObservableViewModelProtocol {
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)

    var apiManager: APIManager?
    var employees: Observable<[Employee]> = Observable([])

    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = Observable(response.data)
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }

}