//
//  extensions.swift
//  DBProject
//
//  Created by Artem Misesin on 3/9/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation
import Cocoa

extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}

extension NSStoryboardSegue {
    
    var source: NSViewController? {
        return self.sourceController as? NSViewController
    }
    
    var destination: NSViewController? {
        return self.destinationController as? NSViewController
    }
}

extension NSImageView {
    func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = NSImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else {
            self.image = NSImage(named: "NSUserGuest")
            return
        }
        downloadedFrom(url: url)
    }
}
