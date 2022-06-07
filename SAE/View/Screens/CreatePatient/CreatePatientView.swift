//
//  CreatePatientView.swift
//  SAE
//
//  Created by Bruno Nascimento on 13/05/22.
//

import SwiftUI

struct CreatePatientView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
//    @FocusState var focusedInput: Field?
    @FocusState var focusedInput: Field?
    
    @StateObject private var viewModel = CreatePatientViewModel()
    let action: (_ patient: Patient) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                General(viewModel: viewModel, focusedInput: _focusedInput)
                Contact(viewModel: viewModel)
                EmergencyContact(viewModel: viewModel)
                ClearAll(viewModel: viewModel)
            }
            .navigationTitle("Adicionar Paciente")
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Pronto") {
                        action(viewModel.newPatient)
                        handleDismissal()
                    }
                    .disabled(!viewModel.isValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar",
                           role: .cancel) {
                        handleDismissal()
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Button(action: dismissKeyboard) {
                        Text("Pronto")
                    }
                    
                    Spacer()
                    
                    Button(action: previous) {
                        Image(systemName: "chevron.up")

                    }
                    .disabled(hasReachedStart)
                    
                    Button(action: next) {
                        Image(systemName: "chevron.down")

                    }
                    .disabled(hasReachedEnd)

                }

                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   focusedInput = .prefix
                }
            }
        }
    }
}

struct CreatePatientView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePatientView{ _ in }
    }
}

private extension CreatePatientView {
    
    var hasReachedEnd: Bool {
       focusedInput == Field.allCases.last
    }
    
    var hasReachedStart: Bool {
        focusedInput == Field.allCases.first
    }
    
    func dismissKeyboard() {
       focusedInput = nil
    }
    
    func next() {
        
        guard let currentInput = focusedInput,
              let lastIndex = Field.allCases.last?.rawValue else { return }
    
        let index = min(currentInput.rawValue + 1, lastIndex)
       focusedInput = Field(rawValue: index)
    }
    
    func previous() {
        
        guard let currentInput = focusedInput,
              let firstIndex = Field.allCases.first?.rawValue else { return }
    
        let index = max(currentInput.rawValue - 1, firstIndex)
        focusedInput = Field(rawValue: index)
    }
}

struct General: View {
    @ObservedObject var viewModel: CreatePatientViewModel
    @FocusState private(set) var focusedInput: Field?
    
    
    var body: some View {
        Section {
            
//            TextField("Prono", text: $viewModel.newPatient.general.prefix)
//                .textContentType(.namePrefix)
//                .focused($focusedInput, equals: .prefix)
            
            TextField("Nome", text: $viewModel.newPatient.general.firstName)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
                .focused($focusedInput, equals: .firstName)
            
            TextField("Sobrenome", text: $viewModel.newPatient.general.lastName)
                .textContentType(.familyName)
                .keyboardType(.namePhonePad)
                .focused($focusedInput, equals: .lastName)
            
            Picker("Gênero", selection: $viewModel.newPatient.general.gender) {
                ForEach(Patient.General.Gender.allCases) { item in
                    Text(item.rawValue.uppercased())
                }
            }
            
            TextField("Empresa (opcional)", text: $viewModel.newPatient.general.company)
                .textContentType(.organizationName)
                .focused($focusedInput, equals: .company)
            
        } header: {
            Text("Dados gerais")
        } footer: {
            Text("Dados gerais do paciente")
        }
        .headerProminence(.increased)
    }
}

struct Contact: View {
    @ObservedObject var viewModel: CreatePatientViewModel
    @FocusState private var focusedInput: Field?
    
    var body: some View {
        Section {
            
            TextField("Telefone", text: $viewModel.newPatient.contactInfo.phoneNumber)
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .focused($focusedInput, equals: .phoneNumber)
            
            TextField("Email", text: $viewModel.newPatient.contactInfo.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .focused($focusedInput, equals: .email)
        } header: {
            Text("Contatos de emergência")
        }
        .headerProminence(.increased)
        
    }
}

struct EmergencyContact: View {
    @ObservedObject var viewModel: CreatePatientViewModel
    @FocusState private var focusedInput: Field?
    
    var body: some View {
        
        Section {
            
            Toggle("Contato de Emergência", isOn: $viewModel.newPatient.emergency.isEmergency)
            
            TextEditor(text: $viewModel.newPatient.emergency.notes)
                .focused($focusedInput, equals: .emergencyNotes)
            
        } footer: {
            Text("Please enter in any information about this emergency contact that someone else should know")
        }
    }
}

struct ClearAll: View {
    @ObservedObject var viewModel: CreatePatientViewModel
    
    var body: some View {
            Button(role: .destructive) {
                withAnimation {
                    viewModel.clearAll()
                }
            } label: {
                Text("Limpar")
            }
    }
}

private extension CreatePatientView {
    
    func handleDismissal() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//extension CreatePatientView {
    enum Field: Int, Hashable, CaseIterable {
        case prefix
        case firstName
        case lastName
        case company
        case phoneNumber
        case email
        case emergencyNotes
    }
//}

//private extension General {
//    enum Field: Int, Hashable, CaseIterable {
//        case prefix
//        case firstName
//        case lastName
//        case company
//        case phoneNumber
//        case email
//        case emergencyNotes
//    }
//}
//
//
////private extension EmergencyContact {
//    enum Field: Int, Hashable, CaseIterable {
//        case prefix
//        case firstName
//        case lastName
//        case company
//        case phoneNumber
//        case email
//        case emergencyNotes
//    }
////}
//
//private extension Contact {
//    enum Field: Int, Hashable, CaseIterable {
//        case prefix
//        case firstName
//        case lastName
//        case company
//        case phoneNumber
//        case email
//        case emergencyNotes
//    }
//}
