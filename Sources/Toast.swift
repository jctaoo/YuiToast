//
//  YuiToast.swift
//  YuiToast
//
//  Created by 陶俊丞 on 2020/4/12.
//  Copyright © 2020 junso. All rights reserved.
//

import UIKit
import SnapKit

/// the class to manage toast.
@objc(YuiToast)
final public class Toast: NSObject {
  
  public static let `default` = Toast()
  
  public init(window: UIWindow) {
    self.window = window
    super.init()
  }
  
  /// default window is first window
  public override init() {
    self.window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
    super.init()
  }
  
  final private var window: UIWindow
  
  final private var toastViews: [ToastView] = []
  
  final private func getView(by item: ToastItem) -> (Int, ToastView)? {
    toastViews.enumerated().filter({ $0.element.item.identity == item.identity }).first
  }
  
  final public func config(textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
    if let tc = textColor {
      ToastView.Configuration.textColor = tc
    }
    if let bc = backgroundColor {
      ToastView.Configuration.backgroundColor = bc
    }
  }
  
  final public func update(item toastItem: ToastItem, updateClouser: ((ToastItem) -> ()) = { _ in }) {
    updateClouser(toastItem)
    if let view = getView(by: toastItem)?.1 {
      view.item = toastItem
    }
  }
  
  @discardableResult
  final public func show(message: String, image: UIImage? = nil, duration: ToastItem.Duration? = nil) -> ToastItem {
    if let duration = duration {
      return add(ToastItem(title: message, image: image, duration: duration))
    } else {
      return add(ToastItem(title: message, image: image))
    }
  }
  
  @discardableResult
  final public func show(_ toastItem: ToastItem) -> ToastItem {
    return add(toastItem)
  }
  
  @discardableResult
  final public func remove(_ toastItem: ToastItem) -> ToastItem {
    guard let (index, toastViewReadyToRemove) = getView(by: toastItem) else {
      return toastItem
    }
    self.toastViews.remove(at: index)
    toastItem.available = false
    self.remove(toastViewReadyToRemove, newer: toastViews)
    return toastItem
  }
  
  @discardableResult
  final private func add(_ toastItem: ToastItem) -> ToastItem {
    let toastView = ToastView(item: toastItem)
    window.addSubview(toastView)
    layoutToast(toastView, pre: toastViews)
    // check itemToView and remove some old
    if toastViews.count > 2 {
      [0...toastViews.count - 2].forEach({ index in
        if let item = toastViews[index].first?.item {
          self.remove(item)
        }
      })
    }
    // save new item
    toastViews.append(toastView)
    toastItem.available = true
    // move old
    self.moveOld(toastViews)
    // start timer
    if let intervalToRemove = toastItem.duration.interval {
      Timer.scheduledTimer(withTimeInterval: intervalToRemove, repeats: false, block: { _ in
        self.remove(toastItem)
      })
    }
    return toastItem
  }
  
  /// Remove the toast.
  /// Called after the toast item remove from `itemToView`, before remove toast view from superView, and just called once.
  ///
  /// - Parameters:
  ///   - taostRemoved: the toast view ready to remove from superView. (doesm't in the `itemToView`)
  ///   - preToast: the list of toast showing on the screen ascending sorted by creating time. (in `itemToView`)
  final private func remove(_ toastRemoved: ToastView, newer newerToast: [ToastView]) {
    UIView.AnimateSet(animations: {
      toastRemoved.alpha = 0
      toastRemoved.snp.remakeConstraints { make in
        make.top.equalTo(self.window).offset(255)
        make.centerX.equalTo(self.window)
      }
      self.window.layoutIfNeeded()
    }, completion: { _ in
      toastRemoved.removeFromSuperview()
    })
  }
  
  /// Define the behavior of toast view layouting.
  /// Called after the toast view added to `window`(main window) and just called once.
  ///
  /// - Parameters:
  ///   - currentToastView: current toast view to layout.
  ///   - preToast: the list of toast showing on the screen ascending sorted by creating time.
  final private func layoutToast(_ currentToastView: ToastView, pre preToast: [ToastView]) {
    currentToastView.center.x = window.center.x
    currentToastView.snp.makeConstraints { make in
      make.top.equalTo(window).offset(-50)
      make.centerX.equalTo(window)
    }
    UIView.AnimateSet {
      currentToastView.snp.updateConstraints { make in
        make.top.equalTo(self.window).offset(45)
      }
      self.window.layoutIfNeeded()
    }
  }
  
  final private func moveOld(_ views: [ToastView]) {
    for (index, view) in views.enumerated() {
      if index < views.count - 1 {
        let next = views[index + 1]
        UIView.AnimateSet {
          view.snp.remakeConstraints { make in
            make.top.equalTo(next.snp.bottom).offset(20)
            make.centerX.equalTo(self.window)
          }
          self.window.layoutIfNeeded()
        }
      }
    }
  }
  
}

