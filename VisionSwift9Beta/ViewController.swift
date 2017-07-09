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
        
        guard let image = UIImage(named: "sample6") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .blue
        
        view.addSubview(imageView)
        
        // Request
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect faces", error)
            }
            //            print(request)
            // results:  Need to get back onto Main Thread after making handler async
            request.results?.forEach({ (result) in
                //                print(result)
                
                DispatchQueue.main.async {
                    // Cast results as VNFaceObservation and call its functions
                    
                    guard let vnFaceObservation = result as? VNFaceObservation else { return }
                    
                    // Use faceObservation's boundingBox values  to get x y origin coordinates to place faceView.  Remember origin starts from lower left.
                    let x = self.view.frame.width * vnFaceObservation.boundingBox.origin.x
                    let width = self.view.frame.width * vnFaceObservation.boundingBox.width
                    let height = scaledHeight * vnFaceObservation.boundingBox.height
                    
                    // 2 steps to getting correct y coordinate. First, 1 minus the origin.y. Second, subtract the height
                    
                    let y = scaledHeight * (1 - vnFaceObservation.boundingBox.origin.y) - height
                    
                    // Make box to place on face
                    let faceView = UIView()
                    faceView.backgroundColor = .yellow
                    faceView.alpha = 0.4
                    faceView.frame = CGRect(x: x, y: y, width: width, height: height)
                    self.view.addSubview(faceView)
                    
                    print(vnFaceObservation.boundingBox)
                }
            })
        }
        // Handle the request
        guard let cgImage = image.cgImage else { return }
        // options return empty dictionary
        
        // Image loading slow, so bring it to background thread
        
        DispatchQueue.global(qos: .background).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            do {
                // Array of requests
                try handler.perform([request])
                
            } catch let error {
                print("Failed to perform request",error)
            }
        }
    }
}

