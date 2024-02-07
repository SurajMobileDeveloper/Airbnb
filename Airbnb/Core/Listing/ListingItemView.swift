//
//  ListingItemView.swift
//  Airbnb
//
//  Created by Suraj Sharma on 06/02/24.
//

import SwiftUI

struct ListingItemView: View {
    let hotel: HotelList
    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ForEach(0 ... 2, id: \.self) { image in
                    if let url = URL(string: hotel.imageUrl ?? ""){
                        RemoteImageView(url: url)
                    }
                }
            }
            .frame(height: 320)
            .tabViewStyle(.page)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hotel.name ?? "Hotel")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text("Added 11 weeks ago")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.gray)
                    
                    Text("5 nights . 25 Feb - 1 Mar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.gray)
                    
                    HStack() {
                        Text("\(hotel.priceCurrency ?? "")\(hotel.price ?? 0)  total before taxes")
                            .font(.system(size: 20, weight: .bold))
                            .underline()
                    }
                }
                Spacer()
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                    Text("4.86")
                }
            } .font(.footnote)
        } .padding()
    }
}



struct ListingItemView_Previews: PreviewProvider {
    static var previews: some View {
        return ListingItemView(hotel: HotelList(id: 1, name: "", imageUrl: "", price: 1, priceCurrency: "", lat: 1.0, lng: 2.0))
    }
}
