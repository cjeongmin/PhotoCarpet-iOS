//
//  PhotoDisplayView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

extension AnyTransition {
    static var modal: AnyTransition {
        .asymmetric(
            insertion: .push(from: .bottom).combined(with: .opacity),
            removal: .push(from: .top).combined(with: .opacity)
        )
    }
    
    static var alert: AnyTransition {
        .asymmetric(
            insertion: .push(from: .top),
            removal: .opacity
        )
    }
}

struct PhotoDisplayView: View {
    @Environment(\.dismiss) var dismissAction
    @EnvironmentObject var exhibitionData: ExhibitionData
    @State private var selection = 0
    @State private var isActive = false
    @State private var showCompleteAlert = false
    @State private var showFailModal = false
    
    var body: some View {
        let photos = [$exhibitionData.photo1, $exhibitionData.photo2, $exhibitionData.photo3, $exhibitionData.photo4]
        
        return ZStack {
            TabView(selection: $selection) {
                ForEach(photos.indices, id: \.self) { index in
                    if let photo = photos[index].photo.wrappedValue {
                        PhotoPageView(photo: .constant(photo))
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                if isActive {
                    Spacer()
                    BuyModal(
                        price: photos[selection].price,
                        isActive: $isActive,
                        showCompleteAlert: $showCompleteAlert,
                        showFailModal: $showFailModal
                    )
                    .padding(.bottom, 50)
                    .transition(.modal)
                }
                
                if showCompleteAlert {
                    CompleteAlert()
                        .transition(.alert)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    showCompleteAlert.toggle()
                                }
                            }
                        }
                }
                
                if showFailModal {
                    FailModal(
                        showFailModal: $showFailModal
                    )
                    .transition(.alert)
                }
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    dismissAction.callAsFunction()
                }
            }
            
            if exhibitionData.userId != User.shared.userId {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeOut(duration: 0.5)) {
                            isActive.toggle()
                        }
                    } label: {
                        Image(systemName: "dollarsign.circle")
                            .scaleEffect(1.25)
                            .foregroundColor(.black)
                    }
                    Like(isLiked: photos[selection].isLiked) {
                        // TODO: 전시물 좋아요 API 호출
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PhotoPageView: View {
    @Binding var photo: Image
    
    var body: some View {
        photo
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PhotoDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        let data = ExhibitionData()
        data.setDummyData()
        return PhotoDisplayView()
            .environmentObject(data)
    }
}
