//
//  HomeViewController.swift
//  Demo1031
//
//  Created by lean on 2022/10/31.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var data = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        configureNavbar()
        APICaller.shared.getData {[weak self]  result in
            switch result{
            case .success(let user):
                self?.data = user
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func configureNavbar() {
        APICaller.shared.getCount {[weak self]  result in
            switch result{
            case .success(let count):
                DispatchQueue.main.async {
                    self?.title = "TotalCount:\(count)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.myLabel.text = self.data[indexPath.row].user.nickName
        let imageURL = self.data[indexPath.row].user.imageUrl
        cell.myImageView.sd_setImage(with: URL(string: imageURL ?? "")) { (image, error, cacheType, url) in
        }
        cell.setData(data: self.data[indexPath.row].tags ?? [])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
}
