//
//  ActionButonView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import SwiftUI

struct ActionButonView: View {
    
    @Binding var toggleDisplayMode: Bool
    @EnvironmentObject var characterListViewModel: CharacterListViewModel
    @State private var showBar = true
    @State var statusButtonIsSelected = false
    @State var gendersButtonIsSelected = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showBar.toggle()
                    
                } label: {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        
                        Text("Search")
                            .font(Font.callout)
                            .frame(width: 80)
                    }
                }
                Button {
                    statusButtonIsSelected.toggle()
                    gendersButtonIsSelected = false
                    
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "cross")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text("Status")
                            .font(Font.callout)
                            .frame(width: 80)
                    }
                }
                Button {
                    gendersButtonIsSelected.toggle()
                    statusButtonIsSelected = false
                } label: {
                    VStack (spacing: 4){
                        
                        Image("genderless")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .tint(.blue)
                            .foregroundColor(.blue)
                        
                        Text("Gender")
                            .font(Font.callout)
                            .frame(width: 80)
                        
                    }
                }
                Button {
                    toggleDisplayMode.toggle()
                    
                } label: {
                    VStack {
                        Image(systemName: toggleDisplayMode ? "list.bullet" : "rectangle.grid.2x2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        
                        Text(toggleDisplayMode ? "List" : "Grid")
                            .font(Font.callout)
                            .frame(width: 80)
                    }
                }
            }
            
            
            .padding()
            if statusButtonIsSelected {
                chooseStatusBar
            }
            if gendersButtonIsSelected {
                chooseGendersBar
            }
            if showBar {
                SearchBar(searched: $characterListViewModel.search)
                    .padding(.horizontal, 30)
                //                if let searching = searchViewModel.searchResponse {
                //                    SearchListView(selected: $selectectText, locations: searching)
                //                }
            }
            
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.clear.opacity(0.8))
                .shadow(color:.cyan ,radius: 50))
    }
    
    var chooseStatusBar: some View {
        HStack {
            Button {
                if characterListViewModel.status == .alive {
                    characterListViewModel.status = nil
                } else {
                    characterListViewModel.status = .alive
                }
            } label: {
                Text("Alive")
                Image(systemName: "smallcircle.filled.circle")
                    .foregroundColor(Character.Status.alive.color)
            }
            Spacer()
            Button {
                if characterListViewModel.status == .unknown {
                    characterListViewModel.status = nil
                } else {
                    characterListViewModel.status = .unknown
                }
            } label: {
                Text("Unknown")
                Image(systemName: "smallcircle.filled.circle")
                    .foregroundColor(Character.Status.unknown.color)
            }
            Spacer()
            Button {
                if characterListViewModel.status == .dead {
                    characterListViewModel.status = nil
                } else {
                    characterListViewModel.status = .dead
                }
            } label: {
                Text("Dead")
                Image(systemName: "smallcircle.filled.circle")
                    .foregroundColor(Character.Status.dead.color)
            }
        }
        .padding(.horizontal)
    }
    var chooseGendersBar: some View {
        HStack(spacing: 30){
            Button {
                if characterListViewModel.gender == .male {
                    characterListViewModel.gender = nil
                } else {
                    characterListViewModel.gender = .male
                }
            } label: {
                Text("Male")
            }
            
            Button {
                if characterListViewModel.gender == .female {
                    characterListViewModel.gender = nil
                } else {
                    characterListViewModel.gender = .female
                }
            } label: {
                Text("Female")
            }
            
            Button {
                if characterListViewModel.gender == .genderless {
                    characterListViewModel.gender = nil
                } else {
                    characterListViewModel.gender = .genderless
                }
            } label: {
                Text("Genderless")
            }
            
            Button {
                if characterListViewModel.gender == .unknown {
                    characterListViewModel.gender = nil
                } else {
                    characterListViewModel.gender = .unknown
                }
            } label: {
                Text("Unknown")
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).opacity(0.1))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ActionButonView(toggleDisplayMode: .constant(Bool(false)))
            .environmentObject(CharacterListViewModel())
    }
}
