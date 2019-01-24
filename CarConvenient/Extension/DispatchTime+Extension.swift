//
//  DispatchTime+Extension.swift
//  videoDemo
//
//  Created by 微标杆 on 2018/6/25.
//  Copyright © 2018年 微标杆. All rights reserved.
//

import Foundation

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}

