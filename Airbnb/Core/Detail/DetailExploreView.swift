//
//  DetailExploreView.swift
//  Airbnb
//
//  Created by Suraj Sharma on 08/02/24.
//

import SwiftUI

#//MARK: Needs to code optimize
struct DetailExploreView: View {
    let hotel: HotelList
    
    init(hotel: HotelList) {
        self.hotel = hotel
    }
    
    var body: some View {
        ScrollView {
            TabView {
                ForEach(0 ... 2, id: \.self) { image in
                    if let url = URL(string: hotel.imageUrl ?? "") {
                        RemoteImageView(url: url)
                    }
                }
            }
            .frame(height: 320)
            .tabViewStyle(.page)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}



struct DetailExploreView_Previews: PreviewProvider {
    static var previews: some View {
        return DetailExploreView(hotel: HotelList(id: 1, name: "", imageUrl: "", price: 0, priceCurrency: "", lat: 1.0, lng: 1.0))
    }
}
