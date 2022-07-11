    //
    //  UpdateListView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/06.
    //

import SwiftUI

struct UpdateListView: View {
    /// data can be updated in realtime
    @ObservedObject var store = UpdateStore()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetailView(update: update)) {
                        UpdateRow(update: update)
                            .padding(.vertical, 8)
                    }
                }
                ///drag to delete function
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                ///we recieve multiple values to manipulate data
                ///Drag to move and update the order and re-order
                .onMove{ (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            
            .listStyle(.plain)
            .navigationTitle("Updates")
            .navigationBarItems(leading: Button(action: {
                addUpdate(store: store)
            }, label: {
                Text("Add Update")
            }), trailing: EditButton())
        }
    }
        
}

struct UpdateListView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateListView()
    }
}


