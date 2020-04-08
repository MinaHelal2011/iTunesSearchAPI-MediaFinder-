//
//  FavouriteMovieVC.swift
//  TestUserDefault
//
//  Created by Mina Helal on 2/19/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class FavouriteMovieVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTerm: UISearchBar!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var mediadb = MediaDB()
    var arrMedia = [Media]()
    var kind: MediaType = .music
    var player: AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage()
        tabledelegate()
        hideKeyboardWhenTappedAround()
        DefaultMedia()
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            kind = .music
        case 1:
            kind = .movie
        case 2:
            kind = .tvShow
        default:
            kind = .music
        }
    }
    
    @IBAction func ProfileButtomPressed(_ sender: Any) {
        let profileVC = UIStoryboard(name: SBs.main, bundle: nil).instantiateViewController(withIdentifier: VCs.profileVC) as! ProfileVC
        self.present(profileVC, animated: false, completion: nil)
    }
    
    // MARK: - Functional
    
    private func tabledelegate() {
        searchTerm.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: VCs.mediaCellNip, bundle: nil), forCellReuseIdentifier: VCs.mediaCellNip)
    }
    
    private func profileimage() {
        let image = UserDB.Shared.getUserImage(DefaultUser.Shared.idUserLogged)
        userProfileImage.image = UIImage(data: image!)
    }

    private func isValid() -> Bool {
        print(searchTerm.text!)
        guard let term = searchTerm.text, !term.isEmpty else { validationAlert("Search is Empty"); return false }
        return true
    }
    private func DefaultMedia () {
        if arrMedia.count == 0 && DefaultUser.Shared.idInsertMedia != 0 {
           self.arrMedia = MediaDB.Shared.getMedia(DefaultUser.Shared.idInsertMedia)
        }
    }
    
    private func bindingData(_ term : String,_ media: MediaType) {
        ItunesSearchApi.loadMedia(term, media, completion: { (error, media) in
            if let error = error {
                print(error.localizedDescription)
            } else if let media = media {
                self.arrMedia = media
                self.tableView.reloadData()
                if media.count == 0 {
                    self.validationAlert("Not Found")
                }else {
                    DefaultUser.Shared.idInsertMedia += 1
                    MediaDB.Shared.insert(self.arrMedia, DefaultUser.Shared.idInsertMedia)
                }
            }
        })
    }
    
    private func mediaPlayer(_ previewUrl : String) {
        let url2 = URL(string: previewUrl)
        let video = AVPlayer(url: url2!)
        let videplayer = AVPlayerViewController()
        videplayer.player = video
        self.present(videplayer ,animated: true, completion: ({
            video.play()
        }))
    }
}

// MARK: - TableView
extension FavouriteMovieVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCellNip") as! MediaCellNip
        let result = arrMedia[indexPath.row]
        cell.SetData(result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = arrMedia[indexPath.row]
        mediaPlayer(result.previewUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - SearchBar
extension FavouriteMovieVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchTerm.text))")
        if isValid() {
            bindingData(searchTerm.text!, kind)
        } else {
            validationAlert("Search is Empty")
        }
    }
}
