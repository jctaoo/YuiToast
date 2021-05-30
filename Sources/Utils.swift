//
//  Utils.swift
//  YuiToast
//
//  Created by jctaoo on 2020/4/12.
//  Copyright © 2020 jctaoo. All rights reserved.
//

import UIKit

extension UIView {
  
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.masksToBounds = true
      layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
    }
  }
  
  func sketchShadow(color: UIColor, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
    if spread != 0.0 {
      let rect = bounds.insetBy(dx: -spread, dy: -spread)
      layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
    }
    layer.shadowColor = color.cgColor
    layer.shadowOffset = CGSize(width: x, height: y)
    layer.shadowRadius = blur / 2
    layer.shadowOpacity = 1
    layer.masksToBounds = false
  }
  
  static func AnimateSet(times: Double = 1.0, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: 0.15 * times, animations: animations, completion: completion)
  }
  
  static func AnimateSet(times: Double = 1.0, animations: @escaping () -> Void) {
    UIView.animate(withDuration: 0.15 * times, animations: animations)
  }
  
}

public extension UIFont {
  
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [
      UIFontDescriptor.TraitKey.weight: weight]
    ])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
  
}
