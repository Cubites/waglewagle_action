package kr.co.waglewagle.goods.won;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class UploadImage {
	
	//썸네일 이미지 구분하려고 받음 
	private String originFileName;
	//실제 저장된 이미지이름 (추후에 fullPath 하나로 퉁칠것)
	private String storeFileName;
	//실제 저장된 경로
	private String fullPath;
	
}
