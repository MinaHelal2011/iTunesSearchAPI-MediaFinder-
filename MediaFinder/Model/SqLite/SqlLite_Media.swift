//
//  SqlLite.swift
//  MediaFinder
//
//  Created by Mina Helal on 4/1/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import Foundation
import SQLite


struct MediaDataBase {
    private static let sharedInstance = MediaDataBase()
    static func Shared() -> MediaDataBase {
        return MediaDataBase.sharedInstance
    }
    
    var dataBase: Connection!
    let mediaTable = Table("media")
    let id              = Expression<Int>("id")
    let artworkUrl100   = Expression<String>("artworkUrl100")
    let artistName      = Expression<String?>("artistName")
    let trackName       = Expression<String?>("trackName")
    let longDescription = Expression<String?>("longDescription")
    let previewUrl      = Expression<String>("previewUrl")
    let kind            = Expression<String?>("kind")
    
    
    func connectDataBase() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dataBase = try! Connection("\(path)/MediaDataBase.sqlite3")
        MediaDB.Shared.dataBase = dataBase
        print("file path is \(dataBase)")
    }
    
    func createTable() {
        let createTable = MediaDB.Shared.mediaTable.create(ifNotExists: true) { (table) in
            table.column(MediaDB.Shared.id)
            table.column(MediaDB.Shared.artworkUrl100)
            table.column(MediaDB.Shared.artistName, defaultValue: "Anonymous Artistname" )
            table.column(MediaDB.Shared.trackName, defaultValue: "Anonymous trackname")
            table.column(MediaDB.Shared.longDescription, defaultValue: "Anonymous longDescription")
            table.column(MediaDB.Shared.previewUrl)
            table.column(MediaDB.Shared.kind, defaultValue: "Anonymous kind")
            
        }
        do {
            try MediaDB.Shared.dataBase.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    func insert(_ mediaModel: [Media], _ id: Int) {
        for mediaModel in mediaModel {
            let insertUser = MediaDB.Shared.mediaTable.insert(MediaDB.Shared.id <- id, MediaDB.Shared.artworkUrl100 <- mediaModel.artworkUrl100, MediaDB.Shared.artistName <- mediaModel.artistName ?? " Anonymous Artistname", MediaDB.Shared.trackName <- mediaModel.trackName ?? "Anonymous trackname", MediaDB.Shared.longDescription <- mediaModel.longDescription ?? "Anonymous longDescription", MediaDB.Shared.previewUrl <- mediaModel.previewUrl ,MediaDB.Shared.kind <- mediaModel.kind ?? "Anonymous kind")
            do {
                try MediaDB.Shared.dataBase.run(insertUser)
                print("INSERTED Media")
            } catch {
                print(error)
            }
        }
    }
    
    func getMedia(_ id: Int) -> [Media] {
        var arrMedia = [Media]()
        for media in try! MediaDB.Shared.dataBase.prepare(MediaDB.Shared.mediaTable) {
            if (media[MediaDB.Shared.id] == id){
                let mediadb = Media(artworkUrl100: media[MediaDB.Shared.artworkUrl100], artistName: media[MediaDB.Shared.artistName], trackName: media[MediaDB.Shared.trackName], longDescription: media[MediaDB.Shared.longDescription], previewUrl: media[MediaDB.Shared.previewUrl], kind: media[MediaDB.Shared.kind])
                arrMedia.append(mediadb)
            }
        }
        return arrMedia
    }
}
