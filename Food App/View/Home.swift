//
//  Home.swift
//  Food App
//
//  Created by Mohsen Abdollahi on 11/14/20.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        //Action
                        print("Button Tapped!")
                    } , label : {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.pink)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..."  :  "Deliver To").foregroundColor(.black)
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.pink)
                    
                    Spacer(minLength: 0)
                }.padding([.horizontal,.top])
                
                Divider()
                HStack(spacing: 15) {
                    TextField("Search", text: $HomeModel.search)
                    if HomeModel.search != "" {
                        Button(action: {
                            //Action
                            print("Search button Tapped!")
                        }, label : {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(Color.gray)
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                Divider()
                
                Spacer()
            }//: VStack
            
            if HomeModel.noLocation {
                Text("Please Enable Location Access In Settings To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }

        }//: ZStack
        
        .onAppear(perform: {
            //Calling Location Delegate...
            HomeModel.locationManager.delegate = HomeModel
            // Modifying Info pList
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
