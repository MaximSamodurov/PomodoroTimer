//
//  Settings .swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//

import UIKit

class SettingsController: UITableViewController {
    
    private let cellID = "cellID"
    var settingsModel = [SettingsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsView.self, forCellReuseIdentifier: cellID)
        self.tableView.reloadData()
        settingsModel.append(SettingsModel(title: "Focus", intervals: "20 minutes"))
        settingsModel.append(SettingsModel(title: "Short Break", intervals: "5 minutes"))
        settingsModel.append(SettingsModel(title: "Long Break", intervals: "15 minutes"))
        view.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.9467936158, blue: 0.9479826093, alpha: 1))
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: -20, right: 0);
    }
    
//    let changeTimeSettings = UIView()
//    
//    fileprivate func setupFloatingControls() {
//        // clipsToBounds - что бы после blurVisualEffect работал cornerRadius
//        changeTimeSettings.clipsToBounds = true
//        changeTimeSettings.layer.cornerRadius = 16
//        view.addSubview(changeTimeSettings)
//        
////        let bottomPadding = UIApplication.shared.statusBarFrame.height
//        changeTimeSettings.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
//        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
//        changeTimeSettings.addSubview(blurVisualEffectView)
//        blurVisualEffectView.fillSuperview()
//        
////        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//        
//        // add subViews
//        let imageView = UIImageView(cornerRadius: 16)
//        imageView.image = todayItem?.image
//        imageView.constrainHeight(constant: 68)
//        imageView.constrainWidth(constant: 68)
//        let getButton = UIButton(title: "GET")
//        getButton.setTitleColor(.white, for: .normal)
//        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        getButton.backgroundColor = .darkGray
//        getButton.layer.cornerRadius = 16
//        getButton.constrainWidth(constant: 80)
//        getButton.constrainHeight(constant: 32)
//        
//        let verticalStackView = VerticalStackView(arrangedSubViews: [
//            UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
//            UILabel(text: "Utilizing Your Time", font: .systemFont(ofSize: 16))
//        ], spacing: 4)
//        
//        let stackView = UIStackView(arrangedSubviews: [
//            imageView,verticalStackView,
//            getButton
//        ], customSpacing: 16)
//        
//        changeTimeSettings.addSubview(stackView)
//        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
//        stackView.alignment = .center
//                                
//    }
    
    
//    сделать попап в котором будет выпадать степпер
//      предеать данные в фокус вью и остальные вью
    // и сохранить данные настроек в юзердефолтс
}


// MARK: Extensions
extension SettingsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingsView
        let model = settingsModel[indexPath.row]
        cell.titleLabel.text = model.title
        cell.intervalLabel.text = model.intervals
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
