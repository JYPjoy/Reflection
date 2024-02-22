import SwiftUI

struct ButtonStyling_Previews {
  static var previews: some View {
    VStack(spacing: 32) {
      VStack(spacing: 16) {
        Text("Primary label")
          .blackLabel()
        
        Text("Secondary label")
          .whiteLabel()
        
        Text("Tertiary label")
          .grayLabel()
      }
      
      VStack(spacing: 16) {
        Button(action: {

        }, label: {
          Text("Primary button")
        })
        .blackButton()
        
        Button(action: {
    
        }, label: {
          Text("Secondary button")
        })
        .blackButton()
        
        Button(action: {
       
        }, label: {
          Text("Tertiary button")
        })
        .grayButton()
      }
    }
    .preferredColorScheme(.dark)
  }
}

