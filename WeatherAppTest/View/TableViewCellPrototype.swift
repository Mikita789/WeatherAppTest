//
//  TableViewCellPrototype.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import UIKit

class TableViewCellPrototype: UITableViewCell {
    var nameCityLabel:UILabel!
    var tempCityLabel:UILabel!
    var feelsLikeCityLabel:UILabel!
    var imViewWeather:UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameCityLabelSettings()
        tempCityLabelSettings()
        feelsLikeCityLabelSettings()
        contentView.backgroundColor =  #colorLiteral(red: 0.8806360364, green: 0.9527737498, blue: 0.9360817671, alpha: 0.5)
        imViewWeatherSettings()
        self.selectionStyle = .blue
        
        
    }
    //MARK: refresh ctyle row
    override func prepareForReuse() {
        super.prepareForReuse()
        nameCityLabel.font = .systemFont(ofSize: 15)
        tempCityLabel.font = .systemFont(ofSize: 15)
        feelsLikeCityLabel.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: update oll label
    func updateInfo(item:CityInfo){
        nameCityLabel.text = item.nameCity
        tempCityLabel.text = "\(item.tempCity) Cº"
        feelsLikeCityLabel.text = "\(item.feelsLikeTempCity) Cº"
        imViewWeather.image = UIImage(systemName: item.imageName ?? "ant.fill")
    }
    //MARK: settings Image View
    private func imViewWeatherSettings(){
        imViewWeather = UIImageView()
        contentView.addSubview(imViewWeather)
        imViewWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imViewWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imViewWeather.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            imViewWeather.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imViewWeather.leftAnchor.constraint(equalTo: feelsLikeCityLabel.rightAnchor)
        ])
        
        imViewWeather.tintColor = .black
        imViewWeather.contentMode = .scaleAspectFit
    }
    //MARK: settings name city label
    private func nameCityLabelSettings(){
        nameCityLabel = UILabel()
        contentView.addSubview(nameCityLabel)
        
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            nameCityLabel.leftAnchor .constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameCityLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.31)
        ])
        nameCityLabel.font = .systemFont(ofSize: 15)
        nameCityLabel.textAlignment = .center
        
    }
    //MARK: settings temp city label
    private func tempCityLabelSettings(){
        tempCityLabel = UILabel()
        contentView.addSubview(tempCityLabel)
        
        tempCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            tempCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            tempCityLabel.leftAnchor.constraint(equalTo: nameCityLabel.rightAnchor),
            tempCityLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25)
        ])
        tempCityLabel.font = .systemFont(ofSize: 15)
        tempCityLabel.textAlignment = .center
        
    }
    //MARK: settings feels temp city label
    private func feelsLikeCityLabelSettings(){
        feelsLikeCityLabel = UILabel()
        contentView.addSubview(feelsLikeCityLabel)
        
        feelsLikeCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feelsLikeCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            feelsLikeCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            feelsLikeCityLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            feelsLikeCityLabel.leftAnchor.constraint(equalTo: tempCityLabel.rightAnchor)
        ])
        feelsLikeCityLabel.font = .systemFont(ofSize: 15)
        feelsLikeCityLabel.textAlignment = .center
        
    }
    
}
