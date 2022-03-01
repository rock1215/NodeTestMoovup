//
//  ListViewController.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit

class ListViewController: UIViewController {

    var persons: [Person] = []
    
    var tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.safeArea = self.view.layoutMarginsGuide
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "Person List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        Person.getAllPersons(url: "https://api.json-generator.com/templates/-xdNcNKYtTFG/data") { results in
            self.persons = results
            self.tableView.reloadData()
        } _: { _ in
            self.persons = PersonData.get()
            self.tableView.reloadData()
        }
    }
    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.contentView.removeAllSubViews()
        
        let person = self.persons[indexPath.row]
        
        let imageView = UIImageView(frame: CGRect(x: 12, y: 8, width: 40, height: 40))
        
        cell.contentView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.setImage(url: URL(string: person.picture), duration: 0)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        
        let titleLabel = UILabel(frame: CGRect(x: 64, y: 16, width: cell.frame.width - 76, height: 20))
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = person.first_name + " " + person.last_name
        
        cell.contentView.addSubview(titleLabel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        let personViewController = PersonDetailViewController()
        personViewController.person = self.persons[indexPath.row]
        
        self.navigationController?.pushViewController(personViewController, animated: false)
    }
}
