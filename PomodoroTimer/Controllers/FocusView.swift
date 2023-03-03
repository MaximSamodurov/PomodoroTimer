//
//  FocusView.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 03.03.2023.
//

import Foundation
import UIKit

class FocusView: UIView {
    
    lazy var chipLabel = {
        let label = UILabel()
        label.text = "Focus"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.addImage(imageName: "ph_brain-fill")
        label.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.2003749907, blue: 0.2578251958, alpha: 1))
        return label
    }()
    
    
    let timeCounter = {
        let label = UILabel()
        label.text = "24.59"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.numberOfLines = 2
        return label
    }()
    
    let threeDotsButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    let pausePlayButton = {
        let button = UIButton()
        button.setTitle("play / pause", for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    let nextSectionButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        let lowStackView = UIStackView(arrangedSubviews: [threeDotsButton, pausePlayButton, nextSectionButton])
        lowStackView.spacing = 1
        lowStackView.distribution = .fillEqually
        
        addSubview(timeCounter)
        addSubview(lowStackView)
        
        timeCounter.translatesAutoresizingMaskIntoConstraints = false
        lowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeCounter.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeCounter.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeCounter.topAnchor.constraint(equalTo: topAnchor, constant: 350),
            
            lowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lowStackView.topAnchor.constraint(equalTo: timeCounter.bottomAnchor, constant: 30),
            lowStackView.heightAnchor.constraint(equalToConstant: 54),
            lowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44),
            lowStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44)
            
        ]
)
        backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.9467936158, blue: 0.9479826093, alpha: 1))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UILabel {

    func addImage(imageName: String) {
    
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)

        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        myString.append(attachmentString)

        self.attributedText = myString
    }
}
