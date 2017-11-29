//
//  RepositoryViewController.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 27/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var itens: [Item]?
    
    let segueIdentifier = "repositoryDetail"
    let repositoryCellIdentifier = "repositoryCell"
    
    var cont = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        getRepository()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.tableView.estimatedRowHeight = 143
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    private func getRepository() {
        
        self.cont += 1
        self.navigationController?.showHUB()
        RestService.instance.get(urlString: RestService.instance.GIT_URL, page: cont) { (data, err) in
            if err != nil {
                print(err!)
                self.navigationController?.hideHUB()
                self.showAlert(title: err, message: nil)
                return
            }
            do {
                let itens = try JSONDecoder().decode(GitObject.self, from: data!)
                
                if self.cont == 1 {
                    self.itens = [Item]()
                }
                
                itens.items?.forEach({ (i) in
                    self.itens?.append(i)
                })
                
                DispatchQueue.main.async {
                    self.navigationController?.hideHUB()
                    self.tableView.reloadData()
                }
            } catch {
                self.navigationController?.hideHUB()
                self.showAlert(title: "Não foi possivel carregar as informações", message: nil)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueIdentifier {
            let vc = segue.destination as! PullRequestViewController
            let objectArray = sender as! [Any]
            vc.item = objectArray.first as? Item
            vc.user = objectArray.last as? User
        }
    }
    

}

extension RepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellIdentifier, for: indexPath) as! RepositoryTableViewCell
        cell.item = self.itens?[indexPath.row]
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RepositoryTableViewCell
        
        guard let item = cell.item, let user = cell.user else {
            self.showAlert(title: "Não foi possivel carregar as informações", message: nil)
            return
        }
        
        self.performSegue(withIdentifier: segueIdentifier, sender: [item, user])
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let item = self.itens else { return }
        if indexPath.row == item.count - 2 {
            self.getRepository()
        }
    }
}
