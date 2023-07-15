//
//  SearchIssueView.swift
//  WeatherInfoApp
//
//  Created by dedeepya reddy salla on 29/06/23.
//

import SwiftUI

struct Device: Hashable, Identifiable {
   let id = UUID()
   var name: String = ""
}

struct SearchIssueView: View {
    @State private var searchText = ""
    var list: [Device] = [Device(name: "keyboard"), Device(name: "keyboard 2"), Device(name: "keyboard 3"), Device(name: "keyboard 4"), Device(name: "keyboard 4"), Device(name: "keyboard 5")]
    
    var searchList : [Device] {
        return list.filter({$0.name.contains(searchText)})
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "keyboard")
                    .frame(width: 400, height: 400)
                Text("dashboard view")
                
            }.background(.yellow)
            Spacer()
        }.searchable(text: $searchText) {
            ForEach(list) { device in
                Text(device.name)
            }
        }
    }
}

struct SearchIssueView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIssueView()
    }
}
