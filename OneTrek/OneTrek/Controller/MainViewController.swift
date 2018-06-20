//
//  MainViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 14/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable
class MainViewController: UIViewController {
    
    var icons: [UIImageView] = []
    var springViews: [SpringView] = []
    
    @IBOutlet weak var startPinButton: UIButton!
    @IBOutlet weak var startPinButton2: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var contentsStackView: UIStackView!
    
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
        for (i, venue) in self.venues.enumerated() {
            let springView = self.insertSpringView()
            self.springViews.append(springView)
            let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
            embededViewController.venue = venue
            embededViewController.venueImage = self.venueImages[i]
            embededViewController.springView = springView
            
            for productBundle in self.products {
                if productBundle.product.venueId == self.venues[i]?.venueId {
                    embededViewController.products.append(productBundle.product)
                    embededViewController.productImages.append(productBundle.image)
                }
            }
            
            springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
            springView.indexSubviews(self.view)
        }
        
        self.insertTextToStory(at: 2,
                               text: "If you feel ready dive in one of the richest Neapolitan palaces in terms of history and creativity. Take few more steps and on your right you will find Palazzo Marigliano.")
        self.insertActionToStory(at: 4,
                                 action: "Look up to the charming suspended garden. Maybe take the time to take gorgeous and unforgettable pictures.",
                                 icon: #imageLiteral(resourceName: "cam3"))
        self.insertTextToStory(at: 6,
                               text: """
Get out of Palazzo Marigliano now. Forget the peace the Marigliano courtyard and get back in the tumultuous colourful chaos of Spaccanapoli.
""")
        self.insertActionToStory(at: 8,
                                 action: """
This is a good time to take a break and sit down at one of the benches in front of Parrocchia all’Olmo. Take a look at black lava tiles, here for nearly 400 hundreds years.
""",
                                 icon: #imageLiteral(resourceName: "cam3"))
        self.insertActionToStory(at: 10,
                                 action: """
Our Vintage Grand Tour is finishing now, but before the end you might want to relax with a few drinks on our next stop.
""",
                                 icon: #imageLiteral(resourceName: "drink"))
        self.startPinButton.imageView?.tintColor = .black
        
        //        let gradient = CAGradientLayer()
        //        gradient.colors = [
        //            UIColor(red: 0xf3 / 255, green: 0xcf / 255, blue: 0x55 / 255, alpha: 1).cgColor,
        //            UIColor(red: 0xc6 / 255, green: 0x6f / 255, blue: 0x29 / 255, alpha: 1).cgColor
        //        ]
        //
        //        gradient.frame = self.view.bounds
        //        gradient.startPoint = .zero
        //        gradient.endPoint = CGPoint(x: 0.2, y: 1)
        //        self.view.layer.insertSublayer(gradient, at: 0)
        
        //        self.view.backgroundColor = UIColor(red: 0xc6 / 255, green: 0x6f / 255, blue: 0x29 / 255, alpha: 1)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(disableScrolling(_:)),
                                               name: NSNotification.Name.springExpand,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableScrolling(_:)),
                                               name: NSNotification.Name.springColapse,
                                               object: nil)
        
        self.contentsStackView.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 24)))
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
        
        let defaults = UserDefaults.standard
        let x = defaults.double(forKey: "scrollViewXOffset")
        let y = defaults.double(forKey: "scrollViewYOffset")
        self.mainScrollView.contentOffset = CGPoint(x: x, y: y)
    }
    
    func setStatusBarHidden(_ isHidden: Bool, with duration: TimeInterval) {
        self._isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.setNeedsStatusBarAppearanceUpdate()
            print(self.mainScrollView.frame)
            self.mainScrollView.frame.origin.y -= self._isStatusBarHidden ? AppDelegate.statusBarHeight : -AppDelegate.statusBarHeight
            self.mainScrollView.frame.size.height += self._isStatusBarHidden ? AppDelegate.statusBarHeight : -AppDelegate.statusBarHeight
            print(self.mainScrollView.frame)
        }
    }
    
    private func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil,
                let placemarks = placemarks
                else {
                    print("Geocoding error: \(error!)")
                    completion(nil)
                    return
            }
            
            completion(placemarks.first?.location?.coordinate)
        }
    }
    
    @IBAction func startTour(_ sender: Any) {
        self.coordinates(forAddress: "Via Vicaria Vecchia, 80138 Napoli NA") { (location) in
            guard let location = location else { return }
            
            let latitude: CLLocationDegrees = location.latitude
            let longitude: CLLocationDegrees = location.longitude
            let regionDistance: CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "San Genaro Mural"
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    @objc func disableScrolling(_ notification: NSNotification) {
        self.mainScrollView.isScrollEnabled = false
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
    }
    
    @objc func enableScrolling(_ notification: NSNotification) {
        self.mainScrollView.isScrollEnabled = true
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
    }
    
    private func insertSpringView(at index: Int? = nil) -> SpringView {
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
        springView.translatesAutoresizingMaskIntoConstraints = false
        if let index = index {
            self.contentsStackView.insertArrangedSubview(springView, at: index)
        } else {
            self.contentsStackView.addArrangedSubview(springView)
        }
        
        springView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        springView.heightAnchor.constraint(equalTo: springView.widthAnchor, multiplier: 376/327, constant: 1).isActive = true
        return springView
    }
    
    private func insertTextToStory(at index: Int? = nil, text: String) {
        let container = UIView()
        let textLabel = UILabel()
        container.addSubview(textLabel)
        textLabel.text = text
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        textLabel.textAlignment = .center
        
        if let index = index {
            self.contentsStackView.insertArrangedSubview(container, at: index)
        } else {
            self.contentsStackView.addArrangedSubview(container)
        }
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        container.heightAnchor.constraint(equalTo: textLabel.heightAnchor, constant: 16).isActive = true
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1, constant: -16).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    private func insertActionToStory(at index: Int? = nil, action text: String, icon: UIImage?) {
        let container = UIView()
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.sizeToFit()
        let image = icon
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        
        // Add text to story
        if let index = index {
            self.contentsStackView.insertArrangedSubview(container, at: index)
        } else {
            self.contentsStackView.addArrangedSubview(container)
        }
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -48).isActive = true
        
        container.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.icons.append(imageView)
        
        imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        
        container.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        textLabel.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        container.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        container.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
        
        imageView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        imageView.tag = 1321
    }
    
    //MARK: VENUES
    var venues: [Venue?] = [
        Venue(venueId: "0",
              name: "Il Musicante",
              promotional: "Gianluca is a real music lover. You will have for sure a very interesting conversation and precious hints.",
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
              promotional: "It’s a museum/shop (Dolls Hospital), unique in its kind, inside Palazzo Marigliano.",
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
              name: "Antica Legatoria Marigliano",
              promotional: "A beautiful book workshop, one of the few survived the centuries, at Palazzo Marigliano.",
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
              promotional: "At the corner between Spaccanapoli and San Gregorio Armeno you’ll have the chance to meet Claudia.",
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
              promotional: "Some of the best drinks in the city, carefully batched by perfectionist bartenders.",
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
        SpringView.offset.y -= AppDelegate.statusBarHeight == 20 ? 8 : 16
        
        for subview in self.contentsStackView.arrangedSubviews {
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
        let shrink = CGAffineTransform(scaleX: 0.8, y: 0.8)
        for icon in self.icons {
            if container.intersects(icon.convert(icon.bounds, to: self.mainScrollView)) {
                if icon.tag == 1321 {
                    icon.tag = 4321
                    UIView.animate(withDuration: 0.2,
                                   delay: 0.15,
                                   options: .curveEaseIn,
                                   animations: {
                                    icon.transform = .identity
                    }) { finished in
                        UIView.animate(withDuration: 0.1,
                                       delay: 0,
                                       options: .curveLinear,
                                       animations: {
                                        icon.transform = shrink
                        }) { finished in
                            UIView.animate(withDuration: 0.1,
                                           delay: 0,
                                           options: .curveEaseOut,
                                           animations: {
                                            icon.transform = .identity
                            })
                        }
                    }
                }
            }
        }
        
        if scrollView.contentOffset.y >= 0 {
            let defaults = UserDefaults.standard
            defaults.set(Double(scrollView.contentOffset.x), forKey: "scrollViewXOffset")
            defaults.set(Double(scrollView.contentOffset.y), forKey: "scrollViewYOffset")
        }
    }
}
