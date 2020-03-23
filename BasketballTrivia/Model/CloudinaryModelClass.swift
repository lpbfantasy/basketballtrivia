//
//  CloudinaryModelClass.swift
//  BasketballTrivia
//
//  Created by IOS on 19/03/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary


class CloudinaryModelClass: NSObject {
    
    static let shared = CloudinaryModelClass()
//    config.put("cloud_name", "dzwwk4pom");
//    config.put("api_key", "498516561631492");
//    config.put("api_secret", "vqDNXdDs_NykoPnr02y94Dy2-1Q");
    
    let config = CLDConfiguration(cloudName: "dzwwk4pom", apiKey: "174568725788468", apiSecret: "hSUWd77bJl8adSt7M6dyEAgKfqE")
    
    var cloudinary : CLDCloudinary?
    var publicId: String?
    var thumb: String?
    var original: String?
    var from: String?
    
    override init() {
        super.init()
        cloudinary = CLDCloudinary(configuration: self.config)
        cloudinary!.cachePolicy = CLDImageCachePolicy.disk
        cloudinary!.cacheMaxDiskCapacity = 2 * 1024 * 1024
    }
    
    func uploadImage(image:UIImage,completion: @escaping (_ org:String, _ thumb:String) -> ()){
        
        let fileName = ProcessInfo.processInfo.globallyUniqueString
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("upload").appendingPathComponent(fileName)
        let filePath = fileURL.path
        let imageData = image.jpegData(compressionQuality: 0.5)
        
       try? imageData!.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
        _ = UIImage(contentsOfFile: filePath)
        
        let params = CLDUploadRequestParams()
        params.setPublicId(fileName)
        
        
        _ = cloudinary!.createUploader().upload(url: fileURL, uploadPreset: "htvww61y", params: params, progress: nil, completionHandler: { (response, error) in
            if error == nil
            {
            self.original = response?.url ?? ""
            self.publicId = response?.publicId ?? ""
            self.thumb =  self.cloudinary!.createUrl().setTransformation(CLDTransformation()
                .setQuality(10))
                .generate(self.publicId!)
           
            completion(self.original!, self.thumb!)
            }
           else
            {
                print(error)
            }
            
        })
        
        
    }
    
}
