import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "4d2b8c31cacd2440d0c272dc9c604b96"
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    
    // IO Outlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here
        locationManager.delegate = self         // this class deals with location data
        
        // accuracy = meters
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // request for authorization from user
        locationManager.requestWhenInUseAuthorization()
        
        // method working in the background
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    // Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // the last value of the array is the most accurate
        let location = locations[locations.count - 1]
        
        // check if the location is valid
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let params = [String : String]                 // dictionary for coordinate
            
        }
        
        
    }
    
    
    /* Write the didFailWithError method here:
       Get triggered when there's error
    */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        // display for user
        cityLabel.text = "Location Unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


