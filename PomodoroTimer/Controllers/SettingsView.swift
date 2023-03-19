//
//  SettingsController.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//

import UIKit

class SettingsView: UITableViewCell {
    
    let titleLabel = UILabel(text: "Work Interval", font: .systemFont(ofSize: 22))
    let intervalLabel = UILabel(text: "20 minutes", font: .systemFont(ofSize: 22))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, intervalLabel])
        stackView.spacing = 10
        addSubview(stackView)
        stackView.fillSuperview()
        
        backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.9467936158, blue: 0.9479826093, alpha: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
