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
    var itens: [Iten]?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        getRepository()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.tableView.estimatedRowHeight = 143
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let index = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    private func getRepository() {
        
        self.navigationController?.showHUB()
        RestService.instance.get(urlString: RestService.instance.GIT_URL, page: 1) { (data, err) in
            if err != nil {
                print(err!)
                return
            }
            do {
                let itens = try JSONDecoder().decode(GitObject.self, from: data!)
                self.itens = itens.items
                DispatchQueue.main.async {
                    self.navigationController?.hideHUB()
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension RepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTableViewCell
        cell.iten = self.itens?[indexPath.row]
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
