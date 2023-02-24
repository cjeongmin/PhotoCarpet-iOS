//
//  Alert.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/24.
//

import SwiftUI

struct CompleteAlert: View {
    var body: some View {
        Text("구매가 완료되었습니다!")
            .font(.system(size: 17, weight: .heavy))
            .padding(.all, 25)
            .background(.white)
            .cornerRadius(20)
    }
}

struct FailModal: View {
    @Binding var showFailModal: Bool
    
    var body: some View {
        VStack {
            Text("해당 작품을 구매하기 위한\n 포인트가 부족해요")
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .heavy))
                .padding(.bottom, 10)
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showFailModal.toggle()
                    }
                } label: {
                    Text("취소")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color(0xC9C9C9))
                        .cornerRadius(54)
                }
                
                Button {
                    // TODO: 충전 화면으로 이동
                } label: {
                    Text("충전하기")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.black)
                        .cornerRadius(54)
                }
                
            }
        }
        .padding(.all, 30)
        .background(.white)
        .cornerRadius(28)
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        CompleteAlert()
    }
}
