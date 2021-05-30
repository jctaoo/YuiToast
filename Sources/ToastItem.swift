//
//  ToastItem.swift
//  YuiToast
//
//  Created by jctaoo on 2020/4/12.
//  Copyright © 2020 jctaoo. All rights reserved.
//

import UIKit
import SnapKit

@objc(YuiToastItem)
open class ToastItem: NSObject {
  
  final public let identity: String = UUID().uuidString
  final public let createTime: Date = Date()
  final public var available: Bool = false
  
  final public var duration: Duration
  open var title: String?
  open var image: UIImage?
  public static let empty = ToastItem()
  
  public enum Duration {
    case timeInterval(duration: TimeInterval)
    case never
    
    var interval: TimeInterval? {
      switch self {
        case .timeInterval(let duration):
          return duration
        case .never:
          return nil
      }
    }
  }
  
  public init(title: String? = nil, image: UIImage? = nil, duration: Duration = .timeInterval(duration: 3.5)) {
    self.duration = duration
    self.title = title
    self.image = image
    super.init()
  }
  
}

