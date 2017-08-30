//
//  AnchorViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let kAnchorReuseIdentifier = "anchorReuseIdentifier"

class AnchorViewController: UIViewController {

    var homeType: HomeTypeModel!
    
    fileprivate lazy var flowLayout: CollectionViewWaterFlowLayout = CollectionViewWaterFlowLayout()
    fileprivate var collectionView: UICollectionView!
    
    fileprivate lazy var anchorVM: AnchorViewModel = AnchorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData(index: 0)
    }
    
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.dataSource = self
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: "AnchorViewCell", bundle: nil), forCellWithReuseIdentifier: kAnchorReuseIdentifier)
        
    }

    func loadData(index: Int) {
        anchorVM.loadHomeData(type: homeType, index: index) { 
            self.collectionView.reloadData()
        }
    }
}

extension AnchorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorVM.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnchorViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorReuseIdentifier, for: indexPath) as! AnchorViewCell
        cell.config(anchorVM.anchorModels[indexPath.row])
        return cell
    }
}



// MARK: - CollectionViewWaterFlowLayoutDataSource
extension AnchorViewController: CollectionViewWaterFlowLayoutDataSource {
    
    func numberOfColsInWaterFlowLayout(_ layout: CollectionViewWaterFlowLayout) -> Int {
        return 2
    }
    
    func waterFlowLayout(_ layout: CollectionViewWaterFlowLayout, indexPath: IndexPath) -> CGFloat {
        return anchorVM.anchorModels[indexPath.row].isEvenIndex ? kScreenW * 2/3 : kScreenW * 0.5
    }
    
}
