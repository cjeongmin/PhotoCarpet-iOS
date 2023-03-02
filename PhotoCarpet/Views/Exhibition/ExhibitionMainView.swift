//
//  ExhibitionMainView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import Alamofire
import SwiftUI

final class PhotoDisplayViewModel: ObservableObject {
    @Published var photos: [Response.Photo] = []
    var photoData: [Image] = []

    func requestPhotos(exhibitionId: Int) {
        AF.request(Request.baseURL + "/photo/\(exhibitionId)").responseDecodable(of: [Response.Photo].self) { response in
            guard let result = response.value else { return }
            self.photos = result

            var alt: [Image] = []
            for photo in self.photos {
                let semaphore = DispatchSemaphore(value: 0)

                if let url = URL(string: photo.artUrl) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = try? Data(contentsOf: url) {
                            if let uiImage = UIImage(data: data) {
                                alt.append(Image(uiImage: uiImage))
                            }
                        }
                        semaphore.signal()
                    }

                    task.resume()
                }

                semaphore.wait()
            }
            self.photoData = alt
        }
    }
}

struct ExhibitionMainView: View {
    @Environment(\.dismiss) var dismissAction
    @State private var showDetail: Bool = false
    @State private var isLiked: Bool = false

    @ObservedObject var photoDisplayViewModel = PhotoDisplayViewModel()

    var exhibition: Response.Exhibition

    init(_ exhibition: Response.Exhibition) {
        self.exhibition = exhibition
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                }

                Group {
                    Text(exhibition.title!)
                        .lineLimit(1 ... 4)
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
                            PhotoDisplayView(exhibition: exhibition)
                                .environmentObject(photoDisplayViewModel)
                        } label: {
                            Text("관람하기")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                                .background(Color(0xFEFEFE))
                                .cornerRadius(5)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            photoDisplayViewModel.requestPhotos(exhibitionId: exhibition.exhibitId)
                        })

                        if exhibition.user.nickName != User.shared.nickName {
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
                    ExhibitionDetailView(isLiked: $isLiked, exhibition: exhibition)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: {
            AsyncImage(url: URL(string: exhibition.thumbUrl!), content: { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .renderingMode(.original)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if phase.error != nil {
                    Image(systemName: "wifi.slash")
                } else {
                    ProgressView()
                        .scaleEffect(3)
                }
            })
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    NavigationUtil.popToRootView()
                }
            }

            if exhibition.user.nickName == User.shared.nickName {
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
                    Like(isLiked: $isLiked) {
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
//        ExhibitionMainView()
        EmptyView()
    }
}
