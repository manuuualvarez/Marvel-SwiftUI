//
//  CharacterRowView.swift
//  Marvel
//
//  Created by Manny Alvarez on 05/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI


struct CharacterRowView: View {
    var character: Character
    var body: some View {
        HStack(alignment: .top, spacing: 15.0) {
            WebImage(url: getImageURL(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(character.description.isEmpty ? "No description" : character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 10.0) {
                    ForEach(character.urls, id: \.self) { data in
                        NavigationLink(destination: WebView(url: getDestiantionsUrl(data: data))) {
                            Text(getDestiantionsTypeUrl(data:data))
                        }
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    // Methods:
    private func getImageURL(data: [String:String]) -> URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        guard let url = URL(string: "\(path).\(ext)") else {
            return URL(string: "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")!
        }
        return url
    }
    
    private func getDestiantionsUrl(data: [String: String]) -> URL {
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    private func getDestiantionsTypeUrl(data: [String: String]) -> String {
        return data["type"]?.capitalized ?? ""
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: CharacterMock)
    }
}
