//
//  CreatePatientViewModel.swift
//  SAE
//
//  Created by Bruno Nascimento on 13/05/22.
//

import Foundation

final class CreatePatientViewModel: ObservableObject {
    
    @Published var newPatient: Patient = .empty
    
    var isValid: Bool {
        !newPatient.general.prefix.isEmpty &&
        !newPatient.general.firstName.isEmpty &&
        !newPatient.general.lastName.isEmpty &&
        !newPatient.contactInfo.phoneNumber.isEmpty
    }
    
    func clearAll() {
        self.newPatient = .empty
    }
}
