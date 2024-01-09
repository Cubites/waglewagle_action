function getLowerCategories() {
  let ca1 = document.querySelector('#goodsCategory1').value;
  console.log(ca1);

  var category2 = $('#goodsCategory2');

  // category2의 모든 옵션을 제거
  category2.empty();

  // category1_value에 따라서 동적으로 옵션 추가
  switch (ca1) {
    case '1':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append('<option value="2">여성의류</option>');
      category2.append('<option value="3">남성의류</option>');
      category2.append('<option value="4">코트</option>');
      category2.append('<option value="5">어린이</option>');
      category2.append('<option value="6">신발</option>');
      category2.append('<option value="7">가방 / 지갑</option>');
      category2.append('<option value="8">시계</option>');
      category2.append('<option value="9">주얼리</option>');
      category2.append('<option value="10">미용</option>');
      break;
    case '11':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append('<option value="12">노트북</option>');
      category2.append('<option value="13">데스크탑</option>');
      category2.append('<option value="14">웨어러블</option>');
      category2.append('<option value="15">휴대폰</option>');
      category2.append('<option value="16">태블릿</option>');
      category2.append('<option value="17">컴퓨터 주변기기</option>');
      category2.append('<option value="18">카메라</option>');
      category2.append('<option value="19">콘솔 게임기</option>');
      break;
    case '20':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append('<option value="21">소모품</option>');
      category2.append('<option value="22">옷</option>');
      category2.append('<option value="23">장난감</option>');
      break;
    case '24':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append(
        '<option value="24" style="display: none;">도서/음악</option>'
      );
      break;
    case '25':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append(
        '<option value="25" style="display: none;">기타</option>'
      );
      break;
    case '26':
      category2.append('<option value="">2차 카테고리</option>');
      category2.append(
        '<option value="26" style="display: none;">생활/가전</option>'
      );
      break;
    default:
      category2.append('<option value="">2차 카테고리</option>');
      break;
  }
}

function submits2() {
  var price = $('#price').val();

  //숫자 보기좋게 변환해둔 것 다시 고쳐야함!
  price = price.replaceAll('￦', '');
  price = price.replaceAll(',', '');
  price = price.trim();
  console.log(price);
  $('#price').val(price);

  //input 태그 file에 파일을 추가하면 내부적으로 files라는 속성에 저장함
  //근데 이 속성 읽기만 가능하고 변경은 불가능함 뭔가 변경하고 싶으면
  //dataTransfer객체를 사용해야함 MDN 무슨 표준
  const dataTransfer = new DataTransfer();

  for (var i = 0; i < window.filesArr.length; i++) {
    if (!window.filesArr[i].is_delete) {
      //dataTransfer객체에 items에 add
      dataTransfer.items.add(filesArr[i]);
    }
  }
  //himage id를 가진 돔객체에 files를 dataTransfer.files로 교체
  $('#himage')[0].files = dataTransfer.files;

  //대표이미지 이름 저장하기 위해 -> 파일 id는 file0으로 파일 fileNum로 저장되어있음
  var image_id = $('.image_th').attr('id'); //id값 가져오기
  var fileNumber;
  var image_th;
  if (image_id !== undefined) {
    //id값이 존재한다면,
    fileNumber = image_id.substring(image_id.indexOf('e') + 1); //fileNum가져오기
    image_th = filesArr[fileNumber].name; //filesArr에서 fileNumber에 해당하는 file객체에 이름 가져오기
  } else {
    fileNumber = null;
    image_th = '';
  }

  $('#goods_th_img').val(image_th);
  //1차 카테고리가 24,25일 경우 2차 카테고리 null이어도 됨
  var ca1 = $('#goodsCategory1').val();

  if (ca1 === '24' || ca1 === '25' || ca1 === '26') {
    $('#goodsCategory2').val(ca1);
  }

  //기존 Date에 현재 시간 시간 추가
  // var timeStampString = getTimeStamp();
  // $("#goods_exph").val(timeStampString);

  var form = $('#registForm');
  form.submit();
}

//타임스탬프로 만드는 함수 -> 요구 사항 변경으로 폐기
// function getTimeStamp() {
//   let goodsDateString = $('#goodsDate');

//   let now = new Date();

//   //시간 추출
//   var hours = ('0' + now.getHours()).slice(-2);
//   var min = ('0' + now.getMinutes()).slice(-2);
//   var seconds = ('0' + now.getSeconds()).slice(-2);
//   var timeString = hours + ':' + min + ':' + seconds;
//   //
//   var TimeStampString = goodsDateString.val() + ' ' + timeString;

//   return TimeStampString;
// }
