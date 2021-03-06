import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "4d2b8c31cacd2440d0c272dc9c604b96"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    // IO Outlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this controller deals with location data
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.requestWhenInUseAuthorization()
        
        // method working in the background
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url: String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                // data came back
                print("Success! Got the weather data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                // inside a closure - use self.
                self.updateWeatherData(json: weatherJSON)
                
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    

    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            weatherDataModel.temperature = Int(tempResult - 273.15)
            
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName =  weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        }
        
    }

    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature) + "°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // the last value of the array is the most accurate
        let location = locations[locations.count - 1]
        
        // check if the location is valid
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            // dictionary for coordinate
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        // display for user
        cityLabel.text = "Location Unavailable"
    }
    
    

    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String){
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
    
}


