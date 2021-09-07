//
//  NoSwipeSegmentedControl.swift
//  Valorant
//
//  Created by Jorge Suarez Calafat on 30/8/21.
//

import UIKit

class NoSwipeSegmentedControl: UISegmentedControl {

    
        override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if(gestureRecognizer.isKind(of: UITapGestureRecognizer.self)){
                return false
            }else{
                return true
            }
        }
    }


