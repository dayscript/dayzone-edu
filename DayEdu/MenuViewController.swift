import UIKit

class MenuViewController: UIViewController, ESTBeaconManagerDelegate {

    // ----------------------------------------------------------
    // GETTING STARTED CODE starts here
    // ----------------------------------------------------------

    var tableNumber = 0
    
    @IBOutlet weak var tableNumberLabel: UILabel!

    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: "11EFEBC8-CD29-11E3-B415-1A514932AC01"), major:2258, minor:35537,
        identifier: "DayEdu")
    
    override func viewDidLoad() {
        tableNumberLabel.text = "Calculando..."
        //Opt in to be notified upon entering and exiting region
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        beaconManager.delegate = self
        beaconManager.startMonitoringForRegion(beaconRegion)
        beaconManager.requestAlwaysAuthorization()
        beaconManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func beaconManager(manager: AnyObject!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            if beacons.count > 0 {
                var firstBeacon = beacons.first! as! CLBeacon
                println("Accuracy: \(firstBeacon.accuracy)")
                println("RSSI: \(firstBeacon.rssi)")
                println("Proximity: \(firstBeacon.proximity)")
                
                self.tableNumberLabel.text = ("\(textForPromimity(firstBeacon.proximity))")
                
            }
    }
    func textForPromimity(proximity:CLProximity) -> (NSString)
    {
        var distance : NSString!
        
        switch(proximity)
        {
        case .Far:
            println("Far")
            distance = "Lejos"
            return distance
        case .Near:
            println("Near")
            distance = "Cerca"
            return distance
        case .Immediate:
            println("Immediate")
            distance = "Immediato"
            return distance
        case .Unknown:
            println("Unknown")
            distance = "Desconocido"
            return distance
        default:
            break;
        }
        return distance
    }
    


    // ----------------------------------------------------------
    // GETTING STARTED CODE ends here
    // ----------------------------------------------------------

    //check for region failure
    func beaconManager(manager: AnyObject!, monitoringDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        println("Region did fail: \(manager) \(region) \(error)")
    }
    //checks permission status
    func beaconManager(manager: AnyObject!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Status: \(status)")
    }
    //beacon entered region
    func beaconManager(manager: AnyObject!, didEnterRegion region: CLBeaconRegion!) {
        var notification : UILocalNotification = UILocalNotification()
        notification.alertBody = "Has llegado a: Análisis Microeconómico"
//        notification.soundName = "Default.mp3"
        println("Enter")
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    //beacon exited region
    func beaconManager(manager: AnyObject!, didExitRegion region: CLBeaconRegion!) {
        var notification : UILocalNotification = UILocalNotification()
        notification.alertBody = "Has salido de: Análisis Microeconómico"
//        notification.soundName = "Default.mp3"
        println("Exit")
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }


    // ----------------------------------------------------------
    // MARK: - User interface and actions
    // ----------------------------------------------------------

}
