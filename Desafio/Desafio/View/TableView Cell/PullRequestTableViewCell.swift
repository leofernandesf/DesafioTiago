//
//  PullRequestTableViewCell.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 29/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import UIKit
import Nuke
class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lbtitle: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    var pullRequest: PullRequest? {
        didSet {
            self.setupView()
        }
    }
    
    
    func setupView() {
        self.lbtitle.text = pullRequest?.title
        self.lbBody.text = pullRequest?.body
        self.lbUserName.text = pullRequest?.user?.login
        
        if let url = URL(string: pullRequest?.user?.avatar_url ?? "") {
            Manager.shared.loadImage(with: url, into: self.ivUser)
        }
        
        print(pullRequest?.created_at)
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = formater.date(from: self.pullRequest?.created_at ?? "") else {
            self.lbDate.text = ""
            return
        }
        
        formater.dateFormat = "dd/MM/yyyy"
        self.lbDate.text = formater.string(from: date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser.layer.cornerRadius = self.ivUser.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
