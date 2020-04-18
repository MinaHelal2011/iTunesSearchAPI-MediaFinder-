//
//  MediaCellNip.swift
//  MediaFinder
//
//  Created by Mina Helal on 3/30/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import UIKit
import MarqueeLabel

class MediaCellNip: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageArtWork: UIImageView!
    @IBOutlet weak var mediaNameArtistOrTrack: UILabel!
    @IBOutlet weak var mediaDescriptionOrartist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func bouncingImageButtom(_ sender: Any) {
        imageArtWork.center.x = self.selectedBackgroundView!.frame.width
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30, options: UIView.AnimationOptions.curveEaseInOut, animations: {(self.imageArtWork.center.x = self.selectedBackgroundView!.frame.width / 6.18)}, completion: nil)
    }
    
    func SetData(_ media: Media) {
        imageArtWork.sd_setImage(with: URL(string: media.artworkUrl100), completed: nil)
        switch media.getType() {
        case .music:
            mediaNameArtistOrTrack.text = media.trackName!
            mediaDescriptionOrartist.text = media.artistName!
        case .movie:
            mediaNameArtistOrTrack.text = media.trackName!
            mediaDescriptionOrartist.text = media.longDescription!
        case .tvShow:
            mediaNameArtistOrTrack.text = media.artistName!
            mediaDescriptionOrartist.text = media.longDescription ?? "not Found"
        }
    }
}
