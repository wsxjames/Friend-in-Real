//
//  ButtonView.swift
//  Friend in Real
//
//  Created by 吴世欣 on 3/16/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import Foundation
import UIKit

class Button: UIView {
  //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  //common func to init our view
  private func setupView() {
    backgroundColor = .red
  }
}
