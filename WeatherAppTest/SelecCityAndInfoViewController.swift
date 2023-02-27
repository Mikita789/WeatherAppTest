//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import UIKit

class SelecCityAndInfoViewController: UIViewController {
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current Weather"
        tableViewSettings()
        
    }
    
    
    //MARK: - func TableView
    private func tableViewSettings(){
        tableView = UITableView()
        self.view.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(TableViewCellPrototype.self, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
    }


}
//MARK: - TableView Delegate
extension SelecCityAndInfoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.bounds.height * 0.07)
    }
    
}
//MARK: - TableView DataSouce
extension SelecCityAndInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? TableViewCellPrototype else { return UITableViewCell() }
        
        return cell
    }
    
    
}

