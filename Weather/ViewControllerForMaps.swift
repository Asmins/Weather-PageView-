
//  ViewControllerForMap.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewControllerForMaps: UIViewController,UISearchBarDelegate,LocateOnMap {

    @IBOutlet weak var viewForGoogleMaps: UIView!
    
    var googleMapsView:GMSMapView!
    var searchResultController:SearchResultController!
    
    var cityArray = [String]()
    var meneger = CityManager()
    
    
    @IBAction func searchButton(sender: AnyObject) {
        let searchResult = UISearchController(searchResultsController: searchResultController)
        searchResult.searchBar.delegate = self
        self.presentViewController(searchResult, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: self.viewForGoogleMaps.frame)
        self.view.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultController()
        searchResultController.delegate = self
    }
    
    func locateWithLongitude(lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
            
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let place = GMSPlacesClient()
        
        
        place.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error:NSError?)->Void in
            
            self.cityArray.removeAll()
            if results == nil{
                return
            }
            for result in results! {
                if results != nil {
                    self.cityArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadData(self.cityArray)
        }
    }


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func showFirstView(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
