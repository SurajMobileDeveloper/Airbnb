//
//  ContentView.swift
//  Airbnb
//
//  Created by Suraj Sharma on 30/01/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = HotelListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchAndFilterBar()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        ForEach(viewModel.hotels, id: \.id) { hotel in
                            ListingItemView(hotel: hotel)
                                .frame(height: 440)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.horizontal, 0)
                }
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}



class HotelListViewModel: ObservableObject {
    @Published var  hotels: [HotelList] = []
    var serviceHandler : ViewServiceDelegate
    
    init(serviceHandler : ViewServiceDelegate = ExploreViewService()) {
        self.serviceHandler = serviceHandler
    }
    
    func fetchData() async {
        
        await serviceHandler.getGetHotelList(url: APIConstants.baseURL) { (result: Result<[HotelList], DemoError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.hotels = data
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    // self.isError = true
                    print("Error", error)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
