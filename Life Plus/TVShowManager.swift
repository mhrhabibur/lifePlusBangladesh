//
//  TVShowManager.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import Foundation

class TVShowManager {
    
    func fetchTVShowData(name: String, compilation: @escaping(TVShow?, Error?)-> Void) {
        if let url = URL(string: "https://api.tvmaze.com/singlesearch/shows?q=\(name)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let data = data {
                    do {
                        let tvShowData = try JSONDecoder().decode(TVShow.self, from: data)
                        compilation(tvShowData, nil)
                    } catch {
                        compilation(nil, error)
                    }
                }
            }.resume()
        }
    }
}
