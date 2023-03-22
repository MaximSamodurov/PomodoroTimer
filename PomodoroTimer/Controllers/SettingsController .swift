//
//  Settings .swift
//  PomodoroTimer
//
//  Created by Maxim Samodurov on 10.03.2023.
//


//максим:
//     сделать попап в котором будет выпадать степпер
//     предеать данные в фокус вью и остальные вью
//ренат:
// и сохранить данные настроек в юзердефолтс

import UIKit

class SettingsController: UITableViewController {
    
    private let cellID = "cellID"
    var settingsModel = [SettingsModel]()
    let stepperView = StepperView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsView.self, forCellReuseIdentifier: cellID)
        self.tableView.reloadData()
        settingsModel.append(SettingsModel(title: "Focus", intervals: "20 minutes"))
        settingsModel.append(SettingsModel(title: "Short Break", intervals: "5 minutes"))
        settingsModel.append(SettingsModel(title: "Long Break", intervals: "15 minutes"))
        view.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.9467936158, blue: 0.9479826093, alpha: 1))
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: -20, right: 0)
        stepperView.doneButton.addTarget(self, action: #selector(donePopUp), for: .touchUpInside)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        configPopOver()
        
    }
    
    @objc func donePopUp() {
        self.stepperView.removeFromSuperview()
        // походу сюда сохранять юзердефолтс при нажатии на done
    }
    
    func configPopOver() {
        stepperView.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
//        popoverView.addSubview(dismissPopoverView)
        stepperView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.stepperView.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 300, height: 300)
            self.stepperView.center = self.view.center
            self.stepperView.alpha = 1
            self.view.addSubview(self.stepperView)
        }
//        dismissPopoverView.anchor(top: popoverView.topAnchor, left: popoverView.leftAnchor,
//                                  bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30,
//                                  paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
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
    
    
}
