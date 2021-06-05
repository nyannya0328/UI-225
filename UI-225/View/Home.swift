//
//  Home.swift
//  UI-225
//
//  Created by にゃんにゃん丸 on 2021/06/05.
//

import SwiftUI
import AudioToolbox

    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }


struct Home: View {
    @State var offset : CGFloat = 0
    var body: some View {
        VStack{
            
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(Circle())
            
            
            Spacer(minLength: 0)
            
            
            Text("Weight")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Text("\(getWeight())")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color("c1"))
                .padding(.top,5)
            
            
            let pickCount = 6
            
            CustomScrollView(pickCount: pickCount, offset: $offset) {
                
                
                HStack(spacing:0){
                    
                    
                    ForEach(1...pickCount,id:\.self){main in
                        
                        VStack{
                            
                            Rectangle()
                                .fill(Color.gray)
                             
                               
                                .frame(width: 1, height: 30)
                            
                            
                            Text("\(30+(main * 10))")
                                .font(.caption)
                                
                        }
                        .frame(width: 20)
                        
                        
                        ForEach(1...4,id:\.self){sub in
                            
                            Rectangle()
                                .fill(Color.gray)
                              
                                .frame(width: 1, height: 15)
                                .frame(width: 20)
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    VStack{
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 30)
                            .frame(width: 20)
                        
                        Text("\(100)")
                            .font(.caption2)
                    }
                    
                    
                    
                }
                
            }
            .frame(height: 50)
            .overlay(
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: 1, height: 50)
                .offset(x:0.8,y: -30)
            
            )
            .padding()
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("NEXT")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.primary)
                    .clipShape(Capsule())
                    
            })
            .padding(.top,20)
            
            
               
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
        Circle()
            .fill(Color.purple)
            .scaleEffect(1.5)
            
            .offset(y: -getRect().height / 2.2)
            
        )
    }
    
    func getWeight() -> String{
        
        let start = 40
        
        let progress = offset / 20
        
         return ("\(start + (Int(progress) * 2))")
        
           
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CustomScrollView<Content : View> : UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return CustomScrollView.Coordinator(parent: self)
    }
    
    var content : Content
    @Binding var offset : CGFloat
    var pickCount : Int
    
    init(pickCount : Int, offset : Binding<CGFloat>,@ViewBuilder content : @escaping ()->Content) {
        self.content = content()
        self.pickCount = pickCount
        self._offset = offset
    }
    
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let view = UIScrollView()
        
        let swiftUiView = UIHostingController(rootView: content).view!
        
        let width = CGFloat((pickCount * 5) * 20) + (getRect().width - 30)
        
        
        swiftUiView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        view.contentSize = swiftUiView.frame.size
        view.addSubview(swiftUiView)
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = context.coordinator
        
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : CustomScrollView
        
        init(parent : CustomScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            parent.offset = scrollView.contentOffset.x
            
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            
            let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(1157)
            
            
            
            
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if !decelerate{
                
                let offset = scrollView.contentOffset.x
                
                let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
                
                scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                AudioServicesPlayAlertSound(1157)
                
                
                
            }
            
        }
        
        
        
        
    }
}
