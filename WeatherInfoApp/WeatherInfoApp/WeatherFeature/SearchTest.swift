//
//  SearchTest.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 17/06/23.
//

import SwiftUI

//struct SearchTest: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

//----1
//struct SearchingExample: View {
//    @State private var searchText = ""
//
//    var body: some View {
//        NavigationStack {
//            SearchedView()
//                .searchable(text: $searchText)
//        }
//    }
//}
//
//
//struct SearchedView: View {
//    @Environment(\.isSearching) private var isSearching
//
//    var body: some View {
//        Text(isSearching ? "Searching" : "Not searching")
//    }
//}

//2a--
struct SearchingExample: View {
    @State var query:String = "a"
    @Environment(\.dismissSearch) private var dismissSearch
    
    struct test: Identifiable, Hashable {
        var id = UUID()
        var name = ""
    }
//    let items = ["a", "b", "c"]
//    var filteredItems: [String] { items.filter { $0 == query.lowercased() } }
    
    let items = [test(name: "a"), test(name: "b"), test(name: "c")]
    var filteredItems: [test] { items.filter { $0.name == query.lowercased() } }

    @State var isSearch = false
    var body: some View {
        NavigationView {
            if isSearch {
                Text("Select an item")
            } else {
                List {
                    ForEach(filteredItems) { item in
                        Button {
                            print("onTapGesture")
                            isSearch = true
                            dismissSearch()
                        } label: {
                            Text(item.name)
                            Label("Add Item", systemImage: "plus")
                        }
            
                    }
                }
                .searchable(text: $query, prompt: Text("search"))
            }
            
//                .onChange(of: citySearchText) { newQuery in
//                                print("text---", citySearchText)
                    //filterRecipes()
//                .searchable(text: $citySearchText)
//                .searchSuggestions {
//                    Text("opop")
//                        .onTapGesture {
//                            print("gest")
//                            dismiss()
//                                               //dismissSearch()
//                        }
//                    Text("klo").searchCompletion("pear")
//                    Text("🍌").searchCompletion("banana")
//                }
//                .onChange(of: citySearchText) { newQuery in
//                                print("text---", citySearchText)
//                            }
            
//            List {
//                ForEach(filteredItems) { item in
//                    Button {
//                        print("onTapGesture")
//                        dismissSearch()
//                    } label: {
//                        Text(item.name)
//                        Label("Add Item", systemImage: "plus")
//                    }
//
//                    Text(item.name).onTapGesture {
//                        print("button---")
//                        dismissSearch()
//                    }
//                }
//            }
//            .searchable(text: $query, prompt: Text("search"))
//            .simultaneousGesture(DragGesture().onChanged({ _ in
//                dismissSearch()
//            }))
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        print("button")
//                    } label: {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
            Text("Select an item")
        }
    }
}
//2---
struct SearchingExample1: View {
    @State private var searchText = ""


    var body: some View {
        NavigationStack {
            SearchedView(searchText: searchText)
                .searchable(text: $searchText)
        }
    }
}


private struct SearchedView: View {
    var searchText: String


    let items = ["a", "b", "c"]
    var filteredItems: [String] { items.filter { $0 == searchText.lowercased() } }


    @State private var isPresented = false
    @Environment(\.dismissSearch) private var dismissSearch


    var body: some View {
        if let item = filteredItems.first {
            Button("Details about \(item)") {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    DetailView(item: item, dismissSearch: dismissSearch)
                }
            }
        }
    }
}

private struct DetailView: View {
    var item: String
    var dismissSearch: DismissSearchAction


    @Environment(\.dismiss) private var dismiss


    var body: some View {
        Text("Information about \(item).")
            .toolbar {
                Button("Add") {
                    // Store the item here...


                    dismiss()
                    dismissSearch()
                }
            }
    }
}

//struct SearchTest: View {
//    @State private var isPresented = true
//    @State private var text = ""
//
//    var body: some View {
//        NavigationStack {
//            SheetContent()
//                .searchable(text: $text, isPresented: $isPresented)
//        }
//    }
//}

//struct SearchTest_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchTest()
//    }
//}
