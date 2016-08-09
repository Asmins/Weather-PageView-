import UIKit
import CoreLocation
import PageMenu

class FirstViewController: UIViewController,CLLocationManagerDelegate,CAPSPageMenuDelegate{
    
    var manager = CityManager()
    var locationManager:CLLocationManager!
    var tempCheck = TemperatureManager()
    
    var pageMenu : CAPSPageMenu?
    
    var viewControllerArray : [UIViewController] = []
    
    @IBOutlet weak var lowView: UIView!
    
    var location: CLLocation!{
        didSet{
            manager.saveLat(location.coordinate.latitude)
            manager.saveLong(location.coordinate.longitude)
            self.getNameCity(Float(location.coordinate.latitude), long: Float(location.coordinate.longitude))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nowViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NowViewController")
        nowViewController?.title = "Now"
        viewControllerArray.append(nowViewController!)
        
        let hourlyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HourlyViewController")
        hourlyViewController?.title = "Hourly"
        viewControllerArray.append(hourlyViewController!)
        
        let dailyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DailyViewController")
        dailyViewController?.title = "Daily"
        viewControllerArray.append(dailyViewController!)
        
        pageMenu?.delegate = self
        
        let menuParam: [CAPSPageMenuOption] = [.MenuItemSeparatorWidth(1.0),.MenuMargin(20.0),.MenuHeight(40.0),
                                               .UseMenuLikeSegmentedControl(true),
                                               .MenuItemSeparatorRoundEdges(true),
                                               .SelectionIndicatorHeight(2.0),
                                               .MenuItemSeparatorPercentageHeight(0.5),
                                               .SelectionIndicatorColor(UIColor.whiteColor()),
                                               .CenterMenuItems(true),
                                               .SelectedMenuItemLabelColor(UIColor.whiteColor()),
                                               .MenuItemFont(UIFont(name: "Apple SD Gothic Neo", size: 19.0)!),
                                               .ScrollMenuBackgroundColor(UIColor(red: 180.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            )
        ]
        pageMenu = CAPSPageMenu(viewControllers: viewControllerArray, frame: CGRectMake(0.0, 0.0,self.view.frame.size.width, UIScreen.mainScreen().bounds.size.height), pageMenuOptions: menuParam)
    }
    
    @IBAction func showMapView(sender: AnyObject) {
        let toShowMapsView = self.storyboard?.instantiateViewControllerWithIdentifier("MapsView") as! ViewControllerForMaps
        self.navigationController?.pushViewController(toShowMapsView, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        navigationItem.title = manager.getName()
        navigationController?.navigationBar.barTintColor = UIColor(red: 180.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.lowView.addSubview(pageMenu!.view)
    }
    
    func checkCoreLocation(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            locationManager.startUpdatingHeading()
        }else if CLLocationManager.authorizationStatus() == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .Restricted{
            print("Use location service")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func showSetting(sender: AnyObject) {
        let settingMenu = UIAlertController(title: nil, message: "Setting", preferredStyle: .ActionSheet)
        
        let findMeToGPS = UIAlertAction(title: "Find Me (GPS)", style: UIAlertActionStyle.Default , handler: {(action)-> Void in
            self.locationManager.startUpdatingLocation()
        })
        
        let changeTo = UIAlertAction(title: "Change to F°/C°", style: UIAlertActionStyle.Default, handler: {(action)-> Void in
            if self.tempCheck.getCheck() == false{
                self.tempCheck.setCheck(true)
            }else{
                self.tempCheck.setCheck(false)
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        settingMenu.addAction(findMeToGPS)
        settingMenu.addAction(changeTo)
        settingMenu.addAction(cancel)
        
        self.presentViewController(settingMenu, animated: true, completion: nil)
    }
    
    func getNameCity(lat:Float,long:Float){
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&sensor=false")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data,response,error)-> Void in
            do{
                if data != nil{
                    let data = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                    if let result = data["results"] as? NSArray{
                        if let resultArray = result[0] as? NSDictionary{
                            if let adress = resultArray["address_components"] as? NSArray{
                                if let number = adress[2] as? NSDictionary{
                                    if let name = number["long_name"] as? String{
                                        self.manager.saveName(name)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
            }catch{
                print("Error")
            }
        }
        task.resume()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}