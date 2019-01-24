//
//  FGConverter.swift
//  FGConverterDemo
//
//  Created by 风过的夏 on 16/9/11.
//  Copyright © 2016年 风过的夏. All rights reserved.
//  http://cgpointzero.top
/*
```
 .................................
 let string="恭喜发财"
 let result=string.reverseString()
 print(result)
 .................................
 ->
 "恭喜發財"
```
*/
import Foundation

extension String{
    
    public func reverseString()->String?{
        
        let mapPath=Bundle.main.path(forResource: "reverse", ofType: nil)
        let map:Dictionary<String,String>?=NSDictionary(contentsOfFile: mapPath!) as! Dictionary?
        let reverseString:NSMutableString=NSMutableString(string: self)
        let resultString=NSMutableString()
        for i in 0..<reverseString.length{
            
            let chactor=reverseString.character(at: i)
            let key=String.init(format: "%C", chactor)
            let value=map?[key]
            if value != nil{
                resultString .append(value!)
                reverseString.replacingCharacters(in: NSMakeRange(i, 1), with: value!)
            }else{
                resultString.append(key)
            }
        }
        return resultString as String
    }
}
