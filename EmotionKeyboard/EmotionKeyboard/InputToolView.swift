//
//  InputToolView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/1.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class InputToolView: UIView, NibLoadable {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var emotionButtonClickClosure: ((UIButton)->Void)?
    
    fileprivate lazy var emotionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    fileprivate var emotionView: EmotionView = EmotionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 260))
    
    fileprivate lazy var emotionsArray: [[String]] = [[String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        emotionButton.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emotionButton.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emotionButton.addTarget(self, action: #selector(emotionButtonClick), for: .touchUpInside)
        
        textField.rightView = emotionButton
        textField.rightViewMode = .always
        
        
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

    
    @objc fileprivate func emotionButtonClick(button: UIButton) {
        button.isSelected = !button.isSelected
        
        let range = textField.selectedTextRange
        
        textField.resignFirstResponder()
        textField.inputView = textField.inputView == nil ? emotionView : nil
        textField.becomeFirstResponder()
        textField.selectedTextRange = range
    }
    
}

extension InputToolView: EmotionViewDataSource {
    
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

extension InputToolView: EmotionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emotionString = emotionsArray[indexPath.section][indexPath.row]
        print(emotionString)
        if emotionString == "delete-n" {
            self.textField.deleteBackward()
            return
        }
        self.textField.insertText(emotionString)
    }
}

