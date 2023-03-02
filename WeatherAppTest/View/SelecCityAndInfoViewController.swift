//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import UIKit
import CoreData

class SelecCityAndInfoViewController: UIViewController,CurrentWeatherDelegate {
    var tableView:UITableView!
    var stackViewLabel:UIStackView!
    var cityName = [CurrentWeather]()
    var netw = NetworkManager()
    var data = [CityInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current Weather"
        tableViewSettings()
        addButtonNavC()
        netw.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.8806360364, green: 0.9527737498, blue: 0.9360817671, alpha: 1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        upLoadData()
        leftButtonNavigControllerAction()
    }
    
    
    //MARK: save data
    private func saveData(item:CurrentWeather){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CityInfo", in: context) else { return }
        let object = CityInfo(entity: entity, insertInto: context)
        object.nameCity = item.name
        object.feelsLikeTempCity = item.feelsLike
        object.tempCity = item.temp
        object.imageName = item.im
        
        do{
            try context.save()
            data.append(object)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    //MARK: upLoad Data
    private func upLoadData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<CityInfo> = CityInfo.fetchRequest()
        do {
            data = try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    //MARK: - delete item func
    private func deleteItem(indexPatch:IndexPath){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<CityInfo> = CityInfo.fetchRequest()
        guard let obj = try? context.fetch(fetchRequest) else { return }
        let indexPatchTrue = IndexPath(row: indexPatch.row - 1, section: indexPatch.section)
        context.delete(obj[indexPatchTrue.row])
        data.remove(at: indexPatchTrue.row)
        self.tableView.deleteRows(at: [indexPatchTrue], with: .fade)
        
        do{
            try context.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
        
    }
    
    //MARK: -Delegate func update info
    func appendCurrenWeatherModel(item: CurrentWeather) {
        let copy = data.filter{$0.nameCity == item.name}
        if copy.count == 0{
            DispatchQueue.main.async {
                self.saveData(item: item)
                self.tableView.reloadData()
            }
        }else{
            updateInfo(target: item)
        }
    }
    
    //MARK: update Info func
    private func updateInfo(target:CurrentWeather){
        for city in data{
            if city.nameCity == target.name{
                city.tempCity = target.temp
                city.feelsLikeTempCity = target.feelsLike
                city.imageName = target.im
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        
        tableView.separatorColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: settings button NavController
    private func addButtonNavC(){
        let barButton  = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButton))
        let leftButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(leftButtonNavigControllerAction))
        navigationItem.rightBarButtonItem = barButton
        navigationItem.leftBarButtonItem = leftButton
    }
    //MARK: search button action
    @objc func leftButtonNavigControllerAction(){
        for item in data{
            guard let cityName = item.nameCity else { return }
            self.netw.currentWeatherDate(cityName: cityName)
        }
    }
    //MARK: search button action
    @objc func searchButton(){
        let alert = UIAlertController(title: "Search City", message: "Enter City Name", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { _ in
            let cityName = alert.textFields?.first?.text ?? "nil"
            self.netw.currentWeatherDate(cityName: cityName)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField()
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }



}
//MARK: - TableView Delegate
extension SelecCityAndInfoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.bounds.height * 0.06)
    }
    
}
//MARK: - TableView DataSouce
extension SelecCityAndInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
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
            cell.imViewWeather.image = UIImage(systemName: "sun.min.fill")
        }else{
            
            let currentModel = data[indexPath.row - 1]
            cell.updateInfo(item: currentModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0{
            return.none
        }else{
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteItem(indexPatch: indexPath)
        }
    }
    
    
}

