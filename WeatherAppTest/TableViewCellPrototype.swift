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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameCityLabelSettings()
        tempCityLabelSettings()
        feelsLikeCityLabelSettings()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func nameCityLabelSettings(){
        nameCityLabel = UILabel()
        contentView.addSubview(nameCityLabel)
        
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            nameCityLabel.leftAnchor .constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameCityLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
        nameCityLabel.text = "name city"
        
    }
    
    private func tempCityLabelSettings(){
        tempCityLabel = UILabel()
        contentView.addSubview(tempCityLabel)
        
        tempCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            tempCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            tempCityLabel.leftAnchor.constraint(equalTo: nameCityLabel.rightAnchor),
            tempCityLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
        tempCityLabel.text = "temp city"
    }
    
    private func feelsLikeCityLabelSettings(){
        feelsLikeCityLabel = UILabel()
        contentView.addSubview(feelsLikeCityLabel)
        
        feelsLikeCityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feelsLikeCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            feelsLikeCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            feelsLikeCityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
            feelsLikeCityLabel.leftAnchor.constraint(equalTo: tempCityLabel.rightAnchor)
        ])
        feelsLikeCityLabel.text = "feels like"
    }
    
}
