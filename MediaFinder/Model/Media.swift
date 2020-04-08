//
//  SearchResult.swift
//  MediaFinder
//
//  Created by Mina Helal on 3/30/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import Foundation

enum MediaType: String {
    case  movie, music, tvShow
}

struct Media: Decodable {
    var artworkUrl100:   String
    var artistName:      String?
    var trackName:       String?
    var longDescription: String?
    var previewUrl:      String
    var kind:            String?
    
    func getType() -> MediaType {
        switch self.kind {
        case "song":
            return MediaType.music
        case "feature-movie":
            return MediaType.movie
        case  "tv-episode":
            return MediaType.tvShow
        default :
            return MediaType.music
        }
    }
}
