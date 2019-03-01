//
//  UIView+Extension.swift
//  SinaWeibo
//
//  Created by apple on 15/11/15.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore
import Accelerate
import SnapKit

enum clipCornerDirection :Int {
    case topLeft  = 0
    case topRight = 1
    case bottomLeft = 2
    case bottomRight = 3
    case left = 4
    case top  = 5
    case right = 6
    case bottom = 7
}

// MARK: - 扩展UIView
extension UIView {
    
    /// 当前view所在导航控制器
    var md_navController: UINavigationController? {
        return self.navController()
    }
    
    /// 通过响应者链条 找到导航控制器
    ///
    /// - Returns: 当前view所在导航控制器
    func navController() -> UINavigationController? {
        //遍历响应者链条 
        
        //获取当前视图对象的下一个响应者
        var next = self.next
        repeat {
            if next is UINavigationController {
                return next as? UINavigationController
            }
            next = next?.next
        
        } while (next != nil)
        
        return nil
    }
    
    /// 当前view所在控制器
    var md_viewController: UIViewController? {
        return self.md_getCurrentVC()
    }
    
    /// 通过响应者链条 找到控制器
    ///
    /// - Returns: 当前view所在的控制器
    private func _viewController() -> UIViewController? {
        
        /*
         /**
         获取当前视图的控制器
         
         @return 控制器
         */
         - (UIViewController*)viewController {
         for (UIView* next = [self superview]; next; next = next.superview) {
         UIResponder* nextResponder = [next nextResponder];
         if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
         return (UIViewController*)nextResponder;
         }
         }
         return nil;
         }
         */

        var nextResponder: UIResponder?
        repeat {
            nextResponder = nextResponder?.next
            if let next = nextResponder, (next.isKind(of: UIViewController.self)) {
                return nextResponder as? UIViewController
            }
        }while (nextResponder != nil)
        return nil
    }
    
    func md_getCurrentVC() -> UIViewController? {
        for window in UIApplication.shared.windows.reversed() {
            var tempView: UIView? = window.subviews.last
            for subview in window.subviews.reversed() {
                if subview.classForCoder == NSClassFromString("UILayoutContainerView") {
                    tempView = subview
                    break
                }
            }
            
            var nextResponder = tempView?.next
            
            var next: Bool {
                return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController || nextResponder?.classForCoder == NSClassFromString("UIInputWindowController")
            }
            
            while next{
                tempView = tempView?.subviews.first
                if tempView == nil {
                    return nil
                }
                nextResponder = tempView!.next
            }
            if let currentVC = nextResponder as? UIViewController {
                return currentVC
            }
        }
        return nil
    }
    
    /// 通过XIB创建View
    ///
    /// - Returns: XIB View
    class func md_viewFromXIB(cornerRadius: CGFloat = 0) -> UIView? {
        let str = NSStringFromClass(self)
//        debugPrint("str --------------------------> \(str)")
        let arr = str.components(separatedBy: ".")
        if let endIndex = arr.last {
//            debugPrint("endIndex --------------------------> \(endIndex)")
            let view = Bundle.main.loadNibNamed(endIndex, owner: nil, options: nil)?.last as! UIView
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
            return view
        }
        return nil
    }
    
}


// MARK: - 扩展UIView的Frame
extension UIView {
    
    var left: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var right: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.width
            self.frame = frame
        }
        get {
            return self.left + self.width
        }
    }
    
    
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    
    var top: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.height
            self.frame = frame
        }
        get {
            return self.top + self.height
        }
    }
    
    var centerY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height * 0.5
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height * 0.5
        }
    }
    
    var centerX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width * 0.5
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width * 0.5
        }
    }
    
    
    
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var safeArea: ConstraintBasicAttributesDSL {
        
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
    
    //    MARK:图片切圆角 左边
    /// 指定方向切圆角 - 左边
    ///
    /// - Parameters: 参数
    ///   - radius: 切的幅度
    ///   - direct: 方向 -
    ///   - fillColor: 填充色
    func viewClipCornerDirection(radius:CGFloat,fillColor:UIColor) {
        
        //
        let corners:UIRectCorner = [UIRectCorner.topLeft,UIRectCorner.bottomLeft]
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
        self.layer.mask = layer
        
        
    }
    
    func viewClipCornerDirection(radius:CGFloat,direct:clipCornerDirection,fillColor:UIColor = UIColor.white) {
        
        var corners:UIRectCorner = [UIRectCorner.topLeft]
        switch direct {
        case clipCornerDirection.topLeft:
            corners = [UIRectCorner.topLeft]
            break
        case clipCornerDirection.topRight:
            corners = [UIRectCorner.topRight]
            break
        case clipCornerDirection.bottomLeft:
            corners = [UIRectCorner.bottomLeft]
            break
        case clipCornerDirection.bottomRight:
            corners = [UIRectCorner.bottomRight]
            break
        case clipCornerDirection.left:
            corners = [UIRectCorner.topLeft, UIRectCorner.bottomLeft]
            break
        case clipCornerDirection.top:
            corners = [UIRectCorner.topLeft, UIRectCorner.topRight]
            break
        case clipCornerDirection.right:
            corners = [UIRectCorner.topRight, UIRectCorner.bottomRight]
            break
        case clipCornerDirection.bottom:
            corners = [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            break
            
        default:
            break
        }
        var tempBounds = bounds
        if bounds.width > bounds.height {
            tempBounds = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.width))
        }else {
            tempBounds = CGRect(origin: .zero, size: CGSize(width: bounds.height, height: bounds.height))
        }
        let path = UIBezierPath(roundedRect: tempBounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
        self.layer.mask = layer
        
    }
    
    
    /// 指定方向切圆角 - 右边
    ///
    /// - Parameters:
    ///   - radius: 切的幅度
    ///   - direct: 方向
    ///   - fillColor: 填充色
    func viewClipCornerDirectionRight(radius:CGFloat,direct:clipCornerDirection,fillColor:UIColor) {
        
        //
        let corners:UIRectCorner = [UIRectCorner.topRight,UIRectCorner.bottomRight]
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
        self.layer.mask = layer
        
        
    }
    
    /// 切圆角 - 需要先设置frame
    ///
    /// - Parameters:参数
    ///   - radius: 切的幅度 -》 四个角都切
    ///   - fillColor: 填充色
    func viewClipCorner(radius:CGFloat,fillColor:UIColor) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.fillColor = fillColor.cgColor
        self.layer.addSublayer(layer)
        self.layer.mask = layer
    }
    
    /// 切圆角(设置边角宽度) - 需要先设置frame
    ///
    /// - Parameters:
    ///   - radius: 幅度
    ///   - fillColor: 填充色 -》无填充色传ClearColor
    ///   - borderColor: 边角色
    ///   - borderWidth: 边角宽
    func viewClipCornerWithBorderColor(radius:CGFloat,fillColor:UIColor,borderColor:UIColor,borderWidth:CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = path.cgPath
        layer.lineCap = kCALineCapSquare
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = borderColor.cgColor
        layer.lineWidth = borderWidth
        self.layer.addSublayer(layer)
        //        self.layer.mask = layer
    }
    
}


// MARK: - 扩展UIImage
extension UIImage {
    //生成圆形图片
    func md_image2Circle() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    
    // MARK: 通过颜色创建一张图片
    /**
     Creates a new solid color image.
     - Parameter color: The color to fill the image with.
     - Parameter size: Image size (defaults: 10x10)
     - Returns A new image
     */
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
    
    ///对指定图片进行等比例拉伸
    func md_resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func md_compressImage(image: UIImage, maxLength: Int) -> NSData? {
        
        let newSize = self.md_scaleImage(image: image, imageLength: 300)
        let newImage = self.md_resizeImage(image: image, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(newImage!, compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage!, compress)
        }
        
        return data as! NSData
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  md_scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func md_resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func md_imageWithColorAndRadius(color: UIColor, radius: CGFloat) -> UIImage? {
        let size = CGSize(width: radius*2, height: radius*2)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let path = UIBezierPath.init(ovalIn: CGRect.init(origin: CGPoint.zero, size: size))
        color.set()
        path.fill()
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
}
// MARK: - 新增UIImage扩展
extension UIImage {
    
    func md_imageRotatedByDegrees(_ degrees: CGFloat) -> UIImage {
        let width: CGFloat = CGFloat((self.cgImage?.width)!)
        let height: CGFloat = CGFloat((self.cgImage?.height)!)
        let rotatedSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        bitmap.rotate(by: degrees * CGFloat.pi / 180)
        bitmap.rotate(by: CGFloat.pi)
        bitmap.scaleBy(x: -1.0, y: 1.0)
        bitmap.draw(self.cgImage!, in: CGRect(x: -rotatedSize.width/2, y: -rotatedSize.height/2, width: rotatedSize.width, height: rotatedSize.height))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func md_resizableImage(_ insets: UIEdgeInsets) -> UIImage {
        if (UIDevice.current.systemVersion as NSString).floatValue >= 6.0 {
            return self.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        }
        return self.stretchableImage(withLeftCapWidth: Int(insets.left), topCapHeight: Int(insets.top))
    }
    
    class func md_imageByScalingAndCroppingForSourceImage(_ sourceImage: UIImage, targetSize: CGSize) -> UIImage? {
        let imageSize: CGSize = sourceImage.size
        let width: CGFloat = imageSize.width
        let height: CGFloat = imageSize.height
        let targetWidth: CGFloat = targetSize.width
        let targetHeight: CGFloat = targetSize.height
        var scaleFactor: CGFloat = 0.0
        var scaledWidth: CGFloat = targetWidth
        var scaledHeight: CGFloat = targetHeight
        var thumbnailPoint: CGPoint = CGPoint.zero
        if imageSize.equalTo(targetSize) == false {
            let widthFactor: CGFloat = targetWidth/width
            let heightFactor: CGFloat = targetHeight/height
            if widthFactor > heightFactor {
                scaleFactor = widthFactor
                // scale to fit height
            } else {
                scaleFactor = heightFactor
                
            }
            // scale to fit width
            scaledWidth = width*scaleFactor
            scaledHeight = height*scaleFactor
            // center the image
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight-scaledHeight)*0.5
            } else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth-scaledWidth)*0.5
            }
        }
        UIGraphicsBeginImageContext(targetSize)
        // this will crop
        var thumbnailRect: CGRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        sourceImage.draw(in: thumbnailRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //pop the context to get back to the default
        UIGraphicsEndImageContext()
        return newImage
    }
    
    class func md_imageWithColor(_ color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(image, 1.0)! as NSData
        image = UIImage(data: imageData as Data)!
        return image
    }
    
    func md_imageByResizeToScale(_ scale: CGFloat) -> UIImage? {
        let size: CGSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height)))
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func md_imageByResizeWithMaxSize(_ size: CGSize) -> UIImage? {
        var resize: CGSize = self.size
        if resize.width > size.width {
            resize = CGSize(width: size.width, height: size.width/resize.width*resize.height)
        }
        if resize.height > size.height {
            resize = CGSize(width: size.height/resize.height*resize.width, height: size.height)
        }
        if resize.width <= 0 || resize.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(resize, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: resize.width, height: resize.height)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func md_imageWithThumbnailForSize(_ size: CGSize) -> UIImage? {
        var imageSize: CGSize = self.size
        if imageSize.width < imageSize.height {
            imageSize = CGSize(width: size.width, height: size.width/imageSize.width*imageSize.height)
        } else {
            imageSize = CGSize(width: size.height/imageSize.height*imageSize.width, height: size.height)
            
        }
        if imageSize.width <= 0 || imageSize.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(imageSize, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: imageSize.width, height: imageSize.height)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func md_imageByCropToRect(_ rect: inout CGRect) -> UIImage? {
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale
        if rect.size.width <= 0 || rect.size.height <= 0 {
            return nil
        }
        let imageRef = self.cgImage?.cropping(to: rect)
        if imageRef == nil {
            return nil
        }
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        //        CGImageRelease(imageRef!)
        return image
    }
    
    func md_imageByRoundCornerRadius(_ radius: CGFloat) -> UIImage? {
        return self.md_imageByRoundCornerRadius(radius, borderWidth: 0, borderColor: nil)
    }
    
    func md_imageByRoundCornerRadius(_ radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) -> UIImage? {
        return self.md_imageByRoundCornerRadius(radius, corners: .allCorners, borderWidth: borderWidth, borderColor: borderColor!, borderLineJoin: .miter)
    }
    
    func md_imageByRoundCornerRadius(_ radius: CGFloat, corners: UIRectCorner, borderWidth: CGFloat, borderColor: UIColor?, borderLineJoin: CGLineJoin) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        let rect: CGRect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.size.height)
        let minSize: CGFloat = CGFloat.minimum(self.size.width, self.size.height)
        
        if borderWidth < minSize/2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: borderWidth))
            path.close()
            context.saveGState()
            path.addClip()
            context.draw(self.cgImage!, in: rect)
            //            CGContextDrawImage(context, rect, self.cgImage)
            context.restoreGState()
        }
        if let _ = borderColor, borderWidth < minSize/2 && borderWidth > 0 {
            let strokeInset: CGFloat = (floor(borderWidth*self.scale)+0.5)/self.scale
            let strokeRect: CGRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius: CGFloat = radius > self.scale/2 ? radius-self.scale/2 : 0
            let path: UIBezierPath = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius,  height: borderWidth))
            path.close()
            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            //            borderColor.stroke = null
            path.stroke()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func md__yy_flipHorizontal(_ horizontal: Bool, vertical: Bool) -> UIImage? {
        if (self.cgImage == nil) {
            return nil
        }
        let width: Int = (self.cgImage?.width)!
        let height: Int = (self.cgImage?.height)!
        let bytesPerRow: Int = width*4
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrderMask.rawValue)
        
        //        CGColorSpaceRelease(colorSpace)
        if (context == nil) {
            return nil
        }
        context?.draw(self.cgImage!, in: CGRect(origin: .zero, size: CGSize(width: CGFloat(width), height: CGFloat(height))))
        var data = context?.bitmapInfo.rawValue
        if data == nil {
            //            CGContextRelease(context!)
            return nil
        }
        var src = vImage_Buffer(data: &data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        var dest = vImage_Buffer(data: &data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        if vertical {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        if horizontal {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill))
        }
        let imgRef = context?.makeImage()
        if imgRef == nil {
            return nil
        }
        //        CGContextRelease(context!)
        let img = UIImage(cgImage: imgRef!, scale: self.scale, orientation: self.imageOrientation)
        //        CGImageRelease(imgRef)
        return img
    }
    
    func md_imageByRotate180() -> UIImage? {
        return self.md__yy_flipHorizontal(true, vertical: true)
    }
    
    func md_imageByFlipVertical() -> UIImage? {
        return self.md__yy_flipHorizontal(false, vertical: true)
    }
    
    func md_imageByFlipHorizontal() -> UIImage? {
        return self.md__yy_flipHorizontal(true, vertical: false)
    }
    
    internal static func md_degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat.pi / 180
    }
    
}

// MARK: - 扩展UIButton
extension UIButton {
    
    //在分类中 需要使用便利的构造方法  有可能实例化一个空对象
    //就是在指定的构造行数基础上  对其进行扩展
    //必须调用指定的构造函数  调用方式  self.
    //相对于 指定的构造方法
    //构造方法最大的一个特点 没有返回值
    
    //构造器
    convenience init(title: String?,backImage: String?,color: UIColor?,image: String = "",size: CGFloat = 14) {
        
        //调用构造方法 实例化
        self.init()
        if title != nil {
            setTitle(title!, for: .normal)
        }
        
        if backImage != nil {
            setBackgroundImage(UIImage(named: backImage!), for: .normal)
            setBackgroundImage(UIImage(named: backImage! + "_highlighted"), for: .highlighted)
        }
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        setImage(UIImage(named: image), for: .normal)
        
        if color != nil {
            setTitleColor(color, for: .normal)
        }
        
    }
    
    /// 标记当前角标是否显示
    var md_badgeLabelIsHidden: Bool {
        get {
            var temp = true
            if let views = superview?.subviews {
                for item in views {
                    if item.tag == 10001 {
                        temp = item.isHidden
                    }
                }
            }
            return temp
        }
        set {
            if let views = superview?.subviews {
                for item in views {
                    if item.tag == 10001 {
                        item.isHidden = newValue
                    }
                }
            }
        }
    }
    
    /// 设置角标的个数（右上角）
    ///
    /// - Parameter value: 角标数字
    func md_setBadgeWithValue(value: Int, isHidden: Bool = false) {
        let badgeW: CGFloat   = 20;
        let imageSize = self.imageView?.frame.size;
        let imageX   = self.imageView?.frame.origin.x;
        let imageY   = self.imageView?.frame.origin.y;
        
        if let views = superview?.subviews {
            var tempView: UILabel?
            for item in views {
                if item.tag == 10001, let lbl = item as? UILabel {
                    tempView = lbl
                    break
                }
            }
            if let tempV = tempView {
                if isHidden {
                    tempV.isHidden = isHidden
                }else {
                    tempV.text = "\(value)"
                }
            }else {
                if value > 0 {
                    let badgeLable = UILabel()
                    badgeLable.tag = 10001
                    badgeLable.text = "\(value)"
                    badgeLable.textAlignment = .center
                    badgeLable.textColor = UIColor.white
                    badgeLable.font = UIFont.systemFont(ofSize: 12)
                    badgeLable.layer.cornerRadius = badgeW * 0.5;
                    badgeLable.clipsToBounds = true
                    badgeLable.backgroundColor = UIColor.red
                    
                    let badgeX = imageX! + (imageSize?.width)! - badgeW * 0.5;
                    let badgeY = imageY! - badgeW * 0.25;
                    
                    self.superview?.addSubview(badgeLable)
                    badgeLable.snp.makeConstraints { (make) in
                        make.centerX.equalTo(self.snp.right)
                        make.centerY.equalTo(self.snp.top)
                        make.width.height.equalTo(badgeW)
                    }
                }
            }
        }
        
        
        
    }
}


// MARK: - 扩展UILabel
extension UILabel {
    
    //1.>文字
    //2.>文字大小
    //3.>文字的颜色
    
    //参数指定默认值  该参数 可以不传
    convenience init(title: String,size: CGFloat,color: UIColor,margin: CGFloat = 0) {
        self.init()
        text = title
        textAlignment = NSTextAlignment.center
        font = UIFont.systemFont(ofSize: size)
        textColor = color
        numberOfLines = 0
        if margin != 0 {
            preferredMaxLayoutWidth = SCREEN_WIDTH - 2 * margin
            textAlignment = .left
        }
        //设置大小
        sizeToFit()
    }
    
    /// 通过Label计算字符串高度
    ///
    /// - Parameters:
    ///   - str: 字符串
    ///   - width: 最大宽度
    ///   - fontSize: 字体大小
    /// - Returns: 高度
    static func heightForString(str: String, maxWidth width: CGFloat, fontSize: CGFloat) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = str
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let contentHeight = size.height
        return contentHeight
    }
    
    /// 通过Label计算字符串宽度
    ///
    /// - Parameters:
    ///   - str: 字符串
    ///   - width: 最大宽度
    ///   - fontSize: 字体大小
    /// - Returns: 高度
    static func widthForString(str: String, maxWidth width: CGFloat, fontSize: CGFloat) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = str
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let contentHeight = size.height
        return contentHeight
    }
}

// MARK: - 扩展UITableView
extension UITableView {
    
    /// 左侧飞入
    func md_moveAnimation() {
        let cells = self.visibleCells
        for i in 0..<cells.count {
            let totalTime: TimeInterval = 0.4
            let cell: UITableViewCell = self.visibleCells[i]
            cell.transform = CGAffineTransform(translationX: -SCREEN_WIDTH, y: 0)
            UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*(totalTime/TimeInterval(cells.count)), usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: .curveEaseIn, animations: {
                cell.transform = .identity
            })
        }
    }
    
    /// 透明度
    func md_alphaAnimation() {
        let cells = self.visibleCells
        for i in 0..<cells.count {
            let cell: UITableViewCell = self.visibleCells[i]
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.3, delay: TimeInterval(i)*0.05, options: UIViewAnimationOptions(rawValue: 0), animations: {
                cell.alpha = 1.0
            })
        }
    }
    
    /// 从上面掉落
    func md_fallAnimation() {
        let cells = self.visibleCells
        let totalTime: TimeInterval = 0.8
        for i in 0..<cells.count {
            let cell: UITableViewCell = self.visibleCells[i]
            cell.transform = CGAffineTransform(translationX: 0, y: -SCREEN_HEIGHT)
            UIView.animate(withDuration: 0.3, delay: TimeInterval(cells.count-i)*(totalTime/TimeInterval(cells.count)), options: UIViewAnimationOptions(rawValue: 0), animations: {
                cell.transform = .identity
            })
        }
    }
    
    /// 抖动
    func md_shakeAnimation() {
        var cells = self.visibleCells
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            if i%2 == 0 {
                cell.transform = CGAffineTransform(translationX: -SCREEN_WIDTH, y: 0)
            } else {
                cell.transform = CGAffineTransform(translationX: SCREEN_WIDTH, y: 0)
                
            }
            UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*0.03, usingSpringWithDamping: 0.75, initialSpringVelocity: 1/0.75, options: UIViewAnimationOptions(rawValue: 0), animations: {
                cell.transform = .identity
            })
        }
    }
    
    /// 翻转
    func md_overTurnAnimation() {
        var cells = self.visibleCells
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            cell.layer.opacity = 0.0
            cell.layer.transform = CATransform3DMakeRotation(.pi, 1, 0, 0)
            let totalTime: TimeInterval = 0.7
            UIView.animate(withDuration: 0.3, delay: TimeInterval(i)*(totalTime/TimeInterval(cells.count)), options: UIViewAnimationOptions(rawValue: 0), animations: {    cell.layer.opacity = 1.0
                cell.layer.transform = CATransform3DIdentity
                
            })
        }
    }
    
    /// 从下往上
    func md_toTopAnimation() {
        let cells = self.visibleCells
        let totalTime: TimeInterval = 0.8
        for i in 0..<cells.count {
            let cell: UITableViewCell = self.visibleCells[i]
            cell.transform = CGAffineTransform(translationX: 0, y: SCREEN_HEIGHT)
            UIView.animate(withDuration: 0.35, delay: TimeInterval(i)*(totalTime/TimeInterval(cells.count)), options: .curveEaseIn, animations: {
                cell.transform = .identity
            })
        }
    }
    
    /// 从上往下弹动
    func md_springListAnimation() {
        var cells = self.visibleCells
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            cell.layer.opacity = 0.7
            cell.layer.transform = CATransform3DMakeTranslation(0, -SCREEN_HEIGHT, 20)
            let totalTime: TimeInterval = 1.0
            UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*(totalTime/TimeInterval(cells.count)), usingSpringWithDamping: 0.65, initialSpringVelocity: 1/0.65, options: .curveEaseIn, animations: {
                cell.layer.opacity = 1.0
                cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20)
            })
        }
    }
    
    /// 从下往上挤到顶部
    func md_shrinkToTopAnimation() {
        var cells = self.visibleCells
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            let rect: CGRect = cell.convert(cell.bounds, from: self)
            cell.transform = CGAffineTransform(translationX: 0, y: -rect.origin.y)
            UIView.animate(withDuration: 0.5, animations: {
                cell.transform = .identity
            })
        }
    }
    
    /// 从上往下展开
    func md_layDownAnimation() {
        var cells = self.visibleCells
        let rectArr: NSMutableArray = NSMutableArray()
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            var rect: CGRect = cell.frame
            rectArr.add(NSValue(cgRect: rect))
            rect.origin.y = CGFloat(i*10)
            cell.frame = rect
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, CGFloat(i*5))
        }
        let totalTime: TimeInterval = 0.8
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            let rect: CGRect = (rectArr[i] as AnyObject).cgRectValue
            UIView.animate(withDuration: (totalTime/TimeInterval(cells.count))*TimeInterval(i), animations: {
                cell.frame = rect
            })
        }
    }
    
    /// 旋转
    func md_roteAnimation() {
        var cells = self.visibleCells
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.fromValue = -Double.pi
        animation.toValue = 0
        animation.duration = 0.3
        animation.isRemovedOnCompletion = false
        animation.repeatCount = 3
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        for i in 0..<cells.count {
            let cell: UITableViewCell = cells[i]
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.1, delay: TimeInterval(i)*0.25, options: UIViewAnimationOptions(rawValue: 0), animations: {
                cell.alpha = 1.0
            })
        }
    }
    
}
// MARK: - 扩展UITextField
extension UITextField {
    
    /// 光标向右移动一个距离
    ///
    /// - Parameter distance: 移动的距离
    func changeCursorLeftDistance(distance: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: distance, height: 10))
        self.leftViewMode = .always
    }
    
    /// 光标向右移动一个距离
    ///
    /// - Parameter distance: 移动的距离
    func changeCursorRightDistance(distance: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: distance, height: 10))
        self.rightViewMode = .always
    }
    
    var verificationCode: Bool? {
        set {
            if let v = verificationCode, v {
//                let lb = UILabel(title: "发送验证码          ", size: 14, color: UIColor(rgba: "#0026FF"))
                let btn = UIButton(title: "发送验证码          ", backImage: nil, color: UIColor(rgba: "#0026FF"), image: "", size: 14)
                btn.sizeToFit()
                self.rightView = btn
                self.rightViewMode = .always
            }
        }
        get {
            return true
        }
    }
    
}
// MARK: - 扩展UISegmentedControl - 修改系统UISegmentedControl样式
extension UISegmentedControl {

    var fontSize: CGFloat {
        get {
            return 14
        }
        set {
            let attr = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: newValue)]
            self.setTitleTextAttributes(attr, for: .normal)
            self.setTitleTextAttributes(attr, for: .selected)
        }
    }
    
    var selectedTitleColor: UIColor {
        get {
            return UIColor.white
        }
        set {
            let attr = [NSAttributedStringKey.foregroundColor : newValue]
            self.setTitleTextAttributes(attr, for: .selected)
        }
    }
    
    var normalTitleColor: UIColor {
        get {
            return UIColor.init(rgba: "#333333")
        }
        set {
            let attr = [NSAttributedStringKey.foregroundColor : newValue]
            self.setTitleTextAttributes(attr, for: .normal)
        }
    }
    var selectedBgColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            let attr = [NSAttributedStringKey.backgroundColor : newValue]
            self.setTitleTextAttributes(attr, for: .selected)
        }
    }
    
    var normalBgColor: UIColor {
        get {
            return UIColor.white
        }
        set {
            let attr = [NSAttributedStringKey.backgroundColor : newValue]
            self.setTitleTextAttributes(attr, for: .normal)
        }
    }
    
    /// 自定义样式
    ///
    /// - Parameters:
    ///   - normalColor: 普通状态下背景色
    ///   - selectedColor: 选中状态下背景色
    ///   - dividerColor: 选项之间的分割线颜色
    func setSegmentStyle(normalColor: UIColor, selectedColor: UIColor, dividerColor: UIColor) {
        
        let normalColorImage = UIImage.md_imageWithColor(normalColor)
        let selectedColorImage = UIImage.md_imageWithColor(selectedColor)
        let dividerColorImage = UIImage.md_imageWithColor(dividerColor)
        
        setBackgroundImage(normalColorImage, for: .normal, barMetrics: .default)
        setBackgroundImage(selectedColorImage, for: .selected, barMetrics: .default)
        setDividerImage(dividerColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let segAttributesNormal: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor(rgba: "#333333"), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let segAttributesSeleted: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        
        // 文字在两种状态下的颜色
        setTitleTextAttributes(segAttributesNormal as [NSObject : AnyObject], for: UIControlState.normal)
        setTitleTextAttributes(segAttributesSeleted as [NSObject : AnyObject], for: UIControlState.selected)
        
        // 边界颜色、圆角
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 0.0
        self.layer.borderColor = dividerColor.cgColor
        self.layer.masksToBounds = true
    }
}
extension UITextView {
    
    /// 扩展替换文本
    var md_placeholder: String {
        get {return ""}
        set {
            //设置UITextView的提示文本
            let placeh = QYTools.md_placeHolderLabel(text: newValue)
            self.addSubview(placeh)
            self.setValue(placeh, forKeyPath: "_placeholderLabel")
        }
    }
}
