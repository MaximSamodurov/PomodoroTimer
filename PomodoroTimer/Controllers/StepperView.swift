//
//  StepperView.swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 21.03.2023.
//

import UIKit

class StepperView: UIView {
    
    let titleLabel = UILabel(text: "Change Time", font: .systemFont(ofSize: 15, weight: .regular))
    
   
    
    lazy var stepper = {
        let step = UIStepper()
        step.stepValue = 5
        return step
    }()
    
    let doneButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = VerticalStackView(arrangedSubViews: [titleLabel, stepper, doneButton], spacing: 1)
        backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.4812640548, blue: 0.4829893708, alpha: 1))
        addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
