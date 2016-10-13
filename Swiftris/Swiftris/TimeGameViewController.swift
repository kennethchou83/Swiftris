//
//  TimeGameViewController.swift
//  Swiftris
//
//  Created by Kenneth Chou on 9/30/16.
//  Copyright © 2016 Kenneth Chou. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class TimeGameViewController: GameViewController, GKGameCenterControllerDelegate {
    var score:Int = 0;
    
    @IBOutlet weak var countDownLabel: UILabel!
    var count : UInt = 0
    var gameTimer : NSTimer?
    var gameEndTimer : NSTimer?
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
    }
    
    override func gameDidBegin(swiftris: Swiftris) {
        super.gameDidBegin(swiftris)
        restartTimer()
    }
    
    func restartTimer() {
        if let gt = gameTimer {
            gt.invalidate()
        }
        if let gt = gameEndTimer {
            gt.invalidate()
        }
        count = 120
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TimeGameViewController.update), userInfo: nil, repeats: true)
//        gameEndTimer = NSTimer.scheduledTimerWithTimeInterval(Double(count), target: self, selector: #selector(gameDidEnd), userInfo: nil, repeats: false)
    }
    
    override func gameDidEnd(swiftris: Swiftris) {
        NSLog("game ending")
        super.gameDidEnd(swiftris)
    }
    
    @IBAction func showLeaderButton(sender: UIButton) {
        showleader()
    }
    
    func showleader(){
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        gcvc.viewState = GKGameCenterViewControllerState.Leaderboards
        gcvc.leaderboardTimeScope = GKLeaderboardTimeScope.AllTime
        gcvc.leaderboardIdentifier = "Kennethchou83.swiftris"
        self.presentViewController(gcvc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController:GKGameCenterViewController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if ((viewController) != nil) {
                self.presentViewController(viewController!, animated: true, completion: nil)
            }else{
                print("(GameCenter) Player authenticated: \(GKLocalPlayer.localPlayer().authenticated)")
            }
        }
    }
    /*
    func updateCounter() {
        //you code, this is an example
        if count > 0 {
            print("\(count) seconds to the end of the world")
            count -= 1
        }
    }
 */
    
    func update() {
        if(count > 0) {
            count = count - 1
            countDownLabel.text = String(count)
        }
    }
    
    @IBAction func homeButton(sender: UIButton) {
    }
    
//    override func gameDidEnd() {
//    
//        super.gameDidEnd()
//        
//        
//    }
    
    override func didTick() {
        super.didTick()
        updateTimeLabel()
    }
    
    func updateTimeLabel() {
        // set the timelabel text to
        // the proper amount of time remaining
        // (start time + 120) - current time = # seconds left
        // divide that by 60 for # of minutes
        // % by 60 for # of seconds (to get remainder)
    }

}