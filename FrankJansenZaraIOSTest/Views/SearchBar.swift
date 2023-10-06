//
//  SearchBar.swift
//  FrankJansenZaraIOSTest
//
//  Created by Frank Jansen on 9/3/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searched: String
    
    var body: some View {
        TextField(text: $searched) {
            Text("Search:")
                .foregroundColor(.white)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color(.white).opacity(0.1))
        .cornerRadius(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searched: .constant(""))
    }
}
