//
//  GiftBoardView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/4.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let giftViewCellID = "GiftViewCellIdentifier"

class GiftBoardView: UIView, NibLoadable {

    var emotionButtonClickClosure: ((UIButton)->Void)?
    fileprivate var flowLayout: CollectionViewHorizontalFlowLayout =  CollectionViewHorizontalFlowLayout(rows: 3, cols: 7)
    
    fileprivate var emotionView: EmotionView!
    fileprivate lazy var emotionsArray: [[String]] = [[String]]()
    
    fileprivate var giftVM: GiftViewModel = GiftViewModel()
    
    @IBOutlet weak var topSeparatorView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutIfNeeded()
        setNeedsDisplay()
        
        flowLayout = CollectionViewHorizontalFlowLayout(rows: 2, cols: 4)
        
//        flowLayout.minimumLineSpacing = 10
//        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.scrollDirection = .horizontal
        
        let property = TitleViewProperty()
        
        emotionView = EmotionView(frame: CGRect(x: 0, y: topSeparatorView.frame.maxY, width: UIScreen.main.bounds.width, height: bounds.height - topSeparatorView.frame.maxY - sendButton.bounds.height - 20),titles: ["热门", "高级", "豪华", "专属", "VIP专属"], layout: flowLayout, property: property)
        emotionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(emotionView)
        
        emotionView.dataSource = self
        emotionView.delegate = self
        emotionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: giftViewCellID)
        
        loadGiftData()
    }
    
    
    func loadGiftData() {
        
        self.giftVM.loadGiftData { 
            self.emotionView.collectionView?.reloadData()
        }
    }
    
}

extension GiftBoardView: EmotionViewDataSource {
    
    func numberOfSections(in emotionView: EmotionView) -> Int {
        print(giftVM.giftList.count)
        return giftVM.giftList.count
    }
    
    func numberOfItemsInSection(emotionView: EmotionView, section: Int) -> Int {
        return giftVM.giftList[section].list.count
    }
    
    func collectionView(emotionView: EmotionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GiftViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: giftViewCellID, for: indexPath) as! GiftViewCell
        cell.giftModel = giftVM.giftList[indexPath.section].list[indexPath.row]
        return cell
    }
}

extension GiftBoardView: EmotionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
