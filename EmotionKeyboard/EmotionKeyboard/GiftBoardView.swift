//
//  GiftBoardView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/4.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class GiftBoardView: UIView, NibLoadable {

    var emotionButtonClickClosure: ((UIButton)->Void)?
    fileprivate var flowLayout: CollectionViewHorizontalFlowLayout =  CollectionViewHorizontalFlowLayout(rows: 3, cols: 7)
    
    fileprivate var emotionView: EmotionView!
    fileprivate lazy var emotionsArray: [[String]] = [[String]]()
    
    
    @IBOutlet weak var topSeparatorView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flowLayout = CollectionViewHorizontalFlowLayout(rows: 2, cols: 4)
        
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.scrollDirection = .horizontal
        
        let property = TitleViewProperty()
        
        emotionView = EmotionView(frame: CGRect(x: 0, y: topSeparatorView.frame.maxY, width: UIScreen.main.bounds.width, height: bounds.height - topSeparatorView.bounds.height - sendButton.bounds.height), layout: flowLayout, property: property)
        addSubview(emotionView)
        
        emotionView.dataSource = self
        emotionView.delegate = self
        emotionView.register(nib: UINib(nibName: "NormalEmotionCell", bundle: nil), forCellWithReuseIdentifier: normalEmotionCellID)
        
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
        let cell: NormalEmotionCell = collectionView.dequeueReusableCell(withReuseIdentifier: normalEmotionCellID, for: indexPath) as! NormalEmotionCell
        cell.emotionName = emotionsArray[indexPath.section][indexPath.row]
        return cell
    }
}

extension GiftBoardView: EmotionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
