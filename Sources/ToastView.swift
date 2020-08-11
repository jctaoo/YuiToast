//
//  ToastView.swift
//  YuiToast
//
//  Created by 陶俊丞 on 2020/4/12.
//  Copyright © 2020 junso. All rights reserved.
//

import UIKit
import SnapKit

@objc(YuiToastView)
open class ToastView: UIView {
  
  // MARK: - Properties
  
  open var item: ToastItem = .empty {
    didSet {
      imageView.image = item.image
      titleLabel.text = item.title
      if item.image != oldValue.image {
        imageView.snp.updateConstraints { make in
          make.trailing.equalTo(self.titleLabel.snp.leading).offset(self.item.image == nil ? 0 : -5)
          make.width.height.equalTo(self.item.image == nil ? 0 : 20)
        }
      }
    }
  }
  
  // MARK: - UI Components
  
  /// A container of all content, add some view into `contentView` if you want to custom `ToastView`.
  open lazy var contentView: UIView = {
    let view = UIView()
    view.addSubview(self.imageView)
    view.addSubview(self.titleLabel)
    view.layer.masksToBounds = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  /// The `imageView` is circle and it's default size is 20 * 20.
  open lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .clear
    imageView.cornerRadius = 10
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  /// Default text color is secondaryLabel, because the information in `ToastView` isn't primary one in the screen normally.
  /// And default font is bold footnote.
  open lazy var titleLabel: UILabel = {
    let label = UILabel()
    if #available(iOS 13.0, *) {
      label.textColor = .secondaryLabel
    } else {
      label.textColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9607843137, alpha: 0.6)
    }
    label.font = UIFont.preferredFont(forTextStyle: .footnote).withWeight(.bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  open lazy var tapGesture: UITapGestureRecognizer = {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.doTap))
    tap.delegate = self
    return tap
  }()
  
  // MARK: - Life Cycle
  
  convenience init(item toastItem: ToastItem) {
    self.init()
    defer {
      self.item = toastItem
    }
  }
  
  private init() {
    super.init(frame: .zero)
    self.commonInit()
  }
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  public required init?(coder: NSCoder) {
    // TODO: 实现类似这样的API
    // @IBOutlet weak var toast: ToastView!
    // toast.show(duration: .never)
    // toast.hide()
    fatalError("unspport Interface Builder")
  }
  
  open func commonInit() {
    addGestureRecognizer(self.tapGesture)
    if #available(iOS 13.0, *) {
      backgroundColor = .systemBackground
    } else {
      backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    cornerRadius = 8
    sketchShadow(color: UIColor.black.withAlphaComponent(0.5), x: 0, y: 2, blur: 4, spread: 0)
    addSubview(contentView)
    layoutContent()
  }
  
  /// to layout subviews in `ToastView`
  /// Called after all views have added to `ToastView` and just called once.
  open func layoutContent() {
    imageView.snp.makeConstraints { make in
      make.trailing.equalTo(self.titleLabel.snp.leading).offset(self.item.image == nil ? 0 : -5)
      make.width.height.equalTo(self.item.image == nil ? 0 : 20)
      make.leading.centerY.equalTo(self.contentView)
    }
    titleLabel.snp.makeConstraints { make in
      make.trailing.equalTo(self.contentView)
      make.top.equalTo(self.contentView).offset(1)
      make.bottom.equalTo(self.contentView).offset(-1)
    }
    contentView.snp.makeConstraints { make in
      make.top.equalTo(self).offset(4)
      make.bottom.equalTo(self).offset(-4)
      make.leading.equalTo(self).offset(12)
      make.trailing.equalTo(self).offset(-12)
    }
  }
  
  // MARK: - Gestures
  
  @objc private func doTap(sender: UITapGestureRecognizer) {
    
  }
  
}

extension ToastView: UIGestureRecognizerDelegate {
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
}
