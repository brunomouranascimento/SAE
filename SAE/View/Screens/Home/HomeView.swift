//
//  HomeView.swift
//  SAE
//
//  Created by Bruno Nascimento on 13/05/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var shouldShowCreatePatient: Bool = false
    
    var body: some View {
        NavigationView {
            LazyVStack {
                
                if viewModel.patients.isEmpty {
                    
                    Text("Ainda não há pacientes cadastrados")
                    
                } else {
                    
                    ForEach(viewModel.patients) { item in
//                        ContactInfoView(item: item)
                        Text(item.general.firstName)
                    }
                        
                }
                
            }
            .padding(.horizontal)
            .navigationTitle("Pacientes")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        shouldShowCreatePatient.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $shouldShowCreatePatient) {
                CreatePatientView { patient in
                    print("Novo paciente")
                    dump(patient)
                    viewModel.add(patient)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
