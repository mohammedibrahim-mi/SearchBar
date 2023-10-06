//
//  bottomsheet.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

//

import SwiftUI

extension View {
    func bottomSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack(alignment: .bottom) {
            self
            if isPresented.wrappedValue {
                TransparentBlurView(removeAllFilters: true)
                    .blur(radius: 10 , opaque: true)
                    .background(Color("GlassBgColor"))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented.wrappedValue = false
                        }
                    }
                content()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    
                    .cornerRadius(10)
                    .zIndex(1)
                   // .ignoresSafeArea(.keyboard)
                    .offset(y: isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height)
            }
        }
        
    }
}
