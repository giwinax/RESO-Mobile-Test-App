//
//  OfficeListViewController.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import UIKit

class OfficeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var officeList: [OfficeListModel] = []
    
    private let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView(frame: CGRect(x: 0, y: view.bounds.height * 13/80, width: view.bounds.width, height: view.bounds.height * 67/80), style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .lightGray
        tv.delegate = self
        tv.dataSource = self
        tv.register(TableViewCell.self, forCellReuseIdentifier: self.cellId)
        tv.backgroundColor = .white
        return tv
    }()
    
    lazy var navigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 13/80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkGreen = UIColor(red: 35/255, green: 128/255, blue: 63/255, alpha: 1.0)
        let lightGreen = UIColor(red: 90/255, green: 168/255, blue: 68/255, alpha: 1.0)
        navigationBar.setRadianGradientBackground(colorTop: darkGreen, colorBottom: lightGreen)
        
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 18))
        title.text = "Офисы РЕСО-Гарантия"
        title.textColor = .white
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 18)
        
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 10, height: 25))
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 10, height: 25))
        filterButton.tintColor = .white
        filterButton.setImage(UIImage(systemName: "terminal.fill"), for: .normal)
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let NVHorizontalPadding = UIStackView(arrangedSubviews: [leftPadding,backButton,title,filterButton,rightPadding])
        NVHorizontalPadding.axis = .horizontal
        NVHorizontalPadding.distribution = .fillProportionally
        NVHorizontalPadding.alignment = .fill
        NVHorizontalPadding.spacing = 34
        NVHorizontalPadding.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: GLOBAL: NVBar, appropriate cells size and highlighting, 
        
        
        navigationBar.addSubview(NVHorizontalPadding)
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    //
    // MARK :- CELL
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return officeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! TableViewCell
        //if cell.address.numberOfLines > 1 {
        return 80
        //} else {
         //   return 60
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! TableViewCell
        cell.name.text = officeList[indexPath.row].SSHORTNAME
        cell.address.text = officeList[indexPath.row].SSHORTADDRESS
        cell.state.text = "Открыт"
        cell.distance.text = "до офиса: \(19.2) км."
        cell.accessoryType = .disclosureIndicator
        //cell.textLabel?.text = officeList[indexPath.row].SSHORTNAME
        return cell
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

