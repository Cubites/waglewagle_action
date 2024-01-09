var con;
var fileNo = 0;
var filesArr = new Array();
var maxFileCnt = 5;
var curImgCnt = 0;
$(function () {
  //숫자만 입력가능 및 콤마로 자동 변환 이벤트
  let inputDom = document.querySelector('#price');
  inputDom.addEventListener('input', function (e) {
    let val = e.target.value.replace(/[^0-9]/g, '');
    e.target.value = val.replace(/\d(?=(?:\d{3})+$)/g, '$&,');
  });
  ////////////////////////////////////////

  $('#registForm').submit(function (event) {
    validationFormData(event);
  });

  (function () {
    setDate();
  })();

  //rejectValue 출력용
  (function () {
    var p = $('#price').val();

    if (p !== '' && p !== null && p !== undefined) {
      changePrice();
    }
  })();

  $('#price').change(function () {
    appendPrefix();
  });
  $('#price').change(function () {
    changePrice();
  });

  //이미지 등록 사진 누르면, input type file 클릭되도록 함
  //var inputFile = $('input[type=file]');
  //전체 input[type=file]의미
  var inputFile = $('#inputFile');
  inputFile.hide();

  $('#selectImageBox').click(function () {
    inputFile.click();
  });

  inputFile.change(function () {
    //현재 추가된 파일 수
    let attFiles = $('.selectedImageBox').length - 1;
    //추가로 첨부 가능한 갯수
    let remainFileCnt = maxFileCnt - attFiles;
    //현재 선택된 첨부 파일 갯수
    let curFileCnt = inputFile[0].files.length;
    //파일길이 검사하고, 검증 성공시에만 addFile
    if (validationImageLength(curFileCnt, remainFileCnt)) {
      addFile(inputFile[0]); //[0]의미는 해당 돔객체중 젤 첫번째 (input[type=file]은 많을 수 있다!)
    }
  });
});

//onload 외 function 모음

//form데이터 검증로직
function validationFormData(event) {
  var files = $('#himage').val();
  var goods_title = $('#goods_title').val();
  var goods_category1 = $('#goodsCategory1').val();
  var goods_category2 = $('#goodsCategory2').val();
  var price = $('#price').val();
  var fulljibun = $('#fullJibun').val();
  var goods_date = $('goodsDate').val();

  if (files === '') {
    alert('상품 이미지는 최소 1개이상 등록해주세요');
    event.preventDefault();
    return;
  }

  if (goods_title === '') {
    alert('제목은 반드시 입력하셔야하는 값 입니다.');
    event.preventDefault();
    return;
  }

  if (goods_category1 === '' || goods_category2 === '') {
    alert('카테고리를 지정해주세요.');
    event.preventDefault();
    return;
  }

  if (price === '') {
    alert('가격을 정확하게 입력해주세요.');
    event.preventDefault();
    return;
  }

  if (price < 0) {
    alert('가격은 음수일 수 없습니다.');
    event.preventDefault();
    return;
  }

  //소수점 검사를 위해 출력
  if (!Number.isInteger(Number(price))) {
    alert('가격은 소수점을 포함할 수 없습니다.');
    event.preventDefault();
    return;
  }

  if (fulljibun === '') {
    alert('주소를 정확하게 기입해주세요.');
    event.preventDefault();
    return;
  }

  if (goods_date === '') {
    alert('경매일자를 정확하게 기입해주세요.');
    event.preventDefault();
    return;
  }
}

function validationImageLength(curFileCnt, remainFileCnt) {
  //첨부될 파일이 추가로 첨부가능한  파일보다 많다면 못하게 막음
  if (curFileCnt > remainFileCnt) {
    alert('첨부파일은 최대' + maxFileCnt + '개 까지만 첨부 가능해요');
    return false;
  }
  return true;
}
function addFile(obj) {
  for (const file of obj.files) {
    var reader = new FileReader();

    //파일이 onload시 콜백
    reader.onload = function (e) {
      //미리보기 담을 태그만들기
      makeTage(e);
      // let html = "<img id='file" + window.fileNo + "' class='selectedImageBox'/>";
      // $("#imageBox").append(html);
      // $("#file" + window.fileNo).attr("src", e.target.result);

      //전역변수사용하기 위해 window지정
      window.filesArr.push(file);
      window.fileNo++;

      //파일 업로드 수 만큼 (1/5) 같이 갯수 출력
      imageCntForText('plus');
      thImgSelect();
    };
    //읽을 파일 지정
    reader.readAsDataURL(file);
  }
}
function makeTage(e) {
  let html =
    "<div class='imageSets' id='imageSet" +
    window.fileNo +
    "'><img id='file" +
    window.fileNo +
    "' class='selectedImageBox'/>";
  html += '<span></span>';
  html +=
    "<img class='xbutton' src='/resources/images/goods/xbutton.PNG' onclick='deleteImage(" +
    window.fileNo +
    ");'/><div>";
  $('#imageBox').append(html);
  $('#file' + window.fileNo).attr('src', e.target.result);
}
function imageCntForText(flag) {
  //plus가 flag로 들어오면 갯수를 올리고 아니면 내림
  if ('plus' === flag) {
    window.curImgCnt++;
  } else {
    window.curImgCnt--;
  }
  let texts = '(' + window.curImgCnt + '/5)';
  $('#fileLengthText').text(texts);
}

function deleteImage(no) {
  $('#imageSet' + no).remove();
  filesArr[no].is_delete = true;
  imageCntForText();
  thImgSelect();
}

function thImgSelect() {
  //처음에 파일이 하나 올라갈때만 작동하면됨 그지
  //첫번째 이미지는 무조건 대표이미지

  let imageBox = $('.selectedImageBox');
  if (imageBox[1] != null) {
    imageBox[1].className += ' image_th';
    let span = imageBox[1].nextSibling;
    $(span).addClass('image_text');
    $(span).text('대표 이미지');
  }
}

function numberValidation(val) {
  return !isNaN(val);
}

function setDate() {
  let today = new Date();
  today.setDate(today.getDate() + 1);
  let mindate = today.toISOString().split('T')[0];
  $('#goodsDate').attr('min', mindate);
  $('#goodsDate').val(mindate);
}
function appendPrefix() {
  var priceTag = $('#price');
  var priceVal = priceTag.val();
  console.log(priceVal);
}
//함수화 세자리 마다 콤마
function changePrice() {
  var priceTag = $('#price');
  var priceVal = priceTag.val();

  var priceNoComma = priceVal.replace(/,/g, '').replace(/￦/, '').trim();
  if (numberValidation(priceNoComma)) {
    var priceNum = Number(priceNoComma);
    var priceComma = priceNum.toLocaleString('ko-KR', 4);
    priceTag.val('￦ ' + priceComma);
  } else {
    alert('숫자만 입력해 주세요');
  }
}
//주소조회 용
$(function () {
  $('#addrSearchButton').click(searchAddr);
});
function searchAddr() {
  new daum.Postcode({
    oncomplete: function (data) {
      var guso = data.sido + ' ' + data.sigungu + ' ';

      if (data.bname1 == '') {
        guso += data.bname;
      } else {
        guso += data.bname1;
      }

      dong = guso.substring(guso.lastIndexOf(' '));

      $('#fullJibun').val(guso);
      $('#addrDong').val(dong);
    },
  }).open();
}
