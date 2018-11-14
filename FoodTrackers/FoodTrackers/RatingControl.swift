//
//  ratingControl.swift
//  FoodTrackers
//
//  Created by Admin on 11/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
class ratingControl: UIStackView {
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //        load button image
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "star2", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "star1", in: bundle, compatibleWith: self.traitCollection)
        let hightlightedStar = UIImage(named: "star3", in: bundle, compatibleWith: self.traitCollection)
        for _ in 0..<starCount {
            let button = UIButton()
            //set image button
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .normal)
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            //setup button action
            button.addTarget(self, action: #selector(ratingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //            them button vao stack
            addArrangedSubview(button)
            //            them button vao mang xep hang
            ratingButtons.append(button)
            
            updateButtonSelectionStates()
        }
    }
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("button khong nam trong mang ratingbutton")
        }
        //tinh toan xep hang cua nut da chon
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }


}
