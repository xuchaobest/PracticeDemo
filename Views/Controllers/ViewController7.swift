//
//  ViewController7.swift
//  practice
//
//  Created by 许超 on 2019/10/20.
//  Copyright © 2019 许超. All rights reserved.
//

import Foundation



class ViewController7: UIViewController {
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.view.backgroundColor = UIColor.white
      self.addXuCView()
      self.addSubView()
   }
   @objc func addXuCView(){
      let xuc = XuCView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300))
      self.view.addSubview(xuc)
   }
   func addSubView() -> Void {
      let blueView = UIView.init(frame: CGRect.init(origin: CGPoint.init(x: 100, y: 400), size: CGSize.init(width: 100, height: 50)))
      blueView.backgroundColor = UIColor.blue
      blueView.layer.cornerRadius = 10
      blueView.clipsToBounds = true
      self.view.addSubview(blueView)
   }
}

