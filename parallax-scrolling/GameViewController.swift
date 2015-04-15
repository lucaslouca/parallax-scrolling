//
//  GameViewController.swift
//  parallax-scrolling
//
//  Created by Lucas Louca on 12/04/15.
//  Copyright (c) 2015 Lucas Louca. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewDidLoad()

            // Configure the view.
            let skView = self.view as! SKView
            
            skView.ignoresSiblingOrder = true
            
            // Create GameScene
            let scene = GameScene(size: skView.bounds.size, scrollingDirection: ParallaxScrolling.ScrollingDirection.Left)
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
