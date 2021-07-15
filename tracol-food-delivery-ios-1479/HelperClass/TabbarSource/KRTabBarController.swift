/**
*
*@copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
*@author     : Shiv Charan Panjeta < shiv@toxsl.com >
*
* All Rights Reserved.
* Proprietary and confidential :  All information contained herein is, and remains
* the property of ToXSL Technologies Pvt. Ltd. and its partners.
* Unauthorized copying of this file, via any medium is strictly prohibited.
*/

import UIKit

protocol PassIndex {
    func passIndex(index: Int)
}
var objPassIndexDelegate:PassIndex?
@available(iOS 9.0, *)
class KRTabBarController: UITabBarController, UITabBarControllerDelegate,PassIndex {
    
    
    
     var selectedTab: Int = 0
    
    private var buttons = [UIButton]()
    private var buttonsColors = [UIColor]()
    
    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.2732129395, green: 0.6568266749, blue: 0.4387068152, alpha: 1)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indexView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowOpacity = 0
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objPassIndexDelegate = self
        tabBar.isHidden = true
        addCustomTabBarView()
        createButtonsStack(viewControllers!)
        autolayout()
        if self.title == "cart" {
            DispatchQueue.main.async {
                self.selectedIndex = 2
                self.didSelectIndex(sender: self.buttons[self.selectedIndex])
            }
        }else  if self.title == "wish" {
            DispatchQueue.main.async {
                self.selectedIndex = 1
                self.didSelectIndex(sender: self.buttons[self.selectedIndex])
                
            }
        }
        
    }
    func passIndex(index: Int) {
         didSelectIndex(sender: self.buttons[index])
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.layer.cornerRadius = customTabBarView.frame.size.height / 2
        indexView.layer.cornerRadius = indexView.frame.size.height / 2
        if selectedTab == 0 {
            indexView.backgroundColor = .white
        }else {
        indexView.backgroundColor = buttonsColors[selectedTab]
        }
        indexView.layer.shadowColor = #colorLiteral(red: 0.2732129395, green: 0.6568266749, blue: 0.4387068152, alpha: 1)//UIColor.white.cgColor//buttonsColors[selectedTab].cgColor
    }
    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        buttonsColors.removeAll()
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for (index, viewController) in viewControllers.enumerated() {
            guard let tabBarItem = viewController.tabBarItem as? KRTabBarItem else {
                assertionFailure("TabBarItems class must be KRTabBarItem")
			    return
            }
            buttonsColors.append(tabBarItem.backgroundColor)
			
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            let image = viewController.tabBarItem.image?.withRenderingMode(.alwaysTemplate)
            if index == 0 {
                button.imageView?.tintColor = #colorLiteral(red: 0.2732129395, green: 0.6568266749, blue: 0.4387068152, alpha: 1)
            } else {
              button.imageView?.tintColor = tabBarItem.iconColor
            }
			
            button.setImage(image, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        view.setNeedsLayout()
    }
    
    private func autolayout() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            customTabBarView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, constant: -40),
            customTabBarView.heightAnchor.constraint(equalToConstant: 70),
            customTabBarView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5),
            customTabBarView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: customTabBarView.heightAnchor),
            indexView.widthAnchor.constraint(equalToConstant: customTabBarView.bounds.height),
            indexView.heightAnchor.constraint(equalToConstant: customTabBarView.bounds.height),
            indexView.centerYAnchor.constraint(equalTo: customTabBarView.centerYAnchor),
            indexView.centerXAnchor.constraint(equalTo: buttons.first?.centerXAnchor ?? customTabBarView.centerXAnchor)
        ])
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        indexView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
        customTabBarView.addSubview(indexView)
        customTabBarView.addSubview(stackView)
    }
    
    @objc private func didSelectIndex(sender: UIButton) {
        let index = sender.tag
        self.selectedIndex = index
        self.selectedTab = index
        for btn in buttons {
            if btn.tag == sender.tag {
                sender.imageView?.tintColor = #colorLiteral(red: 0.2732129395, green: 0.6568266749, blue: 0.4387068152, alpha: 1)
            }else {
                btn.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.indexView.center.x = self.buttons[index].center.x
            self.indexView.backgroundColor = UIColor.white // self.buttonsColors[index]
            self.indexView.layer.shadowColor = UIColor.white.cgColor
            
            //self.buttonsColors[index].cgColor
        }, completion: nil)
    }
    
    
    // Delegate:
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        didSelectIndex(sender: self.buttons[index])
    }
    
}
