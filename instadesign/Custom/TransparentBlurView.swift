//
//  TransparentBlurView.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

import SwiftUI


struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> TransparentBlurViewHelper {
        return TransparentBlurViewHelper(removeAllFilters: removeAllFilters)
    }
    
    func updateUIView(_ uiView: TransparentBlurViewHelper, context: Context) {
        
    }
}

class TransparentBlurViewHelper: UIVisualEffectView {
    init(removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        if subviews.indices.contains(1) {
            subviews[1].alpha = 0
        }
        
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else {
         
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
}
