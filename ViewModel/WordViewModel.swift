//
//  WordViewModel.swift
//  wordSearch
//
//  Created by josefin hellgren on 2023-06-01.
//

import Foundation

final class WordViewModel : ObservableObject{
    @Published private var  words : [Word] = []
    @Published var searchQuery : String = ""
    @Published var isLoading : Bool = false
    
    
    var filteredWords : [Word]{
        if searchQuery.isEmpty{
            return words
        }else{
            return words.filter{$0.word.lowercased().contains(searchQuery.lowercased())}
        }
        
    }
    
    
    func fetchWords () {
        isLoading = true
        let wordUrl = "https://raw.githubusercontent.com/ftronnbe/english-words/main/sample_words_alpha.txt"
        
        
        if let url = URL(string: wordUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
                
                guard let data = data else {
                    
                    return
                }
                
                
                if let wordList = String(data: data, encoding: .utf8)?.components(separatedBy: .newlines) {
                    DispatchQueue.main.async {
                        let words = wordList.filter { !$0.isEmpty && $0.rangeOfCharacter(from: .alphanumerics.inverted) == nil }
                            .map { Word(word: $0)}
                        self?.words = words
                        print("Fetched \(words.count) words")
                        self?.isLoading = false
                    }
                }
                
            }.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    
}



