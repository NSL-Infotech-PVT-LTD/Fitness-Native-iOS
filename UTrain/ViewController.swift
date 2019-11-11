//
//  ViewController.swift
//  UTrain
//
//  Created by osx on 24/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    enum trainingType:Int {
        case athlete = 0
        case coach   = 1
        case organisation = 2
    }
    
    //MARK:- Outlets and Variables
    var currentTraining = trainingType.athlete
    var isHighlight = false
    
    @IBOutlet weak var containerView: UIView?
    
    @IBOutlet weak var athleteView: UIView?
    @IBOutlet weak var coachView: UIView?
    @IBOutlet weak var organizationView: UIView?
    
    @IBOutlet weak var loginBtnView: UIView?
    @IBOutlet weak var athleteBtn: UIButton?
    @IBOutlet weak var loginSignLabel: UILabel?
    
    @IBOutlet weak var athleteImage: UIImageView?
    @IBOutlet weak var athleteInnerImage: UIImageView?
    @IBOutlet weak var athleteLabel: UILabel?
    
    @IBOutlet weak var coachImage: UIImageView?
    @IBOutlet weak var coachInnerImage: UIImageView?
    @IBOutlet weak var coachLabel: UILabel?
    
    @IBOutlet weak var orgImage: UIImageView?
    @IBOutlet weak var orgInnerImage: UIImageView?
    @IBOutlet weak var orgLabel: UILabel?
    let customFont = UIFont(name: "Poppins-Medium.ttf", size: 17)
    
    var athleteVC : AthleteLoginViewController? = AthleteLoginViewController.instance()
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        theme()
        resetView()
        paintAthlete()
    }
    
    class func instance()-> ViewController?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        return controller
    }

    
    func resetView(){
        
        athleteImage?.isHidden = true
        coachImage?.isHidden = true
        orgImage?.isHidden = true
        
        athleteInnerImage?.image = UIImage(named: "Athlete_black")
        athleteLabel?.textColor = UIColor.black
        athleteLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        coachInnerImage?.image = UIImage(named: "coach_black")
        coachLabel?.textColor = UIColor.black
        coachLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        orgInnerImage?.image = UIImage(named: "org_black")
        orgLabel?.textColor = UIColor.black
        orgLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        
    }
    
    func theme(){
        //containerView?.backgroundColor = backGroundColor
        containerView?.layer.cornerRadius = 10
        containerView?.clipsToBounds = true
        containerView?.layer.shadowColor = UIColor.gray.cgColor
        containerView?.layer.shadowOpacity = 1
    
        athleteView?.layer.cornerRadius = 10
        athleteView?.clipsToBounds = true
        athleteView?.layer.shadowColor = UIColor.gray.cgColor
        athleteView?.layer.shadowOpacity = 1
        athleteView?.layer.shadowOffset = .zero
        athleteView?.layer.shadowRadius = 10
        athleteView?.layer.borderColor = UIColor.green.cgColor
        athleteView?.layer.borderWidth = 1.5
        
        coachView?.layer.cornerRadius = 10
        coachView?.clipsToBounds = true
        coachView?.layer.shadowColor = UIColor.gray.cgColor
        coachView?.layer.shadowOpacity = 1
        coachView?.layer.borderColor = UIColor.green.cgColor
        coachView?.layer.borderWidth = 1.5
        
        organizationView?.layer.cornerRadius = 10
        organizationView?.clipsToBounds = true
        organizationView?.layer.shadowColor = UIColor.gray.cgColor
        organizationView?.layer.shadowOpacity = 1
        organizationView?.layer.borderColor = UIColor.green.cgColor
        organizationView?.layer.borderWidth = 1.5
        
        loginBtnView?.layer.cornerRadius = 10
        loginBtnView?.clipsToBounds = true
    }
    
    @IBAction func athleteActionBtn(_ sender: Any) {
    
        resetView()
        paintAthlete()
    }
    
    @IBAction func coachActionBtn(_ sender: Any) {
        
        resetView()
        paintCoach()
    }
    
    @IBAction func orgActionBtn(_ sender: Any) {
        
        resetView()
        paintOrganisation()
    }
    
    func paintAthlete(){
        
        athleteImage?.image = UIImage(named: "mask_athlete")
        athleteImage?.isHidden = false
        athleteInnerImage?.image = UIImage(named: "Athlete_white")
        athleteLabel?.textColor = UIColor.white
        athleteLabel?.font = customFont

        loginSignLabel?.text = "Log in/ Signup Athlete"
        loginSignLabel?.font = customFont
        currentTraining = .athlete
    
    }
    
    func paintCoach(){
        
        coachImage?.image = UIImage(named: "mask_coach")
        coachInnerImage?.image = UIImage(named: "coach_white")
        coachImage?.isHidden = false
        coachLabel?.textColor = UIColor.white
        loginSignLabel?.text = "Log in/ Signup Coach"
        coachLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        currentTraining = .coach
        
    }
    
    func paintOrganisation(){
        
        orgImage?.image = UIImage(named: "mask_org")
        orgImage?.isHidden = false
        orgInnerImage?.image = UIImage(named: "org_white")
        orgLabel?.textColor = UIColor.white
        orgLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        loginSignLabel?.text = "Log in/ Signup Organisation"
        currentTraining = .organisation

    }


    @IBAction func loginActionBtn(_ sender: Any) {
        
        if currentTraining  == .athlete{
            
            guard let controller = AthleteLoginViewController.instance()else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        if currentTraining  == .coach{
            
            guard let controller = CoachLoginViewController.instance()else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        if currentTraining  == .organisation{
            
            guard let controller = OrgLoginViewController.instance()else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }

  }
    
    
}
