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
        NSSortDescriptor(keyPath: \ColorChipEntity.colorName, ascending: true)
    ], animation: .default)
    private var color: FetchedResults<ColorChipEntity>
//    
//    @FetchRequest(sortDescriptors: [
//        NSSortDescriptor(keyPath: \MemoryEntity.title, ascending: true)
//    ], animation: .default)
//    private var memori: FetchedResults<MemoryEntity>
//    
    var body: some View {
        ForEach(self.color, id:\.self.id) {color in
            Text(color.colorList[0])

        }
//        ForEach(self.memori, id: \.self.id) { mem in
//            Text(mem.title)
//            
//        }
      
    }
}

//#Preview {
//    SecondView(colorChip: colorChip)
//}
