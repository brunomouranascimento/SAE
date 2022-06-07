//
//  HomeViewModel.swift
//  SAE
//
//  Created by Bruno Nascimento on 13/05/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var patients: [Patient] = []
    
    func add(_ patient: Patient) {
        patients.append(patient)
    }
}
