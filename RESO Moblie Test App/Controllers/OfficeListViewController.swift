//
//  OfficeListViewController.swift
//  RESO Moblie Test App
//
//  Created by s b on 18.02.2022.
//

import UIKit
import CoreLocation

class OfficeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var officeList: [OfficeListModel] = []
    
    private let cellId = "cellId"
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    lazy var tableView: UITableView = {
        
        let tv = UITableView(frame: CGRect(x: 0, y: view.bounds.height * 13/80 + view.bounds.height * 35 / 567, width: view.bounds.width, height: view.bounds.height * 67/80 - view.bounds.height * 35 / 567), style: .plain)
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
        
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
            searchBar.placeholder = ""
        searchBar.frame = CGRect(x: 0, y: view.bounds.height * 13 / 80, width: view.bounds.width, height: view.bounds.height * 35 / 567)
            searchBar.isTranslucent = false
            searchBar.delegate = self
        searchBar.backgroundColor = .white
            
        
        
        
        navigationBar.setRadianGradientBackground(colorTop: darkGreen, colorBottom: lightGreen)
//        let navItems = UINavigationItem(title: "NavItems")
//        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
//        backButton.tintColor = .white
//
//        let filterButton = UIBarButtonItem(image: UIImage(systemName: "terminal.fill"), style: .plain, target: nil, action: nil)
//        filterButton.tintColor = .white
//
//        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 18))
//        navTitle.text = "Офисы РЕСО-Гарантия"
//        navTitle.textColor = .white
//        navTitle.textAlignment = .center
//        navTitle.font = .boldSystemFont(ofSize: 18)
//
//        navItems.leftBarButtonItem = backButton
//        navItems.rightBarButtonItem = filterButton
//        navItems.titleView = navTitle
//        navigationBar.setItems([navItems], animated: false)
//        self.view.addSubview(navigationBar)
        
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
        title.text = "Офисы РЕСО-Гарантия"
        title.textColor = .white
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 18)
        
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: 20), scale: .default)), for: .normal)
        
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        filterButton.tintColor = .white
        filterButton.setImage(UIImage(systemName: "flag", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: 20), scale: .default)), for: .normal)
        
        let titleStack = UIStackView(arrangedSubviews: [backButton,title,filterButton])
        titleStack.axis = .horizontal
        titleStack.distribution = .fillProportionally
        titleStack.alignment = .fill
        titleStack.spacing = 34
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        
        let segControl = UISegmentedControl(items: ["Списком", "На карте"])
        segControl.selectedSegmentIndex = 0
    
        
        
        let leftDownPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let rightDownPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let NVHorizontalDownPadding = UIStackView(arrangedSubviews: [segControl])
        NVHorizontalDownPadding.spacing = 0
        NVHorizontalDownPadding.axis = .horizontal
        NVHorizontalDownPadding.distribution = .equalSpacing
        NVHorizontalDownPadding.alignment = .center
        
        
            //  NVHorizontalDownPadding.translatesAutoresizingMaskIntoConstraints = false
        
      //  NVHorizontalDownPadding.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
  
        
        let upperPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let downPadding = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let NVVerticalPadding = UIStackView(arrangedSubviews: [upperPadding,leftDownPadding,titleStack,downPadding,NVHorizontalDownPadding,rightDownPadding,downPadding])
        NVVerticalPadding.axis = .vertical
        NVVerticalPadding.distribution = .fillProportionally
        NVVerticalPadding.alignment = .fill
        NVVerticalPadding.spacing = 20
        NVVerticalPadding.translatesAutoresizingMaskIntoConstraints = false
        
        let nvBarWithoutSafeArea = UIView(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height * 13/80  - 20))
        nvBarWithoutSafeArea.layer.zPosition = 0
        navigationBar.addSubview(nvBarWithoutSafeArea)
        navigationBar.addSubview(NVVerticalPadding)
        
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            titleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: titleStack.trailingAnchor, constant: 10),
            segControl.leadingAnchor.constraint(equalTo: NVVerticalPadding.leadingAnchor, constant: 10),
            NVVerticalPadding.trailingAnchor.constraint(equalTo: segControl.trailingAnchor, constant: 10),
            NVVerticalPadding.centerYAnchor.constraint(equalTo: nvBarWithoutSafeArea.centerYAnchor)
        ])
        
        
        
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return officeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! TableViewCell
        //if cell.address.numberOfLines > 1 {
        return UITableView.automaticDimension
        //} else {
        //   return 60
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! TableViewCell
        
        let graf = "Открыт"
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        func formatName(fullString: String) -> NSMutableAttributedString{
            let range = (fullString as NSString).range(of: fullString)
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: fullString)
            myMutableString.setAttributes([.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.black], range: range)
            return myMutableString
        }
        
        func addPaddingOfSize(_ ofSize: Double) -> NSMutableAttributedString{
            let fullString = "\n"
            let range = (fullString as NSString).range(of: fullString)
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: fullString)
            myMutableString.setAttributes([.font: UIFont.systemFont(ofSize: CGFloat(ofSize))], range: range)
            return myMutableString
        }
        
        func formatAddress(fullString: String) -> NSMutableAttributedString{
            let range = (fullString as NSString).range(of: fullString)
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: fullString)
            myMutableString.setAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor : UIColor.lightGray], range: range)
            return myMutableString
        }
        func formatGraf(fullString: String) -> NSMutableAttributedString{
            let range = (fullString as NSString).range(of: fullString)
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: fullString)
            myMutableString.setAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor : UIColor(red: 35/255, green: 128/255, blue: 63/255, alpha: 1.0)], range: range)
            return myMutableString
        }
        func formatDistance(fullString: String) -> NSMutableAttributedString{
            let range = (fullString as NSString).range(of: fullString)
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: fullString)
            myMutableString.setAttributes([.font: UIFont.systemFont(ofSize: 12), .foregroundColor : UIColor.lightGray], range: range)
            return myMutableString
        }
        
        let OfficeCoordinate = CLLocation(latitude: self.officeList[indexPath.row].NLAT, longitude: self.officeList[indexPath.row].NLONG)
        
        let currentLocation = CLLocation(latitude: 55.755826, longitude: 37.6172999)
        
        let distance = Float(OfficeCoordinate.distance(from: currentLocation)) / 1000.0
        
        
        let nameFormated = formatName(fullString: "\(officeList[indexPath.row].SSHORTNAME)\n")
        let paddingNameAddress = addPaddingOfSize(5)
        let addressFormated = formatAddress(fullString: "\(officeList[indexPath.row].SSHORTADDRESS)\n")
        let paddingAddressGrafDistance = addPaddingOfSize(7)
        let grafFormated = formatGraf(fullString: graf)
        let distanceFormated = formatDistance(fullString: String(format: " до офиса: %.1f км.", distance))
        
        
        
        
        let combination = NSMutableAttributedString()
        combination.append(nameFormated)
        combination.append(paddingNameAddress)
        combination.append(addressFormated)
        combination.append(paddingAddressGrafDistance)
        combination.append(grafFormated)
        combination.append(distanceFormated)
        
        
        // set the custom font and color for the 0,1 range in string
        //amountText.setAttributes(combination)
        // if you want, you can add more attributes for different ranges calling .setAttributes many times
        
        // set the attributed string to the UILabel object
        
        //name.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        cell.textLabel?.numberOfLines = 6
        cell.textLabel?.attributedText = combination
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.attributedText = combination
        cell.accessoryType = .disclosureIndicator
        
        //cell.name.text = officeList[indexPath.row].SSHORTNAME
        //        cell.address.text = officeList[indexPath.row].SSHORTADDRESS
        //        cell.state.text = "Открыт"
        //        cell.distance.text = "до офиса: \(19.2) км."
        //        cell.accessoryType = .disclosureIndicator
        //        cell.textLabel?.text = officeList[indexPath.row].SSHORTNAME
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

