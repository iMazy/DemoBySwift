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
    
    fileprivate var flowLayout: CollectionViewHorizontalFlowLayout!
    
    fileprivate var emotionView: EmotionView!
    fileprivate lazy var emotionsArray: [[String]] = [[String]]()
    
    
    @IBOutlet weak var topSeparatorView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setNeedsLayout()
        layoutIfNeeded()
        
        flowLayout = CollectionViewHorizontalFlowLayout(rows: 2, cols: 4)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.scrollDirection = .horizontal
        
        let property = TitleViewProperty()
        
        emotionView = EmotionView(frame: CGRect(x: 0, y: topSeparatorView.frame.maxY, width: UIScreen.main.bounds.width, height: bounds.height - topSeparatorView.frame.maxY - sendButton.bounds.height),titles: ["普通","会员", "专属"], layout: flowLayout, property: property)
        addSubview(emotionView)
        emotionView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin]
        
        emotionView.dataSource = self
        emotionView.delegate = self
        emotionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), forCellWithReuseIdentifier: giftViewCellID)
        
        loadEmotionData()
    }
    
    
    func loadEmotionData() {
        
        guard let normalPath = Bundle.main.path(forResource: "QHNormalEmotionSort.plist", ofType: nil) else { return }
        let normalEmotions: [String] = NSArray(contentsOfFile: normalPath) as! [String]
        emotionsArray.append(normalEmotions)
        
        guard let giftPath = Bundle.main.path(forResource: "QHSohuGifSort.plist", ofType: nil) else { return }
        let giftEmotions: [String] = NSArray(contentsOfFile: giftPath) as! [String]
        emotionsArray.append(giftEmotions)
    }
    
}

extension GiftBoardView: EmotionViewDataSource {
    
    func numberOfSections(in emotionView: EmotionView) -> Int {
        return emotionsArray.count
    }
    
    func numberOfItemsInSection(emotionView: EmotionView, section: Int) -> Int {
        return emotionsArray[section].count
    }
    
    func collectionView(emotionView: EmotionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GiftViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: giftViewCellID, for: indexPath) as! GiftViewCell
        return cell
    }
}

extension GiftBoardView: EmotionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
