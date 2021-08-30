//
//  SigninView.swift
//  GOOUT
//
//  Created by baegteun on 2021/08/30.
//

import UIKit
import Then
import SnapKit

class SigninView: UIView{
    // MARK: - Properties
    private let mainBound = UIScreen.main.bounds
    
    let emailTextField = UITextField().then{
        $0.placeholder = "이메일을 입력하세요."
    }
    lazy var emailView = loginTextFieldView(textField: emailTextField, text: "Email", fontsize: 14)
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
        $0.isSecureTextEntry = true
    }
    lazy var passwordView = loginTextFieldView(textField: passwordTextField, text: "Password", fontsize: 14)
    
    lazy var stack = UIStackView(arrangedSubviews: [emailView, passwordView]).then{
        $0.axis = .vertical
        $0.spacing = self.bounds.height*0.035
    }
    
    lazy var passwordVisibilityBtn = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.width*0.02, height: self.bounds.height*0.014)).then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = UIColor(red: 0.424, green: 0.424, blue: 0.424, alpha: 1)
        $0.addTarget(self, action: #selector(changePasswordVisibilityToggle(_:)), for: .touchUpInside)
    }
    
    let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.dynamicFont(fontSize: 8, currentFontName: "AppleSDGothicNeo-SemiBold")
        $0.setTitleColor(UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1), for: .normal)
        $0.addTarget(self, action: #selector(showFindPasswordController), for: .touchUpInside)
    }
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureShadow()
        addView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // MARK: addView
    func addView(){
        addSubview(stack)
        addSubview(passwordVisibilityBtn)
        addSubview(findPasswordButton)
    }
    
    // MARK: configureUI
    func configureUI(){
        stack.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(self.bounds.width*0.168)
            $0.right.equalTo(self.snp.right).inset(self.bounds.width*0.168)
            $0.top.equalTo(self.snp.top).offset(self.bounds.height*0.129)
        }
        
        passwordVisibilityBtn.snp.makeConstraints {
            $0.right.equalTo(passwordTextField.snp.right)
            $0.centerY.equalTo(passwordTextField)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.left.equalTo(passwordView.snp.left)
            $0.top.equalTo(passwordView.snp.bottom).offset(self.bounds.height*0.016)
        }
    }
    
    // MARK: configureShadow
    func configureShadow(){
        
        let shadows = UIView().then{
            $0.frame = self.frame
            $0.clipsToBounds = false
        }
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: mainBound.width*0.12)
        
        let layer0 = CALayer().then{
            $0.shadowPath = shadowPath0.cgPath
            $0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            $0.shadowOpacity = 1
            $0.shadowRadius = 10
            $0.shadowOffset = CGSize(width: 0, height: 4)
            $0.bounds = shadows.bounds
            $0.position = shadows.center
        }
        
        let shapes = UIView().then{
            $0.frame = self.frame
            $0.clipsToBounds = true
        }
        
        let layer1 = CALayer().then{
            $0.backgroundColor = UIColor(red: 0.954, green: 0.969, blue: 1, alpha: 1).cgColor
            $0.cornerRadius = mainBound.width*0.12
            $0.bounds = shapes.bounds
            $0.position = shapes.center
        }
        
        self.addSubview(shadows)
        shadows.layer.addSublayer(layer0)
        self.addSubview(shapes)
        shapes.layer.addSublayer(layer1)
    }
    
    // MARK: loginTextFieldViewMaker
    func loginTextFieldView(textField: UITextField, text: String, fontsize: Int) -> UIView{
        let view = UIView()
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(red: 0.408, green: 0.525, blue: 0.733, alpha: 1)
        label.dynamicFont(fontSize: CGFloat(fontsize), currentFontName: "AppleSDGothicNeo-SemiBold")
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(label.safeAreaLayoutGuide.snp.bottom).offset(9)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        let Divider = UIView()
        Divider.backgroundColor = UIColor(red: 0.408, green: 0.525, blue: 0.733, alpha: 1)
        
        view.addSubview(Divider)
        
        Divider.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            $0.height.equalTo(1)
        }
        return view
    }
    // MARK: - Actions
    
    // MARK: changePasswordVisibility
    @objc func changePasswordVisibilityToggle(_ sender: UIButton){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry{
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    // MARK: showFindPassword
    @objc func showFindPasswordController(){
        print("FINDPASS")
    }
}
