//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import UIKit

class SelecCityAndInfoViewController: UIViewController,CurrentWeatherDelegate {
    var tableView:UITableView!
    var stackViewLabel:UIStackView!
    var cityName = [CurrentWeather]()
    var netw = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current Weather"
        //stackViewLabelSettings()
        tableViewSettings()
        addButtonNavC()
        netw.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.8806360364, green: 0.9527737498, blue: 0.9360817671, alpha: 1)
        
        
        
    }
    //MARK: -Delegate func update info
    func appendCurrenWeatherModel(item: CurrentWeather) {
        let copy = cityName.filter{$0.name == item.name}
        if copy.count == 0{
            cityName.append(item)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    //MARK: settings stack View
//    private func stackViewLabelSettings(){
//        let nameLabel = ["City Name", "Temp Cº", "Feels Tempº"]
//
//        stackViewLabel = UIStackView(arrangedSubviews: nameLabel.map{createLabel(title: $0)})
//        view.addSubview(stackViewLabel)
//        stackViewLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackViewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            stackViewLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
//            stackViewLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
//            stackViewLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
//        ])
//
//        stackViewLabel.spacing = 5
//        stackViewLabel.axis = .horizontal
//        stackViewLabel.distribution = .fillProportionally
//    }
//
//    //MARK: create label func
//    private func createLabel(title:String)->UILabel{
//        var label = UILabel()
//        label.text = title
//        label.textAlignment = .center
//
//        return label
//    }
    
    //MARK: settings button NavController
    private func addButtonNavC(){
        let barButton  = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButton))
        navigationItem.rightBarButtonItem = barButton
    }
    //MARK: search button action
    @objc func searchButton(){
        let alert = UIAlertController(title: "Search City", message: "Enter City Name", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { _ in
            let cityName = alert.textFields?.first?.text ?? "nil"
            self.netw.currentWeatherDate(cityName: cityName)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField(){_ in
            let teftField = UITextField()
        }
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true)
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
        return cityName.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? TableViewCellPrototype else { return UITableViewCell() }
        if indexPath.row == 0{
            cell.nameCityLabel.text = "City Name"
            cell.nameCityLabel.font = .boldSystemFont(ofSize: 20)
            cell.tempCityLabel.text = "Temp Cº"
            cell.tempCityLabel.font = .boldSystemFont(ofSize: 20)
            cell.feelsLikeCityLabel.text = "Feels"
            cell.feelsLikeCityLabel.font = .boldSystemFont(ofSize: 20)
        }else{
            let currentModel = cityName[indexPath.row - 1]
            cell.updateInfo(item: currentModel)
        }
        
        return cell
    }
    
    
}

