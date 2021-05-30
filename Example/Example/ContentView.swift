//
//  ContentView.swift
//  Example
//
//  Created by jctaoo on 2020/8/11.
//  Copyright © 2020 jctaoo. All rights reserved.
//

import SwiftUI
import YuiToast

class ContentViewModel: ObservableObject {
  @Published var value: Float = 0.5
  @Published var modifiableItem: ToastItem? = nil
}

struct ContentView: View {
  
  @ObservedObject var viewModel = ContentViewModel()
  private var cancelBag = CancelBag()
  
  private func showSimpleToast() {
    Toast.default.show(message: "Hello World")
  }
  
  private func showToastWithImage() {
    Toast.default.show(message: "Toast With Image", image: UIImage(named: "DemoImage"), duration: .timeInterval(duration: 0.3))
  }
  
  private func showModifiableToast() {
    let item = Toast.default.show(message: "current value is \(viewModel.value)", duration: .never)
    viewModel.modifiableItem = item
    viewModel.$value.sink(receiveValue: { value in
      Toast.default.update(item: item) { item in
        item.title = "current value is \(value)"
      }
    }).cancel(with: cancelBag)
  }
  
  private func hideModifiableToast() {
    if let item = viewModel.modifiableItem {
      Toast.default.remove(item)
    }
  }
  
  var body: some View {
    VStack {
      
      Button(action: self.showSimpleToast) {
        Text("Show Toast")
      }.padding()
      
      Button(action: self.showToastWithImage) {
        Text("Show Toast With Image")
      }.padding()
      
      Button(action: self.showModifiableToast) {
        Text("Show Modifiable Toast")
      }.padding()
      
      Slider(value: $viewModel.value)
        .padding()
      
      Button(action: self.hideModifiableToast) {
        Text("Hide Modifiable Toast")
      }.padding()
      
    }
  }
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
