//
//  ViewController.swift
//  VisionSwift9Beta
//
//  Created by Victor Lee on 9/7/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "Sample1") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .blue
        
        view.addSubview(imageView)
    }
    


}

