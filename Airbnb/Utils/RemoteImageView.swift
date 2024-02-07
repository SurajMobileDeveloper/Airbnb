import SwiftUI

struct RemoteImageView: View {
    let url: URL
    let placeholderImage: Image
    @State private var isClicked = false
    @State private var isLoading = true
      
     
    init(url: URL, placeholderImage: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholderImage = placeholderImage
    }
    
    var body: some View {
        ZStack {
            // Use AsyncImage to asynchronously load the image from the URL
            AsyncImage(url: url) { phase in
                // Switch on the loading phaseisLoading
                
                switch phase {
                case .empty:
                    // Show the placeholder image when no image has been loaded yet
                    placeholderImage
                        .resizable()
                        .frame(width: 400, height: 420)
                        .aspectRatio(contentMode: .fit)
                case .success(let image):
                    // Show the loaded image
                  
                     image
                        .resizable()
                        .frame(width: 400, height: 420)
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    // Show the placeholder image if loading fails
                    placeholderImage
                        .resizable()
                        .frame(width: 400, height: 420)
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    // Show the placeholder image if loading fails
                    placeholderImage
                        .resizable()
                        .frame(width: 400, height: 420)
                        .aspectRatio(contentMode: .fit)
                }
            }
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
               
            // TODO: Needs to implement wishlist button with icon
//            // Wishlist icon button
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Add your action for wishlist button here
//                        self.isClicked.toggle()
//                    }) {
//                        Image(systemName: "heart.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 32, height: 32)
//                            .foregroundColor(isClicked ? .red : Color.black)
//                            .padding(8)
//                            .overlay(
//                                Circle()
//                                    .stroke(Color.white, lineWidth: 2)
//                            )
//                        
//                    }
//                }
//                .padding(16)
//                Spacer()
//                Spacer()
//            }
        }
        
        // TODO: Need to replace with dynamic image set timing
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Simulating loading time
                        isLoading = false
                    }
                }
    }
}


struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: URL(string: "https://example.com/image.jpg")!)
    }
}
