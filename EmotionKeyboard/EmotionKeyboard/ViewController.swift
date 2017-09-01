//
//  ViewController.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let normalEmotionCellID = "normalEmotionCellID"

class ViewController: UIViewController {

    fileprivate lazy var emotionsArray: [[String]] = [[String]]()
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
        loadEmotionData()

    }
    
    func setupUI() {
        
        let flowLayout: CollectionViewHorizontalFlowLayout = CollectionViewHorizontalFlowLayout(rows: 3, cols: 7)
        
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        flowLayout.scrollDirection = .horizontal
        let eView = EmotionView(frame: CGRect(x: 0, y: 200, width: view.bounds.width, height: 300), layout: flowLayout)
        eView.dataSource = self
        eView.delegate = self
        view.addSubview(eView)
        
        eView.register(nib: UINib(nibName: "NormalEmotionCell", bundle: nil), forCellWithReuseIdentifier: normalEmotionCellID)
        
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

extension ViewController: EmotionViewDataSource {

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

extension ViewController: EmotionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emotionString = emotionsArray[indexPath.section][indexPath.row]
        print(emotionString)
        if emotionString == "delete-n" {
            self.textView.deleteBackward()
            return
        }
        self.textView.insertText(emotionString)
    }
}


