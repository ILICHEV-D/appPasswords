////
////  viewViewController.swift
////  savePassword
////
////  Created by Danil Ilichev on 02.03.2021.
////
//
//import UIKit
//import SwiftUI
//
//struct NameView: View {
//    let name: String
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Spacer()
//            Text("\(name)")
//                .font(.title)
//                .fontWeight(.semibold)
//                .foregroundColor(.white)
//        }
//        .padding()
//    }
//}
//
//class UserModel: Identifiable {    
//    var image: UIImage
//    var name: String
//    
//    init (image: UIImage, name: String) {
//        self.image = image
//        self.name = name
//    }
//}
//    
//
//struct AvatarView: View {
//    let image: UIImage
//    
//    var body: some View {
//        Image(uiImage: image)
//            .resizable()
//            .overlay(
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]),
//                                         startPoint: .center, endPoint: .bottom))
//                    .clipped()
//        )
//            .cornerRadius(12.0)
//    }
//}
//
//struct UserView: View {
//    let userModel: UserModel
//    
//    var body: some View {
//        ZStack(alignment: .leading) {
//            AvatarView(image: userModel.image)
//            NameView(name: userModel.name)
//        }
//        .shadow(radius: 12.0)
//        .cornerRadius(12.0)
//    }
//}
//
//struct ViewFactory {
//    static func button(_ name: String, renderingMode: Image.TemplateRenderingMode = .original) -> some View {
//        Button(action: {}) {
//            Image(name)
//                .renderingMode(renderingMode)
//        }
//    }
//}
//
//struct WelcomeNavigationView: View {
//    var body: some View {
//        HStack {
//            ViewFactory.button("profile_icon")
//            Spacer()
//            ViewFactory.button("fire_icon")
//                .scaleEffect(2)
//            Spacer()
//            ViewFactory.button("chat_icon")
//        }
//    }
//}
//
//struct BottomBarView: View {
//    var body: some View {
//        HStack {
//            ViewFactory.button("back_icon", renderingMode: .template)
//                .foregroundColor(.orange)
//                .background(
//                    GeometryReader { geometry in
//                        Circle()
//                            .offset(x: 2.5)
//                            .foregroundColor(.white)
//                            .shadow(color: .gray, radius: 12)
//                            .frame(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
//                    }
//            )
//            Spacer()
//            ViewFactory.button("close_icon", renderingMode: .template)
//                .foregroundColor(.red)
//                .background(
//                    GeometryReader { geometry in
//                        Circle().foregroundColor(.white)
//                            .frame(width: geometry.size.width * 2, height: geometry.size.height * 2)
//                            .shadow(color: .gray, radius: 12)
//                    }
//            )
//            Spacer()
//            ViewFactory.button("approve_icon", renderingMode: .template)
//                .foregroundColor(.green)
//                .background(
//                    GeometryReader { geometry in
//                        Circle()
//                            .foregroundColor(.white)
//                            .shadow(color: .gray, radius: 12)
//                            .frame(width: geometry.size.width * 2, height: geometry.size.height * 2)
//                    }
//            )
//            Spacer()
//            ViewFactory.button("boost_icon", renderingMode: .template)
//                .foregroundColor(.purple)
//                .background(
//                    GeometryReader { geometry in
//                        Circle()
//                            .foregroundColor(.white)
//                            .shadow(color: .gray, radius: 12)
//                            .frame(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5)
//                    }
//            )
//        }
//        .padding([.leading, .trailing])
//    }
//}
//
//struct SwipeView: View {
//    @State private var offset: CGFloat = 0
//    @State private var index = 0
//
//    let users = [Common.user1, Common.user2, Common.user3]
//    let spacing: CGFloat = 10
//
//    var body: some View {
//        GeometryReader { geometry in
//            return ScrollView(.horizontal, showsIndicators: true) {
//                HStack(spacing: self.spacing) {
//                    ForEach(self.users) { user in
//                        UserView(userModel: user)
//                            .frame(width: geometry.size.width)
//                    }
//                }
//            }
//            .content.offset(x: self.offset)
//            .frame(width: geometry.size.width, alignment: .leading)
//            .gesture(
//                DragGesture()
//                    .onChanged({ value in
//                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
//                    })
//                    .onEnded({ value in
//                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.users.count - 1 {
//                            self.index += 1
//                        }
//                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
//                            self.index -= 1
//                        }
//                        withAnimation { self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index) }
//                    })
//            )
//        }
//    }
//}
//
//
//struct WelcomeView: View {
//    var body: some View {
//        VStack {
//            WelcomeNavigationView()
//                .padding(.bottom)
//            SwipeView()
//                .padding(.bottom)
//            BottomBarView()
//        }
//        .padding()
//    }
//}
