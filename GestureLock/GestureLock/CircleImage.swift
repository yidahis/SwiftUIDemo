//
//  CircleImage.swift
//  GestureLock
//
//  Created by yidahis on 2020/1/29.
//  Copyright © 2020 fame.inc. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("dae21")
        .clipShape(Circle())
            .overlay(Circle().stroke(Color.red, lineWidth: 5))
        .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
