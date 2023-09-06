//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import SwiftUI
import Combine
import CryptoKit


class HomeViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var characters: [Character]? = nil
    @Published var comics: [Comic] = []
    @Published var offset: Int = 0
    
    var searchCancellable: AnyCancellable? = nil
    
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { searchStr in
                if searchStr == "" {
                    self.characters = nil
                } else {
                    self.searchCharacter()
                }
            })
    }
    
    
    func searchCharacter() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(priuvateKey)\(publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let urlStr =
        "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlStr) else {
            return
        }
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "searchCharacter()")
            }
            
            guard let APIData = data else {
                logged(type: .noData, message: "No Data", fileName: "HomeViewModel", method: "searchCharacter()")
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.async {
                    if self?.characters == nil {
                        self?.characters = characters.data.results
                    }
                }
            } catch let error {
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "searchCharacter()")
            }
        }
        .resume()
    }
    
     func searchComics() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(priuvateKey)\(publicKey)")
        let urlStr =
        "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlStr) else {
            return
        }
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "searchComics()")
            }
            
            guard let APIData = data else {
                logged(type: .noData, message: "No Data", fileName: "HomeViewModel", method: "searchComics()")
                return
            }
            
            do {
                let comics = try JSONDecoder().decode(APIComicsResult.self, from: APIData)
                DispatchQueue.main.async {
                    self?.comics.append(contentsOf: comics.data.results)
                }
            } catch let error {
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "searchCharacter()")
            }
        }
        .resume()
    }
    
    func changeTheOffset() {
        self.offset = self.comics.count
    }
    
    private func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
}
