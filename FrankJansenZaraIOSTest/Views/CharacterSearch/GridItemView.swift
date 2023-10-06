//
//  GridItemView.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 7/3/10/23.
//

import SwiftUI

struct GridItemView: View {
    var character: Character
    var body: some View {
        VStack {
            AsyncImage(url:URL(string: character.image) ) { Image in
                Image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: [character.status.color, Color(.clear)]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                ),
                                lineWidth: 10
                            )
                    )
                Text(character.name)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .shadow(color: .black, radius: 1)
            } placeholder: {
                ProgressView()
            }
        }
        .background(
            Color(.black)
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        )
        
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GridItemView(character: Response.mock.results.first!)
    }
}
