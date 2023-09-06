//
//  Home.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        TabView {
            // Characters
            CharactersView()
                .environmentObject(homeVM)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            ComicsView()
                .environmentObject(homeVM)
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
