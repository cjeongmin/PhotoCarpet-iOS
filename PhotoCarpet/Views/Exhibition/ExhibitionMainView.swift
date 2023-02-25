//
//  ExhibitionMainView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct ExhibitionMainView: View {
    @Environment(\.dismiss) var dismissAction
    @EnvironmentObject var exhibitionData: ExhibitionData
    @State private var showDetail: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                Group {
                    Text(exhibitionData.title)
                        .lineLimit(1...4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(0x000000, opacity: 0.5))
                        .cornerRadius(10)
                        .padding(.bottom)
                    
                    HStack(spacing: 10) {
                        NavigationLink {
                            PhotoDisplayView()
                        } label: {
                            Text("관람하기")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                                .background(Color(0xFEFEFE))
                                .cornerRadius(5)
                        }
                        
                        if exhibitionData.userId != User.shared.userId {
                            NavigationLink {
                                // TODO: 아티스트 정보 이동
                            } label: {
                                Text("아티스트 정보")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .bold))
                                    .padding()
                                    .background(Color(0xF2F2F2, opacity: 0.5))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], 30)
                
                
                Spacer()
                
                Button {
                    showDetail.toggle()
                } label: {
                    HStack(alignment: .lastTextBaseline) {
                        Image(systemName: "chevron.down")
                        Text("more")
                            .font(.system(size: 20))
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                }
                .sheet(isPresented: $showDetail) {
                    ExhibitionDetailView()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: {
            if let photo = exhibitionData.photo1.photo {
                photo
                    .resizable()
                    .renderingMode(.original)
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    NavigationUtil.popToRootView()
                    exhibitionData.clear()
                }
            }
            
            if exhibitionData.userId == User.shared.userId {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EnrollView(isEdit: .constant(true))
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                            .scaleEffect(1.5)
                            .padding(.trailing)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Like(isLiked: $exhibitionData.isLiked) {
                        // TODO: 전시회 좋아요 API 호출
                    }
                    .padding(.trailing)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ExhibitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionMainView()
            .environmentObject(ExhibitionData())
    }
}
