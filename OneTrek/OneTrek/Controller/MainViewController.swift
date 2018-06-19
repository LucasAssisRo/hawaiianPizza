//
//  MainViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 14/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

@IBDesignable
class MainViewController: UIViewController {
    
    @IBOutlet weak var marginView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var icons: [UIImageView] = []
    var springViews: [SpringView] = []
    
    @IBInspectable var hasLightStatusBar: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.hasLightStatusBar ? .lightContent : .default
    }
    
    private var _isStatusBarHidden: Bool = false
    
    var isStatusBarHidden: Bool {
        get {
            return self._isStatusBarHidden
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return self._isStatusBarHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let storyboard = self.storyboard else { return }
        for view in self.stackView.arrangedSubviews {
            if let springView = view as? SpringView {
                springView.didMoveToSuperview()
                let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
                embededViewController.venue = self.venues[0]
                springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
                springView.indexSubviews(self.view)
                
                print(springView.frame)
            }
        }
        
        self.addTextToStory()
        self.addActionToStory()
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0xf3 / 255, green: 0xcf / 255, blue: 0x55 / 255, alpha: 1).cgColor,
            UIColor(red: 0xc6 / 255, green: 0x6f / 255, blue: 0x29 / 255, alpha: 1).cgColor
        ]

        gradient.frame = self.view.bounds
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0.2, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(disableScrolling(_:)),
                                               name: NSNotification.Name.springExpand,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableScrolling(_:)),
                                               name: NSNotification.Name.springColapse,
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStatusBarHidden(_ isHidden: Bool, with duration: TimeInterval) {
        self._isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.scrollView.frame.origin.y -= self._isStatusBarHidden ? 20 : -20
            self.scrollView.frame.size.height += self._isStatusBarHidden ? 20 : -20
        }
    }
    
    @objc func disableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = false
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
    }
    
    @objc func enableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
    }
    
    private func createSpringView() -> SpringView {
        let width = self.view.bounds.width - 48
        let height = width * 327 / 356
        let springView = SpringView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        springView.animationDuration = 0.2
        springView.shrinkX = 0.95
        springView.shrinkY = 0.95
        springView.cornerRadius = 5
        springView.shadowOffset = CGSize(width: 1, height: 1)
        springView.shadowRadius = 6
        springView.shadowOpacity = 0.5
        springView.shadowColor = UIColor(white: 0.33, alpha: 1)
        return springView
    }
    
    private func addTextToStory() {
        
        let container = UIView()
        let textLabel = UILabel()
        textLabel.text = "Lorem ipsum test in which many iuals died in the process. Bathing in whale guts is considered to be pleasant."
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        
        self.stackView.addArrangedSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        container.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        container.backgroundColor = UIColor.green
        
        // subStackView.addArrangedSubview(textLabel)
        container.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
    }
    
    private func addActionToStory() {
        let container = UIView()
        
        let subStackView = UIStackView()
        subStackView.axis = .vertical
        
        let textLabel = UILabel()
        textLabel.text = "Lorem ipsum test in which many iuals died in the process."
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        
        let image = UIImage(named: "cam3")
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        //   imageView.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: imageView.frame.width / 8, height: imageView.frame.height / 8)
        
        // Add text to story
        self.stackView.addArrangedSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        container.heightAnchor.constraint(equalToConstant: 100).isActive = true
        container.backgroundColor = UIColor.green
        /**
         container.addSubview(subStackView)
         subStackView.alignment = .leading
         subStackView.translatesAutoresizingMaskIntoConstraints = false
         //        subStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         subStackView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
         subStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
         subStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
         subStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
         subStackView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1).isActive = true
         subStackView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1).isActive = true
         
         subStackView.backgroundColor = UIColor.red
         **/
        
        
        //subStackView.addArrangedSubview(imageView)
        container.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.icons.append(imageView)
        imageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.0003).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        
        // subStackView.addArrangedSubview(textLabel)
        container.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        //textLabel.widthAnchor.constraint(equalTo: subStackView.widthAnchor, multiplier: 1).isActive = true
        
        //  imageView.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: 0, height: 0)
        
        ///imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: 0).isActive = true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: VENUES
    var venues: [Venue?] = [
        Venue(venueId: "0",
              name: "Il Musicante",
              description:
            """
Il Musicante is the perfect place where to find any kind of rare vinyl from pop to classic music. Of course this is just the place to be if you want to discover some Neapolitan traditional music gems, like Roberto De Simone original records and iconic Neapolitan movies.
""",
              category: "Vintage Store",
              address1: "idk the address",
              address2: "idk the address",
              city: "Naples",
              country: "Italy",
              zipCode: "idk the address",
              phone: "idk the phone",
              email: "idk the email"),
        
        Venue(venueId: "0",
              name: "Il Musicante",
              description:
            """
Il Musicante is the perfect place where to find any kind of rare vinyl from pop to classic music. Of course this is just the place to be if you want to discover some Neapolitan traditional music gems, like Roberto De Simone original records and iconic Neapolitan movies.
""",
              category: "Vintage Store",
              address1: "idk the address",
              address2: "idk the address",
              city: "Naples",
              country: "Italy",
              zipCode: "idk the address",
              phone: "idk the phone",
              email: "idk the email"),
        
        Venue(venueId: "0",
              name: "Il Musicante",
              description:
            """
Il Musicante is the perfect place where to find any kind of rare vinyl from pop to classic music. Of course this is just the place to be if you want to discover some Neapolitan traditional music gems, like Roberto De Simone original records and iconic Neapolitan movies.
""",
              category: "Vintage Store",
              address1: "idk the address",
              address2: "idk the address",
              city: "Naples",
              country: "Italy",
              zipCode: "idk the address",
              phone: "idk the phone",
              email: "idk the email")
    ]
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SpringView.offset = scrollView.contentOffset
        SpringView.offset.y -= 8
        
        for subview in self.stackView.arrangedSubviews {
            if let springview = subview as? SpringView {
                UIView.animate(withDuration: 0.1,
                               delay: 0,
                               options: [.layoutSubviews, .allowAnimatedContent, .curveEaseOut],
                               animations: {
                                springview.transform = .identity
                })
            }
        }
        
        let container = CGRect(x: scrollView.contentOffset.x,
                               y: scrollView.contentOffset.y,
                               width: scrollView.frame.size.width,
                               height: scrollView.frame.size.height)
        
        for icon in self.icons {
            if container.intersects(icon.convert(icon.bounds, to: self.scrollView)) {
                if icon.tag == 0 {
                    print("nöp")
                    icon.tag = 1
                    UIView.animate(withDuration: 0.3, animations: {
                        icon.frame = CGRect(x: icon.frame.minX, y: icon.frame.minY, width: icon.frame.width / 1.2, height: icon.frame.height / 1.2)
                    }, completion: { finish in
                        UIView.animate(withDuration: 0.2, animations: {
                            icon.frame = CGRect(x: icon.frame.minX, y: icon.frame.minY, width: icon.frame.width * 1.2, height: icon.frame.height * 1.2)
                        })
                    })
                }
            } else {
                print("jap")
                icon.tag = 0
            }
        }
    }
}
