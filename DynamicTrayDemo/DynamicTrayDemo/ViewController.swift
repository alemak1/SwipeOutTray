//
//  ViewController.swift
//  DynamicTrayDemo
//
//  Created by Aleksander Makedonski on 1/30/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var trayView: UIVisualEffectView = UIVisualEffectView()
    var trayLeftEdgeConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var animator: UIDynamicAnimator = UIDynamicAnimator()
    var gravityBehavior: UIGravityBehavior = UIGravityBehavior()
    var gravityIsLeft: Bool = false
    
    let GUTTER_WIDTH: CGFloat = 100.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageView = UIImageView(image: UIImage(named: "mabel.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            ])
        
        setupTrayView()
        setupGestureRecognizers()
        animator = UIDynamicAnimator(referenceView: self.view)
        setupBehaviors()
    }
    
    
    func setupBehaviors(){
        let edgeCollisionBehavior = UICollisionBehavior(items: [trayView])
        edgeCollisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsetsMake(0, GUTTER_WIDTH, 0, -self.view.bounds.size.width))
        animator.addBehavior(edgeCollisionBehavior)
        
        gravityBehavior = UIGravityBehavior(items: [trayView])
        animator.addBehavior(gravityBehavior)
        updateGravityIsLeft(isLeft: gravityIsLeft)
        
    }
    
    func updateGravityIsLeft(isLeft: Bool){
        let angle = isLeft ? M_PI: 0.00
        gravityBehavior.setAngle(CGFloat(angle), magnitude: 1.0)
        
        
    }
    
    func setupGestureRecognizers(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(pan))
        edgePan.edges = UIRectEdge.right
        view.addGestureRecognizer(edgePan)
        
        let trayPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        trayView.addGestureRecognizer(trayPanGestureRecognizer)
        
    }
    
    func pan(){
        
    }

    func setupTrayView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        trayView = UIVisualEffectView(effect: blurEffect)
        trayView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trayView)

        NSLayoutConstraint.activate([
            trayView.widthAnchor.constraint(equalTo: view.widthAnchor),
            trayView.heightAnchor.constraint(equalTo: view.heightAnchor),
            trayView.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        

        
        trayLeftEdgeConstraint = NSLayoutConstraint(item: trayView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: view.frame.size.width)
        
        trayLeftEdgeConstraint.isActive = true
        
        let trayLabel = UILabel()
        trayLabel.text = "Good morning, \n Sunshine \n, Maybel the Frenchie"
        trayLabel.numberOfLines = 0
        trayLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        trayLabel.translatesAutoresizingMaskIntoConstraints = false
        trayView.addSubview(trayLabel)
        
        NSLayoutConstraint.activate([
            trayLabel.leftAnchor.constraint(equalTo: trayView.leftAnchor, constant: 30),
            trayLabel.rightAnchor.constraint(equalTo: trayView.rightAnchor, constant: 30),
            trayLabel.topAnchor.constraint(equalTo: trayView.topAnchor, constant: 100),
            trayLabel.bottomAnchor.constraint(equalTo: trayView.bottomAnchor, constant: 100)
            ])
        
        view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

