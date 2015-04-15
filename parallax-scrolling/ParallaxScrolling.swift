//
//  ParallaxScrolling.swift
//  parallax-scrolling
//
//  Created by Lucas Louca on 12/04/15.
//  Copyright (c) 2015 Lucas Louca. All rights reserved.
//

import UIKit
import SpriteKit

class ParallaxScrolling: SKSpriteNode {
    let antiFlickering:CGFloat = 0.05
    var backgrounds:[SKSpriteNode]
    var clonedBackgrounds:[SKSpriteNode]
    var speeds:[CGFloat]
    let numberOfBackgrounds:Int
    let scrollingDirection:ScrollingDirection
    
    enum ScrollingDirection {
        case Left
        case Right
    }
    
    init?(backgroundImages:[UIImage], size:CGSize, scrollingDirection:ScrollingDirection, fastestSpeed:CGFloat, speedDecrease:CGFloat) {
        self.backgrounds = []
        self.clonedBackgrounds = []
        self.speeds = []
        self.numberOfBackgrounds = backgroundImages.count
        self.scrollingDirection = scrollingDirection
        super.init(texture: nil, color:UIColor.clearColor(), size: size)
        
        let zPos = 1.0 / CGFloat(numberOfBackgrounds)
        var currentSpeed = fastestSpeed
        self.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.zPosition = -100
    
        for (index, image) in enumerate(backgroundImages) {
            let node = SKSpriteNode(texture: SKTexture(CGImage: image.CGImage), size:size)

            node.zPosition = self.zPosition - (zPos + (zPos * CGFloat(index)))
            node.position = CGPointMake(0, 0)
            let clonedNode = node.copy() as! SKSpriteNode
            var clonedPosX = node.position.x
            var clonedPosY = node.position.y
            
            switch (scrollingDirection) {
            case .Right:
                clonedPosX = -node.size.width
            case .Left:
                clonedPosX = node.size.width
            default:
                break
            }

            clonedNode.position = CGPointMake(clonedPosX, clonedPosY);

            backgrounds.append(node)
            clonedBackgrounds.append(clonedNode)
            speeds.append(currentSpeed)
            
            currentSpeed = currentSpeed / (1 + speedDecrease)
            
            self.addChild(node)
            self.addChild(clonedNode)
        }
    }
    
    func update(currentTime:NSTimeInterval) {
        for i in 0..<numberOfBackgrounds{
            // determine the speed of each node
            var speed = self.speeds[i]
    
            // adjust positions
            var bg = self.backgrounds[i]
            var cBg = self.clonedBackgrounds[i]
        
            var newBgX = bg.position.x
            var newBgY = bg.position.y
            var newCbgX = cBg.position.x
            var newCbgY = cBg.position.y
            
            // position depends on direction.
            switch (self.scrollingDirection) {
            case .Right:
                newBgX += speed
                newCbgX += speed
                if (newBgX >= bg.size.width) {
                    newBgX = newBgX - 2 * bg.size.width + antiFlickering
                }
                if (newCbgX >= cBg.size.width) {
                    newCbgX = newCbgX - 2 * cBg.size.width + antiFlickering
                }
            case .Left:
                newBgX -= speed
                newCbgX -= speed

                if (newBgX <= -self.size.width) {
                    newBgX = newBgX + 2 * self.size.width - antiFlickering
                }
                if (newCbgX <= -self.size.width) {
                    newCbgX = newCbgX + 2 * self.size.width - antiFlickering
                }
            default:
                break
            }
    
            // update positions with the right coordinates.
            bg.position = CGPointMake(newBgX, newBgY)
            cBg.position = CGPointMake(newCbgX, newCbgY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
