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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var icons: [UIImageView] = []
    @IBOutlet var springViews: [SpringView]!
    
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
        for (i, springView) in self.springViews.enumerated() {
            springView.didMoveToSuperview()
            let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
            embededViewController.venue = self.venues[i]
            embededViewController.venueImage = self.venueImages[i]
            
            for productBundle in self.products {
                if productBundle.product.venueId == self.venues[i]?.venueId {
                    embededViewController.products.append(productBundle.product)
                    embededViewController.productImages.append(productBundle.image)
                }
            }
            
            springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
            springView.indexSubviews(self.view)
        }
        
        self.addTextToStory(index: 2)
        self.addActionToStory(index: 4)
        self.addActionToStory(index: 4)
        self.addActionToStory(index: 4)

        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0xf3 / 255, green: 0xcf / 255, blue: 0x55 / 255, alpha: 1).cgColor,
            UIColor(red: 0xc6 / 255, green: 0x6f / 255, blue: 0x29 / 255, alpha: 1).cgColor
        ]
        
        gradient.frame = self.view.bounds
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0.2, y: 1)
        //        self.view.layer.insertSublayer(gradient, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(disableScrolling(_:)),
                                               name: NSNotification.Name.springExpand,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableScrolling(_:)),
                                               name: NSNotification.Name.springColapse,
                                               object: nil)
        
        self.stackView.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for springView in self.springViews {
            springView.getSmallFrame()
            springView.indexSubviews(self.view)
        }
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
    
    private func addTextToStory(index: Int) {
        
        let container = SpringView()
        //        container.cornerRadius = 5
        //        container.shadowOffset = CGSize(width: 1, height: 1)
        //        container.shadowRadius = 6
        //        container.shadowOpacity = 0.5
        //        container.shadowColor = UIColor(white: 0.33, alpha: 1)
        //        container.backgroundColor = .white
        container.isUserInteractionEnabled = false
        let textLabel = UILabel()
        container.addSubview(textLabel)
        textLabel.text = "Lorem ipsum test in which many iuals died in the process. Bathing in whale guts is considered to be pleasant.Lorem ipsum test in which many iuals died in the process. Bathing in whale guts is considered to be pleasant."
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        textLabel.textAlignment = .left
        
        self.stackView.insertArrangedSubview(container, at: index)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        container.heightAnchor.constraint(equalTo: textLabel.heightAnchor, constant: 16).isActive = true
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1, constant: -16).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    private func addActionToStory(index: Int) {
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
        self.stackView.insertArrangedSubview(container, at: index)
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
        
        //imageView.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: 0, height: 0)
        
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
              promotional: "Gianluca is a real music lover and if you are too you will have for sure a very interesting conversation and some precious hints.",
              description: """
Il Musicante is the perfect place where to find any kind of rare vinyl from pop to classic music, but of course this is just the place to be if you want to discover some Neapolitan traditional music pearls as Roberto De Simone original records and even some iconic Neapolitan movies.
""",
              category: "Records Store",
              address1: "Via San Biagio dei Librai 89",
              address2: nil,
              city: "Naples",
              country: "Italy",
              zipCode: "80138",
              phone: "+39 391 350 2187",
              email: "gianlucarignelli@libero.it"),
        Venue(venueId: "1",
              name: "L’Ospedale delle Bambole",
              promotional: "L'ospedale delle Bambole (The Dolls Hospital) is a museum/shop, unique in it's kind, inside the Palazzo Marigliano.",
              description: """
In the late ninety century Luigi Grassi was a puppet maker, counting the Royal Court among his clients. One day a poor woman came to him bagging to repair the doll of her daughter, not knowing anyone else with the ability to do so. Surprised by the request he puzzled for a minute, then he accepted to fix the humble doll, succeeding.
""",
              category: "Shop/Museum",
              address1: "Via San Biagio dei Librai 39",
              address2: "Palazzo Marigliano",
              city: "Naples",
              country: "Italy",
              zipCode: "80138",
              phone: "+39 393 484 7244",
              email: "ospedaledellebambole@gmail.com"),
        Venue(venueId: "2",
              name: "Legatoria Artigiana Napoli",
              promotional: "A beautiful book workshop, one of the few survived the centuries, again in Palazzo Marigliano.",
              description: """
In this incredible place you can watch the artisans at work in restoring ancient books, but also working on new refined paper product. In the Legatoria you will find elegant hand-made agendas, booklets and so much more. Everything carefully crafted and decorated.
""",
              category: "Handcrafted Items",
              address1: "Via San Biagio dei Librai 39",
              address2: "Palazzo Marigliano",
              city: "Naples",
              country: "Italy",
              zipCode: "80138",
              phone: "081 551 1280",
              email: "legatorianapoli@virgilio.it"),
        Venue(venueId: "3",
              name: "Il Baule Volante",
              promotional: "Right at the corner between Spaccanapoli and the renowned San Gregorio Armeno (famous for its crib artisans) you have the chance to meet Claudia.",
              description: """
Claudia is the owner of the Baule Volante a vintage cloths shop with a super selected selection of the best outfit for you. If you can’t find what you are looking for, be sure that Claudia will look for that particular request personally.

In a blink of an eye she will hold in her hand the thing that suits you perfectly.If for whatever reason is really impossible to satisfy your vintage cloths needs, you at least got the great pleasure of an interesting chat, and maybe a coffee, with some of the most passionate shopkeeper of Spaccanapoli.
""",
              category: "Thrift Shop",
              address1: "Via San Biagio dei Librai 106",
              address2: nil,
              city: "Naples",
              country: "Italy",
              zipCode: "80138",
              phone: nil,
              email: "baulevolante.vintage@libero.it"),
        Venue(venueId: "4",
              name: "Stampe e Oggetti d’Epoca",
              promotional: "Here you will meet one of the protagonist of the Neapolitan vintage scene: Alfonso Sorrentino.",
              description: """
Alfonso runs and select for twenty years a charming underground place that we might call a wunderkammer, a wonder room.
Stampe e oggetti d’Epoca totally reflects the refined taste of Alfonso who carefully select the best objects embodying the most interesting stories.

At the first glance it will look difficult to orient yourself among all those objects, but be sure that Alfonso, quietly sat on his comfy red armchair, absently reading a book, will greatly guide you through the thing you will never wish to be separated from.
""",
              category: "Vintage Art",
              address1: "Via S. Giovanni Maggiore Pignatelli 49",
              address2: nil,
              city: "Naples",
              country: "Italy",
              zipCode: "80134",
              phone: "081 542 2137",
              email: "alfonso_sorrentino@hotmail.it"),
        Venue(venueId: "5",
              name: "Liquid Spirit Art Bar",
              promotional: "Some of the best drinks in the city, carefully batched by perfectionist bartenders",
              description: """
You should know about a quite well hidden night bar, that merges contemporary art together with the ancient greek walls found in the basement of this special place.

The Liquid Spirit Art Bar is in the end of Vico Pallonetto a Santa Chiara, a narrow street starting almost in front of Alfonso’s shop.

The atmosphere is absolutely unique either if you decide to enjoy you aperitivo inside, surrounded by pieces of arts, or outside, in a charming small square.
""",
              category: "Bar",
              address1: "Via Pallonetto a S, Via Santa Chiara, 14/b",
              address2: nil,
              city: "Naples",
              country: "Italy",
              zipCode: "80134",
              phone: "081 1950 6951",
              email: nil)
    ]
    
    var venueImages: [UIImage?] = [
        #imageLiteral(resourceName: "IlMusicante/Shop"),
        #imageLiteral(resourceName: "OspedaleBambole/Shop"),
        #imageLiteral(resourceName: "LegatoriaArtigiana/Shop"),
        #imageLiteral(resourceName: "BauleVolante/Shop"),
        #imageLiteral(resourceName: "StampeOggettiEpoca/Shop"),
        #imageLiteral(resourceName: "LiquidSpiritArtBar/Shop")
    ]
    
    //MARK: Products
    var products: [(product: Product, image: UIImage)] = [
        (Product(productId: "0",
                 venueId: "0",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "IlMusicante/Pr1")),
        (Product(productId: "1",
                 venueId: "0",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "IlMusicante/Pr2")),
        (Product(productId: "2",
                 venueId: "0",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "IlMusicante/Pr3")),
        (Product(productId: "3",
                 venueId: "1",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "OspedaleBambole/Pr1")),
        (Product(productId: "4",
                 venueId: "1",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "OspedaleBambole/Pr2")),
        (Product(productId: "5",
                 venueId: "1",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "OspedaleBambole/Pr3")),
        (Product(productId: "6",
                 venueId: "2",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LegatoriaArtigiana/Pr1")),
        (Product(productId: "7",
                 venueId: "2",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LegatoriaArtigiana/Pr2")),
        (Product(productId: "8",
                 venueId: "2",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LegatoriaArtigiana/Pr3")),
        (Product(productId: "9",
                 venueId: "3",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "BauleVolante/Pr1")),
        (Product(productId: "10",
                 venueId: "3",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "BauleVolante/Pr2")),
        (Product(productId: "11",
                 venueId: "3",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "BauleVolante/Pr3")),
        (Product(productId: "12",
                 venueId: "4",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "StampeOggettiEpoca/Pr1")),
        (Product(productId: "13",
                 venueId: "4",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "StampeOggettiEpoca/Pr2")),
        (Product(productId: "14",
                 venueId: "4",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "StampeOggettiEpoca/Pr3")),
        (Product(productId: "15",
                 venueId: "5",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LiquidSpiritArtBar/Pr1")),
        (Product(productId: "16",
                 venueId: "5",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LiquidSpiritArtBar/Pr2")),
        (Product(productId: "17",
                 venueId: "5",
                 name: "",
                 description: "")!,
         #imageLiteral(resourceName: "LiquidSpiritArtBar/Pr3"))
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
                icon.tag = 0
            }
        }
    }
}
