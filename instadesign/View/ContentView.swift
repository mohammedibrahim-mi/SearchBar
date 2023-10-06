//
//  ContentView.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var popUpView : Bool = false
    @State private var crypto : String = ""   
    @State private var cryptoName : String = ""
    @State private var cryptoDropDown :  Bool = false
    @State private var cryptoClear : String = ""

    @StateObject private var cryptoCurrencyObj = CryptoCurrenciesViewModel()
    
    
    var cryptoFilter : [CryptoCurrenciesDatum] {
        cryptoClear.isEmpty ? cryptoCurrencyObj.cryptoCurrenciesObj : cryptoCurrencyObj.cryptoCurrenciesObj.filter { $0.name.localizedCaseInsensitiveContains(cryptoClear) || $0.slug.localizedCaseInsensitiveContains(cryptoClear) }
    }
    
    var body: some View {
        
        VStack{
           
            Button(action: {
                
                withAnimation {
                    self.popUpView = true
                }
                
            }, label: {
                
                Image(systemName: "lock")
                    .frame(width: 40 , height: 40)
                    .background(
                        Circle()
                            .stroke(Color("BorderGray") , lineWidth: 1))
                    .background(Color.white)
                    .clipShape(Circle())
            })
            
        }
        .bottomSheet(isPresented: $popUpView ){
            VStack{
                
                HStack{
                    
                    Text("Search")
                    
                    Button(action: {
                        
                        withAnimation {
                            
                            self.popUpView = false
                          
                            
                        }
                    
                        
                        
                    }, label: {
                        
                        Image(systemName: "lock")
                        
                    })
                }
                
                HStack(spacing: 8){
                    
                    AsyncImage(url: URL(string: cryptoCurrencyObj.cryptoImg)){
                        
                        image in
                        
                        image
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .clipShape(Circle())
                            .opacity(self.crypto.isEmpty ? 0.5 : 1)
                        
                    } placeholder: {
                        
                        ProgressView()
                            .frame(width: 20 , height: 20)
                        
                        
                    }
                    
                  self.crypto.isEmpty ?
                    
                    HStack(spacing: 0){
                        
                        Text("\(cryptoCurrencyObj.crypto) - ")
                          //  .foregroundColor(Color("DarkGray").opacity(0.5))
                        
                        Text("\(cryptoCurrencyObj.cryptoName)")
                        //    .foregroundColor(Color("LightGray").opacity(0.5))
                        
                    }
                    .font(.custom("Inter-Regular", size: 16))
                    
                    :
                    
                    HStack(spacing: 0){
                        
                        Text("\(crypto) - ")
                        //    .foregroundColor(Color("DarkGray"))
                        
                        Text("\(cryptoName)")
                          //  .foregroundColor(Color("LightGray").opacity(0.6))
                        
                    }
                    .font(.custom("Inter-Regular", size: 16))
                    
                    
                    Spacer()
                    
                    Image(cryptoDropDown ? "shrink-up" : "drop-down")
                        .padding(.trailing , 5)
                }
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .padding([.leading ,.trailing] , 15)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("BorderGray") , lineWidth: 1))
                .background(Color.white)
                .onTapGesture{
                    
                    self.cryptoDropDown.toggle()
                    
                    
                }
              
                
                ZStack{
                    if cryptoDropDown {
                        
                        
                        VStack{
                            
                            SearchBar(text: $cryptoClear , isClear: $cryptoDropDown)
                                .onTapGesture{
                                    self.cryptoDropDown = true
                                    
                                }
                            List{
                                
                                ForEach(cryptoFilter , id: \.id){
                                    
                                    item in
                                    
                                    Button(action: {
                                        
                                     //   self.cryptoId = String(item.id)
                                        self.crypto = item.slug
                                        self.cryptoName = item.name
                                        self.cryptoCurrencyObj.cryptoImg = item.logo
                                        self.cryptoDropDown = false
                                        
                                    }, label: {
                                        
//                                            VStack{
//
//                                                Divider()
                                            
                                            HStack(spacing: 8){
                                                
                                                AsyncImage(url: URL(string: item.logo)){
                                                    
                                                    image in
                                                    
                                                    image
                                                        .resizable()
                                                        .frame(width: 20 , height: 20)
                                                        .clipShape(Circle())
                                                    
                                                } placeholder: {
                                                    
                                                    ProgressView()
                                                        .frame(width: 20 , height: 20)
                                                    
                                                    
                                                }
                                                
                                                Text("\(item.slug)")
                                                    .font(.custom("Inter-Regular", size: 16))
                                                   // .foregroundColor(Color("DarkGray"))
                                                
                                                Text("- \(item.name)")
                                                    .font(.custom("Inter-Regular", size: 16))
                                                   // .foregroundColor(Color("LightGray").opacity(0.6))
                                                
                                                Spacer()
                                                
                                            }
                                            .padding([.top , .bottom] , 8)
//                                            }
//                                            .background( TransparentBlurView(removeAllFilters: true)
//                                                .blur(radius: 10 , opaque: true)
//                                                .background(Color("AlertBgColor")))
//
                                        
                                    })
                                    .listRowBackground( TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 10 , opaque: true)
                                        .background(Color("AlertBgColor"))
                                        .opacity(0.1))
                                    
                              
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                        .padding( .top , 20)
                        .padding([.leading , .trailing], 10)
                        .frame(height: 350)
                        .background( TransparentBlurView(removeAllFilters: true)
                            .blur(radius: 10 , opaque: true)
                            .background(Color("AlertBgColor"))
                            .opacity(0.9))
                        .cornerRadius(24)
                        .padding([.leading , .trailing] , 15)
                        
                    }
                }
                
                
            }
        }
        .onAppear{
            cryptoCurrencyObj.crytoCurrenciesFunc()
        }
        
//        ScrollView{
//            VStack{
//                HStack{
//                    Image(systemName: "lock")
//                    Spacer()
//                    Text("Instagram")
//                    Spacer()
//
//                    Image(systemName: "lock")
//                }
//                ScrollView(.horizontal){
//                    HStack{
//                        ForEach(1..<9){i in
//                            
//                            
//                            
//                            Image("Image")
//                                .resizable()
//                                .frame(width: 70, height: 70)
//                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                                .overlay{
//                                    Circle()
//                                        .stroke(Color.yellow,lineWidth: 4)
//                                }
//                        }
//                    }
//                  
//                }
//                VStack{
//                    HStack{
//                        Image("Image")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                            .overlay{
//                                Circle()
//                                    .stroke(Color.yellow,lineWidth: 1)
//                            }
//                        Spacer()
//                        Text("Dhoni")
//                        Spacer()
//                        Text("...")
//                    }
//                    ForEach(1..<10){ i in
//                        
//                        Image("Image")
//                            .resizable()
//                            .frame(maxWidth: .infinity)
//                            .frame(height:300)
//                          
//                           
//                        
//                    }
//                }
//                
//            }
//            .padding(10)
//        }
        
    }
}

#Preview {
    ContentView()
}
