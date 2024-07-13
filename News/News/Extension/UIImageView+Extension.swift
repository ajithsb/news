//
//  UIImageView+Extension.swift
//  News
//
//  Created by Aj on 13/07/24.
//

import UIKit
extension UIImageView {
    private static var taskKey = 0
    private static var urlKey = 0
    // objc_getAssociatedObject. Returns the value associated with a given object for a given key.
    private var currentTask: URLSessionTask? {
        get { objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var currentURL: URL? {
        get { objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func loadImageAsync(with urlString: String?, placeholder: UIImage? = UIImage(named: "placeholder")) {

        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()

        self.image = placeholder
        guard let urlString = urlString else { return }

        // check cache
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }

        // download
        guard let url = URL(string: urlString) else { return }
        currentURL = url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil

            if let error = error {
                if (error as? URLError)?.code == .cancelled {
                    return
                }

                print(error)
                return
            }

            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }
            ImageCache.shared.save(image: downloadedImage, forKey: urlString)
            if url == self?.currentURL {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }
        currentTask = task
        task.resume()
    }
}

final class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
