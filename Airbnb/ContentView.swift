//
//  ContentView.swift
//  Airbnb
//
//  Created by Suraj Sharma on 30/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HotelListViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            List(viewModel.hotels, id: \.id) { hotel in
                HotelListRow(hotel: hotel)
            }
            .navigationTitle("Hotel List")
            
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            } }
    }
}

class HotelListViewModel: ObservableObject {
    @Published var  hotels: [HotelList] = []
    var serviceHandler : ViewServiceDelegate
    
    init(serviceHandler : ViewServiceDelegate = HotelViewService()) {
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


struct HotelListRow: View {
    let hotel: HotelList
    
    var body: some View {
        HStack {
            // Image view
            if let url = URL(string: hotel.imageUrl ?? ""),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Adjust the size as needed
            } else {
                // Placeholder image or alternative content
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            
            // Text and other views
            VStack(alignment: .leading) {
                Text(hotel.name ?? "")
                    .font(.headline)
                    .font(.subheadline)
            }
            
            Spacer() // Add any other views you need on the right
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
