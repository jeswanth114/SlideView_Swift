//
//  HomeViewController.swift
//  SlideView_Swift
//
//  Created by Jeswanth Bonthu on 8/21/14.
//  Copyright (c) 2014 Jeswanth Bonthu. All rights reserved.
//


import UIKit

public protocol HomeViewControllerDelegate{
    func movePanelRight()
    func movePanelToOriginalPosition()
}


public class HomeViewController: UIViewController {
    
    @IBOutlet public var  leftButton : UIButton! = UIButton();
    public var delegate : HomeViewControllerDelegate? = nil;
    
    
   public  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   @IBAction public func slideOut(sender : AnyObject)
   {
    var button:UIButton = sender as UIButton;

    switch (button.tag) {
    case 0:
        delegate?.movePanelToOriginalPosition();
        break;
        
    case 1:
        delegate?.movePanelRight();
        break;
    default:
        break;
    }
  }
}