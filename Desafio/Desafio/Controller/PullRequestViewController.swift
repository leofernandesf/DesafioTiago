//
//  PullRequestViewController.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 28/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import UIKit

class PullRequestViewController: UIViewController {
    
    var item: Item?
    var user: User?

    let cellIdentifier = "pullRequestCell"
    var pullRequests: [PullRequest]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPullRequest()

        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.navigationItem.title = self.item?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPullRequest() {
        let url = "\(RestService.instance.PULL_REQUEST_URL)\(self.item?.owner?.login ?? "")/\(self.item?.name ?? "")/pulls"
        
        self.navigationController?.showHUB()
        RestService.instance.get(urlString: url) { (data, err) in
            if err != nil {
                self.showAlert(title: err, message: nil)
                self.navigationController?.hideHUB()
                return
            }
            
            guard let data = data else {
                self.navigationController?.hideHUB()
                return
                
            }
            do {
                self.pullRequests = try JSONDecoder().decode([PullRequest].self, from: data)
                self.navigationController?.hideHUB()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                self.showAlert(title: "Não foi possivel carregar as informações", message: nil)
                self.navigationController?.hideHUB()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PullRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PullRequestTableViewCell
        cell.pullRequest = self.pullRequests?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests?.count ?? 0
    }
}

extension PullRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.pullRequests?[indexPath.row]
        guard let url = URL(string: cell?.html_url ?? "") else {
            self.showAlert(title: "Não foi possivel abrir este repositório", message: nil)
            return
        }
        UIApplication.shared.open(url, options: [:])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
