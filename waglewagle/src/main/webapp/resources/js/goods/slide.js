let slidList = document.querySelector('#slideList');
let imgs = document.querySelectorAll('.imgs');
let imgLength = imgs.length;
let imgWidth = imgs[0].width;
let imgHight = imgs[0].height;
let currImg = 0;
//이미지와 이미지 슬라이드 감싸고 있는 박스
let imagewrap = document.querySelector('#imagewrap');
//초기 사이즈 조절
setImgSize();
//이미지가 1개면 움직일 필요 없으니, slide 사이드나 clone객체 생성로직 제외

// if (imgLength > 1) {
//   init();
// }

init();
function init() {
  addImages();
  addClickEvent();
}

function addImages() {
  //맨 뒤 그림부터 앞에 추가
  for (let i = imgLength - 1; i >= 0; i--) {
    var cloneImg = imgs[i].cloneNode(true);
    cloneImg.classList.add('clone');
    slidList.prepend(cloneImg);
  }
  //맨 앞 그림부터 뒤에 추가
  for (let i = 0; i < imgLength; i++) {
    var cloneImg = imgs[i].cloneNode(true);
    cloneImg.classList.add('clone');
    slidList.append(cloneImg);
  }
  //굳이 이렇게 10개를 두는 이유는 이래야 위치 잡기 편함
  updateSlideWidth();
  setInitPos();
}
//이미지 슬라이드 크기조정
function updateSlideWidth() {
  let newimgs = document.querySelectorAll('.imgs');
  let newLen = newimgs.length;
  slidList.style.width = newLen * imgWidth + 'px';
}
//초기 위치 지정
function setInitPos() {
  let initpos = -(imgLength * imgWidth);

  slidList.style.transform = 'translateX(' + initpos + 'px)';
  setTimeout(() => {
    slidList.classList.add('active');
  }, 100);
}
//버튼 클릭시 움직임
function moveSlide(num) {
  let left = -(num * imgWidth);
  slidList.style.left = left + 'px';
  currImg = num;

  if (currImg == imgLength || -currImg == imgLength) {
    setTimeout(() => {
      slidList.classList.remove('active');
      slidList.style.left = 0;
      currImg = 0;
    }, 500);
    setTimeout(() => {
      slidList.classList.add('active');
    }, 550);
  }
}

function setImgSize() {
  //모든 imgs불러옴
  let imgs = document.querySelectorAll('.imgs');

  const width = imagewrap.clientWidth;
  const height = imagewrap.clientHeight;
  //새로 저장된 사이즈 부여
  for (let img of imgs) {
    img.width = width;
    img.height = height;
  }

  return width;
}

//사이즈가 변화면 실행될 함수 정의
function abjustImgDoms() {
  //움직임 보이지 않도록 active제거 일단 제거
  slidList.classList.remove('active');
  //새롭게 부여된 박스 사이즈 계산
  imgWidth = setImgSize();
  //계산된 박스 사이즈로 slide사이즈 조절
  updateSlideWidth();
  //초기 위치 조절
  setInitPos();
  //만약 이미지를 넘긴 상태로 화면 크기를 조절했다면, 반영
  moveSlide(currImg);
}

//imagewrap의 사이지 변화 추적
const observer = new ResizeObserver((entries) => {
  for (let enrty of entries) {
    abjustImgDoms();
  }
});
observer.observe(imagewrap);
