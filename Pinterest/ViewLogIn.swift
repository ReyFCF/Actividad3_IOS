import Foundation

import UIKit
import Firebase
import SwiftyGif

class ViewLogIn: UIViewController {
    private var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(logoContainerView)
        
        logoContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        logoContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        logoContainerView.addSubview(background)
        
        background.leftAnchor.constraint(equalTo: logoContainerView.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: logoContainerView.rightAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: logoContainerView.widthAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor, constant: -30).isActive = true
        
        gradient = CAGradientLayer()
        gradient.frame = background.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0, 0.4, 1]
        background.layer.mask = gradient

        tittle.widthAnchor.constraint(equalTo: logoContainerView.widthAnchor).isActive = true

        //add subview
        view.addSubview(buttonsContainerView)
        
        buttonsContainerView.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: -15 ).isActive = true
        buttonsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //buttonsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        buttonsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        buttonsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        buttonsContainerView.addSubview(emailButton)
        
        emailButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 10).isActive = true
        emailButton.widthAnchor.constraint(equalTo: buttonsContainerView.widthAnchor).isActive = true
        emailButton.heightAnchor.constraint(equalTo: buttonsContainerView.heightAnchor, multiplier: 1/7).isActive = true
        
        buttonsContainerView.addSubview(fbButton)
        
        fbButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 7).isActive = true
        fbButton.widthAnchor.constraint(equalTo: buttonsContainerView.widthAnchor).isActive = true
        fbButton.heightAnchor.constraint(equalTo: buttonsContainerView.heightAnchor, multiplier: 1/7).isActive = true
        
        buttonsContainerView.addSubview(googleButton)
        
        googleButton.topAnchor.constraint(equalTo: fbButton.bottomAnchor, constant: 7).isActive = true
        googleButton.widthAnchor.constraint(equalTo: buttonsContainerView.widthAnchor).isActive = true
        googleButton.heightAnchor.constraint(equalTo: buttonsContainerView.heightAnchor, multiplier: 1/7).isActive = true
        
        buttonsContainerView.addSubview(loginButton)
        
        loginButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 35).isActive = true
        loginButton.widthAnchor.constraint(equalTo: buttonsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: buttonsContainerView.heightAnchor, multiplier: 1/7).isActive = true
    
        buttonsContainerView.addSubview(terms)
        
        terms.topAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: -80).isActive = true
        terms.widthAnchor.constraint(equalTo: buttonsContainerView.widthAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradient.frame = background.bounds
    }
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Correo Electrónico"
        tf.backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Contraseña"
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nombre"
        tf.backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let buttonsContainerView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let logoContainerView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailButton : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(r: 201, g: 34, b: 40)
        ub.setTitle("Continuar con el correo electrónico", for: .normal)
        ub.titleLabel?.font =  UIFont(name: "GillSans-SemiBold", size: 18)
        ub.layer.cornerRadius = 20
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButtonEmail), for: .touchUpInside)
        return ub
    }()
    
    let fbButton : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(r: 60, g: 88, b: 153)
        ub.setTitle("Continuar con Facebook", for: .normal)
        ub.titleLabel?.font =  UIFont(name: "GillSans-SemiBold", size: 18)
        ub.layer.cornerRadius = 20
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return ub
    }()
    
    let googleButton : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(r: 66, g: 113, b: 246)
        ub.setTitle("Continuar con Google", for: .normal)
        ub.titleLabel?.font =  UIFont(name: "GillSans-SemiBold", size: 18)
        ub.layer.cornerRadius = 20
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return ub
    }()
    
    let loginButton : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(r: 240, g: 238, b: 241)
        ub.setTitle("Iniciar Sesión", for: .normal)
        //ub.titleLabel?.font =  UIFont(name: "GillSans-SemiBold", size: 18)
        ub.setTitleColor(.black, for: .normal)
        ub.layer.cornerRadius = 20
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButtonSignIn), for: .touchUpInside)
        return ub
    }()
    
    let background : UIImageView = {
        let imageName = "background"
        let image = UIImage(named: imageName)
        let iv = UIImageView(image: image!)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let tittle : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.text = "TBienvenido a Pinterest"
        lb.font =  UIFont(name: "GillSans-SemiBold", size: 28)
        lb.numberOfLines = 2;
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let terms : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.text = "Estas aceptando las politicas de privacidad"
        lb.numberOfLines = 2;
        lb.font =  UIFont(name: "GillSans", size: 15.5)
        lb.font = lb.font.withSize(13.3)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    @objc func handleButton(){
        if let email = emailTextField.text, let pass = passwordTextField.text, let name = nameTextField.text{
            print(email)
            print(pass)
            Auth.auth().createUser(withEmail: email, password: pass) { (data:AuthDataResult?, error) in
                let user = data?.user
                if error != nil {
                    print(error.debugDescription)
                }
                
                let ref = Database.database().reference(fromURL: "https://pinterest-tecmi.firebaseio.com/")
                
                if let uid = user?.uid{
                    
                    let usersRef = ref.child("users").child(uid)
                    usersRef.updateChildValues(["name" : name, "email" : email, "password": pass])
                    let msgsRef = ref.child("message").child(uid)
                    msgsRef.updateChildValues(["message" : "Prueba"])
                    ref.child("message").child(uid).removeValue()
                    
                }
            }
        }
    }
    
    @objc func handleButtonEmail(){
        let email = ViewEmail()
        email.register = .email
        self.navigationController?.pushViewController(email, animated: true)
    }
    
    @objc func handleButtonSignIn(){
        let signin = ViewController()
        self.navigationController?.pushViewController(signin, animated: true)
    }
    
}

    extension UIColor {
        convenience init(r:CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/300, green: g/320, blue: b/230, alpha: 1)
    }
}
