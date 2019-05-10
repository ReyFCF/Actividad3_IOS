//
//  UploadImage.swift
//  Pinterest
//
//  Created by MacBook Air on 5/9/19.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreML
import Vision

class UploadImage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(Button)
        view.addSubview(imageToUpload)
        
        Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 210).isActive = true
        Button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        imageToUpload.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        imageToUpload.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageToUpload.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageToUpload.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        
    }
    
    let imageToUpload : UIImageView = {
        let imageV = UIImageView()
        imageV.image = #imageLiteral(resourceName: "hello7")
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    
    lazy var Button : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        ub.setTitle("Elegir imagen", for: .normal)
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return ub
    }()
    
    lazy var upload : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        ub.setTitle("Subir imagen", for: .normal)
        ub.translatesAutoresizingMaskIntoConstraints = false
        //ub.addTarget(self, action: #selector(uploadImagen), for: .touchUpInside)
        return ub
    }()
    
    
    
    @objc func handleButton(_ sender:UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        /*let datosViewC = datosViewController()
         self.navigationController?.pushViewController(datosViewC, animated: true)*/
    }
    
    /*
    @objc func uploadImage(){
        
        
        let image = UIImage(named: "hello1")
        let storageRef = Storage.storage().reference().child("\(ivar_getName).jpg")
        //var UID = "123"//userL?.uid
        
        
        if let uploadData = image?.jpegData(compressionQuality:300){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("error al subir imagen")
                    return
                }
                
                var ref = Database.database().reference(fromURL: "https://pinterest-7574e.firebaseio.com/")
                let values = ["nombre" :ivar_getName, "type": "jpg", "uuid" : UUID(), "message" : self.pin.text as! String, "url" : "980"] as [String : Any]
                let usersRef = ref.child("imagesURLS").child(UUID().uuidString)
                usersRef.updateChildValues(values, withCompletionBlock: { (error, databaseRef:DatabaseReference?) in
                    if error != nil { print(error) }
                })
            })
        }
        //self.loadPines()
    }*/
    func run(after seconds: Int, completion: @escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    fileprivate func predict(cgImage: CGImage){
        guard let model = try? VNCoreMLModel(for:SqueezeNet().model)else {return}
        //VNCoreModelRequest(model: model) {(VNRequest, Error?) in
        let request = VNCoreMLRequest(model: model) {(finishedReq, err)in
            guard let results = finishedReq.results as? [VNClassificationObservation] else  {return}
            guard let firstObservation = results.first else {return}
            
            print("\(firstObservation.identifier)")
        }
        try?VNImageRequestHandler(cgImage:cgImage,options:[:]).perform([request])
    }
}
