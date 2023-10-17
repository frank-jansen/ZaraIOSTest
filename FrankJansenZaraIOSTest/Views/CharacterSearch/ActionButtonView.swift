//
//  ActionButtonView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 3/10/23.
//

import SwiftUI


struct ActionButtonView: View {
    
    @EnvironmentObject var characterListViewModel: CharacterListViewModel
    @State private var showSearchBar = true
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showSearchBar.toggle()
                    
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
                    characterListViewModel.currentOption = .status
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
                    characterListViewModel.currentOption = .gender
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
                Button(action: characterListViewModel.toggleDisplay) {
                    VStack {
                        Image(systemName: characterListViewModel.displayMode.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        
                        Text(characterListViewModel.displayMode.name)
                            .font(Font.callout)
                            .frame(width: 80)
                    }
                }
            }
            
            
            .padding()
            
            switch characterListViewModel.currentOption {
            case .status:
                chooseStatusBar
            case .gender:
                chooseGendersBar
            }
            
            if showSearchBar {
                SearchBar(searched: $characterListViewModel.search)
                    .padding(.horizontal, 30)
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
        ActionButtonView()
            .environmentObject(CharacterListViewModel())
    }
}
