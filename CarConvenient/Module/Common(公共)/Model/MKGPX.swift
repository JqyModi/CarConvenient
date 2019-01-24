//
//  MKGPX.swift
//  Trax
//
//  Created by mac on 2017/11/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import MapKit
//创建子类扩展父类变量
class EditableWaypoint: Waypoint {
    override var coordinate: CLLocationCoordinate2D {
        get {
            return super.coordinate
        }
        set {
            coordinate.latitude = newValue.latitude
            coordinate.longitude = newValue.longitude
        }
    }
    
    var thumbnailURL1: NSURL? {
        return self.imageURL1
    }
    
    var imageURL1: NSURL? {
        return links.first?.url as! NSURL
    }
}

extension Waypoint: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var title: String! {
        return name
    }
    var subTitle: String! {
        return info
    }
    
    var thumbnailURL: NSURL? {
        return getImageURLOfType(type: "thumbnail")
    }
    
    var imageURL: NSURL? {
        return getImageURLOfType(type: "large")
    }
    
    func getImageURLOfType(type: String) -> NSURL? {
        if links.count > 0 {
            for link in links {
                if link.type == type {
                    return link.url as! NSURL
                }
            }
        }
        return nil
    }
}

class Waypoint: Entry
{
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
    }
    
    var info: String? {
        set { attributes["desc"] = newValue }
        get { return attributes["desc"] }
    }
    lazy var date: Date? = self.attributes["time"]?.asGpxDate
    
    override var description: String {
        return " " + "\(["lat=\(latitude)", "lon=\(longitude)", super.description])"
    }
}

class Entry: NSObject
{
    var links = [Link]()
    var attributes = [String:String]()
    
    var name: String? {
        set { attributes["name"] = newValue }
        get { return attributes["name"] }
    }
    
    override var description: String {
        var descriptions = [String]()
        if attributes.count > 0 { descriptions.append("attributes=\(attributes)") }
        if links.count > 0 { descriptions.append("links=\(links)") }
        return " " + "\(descriptions)"
    }
}

class Link: CustomStringConvertible
{
    var href: String
    var linkattributes = [String:String]()
    
    init(href: String) { self.href = href }
    
    var url: URL? { return URL(string: href) }
    var text: String? { return linkattributes["text"] }
    var type: String? { return linkattributes["type"] }
    
    var description: String {
        var descriptions = [String]()
        descriptions.append("href=\(href)")
        if linkattributes.count > 0 { descriptions.append("linkattributes=\(linkattributes)") }
        return "[" + " " + "\(descriptions)" + "]"
    }
}

// MARK: - Extensions

private extension String {
    var trimmed: String {
        return (self as NSString).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension String {
    var asGpxDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
            return dateFormatter.date(from: self)
        }
    }
}
