import SwiftUI

struct MemoryView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        Text("컬러칩")
    }
}
