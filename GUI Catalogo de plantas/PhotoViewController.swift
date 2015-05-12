//
//  ViewController.swift
//  Camera Demo
//
//  Created by Gustavo Villar on 4/22/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

import UIKit
import MobileCoreServices

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage?
    var bluePosition: CGPoint?
    var redPosition: CGPoint?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var takePictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        takePictureButton.layer.cornerRadius = 10
//        takePictureButton.layer.borderColor = UIColor.whiteColor().CGColor
//        takePictureButton.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImageButtonPressed(sender: UIButton) {
        
        var actionSheet = UIAlertController(title: "Seleccionar", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            var action = UIAlertAction(title: "Escoger imagen existente", style: .Default) {
                action in
                
                var imageChooser = UIImagePickerController()
                //imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imageChooser.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                imageChooser.mediaTypes = [kUTTypeImage]
                imageChooser.delegate = self
                
                self.presentViewController(imageChooser, animated: true, completion: nil)
            }
            
            actionSheet.addAction(action)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            var action = UIAlertAction(title: "Tomar foto", style: .Default) {
                action in
                
                var imagePicker = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                //imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                imagePicker.mediaTypes = [kUTTypeImage]
                imagePicker.delegate = self
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
            actionSheet.addAction(action)
        }
        
        // cancel action
        var cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Destructive, handler: nil)
        
        actionSheet.addAction(cancelAction)
        
        actionSheet.popoverPresentationController?.sourceRect = takePictureButton.bounds
        actionSheet.popoverPresentationController?.sourceView = takePictureButton
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
    }

    
    struct StoryboardSegue {
        static let Setup = "SetupImage"
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.image = image
        
        dismissViewControllerAnimated(true){
            [unowned self] in
           // self.performSegueWithIdentifier(StoryboardSegue.Setup, sender: self)
            self.performSegueWithIdentifier("DetailPhoto", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case StoryboardSegue.Setup:
            var setupViewController = segue.destinationViewController as! SetupViewController
            setupViewController.image = image
        case "DetailPhoto":
            var detailphotoViewController = segue.destinationViewController as! DetailPhotoViewController
            detailphotoViewController.photoTaken = image
        default:
            println("Unsuported segue indentifier: \(segue.identifier)")
        }
    }
    
    @IBAction func cancelSetup(segue:UIStoryboardSegue) {
        println("Setup canceled")
    }
    
    @IBAction func acceptSetup(segue:UIStoryboardSegue) {
        println("Setup finished")
        resultLabel.text = "La imagen ha sido enviada"
        takePictureButton.setTitle("Tomar otra foto", forState: .Normal)
        
        
        println("Dots where placed on coordinates:")
        println("- \(bluePosition)")
        println("- \(redPosition)")
        
        
    }

}

