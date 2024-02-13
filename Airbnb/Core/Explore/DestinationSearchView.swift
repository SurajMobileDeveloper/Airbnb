//
//  DestinationSearchView.swift
//  Airbnb
//
//  Created by Suraj Sharma on 12/02/24.
//

import SwiftUI

enum SelectionSearch {
    case location
    case dates
    case guests
}

struct DestinationSearchView: View {
    @Binding var show: Bool
    @State private var destination = ""
    @State private var selection: SelectionSearch = .location
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var guestsCount = 0
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    withAnimation(.easeIn) {
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                Spacer()
                if !destination.isEmpty {
                    Button("Clear") {
                        destination = ""
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                }
            }
            .padding()
            //Mark: Location View
            VStack(alignment: .leading) {
                if selection == .location {
                    VStack(alignment: .leading) {
                        Text("Where to?")
                            .font(.title)
                            .fontWeight(.semibold)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.small)
                            TextField("Search destination", text: $destination)
                                .font(.subheadline)
                        }
                        .frame(height: 44)
                        .padding(.horizontal)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(Color(.systemGray4))
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .shadow(radius: 12)
                    
                } else {
                    CollapsedView(title: "Where", description: "Destination")
                }
            } .onTapGesture {
                withAnimation(.snappy) {
                    selection = .location
                }
            }
            
            //Mark: Date Selection View
            VStack {
                if selection == .dates {
                    VStack(alignment: .leading) {
                        Text("When's your trip?")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading) {
                            DatePicker("From", selection: $startDate, displayedComponents: .date)
                            Divider()
                            DatePicker("To", selection: $endDate, displayedComponents: .date)
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .shadow(radius: 12)
                    
                } else {
                    CollapsedView(title: "When", description: "Add dates")
                }
            }
            .onTapGesture {
                withAnimation(.snappy) {
                    selection = .dates
                }
            }
            
            //Mark: Add Guest View
            VStack {
                if selection == .guests {
                    VStack(alignment: .leading) {
                        Text("Who's coming?")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Stepper {
                            Text("\(guestsCount) guests")
                        } onIncrement: {
                            guestsCount += 1
                            print("INC")
                        } onDecrement: {
                            guard guestsCount > 0 else {return}
                            guestsCount -= 1
                            print("DEC")
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .shadow(radius: 12)
                } else {
                    CollapsedView(title: "Who", description: "Add guests")
                }
            }
            .onTapGesture {
                withAnimation(.snappy) {
                    selection = .guests
                }
            }
            Spacer()
        }
         .navigationBarHidden(true)
    }
}


struct CollapsedView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
                Text(description)
                    .fontWeight(.semibold)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
        .shadow(radius: 12)
    }
}

struct DestinationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationSearchView(show: .constant(false))
    }
}
