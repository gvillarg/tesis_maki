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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImageButtonPressed(sender: UIButton) {
        
        var imagePicker = UIImagePickerController()
        //imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePicker.mediaTypes = [kUTTypeImage]
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
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
            var setupViewController = segue.destinationViewController as SetupViewController
            setupViewController.image = image
        case "DetailPhoto":
            var detailphotoViewController = segue.destinationViewController as DetailPhotoViewController
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

