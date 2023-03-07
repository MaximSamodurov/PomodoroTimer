//
//  FocusView.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import Foundation
import UIKit

class FocusView: UIView {
    
    lazy var chipImage = {
        let imageName = "сhip"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
//        imageView.backgroundColor = .black
        return imageView
    }()
    
    
    let timeMinutesCounter = {
        let label = UILabel()
        label.text = "24"
        label.numberOfLines = 1
        label.attributedText = NSAttributedString(string: label.text!, attributes: [.kern: 1.1])
        label.clipsToBounds = true
        label.font = .robotoBlack(size: 211)
        label.textColor = UIColor(#colorLiteral(red: 0.3531352282, green: 0.1171852872, blue: 0.1062337533, alpha: 1))
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
    
    let timeSecondsCounter = {
        let label = UILabel()
        label.text = "59"
        label.clipsToBounds = true
        label.attributedText = NSAttributedString(string: label.text!, attributes: [.kern: 1.1])
        label.numberOfLines = 1
        label.font = .robotoBlack(size: 211)
        label.textColor = UIColor(#colorLiteral(red: 0.3531352282, green: 0.1171852872, blue: 0.1062337533, alpha: 1))
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
    
    let threeDotsButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.sizeToFit()
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(#colorLiteral(red: 0.9975082278, green: 0.8373187184, blue: 0.8360101581, alpha: 1))
        
        // config for sf symbol image
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        button.tintColor = UIColor(#colorLiteral(red: 0.3531352282, green: 0.1171852872, blue: 0.1062337533, alpha: 1))
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: config), for: .normal)
        return button
    }()
    
    let pausePlayButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.sizeToFit()
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.4812640548, blue: 0.4829893708, alpha: 1))
        
        // config for sf symbol image
        let config = UIImage.SymbolConfiguration(pointSize: 23)
        button.tintColor = UIColor(#colorLiteral(red: 0.3531352282, green: 0.1171852872, blue: 0.1062337533, alpha: 1))
        button.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        return button
    }()
    
    let nextSectionButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.sizeToFit()
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(#colorLiteral(red: 0.9975082278, green: 0.8373187184, blue: 0.8360101581, alpha: 1))
        
        // config for sf symbol image
        let config = UIImage.SymbolConfiguration(pointSize: 23)
        button.tintColor = UIColor(#colorLiteral(red: 0.3531352282, green: 0.1171852872, blue: 0.1062337533, alpha: 1))
        button.setImage(UIImage(systemName: "forward.fill", withConfiguration: config), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let counterStack = VerticalStackView(arrangedSubViews: [timeMinutesCounter,
                                                                timeSecondsCounter], spacing: -80)
        
        let threeDotsVerticalStackView = VerticalStackView(arrangedSubViews: [UIView(frame: .init(x: 0, y: 0, width: 0, height: 0)), threeDotsButton, UIView(frame: .init(x: 0, y: 0, width: 0, height: 0))], spacing: -70)
        threeDotsVerticalStackView.distribution = .fillEqually
        
        
        let nextSectionVerticalStackView = VerticalStackView(arrangedSubViews: [UIView(frame: .init(x: 0, y: 0, width: 0, height: 0)), nextSectionButton, UIView(frame: .init(x: 0, y: 0, width: 0, height: 0))], spacing: -70)
        nextSectionVerticalStackView.distribution = .fillEqually
        
        let lowStackView = UIStackView(arrangedSubviews: [
            threeDotsVerticalStackView,
            pausePlayButton,
            nextSectionVerticalStackView
        ])
        
        
        lowStackView.spacing = 10
        lowStackView.distribution = .fillEqually
        
        addSubview(counterStack)
        addSubview(lowStackView)
        addSubview(chipImage)
        
        counterStack.translatesAutoresizingMaskIntoConstraints = false
        lowStackView.translatesAutoresizingMaskIntoConstraints = false
        chipImage.translatesAutoresizingMaskIntoConstraints = false 
        
        NSLayoutConstraint.activate([
            chipImage.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            chipImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 140),
            chipImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -140),
            
            counterStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterStack.topAnchor.constraint(equalTo: chipImage.bottomAnchor, constant: 0),
            
            lowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lowStackView.topAnchor.constraint(equalTo: counterStack.bottomAnchor, constant: 0),
            lowStackView.heightAnchor.constraint(equalToConstant: 90),
            lowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            lowStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        
        backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.9467936158, blue: 0.9479826093, alpha: 1))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


