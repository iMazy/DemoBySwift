//
//  ViewController.swift
//  RealmSwiftDemo
//
//  Created by  Mazy on 2017/4/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import YYWebImage

let reuseID = "cell"

class ViewController: UIViewController {

    var dataSource:[RealmModel] = [RealmModel]()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: self.view.bounds, style: .plain)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://live.9158.com/Fans/GetHotLive?page=1") else {
            return
        }
        Alamofire.request(url).validate().responseJSON { (response) in

            switch response.result {
            case .success:
                if let JSON:[String: AnyObject] = response.result.value as? [String: AnyObject] {
                    let data = JSON["data"]
                    let dataArray = data?["list"] as! [[String: AnyObject]]
                    print(dataArray)
                    for item in dataArray {
                        let model = RealmModel()
                        model.setValuesForKeys(item)
                        self.dataSource.append(model)
                    }
                    
                    // 通过Realm存储数据
                    self.writeJsonToRealm(source: self.dataSource)
                    
                }
            case .failure(let error):
                print(error)
                let localSource = self.readJsonFromRealm()
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: localSource)
            }
            
            self.tableView.reloadData()
            
        }
        
        tableView.dataSource = self
        tableView.rowHeight = 80
        view.addSubview(tableView)
        
    }
    
        
    
    fileprivate func writeJsonToRealm(source: [RealmModel]) {
        let realm = try! Realm()
        
        try! realm.write {
//            realm.add(source)
            // 通过主键更新数据
            realm.add(source, update: true)
        }
    }


    fileprivate func readJsonFromRealm() -> [RealmModel] {
        let realm = try! Realm()
        let results = realm.objects(RealmModel.self).sorted(byKeyPath: "pos")
        var newSource = [RealmModel]()
        newSource.append(contentsOf: results)
        return newSource
    }
    
    
    @IBAction func clearCache(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        let localSource = readJsonFromRealm()
        dataSource.removeAll()
        dataSource.append(contentsOf: localSource)
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
            cell?.accessoryType = .disclosureIndicator
        }
        let model = dataSource[indexPath.row]
        cell?.textLabel?.text = model.myname
        cell?.detailTextLabel?.text = model.signatures
        cell?.imageView?.yy_setImage(with: URL(string: model.smallpic!), options: [])
        return cell!
    }
}

