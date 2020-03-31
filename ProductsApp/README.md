### Installation

1. Open terminal and navigate to project folder
2. Run `pod install`
3. Open `ProductsApp.xcworkspace` and run the project on selected device or simulator

### Dependencies Used

#### Alamofire

Used for HTTP networking

##### Alternatives to Alamofire

- RestKit (for Obj-C)
- Able to build extensive network layer without the use of any third party libraries, though this is time consuming. To see an example of a complete, protocol orientated network layer check out my [iOS-Network-Layer-Demo](https://github.com/ajvelo/iOS-Network-Layer-Demo)

#### SwiftyJSON

- Used for JSON handling
- Swift is very strict about types. But although explicit typing is good for saving us from mistakes, it becomes painful when dealing with JSON and other areas that are, by nature, implicit about types.

##### Alternatives to SwiftyJSON

- Optional Chaining

#### SDWebImage

- Used for async image downloader with cache support

##### Alternatives to SDWebImage

- NSCache. Can be done by applying an extension to UIImageView

```swift
var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(fromURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let activityView = UIActivityIndicatorView(style: .medium)
            self.addSubview(activityView)
            activityView.frame = self.bounds
            activityView.translatesAutoresizingMaskIntoConstraints = false
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            activityView.startAnimating()

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                }

                if let data = data {
                    let image = UIImage(data: data)
                    imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
```

