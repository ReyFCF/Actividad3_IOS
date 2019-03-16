
import UIKit
import SwiftyGif

class Splash: UIViewController {
    
    let logoAnimationView = ViewLogo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self as? SwiftyGifDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
}

extension Splash: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        let login = ViewLogIn()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.setRootViewController(login)
    }
}
