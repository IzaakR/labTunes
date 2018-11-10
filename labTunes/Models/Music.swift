//
//  Music.swift
//  labTunes
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import Foundation

class Music {
    static var urlSession = URLSession(configuration: .default)
    
    static func fetchSongs(songsName: String = "TheBeatles", onSuccess: @escaping([Song]) -> Void) {
        let url = URL(string: "https://itunes.apple.com/search?term='\(songsName)'")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
                if statusCode == 200 {
                    guard let json = parseData(data: data!) else {return}
                    let songs = songsFrom(json: json)
                    onSuccess(songs)
                }
            }
        }
        dataTask.resume()
    }
    
    static func parseData(data: Data) -> NSDictionary? {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        return json
    }
    
    static func songsFrom(json: NSDictionary) -> [Song] {
        let results = json["results"] as! [NSDictionary]
        var songs: [Song] = []
        for dataResult in results {
            let song = Song.create(dict: dataResult)
            songs.append(song!)
        }
        return songs
    }
}
