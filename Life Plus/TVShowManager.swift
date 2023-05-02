//
//  TVShowManager.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import Foundation

class TVShowManager {
    let url = URL(string: "https://api.tvmaze.com/singlesearch/shows?q=girls")!
    func fetchTVShowData(compilation: @escaping(TVShow?, Error?)-> Void) {
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
