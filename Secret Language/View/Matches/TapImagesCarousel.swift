//
//  TapImagesCarousel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct TapImagesCarousel: View {
    
    let images: [String]
    @Binding var x: CGFloat
    @State private var currentImageIndex: Int = 0
    
    var body: some View {
        
        ZStack {
            WebImage(url: URL(string: images[currentImageIndex]))
                .placeholder(content: {
                    ProgressView()
                })
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width - 24,
                       height: UIScreen.main.bounds.size.height * 0.7)
                .clipped()
                .cornerRadius(15)
                .padding(.vertical)
                .overlay( Color.black.opacity( x != 0 ? 0.4 : 0)
                            .frame(width: UIScreen.main.bounds.size.width - 24,
                                   height: UIScreen.main.bounds.size.height * 0.7)
                            .clipped()
                            .cornerRadius(15))
            
            GetTapLocation { point in
                
                if (UIScreen.main.bounds.size.width * 0.7...UIScreen.main.bounds.size.width * 0.9).contains(point.x) {
                    if currentImageIndex < images.count-1 {
                        
                        withAnimation {
                            currentImageIndex += 1
                        }
                    }
                } else if  (0...100).contains(point.x) {
                    if currentImageIndex > 0 {
                        withAnimation {
                            currentImageIndex -= 1
                        }
                    }
                }
            }
        }

    }
}

struct TapImagesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        TapImagesCarousel(images: ["https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png", "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg"], x: .constant(0))
    }
}

struct GetTapLocation:UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)
    
    func makeUIView(context: UIViewRepresentableContext<GetTapLocation>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }
    
    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }
    
    func makeCoordinator() -> GetTapLocation.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<GetTapLocation>) {
    }
    
}
