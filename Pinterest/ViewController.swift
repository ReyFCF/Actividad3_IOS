import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Iniciar Sesión"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Volver"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = .red
        view.addSubview(inputContainerView)
        view.addSubview(logo)
        
        
        view.addSubview(firstButton)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        logo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        logo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        logo.heightAnchor.constraint(equalTo: logo.widthAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -20).isActive = true
        
        firstButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 20).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstButton.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        firstButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Correo"
        tf.backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 22))
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
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 22))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let inputContainerView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let firstButton : UIButton = {
        let ub = UIButton()
        ub.backgroundColor = UIColor(r: 201, g: 34, b: 40)
        ub.setTitle("Iniciar Sesión", for: .normal)
        ub.titleLabel?.font =  UIFont(name: "GillSans-SemiBold", size: 21)
        ub.layer.cornerRadius = 27
        ub.translatesAutoresizingMaskIntoConstraints = false
        ub.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return ub
    }()
    
    let logo : UIImageView = {
        let imageName = "pinterest"
        let image = UIImage(named: imageName)
        let iv = UIImageView(image: image!)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func handleButton(){
        if let email = emailTextField.text, let pass = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: pass) { (data:AuthDataResult?, error) in
                let user = data?.user
                if error != nil {
                }
                let ref = Database.database().reference(fromURL: "pinterest-177a6.firebaseapp.com")
                
                if let uid = user?.uid{
                    let usersRef = ref.child("users").child(uid)
                    usersRef.updateChildValues(["email" : email, "password": pass])
                    let msgsRef = ref.child("message").child(uid)
                    msgsRef.updateChildValues(["message" : "Prueba"])
                    ref.child("message").child(uid).removeValue()
                    
                }
                self.navigationController?.pushViewController(ViewCollection(collectionViewLayout: Layout()), animated: true)
            }
        }
    }
}
