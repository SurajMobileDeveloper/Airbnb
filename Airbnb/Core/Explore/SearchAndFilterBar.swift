//
//  SearchAndFilterBar.swift
//  Airbnb
//
//  Created by Suraj Sharma on 07/02/24.
//

import SwiftUI

struct SearchAndFilterBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            VStack(alignment: .leading, spacing: 2) {
                Text("Where to?")
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Anywhere - Any Week - add guests")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.black)
            })
        }
          .padding(.horizontal)
          .padding(.vertical, 10)
          .overlay {
              Capsule()
                  .stroke(lineWidth: 0.5)
                  .foregroundStyle(Color(.systemGray4))
                  .shadow(color: .black.opacity(0.4), radius: 2)
          }
          .padding()
    }
}


struct SearchAndFilterBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchAndFilterBar()
    }
}
