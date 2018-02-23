//
//  ViewController.swift
//  Assignment2_insPhoto
//
//  Created by JING YANG on 2018-02-21.
//  Copyright © 2018 JING YANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    
    var photo: UIImage!
    
    var lineLayers : [CAShapeLayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func imgDecorate(_ sender: Any) {
        let imageLayer = CALayer()
        imageLayer.contents = photo
        
        let height = imgView.bounds.height
        let width = imgView.bounds.width
        imageLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        
        let lineLayer1 = CAShapeLayer()
        lineLayer1.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: height)).cgPath
        lineLayer1.frame = CGRect(x: width/3, y: 0, width: width, height: height)
        lineLayers.append(lineLayer1)
        
        let lineLayer2 = CAShapeLayer()
        lineLayer2.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: height)).cgPath
        lineLayer2.frame = CGRect(x: width/3 * 2, y: 0, width: width, height: height)
        lineLayers.append(lineLayer2)
        
        let lineLayer3 = CAShapeLayer()
        lineLayer3.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: 1)).cgPath
        lineLayer3.frame = CGRect(x: 0, y: height/3, width: width, height: height)
        lineLayers.append(lineLayer3)
        
        let lineLayer4 = CAShapeLayer()
        lineLayer4.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: 1)).cgPath
        lineLayer4.frame = CGRect(x: 0, y: height/3*2, width: width, height: height)
        lineLayers.append(lineLayer4)
        
        let maskLayer = CAShapeLayer()
        for i in 0..<lineLayers.count {
            lineLayers[i].fillColor = UIColor.white.cgColor
            maskLayer.addSublayer(lineLayers[i])
        }
        
        imgView.layer.addSublayer(imageLayer)
        imgView.layer.addSublayer(maskLayer)
    }
    
    @IBAction func imgPick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        //        imagePicker.sourceType = .photoLibrary
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
        self.imgDecorate(self)
       
    }
    
    
    @IBAction func imgSave(_ sender: Any) {
        let size = CGSize(width: imgView.bounds.width, height: imgView.bounds.height)
        let render = UIGraphicsImageRenderer(size: size)

        let image = render.image { (context) in
            imgView.layer.render(in: context.cgContext)
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let alertController = UIAlertController(title: "Saved", message: "Photo has been saved", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.photo = imgView.image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}

