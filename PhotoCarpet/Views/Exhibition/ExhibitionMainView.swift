//
//  ExhibitionMainView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct ExhibitionMainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var photo1: Image?
    @Binding var photo2: Image?
    @Binding var photo3: Image?
    @Binding var photo4: Image?
    
    @Binding var exhibitionTitle: String
    @Binding var exhibitionDetail: String
    @Binding var hashTags: [String]
    @Binding var date: Date
    
    @State var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Group {
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    Group {
                        Group {
                            Text(exhibitionTitle)
                                .lineLimit(1...4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 42, weight: .black))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(0x000000, opacity: 0.5))
                        .cornerRadius(10)
                        .padding()
                        
                        NavigationLink {
                            PhotoDisplayView(
                                photo1: $photo1,
                                photo2: $photo2,
                                photo3: $photo3,
                                photo4: $photo4
                            )
                        } label: {
                            Group {
                                Text("관람하기")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .frame(width: 100, height: 50)
                            .background(Color(0xFEFEFE))
                            .cornerRadius(5)
                            .padding()
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    
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
                        ExhibitionDetailView(
                            exhibitionTitle: $exhibitionTitle,
                            hashTags: $hashTags,
                            exhibitionDetail: $exhibitionDetail,
                            date: $date
                        )
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(content: {
                if let photo1 {
                    photo1
                        .resizable()
                        .renderingMode(.original)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ZStack {
                        BackButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        Circle()
                            .foregroundColor(Color(0xFFFFFF, opacity: 0.25))
                            .zIndex(-1)
                            .scaleEffect(1.25)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.black)
                            
                            Circle()
                                .foregroundColor(Color(0xFFFFFF, opacity: 0.25))
                                .zIndex(-1)
                                .scaleEffect(1.25)
                        }
                        .padding(.trailing)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ExhibitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionMainView(
            photo1: .constant(Image("example")),
            photo2: .constant(nil),
            photo3: .constant(nil),
            photo4: .constant(nil),
            exhibitionTitle: .constant("전시회 제목"),
            exhibitionDetail: .constant("전시회 설명"),
            hashTags: .constant([]),
            date: .constant(Date())
        )
    }
}
