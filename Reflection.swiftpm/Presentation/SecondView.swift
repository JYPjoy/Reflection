//
//  SwiftUIView.swift
//  
//
//  Created by Joy on 2/13/24.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \ColorChip.colorName, ascending: true)
    ], animation: .default)
    private var color: FetchedResults<ColorChip>

    var body: some View {
        ForEach(self.color, id:\.self.id) {color in
            Text(color.colorList[1])
            Text(color.colorList[0])
           
        }
      
    }
}

//#Preview {
//    SecondView(colorChip: colorChip)
//}
