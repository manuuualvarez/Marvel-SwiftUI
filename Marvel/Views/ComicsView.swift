//
//  ComicsView.swift
//  Marvel
//
//  Created by Manny Alvarez on 06/09/2023.
//

import SwiftUI

struct ComicsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeVM.comics.isEmpty {
                    ProgressView()
                        .padding(.top, 20)
                } else {
                    VStack(spacing: 15.0) {
                        ForEach(homeVM.comics) { comic in
                            ComicRowView(comic: comic)
                        }
                        if homeVM.offset == homeVM.comics.count {
                            // Showing progress and fetch new data
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    homeVM.searchComics()
                                })
                        } else {
                            // Infiniy Scroll
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let heigth = UIScreen.main.bounds.height / 1.3
                                
                                if !homeVM.comics.isEmpty && minY < heigth {
                                    DispatchQueue.main.async {
                                        homeVM.offset = homeVM.comics.count
                                    }
                                } else {
                                    
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Comics")
        }
        .onAppear(perform: {
            if homeVM.comics.isEmpty {
                homeVM.searchComics()
            }
        })
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
            .environmentObject(HomeViewModel())
    }
}
