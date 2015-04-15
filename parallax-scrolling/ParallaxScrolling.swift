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
    
    /**
    Initialize the parralax node.
    
    :param: backgroundImages [UIImage] of images (one image per layer). The order of the images in the array will also be the order the layers are added to the parallax node (from nearest to furthest)
    :param: startingSpeed CGFloat indicating the speed of the nearest layer
    :param: speedDecreaseFactor CGFloat indicating the speed decrease factor
    */
    init?(backgroundImages:[UIImage], size:CGSize, scrollingDirection:ScrollingDirection, startingSpeed:CGFloat, speedDecreaseFactor:CGFloat) {
        self.backgrounds = []
        self.clonedBackgrounds = []
        self.speeds = []
        self.numberOfBackgrounds = backgroundImages.count
        self.scrollingDirection = scrollingDirection
        super.init(texture: nil, color:UIColor.clearColor(), size: size)
        
        let zPos = 1.0 / CGFloat(numberOfBackgrounds)
        var currentSpeed = startingSpeed
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
            
            currentSpeed = currentSpeed / speedDecreaseFactor
            
            self.addChild(node)
            self.addChild(clonedNode)
        }
    }
    
    /**
    Change the position of the backgrounds based on the scrolling direction.
    */
    func update() {
        for i in 0..<numberOfBackgrounds{
            var speed = self.speeds[i]

            var background = self.backgrounds[i]
            var clonedBackground = self.clonedBackgrounds[i]
        
            var adjustedBackgroundX = background.position.x
            var adjustedBackgroundY = background.position.y
            var adjustedClonedBackgroundX = clonedBackground.position.x
            var adjustedClonedBackgroundY = clonedBackground.position.y
            
            switch (self.scrollingDirection) {
            case .Right:
                adjustedBackgroundX += speed
                adjustedClonedBackgroundX += speed
                if (adjustedBackgroundX >= background.size.width) {
                    adjustedBackgroundX = adjustedBackgroundX - 2 * background.size.width + antiFlickering
                }
                if (adjustedClonedBackgroundX >= clonedBackground.size.width) {
                    adjustedClonedBackgroundX = adjustedClonedBackgroundX - 2 * clonedBackground.size.width + antiFlickering
                }
            case .Left:
                adjustedBackgroundX -= speed
                adjustedClonedBackgroundX -= speed

                if (adjustedBackgroundX <= -self.size.width) {
                    adjustedBackgroundX = adjustedBackgroundX + 2 * self.size.width - antiFlickering
                }
                if (adjustedClonedBackgroundX <= -self.size.width) {
                    adjustedClonedBackgroundX = adjustedClonedBackgroundX + 2 * self.size.width - antiFlickering
                }
            default:
                break
            }
    
            // update positions with the right coordinates.
            background.position = CGPointMake(adjustedBackgroundX, adjustedBackgroundY)
            clonedBackground.position = CGPointMake(adjustedClonedBackgroundX, adjustedClonedBackgroundY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
