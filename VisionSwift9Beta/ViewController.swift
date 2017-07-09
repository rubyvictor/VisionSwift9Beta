//
//  ViewController.swift
//  VisionSwift9Beta
//
//  Created by Victor Lee on 9/7/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit
import Vision

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
        
        // request
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect faces", error)
            }
//            print(request)
            
            // results:
            request.results?.forEach({ (result) in
//                print(result)
                
                // Cast results as VNFaceObservation and call its functions
                
                guard let vnFaceObservation = result as? VNFaceObservation else { return }
                
                print(vnFaceObservation.boundingBox)
                
            })
            
            
        }
        // Handle the request
        guard let cgImage = image.cgImage else { return }
        // options return empty dictionary
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            // Array of requests
            try handler.perform([request])
            
        } catch let error {
            print("Failed to perform request",error)
        }
        
    }
    

}

