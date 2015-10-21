#GoEuro
[![CocoaPods](https://img.shields.io/badge/Licence-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![CocoaPods](https://img.shields.io/badge/Platform-iOS-yellow.svg?style=flat-square)](https://en.wikipedia.org/wiki/IOS)
[![CocoaPods](https://img.shields.io/badge/Requires-iOS%209+-blue.svg?style=flat-square)](http://www.apple.com/ios/whats-new/)
[![CocoaPods](https://img.shields.io/badge/Made%20in-Berlin-red.svg?style=flat-square)](https://en.wikipedia.org/wiki/Berlin)

The purpose of this is to show how you can solve a problem using the Objective-c on one case and the Swift on the later.

### Autocompleting travel search form

The form requires the user to enter the departure or if the location service is enabled then the app finds the current locality and thereafter populates the end location. The date of their trip is also required. The arrival location need to be automatically completed using a list of known locations that can be requested through a JSON API. Date entry is facilitated by UIDatePicker. A "search" button is Tapping the "search" button should displays a "Search is not yet implemented" message to the user.

![search](search.png?raw=true)

#### Topics 

1. Concurrency 
2. CoreLocation
3. UITableViews
4. UIViewController - Segues and unwind segues
5. Networking - RestFul
6. CoreData - later...

These are just a few titles that will be highlighted in this project. Remember it is a sample project and nothing serious. It's aim is to show some best practices in the above mentioned topics

####Concurrency

Private queues in swift

```swift

    lazy var concurrentQueue:dispatch_queue_t = {
        var __dispatchToken:dispatch_once_t = 0
        var queue:dispatch_queue_t?
        let qos = qos_class_t(QOS_CLASS_USER_INITIATED.rawValue)
        let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, qos, 2);
        dispatch_once(&__dispatchToken, {
            queue = dispatch_queue_create("com.GoEuro.concurrent", attr);
        });
        return queue!
        }()   
```
How to use a private queue

```swift
    func locationDidFindCurrentLocality(locality: String) {
        departureTextField.text = locality
        dispatch_async(Manager.sharedInstance.concurrentQueue, {
            let query = Query(locale:"DE", term:locality)
            Manager.sharedInstance.fetchLocationsWithQuery(query)
        })
    }
```

Return back to the main queue to update the UI

```swift
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrivalTextField.text = location.fullname
            strongSelf.configureSearchButton()
        }
```
To be continued... watch out for updates.


