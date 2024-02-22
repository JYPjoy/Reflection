import SwiftUI

struct SquareGrid: View {
    let columns: Int
    let spacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let sideLength = (geometry.size.width - CGFloat(self.columns + 1) * self.spacing) / CGFloat(self.columns)
            
            ScrollView {
                VStack(spacing: self.spacing) {
                    ForEach(0..<self.columns) { _ in
                        HStack(spacing: self.spacing) {
                            ForEach(0..<self.columns) { _ in
                                Rectangle()
                                    .frame(width: sideLength, height: sideLength)
                                    .foregroundColor(.blue) // Just for demonstration
                            }
                        }
                    }
                }
                .padding(self.spacing)
            }
        }
    }
}
