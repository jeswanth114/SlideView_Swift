//
//  ViewController.swift
//  SlideView_Swift
//
//  Created by Jeswanth Bonthu on 8/21/14.
//  Copyright (c) 2014 Jeswanth Bonthu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,HomeViewControllerDelegate{
    
    let CENTER_TAG : Int = 1
    let LEFT_PANEL_TAG : Int  = 2
    let RIGHT_PANEL_TAG : Int =  3
    let CORNER_RADIUS : CGFloat = 4
    let SLIDE_TIMING : NSTimeInterval = 0.25
    let PANEL_WIDTH : CGFloat =  60
    
    var homeViewController : HomeViewController = HomeViewController()
    var leftPanelViewController :LeftPanelViewController = LeftPanelViewController()
    var showingLeftPanel : Bool!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView()
    {
    self.homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeViewControllerID") as HomeViewController
    
    self.homeViewController.view.tag = CENTER_TAG;
    self.homeViewController.delegate = self;
    self.view.addSubview(self.homeViewController.view);
    self.addChildViewController(self.homeViewController);
    self.homeViewController.leftButton.tag = 1;
    self.homeViewController.didMoveToParentViewController(self);
    
    //[self setupGestures];
    }
    
    func showCenterViewWithShadow(value:Bool, Offset:CGFloat) {
    if (value) {
    self.homeViewController.view.layer.cornerRadius = CORNER_RADIUS;
   // self.homeViewController.view.layer.shadowColor = CgC
    self.homeViewController.view.layer.shadowOpacity = 0.8
    self.homeViewController.view.layer.shadowOffset = CGSizeMake(Offset, Offset);
    
    } else {
    self.homeViewController.view.layer.cornerRadius = 0.0;
    self.homeViewController.view.layer.shadowOffset = CGSizeMake(Offset, Offset);
    }
    }
    
    func resetMainView(){
    // remove left and right views, and reset variables, if needed
   
   // if (self.leftPanelViewController != nil) {
    self.leftPanelViewController.view.removeFromSuperview();
   // self.leftPanelViewController = nil;
    self.homeViewController.leftButton.tag = 1;
    self.showingLeftPanel = false;
  //  }
    // remove view shadows
    self.showCenterViewWithShadow(false, Offset:0);
    }
    
    func getLeftView () -> UIView {
    // init view if it doesn't already exist
    if (self.leftPanelViewController == nil)
    {
    // this is leftPanelViewController you define the view for the left panel
  
    self.leftPanelViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftPanelViewControllerID") as LeftPanelViewController
     
    
    self.leftPanelViewController.view.tag = LEFT_PANEL_TAG;
    //self.leftPanelViewController.delegate = _centerViewController;
    
    self.view.addSubview(self.leftPanelViewController.view);
    self.addChildViewController(self.leftPanelViewController);
    self.leftPanelViewController.didMoveToParentViewController(self)
    
    self.leftPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeftPanel = true;
    
    // setup view shadows
    self.showCenterViewWithShadow(true, Offset: -2);
    
    var view :UIView = self.leftPanelViewController.view;
    return view;
    }
    
    
    //MARK: newsFeedVeieController Delegate Methods
    
    func movePanelRight()
    {
    var childView : UIView = self.getLeftView()
    self.view.sendSubviewToBack(childView)
    
    UIView.animateWithDuration(SLIDE_TIMING, delay:0, options:UIViewAnimationOptions(), animations: {() -> Void in
        
        self.homeViewController.view.frame = CGRectMake(self.view.frame.size.width - self.PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        }) { (finished:Bool) -> Void in
        
          if (finished) {
            self.homeViewController.leftButton.tag = 0;
            }

        }
    }
    
    func movePanelToOriginalPosition()
    {
        
    UIView.animateWithDuration(SLIDE_TIMING, delay: 0, options:UIViewAnimationOptions(), animations: {() -> Void in
            
       self.homeViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            }) { (finished:Bool) -> Void in
                
                if (finished) {
                    self.resetMainView()
                }
                
        }

    
    }
    


}

