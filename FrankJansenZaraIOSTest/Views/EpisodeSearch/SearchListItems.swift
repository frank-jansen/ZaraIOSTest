//
//  SearchListItems.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 14/3/10/23.
//

import SwiftUI

struct SearchListItems: View {
    
    let episode: Episode
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(episode.name)
                    .font(.custom("American Typewriter", size: 16))
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text(episode.episode)
                    .foregroundColor(.white)
                    .font(.custom("American Typewriter", size: 14))
                    .bold()

            }.padding()
            
            
            Text(episode.air_date ?? "No Data")
                .foregroundColor(.white)
                .padding()
            
        }
    }

}

struct SearchListItems_Previews: PreviewProvider {
    static var previews: some View {
        SearchListItems(episode: Response.mock2.results.first!)
    }
}
