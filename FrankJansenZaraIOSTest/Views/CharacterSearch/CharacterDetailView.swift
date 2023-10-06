//
//  CharacterDetailView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 4/3/10/23.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "\(character.image)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
            } placeholder: {
                ProgressView()
            }
            
            characterName
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                characterStatusView.padding()
                characterCurrentLocalization
                Text("Nombre: \(character.location.name)")
                Text("Genero: \(character.gender.rawValue)")
                Text("Origen: \(character.origin.name)")
                Text("Especie: \(character.species)")
                    .padding(.bottom)
            }
            .padding()
            .foregroundColor(.white)
            .background(
                Color.black
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            )
            Spacer()
        }
        .background (
            Image("Wallpaper")
                .resizable()
                .scaledToFit()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )        
    }
    
    var characterCurrentLocalization: some View {
        HStack {
            Text("Current Location: \(character.location.name)")
                .foregroundColor(.white)
        }
    }
    
    var characterStatusView: some View {
        HStack {
            Text("Status: \(character.status.rawValue)")
                .foregroundColor(.white)
                .bold()
        }
    }
    
    var characterName: some View {
        HStack {
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
                .shadow(color: .black, radius: 10)
        }
    }
    
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: Response.self.mock.results.last!)
    }
}
