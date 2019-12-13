//

//

struct ViewControllerIdentifiers {
    
    static let LoginVC                                  = "LoginVC"
    static let ForgotPasswordVc                         = "ForgotPasswordVc"
    static let CompleateProfile                         = "CompleateProfile"
    static let ChooseSportsVC                           = "ChooseSportsVC"
    static let ServiceVC                                = "ServiceVC"
    static let DashboardVC                              = "DashboardVC"
    static let SelectServiceVC                          = "SelectServiceVC"
    static let SpacesVC                                 = "SpacesVC"
    static let BookingVC                                = "BookingVC"
    static let CardPaymentVC                            = "CardPaymentVC"
    static let CreateTrainingVC                         = "CreateTrainingVC"
    static let CreateEventVC                            = "CreateEventVC"
    static let LocationOnMapVC                          = "LocationOnMapVC"
}

import UIKit
enum ViewControllerType {
    case LoginVC
    case ForgotPasswordVc
    case CompleateProfile
    case ChooseSportsVC
    case ServiceVC
    case DashboardVC
    case SelectServiceVC
    case SpacesVC
    case BookingVC
    case CardPaymentVC
    case CreateTrainingVC
    case CreateEventVC
    case LocationOnMapVC
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType: ViewControllerType) -> UIViewController {
        var viewController: UIViewController?
        let storyboard = UIStoryboard(name: "Coach", bundle: nil)
        
        if viewControllerType == .LoginVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.LoginVC) as! LoginVC
        } else if viewControllerType == .ForgotPasswordVc {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ForgotPasswordVc) as! ForgotPasswordVc
        } else if viewControllerType == .CompleateProfile {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.CompleateProfile) as! CompleateProfile
        } else if viewControllerType == .ChooseSportsVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ChooseSportsVC) as! ChooseSportsVC
        } else if viewControllerType == .ServiceVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ServiceVC) as! ServiceVC
        } else if viewControllerType == .SelectServiceVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SelectServiceVC) as! SelectServiceVC
        }else if viewControllerType == .DashboardVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.DashboardVC) as! DashboardVC
        }else if viewControllerType == .SpacesVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SpacesVC) as! SpacesVC
        }else if viewControllerType == .BookingVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.BookingVC) as! BookingVC
        }else if viewControllerType == .CardPaymentVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.CardPaymentVC) as! CardPaymentVC
        }else if viewControllerType == .CreateTrainingVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.CreateTrainingVC) as! CreateTrainingVC
        }else if viewControllerType == .CreateEventVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.CreateEventVC) as! CreateEventVC
        }else if viewControllerType == .LocationOnMapVC {
            viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.LocationOnMapVC) as! LocationOnMapVC
        }else {
            print("Unknown view controller type")
        }
        
        if let vc = viewController {
            return vc
        } else {
            return UIViewController()
        }
    }
}
