//
//  WordSearchView.swift
//  wordSearch
//
//  Created by josefin hellgren on 2023-06-01.
//

import SwiftUI

struct WordSearchView: View {
    @ObservedObject var vm = WordViewModel()
    
    
    var body: some View {
        VStack {
            TextField("Enter Filter Text", text: $vm.searchQuery)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
            /*.background(Color.gray.opacity(0.2))*/
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .foregroundColor(.black)
                .accentColor(.black)
            
            if vm.isLoading {
                Text("Loading words...")
                    .font(.title)
                Spacer()
                Spacer()
                
            } else if vm.filteredWords.isEmpty {
                Text("No words matching")
                    .font(.title)
                Spacer()
                Spacer()
                
                
            } else {
                List(vm.filteredWords) { word in
                    Text(word.word)
                        .font(.title)
                    
                }
            }
        }
        .onAppear {
            vm.fetchWords()
        }
    }
}

struct WordSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WordSearchView()
    }
}
