//
//  RepositoryTableViewCell.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 27/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import UIKit
import Nuke
class RepositoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbNameRepository: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbStarCount: UILabel!
    @IBOutlet weak var lbforkCount: UILabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbFullname: UILabel!
    
    var iten: Iten? {
        didSet {
            self.setupView()
        }
    }
    
    
    func setupView() {
        self.lbNameRepository.text = self.iten?.name
        self.lbDescription.text = self.iten?.description
        self.lbforkCount.text = self.iten?.forks_count?.description
        self.lbStarCount.text = self.iten?.stargazers_count?.description
        
        if let url = URL(string: self.iten?.owner?.avatar_url ?? "") {
            self.ivUser.image = nil
            Nuke.loadImage(with: url, into: self.ivUser)
        }
        self.lbUsername.text = self.iten?.owner?.login
        self.lbUsername.ajustFontWidth()
        self.getUserName() 
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ivUser.layer.cornerRadius = self.ivUser.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func getUserName() {
        RestService.instance.get(urlString: self.iten?.owner?.url ?? "") { (data, err) in
            if err != nil {
                return
            }
            
            if data != nil {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.lbFullname.text = user.name
                    }
                } catch {
                    print(error)
                }
            }
            
            
        }
    }

}
