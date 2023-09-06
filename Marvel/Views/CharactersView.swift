//
//  CharactersView.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15.0) {
                    // Searchbar
                    HStack(spacing: 10.0){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Character", text: $homeVM.searchQuery)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.secondary.opacity(0.3))
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                    .cornerRadius(15)
                }
                .padding()
                
                if let characters = homeVM.characters {
                    if characters.isEmpty {
                        Text("No Results Found")
                            .padding(.top, 20)
                    } else {
                        ForEach(characters) { character in
                            CharacterRowView(character: character)
                        }
                    }
                } else {
                    if homeVM.searchQuery != "" {
                        ProgressView()
                            .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Marvel")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .environmentObject(HomeViewModel())
    }
}
