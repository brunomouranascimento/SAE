//
//  Patient.swift
//  SAE
//
//  Created by Bruno Nascimento on 13/05/22.
//

import Foundation

struct Patient: Identifiable {
    let id = UUID()
    var general: General
    var contactInfo: ContactInfo
    var emergency: Emergency
}

extension Patient {
    struct General {
        var prefix: String
        var gender: Gender
        var firstName: String
        var lastName: String
        var company: String
    }
}

extension Patient.General {
    enum Gender: String, Identifiable, CaseIterable {
        var id: Self { self }
        case masculino
        case feminino
        case na = "Prefere não se identificar"
    }
}

extension Patient {
    struct ContactInfo {
        var phoneNumber: String
        var email: String
    }
}

extension Patient {
    struct Emergency {
        var isEmergency: Bool
        var notes: String
    }
}

extension Patient {
    
    static var empty: Patient {
        
        let general = Patient.General(prefix: "",
                                         gender: Patient.General.Gender.allCases.first!,
                                         firstName: "",
                                         lastName: "",
                                         company: "")
        
        let contactInfo = Patient.ContactInfo(phoneNumber: "",
                                                 email: "")
        
        let emergency = Patient.Emergency(isEmergency: false,
                                             notes: "")
        
        return Patient(general: general, contactInfo: contactInfo, emergency: emergency)
    }
}
