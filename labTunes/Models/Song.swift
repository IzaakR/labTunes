//
//  Song.swift
//  labTunes
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import Foundation

struct Song {
    var artist: String
    var name: String
    
    static func create(dict: NSDictionary) -> Song? {
        guard let trackName = dict["trackName"] as? String else {return nil}
        guard let artist = dict["artistName"] as? String else {return nil}
        return Song(artist: artist, name: trackName)
    }
}
