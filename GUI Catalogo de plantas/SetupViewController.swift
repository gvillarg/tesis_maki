
//
//  SetupViewController.swift
//  Camera Demo
//
//  Created by Gustavo Villar on 4/22/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    var image: UIImage!

    @IBOutlet weak var blueDot: Dot!
    @IBOutlet weak var redDot: Dot!
    @IBOutlet weak var greenDot: Dot!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageRatioContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
        let ratio = image.size.width / image.size.height
        var imageRatioContraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Height, multiplier: ratio, constant: 0)
        imageView.addConstraint(imageRatioContraint)
        imageView.setNeedsLayout()
        
        //blueDot.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dotDragged:"))
        //redDot.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dotDragged:"))
        //greenDot.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dotDragged:"))
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // Set dots position
        //blueDot.center = CGPointMake(view.center.x - 20, view.center.y)
        //redDot.center = CGPointMake(view.center.x + 20, view.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dotDragged(recognizer: UIPanGestureRecognizer) {
        
        var dot = recognizer.view as! Dot
        
        switch recognizer.state {
        case UIGestureRecognizerState.Changed:
            dot.center = recognizer.locationInView(view)
        default: break
        }

    }
    

    
    // MARK: - Navigation
    
    struct StoryboardSegue {
        static let AcceptSetup = "AcceptSetup"
        static let CancelSetup = "CancelSetup"
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case StoryboardSegue.CancelSetup:
            var viewController = segue.destinationViewController as! PhotoViewController
            viewController.image = nil
            //viewController.bluePosition = nil
            //viewController.redPosition = nil
        case StoryboardSegue.AcceptSetup:
            var viewController = segue.destinationViewController as! PhotoViewController
            //viewController.bluePosition = view.convertPoint(blueDot.center, toView: imageView)
            //viewController.redPosition = view.convertPoint(redDot.center, toView: imageView)
        default: break
        }
    }
    

}


