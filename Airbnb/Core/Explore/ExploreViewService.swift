//
//  HotelViewService.swift
//  Airbnb
//
//  Created by Suraj Sharma on 03/02/24.
//

import Foundation

protocol ViewServiceDelegate {
    func getGetHotelList(url: String, completion: @escaping(Result<[HotelList], DemoError>) -> Void) async
}

class ExploreViewService: ViewServiceDelegate {
    func getGetHotelList(url: String, completion: @escaping(Result<[HotelList], DemoError>) -> Void) async {
        await NetworkManager().fetchData(urls: url, completion: completion)
    }
}
