//
//  Temp.swift
//  LT
//
//  Created by Modi on 2018/6/28.
//  Copyright © 2018年 Modi. All rights reserved.
//

//import UIImage+Category
import QuartzCore
import Accelerate
import CoreGraphics
import CoreImage
// #define ORIGINAL_MAX_WIDTH 640.0f
// #define YY_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)

// MARK: - UIImage + blur
/*
extension UIImage {
    
    /*
    func imageByBlurSoft() -> UIImage {
        return self.imageByBlurRadius(60, tintColor: UIColor(white: 0.84, alpha: 0.36), tintMode: kCGBlendModeNormal, saturation: 1.8, maskImage: nil)
    }
    
    func imageByBlurLight() -> UIImage {
        return self.imageByBlurRadius(60, tintColor: UIColor(white: 1.0, alpha: 0.3), tintMode: kCGBlendModeNormal, saturation: 1.8, maskImage: nil)
    }
    
    func imageByBlurExtraLight() -> UIImage {
        return self.imageByBlurRadius(40, tintColor: UIColor(white: 0.97, alpha: 0.82), tintMode: kCGBlendModeNormal, saturation: 1.8, maskImage: nil)
    }
    
    func imageByBlurDark() -> UIImage {
        return self.imageByBlurRadius(40, tintColor: UIColor(white: 0.11, alpha: 0.73), tintMode: kCGBlendModeNormal, saturation: 1.8, maskImage: nil)
    }
    
    func imageByBlurWithTint(_ tintColor: UIColor) -> UIImage {
        var EffectColorAlpha: const CGFloat = 0.6
        var effectColor: UIColor = tintColor
        var componentCount: Int = CGColorGetNumberOfComponents(tintColor.CGColor)
        if componentCount == 2 {
            var b: CGFloat
            if tintColor.getWhite(&b, alpha: nil) {
                effectColor = UIColor(white: b, alpha: EffectColorAlpha)
            }
        } else {
            var r: CGFloat
            var g: CGFloat
            var b: CGFloat
            if tintColor.getRed(&r, green: &g, blue: &b, alpha: nil) {
                effectColor = UIColor(red: r, green: g, blue: b, alpha: EffectColorAlpha)
            }
            
        }
        return self.imageByBlurRadius(20, tintColor: effectColor, tintMode: kCGBlendModeNormal, saturation: -1.0, maskImage: nil)
    }
 */
    
    func imageByBlurRadius(_ blurRadius: CGFloat, tintColor: UIColor, tintMode tintBlendMode: CGBlendMode, saturation: CGFloat, maskImage: UIImage?) -> UIImage? {
        if self.size.width < 1 || self.size.height < 1 {
            print(String(format: "UIImage+YYAdd error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width,self.size.height,self))
            return nil
        }
        if self.cgImage == nil {
            print("UIImage+YYAdd error: inputImage must be backed by a CGImage: \(self)")
            return nil
        }
        if (maskImage != nil) && maskImage?.cgImage == nil {
            print("UIImage+YYAdd error: effectMaskImage must be backed by a CGImage: \(maskImage)")
            return nil
        }
        // iOS7 and above can use new func.
//        var hasNewFunc: Bool = vImageBuffer_InitWithCGImage != 0 && (vImageCreateCGImageFromBuffer) != 0
        var hasNewFunc = true
        var hasBlur: Bool = blurRadius > CGFloat(FLT_EPSILON)
        var hasSaturation: Bool = fabs(saturation-1.0) > CGFloat(FLT_EPSILON)
        var size: CGSize = self.size
        var rect: CGRect = CGRect(origin: .zero, size: size)
        var scale: CGFloat = self.scale
        var imageRef: CGImage = self.cgImage!
        var opaque: Bool = false
        if !hasBlur && !hasSaturation {
//            return self._yy_mergeImageRef(imageRef, tintColor: tintColor, tintBlendMode: tintBlendMode, maskImage: maskImage, opaque: opaque)
            return nil
        }
        var effect: vImage_Buffer = vImage_Buffer(), scratch = vImage_Buffer()
        var input: vImage_Buffer?, output: vImage_Buffer?
        var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: CGBitmapInfo(rawValue: CGBitmapInfo.RawValue(UInt8(CGBitmapInfo.byteOrderMask.rawValue) | UInt8(CGImageAlphaInfo.premultipliedFirst.rawValue))), version: 0, decode: nil, renderingIntent: .defaultIntent)
        if hasNewFunc {
            var err: vImage_Error
            err = vImageBuffer_InitWithCGImage(&effect, &format, nil, imageRef, vImage_Flags(kvImagePrintDiagnosticsToConsole))
            if err != kvImageNoError {
                print("UIImage+YYAdd error: vImageBuffer_InitWithCGImage returned error code \(err) for inputImage: \(self)")
                return nil
            }
            err = vImageBuffer_Init(&scratch, effect.height, effect.width, format.bitsPerPixel, vImage_Flags(kvImageNoFlags))
            if err != kvImageNoError {
                print("UIImage+YYAdd error: vImageBuffer_Init returned error code \(err) for inputImage: \(self)")
                return nil
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
            var effectCtx: CGContext = UIGraphicsGetCurrentContext()!
            effectCtx.scaleBy(x: 1.0, y: -1.0)
            effectCtx.translateBy(x: 0, y: -size.height)
            effectCtx.draw(imageRef, in: rect)
            
            effect.data = effectCtx.data
            effect.width = vImagePixelCount(effectCtx.width)
            effect.height = vImagePixelCount(effectCtx.height)
            effect.rowBytes = effectCtx.bytesPerRow
            
            UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
            
            var scratchCtx: CGContext = UIGraphicsGetCurrentContext()!
            
            scratch.data = scratchCtx.data
            scratch.width = vImagePixelCount(scratchCtx.width)
            scratch.height = vImagePixelCount(scratchCtx.height)
            scratch.rowBytes = scratchCtx.bytesPerRow
            
        }
        input = effect
        output = scratch
        if hasBlur {
            var inputRadius: CGFloat = blurRadius*scale
            if inputRadius-2.0 < CGFloat(FLT_EPSILON) {
                inputRadius = 2.0
            }
            var tmp = (inputRadius*3.0) * CGFloat(sqrt(2*M_PI))
            var tmp1 = (tmp/4 + 0.5) / 2
            var radius: UInt32 = UInt32(floor(tmp1))
            radius |= 1
            // force radius to be odd so that the three box-blur methodology works.
            var iterations: Int32
            if blurRadius*scale < 0.5 {
                iterations = 1
            } else if blurRadius*scale < 1.5 {
                iterations = 2
            } else {
                iterations = 3

            }
            var tempSize: Int = vImageBoxConvolve_ARGB8888(&input!, &output!, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageGetTempBufferSize|kvImageEdgeExtend))
            var temp = malloc(tempSize)
            
            for i in 0..<iterations {
                vImageBoxConvolve_ARGB8888(&input!, &output!, temp, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
//                YY_SWAP(input, output)
            }
            free(temp)
        }
        if hasSaturation {
            // These values appear in the W3C Filter Effects spec:
            // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/Publish.html#grayscaleEquivalent
            var s: CGFloat = saturation
            var matrixFloat: CGFloat = {
                var divisor: const; int32_t = 256
                var matrixSize: UInt = sizeof((matrixFloat))/sizeof((matrixFloat[0]))
                var matrix: Int16
                for var i: UInt = 0 ; i < matrixSize ; ++i {
                    matrix[i] = Int16(roundf(matrixFloat[i]*divisor))
                }
                vImageMatrixMultiply_ARGB8888(input, output, matrix, divisor, nil, nil, kvImageNoFlags)
                YY_SWAP(input, output)
            }
            var outputImage: UIImage? = nil
            if hasNewFunc {
                var effectCGImage: CGImage? = nil
                effectCGImage = vImageCreateCGImageFromBuffer(input, &format, &_yy_cleanupBuffer, nil, kvImageNoAllocate, nil)
                if effectCGImage == nil {
                    effectCGImage = vImageCreateCGImageFromBuffer(input, &format, nil, nil, kvImageNoFlags, nil)
                    free(input?.data)
                }
                free(output?.data)
                outputImage = self._yy_mergeImageRef(effectCGImage, tintColor: tintColor, tintBlendMode: tintBlendMode, maskImage: maskImage, opaque: opaque)
                CGImageRelease(effectCGImage)
            } else {
                var effectCGImage: CGImage
                var effectImage: UIImage
                if input != &effect {
                    effectImage = UIGraphicsGetImageFromCurrentImageContext()!
                }
                UIGraphicsEndImageContext()
                if input == &effect {
                    effectImage = UIGraphicsGetImageFromCurrentImageContext()!
                }
                UIGraphicsEndImageContext()
                effectCGImage = effectImage.CGImage!
                outputImage = self._yy_mergeImageRef(effectCGImage, tintColor: tintColor, tintBlendMode: tintBlendMode, maskImage: maskImage, opaque: opaque)

            }
            return outputImage
        }
    }
}

*/

